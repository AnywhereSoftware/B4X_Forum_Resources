/**
 * @file B4RNimBLEAdvertiser.cpp
 * @brief Implementation of NimBLE Advertiser Wrapper for B4R.
 */

#include "B4RDefines.h"
#include "rNimBLEAdvertiser.h"

namespace B4R {
    B4RNimBLEAdvertiser* B4RNimBLEAdvertiser::instance = nullptr;

    // Static storage for the name used during init
    static std::string globalDeviceName;

    void B4RNimBLEAdvertiser::Initialize(B4R::B4RString* DeviceName) {
        if (!NimBLEDevice::isInitialized()) {
            NimBLEDevice::init(DeviceName->data);
        }
        globalDeviceName = DeviceName->data;
        initialized = true;
    }

	void B4RNimBLEAdvertiser::SetManufacturerData(ArrayByte* Data) {
		if (!initialized || Data->length < 2) return;

		// 1. Cast void* to uint8_t*, to get the Bytes
		uint8_t* buffer = (uint8_t*)Data->data;

		// 2. Built data frame for NimBLE.
		// NimBLE's setManufacturerData(std::string) expects ID in String!
		std::string fullPayload;
		fullPayload.append((char*)buffer, Data->length);

		NimBLEAdvertising* pAdv = NimBLEDevice::getAdvertising();
		NimBLEAdvertisementData advData;

		// Flags (important for visibility)
		advData.setFlags(BLE_HS_ADV_F_DISC_GEN | BLE_HS_ADV_F_BREDR_UNSUP);

		// 3. Provide the full String
		advData.setManufacturerData(fullPayload);

		// Assign the data to the advertiser
		pAdv->setAdvertisementData(advData);
	}

    void B4RNimBLEAdvertiser::SetServiceData(UInt UUID, ArrayByte* Data) {
        if (!initialized) return;
        NimBLEAdvertising* pAdv = NimBLEDevice::getAdvertising();
        pAdv->setServiceData(NimBLEUUID((uint16_t)UUID), std::string((char*)Data->data, Data->length));
    }

	void B4RNimBLEAdvertiser::Start(uint32_t DurationMS) {
		if (!initialized) return;
		NimBLEAdvertising* pAdv = NimBLEDevice::getAdvertising();
		
		// 1. Set connection type as pure broadcaster
		pAdv->setConnectableMode(BLE_GAP_CONN_MODE_NON);
		
		// 2. Set name within scan-response.
		NimBLEAdvertisementData scanResponse;
		scanResponse.setName(globalDeviceName.c_str());
		pAdv->setScanResponseData(scanResponse);
		
		// 3. Add flags (improves visibility)
		NimBLEAdvertisementData advData;
		advData.setFlags(BLE_HS_ADV_F_DISC_GEN | BLE_HS_ADV_F_BREDR_UNSUP);
		// Manufacturer Data are set via setManufacturerData
		
		uint32_t durationSec = (DurationMS == 0) ? 0 : (DurationMS / 1000);
		pAdv->start(durationSec);
		
		if (debug) ::Serial.println(F("[B4RNimBLEAdvertiser] Started"));
	}

    void B4RNimBLEAdvertiser::Stop() {
        NimBLEDevice::getAdvertising()->stop();
        if (debug) ::Serial.println(F("[B4RNimBLEAdvertiser] Stopped"));
    }

    void B4RNimBLEAdvertiser::SetDebug(bool Enabled) {
        debug = Enabled;
    }
}
