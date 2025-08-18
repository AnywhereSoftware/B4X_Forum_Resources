#include "B4RDefines.h"

namespace B4R {
	void B4RStream::Flush() {
		wrappedStream->flush();
	}
	UInt B4RStream::WriteBytes (ArrayByte* Buffer, UInt StartOffset, UInt Length) {
		UInt total = 0;
		while (Length > 0) {
			Int i = wrappedStream->write(((Byte*)Buffer->data + StartOffset + total), Length);
			if (i <= 0) {
				return total;
			}
			Length -= i;
			total += i;
		}
		return total;
	}
	Int B4RStream::BytesAvailable() {
		return wrappedStream->available();
	}
	UInt B4RStream::ReadBytes(ArrayByte* Buffer, UInt StartOffset, UInt MaxCount) {
		UInt total = 0;
		while (MaxCount > 0) {
			Int i = wrappedStream->readBytes(((Byte*)Buffer->data + StartOffset + total), MaxCount);
			if (i <= 0) {
				return total;
			}
			MaxCount -= i;
			total += i;
		}
		return total;
	}
	//static
	void B4RStream::Print(::Print* stream, Object* Message) {
		if (Message == NULL || (Message->type == BR_PTR && 
			Message->data.PointerField == NULL)) {
			return;
		}
		switch (Message->type) {
			case BR_LONG:
				stream->print(Message->data.LongField);
				break;
			case BR_ULONG:
				stream->print(Message->data.ULongField);
				break;
			case BR_DOUBLE:
				if (Message->data.DoubleField == floor(Message->data.DoubleField))
					stream->print(Message->data.DoubleField, 0);
				else
					stream->print(Message->data.DoubleField, 4);
				break;
			case BR_CONST_CHAR:
				stream->print((const char*)Message->data.PointerField);
				break;
			case BR_F_STRING:
				stream->print((const __FlashStringHelper*)Message->data.PointerField);
				break;
			case BR_PTR: //array of bytes
				ArrayByte* buffer = (ArrayByte*)Message->data.PointerField;
				stream->write((uint8_t*)buffer->data, buffer->length);
				break;
		}
	}
}