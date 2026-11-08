/**
 * rAdafruitMCP23017_I2C.cpp
 * Source of the B4R library rAdafruitMCP23017_I2C.
 */

#include "B4RDefines.h"
namespace B4R {

	bool B4RAdafruitMCP23X17::Initialize() {
		bool rt;
		int i;
		
		mcp = new (beAdafruitMCP23X17) Adafruit_MCP23X17();
		
		this->StateChangedSub = nullptr;
		
		// Init the I2C interface
		rt = mcp->begin_I2C();
		
		// If successful then set all pins by default to mode OUTPUT with state LOW
		if (rt) {
			for (i=0;i<PINS;i++){
				pinModes[i] = MODE_OUTPUT;
				pinStates[i] = STATE_LOW;
			}
		}
		return rt;
	}

	bool B4RAdafruitMCP23X17::Initialize2(Byte addr){
		bool rt;
		int i;
		
		mcp = new (beAdafruitMCP23X17) Adafruit_MCP23X17();
		
		this->StateChangedSub = nullptr;
		
		// Init the I2C interface
		rt = mcp->begin_I2C(addr);
		
		// If successful then set all pins by default to mode OUTPUT with state LOW
		if (rt) {
			for (i=0;i<PINS;i++){
				pinModes[i] = MODE_OUTPUT;
				pinStates[i] = STATE_LOW;
			}
		}

		return rt;
	}
	
	void B4RAdafruitMCP23X17::SetPinMode(Byte pin, Byte mode) {
		mcp->pinMode(pin, mode);
		pinModes[pin] = mode;

		// Example logging over serial line
		/*
		::Serial.print("[DEBUG] SetPinMode pin=");
		::Serial.print(pin);
		::Serial.print(" mode=");
		::Serial.println(mode);
		*/
	}

	Byte B4RAdafruitMCP23X17::GetPinMode(Byte pin) {
		return pinModes[pin];
	}

	Byte B4RAdafruitMCP23X17::DigitalRead(Byte pin) {
		Byte state = mcp->digitalRead(pin);
		pinStates[pin] = state;
		return state;
	}

	void B4RAdafruitMCP23X17::DigitalWrite(Byte pin, Byte value) {
		mcp->digitalWrite(pin, value);
		pinStates[pin] = value;
	}
	
	Byte B4RAdafruitMCP23X17::ReadGPIO(Byte port) {
		return mcp->readGPIO(port);
	}

	void B4RAdafruitMCP23X17::WriteGPIO(Byte value, Byte port) {
		mcp->writeGPIO(value, port);
	}


	void B4RAdafruitMCP23X17::SetupInterrupts(bool mirroring, bool openDrain, Byte polarity) {
		mcp->setupInterrupts(mirroring, openDrain, polarity);
	}
	
	void B4RAdafruitMCP23X17::SetupInterruptPin(Byte pin, Byte mode) {
		mcp->setupInterruptPin(pin, mode);
	}
	
	void B4RAdafruitMCP23X17::DisableInterruptPin(Byte pin) {
		mcp->disableInterruptPin(pin);
	}
	
	void B4RAdafruitMCP23X17::ClearInterrupts() {
		mcp->clearInterrupts();
	}
	
	Byte B4RAdafruitMCP23X17::GetLastInterruptPin() {
		return mcp->getLastInterruptPin();
	}
	
	UInt B4RAdafruitMCP23X17::GetCapturedInterrupt() {
		return mcp->getCapturedInterrupt();
	}
	
	/**
	 * Custom Functions
	 */

	void B4RAdafruitMCP23X17::AddInputHandler(SubVoidPinState StateChangedSub) {
		this->StateChangedSub = StateChangedSub;
		FunctionUnion fu;
		fu.PollerFunction = looperdebouncepolling;
		pollers.add(fu, this);			// "this" will be passed as void*
	}
	
	void B4RAdafruitMCP23X17::AttachInterrupt(Byte intPin, Byte buttonPin, SubVoidPinState StateChangedSub) {
		
		// Configure MCU pin that will read INTA/B state
		pinMode(intPin, INPUT);
		this->intPin = intPin;

		// OPTIONAL - call this to override defaults
		// mirror INTA/B so only one wire required
		// active drive so INTA/B will not be floating
		// INTA/B will be signaled with a LOW
		// mcp->setupInterrupts(true, false, LOW);

		// configure button pin for input with pull up
		mcp->pinMode(buttonPin, INPUT_PULLUP);

		// Enable interrupt on button_pin
		mcp->setupInterruptPin(buttonPin, LOW);

		// Pin state changed event
		this->StateChangedSub = StateChangedSub;
		FunctionUnion fu;
		fu.PollerFunction = looperinterrupt;
		pollers.add(fu, this);			// "this" will be passed as void*
	}
	
	void B4RAdafruitMCP23X17::looperdebouncepolling(void* b) {
		B4RAdafruitMCP23X17* me = (B4RAdafruitMCP23X17*) b;

		// poll every 10 ms
		if (millis() - me->lastCheck < 10) return;
		me->lastCheck = millis();

		for (int i = 0; i < PINS; i++) {
			if (me->pinModes[i] == MODE_INPUT || me->pinModes[i] == MODE_INPUT_PULLUP) {
				int rawState = me->mcp->digitalRead(i);

				// If state differs from last raw read, reset debounce timer
				if (rawState != me->lastReadStates[i]) {
					me->lastReadStates[i] = rawState;
					me->lastChangeTime[i] = millis();
				}

				// If raw state is stable for >=20 ms AND different from stored stable state
				if ((millis() - me->lastChangeTime[i]) >= 20 && rawState != me->pinStates[i]) {
					me->pinStates[i] = rawState;
					if (me->StateChangedSub) {
						me->StateChangedSub(i, rawState);
					}
				}
			}
		}
	}

	void B4RAdafruitMCP23X17::looperinterrupt(void* b) {
		B4RAdafruitMCP23X17* me = (B4RAdafruitMCP23X17*) b;

		// poll every 10 ms
		if (millis() - me->lastCheck < 10) return;
		me->lastCheck = millis();
		
		// Check hardware INT pin on state LOW (only)
		if (me->intPin != 255 && digitalRead(me->intPin) == LOW) {
			// Interrupt detected on pin
			Byte intPin = me->mcp->getLastInterruptPin();
			// Pin states at time of interrupt: 0b2 (so captured has value 2)
			UInt captured = me->mcp->getCapturedInterrupt();

			// DEBUG Example
			/*
			::Serial.print("intPin=");
			::Serial.print(me->intPin);
			::Serial.print(",captured=");
			::Serial.println(captured, HEX);
			*/

			// Check if the pin within pin range and if there is a callback event
			if (intPin < PINS && me->StateChangedSub) {
				bool state = (captured & (1 << intPin)) != 0;
				me->StateChangedSub(intPin, state);
			}
			delay(250);  // debounce
			me->mcp->clearInterrupts();
		}
	}

	/**
	 * HELPER
	 */

	// Uses B4R's StackMemory for temporary storage.
	// The string is only valid until the next call that also uses StackMemory.
	B4RString* B4RAdafruitMCP23X17::ByteToHex(Byte b) {
		// Lookup table for hex characters 0–F
		static const char HEXCHARS[] = "0123456789ABCDEF";

		// Temporary buffer for the hex string: 2 chars + null terminator
		char buf[3];
		buf[0] = HEXCHARS[b >> 4];     // High nibble (upper 4 bits)
		buf[1] = HEXCHARS[b & 0x0F];   // Low nibble (lower 4 bits)
		buf[2] = '\0';                 // Null terminator for C string

		// Printer that writes into B4R's StackMemory buffer
		PrintToMemory pm;

		// Create a managed B4R string (placeholder, real content comes from pm.print)
		B4RString* s = B4RString::PrintableToString(NULL);

		// Copy the buffer into B4R's managed memory
		pm.print(buf);

		// Ensure null termination in the shared buffer
		StackMemory::buffer[StackMemory::cp++] = 0;

		// Return the B4R-managed string
		return s;
	}

	/*
	 * @note Each byte becomes 2 hex characters. 
	 *       A 16-byte array → 32-char hex string (+1 for null terminator).
	 * @note Uses B4R's StackMemory for temporary storage.
	 *       The returned string is only valid until the next StackMemory operation.
	 */
	B4RString* B4RAdafruitMCP23X17::ByteArrayToHex(ArrayByte* b) {
		static const char HEXCHARS[] = "0123456789ABCDEF";

		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);

		// Guard: null or empty array -> return empty string
		if (b == NULL || b->length == 0) {
			pm.print("");
			StackMemory::buffer[StackMemory::cp++] = 0;
			return s;
		}

		// Convert bytes one-by-one, writing directly into StackMemory via pm.print
		byte* dataBytes = (byte*) b->data;
		for (UInt i = 0; i < b->length; i++) {
			char tmp[3];
			tmp[0] = HEXCHARS[dataBytes[i] >> 4];
			tmp[1] = HEXCHARS[dataBytes[i] & 0x0F];
			tmp[2] = '\0';
			pm.print(tmp);
		}

		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}

}
