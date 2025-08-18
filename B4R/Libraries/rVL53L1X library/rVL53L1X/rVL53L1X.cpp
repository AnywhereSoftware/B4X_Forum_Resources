#include "B4RDefines.h"

namespace B4R {
	bool B4RVL53L1X::Initialize() {
		return sensor.begin()==0;
	}
	void B4RVL53L1X::SetI2CAddress(int addr) {
		sensor.setI2CAddress(addr);
	}
	int B4RVL53L1X::GetI2CAddress() {
		return sensor.getI2CAddress();
	}
	void B4RVL53L1X::ClearInterrupt() {
		sensor.clearInterrupt();
	}
	void B4RVL53L1X::SetInterruptPolarityHigh() {
		sensor.setInterruptPolarityHigh();
	}
	void B4RVL53L1X::SetInterruptPolarityLow() {
		sensor.setInterruptPolarityLow();
	}
	int B4RVL53L1X::GetInterruptPolarity() {
		return sensor.getInterruptPolarity();
	}
	void B4RVL53L1X::StartRanging() {
		sensor.startRanging();
	}
	void B4RVL53L1X::StopRanging() {
		sensor.stopRanging();
	}
	bool B4RVL53L1X::CheckForDataReady() {
		return sensor.checkForDataReady();
	}	
	void B4RVL53L1X::SetTimingBudgetInMs(int timingBudget) {
		sensor.setTimingBudgetInMs(timingBudget);
	}
	int B4RVL53L1X::GetTimingBudgetInMs() {
		return sensor.getTimingBudgetInMs();
	}
	void B4RVL53L1X::SetDistanceModeLong() {
		sensor.setDistanceModeLong();
	}
	void B4RVL53L1X::SetDistanceModeShort() {
		sensor.setDistanceModeShort();
	}
	int B4RVL53L1X::GetDistanceMode() {
		return sensor.getTimingBudgetInMs();
	}
	void B4RVL53L1X::SetIntermeasurementPeriod(int intermeasurement) {
		sensor.setIntermeasurementPeriod(intermeasurement);
	}
	int B4RVL53L1X::GetIntermeasurementPeriod() {
		return sensor.getIntermeasurementPeriod();
	}
	int B4RVL53L1X::GetDistance() {
		return sensor.getDistance();
	}
	int B4RVL53L1X::GetSignalRate() {
		return sensor.getSignalRate();
	}
	int B4RVL53L1X::GetAmbientRate() {
		return sensor.getAmbientRate();
	}
	int B4RVL53L1X::GetRangeStatus() {
		return sensor.getRangeStatus();
	} 
	void B4RVL53L1X::SetOffset(int offset) {
		sensor.setOffset(offset);
	}
	int B4RVL53L1X::GetOffset() {
		return sensor.getOffset();
	}
	void B4RVL53L1X::SetXTalk(int xTalk) {
		sensor.setXTalk(xTalk);
	} 
	int B4RVL53L1X::GetXTalk() {
		return sensor.getXTalk();
	} 
	void B4RVL53L1X::SetDistanceThreshold(int lowThresh, int hiThresh, int window) {
		sensor.setDistanceThreshold(lowThresh, hiThresh, window);
	}
	int B4RVL53L1X::GetDistanceThresholdLow() {
		return sensor.getDistanceThresholdLow();
	}
	int B4RVL53L1X::GetDistanceThresholdHigh() {
		return sensor.getDistanceThresholdHigh();
	} 
	int B4RVL53L1X::GetDistanceThresholdWindow() {
		return sensor.getDistanceThresholdWindow();
	}
	void B4RVL53L1X::SetSignalThreshold(int signalThreshold) {
		sensor.setSignalThreshold(signalThreshold);
	}
	int B4RVL53L1X::GetSignalThreshold() {
		sensor.getSignalThreshold();
	}
	void B4RVL53L1X::SetSigmaThreshold(int sigmaThreshold) {
		sensor.setSigmaThreshold(sigmaThreshold);
	}
	int B4RVL53L1X::GetSigmaThreshold() {
		sensor.getSigmaThreshold();
	}
	void B4RVL53L1X::StartTemperatureUpdate() {
		sensor.startTemperatureUpdate();
	}
	void B4RVL53L1X::CalibrateOffset(int targetDistanceInMm) {
		sensor.calibrateOffset(targetDistanceInMm);
	}
	void B4RVL53L1X::CalibrateXTalk(int targetDistanceInMm) {
		sensor.calibrateXTalk(targetDistanceInMm);
	}

}