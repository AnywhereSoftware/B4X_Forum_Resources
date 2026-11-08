#include "B4RDefines.h"
namespace B4R {
	bool B4RCAN::Initialize(SubByteArray DataAvailableSub, int PinR, int PinT, long CanSpeed) {
		this->DataAvailableSub = DataAvailableSub;
		if (PinT == 0) {
			CAN.setPins(PinR,NULL);
		}
		else {
			CAN.setPins(PinR,PinT);
		}
		bool res = CAN.begin(CanSpeed);
		FunctionUnion fu;
		fu.PollerFunction = looper;
		pollers.add(fu, this);
		return res;
	}

	void B4RCAN::SendMessage(int ID, ArrayByte * Msg) {
		int i = 2047;
		if (ID < 2047) {
			i=ID;
		}
		CAN.beginPacket(i);
		CAN.write((Byte*)Msg->data, Msg->length);
		CAN.endPacket();
	}

	void B4RCAN::SendMessageExtended(long ID, ArrayByte * Msg) {
		long l = 536870911;
		if (ID < 536870911) {
			l=ID;
		}
		CAN.beginExtendedPacket(l);
		CAN.write((Byte*)Msg->data, Msg->length);
		CAN.endPacket();
	}

	long B4RCAN::MessageId(){
		return CAN.packetId();
	}

	bool B4RCAN::isExtendedId() {
		return CAN.packetExtended();
	}

	void B4RCAN::looper(void* b) {
		B4RCAN* me = (B4RCAN*)b;
		if (CAN.parsePacket()) {
			if (!CAN.packetRtr()) {
				int count = 0;
				byte dat[8];
				while (CAN.available()) {
					byte b = (byte)CAN.read();
					dat[count] = b;
					count+=1;
				}
				if (count>0) {
					const UInt cp = B4R::StackMemory::cp;
					ArrayByte* arr = CreateStackMemoryObject(ArrayByte);
					arr->data = dat;
					arr->length = count;
					me->DataAvailableSub (arr);
					B4R::StackMemory::cp = cp;
				}
			}
		}
	}

}