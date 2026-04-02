/**
 * @file rNimBLEScanner.cpp
 * @brief Implementation of NimBLE Scanner Wrapper for B4R.
 */

#include "B4RDefines.h"
#include "rNimBLEScanner.h"

namespace B4R {
    B4RNimBLEScanner* B4RNimBLEScanner::instance = nullptr;

	// Handle only known services ID.
	// Extend the list as required.
	const uint16_t B4RNimBLEScanner::knownServiceUUIDs[4] = {0x181A, 0xFE95, 0xFCD2, 0xAAFE};

    class ScannerCallbacks : public NimBLEScanCallbacks {
        void onResult(const NimBLEAdvertisedDevice* device) override {
            B4RNimBLEScanner::HandleResult(device);
        }
    };

    void B4RNimBLEScanner::Initialize(SubVoidArrayArray NewData) {
        instance = this;
		NewDataSub = NewData;

		// Optional: Reset filters on re-init
		filterMac = false;
		filterCompanyID = false;
		
        if (!NimBLEDevice::isInitialized()) {
            NimBLEDevice::init("");
        }
        pCallbacks = new ScannerCallbacks();
        initialized = true;
		
		if (debugMode) {
			::Serial.printf("[B4RNimBLEScanner.Initialize][I] OK\n");
		}
    }

	void B4RNimBLEScanner::Start(ULong DurationMS, bool DoNotAllowDuplicates) {
		if (!initialized) return;
		NimBLEScan* pScan = NimBLEDevice::getScan();
		
		// IMPORTANT: Reset the scan each time to prevent state issues
		pScan->setScanCallbacks(pCallbacks, false);
		
		pScan->setActiveScan(true);
		
		// Set to false to see every advertisement
		pScan->setDuplicateFilter(DoNotAllowDuplicates);
		
		// Explicitly set timing (Interval 100ms, Window 99ms)
		pScan->setInterval(100);
		pScan->setWindow(99);
		
		// NimBLE start takes MS.
		// If 0 is passed, it scans forever.
		uint32_t durationSeconds = (DurationMS == 0) ? 0 : (uint32_t)(DurationMS);
		
		// parameters: duration(s), is_continious(bool), scan_type(active/passive)
		pScan->start(durationSeconds, false); 

		if (debugMode) {
			::Serial.printf("[B4RNimBLEScanner.Start][I] Duration: %d s\n", durationSeconds);
		}
	}

    void B4RNimBLEScanner::Stop() {
        NimBLEDevice::getScan()->stop();
		if (debugMode) { 
			::Serial.printf("[B4RNimBLEScanner.Stop][I]\n");
		}
    }

	void B4RNimBLEScanner::HandleResult(const NimBLEAdvertisedDevice* device) {
		if (!instance || !instance->NewDataSub) return;

		std::string data;
		bool isServiceData = false;

		// 1. Get Data (Check Manufacturer OR Service Data)
		if (device->haveManufacturerData()) {
			data = device->getManufacturerData();
		} else if (device->haveServiceData()) {

			// Selective UUIDs
			for (int i = 0; i < B4RNimBLEScanner::numKnownUUIDs; i++) {
				std::string d = device->getServiceData(NimBLEUUID(B4RNimBLEScanner::knownServiceUUIDs[i]));
				if (d.length() > 0) {
					data = d;
					isServiceData = true;
					break;
				}
			}
		}
		
		// No data > leave
		if (data.length() < 2) return; 

		// 2. Company ID Filter (Only applies to Manufacturer Data)
		if (!isServiceData && instance->filterCompanyID) {
			uint16_t currentID = (uint8_t)data[0] | ((uint8_t)data[1] << 8);
			if (currentID != instance->targetCompanyID) return;
		}

		// 3. Prepare MAC (Human readable order)
		const uint8_t* macRaw = device->getAddress().getBase()->val;
		uint8_t macRev[6];
		for (int i = 0; i < 6; i++) {
			macRev[i] = macRaw[5 - i];
		}

		// 4. MAC Filter
		if (instance->filterMac && memcmp(macRev, instance->targetMac, 6) != 0) return;

		// 5. Wrap and Send
		B4R::ArrayByte macArr;
		macArr.data = macRev;
		macArr.length = 6;

		B4R::ArrayByte dataArr;
		dataArr.data = (uint8_t*)data.data();
		dataArr.length = data.length();

		instance->NewDataSub(&macArr, &dataArr);
	}

	void B4RNimBLEScanner::SetCompanyFilter(UInt CompanyID) { 
		targetCompanyID = CompanyID; 
		filterCompanyID = (CompanyID != 0); 
	}			

	void B4RNimBLEScanner::SetMacFilter(ArrayByte* TargetMAC) {
		if (TargetMAC == NULL || TargetMAC->length < 6) {
			filterMac = false;
			if (debugMode) {
				::Serial.printf("[B4RNimBLEScanner.SetTargetMac][E] MAC incorrect\n");
			}
		} else {
			// Copy the bytes from the B4R array into our class buffer
			// Note: TargetMAC->data is the byte pointer
			memcpy(targetMac, TargetMAC->data, 6);
			filterMac = true;
			if (debugMode) {
				::Serial.printf(
					"[B4RNimBLEScanner.SetTargetMac][I] mac=%02X:%02X:%02X:%02X:%02X:%02X\n",
					targetMac[0], targetMac[1], targetMac[2], targetMac[3], targetMac[4], targetMac[5]);
			}
		}
	}

	void B4RNimBLEScanner::SetDebug(bool Enabled) {
		debugMode = Enabled;
	}

}
