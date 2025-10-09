/**
 * rAdafruitPWMServoDriver.cpp
 * Source of the B4R library rAdafruitPWMServoDriver.
 */

#include "B4RDefines.h"
namespace B4R {

	void B4RAdafruitPWMServoDriver::Initialize() {
		// New instance
		pwm = new (beAdafruitPWMServoDriver) Adafruit_PWMServoDriver();
		pwm->begin();
		
		// Init the angle for all channels with -1 (UNKNOWN), min 0°, max 180°.
		// This does not set the servo angle.
		int channel;
		for (channel=0;channel<CHANNELS;channel++) {
			servoAngles[channel] = ANGLE_UNKNOWN;
			servoMinAngles[channel] = ANGLE_MIN;
			servoMaxAngles[channel] = ANGLE_MAX;
		}
	}

	void B4RAdafruitPWMServoDriver::Initialize2(const Byte addr){
		pwm = new (beAdafruitPWMServoDriver) Adafruit_PWMServoDriver(addr);
		pwm->begin();
	}

	void B4RAdafruitPWMServoDriver::Initialize3(const Byte addr, TwoWire &i2c){
		pwm = new (beAdafruitPWMServoDriver) Adafruit_PWMServoDriver(addr, i2c);
		pwm->begin();
	}
	
	void B4RAdafruitPWMServoDriver::Reset() {
		pwm->reset();
	}

	void B4RAdafruitPWMServoDriver::Sleep() {
		pwm->sleep();
	}

	void B4RAdafruitPWMServoDriver::Wakeup() {
		pwm->wakeup();
	}

	void B4RAdafruitPWMServoDriver::SetExtClk(Byte prescale) {
		pwm->setExtClk(prescale);
	}

	void B4RAdafruitPWMServoDriver::SetPWMFreq(float freq) {
		pwm->setPWMFreq(freq);
	}

	void B4RAdafruitPWMServoDriver::SetOutputMode(bool totempole) {
		pwm->setOutputMode(totempole);
	}

	UInt B4RAdafruitPWMServoDriver::GetPWM(Byte channel, bool off) {
		if (!IsChannel(channel)) return -1; 
		return pwm->getPWM(channel, off);
	}

	Byte B4RAdafruitPWMServoDriver::SetPWM(Byte channel, UInt on, UInt off) {
		if (!IsChannel(channel)) return 0; 
		pwm->setPWM(channel, on, off);
	}

	void B4RAdafruitPWMServoDriver::SetPin(Byte channel, UInt val, bool invert) {
		if (!IsChannel(channel)) return; 
		pwm->setPin(channel, val, invert);
	}

	Byte B4RAdafruitPWMServoDriver::ReadPrescale(void) {
		pwm->readPrescale();
	}

	void B4RAdafruitPWMServoDriver::WriteMicroseconds(Byte channel, UInt microseconds) {
		if (!IsChannel(channel)) return; 
		pwm->writeMicroseconds(channel, microseconds);
	}

	void B4RAdafruitPWMServoDriver::setOscillatorFrequency(ULong freq) {
		pwm->setOscillatorFrequency(freq);
	}
	
	ULong B4RAdafruitPWMServoDriver::getOscillatorFrequency(void) {
		return pwm->getOscillatorFrequency();
	}

	/**
	 * Custom Functions
	 */

	bool B4RAdafruitPWMServoDriver::IsChannel(int channel) {
		return (channel >= 0 && channel < CHANNELS);
	}

	void B4RAdafruitPWMServoDriver::EnablePWM(Byte channel) {
		if (!IsChannel(channel)) return; 
		
		UInt angle = servoAngles[channel];

		// Clamp angle in case of corruption
		if (angle < ANGLE_MIN) angle = ANGLE_MIN;
		if (angle > ANGLE_MAX) angle = ANGLE_MAX;

		// Convert angle → pulse length (ticks)
		UInt pulselen = AngleToPulse(angle);

		pwm->setPWM(channel, 0, pulselen);
		delay(MOVE_DELAY);
	}

	void B4RAdafruitPWMServoDriver::DisablePWM(Byte channel) {
		if (!IsChannel(channel)) return; 
		
		pwm->setPWM(channel, 0, 0);
		delay(MOVE_DELAY);
	}

	void B4RAdafruitPWMServoDriver::SetLimits(Byte channel, UInt minAngle, UInt maxAngle) {
		if (!IsChannel(channel)) return; 
		
		servoMinAngles[channel] = minAngle;
		servoMaxAngles[channel] = maxAngle;
	}

	int B4RAdafruitPWMServoDriver::SetAngle(Byte channel, UInt angle, bool disable) {
		if (!IsChannel(channel)) return -1; 
		
		UInt minangle = servoMinAngles[channel];
		UInt maxangle = servoMaxAngles[channel];
		
		if (angle < minangle) {
			angle = minangle;
		}
		if (angle > maxangle) {
			angle = maxangle;
		}

		// Store the last commanded angle
		servoAngles[channel] = angle;
		
		// Convert angle to pulse microseconds
		UInt pulselen = AngleToPulse(angle);
		
		// Set the pwm value for the channel
		pwm->setPWM(channel, 0, pulselen);
		delay(MOVE_DELAY);
		
		// Disable PWM
		if (disable) {
			DisablePWM(channel);
		}
		
		return pulselen;
	}

	int B4RAdafruitPWMServoDriver::GetAngle(Byte channel) {
		// invalid channel
		if (!IsChannel(channel)) return -1; 
		return servoAngles[channel];
	}

	UInt B4RAdafruitPWMServoDriver::AngleToPulse(UInt angle) {
		return map(angle, ANGLE_MIN, ANGLE_MAX, SERVO_MIN, SERVO_MAX);
	}

	UInt B4RAdafruitPWMServoDriver::PulseToAngle(UInt microseconds) {
		return map(microseconds, SERVO_MIN, SERVO_MAX, ANGLE_MIN, ANGLE_MAX);
	}

}
