/**
 * @file rNimBLEServer.cpp
 * @brief Implementation of NimBLE Server Wrapper for B4R.
 */

#include "B4RDefines.h"
#include "rNimBLEServer.h"

namespace B4R {

	B4RNimBLEServer* B4RNimBLEServer::instance = nullptr;

	/**
	 * @brief Server callbacks (connect/disconnect)
	 */
	class ServerCB : public NimBLEServerCallbacks {

		void onConnect(NimBLEServer* s, NimBLEConnInfo& connInfo) override {
			if (B4RNimBLEServer::instance) {
				B4RNimBLEServer::instance->SetConnected(true);
				B4RNimBLEServer::instance->HandleConnect();
			}
		}

		void onDisconnect(NimBLEServer* s, NimBLEConnInfo& connInfo, int reason) override {
			if (B4RNimBLEServer::instance) {

				B4RNimBLEServer::instance->SetConnected(false);
				B4RNimBLEServer::instance->HandleDisconnect();

				// IMPORTANT: restart advertising
				NimBLEDevice::startAdvertising();

				if (B4RNimBLEServer::instance->debug) {
					::Serial.println("[NimBLEServer.onDisconnect] Re-advertising after disconnect");
				}
			}
		}
	};

	/**
	 * @brief Characteristic callbacks (write)
	 */
	class CharCB : public NimBLECharacteristicCallbacks {

		void onWrite(NimBLECharacteristic* c, NimBLEConnInfo& connInfo) override {
			if (!B4RNimBLEServer::instance) return;

			std::string value = c->getValue();

			B4RNimBLEServer::instance->HandleWrite(
				(uint8_t*)value.data(),
				value.length()
			);
		}
	};

	void B4RNimBLEServer::Initialize(
		B4RString* DeviceName,
		B4RString* ServiceUUID,
		B4RString* CharUUID,
		SubVoidVoid OnConnected,
		SubVoidVoid OnDisconnected,
		SubVoidArray OnWrite,
		bool Debug
	) {
		instance = this;
		debug = Debug;

		// GPIO
		pinMode(ONBOARD_LED_PIN, OUTPUT);

		// Events
		ConnectedSub = OnConnected;
		DisconnectedSub = OnDisconnected;
		WriteSub = OnWrite;

		// BLE
		deviceName = std::string((const char*)DeviceName->data, DeviceName->getLength());

		serviceUUID = NimBLEUUID(std::string((const char*)ServiceUUID->data, ServiceUUID->getLength()).c_str());
		charUUID    = NimBLEUUID(std::string((const char*)CharUUID->data, CharUUID->getLength()).c_str());

		if (!nimbleInitialized) {
			NimBLEDevice::init(deviceName.c_str());
			NimBLEDevice::setPower(ESP_PWR_LVL_P9);
			NimBLEDevice::setSecurityAuth(false, false, false);
			nimbleInitialized = true;
		}

		if (debug) ::Serial.println("[NimBLEServer.Initialize][I] OK");
	}

	void B4RNimBLEServer::Start() {

		pServer = NimBLEDevice::createServer();
		pServer->setCallbacks(new ServerCB());

		pService = pServer->createService(serviceUUID);

		pCharacteristic = pService->createCharacteristic(
			charUUID,
			NIMBLE_PROPERTY::READ |
			NIMBLE_PROPERTY::WRITE |
			NIMBLE_PROPERTY::NOTIFY
		);

		pCharacteristic->setCallbacks(new CharCB());

		pService->start();

		// --- Advertising ---
		pAdvertising = NimBLEDevice::getAdvertising();

		NimBLEAdvertisementData advData;
		advData.setName(deviceName);
		advData.addServiceUUID(serviceUUID);

		pAdvertising->setAdvertisementData(advData);

		// Optional but safe
		NimBLEAdvertisementData scanData;
		pAdvertising->setScanResponseData(scanData);

		pAdvertising->start();

		if (debug) {
			::Serial.println("[NimBLEServer.Start][I] Advertising started");
		}
	}


	void B4RNimBLEServer::Stop() {
		if (pAdvertising) pAdvertising->stop();
		if (debug) ::Serial.println("[NimBLEServer.Stop][I] Stopped");
	}

	void B4RNimBLEServer::Write(ArrayByte* data) {
		if (!connected || !pCharacteristic) return;

		pCharacteristic->setValue((uint8_t*)data->data, data->length);
		pCharacteristic->notify();

		if (debug) ::Serial.println("[NimBLEServer.Write][I] Notify sent");
	}

	void B4RNimBLEServer::SetConnected(bool state) {
		connected = state;
	}

	bool B4RNimBLEServer::IsConnected() {
		return connected;
	}

	// --- Internal Handlers ---

	void B4RNimBLEServer::HandleConnect() {
		if (ConnectedSub) ConnectedSub();
	}

	void B4RNimBLEServer::HandleDisconnect() {
		if (DisconnectedSub) DisconnectedSub();
	}

	void B4RNimBLEServer::HandleWrite(uint8_t* data, size_t length) {
		if (!WriteSub) return;

		if (debug) {
			::Serial.print("[NimBLEServer.HandleWrite] RX: ");
			for (size_t i = 0; i < length; i++) {
				::Serial.printf("%02X ", data[i]);
			}
			::Serial.println();
		}

		// Forward raw data to B4R
		if (WriteSub) {
			ArrayByte arr;
			arr.data = data;
			arr.length = length;
			WriteSub(&arr);
		}
	}

	/*
	NOT USED - Example handling direct HubController 5-byte commands
	void B4RNimBLEServer::HandleWriteHC(uint8_t* data, size_t length) {
		if (length < 5) {
			if (debug) ::Serial.println("[HandleWrite][E] Invalid command length");
			return;
		}

		if (debug) {
			::Serial.print("[HandleWrite] RX: ");
			for (size_t i = 0; i < length; i++) {
				::Serial.printf("%02X ", data[i]);
			}
			::Serial.println();
		}

		// --- Validate frame ---
		if (data[0] != FRAME_START || data[length - 1] != FRAME_END) {
			if (debug) ::Serial.println("[HandleWrite][E] Invalid frame markers");
			return;
		}

		uint8_t adr = data[1];
		uint8_t cmd = data[2];
		uint8_t val = data[3];

		if (debug) {
			::Serial.print("[HandleWrite][I] ");
			::Serial.printf("adr=%02X ", adr);
			::Serial.printf("cmd=%02X ", cmd);
			::Serial.printf("val=%02X ", val);
			::Serial.println();
		}

		// --- Command handling ---
		switch (cmd) {
			::Serial.print("[HandleWrite][I] execute command");

			case SYSTEM_CMD_ONBOARD_LED: {
				if (val == STATE_OFF) {					
					digitalWrite(ONBOARD_LED_PIN, LOW);
					if (debug) ::Serial.println("[HandleWrite] Onboard-LED OFF");
				} else if (val == STATE_ON) {
					digitalWrite(ONBOARD_LED_PIN, HIGH);
					if (debug) ::Serial.println("[HandleWrite] Onboard-LED ON");
				}
				// --- after command execution ---
				SendAck(data, length);
				break;
			}

			default:
				if (debug) ::Serial.printf("[HandleWrite][W] Unknown CMD: 0x%02X\n", cmd);
				break;
		}

		// Forward raw data to B4R (optional)
		if (WriteSub) {
			ArrayByte arr;
			arr.data = data;
			arr.length = length;
			WriteSub(&arr);
		}
	}
	*/
	
	void B4RNimBLEServer::SendAck(uint8_t* data, size_t length) {
		if (!connected || !pCharacteristic) return;

		pCharacteristic->setValue(data, length);
		pCharacteristic->notify();

		if (debug) {
			::Serial.print("[NimBLEServer.ACK] TX: ");
			for (size_t i = 0; i < length; i++) {
				::Serial.printf("%02X ", data[i]);
			}
			::Serial.println();
		}
	}


} // namespace B4R
