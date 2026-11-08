#include "B4RDefines.h"
namespace B4R
{
	bool B4RESP32LEDControl::Initialize(Byte pin, ULong frequency, Byte resolution){
		bool success = true;

		// Assign the parameter to the private vars
		_pin = pin;
		_frequency = frequency;
		_resolution = resolution;

		// Check resolution and frequency in range (see globals)
		_resolution = resolution;
		if (resolution < RESOLUTION_MIN || resolution > RESOLUTION_MAX) {
			_resolution = RESOLUTION_DEFAULT;			
			::Serial.println("[WARNING][Initialize] Resolution out of range. Default set.");
		}

		_frequency = frequency;			
		if (frequency < FREQUENCY_MIN || frequency > FREQUENCY_MAX) {
			_frequency = FREQUENCY_DEFAULT;			
			::Serial.println("[WARNING][Initialize] Frequency out of range. Default set.");
		}

		// Setup LED pin with given frequency and resolution. LED channel will be selected automatically.
		// New API (ESP32 Arduino Core 3.x+)
		success = ledcAttach(_pin, _frequency, _resolution);
		if (!success) {
			::Serial.println("[ERROR][Initialize] Can not setup the LED pin. Check pin number.");
			return success;
		}

		return success;
	}

	// pin-based instead of channel-based
	void B4RESP32LEDControl::Write(Byte value) {
		_duty = value;
		ledcWrite(_pin, value);
	}

	/**
	 * Set brightness as percentage (0-100%).
	 */
	void B4RESP32LEDControl::WritePercentage(Byte percent) {
		if (percent > 100) percent = 100;
		Byte value = (Byte)((percent / 100.0) * DUTY_MAX);
		Write(value);
	}

	void B4RESP32LEDControl::setDutyCycle(Byte value) {
		Write(value);
	}

	Byte B4RESP32LEDControl::getDutyCycle() { 
		return _duty; 
	}

	/**
	 * On, Off
	 */

	bool B4RESP32LEDControl::IsOn() {
		return _duty > DUTY_MIN;
	}

	void B4RESP32LEDControl::On(void){
		Write(DUTY_MAX);
	}	

	void B4RESP32LEDControl::Off(void){
		Write(DUTY_MIN);
	}	

}
