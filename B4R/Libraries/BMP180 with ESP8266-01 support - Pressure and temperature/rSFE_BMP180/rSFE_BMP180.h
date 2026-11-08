#pragma once
#include "B4RDefines.h"
#include "SFE_BMP180.h"
namespace B4R {
	//~Version: 1.10
	//~shortname: SFE_BMP180
	class B4RSFE_BMP180 {
		private:
			SFE_BMP180 SFEBMP180;
			double LastResult;
		public:
		//Should be called after calling GetTemperature or GetPressure.
		Double getLastResult();
		//Initializes the object. Returns True if successful.
  		bool Initialize();
		//Initializes the object with the specified SDA and SCL pins. Returns True if successful.
  		bool Initialize2(int SDA, int SCL);
		//Result will be stored in LastResult. Returns True if successful.
  		bool GetTemperature();
		//Result will be stored in LastResult.	Returns True if successful.
  		bool GetPressure(Int oversampling, Double LastTemperatureRead);
		//Returns pressure at sea level.
		//P - Pressure in millibars.
		//A - Altitude in meters.
  		Double Sealevel(Double P, Double A);
		//Returns altitude measured in meters.
		//P - Pressure
		//P0 - Pressure in sea level.
  		Double Altitude(Double P, Double P0);

	};
}