#include "B4RDefines.h"
namespace B4R {
	B4RString* ByteConverter::HexFromBytes(ArrayByte* Bytes) {
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		for (UInt i = 0;i < Bytes->length;i++) {
			Byte b = ByteFromArray(Bytes, i);
			if (b < 16)
				StackMemory::buffer[StackMemory::cp++] = '0';
			pm.print(b, 16);
		}
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}
	ArrayByte* ByteConverter::HexToBytes(B4RString* Hex) {
		ArrayByte* arr = CreateStackMemoryObject(ArrayByte);
		arr->data = (StackMemory::buffer + StackMemory::cp);
		int length = Hex->getLength();
		char byteChars[] = {0, 0, 0};
		for (int i = 0;i < length; i+= 2) {
			byteChars[0] = Hex->data[i];
			byteChars[1] = Hex->data[i + 1];
			StackMemory::buffer[StackMemory::cp++] = strtol(byteChars, NULL, 16);
		}
		arr->length = length / 2;
		return arr;
		
	}
	Array* ByteConverter::convertBytesToArray(Array* Bytes, size_t s) {
		Array* arr = CreateStackMemoryObject(Array);
		arr->length = Bytes->length / s;
		arr->data = Bytes->data;
		return arr;
	}
	Array* ByteConverter::convertArrayToBytes(Array* arr, size_t s) {
		Array* Bytes = CreateStackMemoryObject(Array);
		Bytes->length = arr->length * s;
		Bytes->data = arr->data;
		return Bytes;
	}
	ArrayByte* ByteConverter::ObjectToBytes(Object* Object, UInt ObjectSize) {
		Array* Bytes = CreateStackMemoryObject(Array);
		Bytes->length = ObjectSize;
		Bytes->data = Object->data.PointerField;
		return Bytes;
	}
	Object* ByteConverter::ObjectFromBytes(ArrayByte* Bytes) {
		Object* obj = CreateStackMemoryObject(Object);
		obj->wrapPointer(Bytes->data);
		return obj;
	}
	void ByteConverter::ObjectCopy(Object* Src, Object* Dest, UInt ObjectSize) {
		memmove(Dest->data.PointerField, Src->data.PointerField, ObjectSize);
	}
	void ByteConverter::ObjectSet(Object* Src, Object* Dest) {
		memmove(Dest, Src, sizeof(Object));
		Dest->type = Src->type;
	}
	
	Int ByteConverter::ArrayCompare(ArrayByte* Arr1, ArrayByte* Arr2) {
		int i = memcmp(Arr1->data, Arr2->data, Common_Min(Arr1->length, Arr2->length));
		if (i == 0)
			return Arr1->length - Arr2->length;
		return i;
	}
	void ByteConverter::ArrayCopy (ArrayByte* Src, ArrayByte* Dest) {
		memcpy((Byte*)Dest->data, (Byte*)Src->data, Src->length);
		Dest->length = Src->length;
	}
	void ByteConverter::ArrayCopy2 (ArrayByte* Src, UInt SrcOffset, ArrayByte* Dest, UInt DestOffset, UInt Count) {
		memmove((Byte*)Dest->data + DestOffset, (Byte*)Src->data + SrcOffset, Count);
	}
	ArrayByte* ByteConverter::SubString(ArrayByte* Bytes, UInt BeginIndex) {
		return SubString2(Bytes, BeginIndex, Bytes->length);
	}
	ArrayByte* ByteConverter::SubString2(ArrayByte* Bytes, UInt BeginIndex, UInt EndIndex) {
		Array* arr = CreateStackMemoryObject(Array);
		arr->length = EndIndex - BeginIndex;
		arr->data = (Byte*)Bytes->data + BeginIndex;
		return arr;
	}
	Int ByteConverter::IndexOf(ArrayByte* Bytes, ArrayByte* SearchFor) {
		return IndexOf2(Bytes, SearchFor, 0);
	}
	Int ByteConverter::IndexOf2(ArrayByte* Bytes, ArrayByte* SearchFor, UInt StartIndex) {
		if (SearchFor->length > Bytes->length)
			return -1;
		for (UInt a = StartIndex;a < Bytes->length + 1 - SearchFor->length ;a++) {
			bool found = true;
			for (UInt b = 0;b < SearchFor->length;b++) {
				if (ByteFromArray(Bytes, a + b) != ByteFromArray(SearchFor, b)) {
					found = false;
					break;
				}
			}
			if (found)
				return a;
		}
		return -1;
	}
	Int ByteConverter::LastIndexOf(ArrayByte* Bytes, ArrayByte* SearchFor) {
		return LastIndexOf2(Bytes, SearchFor, Bytes->length);
	}
	Int ByteConverter::LastIndexOf2(ArrayByte* Bytes, ArrayByte* SearchFor, UInt StartIndex) {
		if (SearchFor->length > Bytes->length)
			return -1;
		for (Int a = Common_Min(StartIndex, Bytes->length - SearchFor->length);a >= 0 ;a--) {
			bool found = true;
			for (UInt b = 0;b < SearchFor->length;b++) {
				if (ByteFromArray(Bytes, a + b) != ByteFromArray(SearchFor, b)) {
					found = false;
					break;
				}
			}
			if (found)
				return a;
		}
		return -1;
	}
	SplitIterator* ByteConverter::Split(ArrayByte* Src, ArrayByte* Separator) {
		ArrayByte* arr = CreateStackMemoryObject(ArrayByte);
		SplitIterator* si = CreateStackMemoryObject(SplitIterator);
		si->arr = arr;
		si->o.wrapPointer(si->arr);
		si->src = Src;
		si->index = 0;
		si->bc = this;
		si->searchFor = Separator;
		return si;
	}
	bool SplitIterator::MoveNext() {
		if (index == -1) {
			if ((unsigned int)(void*)(StackMemory::buffer + StackMemory::cp) - sizeof(SplitIterator) == (unsigned int)(void*)this) {
				StackMemory::cp -= sizeof(SplitIterator);
			}
			return false;
		}
		Int i = bc->IndexOf2(src, searchFor, index);
		arr->data = (Byte*)src->data + index;
		if (i == -1) {
			arr->length = src->length - index;
			index = -1;
		}
		else {
			arr->length = i - index;
			index = i + searchFor->length;
		}
		return true;
	}
	Object* SplitIterator::Get() {
		return &o;
	}
	bool ByteConverter::StartsWith(ArrayByte* Src, ArrayByte* Prefix) {
		if (Prefix->length > Src->length)
			return false;
		return SubString2(Src, 0, Prefix->length)->equals(Prefix);
	}
	bool ByteConverter::EndsWith(ArrayByte* Src, ArrayByte* Suffix) {
		if (Suffix->length > Src->length)
			return false;
		return SubString2(Src, Src->length - Suffix->length, Src->length)->equals(Suffix);
	}
	static bool isWhitespace(Byte b) {
		return b == 32 || (b >=9 && b <= 13);
	}

	ArrayByte* ByteConverter::Trim(ArrayByte* Src) {
		Array* Bytes = CreateStackMemoryObject(Array);
		Bytes->data = Src->data;
		Bytes->length = Src->length;
		while (Bytes->length > 0 && isWhitespace(ByteFromArray(Bytes, 0))) {
			Bytes->length--;
			Bytes->data = (Byte*)Bytes->data + 1;
		}
		while (Bytes->length > 0 && isWhitespace(ByteFromArray(Bytes, Bytes->length - 1))) {
			Bytes->length--;
		}
		return Bytes;
	}
	
	ArrayByte* ByteConverter::StringToBytes(B4RString* Str) {
		return Str->GetBytes();
	}
	B4RString* ByteConverter::StringFromBytes(ArrayByte* Bytes) {
		B4RString* str = CreateStackMemoryObject(B4RString);
		str->data = (const char*)StackMemory::buffer + StackMemory::cp;
		memcpy((void*)str->data, Bytes->data, Bytes->length);
		StackMemory::cp += Bytes->length;
		StackMemory::buffer[StackMemory::cp++] = 0;
		return str;
	}
	
}