#include "B4RDefines.h"
namespace B4R
{
	bool B4RESP32RGBLEDC::Initialize(Byte pinred, Byte pingreen, Byte pinblue, ULong frequency, Byte resolution){
		bool success = true;

		//Assign the led pins to the private vars
		RedPin		= pinred;
		GreenPin	= pingreen;
		BluePin 	= pinblue;

		// Check resolution and frequency in range (see globals)
		if (resolution < RESOLUTION_MIN || resolution > RESOLUTION_MAX) {
			::Serial.println("[WARNING][Initialize] Resolution out of range. Default set.");
			resolution = RESOLUTION_DEFAULT;			
		}
		if (frequency < FREQUENCY_MIN || frequency > FREQUENCY_MAX) {
			::Serial.println("[WARNING][Initialize] Frequency out of range. Default set.");
			frequency = FREQUENCY_DEFAULT;			
		}

		// Setup LEDC pin with given frequency and resolution. LEDC channel will be selected automatically.
		success = ledcAttach(RedPin, frequency, resolution);
		if (!success) {
			::Serial.println("[ERROR][Initialize] Can not setup the RGB RED LEDC pin. Check pin number.");
			return success;
		}
		
		success = ledcAttach(GreenPin , frequency, resolution);
		if (!success) {
			::Serial.println("[ERROR][Initialize] Can not setup the RGB GREEN LEDC pin. Check pin number.");
			return success;
		}
		
		success = ledcAttach(BluePin, frequency, resolution);
		if (!success) {
			::Serial.println("[ERROR][Initialize] Can not setup the RGB BLUE LEDC pin. Check pin number.");
			return success;
		}

		//Turn rgb off
		Off();

		return success;
	}

	bool B4RESP32RGBLEDC::SetColor(Byte red, Byte green, Byte blue){
		bool success = true;

		// If a byte gets a higher value, then it will rollover.
		// Must be checked by B4R if in range 0 (DUTY_MIN) - 255 (DUTY_MAX) prior calling this function.
		
		// Assign the given dutycycle to the globals
		RedDuty = red;
		GreenDuty = green;
		BlueDuty = blue;

		// Set duty for each of the RGB LEDC pins.
		success = ledcWrite(RedPin, RedDuty);
		if (!success) {
			::Serial.println("[ERROR][SetColor] Can not write to RGB RED LEDC pin. Check wiring.");
			return success;
		}

		success = ledcWrite(GreenPin, GreenDuty);
		if (!success) {
			::Serial.println("[ERROR][SetColor] Can not write to RGB GREEN LEDC pin. Check wiring.");
			return success;
		}

		success = ledcWrite(BluePin, BlueDuty);
		if (!success) {
			::Serial.println("[ERROR][SetColor] Can not write to RGB BLEU LEDC pin. Check wiring.");
			return success;
		}

		return success;
				
	}	

	ArrayByte* B4RESP32RGBLEDC::GetColor(void) {
		UInt Length = 3;
		Array* arr = CreateStackMemoryObject(Array);
		arr->data = StackMemory::buffer + StackMemory::cp;
		StackMemory::cp += Length;
		arr->length = Length;

		// Assign the globals containing the dutycycle for each of the RGB LEDs to the array.
		((Byte*)arr->data)[0] = RedDuty;
		((Byte*)arr->data)[1] = GreenDuty;
		((Byte*)arr->data)[2] = BlueDuty;
		return arr;
	}

	/**
	* Getter, setter for each of the RGB LEDs
	*/
	
	void B4RESP32RGBLEDC::setRed(Byte duty){
		SetColor(duty, DUTY_MIN, DUTY_MIN);
	}
	Byte B4RESP32RGBLEDC::getRed(){
		return RedDuty;
	}

	void B4RESP32RGBLEDC::setGreen(Byte duty){
		SetColor(DUTY_MIN, duty, DUTY_MIN);
	}
	Byte B4RESP32RGBLEDC::getGreen(){
		return GreenDuty;
	}

	void B4RESP32RGBLEDC::setBlue(Byte duty){
		SetColor(DUTY_MIN, DUTY_MIN, duty);
	}
	Byte B4RESP32RGBLEDC::getBlue(){
		return GreenDuty;
	}

	/**
	* Off, On
	*/

	void B4RESP32RGBLEDC::Off(void){
		SetColor(DUTY_MIN, DUTY_MIN, DUTY_MIN);
	}	
	void B4RESP32RGBLEDC::On(void){
		SetColor(DUTY_MAX, DUTY_MAX, DUTY_MAX);
	}	

	/**
	* Various
	*/

	B4RString* B4RESP32RGBLEDC::getVersion(void){
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(version);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}

}
