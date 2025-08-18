// B4R Library rMiLYWSD03MMC
// Xiaomi Mi Temperature and Humidity Monitor 2, Model LYWSD03MMC
#include "B4RDefines.h"

namespace B4R {
	// Debug flag
	bool isDebug = false;
	
	// Declare the BLEClient
	BLEClient* pClient;

	// Sensor address as MAC address - created as sensorAddress = new BLEAddress("A4:C1:38:38:A9:0C");
	static BLEAddress *sensorAddress;

	// BLEUUID's for the service and characterictics - defined in the header file
	static BLEUUID serviceUUID(SERVICE_UUID);
	static BLEUUID charUUID(CHAR_UUID);
	
	// Flag if scanning complete and data is available or error occurred
	bool isScanCompleted = false;

	// Data as result from scanning. Init with error value.
	int DATA_ERROR_VALUE = -9999;
	float temperature = DATA_ERROR_VALUE;
	float humidity = DATA_ERROR_VALUE;
	float battery = DATA_ERROR_VALUE;

	// Status code: OK=1, ERROR<>1 - see header file defines
	int statusCode = B4RMITHM_STATUS_UNKNOWN;

	/*
	* C++ Code
	*/
	
	// Callback for the advertised characterictic = get notified there is data.
	// The pData has a length of 5:
	// temperature Degree C = array index 0 and 1 - as little endian to be divided by 100 = NN.NN C
	// humidity %RH = array index 2 - no conversion required
	// battery Voltage between 2100 & 3100 = array index 3 and 4  - as little endian to be divided by 1000 = 2.1 - 3.1 V
	static void notifyCallback(BLERemoteCharacteristic* pBLERemoteCharacteristic, uint8_t* pData, size_t length, bool isNotify) {
		if (isNotify) {
			if (isDebug) { 
				::Serial.print("[DEBUG] Data received HEX: ");
				for (int i = 0; i < length; i++) {
					::Serial.print(pData[i],HEX);
					::Serial.print(" ");
				}
				::Serial.println("");
			}
			temperature	= (pData[0] | (pData[1] << 8)) * 0.01;	//little endian 
			humidity	= pData[2];
			battery		= (pData[3] | (pData[4] << 8)) * 0.001; //little endian 
			if (isDebug) { ::Serial.printf("[DEBUG] T = %.2f H = %.1f B = %.2f\n", temperature, humidity, battery); }

			// Stop scanning (else the device keeps on scanning) and disconnect the client
			BLEDevice::getScan()->stop();
			if (isDebug) { ::Serial.println("[DEBUG] Background scan stopped"); }
			pClient->disconnect();
			if (isDebug) { ::Serial.println("[DEBUG] Client disconnected"); }
			// Set status code
			statusCode = B4RMITHM_STATUS_OK;
			isScanCompleted = true;
		}
	}

	// Get the client data by connecting to the device, get the service UUID and the characteristics to read the data from
	void getBLEClientData() {
		if (isDebug) { ::Serial.println("[DEBUG] Get client data"); }
		// Create BLE client
		pClient = BLEDevice::createClient();
		if (isDebug) { ::Serial.println("[DEBUG] Connecting..."); }
		// Connect to the device
		bool success = pClient->connect(*sensorAddress);
		// bool success = pClient->connect(BLEAddress(BLE_ADDR));
		// If not connected, delete the client and set scan completed which is handled by the looper()
		if(!success) {
			BLEDevice::deleteClient(pClient);
			if (isDebug) { ::Serial.println("[DEBUG] Failed to connect"); }
			statusCode = B4RMITHM_STATUS_ERR_CONNECT;
			isScanCompleted = true;
			return;
		}
		if (isDebug) { ::Serial.println("[DEBUG] Client connected"); }

		// Get the service looking for
		BLERemoteService * pRemoteService = pClient->getService(BLEUUID(serviceUUID));
		// Service not found
		if(pRemoteService == nullptr) {
			if (isDebug) { ::Serial.printf("[DEBUG] Failed to find service UUID: %s\r", serviceUUID.toString().c_str()); }
			statusCode = B4RMITHM_STATUS_ERR_SERVICEUUID;
			isScanCompleted = true;
		}
		else {
			if (isDebug) { ::Serial.printf("[DEBUG] Found service UUID: %s\r", serviceUUID.toString().c_str()); }
			// Obtain a reference to the characteristic in the service of the remote BLE server.
			BLERemoteCharacteristic * pRemoteCharacteristic = pRemoteService->getCharacteristic(BLEUUID(charUUID));
			if(pRemoteCharacteristic == nullptr) {
				if (isDebug) { ::Serial.printf("[DEBUG] Failed to find characteristic UUID: %s\r", charUUID.toString().c_str()); }
				statusCode = B4RMITHM_STATUS_ERR_CHARUUID;
				isScanCompleted = true;
			}
			else {
				// Characteristic found, register the notification to get the data broadcasted by the device
				if (isDebug) { ::Serial.printf("[DEBUG] Found characteristic UUID: %s\r", charUUID.toString().c_str()); }
				pRemoteCharacteristic->registerForNotify(notifyCallback);
			}
		}
	}

	/*
	*
	* B4R Code
	*
	*/

	// Init the device and set the callbacks
	void B4RMITHM::Initialize(SubVoidVoid ScanCompletedSub, B4RString* Addr, bool Debug) {
		// Set the debug flag
		isDebug = Debug;
		if (isDebug) { ::Serial.println("[DEBUG] Initializing"); }
		// Assign the scan completed  sub
		this->ScanCompletedSub = ScanCompletedSub;
		// Set the sensor address
		sensorAddress = new BLEAddress(Addr->data);
		// Init the BLE device with no name
		BLEDevice::init("");
		// Set the power level to max
		BLEDevice::setPower(ESP_PWR_LVL_P9, ESP_BLE_PWR_TYPE_SCAN);
		// Setup the looper for the sub scancompleted handled by the looper()
		FunctionUnion fu;
		fu.PollerFunction = looper;
		pollers.add(fu, this);
	}

	// Scan for data by connecting to the device and register notification callback with data
	// If the connection fails, set isScanCompleted to true so the looper can action with status 0.
	void B4RMITHM::Scan(){
		getBLEClientData();
	}

	// Get the temperature from the global var
	float B4RMITHM::getTemperature(){
		return temperature;
	}

	// Get the humidity from the global var
	float B4RMITHM::getHumidity(){
		return humidity;
	}

	// Get the battery from the global var
	float B4RMITHM::getBattery(){
		return battery;
	}

	// Get the status from the global var
	int B4RMITHM::getStatusCode(){
		return statusCode;
	}

	// Looper listing if the data scan has completed.
	// The data has to be retrieved from the functions getTemperature ...
	// Ensure to set isScanCompleted to false, else endless looper.
	void B4RMITHM::looper(void* b) {
		B4RMITHM* me = (B4RMITHM*)b; 
		if (isScanCompleted) {
			// Set the statusCode by checking temperature value: 0=ERROR,1=OK
			if (isDebug) { ::Serial.printf("[DEBUG] Scan completed, Status: %d\r", statusCode); }
			// Link back to the callback
			me->ScanCompletedSub();
			// Work is done = no data available anymore
			isScanCompleted = false;
		}
	}

}
