#pragma once
#include "B4RDefines.h"

//~Library: rESP32LEDControl
//~Author: Robert W.B. Linn
//~Brief: B4R library to control an LED connected to an ESP32 using the Arduino-ESP32 LEDC API (using pin and not channel).
//~Dependencies: built-in official ESP32 LEDC API.
//~Version: 1.0
//~Built: 20250613

// Notes
// For non-blocking fade-in/out effects, use B4R's CallSubPlus and a custom timer loop in your B4R code.
// Example in B4R:
//   CallSubPlus("FadeStep", 20, 0)

namespace B4R
{
	//~shortname: ESP32LEDControl
	class B4RESP32LEDControl
	{
		private:
			
			Byte _pin;			// LED Pin number
			Byte _duty;			// LED Pin Duty Cycle 0 (off) - 255 (on)
			ULong _frequency;
			Byte _resolution;

		public:
			
			/**
			* Static Constants
			*/
			
			// DutyCycle min and max
			Byte DUTY_MIN = 0;
			Byte DUTY_MAX = 255;

			// PWM Frequency with default (5000Hz), min (10Hz) and max 40MHz (40000000Hz)
			ULong FREQUENCY_DEFAULT = 5000;
			ULong FREQUENCY_MIN = 10;
			ULong FREQUENCY_MAX = 40000000;

			// Resolution for ESP32 specific with default 8, min 1 and max 20 bits
			Byte RESOLUTION_DEFAULT = 8;
			Byte RESOLUTION_MIN = 1;
			Byte RESOLUTION_MAX = 20;

			/**
			 * Initialize LEDC pin with given frequency and resolution.
			 * PWM is not available on all ESP32 pins. Pins like 0, 2, 4, 12–15, 25–27, 32–33 are safe for LEDC.
			 * pin - LEDC pin.
			 * frequency - frequency of pwm.
			 * resolution - resolution for LEDC channel (1-20 bits for ESP32).
			 * Returns true (OK) or false (error).
			 * Example (Private led As ESP32LEDControl):<code>
			 * Dim result As Boolean = led.Initialize(ledpin, ledc.FREQUENCY_DEFAULT, ledc.RESOLUTION_DEFAULT)
			 * If Not(result) Then
			 *	Log("[ERROR][Initialize] LED not initialized. Check log.")
			 *	Return
			 * End If
			 * </code>
			 */
			bool Initialize(Byte pin, ULong frequency, Byte resolution);

			/**
			 * Set the value of the LED.
			 * value - dutycycle 0-255.
			 * Returns true (OK) or false (error).
			 * Example (Private led As ESP32LEDControl):<code>
			 * led.Write(255)
			 * </code>
			 */
			void Write(Byte value);

			/**
			 * Set brightness as percentage (0-100%).
			 */
			void WritePercentage(Byte percent);

			/**
			 * Turn LED Off.
			 */
			void Off(void);
	
			/**
			 * Turn LED On with max dutycycle 255.
			 */
			void On(void);
			
			/**
			 * Check if the LED is on.
			 * Returns true (On) or false (Off).
			 */
			bool IsOn();

			/**
			 * Get or Set the actual duty cycle.
			 * duty - between 0-255.
			 */
			void setDutyCycle(Byte value);
			
			/**
			 * Get the actual duty cycle.
			 * Returns value between 0-255.
			 */
			Byte getDutyCycle();
			
	};
}