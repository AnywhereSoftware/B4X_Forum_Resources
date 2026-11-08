#include "B4RDefines.h"
namespace B4R {
	bool B4RSFE_BMP180::Initialize() {
		return SFEBMP180.begin(-1, -1); // Use default SDA and SCL
	}
	bool B4RSFE_BMP180::Initialize2(int SDA, int SCL) {
		return SFEBMP180.begin(SDA, SCL);
	}
	bool B4RSFE_BMP180::GetTemperature() {
		char c = SFEBMP180.startTemperature();
		if (c == 0)
			return false;
		delay(c);
		return SFEBMP180.getTemperature(LastResult);
	}
	bool B4RSFE_BMP180::GetPressure(Int oversampling, Double LastTemperatureRead) {
		char c = SFEBMP180.startPressure((char)oversampling);
		if (c == 0)
			return false;
		delay(c);
		double d = (double)LastTemperatureRead;
		return SFEBMP180.getPressure(LastResult, d);
	}
	Double B4RSFE_BMP180::Sealevel(Double P, Double A) {
		return SFEBMP180.sealevel(P, A);
	}
	Double B4RSFE_BMP180::Altitude(Double P, Double P0) {
		return SFEBMP180.altitude(P, P0);
	}
	Double B4RSFE_BMP180::getLastResult() {
		return (Double)LastResult;
	}

}
