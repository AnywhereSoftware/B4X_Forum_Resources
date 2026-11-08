#include "B4RDefines.h"
namespace B4R
{
	bool B4RSHT20::Initialize(void){
		bool success = true;
		
		sht = new (beSHT20) SHT20();
		sht->begin();
		
		return success;
	}

	bool B4RSHT20::Measure(void) {
		float t, h;
		if (sht->measure(t, h)) {
			temperature = t;
			humidity = h;
			return true;
		}
		else {
			return false;
		}
	}

	float B4RSHT20::Temperature(void){
		return this->temperature;
	}
	
	float B4RSHT20::Humidity(void){
		return this->humidity;
	}

	float B4RSHT20::Dewpoint(float temperature, float humidity){
		return sht->dewpoint(temperature, humidity);
	}

}
