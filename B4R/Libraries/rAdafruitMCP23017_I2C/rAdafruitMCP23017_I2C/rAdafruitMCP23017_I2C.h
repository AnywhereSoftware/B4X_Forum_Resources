/**
 * File:        rAdafruitMCP23017_I2C.h
 * Brief:       B4R library partial wrapper for the Adafruit MCP23008/17 I2C and MCP23S08/17 SPI Port Expanders library.
 *              Wrapped are the function for the MCP23017 I2C.
 *              Based on the Adafruit MCP23017 Arduino Library:
 *              https://github.com/adafruit/Adafruit-MCP23017-Arduino-Library?tab=readme-ov-file
 *
 * Original Library (Adafruit):
 *   Copyright (c) 2012 Adafruit Industries
 *   Licensed under the BSD 3-Clause License
 *   (see LICENSE file in the original repository).
 *
 * This Wrapper (B4R):
 *   Wraps only the MCP23017 I2C Functions.	
 *   Enhancements for B4R integration:
 *     - <ADD>
 *   Requires Adafruit MCP23017 Arduino Library v2.3.2 or higher (install via Arduino IDE Library Manager).
 *
 * Author (Wrapper): Robert W.B. Linn
 * Date:            2025-09-09
 *
 * License for this wrapper: MIT
 *   Copyright © 2025 Robert W.B. Linn
 *   Permission is hereby granted, free of charge, to use, copy, modify, merge,
 *   publish, distribute, sublicense, and/or sell copies of this software.
 *
 * Note: The Adafruit library remains under the BSD license.
 *       This wrapper code is MIT licensed. When distributing, both licenses apply.
 */

#pragma once
#include "B4RDefines.h"

// Including arduino header for constants like OUTPUT, INPUT, HIGH etc.
// #include <Arduino.h>

// Including Adafruit_MCP23XXX.h header to have access to all MCP23XXX variants.
// Note: only MCP23017 I2C functions are wrapped.
// #include <Adafruit_MCP23XXX.h>
#include <Adafruit_MCP23X17.h>

namespace B4R {
    //~Version: 1.0
    //~shortname: AdafruitMCP23017_I2C
	//~event: StateChanged (InputPin As Byte, State As Boolean)

	// Input pin state definition used by the event StateChanged.
	typedef void (*SubVoidPinState)(Byte inputpin, bool state);

    /**
     * @class AdafruitMCP23017
     * @brief Wrapper class that exposes the Adafruit MCP23017 expander MCP23017 to B4R.
	 *        Enhanced with custom constants & functions.
     */
    class B4RAdafruitMCP23X17 {

        private:
            /** Internal buffer to hold the Adafruit_MCP23017 instance based upon MCP23XXX. */
            Byte beAdafruitMCP23X17[sizeof(Adafruit_MCP23X17)];

			/** Pin mode array. */
			Byte pinModes[16];

			/** Pin state array. */
			Byte pinStates[16];

			/** Event statechanged used by 2 loopers. */
			SubVoidPinState StateChangedSub;
			static void looperdebouncepolling(void* b);	// must be static
			static void looperinterrupt(void* b);		// must be static
			PollerNode pnode;
			ULong lastCheck = 0;			

			// Debounce support
			Byte lastReadStates[16];       				// last raw read
			ULong lastChangeTime[16];      				// last time a change was detected

			// Hardware interrupt pin on MCU
            Byte intPin = 255; 					// 255 = not used	
			
        public:
		
            /** Pointer to the underlying Adafruit MCP23XXXX object. */
            //~hide
            Adafruit_MCP23X17* mcp;

			/**
			 * Initialize MCP using I2C with default I2C address 0x20.
			 * @return true if initialization successful, otherwise false.
             */
            bool Initialize();

			/**
			 * Initialize MCP using I2C with custom I2C address.
			 * Example: 0x27 = MCP23017 module has the address jumpers A0/A1/A2 pulled high.
			 * @param i2c_addr I2C address.
			 * @return true if initialization successful, otherwise false.
             */
            bool Initialize2(Byte addr);

			/**
			 * Configures the specified pin to behave either as an input or an output.
			 * @param pin the Arduino pin number to set the mode of.
			 * @param mode INPUT, OUTPUT, or INPUT_PULLUP.
			 */
			void SetPinMode(Byte pin, Byte mode);

			/**
			 * Get the specified pin mode.
			 * @param pin the Arduino pin number to get the mode of.
			 * @param mode INPUT, OUTPUT, or INPUT_PULLUP.
			 */
			Byte GetPinMode(Byte pin);

			/**
			 * Reads the value from a specified digital pin, either HIGH or LOW.
			 * @param pin the Arduino pin number you want to read.
			 * Returns - HIGH or LOW
			 */
			Byte DigitalRead(Byte pin);

			/**
			 *
			 */
			void DigitalWrite(Byte pin, Byte value);

			/**
			 * Bulk read all pins on a port.
			 * @param port 0 for Port A, 1 for Port B (MCP23X17 only).
			 * Returns - current pin states of port as a uint8_t.
			 */
			Byte ReadGPIO(Byte port);

			/**
			 * Bulk write all pins on a port.
			 * @param value pin states to write as a uint8_t.
			 * @param port 0 for Port A, 1 for Port B (MCP23X17 only).
			 */
			void WriteGPIO(Byte value, Byte port);

			/**
			 * Interrupts
			 */

			/**
			 * Configure the interrupt system.
			 * @param mirroring true to OR both INTA and INTB pins.
			 * @param openDrain true for open drain output, false for active drive output.
			 * @param polarity HIGH or LOW
			 */
			void SetupInterrupts(bool mirroring, bool openDrain, Byte polarity);

			/**
			 * Enable interrupt and set mode for given pin.
			 * @param pin Pin to enable.
			 * @param mode CHANGE, LOW, HIGH
			 */
			void SetupInterruptPin(Byte pin, Byte mode);
			
			/**
			 * Disable interrupt for given pin.
			 * @param pin Pin to disable.
			 */
			void DisableInterruptPin(Byte pin);

			/**
			 * Clear interrupts. NOTE:If using DEFVAL, INT clears only if interrupt
			 * condition does not exist. See Fig 1-7 in datasheet.
			 */
			void ClearInterrupts();
			
			/**
			 * Gets the pin that caused the latest interrupt, from INTF, without
			 * clearing any interrupt flags.
			 * Returns - Pin that caused lastest interrupt.
			 */
			Byte GetLastInterruptPin();

			/**
			 * Get pin states captured at time of interrupt.
			 * Returns - Multi-bit value representing pin states.
			 */
			UInt GetCapturedInterrupt();

			/**
			 * Custom Functions
			 */

			/**
			 * Add input handler for the input/input_pullup pins.
			 * The Input_StateChanged in B4R only sees clean transitions:
			 * Button press > 1 clean LOW event.
			 * Button release > 1 clean HIGH event.
			 * No multiple toggles caused by bouncing contacts.
			 */
			void AddInputHandler(SubVoidPinState StateChangedSub);

			/**
             * Attach MCP pin interrupt with MCU pin for INTA/B.
			 * intPin - Interrupt pin INTA or INTB.
			 * buttonPin - Button pin GPA0-7 or GPB0-GPB7.
			 * StateChangedSub - Event name handling the input state change.
			 */
            void AttachInterrupt(Byte intPin, Byte buttonPin, SubVoidPinState StateChangedSub);

			/**
			 * Convert a single byte into a 2-character uppercase hexadecimal string.
			 *
			 * This helper is useful for logging or debugging register values, I2C data, etc.
			 * It returns a B4R-managed string (B4RString*) so it can be directly used inside
			 * B4R code (e.g. Log, concatenation, publishing to MQTT).
			 *
			 * b - The byte to convert (0–255).
			 * Returns - B4RString* Managed string containing the 2-digit hex representation,
			 *           e.g. 0x0A -> "0A", 0xFF -> "FF".
			 */
			B4RString* ByteToHex(Byte b);

			/**
			 * Convert a byte array into a continuous uppercase hexadecimal string.
			 *
			 * This helper is useful for logging or publishing raw data arrays (e.g. I2C, SPI,
			 * BLE, or MQTT payloads) in a human-readable format.
			 *
			 * Example:
			 *   Input:  [0x12, 0xAB, 0x00]
			 *   Output: "12AB00"
			 *
			 * data - Pointer to the byte array.
			 * length - Number of bytes in the array.
			 * Returns - B4RString* Managed B4R string with the hex representation.
			 */
			B4RString* ByteArrayToHex(ArrayByte* b);

            /**
             * Constants
             */

			/** Default I2C Address. */
			#define /*Byte MCP23XXX_ADDR;*/ AdafruitMCP23017_MCP23XXX_ADDR 0x20

			// Following constants defined as vars to be able to use in the .cpp.
			
			/** Pin modes output, input, input pullup. */
			static const Byte MODE_OUTPUT = OUTPUT;
			static const Byte MODE_INPUT = INPUT;
			static const Byte MODE_INPUT_PULLUP	= INPUT_PULLUP;

			/** Pin states change, high or low. */
			static const Byte STATE_CHANGE = CHANGE;
			static const Byte STATE_HIGH = HIGH;
            static const Byte STATE_LOW = LOW;
			
			/** Number of pins 16 (0-15). */
			static const Byte PINS = 0x10;

			/** Pin codes. */
			static const Byte PIN_PA0 = 0;
			static const Byte PIN_PA1 = 1;
			static const Byte PIN_PA2 = 2;
			static const Byte PIN_PA3 = 3;
			static const Byte PIN_PA4 = 4;
			static const Byte PIN_PA5 = 5;
			static const Byte PIN_PA6 = 6;
			static const Byte PIN_PA7 = 7;
			static const Byte PIN_PB0 = 8;
			static const Byte PIN_PB1 = 9;
			static const Byte PIN_PB2 = 10;
			static const Byte PIN_PB3 = 11;
			static const Byte PIN_PB4 = 12;
			static const Byte PIN_PB5 = 13;
			static const Byte PIN_PB6 = 14;
			static const Byte PIN_PB7 = 15;
			
    };
    
}
