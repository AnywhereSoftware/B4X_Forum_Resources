/**
 * File:		rESP32Servo.h
 * Brief:		B4R library to control servo motors attached to ESP32 (only).
 * Dependson:	Arduino library ESP32Servo - must be installed in the Arduino IDE.
 * Author:		Robert W.B. Linn.
 * Date:		2025-08-21
 * License:		MIT
 * Copyright © 2025 Robert W.B. Linn. All rights reserved.
 *
 * Notes:		Functions not wrapped:
 *				void setPeriodHertz(int Hertz);
 */

#pragma once
#include "B4RDefines.h"
#include <ESP32Servo.h>

namespace B4R {
	//~Version: 1.0
	//~shortname: ESP32Servo
	class B4RESP32Servo {
		private:
			Servo servo;

		public:
			/**
			 * Attaches the servo to the specified pin.
			 * Returns 0 in case of a failure.
			 * Recommended GPIO pins:
			 * ESP32: 2,4,12-19,21-23,25-27,32-33
			 * ESP32-S2: 1-21,26,33-42
			 * ESP32-S3: 1-21,35-45,47-48
			 * ESP32-C3: 1-10,18-21
			 */
			Byte Attach(int pin);
			
			/**
			 * Attaches the servo to the specified pin.
			 * Returns 0 if there was a failure.
			 * MinValue and MaxValue set the minimum and maximum pulse width that will be sent to the servo.
			 */
			Byte Attach2(int pin, int minValue, int maxValue);
			
			/**
			 * Detaches the servo pin.
			 */
			void Detach();

			/**
			 * Set servo angle.
			 * If the value is smaller than 200 then it is treated as an angle. 
			 * Otherwise it is treated as pulse width in microseconds.
			 */
			void Write(int value);
						
			/**
			 * Writes pulse width in microseconds.
			 */
			void WriteMicroseconds(int value);

			/**
			 * Write ticks, the smallest increment the servo can handle.
			 */
			void WriteTicks(int value);
			
			/**
			 * Returns current pulse width as an angle between 0 to 180 degrees.
			 */
			int Read();
			
			/**
			 * Returns current pulse width in microseconds.
			 */
			int ReadMicroseconds();
			
			/**
			 * Returns current ticks, the smallest increment the servo can handle.
			 */
			int ReadTicks();
			
			/**
			 * Returns true if the servo is attached.
			 */
			bool Attached();

			// ESP32 only functions
			
			/**
			 * Set or get the PWM timer width (ESP32 ONLY).
			 */
			void setTimerWidth(int value);
			int getTimerWidth();

	};
	
}