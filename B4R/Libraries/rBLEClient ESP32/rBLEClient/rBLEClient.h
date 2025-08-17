/**
 * @file rBLEClient.h
 * @brief ESP32 B4R library to connect or passively scan Bluetooth Low Energy (BLE) peripherals.
 *
 * @section author Author
 * Created by Robert W.B. Linn on see Built below.
 * 
 * @section license License
 * Copyright © 2025 Robert W.B. Linn. All rights reserved.
 * License: MIT — see LICENSE file.
 */

#pragma once
#include "B4RDefines.h"
#include <BLEDevice.h>
#include <BLEClient.h>
#include <BLERemoteService.h>
#include <BLERemoteCharacteristic.h>

//~Library: rBLEClient
//~Dependencies: built-in official ESP32 BLE library 3.3.0.
//~Version: 1.02
//~Built: 20250806

namespace B4R {

	typedef void (*SubVoidByte)(Byte b);

	//~shortname: BLEClient
	//~Event: NewData (Buffer() As Byte)
	//~Event: Error (Code As Byte)
	class B4RBLEClient {

		private:
			static B4RBLEClient* instance;

			// BLE core objects
			BLEClient* pClient = nullptr;
			BLERemoteCharacteristic* pTxCharacteristic = nullptr;
			BLERemoteCharacteristic* pRxCharacteristic = nullptr;

			// Configuration
			String targetMAC;
			String serviceUUID;
			String txUUID;
			String rxUUID;

			// Flags
			bool connected = false;
			bool debug = false;

			// Event callbacks
			SubVoidArray NewDataSub;
			SubVoidByte ErrorSub;

			// Internal helper methods
			void HandleError(uint8_t code);
			static void notifyCallback(BLERemoteCharacteristic* c, uint8_t* data, size_t length, bool isNotify);

		public:
			/**
			 * @brief Initializes the BLE client configuration.
			 *
			 * @param MAC           BLE peripheral MAC address.
			 * @param Service       Service UUID.
			 * @param TxChar        Characteristic UUID for writing (TX).
			 * @param RxChar        Characteristic UUID for notifications (RX). If NULL or empty, the TX characteristic is also used for RX.
			 * @param NewData       Callback when new data is received.
			 * @param OnError       Callback when an error occurs.
			 * @param Debug         Enable debug logging via Serial.
			 */
			void Initialize(B4RString* MAC, B4RString* Service, B4RString* TxChar, B4RString* RxChar, SubVoidArray NewData, SubVoidByte OnError, bool Debug);

			/**
			 * @brief Connects to the BLE peripheral and discovers its service and characteristics.
			 *
			 * Scans for the device by MAC, creates a client, connects, and registers for notifications.
			 *
			 * @return true if connection succeeded, false otherwise.
			 */
			bool Connect();

			/**
			 * @brief Disconnects from the connected BLE peripheral.
			 */			
			void Disconnect();


			/**
			 * @brief Checks if the client is currently connected to the peripheral.
			 *
			 * @return true if connected, false otherwise.
			 */
			bool IsConnected();

			/**
			 * @brief Writes a byte array to the TX characteristic of the connected peripheral.
			 *
			 * @param data Pointer to ArrayByte structure to send.
			 */
			void Write(ArrayByte* data);


			/**
			 * @brief Performs a passive BLE scan with optional single-match mode.
			 *
			 * @param scanTimeSeconds Scan duration in seconds.
			 * @param onlyOnce        If true, scan exits when target device is found.
			 * @param timeoutSeconds  Max timeout in seconds for single-match mode.
			 * @return true if target found (onlyOnce mode), false otherwise.
			 */
			bool PassiveScan(int scanTimeSeconds, bool onlyOnce, int timeoutSeconds);

			/**
			 * @brief Convenience wrapper for single passive scan mode.
			 *
			 * @param timeoutSeconds Timeout in seconds.
			 * @return true if target found, false otherwise.
			 */
			bool PassiveScanOnce(int timeoutSeconds);

			// Max timeout in seconds for passive scan
			static const uint8_t MAX_TIMEOUT_SECONDS = 60;

			// Error codes
			static const uint8_t ERROR_NONE = 0;
			static const uint8_t ERROR_ALREADY_CONNECTED = 1;
			static const uint8_t ERROR_DEVICE_NOT_FOUND = 2;
			static const uint8_t ERROR_CREATE_BLE_CLIENT = 3;
			static const uint8_t ERROR_FAILED_TO_CONNECT = 4;
			static const uint8_t ERROR_SERVICE_NOT_FOUND = 5;
			static const uint8_t ERROR_CHARACTERISTICS_NOT_FOUND = 6;
			static const uint8_t ERROR_CAN_NOT_WRITE_VALUE = 7;
	};
}
