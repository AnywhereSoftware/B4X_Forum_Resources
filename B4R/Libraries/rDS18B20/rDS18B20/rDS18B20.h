/**
 * @file rDS18B20.h
 * @brief Header for the Dallas Temperature Sensor DS18B20.
 * 
 * @date 2026-03-29
 * @author Robert W.B. Linn
 * @version 1.0
 * 
 * @section description Description
 * This library provides interface for B4R:
 * - Advertises in regular intervals data
 * 
 * @section dependencies Dependencies
 * Platform: esp32@3.3.6  
 * NimBLE: 2.3.7
 * 
 * @section notes Notes
 * DS18B20 has two special error values:
 * -127°C = sensor error, 85°C = power-on default
 * 
 * @section license License
 * MIT License
 */

#pragma once

/** B4R defintions */
#include "B4RDefines.h"

/** External libraries to be installed via the Arduino IDE */
#include <OneWire.h>
#include <DallasTemperature.h>

/** Helper */

// Use like uint8_t* mac = BYTEPTR(macArr);
#define BYTEPTR(a) ((uint8_t*)(a).data)

// Use like macArr.data = ARR(mac);
#define ARR(x) ((uint8_t*)(x))

//~Library: RDS18B20
//~Version: 1.0

namespace B4R {
	//~Version: 1.00
	//~Shortname: DS18B20
	//~Event: StateChanged (Temperature As Float)
	//~Event: Error (Code As Byte)

	class B4RDS18B20 {
		/** @brief Type definition for the sensor value used for the event. */
		typedef void (*SubVoidFloat)(float tempval);
		/** @brief Type definition for any errors. */
		typedef void (*SubVoidByte)(Byte code);

		private:
			/** @brief Declare object from OneWire.h. */
			OneWire* oneWire = NULL;

			/** @brief Declare object from DallasTemperature.h. */
			DallasTemperature* sensor = NULL;
			
			/** Sensor signal pin number */
			Byte pin;

			/** Sensor resolution */
			Byte resolution;
						
			/** Flag for checking proper initialization */
			bool initialized;
			
			/** @brief Store the prev value.*/
			float tempPrev;

			/** @brief Event-enabled flag (instance specific). */
			bool eventEnabled;

			/** @brief Per-instance event timer. */
			UInt lastEvent = 0;

			/** @brief Callback event state changed. */
			SubVoidFloat stateChangedSub;

			/** @brief Callback event for any errors. */
			SubVoidByte errorSub;

			/** @brief Looper to poll sensor data. */
			static void looper(void* b);

			// Debug flag for extensive logging serial line
            bool debugMode = false;

		public:

			/**
			 * @param Pin - Pin number to connect the sensor data signal.
			 * @param Resolution - Resolution.
			 * @param StateChangedSub - Callback for the `StateChanged` event.
			 * @param ErrorSub - Callback for the `Error` event.
			 */
			void Initialize(Byte Pin, Byte Resolution, SubVoidFloat StateChangedSub, SubVoidByte ErrorSub);

			/**
			 * @brief Check if sensor is properly initialized.
			 * @note Returns false if there was a failure.
			 */
			bool IsInitialized();

			/**
			 * @brief Read temperature from DS18B20 (Celsius).
			 * @note Returns nan if there was a failure.
			 */
			float GetTemperature();	

			/**
			 * @brief Set/Get enabled state change event.
			 */
			void setEventEnabled(bool state);
			bool getEventEnabled(void);

			/**
             * @brief Toggles verbose Serial logging for the library.
             * @param Enabled True to enable debug output.
             */
            void SetDebug(bool Enabled);

            /** Internal helper methods for B4R event handling */

			//~hide
            void HandleError(Byte code);

			/**
			 * PUBLIC CONSTANTS
			 */
			const Byte ADC_RESOLUTION_9  		= 9;
			const Byte ADC_RESOLUTION_10 		= 10;
			const Byte ADC_RESOLUTION_11 		= 11;
			const Byte ADC_RESOLUTION_12    	= 12;

			const Byte ERR_INVALID_RESOLUTION 	= 1;
			const Byte ERR_NO_SENSOR_FOUND 		= 2;
			
			const float POWER_ON_DEFAULT		= 85.0;
			// Note
			// DEVICE_DISCONNECTED_C defined by DallasTemperature -127.

	};
}