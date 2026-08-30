#pragma once
/**
 * @file rOneWireEx.h
 * @brief B4R C++ wrapper for the OneWire library optimized for ESP32.
 * @note This B4R Library is wrapped from the native Arduino OneWire library to fix strict execution timing and macro conflicts.
 * @note The B4R library rOneWire is used as a base (thanks to author).
 * @note This B4R library depends on the OneWire library installed using the Arduino IDE.
 * @note Tested with the DS18B20 Dallas Temperature Sensor.
 * @version 1.0
 * @date 2026-08-26
 * @author Robert W. B. Linn (c) 2026 — MIT License
 */

#include "B4RDefines.h"
// Installed using the Arduino IDE.
#include <OneWire.h>

//~version: 1.0
namespace B4R {
	//~shortname: OneWireEx
	class B4ROneWireEx {
		private:
			
			uint8_t beOneWire[sizeof(OneWire)];
			OneWire* oneWire;	// onewire instance
			
		public:
			/**
			 * Initializes the object. Sets the OneWire pin.
			 * @param WirePin
			 */
			void Initialize(Byte WirePin);
			
			/**
			 * Searches for the next device. Returns True if a device was found.
			 * The order of devices is deterministic.
			 * @param  Address - 8 bytes array. The address of the device found will be written to this array.
			 */
			bool Search (ArrayByte* Address);
			
			/**
			 * Clears the search state. The next search will start from the beginning.
			 */
			void ResetSearch();
			
			/**
			 * Computes a Dallas Semiconductor 16 bit CRC.
			 * @param Data - Array with the bytes to checksum.
			 * @param Length - Number of bytes to use.
			 */
			UInt CRC16 (ArrayByte* Data, UInt Length);
			
			/**
			 * Computes a Dallas Semiconductor 8 bit CRC.
			 * @param Data - Array with the bytes to checksum.
			 * @param Length - Number of bytes to use.
			 */
			Byte CRC8 (ArrayByte* Data, Byte Length);
			
			/**
			 * Performs a reset function. Returns True if the device asserted a presence pulse.
			 */
			bool Reset();
			
			/**
			 * Issues a select command. This is needed after each call to Reset.
			 * @param Address
			 */
			void Select(ArrayByte* Address);
			
			/**
			 * Writes a byte.
			 * @param Value - Value to write.
			 * @param Power - Set to True if power after the write is needed.
			 */
			void Write(Byte Value, bool Power);
			
			/**
			 * Writes bytes.
			 * @param Bytes - Data to write.
			 * @param Power - Set to True if power after the write is needed.
			 */
			void WriteBytes(ArrayByte* Bytes, bool Power);
			
			/**
			 * Reads data.
			 * @param Bytes - Data will be written to this array.
			 * @param Count - Number of bytes to read.
			 */
			void ReadBytes(ArrayByte* Bytes, UInt Count);
			
			/**
			 * Skips the device selection. Useful when there is only a single device connected.
			 */
			void Skip();

			/**
			 * Scans the OneWire bus for the next available device address.
			 * 
			 * This method wraps the native `search()` mechanism. If a device is 
			 * discovered, its unique 8-byte ROM code is written directly into 
			 * the provided address buffer array.
			 * 
			 * @param address An ArrayByte pointer to a pre-allocated 8-byte buffer where the discovered address will be stored.
			 * @return True if a device address was successfully found and populated; False if no further devices responded.
			 */
			bool ReadAddress(ArrayByte* address);

			/**
			 * Reads the temperature from a specific DS18B20 sensor.
			 * 
			 * This method executes a full 1-Wire transaction block, including
			 * bus reset, device selection, conversion triggering (0x44), a 
			 * synchronous 750ms delay, and a scratchpad data read (0xBE).
			 * 
			 * @param address An ArrayByte pointer containing the unique 8-byte ROM address of the target sensor.
			 * @return The calculated temperature value in degrees Celsius. Returns -127.0 if the CRC validation check fails.
			 */
			float ReadTemperature(ArrayByte* address);

			/**
			 * Sets the internal measurement resolution of a specific sensor.
			 * 
			 * This method updates the configuration register inside the DS18B20 
			 * scratchpad non-volatile memory. Lower resolutions convert temperature 
			 * faster but with wider incremental steps.
			 * 
			 * @param address An ArrayByte pointer containing the 8-byte ROM address of the target sensor.
			 * @param resolution The desired bit resolution. Accepted values are 9, 10, 11, or 12.
			 *		  bit 9 0.5°C 93.75ms, bit 10 0.25°C 187.5ms, bit 11 0.125°C 375.0ms, bit 12 0.0625°C (Default)750.0ms
			 * @return True if the resolution configuration was successfully updated on the sensor.
			 */
			bool SetResolution(ArrayByte* address, Byte resolution);

			/**
			 * Identifies the device type from its 8-byte ROM address.
			 * 
			 * This method reads the first byte (Family Code) of the 1-Wire address.
			 * 
			 * @param address An ArrayByte pointer containing the 8-byte ROM code.
			 * @return An integer representing the device type:
			 *         1 = DS18B20, 2 = DS18S20, 3 = DS1822, 4 = MAX31820, 0 = Unknown/Other.
			 */
			Byte GetDeviceType(ArrayByte* address);

			/**
			 * Identifies the device type name from its 8-byte ROM address.
			 * 
			 * This method reads the first byte (Family Code) of the 1-Wire address.
			 * 
			 * @param address An ArrayByte pointer containing the 8-byte ROM code.
			 * @return string representing the device type name (model name):
			 *		   0x28 = DS18B20, 0x10 = DS18S20OLD, 0x22 = DS1822, 0x3B = MAX31820, 0x01 iButton Key, 0x24 = EEPROM Storage, else Unknown
			 */
			B4RString* GetDeviceTypeName(ArrayByte* address);

			/**
			 * CONSTANTS
			 */
			
			/** @brief DS1820 Resolution 9 0.5°C*/
			static const Byte RESOLUTION_9 = 9;
			/** @brief DS1820 Resolution 10 0.25°C */
			static const Byte RESOLUTION_10 = 10;
			/** @brief DS1820 Resolution 11 0.125°C */
			static const Byte RESOLUTION_11 = 11;
			/** @brief DS1820 Resolution 12 0.0625°C (default) */
			static const Byte RESOLUTION_12 = 12;

	};
}
