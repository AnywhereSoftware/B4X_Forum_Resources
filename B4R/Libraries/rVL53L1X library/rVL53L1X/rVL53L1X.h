#pragma once
#include "B4RDefines.h"
#include <SparkFun_VL53L1X.h>
//~version: 1.01
//~Author: JanDerKan
namespace B4R {

	//~shortname: VL53L1X
	//This is a library that helps interface with ST's VL53L1X time-of-flight distance sensor. 
	//It wraps this library : 
	//https://github.com/sparkfun/SparkFun_VL53L1X_Arduino_Library
	//The library makes it simple to configure the sensor and read range data from it via I²C.
	//https://www.st.com/resource/en/datasheet/vl53l1x.pdf
	//You must use Arduino to install the VL53L1X library by SparkFun
	//You must have a Wiremaster initialized.
	//Example: <code>
	//Sub Process_Globals
	//	Private Master As WireMaster
	//	Private VL53 As VL53L1X
	//End Sub
	//
	//Private Sub AppStart
	//	Master.Initialize
	//	VL53.Initialize
	//End Sub
	//</code>

	class B4RVL53L1X {
		private:
			SFEVL53L1X sensor;
		public:
			//Initialization of sensor
			bool Initialize();

			//Set the I2C address
			void SetI2CAddress(int addr);

			//Get the I2C address
			int GetI2CAddress();
			
			// Clear the interrupt flag
			void ClearInterrupt();
			
			//Set the polarity of an active interrupt to High
			void SetInterruptPolarityHigh();
			
			//Set the polarity of an active interrupt to Low
			void SetInterruptPolarityLow();

			//get the current interrupt polarity
			int GetInterruptPolarity();
			
			//Begins taking measurements
			void StartRanging();

			//Stops taking measurements
			void StopRanging();
			
			//Checks the to see if data is ready
			bool CheckForDataReady();

			//Set the timing budget for a measurement
			void SetTimingBudgetInMs(int timingBudget);
			
			//Get the timing budget for a measurement
			int GetTimingBudgetInMs();
			
			//Set to 4M range
			void SetDistanceModeLong();
			
			//Set to 1.3M range
			void SetDistanceModeShort();
			
			//Get the distance mode, returns 1 for short and 2 for long
			int GetDistanceMode();

			//Set time between measurements in ms
			//Intermeasurement period must be >= timing budget.
			void SetIntermeasurementPeriod(int intermeasurement);
	
			//Get time between measurements in ms
			int GetIntermeasurementPeriod();
			
			//Returns distance
			int GetDistance();
			
			//Returns the signal rate in kcps. All SPADs combined.
			int GetSignalRate();
			
			// Returns the total ambinet rate in kcps. All SPADs combined.
			int GetAmbientRate();
			
			//Returns the range status, which can be any of the following.
			//0 = no error
			//1 = signal fail
			//2 = sigma fail
			//7 = wrapped target fail
			int GetRangeStatus(); 

			//Manually set an offset in mm
			void SetOffset(int offset);
			
			//Get the current offset in mm
			int GetOffset();
			
			//Manually set the value of crosstalk in counts per second (cps),
			//which is interference from any sort of window in front of your sensor.
			void SetXTalk(int xTalk); 
			
			//Returns the current crosstalk value in cps.
			int GetXTalk();

			//Set bounds for the interrupt.
			//lowThresh and hiThresh are the bounds of your interrupt
			//while window decides when the interrupt should fire.
			//The options for window are :
			//0: Interrupt triggered on measured distance below lowThresh.
			//1: Interrupt triggered on measured distance above hiThresh.
			//2: Interrupt triggered on measured distance outside of bounds.
			//3: Interrupt triggered on measured distance inside of bounds.
			void SetDistanceThreshold(int lowThresh, int hiThresh, int window);
			
			//Returns distance threshold window option
			int GetDistanceThresholdWindow();
			
			//Returns lower bound in mm.
			int GetDistanceThresholdLow();
			
			//Returns upper bound in mm
			int GetDistanceThresholdHigh();
			
			//Programs the necessary threshold to trigger a measurement.
			//Default is 1024 kcps.
			void SetSignalThreshold(int signalThreshold);
			
			//Returns the signal threshold in kcps
			int GetSignalThreshold();
			
			//Programs a new sigma threshold in mm.
			//default=15 mm
			void SetSigmaThreshold(int sigmaThreshold);
			
			//Returns the current sigma threshold.
			int GetSigmaThreshold();
			
			//Recalibrates the sensor for temperature changes.
			//Run this any time the temperature has changed by more than 8°C
			void StartTemperatureUpdate();
			
			//Autocalibrate the offset by placing a target a known distance away from the sensor
			//and passing this known distance into the setOffset() function.
			void CalibrateOffset(int targetDistanceInMm);
			
			//Autocalibrate the crosstalk by placing a target a known distance away from the sensor
			//and passing this known distance into the SetXTalk() function.
			void CalibrateXTalk(int targetDistanceInMm);
		
	};
}