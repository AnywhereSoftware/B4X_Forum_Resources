#include "B4RDefines.h"

namespace B4R {
	bool B4RVL53L0X::Initialize() {
		return sensor.init(true);
	}
	bool B4RVL53L0X::Initialize_1v8() {
		return sensor.init(false);
	}
	byte B4RVL53L0X::Last_Status() {
		return sensor.last_status;
	}
	void B4RVL53L0X::SetAddress(byte New_Addr) {
		sensor.setAddress(New_Addr);
	}
	byte B4RVL53L0X::GetAddress() {
		return sensor.getAddress();
	}
	byte B4RVL53L0X::ReadReg(byte Reg) {
		return sensor.readReg(Reg);
	}
	int B4RVL53L0X::ReadReg16Bit(byte Reg) {
		return sensor.readReg16Bit(Reg);
	}
	long B4RVL53L0X::ReadReg32Bit(byte Reg) {
		return sensor.readReg32Bit(Reg);
	}
	void B4RVL53L0X::WriteReg(byte Reg, byte Value) {
		sensor.writeReg(Reg,Value);
	}
	void B4RVL53L0X::WriteReg16Bit(byte Reg, int Value) {
		sensor.writeReg16Bit(Reg,Value);
	}
	void B4RVL53L0X::WriteReg32Bit(byte Reg, long Value) {
		sensor.writeReg32Bit(Reg,Value);
	}
	bool B4RVL53L0X::SetSignalRateLimit(Double limit_Mcps) {
		sensor.setSignalRateLimit(limit_Mcps);
	}
	Double B4RVL53L0X::GetSignalRateLimit() {
		double d = (double)sensor.getSignalRateLimit();
		return d;
	}
	bool B4RVL53L0X::SetMeasurementTimingBudget(long budget_us) {
		sensor.setMeasurementTimingBudget(budget_us);
	}
	long B4RVL53L0X::GetMeasurementTimingBudget() {
		return sensor.getMeasurementTimingBudget();
	}
	bool B4RVL53L0X::SetVcselPulsePeriodPreRange(int period_pclks) {
		return sensor.setVcselPulsePeriod(VL53L0X::VcselPeriodPreRange, period_pclks);
	}
	byte B4RVL53L0X::GetVcselPulsePeriodPreRange() {
		return sensor.getVcselPulsePeriod(VL53L0X::VcselPeriodPreRange);
	}
	bool B4RVL53L0X::SetVcselPulsePeriodFinalRange(int period_pclks) {
		return sensor.setVcselPulsePeriod(VL53L0X::VcselPeriodFinalRange, period_pclks);
	}
	byte B4RVL53L0X::GetVcselPulsePeriodFinalRange() {
		return sensor.getVcselPulsePeriod(VL53L0X::VcselPeriodFinalRange);
	}
	void B4RVL53L0X::StartContinuous(long period_ms) {
		sensor.startContinuous(period_ms);
	}
	void B4RVL53L0X::StopContinuous() {
		sensor.stopContinuous();
	}
	int B4RVL53L0X::ReadRangeContinuousMillimeters() {
		return sensor.readRangeContinuousMillimeters();
	}
	int B4RVL53L0X::ReadRangeSingleMillimeters() {
		return sensor.readRangeSingleMillimeters();
	}
	void B4RVL53L0X::SetTimeout(int timeout) {
		sensor.setTimeout(timeout);
	}
	int B4RVL53L0X::GetTimeout() {
		return sensor.getTimeout();
	}
	bool B4RVL53L0X::TimeoutOccurred() {
		return sensor.timeoutOccurred();
	}
}