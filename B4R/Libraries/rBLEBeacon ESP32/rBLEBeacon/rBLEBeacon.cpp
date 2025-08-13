#include "B4RDefines.h"

// Namespace with source
namespace B4R {
		
	void B4RBLEBeacon::Initialize(B4RString* Name, SubVoidByte ErrorSub) {
		// Assign the event errorsub
		this->ErrorSub = ErrorSub;

		// Ensure fresh start followed by short delay
		::Serial.println("Deinitializing BLE...");
		BLEDevice::deinit();
		delay(200);  // Increased delay

		::Serial.println("Initializing BLE...");
		BLEDevice::init(Name->data);
		
		// Debugging: Check available heap memory
		::Serial.print("Free heap memory: ");
		::Serial.println(ESP.getFreeHeap());

		// Set BLE transmit power to maximum (+9 dBm)
		::Serial.println("Setting transmit power...");
		esp_ble_tx_power_set(ESP_BLE_PWR_TYPE_DEFAULT, ESP_PWR_LVL_P9);

		/**
		// Define the scan parameters
		esp_ble_scan_params_t ble_scan_params = {};
		ble_scan_params.scan_type = BLE_SCAN_TYPE_ACTIVE;
		ble_scan_params.own_addr_type = BLE_ADDR_TYPE_PUBLIC;
		ble_scan_params.scan_filter_policy = BLE_SCAN_FILTER_ALLOW_ALL;
		ble_scan_params.scan_interval = 0x50;  // Scan interval
		ble_scan_params.scan_window = 0x30;    // Scan window

		// Set the scan parameters
		::Serial.println("Setting scan parameters...");
		esp_ble_gap_set_scan_params(&ble_scan_params);

		// Explicitly get the Bluetooth address
		::Serial.println("Getting Bluetooth address...");
		esp_bd_addr_t bd_addr;
		esp_bt_dev_address(bd_addr);  // Get the Bluetooth address
	
		// Set connection parameters (example values) - using nullptr for bd_addr
		::Serial.println("Setting connection parameters...");
		esp_ble_gap_set_prefer_conn_params(nullptr, 0x06, 0x20, 0, 300);  // Example: 15ms connection interval, 0 slave latency, 300ms timeout
		*/
		
		::Serial.println("Initialization complete.");
	}
	void B4RBLEBeacon::Advertise(ArrayByte* data) {
		
		// Check data size first (max 31 bytes)
		if (data->length > MAX_ADV_DATA_SIZE) {
			HandleError(ERROR_ADV_DATA_SIZE_TOO_LARGE);
			return;
		}

		// Debug: Print the data advertised by B4R
		::Serial.print("[B4RBLEBeacon::WriteAdvertisement] B4R data: ");
		for (size_t i = 0; i < data->length; i++) {
			if ( ((uint8_t*)data->data)[i] < 0x10 ) {
				::Serial.print("0");
			}
			::Serial.print( ((uint8_t*)data->data)[i], HEX);
			// ::Serial.print(" "); // space between hex values
		}
		::Serial.println();
		
		// Stop advertising before updating data
		BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
		pAdvertising->stop();

		// Create BLEAdvertisementData object
		BLEAdvertisementData advertisementData;

		// Set flags (optional, general discoverable, BR/EDR not supported)
		advertisementData.setFlags(0x06);

		// Prepare the advertisement data with Eddystone-UID format
		// Frame type + namespace + instance ID + TX Power + ArrayByte data
		uint8_t size = 1 + sizeof(NAMESPACE_ID) + sizeof(INSTANCE_ID) + 1 + data->length;
		uint8_t advertisementDataBuffer[size];

		// Set Eddystone-UID frame data
		advertisementDataBuffer[0] = FRAME_TYPE_EDDYSTONE_UID;
		memcpy(advertisementDataBuffer + 1, NAMESPACE_ID, sizeof(NAMESPACE_ID));
		memcpy(advertisementDataBuffer + 11, NAMESPACE_ID, sizeof(NAMESPACE_ID));
		advertisementDataBuffer[17] = TX_POWER_DEFAULT;

		// Copy ArrayByte data (passed from the argument) into the advertisement buffer
		memcpy(advertisementDataBuffer + 18, data->data, data->length);

		// Set the manufacturer data with the entire advertisement data (Eddystone-UID + ArrayByte)
		advertisementData.setManufacturerData(String((char*)advertisementDataBuffer, size));

		// Apply new advertisement data
		pAdvertising->setAdvertisementData(advertisementData);

		// Debug: Print the full advertised data
		::Serial.print("[B4RBLEBeacon::WriteAdvertisement] Advertised data: ");
		for (size_t i = 0; i < size; i++) {
			if (advertisementDataBuffer[i] < 0x10) {
				::Serial.print("0");
			}
			::Serial.print(advertisementDataBuffer[i], HEX);
			// ::Serial.print(" "); // space between hex values
		}
		::Serial.println();

		// Start advertising again
		pAdvertising->start();
	}

	void B4RBLEBeacon::AdvertiseRaw(ArrayByte* data, bool serviceinfo) {

		// Check data size first (max 31 bytes)
		if (data->length == 0) {
			::Serial.println("[B4RBLEBeacon::AdvertiseRaw] No data");
			HandleError(ERROR_ADV_NO_DATA);
			return;
		}

		// Stop advertising before updating data
		BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
		pAdvertising->stop();

		// Create BLEAdvertisementData object
		BLEAdvertisementData advertisementData;

		// General discoverable, BR/EDR not supported
		advertisementData.setFlags(0x06);

		// Prepare the environment data directly for service data (no manufacturer data)
		size_t advDataSize = data->length;
		uint8_t advData[advDataSize];

		// Copy the entire payload (data) into the advertisement data array
		memcpy(advData, data->data, data->length);

		// Debug: Print full constructed advertisement data as hex
		::Serial.println("[B4RBLEBeacon::AdvertiseRaw] Advertised data size: " + String(advDataSize));
		::Serial.print("[B4RBLEBeacon::AdvertiseRaw] Advertised data: ");
		for (size_t i = 0; i < advDataSize; i++) {
			if (advData[i] < 0x10) ::Serial.print("0");
			::Serial.print(advData[i], HEX);
		}
		::Serial.println();

		// Check if serviceinfo data to be advertised or manufacturer data
		if (serviceinfo) {
			// Only the environment data, which is the 4-byte payload
			// Environmental Sensing service UUID
			BLEUUID serviceUUID((uint16_t)0x181A);
			// Use the 4-byte environment data
			String serviceData((const char*)advData, advDataSize);
			// Set environment data as service data
			advertisementData.setServiceData(serviceUUID, serviceData);
		} else {
			// Create a String object using the raw binary data (advData) and its size
			String manufacturerData((const char*)advData, advDataSize);
			// Set manufacturer data correctly as raw binary data in String
			advertisementData.setManufacturerData(manufacturerData);
		}
		
		// Apply the new advertisement data
		pAdvertising->setAdvertisementData(advertisementData);

		// Start advertising again
		pAdvertising->start();
	}

    // Handle errors by calling the B4R sub defined in Initialize
    // errorcode - Error code as defined in the header defines.
    void B4RBLEBeacon::HandleError(uint8_t errorcode) {
        // Call the error handler in the B4R code
        if (ErrorSub) {
            ErrorSub(errorcode);
        }
    }
}
