#pragma once
#include "B4RDefines.h"

// Arduino built-in official ESP32 BLE library.
// Install or Update ESP32 Board Package to ensure correct ESP32 BLE support:
// Open Arduino IDE, Go to Tools > Board > Boards Manager, Search for ESP32 by Espressif Systems, If outdated, update to the latest version. Restart the Arduino IDE.
#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>
#include <BLEBeacon.h>
#include <BLECharacteristic.h>
#include <BLE2902.h>

//~Library: rBLEBeacon
//~Author: Robert W.B. Linn
//~Brief: B4R library Bluetooth Low Energy (BLE) Eddystone beacon for ESP32.
//~Dependencies: built-in official ESP32 BLE library 3.1.1.
//~Version: 0.91
//~Built: 20250216

// Define the B4R namespace.
// The CPP code must be wrapped inside the B4R namespace to integrate with B4R.
namespace B4R {

    //~shortname: BLEBeacon
    //~Event: Error
    typedef void (*SubVoidByte)(Byte b);

    class B4RBLEBeacon {
    private:
        // BLE server, service, and characteristic
        BLEServer *pBeacon;

        // Client Callbacks defined in the B4R code (see HandleError)
        SubVoidByte ErrorSub;

		// Centralized error handler calling ErrorSub
		void HandleError(uint8_t errorcode);

        /**
        * Const for Eddystone UID (17+ bytes)
		* Full HEX string (18 bytes) = 00D20C9CB0A5D94BF7A3E1659E5A8E9C42F0
		* Used to extract the data in beacon client, like B4A.
        */
		const Byte FRAME_TYPE_EDDYSTONE_UID = 0x00;
		const Byte NAMESPACE_ID[10] = { 0xD2, 0x0C, 0x9C, 0xB0, 0xA5, 0xD9, 0x4B, 0xF7, 0xA3, 0xE1 };
		const Byte INSTANCE_ID[6] = { 0x65, 0x9E, 0x5A, 0x8E, 0x9C, 0x42 };
		const Byte TX_POWER_DEFAULT = 0xF0;

    public:

		/**
		* Static const max data size of 31. This is fixed.
		*/
		static const Byte MAX_ADV_DATA_SIZE = 31;

        /**
        * Static const for warning and error codes as constants - see source.
        */
		
		// Eddystone = Max data size is 31 bytes. This is fixed.
        static const Byte ERROR_ADV_DATA_SIZE_TOO_LARGE	= 1;
		static const Byte ERROR_ADV_DATA_SIZE_TOO_SMALL	= 2;
        static const Byte ERROR_ADV_NO_DATA = 3;
                
        /**
        * Initialize the BLE beacon.
        * Name - Name of the BLE beacon.
        * ErrorSub - Event sub to show any errors.
        */
        void Initialize (B4RString* Name, SubVoidByte ErrorSub);
        
        /**
        * Advertise data in Eddystone format.
        * data - Array as Byte with max size 31 bytes.
        */
        void Advertise(ArrayByte* data);

        /**
        * Advertise data in raw format using manufacturer data or service data.
		* For manufacturer data, the content should contain the manufacturer id + advertised data (from f.e. a sensor).
		* For service data, the content could be specific like environment data (from f.e. a sensor).
		* Environmental Sensing service UUID is 0x181A (Raw data type 0x16 = UUID + data).
        * data - Array as Byte with any format.
		* serviceinfo - Bool to use service data in the advertisement, else manufacturer id + data.
        */
		void AdvertiseRaw(ArrayByte* data, bool serviceinfo);
	
    };
}
