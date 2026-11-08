#include "B4RDefines.h"

// Define the UUIDs (UPPERCASE)
#define SERVICE_UUID        "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
#define CHARACTERISTIC_UUID "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"

// Namespace with source
namespace B4R {

	// Define static instance pointer
	B4RBLEServer* B4RBLEServer::instance = nullptr;

	// BLE Server Callbacks
	class MyServerCallbacks : public BLEServerCallbacks {

		// Handle client connected
		void onConnect(BLEServer* pServer) {
			if (B4RBLEServer::GetInstance()) {
				B4RBLEServer::GetInstance()->SetDeviceConnected(true);
			}
		}

		// Handle client disconnected
		void onDisconnect(BLEServer* pServer) {
			// Ensured advertising restarts after disconnect
			if (B4RBLEServer::GetInstance()) {
				B4RBLEServer::GetInstance()->SetStartAdvertising();
			}
		}

		/**
		NOT SUPPORTED
		void onMtuChanged(BLEServer* pServer, uint16_t mtu) override {
			::Serial.print("MTU size changed to: ");
			::Serial.println(mtu);
		}
		*/
	};

	// BLE Characteristic Callbacks
	// NOTE: ESP32 BLE 3.x versions, getValue() returns an std::vector<uint8_t>
	class MyCallbacks : public BLECharacteristicCallbacks {
		void onWrite(BLECharacteristic *pCharacteristic) {
			// Get the value as a String (it might contain raw bytes, but it's a String)
			String valueStr = pCharacteristic->getValue();
			
			// Convert the String to a vector of bytes
			std::vector<uint8_t> value;
			for (size_t i = 0; i < valueStr.length(); ++i) {
				value.push_back(static_cast<uint8_t>(valueStr[i]));
			}

			// Debugging: print the received value
			//::Serial.print("[onWrite] Received data: ");
			//for (size_t i = 0; i < value.size(); ++i) {
			//	::Serial.print("0x");
			//	::Serial.print(value[i], HEX);
			//	::Serial.print(" ");
			//}
			//::Serial.println();

			// Proceed with handling the data if not empty
			if (!value.empty() && B4RBLEServer::GetInstance()) {
				B4RBLEServer::GetInstance()->HandleDataReceived(value);
			}
		}
	};

	// Initialize new instance.
	void B4RBLEServer::Initialize (B4RString* Name, SubVoidArray NewDataSub, SubVoidByte ErrorSub, UInt mtuSize) {
		instance = this;  
		this->NewDataSub = NewDataSub;
		this->ErrorSub = ErrorSub;

		// Ensure fresh start followed by short delay.
        BLEDevice::deinit();
		delay(100);
		
		// Set server name
        BLEDevice::init(Name->data);

		// Create the server
        pServer = BLEDevice::createServer();

		// Set the MTU size (Maximum Transmission Unit)
		// Required for MTU negotiation
		pServer->getAdvertising()->setMinPreferred(0x06);
		// Recommended max value
		pServer->getAdvertising()->setMaxPreferred(0x12);
		// Set MTU size (default 23, max 512), ensure MTU is within valid range.
		uint16_t mtu = mtuSize;
		if (mtu < MTU_SIZE_MIN || mtu > MTU_SIZE_MAX) {
			// ::Serial.println("[WARNING][Initialize] MTU out of range 23-512, set default 23");
			HandleError(WARNING_INVALID_MTU);
			// MTU is invalid, set default
			mtu = MTU_SIZE_MIN;
		}	
		BLEDevice::setMTU(mtu);

		// Set BLE transmit power to maximum (+9 dBm)
		// ::Serial.println("Setting transmit power...");
		esp_ble_tx_power_set(ESP_BLE_PWR_TYPE_DEFAULT, ESP_PWR_LVL_P9);
		
		// Set the server callbacks
        pServer->setCallbacks(new MyServerCallbacks());

		// Create service and set characteristics
        pService = pServer->createService(SERVICE_UUID);
		// Ensure to enable READ + WRITE + NOTIFY
        pCharacteristic = pService->createCharacteristic(
            CHARACTERISTIC_UUID,
            BLECharacteristic::PROPERTY_READ |
            BLECharacteristic::PROPERTY_WRITE |
            BLECharacteristic::PROPERTY_NOTIFY
        );

		// Add notifier descriptor 0x2902 to enable notifications
		// BLEDescriptor *pDescriptor = new BLEDescriptor(BLEUUID((uint16_t)0x2902));
		// pCharacteristic->addDescriptor(pDescriptor);
		
		pCharacteristic->addDescriptor(new BLE2902());
        pCharacteristic->setCallbacks(new MyCallbacks());

		// Start the service
		pService->start();

		// Start advertising
		SetStartAdvertising();
	}

	// Restart advertising
    void B4RBLEServer::SetStartAdvertising() {
        deviceConnected = false;
		BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();

		// Ensure service UUID is advertised
		pAdvertising->addServiceUUID(SERVICE_UUID);

		// Set scan response to provide more data
		pAdvertising->setScanResponse(true);

		// Default settings for improved compatibility
		pAdvertising->setMinPreferred(0x06);
		pAdvertising->setMaxPreferred(0x12);

		// Start advertising properly		
		pAdvertising->start();
    }

	// Get the client connection state
	bool B4RBLEServer::Connected() {
		return deviceConnected;
	}

	// Set device connected state
	void B4RBLEServer::SetDeviceConnected(bool status) {
        deviceConnected = status;
    }

	// Handle the data received from connected client
	void B4RBLEServer::HandleDataReceived(std::vector<uint8_t>& value) {

		//::Serial.println("[HandleDataReceived]");
		//for (auto v : value) {
		//	::Serial.print(v, HEX);
		//	::Serial.print(" ");
		//}
		//::Serial.println();

		ArrayByte b4rData;
		b4rData.data = (Byte*)value.data();
		b4rData.length = value.size();
		// Call the new data handler in the B4R code
		NewDataSub(&b4rData);
	}

	// Write data to the connected client.
	void B4RBLEServer::Write(ArrayByte* data) {

		if (pCharacteristic == nullptr) {
			// ::Serial.println("[ERROR][Write] failed: No valid characteristic.");
			HandleError(ERROR_INVALID_CHARACTERISTIC);
			return;
		}

		if (data->length == 0) {
			// ::Serial.println("[ERROR][Write] failed: Empty data.");
			HandleError(ERROR_EMPTY_DATA);
			return;
		}

		// Write the value
		pCharacteristic->setValue((uint8_t*)data->data, data->length);
		// Explicit notify after writing data
		pCharacteristic->notify();
	}

	void B4RBLEServer::WriteAdvertisement(ArrayByte* data) {
		BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();

		// Stop advertising before updating data
		pAdvertising->stop();

		// Create new advertisement data
		BLEAdvertisementData advertisementData;
		
		// Convert byte array to String
		String manufacturerData = "";
		
		// Cast the void* data->data to a uint8_t* (pointer to bytes)
		uint8_t* byteArray = (uint8_t*)data->data;
		
		// Iterate through byte array
		for (int i = 0; i < data->length; i++) {
			manufacturerData += String(byteArray[i], HEX);  // Convert byte to hex and append to String
		}
		
		// Set manufacturer data
		advertisementData.setManufacturerData(manufacturerData);
		
		// Apply new advertisement data
		pAdvertising->setAdvertisementData(advertisementData);
		
		// Restart advertising with updated data
		pAdvertising->start();
	}

	// Handle errors by calling the B4R sub defined in Initialize
	// errorcode - Error code as defined in the header defines.
	void B4RBLEServer::HandleError(uint8_t errorcode) {
		//::Serial.print("[HandleError]code=");
		//::Serial.println(errorcode);

		// Call the error handler in the B4R code
		if (ErrorSub) {
			ErrorSub(errorcode);
		}
	}

}
