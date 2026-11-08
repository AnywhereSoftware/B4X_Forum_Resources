#pragma once
#include "B4RDefines.h"

//~version: 1.91
namespace B4R {
	class SplitIterator;
	/**
	*Provides methods that allow converting between different types of arrays to arrays of bytes.
	*The conversion methods do not modify the memory, instead they provide a different representation of the same memory block.
	*ArrayCopy and ObjectCopy allow copying of arrays and objects. These methods can be used to copy local objects to global variables.
	*The endianess used is the board's native endianess (little endian for Arduino).
	*Note that strings are casted to arrays of bytes automatically.
	*/
	//~shortname: ByteConverter
	class ByteConverter {
		public:
		/**
		*Splits the array of bytes based on the Separator array and returns an iterator.
		*Example:
		*<code>
		 *Dim bc As ByteConverter
		 *For Each s() As Byte In bc.Split("abc,def,ghf", ",")
		 *	Log(s)
		 *Next</code>
		*/
		SplitIterator* Split(ArrayByte* Src, ArrayByte* Separator);
		/**
		*Create a new array that shares the same memory as the given array.
		*Src - Source array.
		*BeginIndex - The index of the first element in the new array.
		*Example:<code>
		*Dim bc As ByteConverter
		*Log(bc.SubString("012345", 2)) '2345</code>
		*/
		ArrayByte* SubString(ArrayByte* Src, UInt BeginIndex);
		/**
		*Create a new array that shares the same memory as the given array.
		*Src - Source array.
		*BeginIndex - The index of the first element in the new array.
		*EndIndex - The index of the last element. The last element will not be included.
		*Example:<code>
		*Dim bc As ByteConverter
		*Log(bc.SubString2("012345", 2, 4)) '23</code>
		*/
		ArrayByte* SubString2(ArrayByte* Src, UInt BeginIndex, UInt EndIndex);
		/**
		 * Returns the index of the first occurrence of SearchFor array in the Src array.
		 *Starts searching from the given Index.
		 *Returns -1 if SearchFor was not found.
		 */
		Int IndexOf(ArrayByte* Src, ArrayByte* SearchFor);
		/**
		 * Returns the index of the first occurrence of SearchFor array in the Src array.
		 *Returns -1 if SearchFor was not found.
		 */
		Int IndexOf2(ArrayByte* Src, ArrayByte* SearchFor, UInt StartIndex);
		/**
		 * Returns the index of the first occurrence of SearchFor array in the Src array.
		 *The search starts at the end of the array and advances to the beginning.
		 */
		Int LastIndexOf(ArrayByte* Src, ArrayByte* SearchFor);
		/**
		 * Returns the index of the first occurrence of SearchFor array in the Src array.
		 *The search starts at the given index and advances to the beginning.
		 */
		Int LastIndexOf2(ArrayByte* Src, ArrayByte* SearchFor, UInt StartIndex);
		/**
		*Creates a new array that shares the same memory as the given array, without the leading and trailing whitespace characters.
		*/
		ArrayByte* Trim(ArrayByte* Src);
		//Returns true if the Src array starts with the Prefix array.
		bool StartsWith(ArrayByte* Src, ArrayByte* Prefix);
		//Returns true if the Src array ends with the Suffix array.
		bool EndsWith(ArrayByte* Src, ArrayByte* Suffix);
		
		/**
		*Compares the two arrays.
		*Returns 0 if both arrays are equal.
		*Returns a value lower than 0 if Arr2 value is larger (the first byte that is different is larger).
		*Returns a value larger than 0 if Arr1 value is larger.
		*/
		Int ArrayCompare(ArrayByte* Arr1, ArrayByte* Arr2);
		//Converts the bytes array to a hex string.
		B4RString* HexFromBytes(ArrayByte* Bytes);
		//Converts the hex string to a bytes array.
		ArrayByte* HexToBytes(B4RString* Hex);
		/**
		*Converts the object (non-primitive) to an array of bytes. Note that the array and the object share the same memory.
		*/
		ArrayByte* ObjectToBytes(Object* Object, UInt ObjectSize);
		/**
		*Converts the array of bytes to an object. Note that the array and the object share the same memory.
		*/
		Object* ObjectFromBytes(ArrayByte* Bytes);
		/**
		*Copies the source object to the destination object. This method makes a shallow copy of the source object's memory.
		*The destination object must be a variable of the same type.
		*You can use this method to copy local objects to global variables.
		*If the Dest variable is an Object variable then you should use ObjectSet instead.
		*Src - The source object.
		*Dest - Destination variable.
		*ObjectSize - The object size as computed with SizeOf.
		*Example:<code>
		*bc.ObjectCopy(LocalType, GlobalType, SizeOf(LocalType))</code>
		*/
		void ObjectCopy(Object* Src, Object* Dest, UInt ObjectSize);
		/**
		*Sets the value of an existing Object instance. This method can be used to set the values of an
		*array of objects. When setting a global object you should make sure that the referenced value is not a 
		*pointer to a stack value as it will not be valid after the sub completes.
		*/
		void ObjectSet(Object* Src, Object* Dest);
		/**
		*Copies the Src array to the Dest array. The destination array length will be set
		*to the length of the source array. Bounds are not checked.
		*This method is useful for copying local arrays to global arrays.
		*/
		void ArrayCopy(ArrayByte* Src, ArrayByte* Dest);
		/**
		*Copies the bytes from the source array to the destination array.
		*Make sure that the destination array is large enough. Bounds are not checked.
		*Src - Source array.
		*SrcOffset - Index of the first byte to be copied.
		*Dest - Destination array.
		*DestOffset - The first byte will be copied to this index.
		*Count - Number of bytes to copy.
		*/
		void ArrayCopy2 (ArrayByte* Src, UInt SrcOffset, ArrayByte* Dest, UInt DestOffset, UInt Count);
		//Converts the string to an array of bytes. This is the same as calling Str.GetBytes.
		//Note that the array and the string share the same memory.
		ArrayByte* StringToBytes(B4RString* Str);
		//Creates a new string based on the bytes array.
		//Note that you can print bytes arrays directly so in most cases this method is not required.
		//Unlike StringToBytes this method does allocate a new memory block for the returned string.
		B4RString* StringFromBytes(ArrayByte* Src);
		//~hide
		static Array* convertBytesToArray(Array* arr, size_t s);
		//~hide
		static Array* convertArrayToBytes(Array* arr, size_t s);
		//Converts the bytes array to an array of 16 bit ints. Note that both arrays share the same memory.
		#define /*ArrayInt* IntsFromBytes(ArrayByte* Bytes);*/ ByteConverter_IntsFromBytes(Bytes) B4R::ByteConverter::convertBytesToArray(Bytes, sizeof(Int))
		//Converts the 16 bit ints array to an array of bytes. Note that both arrays share the same memory. 
		#define /*ArrayByte* IntsToBytes(ArrayInt* Ints);*/ ByteConverter_IntsToBytes(Bytes) B4R::ByteConverter::convertArrayToBytes(Bytes, sizeof(Int))
		
		//Converts the bytes array to an array of 16 bit unsigned ints. Note that both arrays share the same memory.
		#define /*ArrayUInt* UIntsFromBytes(ArrayByte* Bytes);*/ ByteConverter_UIntsFromBytes(Bytes) B4R::ByteConverter::convertBytesToArray(Bytes, sizeof(UInt))
		//Converts the 16 bit unsigned ints array to an array of bytes. Note that both arrays share the same memory. 
		#define /*ArrayByte* UIntsToBytes(ArrayUInt* UInts);*/ ByteConverter_UIntsToBytes(Bytes) B4R::ByteConverter::convertArrayToBytes(Bytes, sizeof(UInt))
		
		//Converts the bytes array to an array of 32 bit unsigned longs. Note that both arrays share the same memory.
		#define /*ArrayULong* ULongsFromBytes(ArrayByte* Bytes);*/ ByteConverter_ULongsFromBytes(Bytes) B4R::ByteConverter::convertBytesToArray(Bytes, sizeof(ULong))
		//Converts the 32 bit unsigned longs array to an array of bytes. Note that both arrays share the same memory. 
		#define /*ArrayByte* ULongsToBytes(ArrayULong* ArrayULong);*/ ByteConverter_ULongsToBytes(Bytes) B4R::ByteConverter::convertArrayToBytes(Bytes, sizeof(ULong))
		
		//Converts the bytes array to an array of 32 bit signed longs. Note that both arrays share the same memory.
		#define /*ArrayLong* LongsFromBytes(ArrayByte* Bytes);*/ ByteConverter_LongsFromBytes(Bytes) B4R::ByteConverter::convertBytesToArray(Bytes, sizeof(Long))
		//Converts the 32 bit signed longs array to an array of bytes. Note that both arrays share the same memory. 
		#define /*ArrayByte* LongsToBytes(ArrayLong* UInts);*/ ByteConverter_LongsToBytes(Bytes) B4R::ByteConverter::convertArrayToBytes(Bytes, sizeof(Long))
		
		//Converts the bytes array to an array of 32 bit floating points. Note that both arrays share the same memory.
		#define /*ArrayDouble* DoublesFromBytes(ArrayByte* Bytes);*/ ByteConverter_DoublesFromBytes(Bytes) B4R::ByteConverter::convertBytesToArray(Bytes, sizeof(Double))
		//Converts the 32 bit floating points array to an array of bytes. Note that both arrays share the same memory. 
		#define /*ArrayByte* DoublesToBytes(ArrayDouble* UInts);*/ ByteConverter_DoublesToBytes(Bytes) B4R::ByteConverter::convertArrayToBytes(Bytes, sizeof(Double))
		
	};
	//~hide
	class SplitIterator : public Iterator{
		public:
			Object o;
			ArrayByte* arr;
			ArrayByte* src;
			ArrayByte* searchFor;
			Int index;
			ByteConverter* bc;
			virtual bool MoveNext() override;
			virtual Object* Get() override;
						
	};
	//~shortname: AsyncStreams
	//~Event: NewData (Buffer() As Byte)
	//~Event: Error
	class AsyncStreams {
		private:
			PollerNode pnode;
			SubVoidArray NewDataSub;
			SubVoidVoid ErrorSub;
			B4RStream* stream;
			void Close();
			static void checkForData(void* b);
			bool prefixMode;
			bool bigEndian;
		public:
			//The internal buffer limit. The NewData event will be raised when the buffer reaches this size or if no more data is available.
			//The data is stored in the stack buffer. Make sure that #StackBufferSize is large enough.
			UInt MaxBufferSize = 100;
			//Number of milliseconds to wait for new data (when there is at least one byte available).
			UInt WaitForMoreDataDelay = 5;
			//Initializes the object and set the subs that will handle the events.
			void Initialize (B4RStream* Stream, SubVoidArray NewDataSub, SubVoidVoid ErrorSub);
			//Initializes the object in prefix mode. Both sides of the connection must adhere to the "prefix" protocol.
			//It is recommended to set #StackBufferSize to 600 or more.
			//MaxBufferSize will be set to 500 bytes and WaitForMoreDataDelay will be set to 300ms.
			//BigEndian - Sets the length prefix endianess. 
			
			void InitializePrefix (B4RStream* Stream, bool BigEndian, SubVoidArray NewDataSub, SubVoidVoid ErrorSub);
			//Writes the array to the stream.
			AsyncStreams* Write (ArrayByte* Data);
			//Writes the array to the stream. 
			AsyncStreams* Write2 (ArrayByte* Data, UInt Start, UInt Length);
	};
	//~shortname: RandomAccessFile
	class RandomAccessFile {
		private:
			bool shouldSwap;
			Byte* data;
			void WriteNumber(Byte* number, Byte length, UInt Position);
			void ReadNumber(Byte* number, Byte length, UInt Position);
		public:
			//Gets or sets the current position.
			UInt CurrentPosition;
			//Initializes the object with the backend array.
			//Buffer - Backend array.
			//LittleEndian - Sets the endianess that is used when reading or writing numbers.
			void Initialize(ArrayByte* Buffer, bool LittleEndian);
			//Writes a single byte.
			void WriteByte(Byte Value, UInt Position);
			//Reads a single byte.
			Byte ReadByte(UInt Position);
			//Writes a 2 byte Int (equivalent to B4X Short).
			void WriteInt16(Int Value, UInt Position);
			//Reads a 2 byte Int (equivalent to B4X Short).
			Int ReadInt16(UInt Position);
			//Write a 2 byte unsigned Int.
			void WriteUInt16(UInt Value, UInt Position);
			//Reads a 2 byte unsigned Int.
			UInt ReadUInt16(UInt Position);
			//Writes a 4 bytes Long (equivalent to B4X Int).
			void WriteLong32(Long Value, UInt Position);
			//Reads a 4 bytes Long (equivalent to B4X Int).
			Long ReadLong32(UInt Position);
			//Writes a 4 bytes unsigned Long.
			void WriteULong32(ULong Value, UInt Position);
			//Reads a 4 bytes unsigned long.
			ULong ReadULong32(UInt Position);
			//Writes a 4 bytes Double (equivalent to B4X Float).
			void WriteDouble32(Double Value, UInt Position);
			//Reads a 4 bytes Double (equivalent to B4X Float).
			Double ReadDouble32(UInt Position);
			//Copies bytes from the backend array to the Dest array. Boundaries are not checked.
			//Dest - Destination array.
			//StartOffset - Index of the first byte in the destination array.
			//Length - Number of bytes to copy.
			//Position - Position of the first byte.
			void ReadBytes(ArrayByte* Dest, int StartOffset, int Length, UInt Position);
			//Similar to ReadBytes, however data is not copied.
			//Returns an array that shares the same memory as the backend array.
			//Length - The returned array length.
			//Position - Position of the first byte in the backend array.
			ArrayByte* ReadBytes2(int Length, UInt Position);
			//Copies bytes to the backend array. Boundaries are not checked.
			//Src - Source array.
			//StartOffset - Offset of the first byte in the source array.
			//Length - Number of bytes to copy.
			//Position - Position of the first byte in the backend array.
			void WriteBytes(ArrayByte* Src, int StartOffset, int Length, UInt Position);
	};
	//~shortname: B4RSerializator
	//Converts arrays of objects to bytes and vice versa.
	//The data can be shared with other B4X tools using the B4RSerializator class (not to confuse with B4XSerializator which is not compatible with B4R).
	class B4RSerializator {
		public:
			//Converts an array of objects to an array of bytes.
			//Supported types: numbers, strings and array of bytes. Booleans will be converted to 0 or 1.
			//The returned array is created on the stack buffer.
			ArrayByte* ConvertArrayToBytes (ArrayObject* Objects);
			//Similar to ConvertArrayToBytes. The returned array will share the memory with the Buffer array instead of using the stack buffer.
			ArrayByte* ConvertArrayToBytes2 (ArrayObject* Objects, ArrayByte* Buffer);
			//Converts a previously serialized array of bytes to an array of objects.
			//Returns an empty array if the input is invalid. Make sure to check the returned array size.
			//The returned array will share the memory with ObjectsBuffer array. ObjectsBuffer length must be equal or larger than the number of items.
			ArrayObject* ConvertBytesToArray (ArrayByte* Bytes, ArrayObject* ObjectsBuffer);
	};
}