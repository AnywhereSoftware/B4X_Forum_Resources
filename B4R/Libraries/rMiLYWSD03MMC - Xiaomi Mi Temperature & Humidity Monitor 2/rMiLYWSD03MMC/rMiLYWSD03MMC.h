// B4R Library rMiLYWSD03MMC
// Xiaomi Mi Temperature and Humidity Monitor 2, Model LYWSD03MMC
// Read temperature (C), humidity (RH%) and battery (Voltage).
// The library is based on the Bluetooth Low Energy (BLE) library for Arduino-ESP32 based on NimBLE:
// https://github.com/h2zero/NimBLE-Arduino , https://www.arduino.cc/reference/en/libraries/nimble-arduino/
// The NimBLE-Arduino library functions are not wrapped but used in dedicated functions defined in the rMiLYWSD03MMC library.
// The power level is set to max +9dbm (ESP_PWR_LVL_P9).
// Tested with the module ESP-WROOM-32 and B4R 3.71
// Dependencies: Library NimBLE-Arduino (must be instaled via the Arduino IDE).
// 20210619 rwbl

#pragma once
#include "B4RDefines.h"
// Include the NimBLE library located in the Arduino IDE libraries folder (installed via the Arduino IDE)
#include <NimBLEDevice.h>

//~Author: Robert W.B. Linn
//~Version: 1.0
//~Event: ScanCompleted
namespace B4R {
	//~shortname: MiLYWSD03MMC
	
	// Defines used in the CPP global var declarations
	// UUID for the remote service to connect to.
	#define SERVICE_UUID	"ebe0ccb0-7a0a-4b0c-8a1a-6ff2997da3a6"

	// UUID for characteristic of the remote service holding the temp+hum+battery data.
	#define CHAR_UUID		"ebe0ccc1-7a0a-4b0c-8a1a-6ff2997da3a6"
	
	class B4RMITHM {
		private:
			SubVoidVoid ScanCompletedSub;
			static void looper(void *);
		public:
			// Initializes the object.
			// ScanCompletedSub - The sub to call when the scan for data is completed.
			// Addr - Device MAC address - a4:c1:38:38:a9:0c.
			// Debug - Set to true to log the various steps from init to getting data.
			// Example: <code>
			// Private miSensor As MiLYWSD03MMC
			// miSensor.Initialize("miSensor_ScanCompleted", "a4:c1:38:38:a9:0c", False)
			// Sub miSensor_ScanCompleted
			//	If (miSensor.StatusCode = miSensor.STATUS_OK) Then
			//		Log("T: ", miSensor.Temperature, " C, H: ", miSensor.Humidity, " %, B: ", miSensor.Battery, " V")
			//	Else
			//		Log("Error scanning BLE device.")
			//	End If
			// End Sub
			// </code>
			void Initialize(SubVoidVoid ScanCompletedSub, B4RString* Addr, bool Debug=false);

			// Scan for the sensor data. This is done once. Use B4R timer to scan frequent.
			// Lookup sub _ScanCompleted for the result.
			// Example: <code>
			// miSensor.Scan
			// </code>
			void Scan();

			// Get the temperature in Degree C.
			// Example: <code>
			// Dim t as Double = miSensor.Temperature
			// </code>
			float getTemperature();

			// Get the Humidity in %RH.
			// Example: <code>
			// Dim h as Double = miSensor.Humidity
			// </code>
			float getHumidity();
			
			// Get the Battery Voltage between 2.1 and 3.1 V.
			// Example: <code>
			// Dim b as Double = miSensor.Battery
			// </code>
			float getBattery();
			
			// Get the status of the sensor scan: OK=1 else error (see STATUS constants).
			// Example: <code>
			// Dim statusCode as Byte = miSensor.StatusCode
			// If (miSensor.StatusCode = miSensor.STATUS_OK) Then
			//   'OK
			// Else
			//   'Error
			// End
			// </code>
			int getStatusCode();
			
			//
			// Defines for the status code returned from the scan method.
			//
			#define /*Byte STATUS_OK;*/					B4RMITHM_STATUS_OK 0x1
			#define /*Byte STATUS_UNKNOWN;*/			B4RMITHM_STATUS_UNKNOWN 0x0
			// Error can not connect to the device
			#define /*Byte STATUS_ERR_CONNECT;*/		B4RMITHM_STATUS_ERR_CONNECT 0x2
			// Error can not find the service UUID (see define SERVICE_UUID)
			#define /*Byte STATUS_ERR_SERVICEUUID;*/	B4RMITHM_STATUS_ERR_SERVICEUUID 0x3
			// Error can not find the characteristics UUID (see define CHAR_UUID)
			#define /*Byte STATUS_ERR_CHARUUID;*/		B4RMITHM_STATUS_ERR_CHARUUID 0x4
			
	};

}
