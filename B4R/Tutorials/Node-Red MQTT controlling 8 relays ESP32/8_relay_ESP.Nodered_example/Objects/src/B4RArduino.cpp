#include "B4RDefines.h"

namespace B4R {

	void Pin::Initialize(Byte Pin, Byte Mode) {
		this->PinNumber = Pin;
		setMode(Mode);
	}
	void Pin::setMode(Byte arduino_Mode) {
// #ifdef _VARIANT_ARDUINO_STM32_
		// WiringPinMode stm32_Mode;
		// switch (arduino_Mode) {
			// case INPUT:
				// stm32_Mode = INPUT;
				// break;
			// case OUTPUT:
				// stm32_Mode = OUTPUT;
				// break;
			// case INPUT_PULLUP:
				// stm32_Mode = INPUT_PULLUP;
				// break;
		// }
		// pinMode(PinNumber, stm32_Mode);
// #else
		pinMode(PinNumber, arduino_Mode);
// #endif
		if (arduino_Mode == INPUT_PULLUP)
			CurrentValue = true;
    }
	void Pin::AddListener(SubVoidBool Event) {
		this->Event = Event;
		FunctionUnion fu;
		fu.PollerFunction = loop;
		pollers.add(fu, this);
	}
	bool Pin::DigitalRead() {
		return digitalRead(PinNumber);
	}
	UInt Pin::AnalogRead() {
		return analogRead(PinNumber);
	}
	void Pin::AnalogWrite(UInt Value) {
  #ifndef ESP32
		analogWrite(PinNumber, Value);
  #endif
	}
	void Pin::DigitalWrite(bool Value) {
		digitalWrite(PinNumber, Value);
	}

	void Pin::loop(void* b) {
		Pin* pi = (Pin*)b;
		bool newValue = digitalRead(pi->PinNumber);
		if (newValue != pi->CurrentValue) {
			sender->wrapPointer(pi);
			pi->CurrentValue = newValue;
			pi->Event(newValue);
		}
	}
	  
	
	void Serial::Initialize (ULong BaudRate){
	#ifdef B4R_SERIAL
		stream.wrappedStream = &::Serial;
		::Serial.begin(BaudRate);
		while (!::Serial) {
			; 
		}
	#endif
	}
	void Serial::Close (){
	#ifdef B4R_SERIAL
		::Serial.end();
	#endif
	}
	B4RStream* Serial::getStream() {
		return &stream;
	}
	
	
	
	static union FunctionUnion fncu;
	void Timer::Initialize(void (*Event) (void), ULong Interval) {
		fncu.TimerFunction = tick;
		this->event = Event;
		this->Interval = Interval;
	}
	void Timer::setEnabled(bool e) {
		if (enabled == e)
			return;
		enabled = e;
		if (enabled) {
			counter++;
			scheduler.add(millis() + Interval, fncu, counter, this);
		}
	}
	bool Timer::getEnabled() {
		return enabled;
	}
	void Timer::tick(byte tag, void* target) {
		Timer* me = (Timer*)target;
		if (me->counter != tag || me->enabled == false)
			return;
		scheduler.add(millis() + me->Interval, fncu, me->counter, me);
		me->event();
	}
	
}

