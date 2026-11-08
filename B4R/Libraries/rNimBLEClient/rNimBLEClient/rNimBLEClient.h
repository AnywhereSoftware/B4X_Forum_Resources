/**
 * @file rNimBLEClient.h
 * @brief Header for the thin B4R NimBLE Client Wrapper.
 * Provides resource-efficient BLE communication on the ESP32 for B4R projects.
 * @date 2026-02-25
 * @author Robert W.B. Linn
 * @version 1.0
 * @section dependencies Dependencies
 * Dependencies: Platform esp32@3.3.7, NimBLE library 2.3.9
 * @section license License
 * Copyright © 2026 Robert W.B. Linn. All rights reserved.
 * License: MIT — see LICENSE file.
*/

#pragma once
#ifndef RNIMBLECLIENT_H
#define RNIMBLECLIENT_H

#include "B4RDefines.h"
#include <NimBLEDevice.h>

//~Library: rNimBLEClient
//~Version: 1.0

namespace B4R {

	typedef void (*SubVoidByte)(Byte b);
	typedef void (*SubVoidVoid)();

	//~shortname: NimBLEClient
	//~Event: NewData (Buffer() As Byte)
	//~Event: Error (Code As Byte)
	//~Event: Connected ()
	//~Event: Disconnected ()

    /**
     * @class B4RNimBLEClient
     * @brief Main class for BLE client functionality in B4R.
     * 
     * Encapsulates NimBLE logic to connect to BLE devices like BuWizz 2.
     */
    class B4RNimBLEClient {
        private:
            // Internal States
            bool nimbleInitialized = false;
            uint8_t targetMac[6];
            NimBLEAddress addr;
            
            // NimBLE Pointers
            NimBLEClient* pClient = nullptr;
            NimBLERemoteService* pService = nullptr;
            NimBLERemoteCharacteristic* pTXChar = nullptr;
            NimBLERemoteCharacteristic* pRXChar = nullptr;

            // UUIDs
            NimBLEUUID serviceUUID;
            NimBLEUUID txUUID;
            NimBLEUUID rxUUID;

            // B4R Callbacks
            SubVoidArray NewDataSub;
            SubVoidByte ErrorSub;
            SubVoidVoid ConnectedSub;
            SubVoidVoid OnDisconnectedSub;

            // Error Codes
            static const uint8_t ERROR_CREATE_BLE_CLIENT = 1;
            static const uint8_t ERROR_FAILED_TO_CONNECT = 2;
            static const uint8_t ERROR_SERVICE_NOT_FOUND = 3;
            static const uint8_t ERROR_CHARACTERISTICS_NOT_FOUND = 4;

        public:
            /** @brief Singleton instance for static callbacks */
			//~hide
            static B4RNimBLEClient* instance;
            
            /** @brief Debug flag for serial logging */
			//~hide
            bool debug = false;
            
            /** @brief Connection status flag */
			//~hide
            bool connected = false;

            /**
             * @brief Initializes the BLE module and prepares target parameters.
			 * @param MAC - BLE peripheral MAC address.
			 * @param Service - Service UUID.
			 * @param TxChar - Characteristic UUID for writing (TX).
			 * @param RxChar - Characteristic UUID for notifications (RX). If NULL or empty, the TX characteristic is also used for RX.
			 * @param NewData - Callback when new data is received.
			 * @param OnError - Callback when an error occurs.
			 * @param OnConnected - Callback when client connected.
			 * @param OnDisconnected - Callback when client is disconnected.
			 * @param Debug         	Enable debug logging via Serial.
			 */
            void Initialize(ArrayByte* Mac, B4RString* Service, B4RString* TXChar, B4RString* RXChar, SubVoidArray NewData, SubVoidByte OnError, SubVoidVoid OnConnected, SubVoidVoid OnDisconnected, bool Debug);

            /**
             * @brief Starts the connection process and service discovery.
             * @return true if successfully connected and characteristics found.
             */
            bool Connect();

            /**
             * @brief Terminates an existing connection and cleans up resources.
             */
            void Disconnect();

            /**
             * @brief Sends data to the remote device via RX characteristic.
			 * Automatically chooses between 'With Response' and 'No Response' write modes.
             * @param data - Byte array of data to be sent.
             */
            void Write(ArrayByte* data);

            /**
             * @brief Checks if the client is currently connected.
             * @return true if connected.
             */
            bool IsConnected();

            /** Internal helper methods for B4R event handling */

            /** @brief Static bridge for incoming BLE notifications
			 * @brief Internal callback class to handle NimBLE client events.
			 */
			//~hide
            static void notifyCB(NimBLERemoteCharacteristic* chr, uint8_t* data, size_t length, bool isNotify);

			//~hide
            void HandleConnected();

			//~hide
            void HandleDisconnected();

			//~hide
            void HandleError(uint8_t code);
    };
}
#endif
