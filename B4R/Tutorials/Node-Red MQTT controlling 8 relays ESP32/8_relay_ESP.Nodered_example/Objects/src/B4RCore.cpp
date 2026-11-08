#include "B4RDefines.h"

namespace B4R {
	
	Object* Object::wrapPointer(void* p) {
		this->data.PointerField = p;
		this->type = BR_PTR;
		return this;
	}
	Object* Object::wrapPointer(const char* p) {
		this->data.PointerField = (void*)p;
		this->type = BR_CONST_CHAR;
		return this;
	}
		
	Object* Object::wrapPointer(const __FlashStringHelper* p) {
		this->data.PointerField = (void*)p;
		this->type = BR_F_STRING;
		return this;
	}
	
	bool Object::equals(Object* o) {
		if (o == NULL)
			return false;
		if (this->type == BR_PTR) {
			if (o->type == BR_PTR)
				return this->data.PointerField == o->data.PointerField;
			return false;
		}
		if (this->type == BR_CONST_CHAR) {
			if (o->type == BR_CONST_CHAR)
				return strcmp((const char*)this->data.PointerField, (const char*)o->data.PointerField) == 0;
			if (o->type < 20)
				return o->toDouble() == atof((const char*)this->data.PointerField);
			return false;
		}
		if (this->type < 20) {
			if (o->type < 20) {
				return this->toDouble() == o->toDouble();
			}
			if (o->type == BR_CONST_CHAR)
				return this->toDouble() == atof((const char*)o->data.PointerField);
			return false;
		}
		return false;
	}
	Object* Object::wrapNumber(Byte i) {
		return wrapNumber((Long) i);
		
	}
#ifdef _VARIANT_ARDUINO_DUE_X_
	Object* Object::wrapNumber(int i) {
		return wrapNumber((Long) i);
	}
#endif
	Object* Object::wrapNumber(Int i) {
		return wrapNumber((Long) i);
	}
	Object*  Object::wrapNumber(ULong i) {
		this->data.ULongField = i;
		this->type = BR_ULONG;
		return this;
	}
	Object*  Object::wrapNumber(Long i) {
		this->data.LongField = i;
		this->type = BR_LONG;
		return this;
	}
	Object*  Object::wrapNumber(float d) {
		return wrapNumber((double)d);
	}
	Object*  Object::wrapNumber(double d) {
		this->data.DoubleField = d;
		this->type = BR_DOUBLE;
		return this;
	}
	Long Object::toLong() {
		if (this->type == BR_DOUBLE)
			return this->data.DoubleField;
		return this->data.LongField;
	}
	ULong Object::toULong() {
		if (this->type == BR_DOUBLE)
			return this->data.DoubleField;
		return this->data.ULongField;
	}
	Double Object::toDouble() {
		if (this->type == BR_LONG)
			return this->data.LongField;
		else if (this->type == BR_ULONG)
			return this->data.ULongField;
		return this->data.DoubleField;
	}
	void* Object::toPointer(Object* me) {
		if (me == NULL)
			return NULL;
		return me->data.PointerField;
	}
	
	#ifdef CHECK_ARRAY_BOUNDS
	void* Array::getData(UInt index) {
		if (index >= length) {
			#ifdef B4R_SERIAL
			::Serial.print("Out of bounds error. Array length = ");
			::Serial.print(length);
			::Serial.print(", Index = ");
			::Serial.println(index);
			#endif
			BR::errorLoop();
		}
		staticIndex = index;
		return data;
	}
	UInt Array::staticIndex = 0;
	#endif
	Array* Array::wrap(void* data, UInt length) {
		this->data = data;
		this->length = length;
		return this;
	}
	Array* Array::wrapDynamic(UInt length, Int objectSize) {
		wrap((void*)(StackMemory::buffer + StackMemory::cp), length);
		StackMemory::cp += objectSize * length;
		return this;
	}
	Array* Array::wrapObjects(void** arrayOfPointers, void* data, UInt length, Int objectSize) {
		byte *b = (byte*) data;
		for (UInt i = 0;i < length;i++)
			arrayOfPointers[i] = b + objectSize * i;
		this->data = arrayOfPointers;
		this->length = length;
		return this;
	}
	Array* Array::create(void* data, UInt length, Byte type, ...) {
		
		this->data = data;
		this->length = length;
		va_list arguments;
		va_start ( arguments, type );
		for (UInt index = 0;index < length;index++) {
			switch (type) {
				case BR_BYTE:
					((Byte*) data)[index] = va_arg ( arguments, B4R_VAARGS_INT);
					break;
				case BR_PTR:
				case BR_CONST_CHAR:
					((void**)data)[index] = va_arg(arguments, void*);
					break;
				case BR_CHAR:
					((char*) data)[index] = va_arg ( arguments, B4R_VAARGS_INT);
					break;
				case BR_INT:
					((Int*) data)[index] = va_arg ( arguments, B4R_VAARGS_INT);
					break;
				case BR_UINT:
					((UInt*) data)[index] = va_arg ( arguments, B4R_VAARGS_UINT);
					break;
				case BR_LONG:
					((Long*) data)[index] = va_arg ( arguments, Long);
					break;
				case BR_ULONG:
					((ULong*) data)[index] = va_arg ( arguments, ULong);
					break;
				case BR_DOUBLE:
					((Double*) data)[index] = va_arg ( arguments, double);
					break;
				case BR_BOOL:
					((bool*) data)[index] = va_arg ( arguments, B4R_VAARGS_INT);
					break;
				
			}
			
		}
		va_end ( arguments ); 
		return this;
	}
	bool Array::equals(ArrayByte* other) {
		if (other == NULL || other->length != this->length)
			return false;
		return  memcmp(this->data, other->data, this->length) == 0;
	}
	void Common::LogHelper(int length, ...) {
		va_list arguments;
		va_start ( arguments, length );
		Object o[length];
		BR::varArgsToObject(o, length, arguments);
		for (int i = 0;i < length;i++) {
			B4R::B4RStream::Print(&::Serial, &o[i]);
		}
		va_end ( arguments ); 
		::Serial.println();
		if (AUTO_FLUSH_LOGS)
			::Serial.flush();
	}
	void Common::CallSubPlus(SubVoidByte SubName,ULong Interval, Byte Tag) {
		union FunctionUnion fncu;
		fncu.CallSubPlusFunction = SubName;
		scheduler.add(millis() + Interval, fncu, Tag, NULL);
	}
	void Common::AddLooper(SubVoidVoid SubName) {
		union FunctionUnion fncu;
		fncu.LooperFunction = SubName;
		pollers.add(fncu, NULL);
	}
	Int BR::switchObjectToInt(int length,...) {
		va_list arguments;
		va_start ( arguments, length );
		Object* test = (Object*)(va_arg(arguments, void*));
		int res = -1;
		for (int i = 1;i < length;i++) {
			if (test->equals((Object*)(va_arg(arguments, void*)))) {
				res = i - 1;
				break;
			}
		}
		va_end ( arguments ); 
		return res;
	}
	void BR::varArgsToObject(Object o[], int length, va_list arguments) {
		for (int index = 0;index < length;index++) {
			switch ((Int)va_arg ( arguments, B4R_VAARGS_INT)) {
				case BR_BYTE:
					o[index].wrapNumber((Int)va_arg ( arguments, B4R_VAARGS_INT));
					break;
				case BR_PTR: //must be Object*
					o[index] = *(Object*)(va_arg(arguments, void*));
					break;
				case BR_CONST_CHAR:
					o[index].wrapPointer((const char*) va_arg(arguments, void*));
					break;
				case BR_F_STRING:
					o[index].wrapPointer((const __FlashStringHelper*)va_arg(arguments, void*));
					break;
				case BR_CHAR:
					o[index].wrapNumber((Int)va_arg ( arguments, B4R_VAARGS_INT));
					break;
				case BR_INT:
					o[index].wrapNumber((Int)va_arg ( arguments, B4R_VAARGS_INT));
					break;
				case BR_UINT:
					o[index].wrapNumber((ULong)va_arg ( arguments, B4R_VAARGS_UINT));
					break;
				case BR_LONG:
					o[index].wrapNumber((Long)va_arg ( arguments, Long));
					break;
				case BR_ULONG:
					o[index].wrapNumber((ULong)va_arg ( arguments, ULong));
					break;
				case BR_DOUBLE:
					o[index].wrapNumber((Double)va_arg ( arguments, double));
					break;
				case BR_BOOL:
					o[index].wrapNumber((Int)va_arg ( arguments, B4R_VAARGS_INT));
					break;
				
			}
		}
	}
	void BR::errorLoop() {
		while (true)
			delay(100);
	}
	
	
	Common* __c = NULL;
	B4RString::B4RString(void) {
		data = NULL;
	}
}
static ULong AvailableRAM() {
#if defined(ESP_H)
	return (ULong)ESP.getFreeHeap();
#else
	extern int __heap_start, *__brkval;
	int v;
	return (int) &v - (__brkval == 0 ? (int) &__heap_start : (int) __brkval);
#endif
}
// #if  !defined(_NEW)
// void *operator new( size_t, void *ptr ) {
	// return ptr;
// }
// #endif
namespace B4R {
	
	ULong Common::AvailableRAM() {
		return ::AvailableRAM();
	}
	UInt Common::StackBufferUsage() {
		return StackMemory::cp;
	}
	Object* Common::Sender() {
		return sender;
	}
	Array* StackMemory::ReturnArrayOnStack(Array* old, Int ObjectSize) {
		if (old == NULL)
			return NULL;
		int length = old->length;
		int total = old->length * ObjectSize;
		UInt frameEnd = StackMemory::cp;
		memmove((void*)(StackMemory::buffer + StackMemory::cp), old->data, total);
		StackMemory::cp += total;
		ArrayByte* arr = CreateStackMemoryObject(ArrayByte);
		arr->data = StackMemory::buffer + frameEnd;
		arr->length = length;
		return arr;
	}
	B4RString* StackMemory::ReturnStringOnStack(B4RString* old) {
		if (old == NULL)
			return NULL;
		const char* c;
		bool stringLiteral = old->stringLiteral;
		if (old->stringLiteral) {
			c = old->data;
		}
		else {
			int len = old->getLength() + 1;
			c = (const char*)memmove((void*)(StackMemory::buffer + StackMemory::cp), old->data, len);
			StackMemory::cp += len;
		}
		B4RString* str = CreateStackMemoryObject(B4RString);
		str->data = c;
		str->stringLiteral = stringLiteral;
		return str;
		
	}
	B4RString* B4RString::wrap(const char* c){
		data = c;
		if (c == NULL)
			return NULL;
		stringLiteral = true;
		return this;
	}
	ArrayByte* B4RString::GetBytes() {
		ArrayByte* arr = CreateStackMemoryObject(ArrayByte);
		arr->data = (void*)this->data;
		arr->length = getLength();
		return arr;
	}
	bool B4RString::equals(B4RString* o) {
		if (o == NULL)
			return false;
		return strcmp(this->data, o->data) == 0;
	}
	Int B4RString::getLength() {
		return strlen(data);
	}
	static B4RString be_empty;
	B4RString* B4RString::EMPTY = be_empty.wrap("");
	byte* StackMemory::buffer = NULL;
	UInt StackMemory::cp = 0;
	size_t PrintToMemory::write(uint8_t b) {
		StackMemory::buffer[StackMemory::cp++] = b;
		return 1;
	}
	B4RString* B4RString::PrintableToString(Printable* p) {
		PrintToMemory pm;
		B4RString* s = CreateStackMemoryObject(B4RString);
		s->stringLiteral = false;
		s->data = (const char*)(StackMemory::buffer + StackMemory::cp);
		if (p == NULL)
			return s;
		pm.print(*p);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}
	B4RString* B4RString::fromNumber(Double d) {
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(d);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}
	B4RString* B4RString::fromNumber(Long d) {
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(d);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}
	B4RString* Common::NumberFormat(Double Number, byte MinimumIntegers, byte MaximumFractions) {
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		Long lng = 1;
		byte i;
		if (Number < 0) {
			pm.print("-");
			Number = -Number;
		}
		for (i = 0;i < MinimumIntegers - 1;i++) {
			lng *= 10;
			if (lng > Number) {
				MinimumIntegers = MinimumIntegers - i;
				while (MinimumIntegers > 1) {
					pm.print(0);
					MinimumIntegers--;
				}
			}
		}
		pm.print(Number, (Int)MaximumFractions);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
		
	}
	bool Common::IsNumber(B4RString* s) {
		char *end;
		strtod(s->data, &end); 
		return end == s->data + s->getLength();
	}
	Double Common::Constrain(Double Value, Double MinValue, Double MaxValue) {
		return constrain(Value, MinValue, MaxValue);
	}
	B4RString* Common::JoinStrings(ArrayString* strings) {
		B4RString* s = CreateStackMemoryObject(B4RString);
		s->stringLiteral = false;
		s->data = (const char*)(StackMemory::buffer + StackMemory::cp);
		for (UInt i = 0;i < strings->length;i++) {
			B4RString* c = ((B4RString**)strings->data)[i];
			UInt stringLength = c->getLength();
			memcpy((Byte*)(StackMemory::buffer + StackMemory::cp),c->data, stringLength);
			StackMemory::cp += stringLength;
		}
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}
	ArrayByte* Common::JoinBytes(ArrayObject* ArraysOfBytes) {
		ArrayByte* res = CreateStackMemoryObject(ArrayByte);
		res->data = (Byte*)(StackMemory::buffer + StackMemory::cp);
		for (UInt i = 0;i < ArraysOfBytes->length;i++) {
			ArrayByte* ab = (ArrayByte*)(((Object**)ArraysOfBytes->data)[i])->data.PointerField;
			memcpy((Byte*)(StackMemory::buffer + StackMemory::cp),ab->data, ab->length);
			StackMemory::cp += ab->length;
			res->length += ab->length;
		}
		return res;
	}
	B4RString* BitClass::ToBinaryString(UInt N) {
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(N, 2);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}
	
}
	