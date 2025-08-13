#pragma once
#include "B4RDefines.h"

//~Library: rESP32RGBLEDC
//~Author: Robert W.B. Linn
//~Brief: B4R library to control an RGB LED connected to ESP32 PWM pins. Uses the Arduino-ESP32 LEDC API.
//~Dependencies: built-in official ESP32 LEDC API.
//~Version: 1.0
//~Built: 20250210
namespace B4R
{
	//~shortname: ESP32RGBLEDC
	class B4RESP32RGBLEDC
	{
		private:
			String version = "20250210";
			
			// Define the RGB LED Pins
			Byte RedPin;
			Byte GreenPin;
			Byte BluePin;
			
			// RGB LED Pins Duty Cycle 0 (off) - 255 (on)
			Byte RedDuty;
			Byte GreenDuty;
			Byte BlueDuty;
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
			* Initialize RGB LEDC pins for Red, Yellow, Green with given frequency and resolution. LEDC channel will be selected automatically.
			* Ensure to use ESP32 PWM pins, like GPIO 25,26,27.
			* redpin - LEDC pin for RED.
			* greenpin - LEDC pin for GREEN.
			* bluepin - LEDC pin for BLUE.
			* frequency - frequency of pwm.
			* resolution - resolution for LEDC channel (1-20 bits for ESP32).
			* Returns true (OK) or false (error).
			* Example (Private rgb As ESP32RGBLEDC):<code>
			* Dim result As Boolean = rgb.Initialize(redPin, greenPin, bluePin, RGB.FREQUENCY_DEFAULT, RGB.RESOLUTION_DEFAULT)
			* If Not(result) Then
			*	Log("[ERROR][Initialize] RGB LEDC not initialized. Check log.")
			*	Return
			* End If
			* </code>
			*/
			bool Initialize(Byte redpin, Byte greenpin, Byte bluepin, ULong frequency, Byte resolution);

			/**
			* Set the RGB color. Ensure to set in range 0-255 prior calling this function..
			* red - led dutycycle 0-255.
			* green - led dutycycle 0-255.
			* blue - led dutycycle 0-255.
			* Returns true (OK) or false (error).
			* Example (Private rgb As ESP32RGBLEDC):<code>
			* 'Set RGB color to yellow
			* RGB.SetColor(255,255,0)
			* </code>
			*/
			bool SetColor(Byte red, Byte green, Byte blue);

			/**
			* Get the dutycycle (color setting range 0-255) for each of the RGB LEDs.
			* Returns an Array of Byte.
			* Example (Private rgb As ESP32RGBLEDC):<code>
			* Dim colors(3) As Byte = rgb.GetColor
			* Log("[GetColor] r=",colors(0),",g=",colors(1),",b=",colors(2))
			* '[GetColor] r=255,g=255,b=0
			* </code>
			*/
			ArrayByte* GetColor(void);

			/**
			* Set or get the dutycycle of the RED LED.
			* Example (Private rgb As ESP32RGBLEDC):<code>
			* 'Set RED LED dutycycle (color) to 100
			* rgb.Red = 100
			* 'Get the dutycycle of the RED LED
			* Log(rgb.Red) returning value 100 (must be between 0-255)
			* </code>
			*/
			void setRed(Byte duty);
			Byte getRed();

			/**
			* Set or get the dutycycle of the GREEN LED.
			* Example (Private rgb As ESP32RGBLEDC):<code>
			* 'Set GREEN LED dutycycle (color) to 100
			* rgb.Green = 100
			* 'Get the dutycycle of the GREEN LED
			* Log(rgb.Green) returning value 100 (must be between 0-255)
			* </code>
			*/
			void setGreen(Byte duty);
			Byte getGreen();

			/**
			* Set or get the dutycycle of the BLUE LED.
			* Example (Private rgb As ESP32RGBLEDC):<code>
			* 'Set BLUE LED dutycycle (color) to 100
			* rgb.Blue = 100
			* 'Get the dutycycle of the BLUE LED
			* Log(rgb.Blue) returning value 100 (must be between 0-255)
			* </code>
			*/
			void setBlue(Byte duty);
			Byte getBlue();

			/**
			* Turn RGB Off.
			*/
			void Off(void);
	
			/**
			* Turn RGB On color white with max dutycycle 255.
			*/
			void On(void);

			/**
			* Get the library version.
			* Example (Private rgb As ESP32RGBLEDC):<code>
			* Log(rgb.Version)
			* '20250210
			* </code>
			*/
			B4RString* getVersion(void);

	};
}