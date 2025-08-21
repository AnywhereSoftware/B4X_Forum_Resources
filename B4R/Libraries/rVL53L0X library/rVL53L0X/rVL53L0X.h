#pragma once
#include "B4RDefines.h"
#include <VL53L0X.h>
//~version: 1.00
//~Author: JanDerKan
namespace B4R {

	//~shortname: VL53L0X
	//This is a library that helps interface with ST's VL53L0X time-of-flight distance sensor.
	//It wraps this library : 
	//https://github.com/pololu/vl53l0x-arduino
	//The library makes it simple to configure the sensor and read range data from it via I²C.
	//Use the VL53L0X API provided by ST to make advanced configurations : 
	//https://www.st.com/content/st_com/en/products/embedded-software/proximity-sensors-software/stsw-img005.html
	//You must use Arduino to install the VL53L0X library by Pololu
	//You must have a Wiremaster initialized.
	//Example: <code>
	//Sub Process_Globals
	//	Private Master As WireMaster
	//	Private VL53 As VL53L0X
	//	Private RegAddr As VL53L0X_REGISTER_ADDRESSES
	//End Sub
	//
	//Private Sub AppStart
	//	Master.Initialize
	//	VL53.Initialize
	//	Log(RegAddr.SYSRANGE_START)
	//End Sub
	//</code>
	class B4RVL53L0X {
		private:
			VL53L0X sensor;
		public:

			//Initializes the module. Returns true if it was initialized successfully.
			bool Initialize();

			//Initializes the module. Returns true if it was initialized successfully.
			//If the argument io_1v8 is true, the sensor is configured for 1V8 mode.
			//If false the sensor is left in 2V8 mode. (Default)
			bool Initialize_1v8();
			
			//The status of the last I²C write transmission.
			//0:success
			//1:data too long to fit in transmit buffer
			//2:received NACK on transmit of address
			//3:received NACK on transmit of data
			//4:other error
			byte Last_Status();
			
			//Changes the I²C slave device address of the VL53L0X to the given value (7-bit).
			//Use XSHUT pin to disable all VL53L0X but the one to change
			void SetAddress(byte New_Addr);

			//Returns the current I²C address.
			byte GetAddress();

			//Reads an 8-bit sensor register and returns the value read.
			//Use the constants defined
			byte ReadReg(byte Reg);

			//Reads an 16-bit sensor register and returns the value read.
			//Use the constants defined
			int ReadReg16Bit(byte Reg);

			//Reads an 32-bit sensor register and returns the value read.
			//Use the constants defined
			long ReadReg32Bit(byte Reg);

			//Writes an 8-bit sensor register with the given value.
			//Use the constants defined
			void WriteReg(byte Reg, byte Value);

			//Writes an 16-bit sensor register with the given value.
			//Use the constants defined
			void WriteReg16Bit(byte Reg, int Value);

			//Writes an 32-bit sensor register with the given value.
			//Use the constants defined
			void WriteReg32Bit(byte Reg, long Value);

			//Sets the return signal rate limit to the given value in units of MCPS (mega counts per second). 
			//This is the minimum amplitude of the signal reflected from the target and received by the sensor necessary for it to report a valid reading. 
			//Setting a lower limit increases the potential range of the sensor but also increases the likelihood of getting an inaccurate reading because of reflections from objects other than the intended target. 
			//This limit is initialized to 0.25 MCPS by default. 
			//The return value is a boolean indicating whether the requested limit was valid.
			bool SetSignalRateLimit(Double limit_Mcps);

			//Returns the current return signal rate limit in MCPS.
			Double GetSignalRateLimit();
			
			//Sets the measurement timing budget to the given value in microseconds. 
			//This is the time allowed for one range measurement; a longer timing budget allows for more accurate measurements. 
			//The default budget is about 33000 microseconds, or 33 ms; the minimum is 20 ms. 
			//The return value is a boolean indicating whether the requested budget was valid.
			bool SetMeasurementTimingBudget(long budget_us);

			//Returns the current measurement timing budget in microseconds.
			long GetMeasurementTimingBudget();
			
			//Sets the VCSEL (vertical cavity surface emitting laser) pulse period for the PreRange type to the given value (in PCLKs).
			//Longer periods increase the potential range of the sensor.
			//Valid values are (even numbers only):
			//12 to 18 (initialized to 14 by default)
			//The return value is a boolean indicating whether the requested period was valid.
			bool SetVcselPulsePeriodPreRange(int period_pclks);

			//Returns the current VCSEL pulse period for the PreRange type.
			byte GetVcselPulsePeriodPreRange();

			//Sets the VCSEL (vertical cavity surface emitting laser) pulse period for the FinalRange type to the given value (in PCLKs).
			//Longer periods increase the potential range of the sensor.
			//Valid values are (even numbers only):
			//8 to 14 (initialized to 10 by default)
			//The return value is a boolean indicating whether the requested period was valid.
			bool SetVcselPulsePeriodFinalRange(int period_pclks);
			
			//Returns the current VCSEL pulse period for the FinalRange type.
			byte GetVcselPulsePeriodFinalRange();
			
			//Starts continuous ranging measurements.
			//If the optional argument period_ms is 0 (the default if not specified),
			//continuous back-to-back mode is used (the sensor takes measurements as often as possible)
			//if it is nonzero,
			//continuous timed mode is used, with the specified inter-measurement period in milliseconds determining how often the sensor takes a measurement.
			void StartContinuous(long period_ms = 0);

			//Stops continuous mode.
			void StopContinuous();

			//Returns a range reading in millimeters when continuous mode is active.
			int ReadRangeContinuousMillimeters();
			
			//Performs a single-shot ranging measurement and returns the reading in millimeters.
			int ReadRangeSingleMillimeters();
			
			//Sets a timeout period in milliseconds after which read operations will abort if the sensor is not ready.
			//A value of 0 disables the timeout.
			void SetTimeout(int timeout);
			
			//Returns the current timeout period setting.
			int GetTimeout();
			
			//Indicates whether a read timeout has occurred since the last call to timeoutOccurred().
			bool TimeoutOccurred();
	};
	//~shortname: VL53L0X_REGISTER_ADDRESSES
	//Addresses to use with RegRead and RegWrite
	class B4RVREGADDR {
		private:
		public:
			#define /*UInt SYSRANGE_START;*/ B4RVREGADDR_SYSRANGE_START VL53L0X::SYSRANGE_START 
			#define /*UInt SYSTEM_THRESH_HIGH;*/ B4RVREGADDR_SYSTEM_THRESH_HIGH VL53L0X::SYSTEM_THRESH_HIGH 
			#define /*UInt SYSTEM_THRESH_LOW;*/ B4RVREGADDR_SYSTEM_THRESH_LOW VL53L0X::SYSTEM_THRESH_LOW 
			#define /*UInt SYSTEM_SEQUENCE_CONFIG;*/ B4RVREGADDR_SYSTEM_SEQUENCE_CONFIG VL53L0X::SYSTEM_SEQUENCE_CONFIG 
			#define /*UInt SYSTEM_RANGE_CONFIG;*/ B4RVREGADDR_SYSTEM_RANGE_CONFIG VL53L0X::SYSTEM_RANGE_CONFIG 
			#define /*UInt SYSTEM_INTERMEASUREMENT_PERIOD;*/ B4RVREGADDR_SYSTEM_INTERMEASUREMENT_PERIOD VL53L0X::SYSTEM_INTERMEASUREMENT_PERIOD 
			#define /*UInt SYSTEM_INTERRUPT_CONFIG_GPIO;*/ B4RVREGADDR_SYSTEM_INTERRUPT_CONFIG_GPIO VL53L0X::SYSTEM_INTERRUPT_CONFIG_GPIO 
			#define /*UInt GPIO_HV_MUX_ACTIVE_HIGH;*/ B4RVREGADDR_GPIO_HV_MUX_ACTIVE_HIGH VL53L0X::GPIO_HV_MUX_ACTIVE_HIGH 
			#define /*UInt SYSTEM_INTERRUPT_CLEAR;*/ B4RVREGADDR_SYSTEM_INTERRUPT_CLEAR VL53L0X::SYSTEM_INTERRUPT_CLEAR 
			#define /*UInt RESULT_INTERRUPT_STATUS;*/ B4RVREGADDR_RESULT_INTERRUPT_STATUS VL53L0X::RESULT_INTERRUPT_STATUS 
			#define /*UInt RESULT_RANGE_STATUS;*/ B4RVREGADDR_RESULT_RANGE_STATUS VL53L0X::RESULT_RANGE_STATUS 
			#define /*UInt RESULT_CORE_AMBIENT_WINDOW_EVENTS_RTN;*/ B4RVREGADDR_RESULT_CORE_AMBIENT_WINDOW_EVENTS_RTN VL53L0X::RESULT_CORE_AMBIENT_WINDOW_EVENTS_RTN 
			#define /*UInt RESULT_CORE_RANGING_TOTAL_EVENTS_RTN;*/ B4RVREGADDR_RESULT_CORE_RANGING_TOTAL_EVENTS_RTN VL53L0X::RESULT_CORE_RANGING_TOTAL_EVENTS_RTN 
			#define /*UInt RESULT_CORE_AMBIENT_WINDOW_EVENTS_REF;*/ B4RVREGADDR_RESULT_CORE_AMBIENT_WINDOW_EVENTS_REF VL53L0X::RESULT_CORE_AMBIENT_WINDOW_EVENTS_REF 
			#define /*UInt RESULT_CORE_RANGING_TOTAL_EVENTS_REF;*/ B4RVREGADDR_RESULT_CORE_RANGING_TOTAL_EVENTS_REF VL53L0X::RESULT_CORE_RANGING_TOTAL_EVENTS_REF 
			#define /*UInt RESULT_PEAK_SIGNAL_RATE_REF;*/ B4RVREGADDR_RESULT_PEAK_SIGNAL_RATE_REF VL53L0X::RESULT_PEAK_SIGNAL_RATE_REF 
			#define /*UInt ALGO_PART_TO_PART_RANGE_OFFSET_MM;*/ B4RVREGADDR_ALGO_PART_TO_PART_RANGE_OFFSET_MM VL53L0X::ALGO_PART_TO_PART_RANGE_OFFSET_MM 
			#define /*UInt I2C_SLAVE_DEVICE_ADDRESS;*/ B4RVREGADDR_I2C_SLAVE_DEVICE_ADDRESS VL53L0X::I2C_SLAVE_DEVICE_ADDRESS 
			#define /*UInt MSRC_CONFIG_CONTROL;*/ B4RVREGADDR_MSRC_CONFIG_CONTROL VL53L0X::MSRC_CONFIG_CONTROL 
			#define /*UInt PRE_RANGE_CONFIG_MIN_SNR;*/ B4RVREGADDR_PRE_RANGE_CONFIG_MIN_SNR VL53L0X::PRE_RANGE_CONFIG_MIN_SNR 
			#define /*UInt PRE_RANGE_CONFIG_VALID_PHASE_LOW;*/ B4RVREGADDR_PRE_RANGE_CONFIG_VALID_PHASE_LOW VL53L0X::PRE_RANGE_CONFIG_VALID_PHASE_LOW 
			#define /*UInt PRE_RANGE_CONFIG_VALID_PHASE_HIGH;*/ B4RVREGADDR_PRE_RANGE_CONFIG_VALID_PHASE_HIGH VL53L0X::PRE_RANGE_CONFIG_VALID_PHASE_HIGH 
			#define /*UInt PRE_RANGE_MIN_COUNT_RATE_RTN_LIMIT;*/ B4RVREGADDR_PRE_RANGE_MIN_COUNT_RATE_RTN_LIMIT VL53L0X::PRE_RANGE_MIN_COUNT_RATE_RTN_LIMIT 
			#define /*UInt FINAL_RANGE_CONFIG_MIN_SNR;*/ B4RVREGADDR_FINAL_RANGE_CONFIG_MIN_SNR VL53L0X::FINAL_RANGE_CONFIG_MIN_SNR 
			#define /*UInt FINAL_RANGE_CONFIG_VALID_PHASE_LOW;*/ B4RVREGADDR_FINAL_RANGE_CONFIG_VALID_PHASE_LOW VL53L0X::FINAL_RANGE_CONFIG_VALID_PHASE_LOW 
			#define /*UInt FINAL_RANGE_CONFIG_VALID_PHASE_HIGH;*/ B4RVREGADDR_FINAL_RANGE_CONFIG_VALID_PHASE_HIGH VL53L0X::FINAL_RANGE_CONFIG_VALID_PHASE_HIGH 
			#define /*UInt FINAL_RANGE_CONFIG_MIN_COUNT_RATE_RTN_LIMIT;*/ B4RVREGADDR_FINAL_RANGE_CONFIG_MIN_COUNT_RATE_RTN_LIMIT VL53L0X::FINAL_RANGE_CONFIG_MIN_COUNT_RATE_RTN_LIMIT 
			#define /*UInt PRE_RANGE_CONFIG_SIGMA_THRESH_HI;*/ B4RVREGADDR_PRE_RANGE_CONFIG_SIGMA_THRESH_HI VL53L0X::PRE_RANGE_CONFIG_SIGMA_THRESH_HI 
			#define /*UInt PRE_RANGE_CONFIG_SIGMA_THRESH_LO;*/ B4RVREGADDR_PRE_RANGE_CONFIG_SIGMA_THRESH_LO VL53L0X::PRE_RANGE_CONFIG_SIGMA_THRESH_LO 
			#define /*UInt PRE_RANGE_CONFIG_VCSEL_PERIOD;*/ B4RVREGADDR_PRE_RANGE_CONFIG_VCSEL_PERIOD VL53L0X::PRE_RANGE_CONFIG_VCSEL_PERIOD 
			#define /*UInt PRE_RANGE_CONFIG_TIMEOUT_MACROP_HI;*/ B4RVREGADDR_PRE_RANGE_CONFIG_TIMEOUT_MACROP_HI VL53L0X::PRE_RANGE_CONFIG_TIMEOUT_MACROP_HI 
			#define /*UInt PRE_RANGE_CONFIG_TIMEOUT_MACROP_LO;*/ B4RVREGADDR_PRE_RANGE_CONFIG_TIMEOUT_MACROP_LO VL53L0X::PRE_RANGE_CONFIG_TIMEOUT_MACROP_LO 
			#define /*UInt SYSTEM_HISTOGRAM_BIN;*/ B4RVREGADDR_SYSTEM_HISTOGRAM_BIN VL53L0X::SYSTEM_HISTOGRAM_BIN 
			#define /*UInt HISTOGRAM_CONFIG_INITIAL_PHASE_SELECT;*/ B4RVREGADDR_HISTOGRAM_CONFIG_INITIAL_PHASE_SELECT VL53L0X::HISTOGRAM_CONFIG_INITIAL_PHASE_SELECT 
			#define /*UInt HISTOGRAM_CONFIG_READOUT_CTRL;*/ B4RVREGADDR_HISTOGRAM_CONFIG_READOUT_CTRL VL53L0X::HISTOGRAM_CONFIG_READOUT_CTRL 
			#define /*UInt FINAL_RANGE_CONFIG_VCSEL_PERIOD;*/ B4RVREGADDR_FINAL_RANGE_CONFIG_VCSEL_PERIOD VL53L0X::FINAL_RANGE_CONFIG_VCSEL_PERIOD 
			#define /*UInt FINAL_RANGE_CONFIG_TIMEOUT_MACROP_HI;*/ B4RVREGADDR_FINAL_RANGE_CONFIG_TIMEOUT_MACROP_HI VL53L0X::FINAL_RANGE_CONFIG_TIMEOUT_MACROP_HI 
			#define /*UInt FINAL_RANGE_CONFIG_TIMEOUT_MACROP_LO;*/ B4RVREGADDR_FINAL_RANGE_CONFIG_TIMEOUT_MACROP_LO VL53L0X::FINAL_RANGE_CONFIG_TIMEOUT_MACROP_LO 
			#define /*UInt CROSSTALK_COMPENSATION_PEAK_RATE_MCPS;*/ B4RVREGADDR_CROSSTALK_COMPENSATION_PEAK_RATE_MCPS VL53L0X::CROSSTALK_COMPENSATION_PEAK_RATE_MCPS 
			#define /*UInt MSRC_CONFIG_TIMEOUT_MACROP;*/ B4RVREGADDR_MSRC_CONFIG_TIMEOUT_MACROP VL53L0X::MSRC_CONFIG_TIMEOUT_MACROP 
			#define /*UInt SOFT_RESET_GO2_SOFT_RESET_N;*/ B4RVREGADDR_SOFT_RESET_GO2_SOFT_RESET_N VL53L0X::SOFT_RESET_GO2_SOFT_RESET_N 
			#define /*UInt IDENTIFICATION_MODEL_ID;*/ B4RVREGADDR_IDENTIFICATION_MODEL_ID VL53L0X::IDENTIFICATION_MODEL_ID 
			#define /*UInt IDENTIFICATION_REVISION_ID;*/ B4RVREGADDR_IDENTIFICATION_REVISION_ID VL53L0X::IDENTIFICATION_REVISION_ID 
			#define /*UInt OSC_CALIBRATE_VAL;*/ B4RVREGADDR_OSC_CALIBRATE_VAL VL53L0X::OSC_CALIBRATE_VAL 
			#define /*UInt GLOBAL_CONFIG_VCSEL_WIDTH;*/ B4RVREGADDR_GLOBAL_CONFIG_VCSEL_WIDTH VL53L0X::GLOBAL_CONFIG_VCSEL_WIDTH 
			#define /*UInt GLOBAL_CONFIG_SPAD_ENABLES_REF_0;*/ B4RVREGADDR_GLOBAL_CONFIG_SPAD_ENABLES_REF_0 VL53L0X::GLOBAL_CONFIG_SPAD_ENABLES_REF_0 
			#define /*UInt GLOBAL_CONFIG_SPAD_ENABLES_REF_1;*/ B4RVREGADDR_GLOBAL_CONFIG_SPAD_ENABLES_REF_1 VL53L0X::GLOBAL_CONFIG_SPAD_ENABLES_REF_1 
			#define /*UInt GLOBAL_CONFIG_SPAD_ENABLES_REF_2;*/ B4RVREGADDR_GLOBAL_CONFIG_SPAD_ENABLES_REF_2 VL53L0X::GLOBAL_CONFIG_SPAD_ENABLES_REF_2 
			#define /*UInt GLOBAL_CONFIG_SPAD_ENABLES_REF_3;*/ B4RVREGADDR_GLOBAL_CONFIG_SPAD_ENABLES_REF_3 VL53L0X::GLOBAL_CONFIG_SPAD_ENABLES_REF_3 
			#define /*UInt GLOBAL_CONFIG_SPAD_ENABLES_REF_4;*/ B4RVREGADDR_GLOBAL_CONFIG_SPAD_ENABLES_REF_4 VL53L0X::GLOBAL_CONFIG_SPAD_ENABLES_REF_4 
			#define /*UInt GLOBAL_CONFIG_SPAD_ENABLES_REF_5;*/ B4RVREGADDR_GLOBAL_CONFIG_SPAD_ENABLES_REF_5 VL53L0X::GLOBAL_CONFIG_SPAD_ENABLES_REF_5 
			#define /*UInt GLOBAL_CONFIG_REF_EN_START_SELECT;*/ B4RVREGADDR_GLOBAL_CONFIG_REF_EN_START_SELECT VL53L0X::GLOBAL_CONFIG_REF_EN_START_SELECT 
			#define /*UInt DYNAMIC_SPAD_NUM_REQUESTED_REF_SPAD;*/ B4RVREGADDR_DYNAMIC_SPAD_NUM_REQUESTED_REF_SPAD VL53L0X::DYNAMIC_SPAD_NUM_REQUESTED_REF_SPAD 
			#define /*UInt DYNAMIC_SPAD_REF_EN_START_OFFSET;*/ B4RVREGADDR_DYNAMIC_SPAD_REF_EN_START_OFFSET VL53L0X::DYNAMIC_SPAD_REF_EN_START_OFFSET 
			#define /*UInt POWER_MANAGEMENT_GO1_POWER_FORCE;*/ B4RVREGADDR_POWER_MANAGEMENT_GO1_POWER_FORCE VL53L0X::POWER_MANAGEMENT_GO1_POWER_FORCE 
			#define /*UInt VHV_CONFIG_PAD_SCL_SDA__EXTSUP_HV;*/ B4RVREGADDR_VHV_CONFIG_PAD_SCL_SDA__EXTSUP_HV VL53L0X::VHV_CONFIG_PAD_SCL_SDA__EXTSUP_HV 
			#define /*UInt ALGO_PHASECAL_LIM;*/ B4RVREGADDR_ALGO_PHASECAL_LIM VL53L0X::ALGO_PHASECAL_LIM 
			#define /*UInt ALGO_PHASECAL_CONFIG_TIMEOUT;*/ B4RVREGADDR_ALGO_PHASECAL_CONFIG_TIMEOUT VL53L0X::ALGO_PHASECAL_CONFIG_TIMEOUT 
	};
}