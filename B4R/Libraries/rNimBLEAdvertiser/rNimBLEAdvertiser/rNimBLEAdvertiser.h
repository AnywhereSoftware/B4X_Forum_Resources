/**
 * @file rNimBLEAdvertiser.h
 * @brief Header for the thin B4R NimBLE Advertiser Wrapper.
 * Provides resource-efficient BLE advertiser functionality on ESP32 for B4R.
 * 
 * @date 2026-03-27
 * @author Robert W.B. Linn
 * @version 1.0
 * 
 * @section description Description
 * This wrapper exposes a minimal BLE advertiser interface for B4R:
 * - Advertises in regular intervals data
 * - Device is a pure broadcaster (setConnectableMode(BLE_GAP_CONN_MODE_NON))
 * 
 * @section dependencies Dependencies
 * Platform: esp32@3.3.6  
 * NimBLE: 2.3.7
 * 
 * @section license License
 * MIT License
 */

#pragma once
#ifndef RNIMBLEADVERTISER_H
#define RNIMBLEADVERTISER_H

#include "B4RDefines.h"
#include <NimBLEDevice.h>

// Helper

// Use like uint8_t* mac = BYTEPTR(macArr);
#define BYTEPTR(a) ((uint8_t*)(a).data)

// Use like macArr.data = ARR(mac);
#define ARR(x) ((uint8_t*)(x))

// Debugging
#define DBG if (instance && instance->debug)
#define DBGLN(x) if (instance && instance->debug) ::Serial.println(x)
	
//~Library: rNimBLEAdvertiser
//~Version: 1.0

namespace B4R {
    //~shortname: NimBLEAdvertiser
	//~Event: NewData (Mac() As Byte, Buffer() As Byte)

    /**
     * @class B4RNimBLEAdvertiser
     * @brief Lightweight BLE scanner wrapper for B4R.
     */
    class B4RNimBLEAdvertiser {
        private:
            static B4RNimBLEAdvertiser* instance;
            bool initialized = false;
			// Debug flag for extensive logging serial line
            bool debug = false;
            
        public:
            /**
             * @brief Initializes the BLE stack and sets the local device name.
             * @param DeviceName The name that will appear in scan responses.
             */
			void Initialize(B4R::B4RString* DeviceName);

            /**
             * @brief Injects custom data into the Manufacturer Specific (0xFF) field.
             * @param Data Byte array containing the raw payload (e.g., Govee/Ruuvi format).
             */
            void SetManufacturerData(ArrayByte* Data);

            /**
             * @brief Injects data into a specific Service Data (0x16) field.
             * @param UUID The 16-bit Service UUID (e.g., 0x181A for Environmental Sensing).
             * @param Data The payload associated with the service.
             */
            void SetServiceData(UInt UUID, ArrayByte* Data);

            /**
             * @brief Starts the BLE radio transmission.
             * @param DurationMS Total time to advertise in milliseconds (0 = infinite).
             */
            void Start(ULong DurationMS);

            /**
             * @brief Immediately stops all BLE advertising.
             */
            void Stop();

            /**
             * @brief Toggles verbose Serial logging for the library.
             * @param Enabled True to enable debug output.
             */
            void SetDebug(bool Enabled);

    };
}
#endif

