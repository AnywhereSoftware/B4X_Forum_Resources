
#include "B4RDefines.h"

namespace B4R {
	void B4RDS18B20::Initialize(Byte Pin, Byte Resolution, SubVoidFloat StateChangedSub, SubVoidByte ErrorSub) {

		// Assign parameters and register events callback
		pin = Pin;
		resolution = Resolution;
		stateChangedSub = StateChangedSub;
		errorSub = ErrorSub;
		
		// Initialize internal states
		initialized = false;
		tempPrev = NAN;       
		eventEnabled = true;
		lastEvent = 0;

		// Cleanup previous objects
		if (oneWire != NULL) {
			delete oneWire;
			oneWire = NULL;
		}

		if (sensor != NULL) {
			delete sensor;
			sensor = NULL;
		}

		// Check ADC resolution (DS18B20 supports 9..12)
		if (Resolution < ADC_RESOLUTION_9 || Resolution > ADC_RESOLUTION_12) {
			::Serial.println("[B4RDS18B20::Initialize][E] Invalid resolution.");
			HandleError(ERR_INVALID_RESOLUTION);
			return;
		}

		// Create OneWire bus
		oneWire = new OneWire(pin);

		// Create DallasTemperature instance
		sensor = new DallasTemperature(oneWire);

		// Start sensor
		sensor->begin();

		// Detect sensors
		if (sensor->getDeviceCount() == 0) {
			::Serial.println("[B4RDS18B20::Initialize][E] No DS18B20 sensor found.");
			HandleError(ERR_NO_SENSOR_FOUND);
			return;
		}

		// Set resolution
		sensor->setResolution(resolution);

		// Set the poller
		FunctionUnion fu;
		fu.PollerFunction = looper;
		pollers.add(fu, this);
		
		initialized = true;
		
		if (debugMode) {
			::Serial.println("[B4RDS18B20.Initialize][I] OK");
		}
	}

	bool B4RDS18B20::IsInitialized() {
		return initialized;
	}

	float B4RDS18B20::GetTemperature() {

		if (!initialized) return NAN;

		sensor->requestTemperatures();
		float temp = sensor->getTempCByIndex(0);

		// invalid reading
		if (temp == DEVICE_DISCONNECTED_C || temp == POWER_ON_DEFAULT)
			return NAN;

		if (debugMode) {
			::Serial.print("[B4RDS18B20.GetTemperature][I] ");
			::Serial.println(temp);
		}

		return temp;
	}

	void B4RDS18B20::setEventEnabled(bool state) {
		eventEnabled = state;
	}
	bool B4RDS18B20::getEventEnabled() {
		return eventEnabled;
	}

    void B4RDS18B20::SetDebug(bool Enabled) {
        debugMode = Enabled;
    }

	void B4RDS18B20::HandleError(Byte code) {
		initialized = false;
		if (errorSub) errorSub(code);
	}

	//*******************************************
	// Event
	//*******************************************

	// Looper every 500 MS
	void B4RDS18B20::looper(void* b) {
		
		B4RDS18B20* me = (B4RDS18B20*)b;
		
		if (me->lastEvent + 500 > millis())
			return;
		me->lastEvent = millis();

		// Check if the event is enabled
		if (me->getEventEnabled()) {
			
			// Read the sensor value
			float temp = me->GetTemperature();

			// Call the event if temp or hum has changed
			if (temp != me->tempPrev) {
				const UInt cp = B4R::StackMemory::cp;
		
				if (me->stateChangedSub) {
					if (me->debugMode) {
						::Serial.println("[B4RDS18B20.looper][I] Calling B4R event");
					}
					me->stateChangedSub(temp);
				}
				B4R::StackMemory::cp = cp;
				
				me->tempPrev = temp;
			}
		}
	}
}