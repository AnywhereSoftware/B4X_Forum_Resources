/**
 * @file rNimBLEScanner.h
 * @brief Header for the thin B4R NimBLE Scanner Wrapper.
 * Provides resource-efficient BLE scanner functionality on ESP32 for B4R.
 * 
 * @date 2026-03-27
 * @author Robert W.B. Linn
 * @version 1.0
 * 
 * @section description Description
 * This wrapper exposes a minimal BLE scanner interface for B4R, allowing:
 * - Listen to advertisements of BLE peripherals
 * - Receiving advertised data from BLE peripherals
 * - Reference: https://h2zero.github.io/NimBLE-Arduino/class_nim_b_l_e_scan.html
 * 
 * @section dependencies Dependencies
 * Platform: esp32@3.3.6  
 * NimBLE: 2.3.7
 * 
 * @section license License
 * MIT License
 */

#pragma once
#ifndef RNIMBLESCANNER_H
#define RNIMBLESCANNER_H

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
	
//~Library: rNimBLEScanner
//~Version: 1.0

namespace B4R {
	typedef void (*SubVoidArrayArray)(Array* barray, Array* bbarray) ;
	
    // Forward declaration of the internal callback class
    class ScannerCallbacks;

    //~shortname: NimBLEScanner
	//~Event: NewData (Mac() As Byte, Buffer() As Byte)

    /**
     * @class B4RNimBLEScanner
     * @brief Lightweight BLE scanner wrapper for B4R.
     */
    class B4RNimBLEScanner {
        private:
            static B4RNimBLEScanner* instance;

            bool initialized = false;

			// Filter by company id
			uint16_t targetCompanyID = 0;
            bool filterCompanyID = false;

			// Filter by mac
            uint8_t targetMac[6];
			bool filterMac = false;
			
			// Selective service data UUIDs used by HandleResult from scanning
			static const uint16_t knownServiceUUIDs[4];  // move array here
			static const int numKnownUUIDs = 4;          // store length to avoid sizeof hacks
	
			// Debug flag for extensive logging serial line
            bool debug = false;

            // B4R Callbacks
            ScannerCallbacks* pCallbacks;
            SubVoidArrayArray NewDataSub;
            
        public:
			/**
             * @brief Initializes the BLE module and prepares target parameters.
			 * @param NewData - Callback when new data is received.
			 */
            void Initialize(SubVoidArrayArray NewData);
			
			/**
             * @brief Scan for advertisements of the device with target MAC.
			 * @param DurationMS - Scan duration, 0 = scan forever.
			 * @param DoNotAllowDuplicates - Set to false to see every advertisement. 
			 */
            void Start(ULong DurationMS, bool DoNotAllowDuplicates);
            
			/**
             * @brief Stop scanning.
			 */
			void Stop();

			/**
			 * Set filter for company id.
			 * @param CompanyID - Company ID as 2 bytes, i.e. 0xEC88
			 */
			void SetCompanyFilter(UInt CompanyID);
			// void SetCompanyFilter(UInt CompanyID) { targetCompanyID = CompanyID; filterCompanyID = (CompanyID != 0); }			

			/**
			 * Set filter for target MAC.
			 * @param TargetMAC - Array byte length 6, i.e. 0xa4,0xc1,0x38,0x4c,0x30,0x22
			 */
			void SetMacFilter(ArrayByte* TargetMAC);

			/**
			 * Set debug flag.
			 * @param Enabled - Enable debug logging via Serial
			 */
			void SetDebug(bool Enabled);

            /** Internal bridge for the callback class */
			//~hide
            static void HandleResult(const NimBLEAdvertisedDevice* device);
    };
}
#endif

