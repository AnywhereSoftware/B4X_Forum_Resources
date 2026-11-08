#include "B4RDefines.h"
namespace B4R {
	#define T_UINT_1 1
	#define T_UINT_2 2
	#define T_UINT_4 3
	#define T_NINT_1 4
	#define T_NINT_2 5
	#define T_INT_4 6
	#define T_FLOAT_4 7
	#define T_STRING 8
	#define T_LONG_BYTES 9
	#define T_SHORT_BYTES 0x40
	#define T_SMALL_UINT 0x80
	#define MARK_BEGIN 0x7E
	#define MARK_END 0x7F
	
	ArrayByte* B4RSerializator::ConvertArrayToBytes (ArrayObject* Objects) {
		ArrayByte* arr = CreateStackMemoryObject(ArrayByte);
		arr->data = (StackMemory::buffer + StackMemory::cp);
		arr->length = 0xFFFF;
		arr = ConvertArrayToBytes2(Objects, arr);
		StackMemory::cp += arr->length;
		return arr;
		
	}
	ArrayByte* B4RSerializator::ConvertArrayToBytes2 (ArrayObject* Objects, ArrayByte* Buffer) {
		RandomAccessFile raf;
		raf.Initialize(Buffer, true);
		raf.WriteByte (MARK_BEGIN, raf.CurrentPosition);
		raf.WriteByte (Objects->length, raf.CurrentPosition);
		
		for (UInt i = 0;i < Objects->length;i++) {
			Object* o = ((Object**)Objects->data)[i];
			
			switch (o->type) {
				
				case BR_LONG: {
					Long lng = o->data.LongField;
					if ((lng & (T_SMALL_UINT - 1)) == lng) {
						raf.WriteByte(T_SMALL_UINT | lng, raf.CurrentPosition);
					} else if ((lng & 0xFF) == lng) {
						raf.WriteByte(T_UINT_1, raf.CurrentPosition);
						raf.WriteByte(lng, raf.CurrentPosition);
					} else if ((lng & 0xFFFF) == lng) {
						raf.WriteByte(T_UINT_2, raf.CurrentPosition);
						raf.WriteUInt16(lng, raf.CurrentPosition);
					} else if ((lng & 0xFFFFFF00) == 0xFFFFFF00) {
						raf.WriteByte(T_NINT_1, raf.CurrentPosition);
						raf.WriteByte (lng, raf.CurrentPosition);
					} else if ((lng & 0xFFFF0000) == 0xFFFF0000) {
						raf.WriteByte(T_NINT_2, raf.CurrentPosition);
						raf.WriteInt16 (lng, raf.CurrentPosition);
					} else {
						raf.WriteByte(T_INT_4, raf.CurrentPosition);
						raf.WriteLong32(lng, raf.CurrentPosition);
					}
					break;
				}
				case BR_ULONG: 
					raf.WriteByte(T_UINT_4, raf.CurrentPosition);
					raf.WriteULong32(o->data.ULongField, raf.CurrentPosition);
					break;
				case BR_DOUBLE:
					raf.WriteByte(T_FLOAT_4, raf.CurrentPosition);
					raf.WriteDouble32(o->data.DoubleField, raf.CurrentPosition);
					break;
				case BR_PTR: {
					ArrayByte* arrayOfBytes = (ArrayByte*)o->data.PointerField;
					Byte len = arrayOfBytes->length;
					if (len < T_SHORT_BYTES) {
						raf.WriteByte (T_SHORT_BYTES | len, raf.CurrentPosition);
					} else {
						raf.WriteByte (T_LONG_BYTES, raf.CurrentPosition);
						raf.WriteUInt16 (len, raf.CurrentPosition);
					}
					memcpy((Byte*)Buffer->data + raf.CurrentPosition, (Byte*)arrayOfBytes->data, len);
					raf.CurrentPosition += len;
					break;
				}
				case BR_CONST_CHAR: {
					raf.WriteByte(T_STRING, raf.CurrentPosition);
					const char* str = (const char*)o->data.PointerField;
					strcpy((char*)Buffer->data + raf.CurrentPosition, str);
					raf.CurrentPosition += strlen(str) + 1;
					break;
				}
			
			}
		}
		raf.WriteByte(MARK_END, raf.CurrentPosition);
		#ifdef CHECK_ARRAY_BOUNDS
			Buffer->getData(raf.CurrentPosition - 1);
		#endif
		Array* arr = (Buffer->length == 0xFFFF || Buffer->length == raf.CurrentPosition) ? Buffer : CreateStackMemoryObject(Array);
		arr->length = raf.CurrentPosition;
		arr->data = (Byte*)Buffer->data;
		return arr;
	}

	ArrayObject* B4RSerializator::ConvertBytesToArray (ArrayByte* Bytes, ArrayObject* Result) {
		RandomAccessFile raf;
		raf.Initialize(Bytes, true);
		Byte length;
		if (Bytes->length > 0 &&
			ByteFromArray(Bytes, 0) == MARK_BEGIN 
			&& ByteFromArray(Bytes, Bytes->length - 1) == MARK_END) {
				raf.CurrentPosition++;
				length = raf.ReadByte(raf.CurrentPosition);
				for (Byte i = 0;i < length;i++) {
					Byte recordType = raf.ReadByte(raf.CurrentPosition);
					Object* o = ((Object**)Result->data)[i];
					switch (recordType) {
						case T_UINT_1: 
							o->wrapNumber(raf.ReadByte(raf.CurrentPosition));
							break;
						case T_UINT_2:
							o->wrapNumber((Long)raf.ReadUInt16(raf.CurrentPosition));
							break;
						case T_UINT_4:
							o->wrapNumber(raf.ReadULong32(raf.CurrentPosition));
							break;
						case T_INT_4:
							o->wrapNumber(raf.ReadLong32(raf.CurrentPosition));
							break;
						case T_NINT_1:
							o->wrapNumber((Long)(0xFFFFFF00 | raf.ReadByte(raf.CurrentPosition)));
							break;
						case T_NINT_2:
							o->wrapNumber((Long)(0xFFFF0000 | raf.ReadInt16(raf.CurrentPosition)));
							break;
						case T_FLOAT_4:
							o->wrapNumber(raf.ReadDouble32(raf.CurrentPosition));
							break;
						case T_STRING: {
							const char* str = (const char*)Bytes->data + raf.CurrentPosition;
							raf.CurrentPosition += strlen(str) + 1;
							o->wrapPointer(str);
							break;
						}
						default:
							if ((recordType & T_SMALL_UINT) == T_SMALL_UINT)
								o->wrapNumber((Long)(recordType & ~T_SMALL_UINT));
							else if (recordType == T_LONG_BYTES || (recordType & T_SHORT_BYTES) == T_SHORT_BYTES) {
								UInt len;
								if (recordType == T_LONG_BYTES)
									len = raf.ReadUInt16(raf.CurrentPosition);
								else
									len = recordType &~T_SHORT_BYTES;
								o->wrapPointer(raf.ReadBytes2(len, raf.CurrentPosition));
							}
							break;
					}
				}
				#ifdef CHECK_ARRAY_BOUNDS
				Result->getData(length - 1);
				#endif
		} else {
			length = 0;
		}
		
		Array* arr = Result->length == length ? Result : CreateStackMemoryObject(Array);
		arr->length = length;
		arr->data = Result->data;
		return arr;
	}
}