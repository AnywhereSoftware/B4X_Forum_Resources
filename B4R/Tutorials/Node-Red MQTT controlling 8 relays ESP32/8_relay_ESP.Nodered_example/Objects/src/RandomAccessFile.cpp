#include "B4RDefines.h"
namespace B4R {
	void RandomAccessFile::Initialize(ArrayByte* Buffer, bool LittleEndian) {
		this->CurrentPosition = 0;
		this->data = (Byte*)Buffer->data;
		this->shouldSwap = !LittleEndian;
	}
	void RandomAccessFile::WriteNumber(Byte* number, Byte length, UInt Position) {
		for (int i = 0;i < length;i++) {
			data[Position + i] = number[shouldSwap ? length - 1 - i : i];
		}
		CurrentPosition = Position + length;
		
	}
	void RandomAccessFile::ReadNumber(Byte* number, Byte length, UInt Position) {
		for (int i = 0;i < length;i++) {
			number[i] = data[Position + (shouldSwap ? length - 1 - i : i)];
		}
		CurrentPosition = Position + length;
	}
	void RandomAccessFile::WriteByte(Byte Value, UInt Position) {
		data[Position] = Value;
		CurrentPosition = Position + 1;
	}
	Byte RandomAccessFile::ReadByte(UInt Position) {
		Byte b = data[Position];
		CurrentPosition = Position + 1;
		return b;
	}
	
	
	void RandomAccessFile::WriteInt16(Int Value, UInt Position) {
		WriteNumber((Byte*)&Value, 2, Position);
	}
	Int RandomAccessFile::ReadInt16(UInt Position) {
		Int i;
		ReadNumber((Byte*)&i, 2, Position);
		return i;
	}
	void RandomAccessFile::WriteUInt16(UInt Value, UInt Position) {
		WriteNumber((Byte*)&Value, 2, Position);
	}
	UInt RandomAccessFile::ReadUInt16(UInt Position) {
		UInt i;
		ReadNumber((Byte*)&i, 2, Position);
		return i;
	}
	void RandomAccessFile::WriteLong32(Long Value, UInt Position) {
		WriteNumber((Byte*)&Value, 4, Position);
	}
	Long RandomAccessFile::ReadLong32(UInt Position) {
		Long i;
		ReadNumber((Byte*)&i, 4, Position);
		return i;
	}
	void RandomAccessFile::WriteULong32(ULong Value, UInt Position) {
		WriteNumber((Byte*)&Value, 4, Position);
	}
	ULong RandomAccessFile::ReadULong32(UInt Position) {
		ULong i;
		ReadNumber((Byte*)&i, 4, Position);
		return i;
	}
	void RandomAccessFile::WriteDouble32(Double Value, UInt Position) {
		WriteNumber((Byte*)&Value, 4, Position);
	}
	Double RandomAccessFile::ReadDouble32(UInt Position) {
		Double i;
		ReadNumber((Byte*)&i, 4, Position);
		return i;
	}
	void RandomAccessFile::ReadBytes(ArrayByte* Dest, int StartOffset, int Length, UInt Position) {
		memcpy((Byte*)Dest->data + StartOffset, data + Position, Length);
		CurrentPosition = Position + Length;
	}
	ArrayByte* RandomAccessFile::ReadBytes2(int Length, UInt Position) {
		Array* arr = CreateStackMemoryObject(Array);
		arr->length = Length;
		arr->data = data + Position;
		CurrentPosition = Position + Length;
		return arr;
	}
	void RandomAccessFile::WriteBytes(ArrayByte* Src, int StartOffset, int Length, UInt Position) {
		memcpy(data + Position, (Byte*)Src->data + StartOffset, Length);
		CurrentPosition = Position + Length;
	}
	
	
}