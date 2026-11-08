/**
 * @file rNimBLEClient.cpp
 * @brief Implementation of the NimBLE Client Wrapper for B4R.
 */

#include "B4RDefines.h"
#include "rNimBLEClient.h"

namespace B4R {

	B4RNimBLEClient* B4RNimBLEClient::instance = nullptr;

	/**
	 * @class ClientCB
	 * @brief Internal callback class to handle NimBLE client events.
	 */
	class ClientCB : public NimBLEClientCallbacks {
		/**
		 * @brief Called when the BLE connection is established.
		 */
		void onConnect(NimBLEClient* c) override {
			if (B4RNimBLEClient::instance) {
				B4RNimBLEClient::instance->connected = true;
				B4RNimBLEClient::instance->HandleConnected();
			}
		}

		/**
		 * @brief Called when the connection is lost.
		 * @param reason The NimBLE specific reason for disconnection.
		 */
		void onDisconnect(NimBLEClient* c, int reason) override {
			if (B4RNimBLEClient::instance) {
				B4RNimBLEClient::instance->connected = false;
				B4RNimBLEClient::instance->HandleDisconnected();
			}
		}
	};

	/**
	 * @brief Static bridge for incoming BLE notifications.
	 * Converts raw data to B4R ArrayByte and forwards it to the B4R sub.
	 */
	void B4RNimBLEClient::notifyCB(
		NimBLERemoteCharacteristic* chr,
		uint8_t* data,
		size_t length,
		bool isNotify) {
		if (!instance || !instance->NewDataSub) return;

		ArrayByte arr;
		arr.data = data;
		arr.length = length;

		instance->NewDataSub(&arr);
	}

	/**
	 * @brief Initializes the client with MAC and UUIDs.
	 * @param Mac 6-byte array for the target MAC address.
	 * @param Service Service UUID string.
	 * @param TXChar TX characteristic UUID string (for notifications).
	 * @param RXChar RX characteristic UUID string (for writing).
	 */
	void B4RNimBLEClient::Initialize(
		ArrayByte* Mac,
		B4RString* Service,
		B4RString* TXChar,
		B4RString* RXChar,
		SubVoidArray NewData,
		SubVoidByte OnError,
		SubVoidVoid OnConnected,
		SubVoidVoid OnDisconnected,
		bool Debug) {
		instance = this;
		NewDataSub = NewData;
		ErrorSub = OnError;
		ConnectedSub = OnConnected;
		OnDisconnectedSub = OnDisconnected;
		debug = Debug;

		if (!Mac || Mac->length != 6) {
			if (debug) ::Serial.println("[NimBLEClient.Initialize][E] Invalid MAC");
			return;
		}

		memcpy(targetMac, Mac->data, 6);

		// Safe conversion of B4R strings to NimBLEUUIDs using explicit length
		serviceUUID = NimBLEUUID(std::string((const char*)Service->data, Service->getLength()).c_str());
		txUUID      = NimBLEUUID(std::string((const char*)TXChar->data, TXChar->getLength()).c_str());
		rxUUID      = NimBLEUUID(std::string((const char*)RXChar->data, RXChar->getLength()).c_str());

		if (debug) {
			::Serial.printf("[NimBLEClient.Initialize][I] ServiceUUID=%s\n", serviceUUID.toString().c_str());
			::Serial.printf("[NimBLEClient.Initialize][I] TxUUID=%s\n", txUUID.toString().c_str());
			::Serial.printf("[NimBLEClient.Initialize][I] RxUUID=%s\n", rxUUID.toString().c_str());
		}

		if (!nimbleInitialized) {
			NimBLEDevice::init("");
			NimBLEDevice::setPower(ESP_PWR_LVL_P9);
			NimBLEDevice::setSecurityAuth(false, false, false);
			// Change MTU size should not be required - keep 23 bytes
			// NimBLEDevice::setMTU(512);
			nimbleInitialized = true;
		}

		addr = NimBLEAddress(targetMac, BLE_ADDR_PUBLIC);
		if (debug) ::Serial.println("[NimBLEClient.Initialize][I] OK");
	}

	/**
	 * @brief Connects to the BLE device and discovers services/characteristics.
	 * @return True if connected and characteristics are ready for use.
	 */
	bool B4RNimBLEClient::Connect() {
		if (debug) ::Serial.println("[NimBLEClient.Connect][I] Start");
		if (connected) return true;

		pClient = NimBLEDevice::createClient();
		if (!pClient) {
			HandleError(ERROR_CREATE_BLE_CLIENT);
			return false;
		}

		pClient->setClientCallbacks(new ClientCB(), false);

		/**
		 * @brief SET THE TIMEOUT HERE (in Milliseconds)
		 * This prevents the "infinite" connection attempt.
		 */
		pClient->setConnectTimeout(2000); // 2 seconds timeout

		/**
		 * @param addr Target MAC
		 * @param deleteAttributes true (clears cache, very stable for BuWizz)
		 * @param asyncConnect false (BLOCKING mode - like the old library)
		 * @param exchangeMTU false (prevents the 3.3.7 crash)
		 */
		if (!pClient->connect(addr, true, false, false)) {
			if (debug) ::Serial.println("[NimBLEClient.Connect][E] Connection failed or timed out.");
			HandleError(ERROR_FAILED_TO_CONNECT);
			return false;
		}

		// --- FROM HERE: Connection is established ---
	
		// Wait for connection to stabilize
		delay(200); 
		pClient->setConnectionParams(12, 12, 0, 60);
		
		// 2. Discover attributes (Important for NimBLE to map UUIDs correctly)
		pClient->discoverAttributes();
		delay(100); 

		if (debug) {
			::Serial.printf("[NimBLEClient][I] Discover attributes\n");
			for (auto &s : pClient->getServices(true)) {
				::Serial.printf("[NimBLEClient][I] Service: %s\n", s->getUUID().toString().c_str());
				for (auto &c : s->getCharacteristics(true)) {
					::Serial.printf("[NimBLEClient][I]  -> Char: %s\n", c->getUUID().toString().c_str());
				}
			}
		}
		
		pService = pClient->getService(serviceUUID);
		if (!pService) {
			HandleError(ERROR_SERVICE_NOT_FOUND);
			pClient->disconnect();
			return false;
		}

		pTXChar = pService->getCharacteristic(txUUID);
		pRXChar = pService->getCharacteristic(rxUUID);

		if (!pTXChar || !pRXChar) {
			if (debug) ::Serial.println("[NimBLEClient.Connect][E] No characteristics found.");
			HandleError(ERROR_CHARACTERISTICS_NOT_FOUND);
			pClient->disconnect();
			return false;
		}

		// Subscribe to notifications (usually on the TX characteristic)
		if (pTXChar->canNotify()) {
			if (debug) ::Serial.println("[NimBLEClient.Connect][I] Notify subscribed");
			pTXChar->subscribe(true, notifyCB);    
		}

		connected = true;
		if (debug) ::Serial.println("[NimBLEClient.Connect][I] OK");
		return true;
	}

	/**
	 * @brief Disconnects and deletes the client instance to free memory.
	 */
	void B4RNimBLEClient::Disconnect() {
		if (pClient) {
			if (pClient->isConnected())
				pClient->disconnect();
			NimBLEDevice::deleteClient(pClient);
			pClient = nullptr;
		}
		connected = false;
	}

	/**
	 * @brief Writes data to the RX characteristic.
	 * Automatically chooses between 'With Response' and 'No Response' write modes.
	 */
	void B4RNimBLEClient::Write(ArrayByte* data) {
		if (!pClient || !pClient->isConnected()) {
			if (debug) ::Serial.println("[NimBLEClient.Write][E] Not connected.");
			return;
		}

		if (!pRXChar) {
			if (debug) ::Serial.println("[NimBLEClient.Write][E] RX Characteristic is null.");
			return;
		}

		// In deiner B4RNimBLEClient::Write Methode:
		bool success = false;

		// Check first "No Response" to avoid NimBLE internal errors
		if (pRXChar->canWriteNoResponse()) {
			success = pRXChar->writeValue((uint8_t*)data->data, (size_t)data->length, false);
			if (debug) ::Serial.println("[NimBLEClient.Write][I] WriteNoResponse");
		} 
		else if (pRXChar->canWrite()) {
			success = pRXChar->writeValue((uint8_t*)data->data, (size_t)data->length, true);
			if (debug) ::Serial.println("[NimBLEClient.Write][I] WriteResponse");
		}
		else {
			if (debug) ::Serial.println("[NimBLEClient.Write][E] Characteristic has NO write properties!");
		}

		if (debug) {
			if (success) ::Serial.println("[NimBLEClient.Write][I] OK");
			else ::Serial.println("[NimBLEClient.Write][E] Write failed");
		}
	}

	/**
	 * @brief Returns the current connection status.
	 */
	bool B4RNimBLEClient::IsConnected() {
		return (pClient && pClient->isConnected());
	}

	// B4R Event Handlers
	void B4RNimBLEClient::HandleConnected() { if (ConnectedSub) ConnectedSub(); }
	void B4RNimBLEClient::HandleDisconnected() { if (OnDisconnectedSub) OnDisconnectedSub(); }
	void B4RNimBLEClient::HandleError(uint8_t code) {
		connected = false;
		if (ErrorSub) ErrorSub(code);
	}

} // namespace B4R
