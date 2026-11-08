/**
 * @file rBLEClient.cpp
 * @brief Source for the ESP32 B4R library rBLEClient.
 * 
 * @section license License
 * Copyright © 2025 Robert W.B. Linn. All rights reserved.
 * License: MIT — see LICENSE file.
 */

#include "B4RDefines.h"
#include "rBLEClient.h"

namespace B4R {

	// Static instance for global callback access
	B4RBLEClient* B4RBLEClient::instance = nullptr;

	/**
	 * @brief Notification callback handler for BLE notifications.
	 *
	 * Invoked by the ESP32 BLE library when the remote characteristic sends a notification.
	 * Passes the received data to the B4R NewDataSub callback.
	 *
	 * @param c         Pointer to the BLERemoteCharacteristic that triggered the notification.
	 * @param data      Pointer to the received byte buffer.
	 * @param length    Number of bytes received.
	 * @param isNotify  True if this was a notification, false if indication.
	 */
	void B4RBLEClient::notifyCallback(BLERemoteCharacteristic* c, uint8_t* data, size_t length, bool isNotify) {
		if (instance == nullptr || instance->NewDataSub == nullptr) return;

		// Use static so memory stays valid after function returns
		static ArrayByte arr;  
		arr.data = data;
		arr.length = length;

		instance->NewDataSub(&arr);
	}

	/**
	 * @brief Internal error handler that calls the ErrorSub callback.
	 *
	 * @param code Error code from the predefined constants.
	 */
	void B4RBLEClient::HandleError(uint8_t code) {
		connected = false;
		if (ErrorSub != nullptr) {
			ErrorSub(code);
		}
	}

	/**
	 * @brief Initializes the BLE client configuration.
	 *
	 * Sets the target MAC, service UUID, TX and RX characteristic UUIDs, and event callbacks.
	 * If RxChar is NULL or empty, TX characteristic will also be used for notifications.
	 */
	void B4RBLEClient::Initialize(B4RString* MAC, B4RString* Service, B4RString* TxChar, B4RString* RxChar,
								  SubVoidArray NewData, SubVoidByte OnError, bool Debug) {
		instance = this;
		NewDataSub = NewData;
		ErrorSub = OnError;
		debug = Debug;

		targetMAC   = String((const char*)MAC->data, MAC->getLength());
		serviceUUID = String((const char*)Service->data, Service->getLength());
		txUUID      = String((const char*)TxChar->data, TxChar->getLength());
		rxUUID      = (RxChar && RxChar->getLength() > 0)
						? String((const char*)RxChar->data, RxChar->getLength())
						: txUUID;

		BLEDevice::init("");
		vTaskDelay(300 / portTICK_PERIOD_MS);

		if (debug) {
			::Serial.printf("[B4RBLEClient::Initialize] MAC=%s\n", targetMAC.c_str());
			::Serial.printf("[B4RBLEClient::Initialize] ServiceUUID=%s\n", serviceUUID.c_str());
			::Serial.printf("[B4RBLEClient::Initialize] TxUUID=%s\n", txUUID.c_str());
			::Serial.printf("[B4RBLEClient::Initialize] RxUUID=%s\n", rxUUID.c_str());
		}
	}

	/**
	 * @brief Connects to the BLE peripheral and discovers its service and characteristics.
	 *
	 * Scans for the device by MAC, connects, and enables notifications if available.
	 *
	 * @return true if connection succeeded, false otherwise.
	 */
	bool B4RBLEClient::Connect() {
		const int scanTimeout = 5; // seconds

		if (debug) {
			::Serial.printf("[B4RBLEClient::Connect] Connecting to %s\n", targetMAC.c_str());
		}

		if (connected) {
			if (debug) ::Serial.println("[B4RBLEClient::Connect] Already connected");
			HandleError(ERROR_ALREADY_CONNECTED);
			return true;
		}

		if (pClient) {
			delete pClient;
			pClient = nullptr;
		}

		// --- Scan for device ---
		BLEScan* pBLEScan = BLEDevice::getScan();
		pBLEScan->setActiveScan(true);
		pBLEScan->setInterval(100);
		pBLEScan->setWindow(80);

		if (debug) ::Serial.println("[B4RBLEClient::Connect] Scanning...");
		BLEScanResults *results = pBLEScan->start(scanTimeout, false);

		bool found = false;
		for (int i = 0; i < results->getCount(); ++i) {
			BLEAdvertisedDevice device = results->getDevice(i);
			if (device.getAddress().toString().equalsIgnoreCase(targetMAC.c_str())) {
				found = true;
				break;
			}
		}
		pBLEScan->clearResults();

		if (!found) {
			if (debug) ::Serial.println("[B4RBLEClient::Connect] Device not found");
			HandleError(ERROR_DEVICE_NOT_FOUND);
			return false;
		}

		// --- Create client and connect ---
		pClient = BLEDevice::createClient();
		if (!pClient || !pClient->connect(BLEAddress(targetMAC.c_str()))) {
			if (debug) ::Serial.println("[B4RBLEClient::Connect] Failed to connect");
			HandleError(ERROR_FAILED_TO_CONNECT);
			return false;
		}
		if (debug) ::Serial.println("[B4RBLEClient::Connect] Connected");

		// --- Discover service and characteristics ---
		BLERemoteService* pService = pClient->getService(serviceUUID);
		if (!pService) {
			if (debug) ::Serial.printf("[B4RBLEClient::Connect] Service not found: %s\n", serviceUUID.c_str());
			pClient->disconnect();
			HandleError(ERROR_SERVICE_NOT_FOUND);
			return false;
		}

		pTxCharacteristic = pService->getCharacteristic(txUUID);
		pRxCharacteristic = pService->getCharacteristic(rxUUID);
		if (!pTxCharacteristic || !pRxCharacteristic) {
			if (debug) ::Serial.println("[B4RBLEClient::Connect] Characteristics not found");
			pClient->disconnect();
			HandleError(ERROR_CHARACTERISTICS_NOT_FOUND);
			return false;
		}

		// --- Register for notifications and enable CCCD ---
		if (pRxCharacteristic->canNotify()) {
			pRxCharacteristic->registerForNotify(notifyCallback);

			// Explicitly enable notifications in CCCD (0x2902)
			BLERemoteDescriptor* cccd = pRxCharacteristic->getDescriptor(BLEUUID((uint16_t)0x2902));
			if (cccd != nullptr) {
				uint8_t notifOn[] = {0x01, 0x00};  // enable notifications
				cccd->writeValue(notifOn, sizeof(notifOn), true);
				if (debug) ::Serial.println("[B4RBLEClient::Connect] Notifications enabled via CCCD");
			} else if (debug) {
				::Serial.println("[B4RBLEClient::Connect] No CCCD descriptor found");
			}
		}

		connected = true;
		if (debug) ::Serial.println("[B4RBLEClient::Connect] Ready");
		return true;
	}

	/**
	 * @brief Disconnects from the connected BLE peripheral.
	 */
	void B4RBLEClient::Disconnect() {
		if (connected && pClient != nullptr) {
			pClient->disconnect();
			connected = false;
			if (debug) ::Serial.println("[B4RBLEClient::Disconnect] Disconnected");
		}
	}

	/**
	 * @brief Checks if the client is currently connected to the peripheral.
	 *
	 * @return true if connected, false otherwise.
	 */
	bool B4RBLEClient::IsConnected() {
		return connected && pClient != nullptr && pClient->isConnected();
	}

	/**
	 * @brief Writes a byte array to the TX characteristic of the connected peripheral.
	 *
	 * @param data Pointer to ArrayByte structure to send.
	 */
	void B4RBLEClient::Write(ArrayByte* data) {
		if (connected && pTxCharacteristic && pTxCharacteristic->canWrite()) {
			pTxCharacteristic->writeValue((uint8_t*)data->data, data->length, false);
		} else {
			HandleError(ERROR_CAN_NOT_WRITE_VALUE);
		}
	}

	/**
	 * @brief Performs a passive BLE scan with optional single-match mode.
	 *
	 * @param scanTimeSeconds Scan duration in seconds.
	 * @param onlyOnce        If true, scan exits when target device is found.
	 * @param timeoutSeconds  Max timeout in seconds for single-match mode.
	 * @return true if target found (onlyOnce mode), false otherwise.
	 */
	bool B4RBLEClient::PassiveScan(int scanTimeSeconds, bool onlyOnce, int timeoutSeconds) {
		if (debug) {
			::Serial.printf("[B4RBLEClient::PassiveScan] Mode=%s\n", onlyOnce ? "Once" : "Multi");
		}

		if (onlyOnce && targetMAC.length() == 0) {
			if (debug) ::Serial.println("[B4RBLEClient::PassiveScan] No target MAC set");
			return false;
		}

		BLEDevice::init("");
		delay(300);

		BLEScan* pBLEScan = BLEDevice::getScan();
		pBLEScan->setActiveScan(false);
		pBLEScan->setInterval(100);
		pBLEScan->setWindow(80);

		unsigned long startMillis = millis();
		while (true) {
			BLEScanResults *results = pBLEScan->start(onlyOnce ? 1 : scanTimeSeconds, false);
			bool hasFilter = targetMAC.length() > 0;

			for (int i = 0; i < results->getCount(); i++) {
				BLEAdvertisedDevice d = results->getDevice(i);
				String mac = d.getAddress().toString();

				if (hasFilter && !mac.equalsIgnoreCase(targetMAC)) continue;

				// Forward first 6 bytes MAC + first 20 bytes of service/manufacturer data
				if (NewDataSub != nullptr) {
					const size_t macLen = 6;
					String sdata = d.haveServiceData() ? d.getServiceData() : "";
					String mdata = d.haveManufacturerData() ? d.getManufacturerData() : "";

					int datalen = (sdata.length() > 0) ? sdata.length() : mdata.length();
					if (datalen > 20) datalen = 20;

					const size_t totalLen = macLen + datalen;
					static uint8_t buffer[64];
					if (datalen > 0 && totalLen <= sizeof(buffer)) {
						// Convert MAC "AA:BB:CC:DD:EE:FF" -> 6-byte array
						int idx = 0;
						for (int j = 0; j < 6; j++) {
							buffer[idx++] = strtoul(mac.substring(j*3, j*3+2).c_str(), nullptr, 16);
						}

						// Copy data
						String &src = (sdata.length() > 0) ? sdata : mdata;
						for (int i = 0; i < datalen; i++) {
							buffer[macLen + i] = (uint8_t)src.charAt(i);
						}

						ArrayByte arr;
						arr.data = buffer;
						arr.length = totalLen;
						NewDataSub(&arr);
					}
				}

				if (onlyOnce) {
					pBLEScan->clearResults();
					if (debug) ::Serial.println("[B4RBLEClient::PassiveScan] Match found, done");
					return true;
				}
			}

			pBLEScan->clearResults();

			if (!onlyOnce) break; // Multi-scan completes after one iteration

			// Timeout
			if (timeoutSeconds > 0 && (millis() - startMillis) > (timeoutSeconds * 1000UL)) {
				if (debug) ::Serial.println("[B4RBLEClient::PassiveScan] Timeout reached");
				break;
			}

			if (timeoutSeconds == 0 && (millis() - startMillis) > (MAX_TIMEOUT_SECONDS * 1000UL)) {
				if (debug) ::Serial.println("[B4RBLEClient::PassiveScan] Max timeout fallback");
				break;
			}

			delay(20);
		}

		if (debug) ::Serial.println("[B4RBLEClient::PassiveScan] Done (no match)");
		return false;
	}

	/**
	 * @brief Convenience wrapper for single passive scan mode.
	 *
	 * @param timeoutSeconds Timeout in seconds.
	 * @return true if target found, false otherwise.
	 */
	bool B4RBLEClient::PassiveScanOnce(int timeoutSeconds) {
		return PassiveScan(1, true, timeoutSeconds);
	}
}
