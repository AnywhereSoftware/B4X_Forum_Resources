/**
 * rESP32Servo.cpp
 * Source of the B4R library to control servo motors attached to ESP32 (only).
 */

#include "B4RDefines.h"
namespace B4R {
	
	Byte B4RESP32Servo::Attach(int pin) {
		return servo.attach(pin);
	}

	Byte B4RESP32Servo::Attach2(int pin, int minValue, int maxValue) {
		return servo.attach(pin, minValue, maxValue);
	}

	void B4RESP32Servo::Detach(){
		servo.detach();
	}

	void B4RESP32Servo::Write(int value){
		servo.write(value);
	}

	void B4RESP32Servo::WriteMicroseconds(int value){
		servo.writeMicroseconds(value);
	}

	void B4RESP32Servo::WriteTicks(int value){
		servo.writeTicks(value);
	}

	int B4RESP32Servo::Read(){
		return servo.read();
	}

	int B4RESP32Servo::ReadMicroseconds() {
		return servo.readMicroseconds();
	}

	int B4RESP32Servo::ReadTicks(){
		return servo.readTicks();
	}

	bool B4RESP32Servo::Attached() {
		return servo.attached();
	}

	void B4RESP32Servo::setTimerWidth(int value) {
		servo.setTimerWidth(value);
	}
	int B4RESP32Servo::getTimerWidth() {
		return servo.readTimerWidth();
	}

}
