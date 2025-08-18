#ifndef B4RCore_h
#define B4RCore_h
#include "B4RDefines.h"



typedef int16_t Int;
typedef uint16_t UInt;
typedef int32_t Long;
typedef uint32_t ULong;
typedef byte Byte;
typedef float Double;
#ifdef B4R_STANDARD_PROMOTIONS
typedef int B4R_VAARGS_INT;
typedef unsigned int B4R_VAARGS_UINT;
#endif

//if removed becouse generate error at compiler time
//#if !defined(_NEW) && !defined(SKIP_B4RNEW)
//extern void *operator new( size_t size, void *ptr );
//#endif
//~version: 3.90
namespace B4R {
	//numeric types < 20
	#define BR_BYTE 1
	#define BR_CHAR 2
	#define BR_INT 3
	#define BR_UINT 4 
	#define BR_LONG 5 //stored type
	#define BR_ULONG 6 //stored type
	#define BR_DOUBLE 7 //stored type
	#define BR_BOOL 8
	#define BR_PTR 100 //stored type
	#define BR_CONST_CHAR 101 //stored type
	#define BR_F_STRING 102 //stored type

	#define ByteFromArray(Arr,Index) ((Byte*)Arr->data)[Index]

	class Object;
	//~hide
	class Array {
		public:
			Array* wrap(void* data, UInt length);
			Array* wrapDynamic(UInt length, Int objectSize);
			Array* wrapObjects(void** arrayOfPointers, void* data, UInt length, Int objectSize);
			Array* create(void* data, UInt length, Byte type,...);
			void CopyTo(Array* Destination, UInt StartOffset, UInt Count, UInt ElementSize);
			void* data;
			UInt length;
			#ifdef CHECK_ARRAY_BOUNDS
			static UInt staticIndex;
			void* getData(UInt index);
			#endif
			bool equals(Array* other);
			
		
	};
	typedef void (*SubVoidArray)(Array* barray) ;
	typedef void (*SubVoidBool)(bool b) ;
	typedef void (*SubVoidByte)(Byte b) ;
	typedef void (*SubVoidVoid) (void);
	typedef void (*SubByteVoidP)(Byte, void*);
	typedef void (*SubVoidVoidP)(void*);
	typedef Object* (*FunctionObjectObject)(Object*);
	typedef Array ArrayObject;
	typedef Array ArrayByte;
	typedef Array ArrayInt;
	typedef Array ArrayUInt;
	typedef Array ArrayLong;
	typedef Array ArrayULong;
	typedef Array ArrayFloat;
	typedef Array ArrayDouble;
	typedef Array ArrayString;
	
	union ObjectData {
		void* PointerField;
		Double DoubleField;
		Long LongField;
		ULong ULongField;
	};
	union FunctionUnion {
		SubByteVoidP TimerFunction;
		SubVoidByte CallSubPlusFunction;
		SubVoidVoid LooperFunction;
		SubVoidVoidP PollerFunction;
	};
	//~hide
	class Object {
		public:
		Object* wrapNumber(Byte i);
		Object* wrapNumber(ULong i);
		Object* wrapNumber(Long i);
#ifdef _VARIANT_ARDUINO_DUE_X_ 
		Object* wrapNumber(int i);
#endif
		Object* wrapNumber(Int i);
		Object* wrapNumber(float d);
		Object* wrapNumber(double d);
		Object* wrapPointer(void* p);
		Object* wrapPointer(const char* c);
		Object* wrapPointer(const __FlashStringHelper* f);
		bool equals(Object* o);
		Long toLong();
		ULong toULong();
		Double toDouble();
		static void* toPointer(Object* me);
		
		ObjectData data;
		Byte type;
	};
	//~hide
	class ObjectWrapper {
		public:
			virtual void* GetNative() = 0;
	};
	
	//~hide
	class ScheduledNode {
	public:
		ScheduledNode();
		ULong eventTime;
		FunctionUnion functionUnion;
		Byte tag;
		void* target;
		ScheduledNode* next;
		
	};
	//~hide
	class Scheduler {
	public:
		Scheduler();
		void add(ULong x,  FunctionUnion fncu, Byte tag, void* target);
		ScheduledNode* getFirst();
		void removeFirst();
		void printList();
		void loop();
	private:
		ScheduledNode* first;
		ScheduledNode* last;
		ScheduledNode* unused;
		void insertBetween(ScheduledNode* n, ScheduledNode* prev, ScheduledNode* next);
		ScheduledNode* getUnused();
	
	};

	//~hide
	class PollerNode {
	public:
		FunctionUnion functionUnion;
		void* tag;
		PollerNode* next;
		PollerNode() {
			next = NULL;
		}
	};
	//~hide
	class PollerList {
		volatile static SubVoidVoid interruptFnc;
	public:
		PollerList();

		void runAll();
		void add(FunctionUnion fnc, void* tag);
		void add(PollerNode* pnode);
		void remove(PollerNode* pnode);
		void setInterrupt(SubVoidVoid fnc);
		

	private:
		PollerNode* first;
		PollerNode* last;
	};

	
	
	
	
	//~ShortName: Timer	
	//~Event: Tick
	class Timer {
		public:
			//Gets or sets the timer interval, measured in milliseconds.
			ULong Interval;
			/**
			*Initializes the timer. Note that you must set Enabled to True for the timer to start running.
			*TickSub - The sub that will handle the tick event.
			*Interval - Interval measured in milliseconds.
			*/
			void Initialize(SubVoidVoid TickSub, ULong Interval);
			//Enables or disables the timer.
			void setEnabled(bool e);
			bool getEnabled();
		private:
			Byte counter;
			void (*event)(void);
			bool enabled = false;
			static void tick(Byte tag, void* target);

	};
	class B4RString;
	class B4RStream;
	//~ShortName: Bit
	class BitClass {
		public:
		//Returns the bitwise AND of the two values.
		#define /*UInt And (UInt X, UInt Y);*/ BitClass_And(X, Y) ((X) & (Y))
		//Returns the bitwise OR of the two values.
		#define /*UInt Or (UInt X, UInt Y);*/ BitClass_Or(X, Y) ((X) | (Y))
		//Returns the bitwise XOR of the two values.
		#define /*UInt Xor (UInt X, UInt Y);*/ BitClass_Xor(X, Y) ((X) ^ (Y))
		//Returns the bitwise complement of the given value.
		#define /*UInt Not (UInt N);*/ BitClass_Not(N) (~(N))
		/**
		 * Shifts N left.
		 *Shift - Number of positions to shift.
		 */
		#define /*UInt ShiftLeft (UInt N, Byte Shift);*/ BitClass_ShiftLeft(N,S) ((N) << (S))
		/**
		 * Shifts N right.
		 *Shift - Number of positions to shift.
		 */
		#define /*UInt ShiftRight (UInt N, Byte Shift);*/ BitClass_ShiftRight(N,S) ((N) >> (S))
		/**
		 * Returns a string representation of N in base 2.
		 */
		static B4RString* ToBinaryString(UInt N);
		/**
		 * Parses Value as an integer using the specified radix. Returns 0 if the value cannot be parsed.
		 *Radix - Should be between 2 to 36.
		 */
		#define /*Int ParseInt(B4RString* Value, Byte Radix);*/ BitClass_ParseInt(V,R) strtol((V)->data, NULL, R)
		//Returns the low byte value of the given number.
		#define /*Byte LowByte (UInt N);*/ BitClass_LowByte(N) lowByte(N)
		//Returns the high byte value of the given number.
		#define /*Byte HighByte (UInt N);*/ BitClass_HighByte(N) highByte(N)
		/**
		*Returns a byte based on the given number, with the specified bit set.
		*Example: <code>
		*Dim b As Byte = 0
		*b = Bit.Set(b, 0)
		*Log(b) '1</code>
		*/
		#define /*Byte Set(Byte B, Byte Bit);*/ BitClass_Set(B,Bit) bitSet(B,Bit)
		//Returns a byte based on the given number, with the specified bit cleared.
		#define /*Byte Clear(Byte B, Byte Bit);*/ BitClass_Clear(B,Bit) bitClear(B,Bit)
		//Returns the value of the specified bit in the given number.
		#define /*Byte Get(Byte B, Byte Bit);*/ BitClass_Get(B,Bit) bitRead(B,Bit)
	};
	
	class Common {
		public:
		//Bitwise related methods.
		static const BitClass* Bit;
		#define /*bool True;*/ Common_True true
		#define /*bool False;*/ Common_False false
		#define /*Object* Null;*/ Common_Null NULL
		//New line character. Value of Chr(13) and Chr(10). Note that in other B4X products the value is Chr(10).
		#define /*StringLiteral CRLF;*/ Common_CRLF "\r\n"
		//Tab character.
		#define /*StringLiteral TAB;*/ Common_TAB "\t"
		//Quote character.
		#define /*StringLiteral QUOTE;*/ Common_QUOTE "\""
		//PI constant.
		#define /*Double cPI;*/ Common_cPI PI 
		//e (natural logarithm base) constant.
		#define /*Double cE;*/ Common_cE EULER 
		/**
		*Logs one or more messages.
		*This is a special method. It can accept any number of parameters.
		*The data is sent through the Serial object.
		*Each parameter can be a String, number or an array of bytes (which will be treated as a string).
		*Example: <code>
	 *Log("x = ", x)</code>
		*/
		static void Log(Object* OneOrMoreMessages);
		//~hide
		static void LogHelper(int len, ...);
		//Returns the available memory. 
		static ULong AvailableRAM();
		//Returns the usage of the stack memory buffer (set with #StackMemoryBuffer attribute).
		static UInt StackBufferUsage();
		/**
	 * Declares a sub with the parameters and return type.
	 *Syntax: Sub name [(list of parameters)] [As return-type]
	 *Parameters include name and type.
	 *The lengths of arrays dimensions should not be included.
	 *Example:<code>
	 *Sub MySub (FirstName As String, LastName As String, Age As Int, OtherValues() As Double) As Boolean
	 * ...
	 *End Sub</code>
	 *In this example OtherValues is a single dimension array.
	 *The return type declaration is different than other declarations as the array parenthesis follow the type and not
	 *the name (which does not exist in this case).
	 */
		#define /*static void Sub();*/ Common_Sub 
		/**
	 * Creates a single dimension array of the specified type, or Object if the type is not specified.
	 *The syntax is: Array As type (list of values).
	 *Example:<code>
	 *Dim Days() As String = Array As String("Sunday", "Monday", ...)</code>
	 */
		static void Array();
		/**
	 * Single line:
	 *If condition Then true-statement [Else false-statement]
	 *Multiline:
	 *If condition Then
	 * statement
	 *Else If condition Then
	 * statement
	 *...
	 *Else
	 * statement
	 *End If
	 */
		static void If();
		/**
	 * Declares a variable.
	 *Syntax:
	 *Declare a single variable:
	 *Dim variable name [As type] [= expression]
	 *The default type is String.
	 *
	 *Declare multiple variables. All variables will be of the specified type.
	 *Dim variable1 [= expression], variable2 [= expression], ..., [As type]
	 *Note that the shorthand syntax only applies to Dim keyword.
	 *Example:<code>Dim a = 1, b = 2, c = 3 As Int</code>
	 *
	 *Declare an array:
	 *Dim variable(Rank1, Rank2, ...) [As type]
	 *Example:<code>Dim Days(7) As String</code>
	 *The actual rank can be omitted for zero length arrays.
	 */
		static void Dim();
		/**
	 * Loops while the condition is true.
	 * Syntax:
	 * Do While condition
	 *  ...
	 * Loop
	 */
		static void While();
		/**
	 * Loops until the condition is true.
	 * Syntax:
	 * Do Until condition
	 *  ...
	 * Loop
	 */
		static void Until();
		/**
	 * Syntax:
	 *For variable = value1 To value2 [Step interval]
	 * ...
	 *Next
	 *If the iterator variable was not declared before it will be of type Int.
	 *
	 *Or:
	 *For Each variable As type In collection
	 * ...
	 *Next
	 *Examples:<code>
	 *For i = 1 To 10
	 * Log(i) 'Will print 1 to 10 (inclusive).
	 *Next
	 *For Each n As Int In Numbers 'an array
	 * Sum = Sum + n
	 *Next
	 *</code>
	 *Note that the loop limits will only be calculated once before the first iteration.
	 */
		static void For();
		/**
	 * Declares a structure.
	 *Can only be used inside Process_Globals sub.
	 *Syntax:
	 *Type type-name (field1, field2, ...)
	 *Fields include name and type.
	 *Example:<code>
	 *Type MyType (Name As String, Value As Int)
	 *Dim a, b As MyType
	 *a.Value = 123</code>
	 */
		static void Type();
		/**
	 * Exits the most inner loop.
	 *Note that Exit inside a Select block will exit the Select block.
	 */
		static void Exit();
		/**
	 * Stops executing the current iteration and continues with the next one.
	 */
		static void Continue();
		/**
	 * Returns from the current sub and optionally returns the given value.
	 *Note that only primitives, numbers, strings and array of primitives can be returned.
	 *Syntax: Return [value]
	 */
		static void Return();
		/**
		 * Compares a single value to multiple values.
		 *Example:<code>
		 *Dim value As Int = 7
		 *Select value
		 *	Case 1
		 *		Log("One")
		 *	Case 2, 4, 6, 8
		 *		Log("Even")
		 *	Case 3, 5, 7, 9
		 *		Log("Odd larger than one")
		 *	Case Else
		 *		Log("Larger than 9")
		 *End Select</code>
		 */
		static void Select();
		/**
		 * Inline If - returns TrueValue if Condition is True and False otherwise. Only the relevant expression is evaluated. 
		 *It is recommended to explicitly set the return type with a following As:
		 *<code>Dim x As Int = IIf(y > 10, 17, 7).As(Int)</code>
		 */
		static Object IIf (boolean Condition, Object TrueValue, Object FalseValue);
		/**
		*Returns the size (number of bytes) of the given object. The object type must be known during compilation.
		*/
		static UInt SizeOf(Object* Object);
		/**
		*Pauses the execution for the specified delay measured in milliseconds.
		*Note that in most cases it is better to use a Timer or CallSubPlus instead.
		*/
		#define /*void Delay (ULong DelayMs);*/ Common_Delay(X) delay(X)
		
		//Pauses the execution for the specified delay measured in microseconds.
		#define /*void DelayMicroseconds (UInt Delay);*/ Common_DelayMicroseconds(X) delayMicroseconds(X)
		/**
		* Inverts the value of the given boolean.
		*/
		#define /*bool Not(Bool Value);*/ Common_Not(X) !(X)
		/**
		*Runs the given sub after the specified time elapses. Note that this call does not block the thread.
		*SubName - Sub name as literal string.
		*DelayMs - Delay in milliseconds.
		*Tag - Value that will be passed to the called sub. This is useful when multiple CallSubPlus call the same sub.
		*Example:<code>
	 *CallSubPlus("DoSomething", 1000, 5)
	 *'...
	 *
	 *Sub DoSomething(Tag as Byte)
	 *	
	 *End Sub</code>
		*/
		static void CallSubPlus(SubVoidByte SubName,ULong DelayMs, Byte Tag);
		/**
		*Runs an inline C function.
		*Example:<code>
		 *RunNative("testc", Null)
		 *
		 *#If C
		 * void testc(B4R::Object* o) {
		 *	Serial.println(b4r_main::_i); //print a global variable named i
		 *}
		 *#End If</code>
		*/
		#define /*Object* RunNative (FunctionObjectObject Method, Object* Arg);*/ Common_RunNative(F,A) F(A)
		/**
		*Adds a looper sub. Looper is similar to a timer with the lowest possible interval.
		*There could be any number of looper subs. 
		*Example:<code>
		*AddLooper("Looper1")
		*'...
		*Sub Looper1
		*
		*End Sub</code>
		*/
		static void AddLooper(SubVoidVoid SubName);
		//Returns the object that raised the event (if it was set).
		static Object* Sender();
		/**
		*Converts the number to string with the specified minimum number of integers and maximum number of fractions.
		*/
		static B4RString* NumberFormat(Double Number, byte MinimumIntegers, byte MaximumFractions);
		/**
		*Sets that random seed value.
		*Example based on the analog value of a floating pin:<code>
	 *dim p as Pin
	 *p.Initialize(0, p.MODE_INPUT)
	 *RndSeed(p.AnalogRead)</code>
		*/
		#define /*void RndSeed (ULong Seed);*/ Common_RndSeed(s) randomSeed(s)
		/**
		 * Returns a random number between Min (inclusive) and Max (exclusive).
		 */
		 #define /*Long Rnd(Long Mininum, Long Maximum);*/ Common_Rnd(m1,m2) random(m1,m2)
		//Returns the number of milliseconds since the last restart.
		#define /*ULong Millis();*/ Common_Millis() ((ULong)millis())
		//Returns the number of microseconds since the last restart.
		//Note that this value overflows (goes back to zero) after approximately 70 minutes.
		#define /*ULong Micros();*/ Common_Micros() ((ULong)micros())
		//Returns the absolute value.
		#define /*Double Abs(Double Number);*/ Common_Abs(n) abs(n)
		/**
		* Returns the larger number between the two numbers.
		*/
		#define /*Double Max(Double Number1, Double Number2);*/ Common_Max(a,b) ((a)>(b)?(a):(b))
		/**
		* Returns the smaller number between the two numbers.
		*/
		#define /*Double Min(Double Number1, Double Number2);*/ Common_Min(a,b) ((a)<(b)?(a):(b))
		//Calculates the trigonometric sine function. Angle measured in radians.
		#define /*Double Sin(Double Radians);*/ Common_Sin(n) sin(n)
		//Calculates the trigonometric sine function. Angle measured in degrees.
		#define /*Double SinD(Double Degrees);*/ Common_SinD(n) sin(n * DEG_TO_RAD)
		//Calculates the trigonometric cosine function. Angle measured in radians.
		#define /*Double Cos(Double Radians);*/ Common_Cos(n) cos(n)
		//Calculates the trigonometric cosine function. Angle measured in degrees.
		#define /*Double CosD(Double Degrees);*/ Common_CosD(n) cos(n * DEG_TO_RAD)
		//Calculates the trigonometric tangent function. Angle measured in radians.
		#define /*Double Tan(Double Radians);*/ Common_Tan(n) tan(n)
		//Calculates the trigonometric tangent function. Angle measured in degrees.
		#define /*Double TanD(Double Degrees);*/ Common_TanD(n) tan(n * DEG_TO_RAD)
		//Returns the Base value raised to the Exponent power.
		#define /*Double Power(Double Base, Double Exponent);*/ Common_Power(n1,n2) pow(n1, n2)
		//Returns the positive square root.
		#define /*Double Sqrt(Double Value);*/ Common_Sqrt(n1) sqrt(n1)
		//Returns the angle measured with radians.
		#define /*Double ASin(Double Value);*/ Common_ASin(n) asin(n)
		//Returns the angle measured with degrees.
		#define /*Double ASinD(Double Value);*/ Common_ASinD(n) (asin(n) * RAD_TO_DEG)
		//Returns the angle measured with radians.
		#define /*Double ACos(Double Value);*/ Common_ACos(n) acos(n)
		//Returns the angle measured with degrees.
		#define /*Double ACosD(Double Value);*/ Common_ACosD(n) (acos(n) * RAD_TO_DEG)
		//Returns the angle measured with radians.
		#define /*Double ATan(Double Value);*/ Common_ATan(n) atan(n)
		//Returns the angle measured with degrees.
		#define /*Double ATanD(Double Value);*/ Common_ATanD(n) (atan(n) * RAD_TO_DEG)
		//Returns the angle measured with radians.
		#define /*Double ATan2(Double Y, Double X);*/ Common_ATan2(y,x) atan2(y,x)
		//Returns the angle measured with degrees.
		#define /*Double ATan2D(Double Y, Double X);*/ Common_ATan2D(y,x) (atan2(y,x) * RAD_TO_DEG)
		
		#define /*Double Logarithm(Double Number, Double Base);*/ Common_Logarithm(Number,Base) (log(Number)/log(Base))
		//Returns the whole number closest to the given number. 
		#define /*Long Round(Double Number);*/ Common_Round(n) lround(n)
		//Returns the smallest double that is greater or equal to the specified number and is equal to an integer.
		#define /*Double Ceil(Double Number);*/ Common_Ceil(n) ceil(n)
		//Returns the largest double that is smaller or equal to the specified number and is equal to an integer.
		#define /*Double Floor(Double Number);*/ Common_Floor(n) floor(n)
		//Tests whether the given string can be safely parsed as a number.
		bool IsNumber(B4RString* Text);
		//Equivalent to Min(MaxValue, Max(Value, MinValue))
		Double Constrain(Double Value, Double MinValue, Double MaxValue);
		//Returns the byte (ASCII) value of the first character in the string.
		#define /*Byte Asc(B4RString* Character);*/ Common_Asc(s) ((s)->data[0])
		/**
		*Maps the value from the "from" range to the "to" range.
		*
		*Example:<code>
	 *Dim v as int = MapRange(p.AnalogRead, 0, 1023, 0, 255)</code>
		*/
		#define /*Long MapRange (Long Value, Long FromLow, Long FromHigh, Long ToLow, Long ToHigh);*/ Common_MapRange(a,b,c,d,e) map(a,b,c,d,e)
		/**
		*Concatenates the strings to a single string.
		*Think carefully before using this method. In most cases there are better solutions that require less memory.
		*Example:<code>
		*Dim s As String  = JoinStrings(Array As String("Pi = ", cPI))</code>
		*/
		B4RString* JoinStrings(ArrayString* Strings);
		/**
		*Concatenates the arrays of bytes to a single array.
		*Think carefully before using this method. In most cases there are better solutions that require less memory (calling Write multiple times for example).
		*Example: <code>
		*Dim b() as byte = JoinBytes(Array("abc".GetBytes, Array as Byte(13, 10)))</code>
		*/
		ArrayByte* JoinBytes(ArrayObject* ArraysOfObjects);
		
		
	};
	//~hide
	class StackMemory {
		public:
		static byte* buffer;
		static UInt cp;
#if B4R_MEMORY_ALIGNMENT > 0
		#define AlignCP (StackMemory::cp = ((StackMemory::cp + B4R_MEMORY_ALIGNMENT) & ~B4R_MEMORY_ALIGNMENT))
#else
		#define AlignCP (StackMemory::cp = StackMemory::cp)
#endif
		#define CreateStackMemoryObject(type) new (StackMemory::buffer + AlignCP) type(); StackMemory::cp += sizeof(type)
		
		static Array* ReturnArrayOnStack(Array* arr, Int objectSize);
		static B4RString* ReturnStringOnStack(B4RString* old);
		
	};
	class B4RString{
		public:
		//~hide
		B4RString();
		//~hide
		const char* data;
		//~hide
		bool stringLiteral = false;
		//~hide
		B4RString* wrap(const char* c);
		//~hide
		bool equals(B4RString* s);
		//~hide
		static B4RString* fromNumber(Double d);
		//~hide
		static B4RString* fromNumber(Long lng);
		//Returns the string length.
		Int getLength();
		//Returns the string content as an array of bytes.
		//Note that the array and string share the same memory.
		ArrayByte* GetBytes();
		//~hide
		static B4RString* EMPTY;
		//~hide
		static B4RString* PrintableToString(Printable* p);
		
	};
	//~hide
	class PrintToMemory : public Print {
		size_t write(uint8_t);
	};
	#undef BR
	//~hide
	class BR {
		public:
		static void varArgsToObject(Object o[], int length, va_list arguments);
		static Int switchObjectToInt(int length, ...);
		static void errorLoop();
		
	};
	//~shortname: Pin
	//~event: StateChanged (State As Boolean)
	class Pin {
		public:
			//Returns the pin's number.
			Byte PinNumber;
			//Input mode.
			#define /*Byte MODE_INPUT;*/ Pin_MODE_INPUT INPUT
			//Output mode.
			#define /*Byte MODE_OUTPUT;*/ Pin_MODE_OUTPUT OUTPUT
			//Input mode with internal pull up resistor.
			#define /*Byte MODE_INPUT_PULLUP;*/ Pin_MODE_INPUT_PULLUP INPUT_PULLUP
			#define /*Byte A0;*/ Pin_A0 A0
			#define /*Byte A1;*/ Pin_A1 A1
			#define /*Byte A2;*/ Pin_A2 A2
			#define /*Byte A3;*/ Pin_A3 A3
			#define /*Byte A4;*/ Pin_A4 A4
			#define /*Byte A5;*/ Pin_A5 A5
			#define /*Byte A6;*/ Pin_A6 A6
			#define /*Byte A7;*/ Pin_A7 A7
			//Initializes the pin and sets the mode.
			void Initialize(Byte Pin, Byte Mode);
			//Sets the pin's mode (one of the MODE constants).
			void setMode(Byte Mode) ;
			//Adds a listener. The StateChanged event will be raised when the pin's state changes.
			void AddListener(SubVoidBool StateChangedSub) ;
			//Reads the pin value and returns true or false.
			bool DigitalRead() ;
			//Reads the pin value and returns a value between 0 to 1023.
			UInt AnalogRead();
			//Writes the given value.
			void DigitalWrite(bool Value) ;
			/**
			*Writes the given analog value. Value should be between 0 to 255.
			*This can only be used with pins that support PMW waves.
			*/
			void AnalogWrite(UInt Value) ;
		private:
			bool CurrentValue;
			void (*Event)(bool NewValue);
			static void loop(void* b);

	};
	//~ShortName: Stream
	class B4RStream {
		public:
		//~hide
		Stream* wrappedStream = NULL;
		//~hide
		Client* wrappedClient = NULL;
		//Flushes the stream.
		void Flush();
		/**
		*Writes the data to the stream. Returns the number of bytes written.
		*All the bytes will be written to the stream if possible.
		*Buffer - Data that will be written.
		*StartOffset - Index of the first byte.
		*Length - Number of bytes that will be written.
		*/
		UInt WriteBytes (ArrayByte* Buffer, UInt StartOffset, UInt Length);
		/**
		*Returns the number of bytes that are available for reading.
		*/
		Int BytesAvailable();
		/**
		*Reads data from the stream and stores it in the buffer.
		*Will attempt to read the specified number of bytes.
		*Returns the number of bytes read.
		*Buffer - Data will be written to this array.
		*StartOffset - Index of the first byte in the array.
		*Length - Number of bytes to read.
		*/
		UInt ReadBytes(ArrayByte* Buffer, UInt StartOffset, UInt Length);
		//~hide
		static void Print(::Print* stream, Object* message);
			
			
	};
	//~ShortName: Serial
	class Serial{
		private: 
			B4RStream stream;
		public:
			//Initializes the serial object and sets the baudrate. Uses the default 8N1 configuration.
			//The baudrate should match the setting in the IDE if the serial will be used for logging.
			void Initialize (ULong BaudRate);
			//Returns the internal stream. This can be used together with AsyncStreams to read or write from the serial.
			B4RStream* getStream();
			//Closes the serial port.
			void Close();
	};
	//~hide
	class Iterator {
		public:
			virtual bool MoveNext() = 0;
			virtual Object* Get() = 0;
	};
	
	extern Scheduler scheduler;
	extern PollerList pollers;
	extern Object* sender; 
	extern Common* __c;
	
}
#endif






