#include "B4RDefines.h"
namespace B4R {
	
	
	//static
	void AsyncStreams::checkForData(void* b) {
		AsyncStreams* me = (AsyncStreams*) b;
		int av = me->stream->BytesAvailable();
		bool dataNotAvailable = (av == 0 || (me->prefixMode && av < 4));
		if (me->stream->wrappedClient != NULL) {
			// ::Serial.print("is connected: ");
			// ::Serial.println(me->stream->wrappedClient->connected());
			// ::Serial.println(av);
			if (me->stream->wrappedClient->connected() == false) {
				delay(10);
				av = me->stream->BytesAvailable();
				dataNotAvailable = (av == 0 || (me->prefixMode && av < 4));
				// ::Serial.print("not connected. DataNotAvailable: ");
				// ::Serial.println(dataNotAvailable);
				if (dataNotAvailable) {
					me->Close();
					if (me->ErrorSub != NULL) {
						sender->wrapPointer(me);
						me->ErrorSub();
					}
					return;
				}
				
			}
			#ifdef ESP_H
			me->stream->wrappedClient->flush();
			#endif
		}
		if (dataNotAvailable)
			return;
		const UInt cp = B4R::StackMemory::cp;
		ArrayByte* arr = CreateStackMemoryObject(ArrayByte);
		arr->data = StackMemory::buffer + StackMemory::cp;
		UInt index = 0;
		UInt maxSize = me->MaxBufferSize;
		if (me->prefixMode) {
			me->stream->ReadBytes(arr, 0, 4);
			UInt messageSize, zero;
			((Byte*)&messageSize)[0] = ByteFromArray(arr, me->bigEndian ? 3 : 0);
			((Byte*)&messageSize)[1] = ByteFromArray(arr, me->bigEndian ? 2 : 1);
			((Byte*)&zero)[0] = ByteFromArray(arr, me->bigEndian ? 0 : 2);
			((Byte*)&zero)[1] = ByteFromArray(arr, me->bigEndian ? 1 : 3);
			if (messageSize <= me->MaxBufferSize && zero == 0)
				maxSize = messageSize;
			else {
				while (me->stream->BytesAvailable()) {
					me->stream->ReadBytes(arr, 0, Common_Min(av, 100));
				}
				maxSize = 0;
			}
		}
		while (index < maxSize) {
			if (av) {
				int count = me->stream->ReadBytes(arr, index, Common_Min(av, maxSize - index));
				index += count;
			}
			else {
				break;
			}
			av = me->stream->BytesAvailable();
			if (!av) {
				if (me->WaitForMoreDataDelay)
					delay(me->WaitForMoreDataDelay);
				av = me->stream->BytesAvailable();
			}
		}
		if (index > 0 && (!me->prefixMode || index == maxSize)) {
			arr->length = index;
			sender->wrapPointer(b);
			B4R::StackMemory::cp += index;
			me->NewDataSub(arr);
		}
		B4R::StackMemory::cp = cp;
	}
	void AsyncStreams::Initialize (B4RStream* Stream, SubVoidArray NewDataSub, SubVoidVoid ErrorSub) {
		this->NewDataSub = NewDataSub;
		this->ErrorSub = ErrorSub;
		FunctionUnion fu;
		fu.PollerFunction = checkForData;
		pnode.functionUnion = fu;
		pnode.tag = this;
		if (pnode.next == NULL) {
			pollers.add(&pnode);
		}
		this->stream = Stream;
		prefixMode = false;
	}
	void AsyncStreams::InitializePrefix (B4RStream* Stream, bool BigEndian, SubVoidArray NewDataSub, SubVoidVoid ErrorSub) {
		Initialize(Stream, NewDataSub, ErrorSub);
		prefixMode = true;
		bigEndian = BigEndian;
		MaxBufferSize = 500;
		WaitForMoreDataDelay = 300;
	}
	AsyncStreams* AsyncStreams::Write (ArrayByte* Data) {
		return Write2(Data, 0, Data->length);
	}
	AsyncStreams* AsyncStreams::Write2 (ArrayByte* Data, UInt Start, UInt Length) {
		if (prefixMode) {
			Byte* b = (Byte*)&Length;
			stream->wrappedStream->write(bigEndian ? 0 : b[0]);
			stream->wrappedStream->write(bigEndian ? 0 : b[1]);
			stream->wrappedStream->write(bigEndian ? b[1] : 0);
			stream->wrappedStream->write(bigEndian ? b[0] : 0);
		}
		UInt i = stream->WriteBytes (Data, Start, Length);
		if (i < Length) {
			sender->wrapPointer(this);
			Close();
			if (this->ErrorSub != NULL)
				this->ErrorSub();
			
		}
		return this;
	}
	
	void AsyncStreams::Close() {
		if (pnode.next != NULL)
			pollers.remove(&pnode);
	}
}