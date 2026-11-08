#pragma once
#include "B4RDefines.h"

// Arduino built-in official ESP32 BLE library.
// Install or Update ESP32 Board Package to ensure correct ESP32 BLE support:
// Open Arduino IDE, Go to Tools > Board > Boards Manager, Search for ESP32 by Espressif Systems, If outdated, update to the latest version. Restart the Arduino IDE.
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLECharacteristic.h>
#include <BLEUtils.h>
#include <BLE2902.h>

//~Library: rBLEServer
//~Author: Robert W.B. Linn
//~Brief: B4R library Bluetooth Low Energy (BLE) server for ESP32.
//~Dependencies: built-in official ESP32 BLE library 3.1.1.
//~Version: 0.85
//~Built: 20250224

// Define the B4R namespace.
// The CPP code must be wrapped inside the B4R namespace to integrate with B4R.
namespace B4R {
	
	//~shortname: BLEServer
	//~Event: NewData (Buffer() As Byte)
	//~Event: Error
	typedef void (*SubVoidByte)(Byte b);

	class B4RBLEServer {
		private:
			// Global instance pointer
			static B4RBLEServer* instance;
			
			// Client Callbacks defined in the B4R code
			SubVoidArray NewDataSub;
			SubVoidByte ErrorSub;

			// BLE server, service and characteristic
            BLEServer *pServer;
            BLEService *pService;
            BLECharacteristic *pCharacteristic;

			// Centralized error handler calling ErrorSub
			void HandleError(uint8_t errorcode);

		public:
			/**
			* Static const for MTU min and max size
			*/
			static const UInt MTU_SIZE_MIN					= 23;
			static const UInt MTU_SIZE_MAX					= 512;

			/**
			* Static const for warning and error codes as constants - see source.
			*/
			static const Byte WARNING_INVALID_MTU			= 1;
			static const Byte ERROR_INVALID_CHARACTERISTIC	= 2;
			static const Byte ERROR_EMPTY_DATA				= 3;
				
			/**
			* Initialize the BLE server.
			* Name - Name of the BLE server.
			* NewDataSub - Sub to handle new data from the connected client.
			* ErrorSub - Sub to show any errors.
			* mtuSize - Size of the MTU between 23 (default) and 512.
			*/
			void Initialize (B4RString* Name, SubVoidArray NewDataSub, SubVoidByte ErrorSub, UInt mtuSize);

			/**
			* Flag to check if a client is connected.
			*/
			bool Connected();
			
			/**
			* Write data to the BLE client.
			* data = Array as Bytes
			*/
			void Write(ArrayByte* data);
			
			void WriteAdvertisement(ArrayByte* data);

			/**
			* Next functions must be public but are hidden.
			*/
			
			// Add a public getter for the BLEServer instance.
			
			//~hide
			static B4RBLEServer* GetInstance() { return instance; }
						
			//~hide
            bool deviceConnected = false;

			//~hide
			void SetDeviceConnected(bool status);

			//~hide
			void SetStartAdvertising();

			//~hide
			void HandleDataReceived(std::vector<uint8_t>& data);

	};
}
