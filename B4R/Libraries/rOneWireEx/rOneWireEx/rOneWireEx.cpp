
#include "B4RDefines.h"

namespace B4R {
	void B4ROneWireEx::Initialize(Byte pin) {
		oneWire = new (beOneWire) OneWire(pin);
	}
	
	bool B4ROneWireEx::Search (ArrayByte* Address) {
		return oneWire->search((Byte*)Address->data);
	}
	
	void B4ROneWireEx::ResetSearch() {
		oneWire->reset_search();
	}
	
	UInt B4ROneWireEx::CRC16 (ArrayByte* Data, UInt Length) {
		return OneWire::crc16((Byte*)Data->data, Length, 0);
	}
	
	Byte B4ROneWireEx::CRC8 (ArrayByte* Data, Byte Length) {
		return OneWire::crc8((Byte*)Data->data, Length);
	}
	
	bool B4ROneWireEx::Reset() {
		return oneWire->reset();
	}
	
	void B4ROneWireEx::Select(ArrayByte* Address) {
		oneWire->select((Byte*)Address->data);
	}
	
	void B4ROneWireEx::Write(Byte Value, bool Power) {
		oneWire->write(Value, Power);
	}
	
	void B4ROneWireEx::WriteBytes(ArrayByte* Bytes, bool Power) {
		oneWire->write_bytes((Byte*)Bytes, Bytes->length, Power);
	}
	
	void B4ROneWireEx::ReadBytes(ArrayByte* Bytes, UInt Count) {
		oneWire->read_bytes((Byte*)Bytes->data, Count);
	}
	
	void B4ROneWireEx::Skip() {
		oneWire->skip();
	}
	
	bool B4ROneWireEx::ReadAddress(ArrayByte* address) {
		// Pass the internal raw data pointer of the B4R array directly to the OneWire driver
		return oneWire->search((uint8_t*)address->data);
	}

	bool B4ROneWireEx::SetResolution(ArrayByte* address, Byte resBits) {
		uint8_t* addr = (uint8_t*)address->data;
		uint8_t targetRes = (uint8_t)resBits;
		if (targetRes < 9 || targetRes > 12) return false;
		
		// 1. Read existing scratchpad configuration to preserve TH and TL alarm settings
		oneWire->reset();
		oneWire->select(addr);
		oneWire->write(0xBE);
		
		uint8_t scratchpad[9];
		for (int i = 0; i < 9; i++) {
			scratchpad[i] = oneWire->read();
		}
		
		// 2. Map target configurations to corresponding DS18B20 register bitmasks
		uint8_t configRegister = 0x1F; 
		if (targetRes == 10)      configRegister = 0x3F;
		else if (targetRes == 11) configRegister = 0x5F;
		else if (targetRes == 12) configRegister = 0x7F;
		
		// 3. Write data adjustments back to the sensor configuration registers
		oneWire->reset();
		oneWire->select(addr);
		oneWire->write(0x4E); 
		oneWire->write(scratchpad[2]); // Preserve original High Alarm
		oneWire->write(scratchpad[3]); // Preserve original Low Alarm
		oneWire->write(configRegister); 
		
		// 4. Copy modifications permanently to the sensor's non-volatile EEPROM storage
		oneWire->reset();
		oneWire->select(addr);
		oneWire->write(0x48); 
		
		delay(20); // Small safety buffer for EEPROM write cycle to complete
		return true;
	}

float B4ROneWireEx::ReadTemperature(ArrayByte* address) {
    uint8_t* addr = (uint8_t*)address->data;
    
    // 1. Trigger the temperature conversion command
    oneWire->reset();
    oneWire->select(addr);
    oneWire->write(0x44); 
    
    // 2. Wait for conversion (750ms covers all resolutions safely when reading sequentially)
    delay(750); 
    
    // 3. Fetch the scratchpad data (Contains temperature AND configuration)
    oneWire->reset();
    oneWire->select(addr);
    oneWire->write(0xBE); 
    
    uint8_t scratchpad[9];
    for (int i = 0; i < 9; i++) {
        scratchpad[i] = oneWire->read();
    }
    
    // 4. Verify transmission block via CRC
    if (oneWire->crc8(scratchpad, 8) != scratchpad[8]) {
        return -127.0; 
    }
    
    // 5. Extract resolution setting from the configuration register (byte index 4)
    uint8_t currentResolution = 12;      // Default fallback
    uint8_t cfg = scratchpad[4] & 0x60;  // Isolate bits 5 and 6 safely from live data
    if (cfg == 0x00)      currentResolution = 9;
    else if (cfg == 0x20) currentResolution = 10;
    else if (cfg == 0x40) currentResolution = 11;
    
    // 6. Convert Raw Bytes to Celsius 16-bit signed integer
    int16_t rawTemp = (scratchpad[1] << 8) | scratchpad[0];
    
    // 7. Clear out only the true uninitialized floating fractional bits
    if (currentResolution == 9) {
        rawTemp = rawTemp & ~7;  // Wipes out bits 0, 1, 2 (Only bit 3 remains for 0.5°C steps)
    } else if (currentResolution == 10) {
        rawTemp = rawTemp & ~3;  // Wipes out bits 0, 1 (Bits 2 and 3 remain for 0.25°C steps)
    } else if (currentResolution == 11) {
        rawTemp = rawTemp & ~1;  // Wipes out bit 0 (Bits 1, 2, 3 remain for 0.125°C steps)
    }
    // 12-bit keeps all 4 fractional bits intact (0.0625°C steps)
    
    // 8. Divide by 16.0 to restore the full float decimal value
    return (float)rawTemp / 16.0;
}

	Byte B4ROneWireEx::GetDeviceType(ArrayByte* address) {
		// Safety check: ensure the array pointer is valid
		if (address == NULL || address->data == NULL || address->length < 1) return 0;
		
		// Extract the family code from the very first byte index
		uint8_t familyCode = ((uint8_t*)address->data)[0];
		
		// Evaluate the family code against known Dallas hardware profiles
		switch (familyCode) {
			case 0x28: return 1; // DS18B20 (Most Common)
			case 0x10: return 2; // DS18S20 / Older DS1820
			case 0x22: return 3; // DS1822
			case 0x3B: return 4; // MAX31820
			default:   return 0; // Unknown or non-temperature device
		}
	}

	B4RString* B4ROneWireEx::GetDeviceTypeName(ArrayByte* address) {
		const char* modelName;

		// Safe validation check to prevent null pointer crashes
		if (address == NULL || address->data == NULL || address->length < 1) {
			modelName = "INVALID";
		} else {
			// Extract the family code safely from the data array
			uint8_t familyCode = ((uint8_t*)address->data)[0];
			
			switch (familyCode) {
				case 0x28: modelName = "DS18B20"; break;
				case 0x10: modelName = "DS18S20OLD"; break;
				case 0x22: modelName = "DS1822";  break;
				case 0x3B: modelName = "MAX31820"; break;
				case 0x01: modelName = "iButton Key"; break;
				case 0x24: modelName = "EEPROM Storage"; break;
				default:   modelName = "UNKNOWN"; break;
			}
		}

		// Format model name into a local character buffer
		char buf[24]; 
		snprintf(buf, sizeof(buf), "%s", modelName);

		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(buf);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}

// End NameSpace
}