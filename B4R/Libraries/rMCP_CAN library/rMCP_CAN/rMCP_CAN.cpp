
#include "B4RDefines.h"
namespace B4R {
	bool B4RMCP_CAN::Initialize(SubByteArrayInt DataSub, int SPI_CS_PIN, byte CanSpeed) {
		this->DataSub = DataSub;
		canbus = new (backend) MCP_CAN();
		SPI.begin();
		canbus->init_CS(SPI_CS_PIN);
		bool res = canbus->begin(CanSpeed) == CAN_OK;
		FunctionUnion fu;
		fu.PollerFunction = looper;
		pnode.functionUnion = fu;
		pnode.tag = this;
		if (pnode.next == NULL)
			pollers.add(&pnode);
		return res;
	}
	bool B4RMCP_CAN::SendMessage(int ID, ArrayByte* Msg, byte Frame) {
		uint8_t * b = (uint8_t *)Msg->data;
		return (canbus->sendMsgBuf(ID, Frame, Common_Min(8, Msg->length), b)) == CAN_OK;
 	}

	void B4RMCP_CAN::looper(void* b) {
		B4RMCP_CAN* me = (B4RMCP_CAN*)b;
		if (me->canbus->checkReceive() == CAN_MSGAVAIL) {
			const UInt cp = B4R::StackMemory::cp;
			byte len = CAN_MAX_CHAR_IN_MESSAGE;
			unsigned char buf[CAN_MAX_CHAR_IN_MESSAGE];
			me->canbus->readMsgBuf(&len, buf);
			ArrayByte* arr = CreateStackMemoryObject(ArrayByte);
			arr->data = (StackMemory::buffer + StackMemory::cp);
			for (int i = 0;i < len; i++) {
				StackMemory::buffer[StackMemory::cp++] = buf[i];
			}
			arr->length=len;
			me->DataSub(arr, me->canbus->getCanId(), me->canbus->isExtendedFrame());
			B4R::StackMemory::cp = cp;
		}
	}
}