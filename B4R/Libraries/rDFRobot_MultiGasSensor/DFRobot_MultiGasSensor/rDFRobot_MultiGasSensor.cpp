/**
 * rAdafruitPWMServoDriver.cpp
 * Source of the B4R library rAdafruitPWMServoDriver.
 */

#include "B4RDefines.h"

namespace B4R {

	bool B4RDFRobot_MultiGasSensor::Initialize() {
		
		// Wire settings to ensure ESP32 is working properly (Wire on ESP32 is more strict)
		Wire.begin();           // SDA=21, SCL=22 default
		Wire.setClock(100000);  // 100 kHz
		Wire.setTimeout(1000);  // 1 second

		// Create new instance
		sensor = new (beDFRobot_GAS_I2C) DFRobot_GAS_I2C(&Wire, i2cAddress);

		// I2C connection
		int attempts = 0;
		while(!sensor->begin() && attempts < 5) {
			// ::Serial.println("[B4RDFRobot_MultiGasSensor::Initialize][ERROR] Device not found, retrying...");
			delay(1000);
			attempts++;
		}
		if (attempts == 5) return false;

		// ::Serial.println("[B4RDFRobot_MultiGasSensor::Initialize] Device connected successfully.");

		// Read the gas type, i.e. CO
		sensor->queryGasType();

		// On ESP32, passive mode is prone to race conditions if you read too fast.
		sensor->changeAcquireMode(sensor->INITIATIVE);
		// sensor->changeAcquireMode(sensor->PASSIVITY);
		delay(500);

		// Set the temperature compensation ON
		sensor->setTempCompensation(sensor->ON);

		return true;
	}

	bool B4RDFRobot_MultiGasSensor::InitializeWithAddress(const Byte addr){
		i2cAddress = addr;
		Initialize();
	}
	
	bool B4RDFRobot_MultiGasSensor::SetAcquireMode(Byte mode) {
		// Cast byte into the enum.
		sensor->changeAcquireMode( (DFRobot_GAS::eMethod_t) mode);
	}
	
	float B4RDFRobot_MultiGasSensor::ReadConcentrationPPM(void) {
		return sensor->readGasConcentrationPPM();
	}
	
	B4RString* B4RDFRobot_MultiGasSensor::ReadGasType(void) {
		String gasType = sensor->queryGasType();
		PrintToMemory pm;
		B4RString* s = B4RString::PrintableToString(NULL);
		pm.print(gasType);
		StackMemory::buffer[StackMemory::cp++] = 0;
		return s;
	}

	Byte B4RDFRobot_MultiGasSensor::ReadGasTypeID(void) {
		String gasType = sensor->queryGasType();
		Byte gasID = 0x00;
		if (gasType == "O2") { gasID = 0x05; }
		else if (gasType == "CO") { gasID = 0x04; }
		else if (gasType == "H2S") {gasID = 0x03; }
		else if (gasType == "NO2") {gasID = 0x2C; }
		else if (gasType == "O3") {gasID = 0x2A; }
		else if (gasType == "CL2") {gasID = 0x31; }
		else if (gasType == "NH3") {gasID = 0x02; }
		else if (gasType == "H2") {gasID = 0x06; }
		else if (gasType == "HCL") {gasID = 0x2E; }
		else if (gasType == "SO2") {gasID = 0x2B; }
		else if (gasType == "HF") {gasID = 0x33; }
		else if (gasType == "PH3") {gasID = 0x45; }
		return gasID;
	}
	
	bool B4RDFRobot_MultiGasSensor::SetThresholdAlarm(Byte switchoff, UInt threshold, Byte alamethod) {
		return sensor->setThresholdAlarm((DFRobot_GAS::eSwitch_t) switchoff, threshold, (DFRobot_GAS::eALA_t) alamethod, sensor->queryGasType());
	}
	
	float B4RDFRobot_MultiGasSensor::ReadTemperatureC(void) {
		return sensor->readTempC();
	}

	void B4RDFRobot_MultiGasSensor::SetTemperatureCompensation(Byte tempswitch) {
		sensor->setTempCompensation( (DFRobot_GAS::eSwitch_t) tempswitch);
	}

	float B4RDFRobot_MultiGasSensor::ReadVoltage(void) {
		return sensor->getSensorVoltage();
	}

	bool B4RDFRobot_MultiGasSensor::IsDataAvailable(void) {
		return sensor->dataIsAvailable();
	}

	bool B4RDFRobot_MultiGasSensor::SetI2CAddrGroup(Byte group) {
		return sensor->changeI2cAddrGroup(group);
	}

}
