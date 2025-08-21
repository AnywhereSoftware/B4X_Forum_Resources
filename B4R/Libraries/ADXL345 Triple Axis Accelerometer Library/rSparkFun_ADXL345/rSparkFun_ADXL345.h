//Wrapped by Johan  Schoeman
//Changelog
//20200201: NEW
#pragma once
#include "B4RDefines.h"
#include "SparkFun_ADXL345.h"

namespace B4R {
	//~Version: 1.0
	//~shortname: ADXL345
	class B4RADXL345 {
		private:
		    ArrayInt buffer;
			ADXL345* bn;
			uint8_t be[sizeof(ADXL345)];
		public:	

			/**
			*
			*Initializes the ADXL345 object for I2C comms
			*I2C pins on Uno and Nano is for eg A4 (SDA) and A5 (SCL)
			*
			*/			
			void InitializeI2C();	
					
			/**
			*
			*Initializes the ADXL345 object for SPI comms
			*CS = Pin used for CS line
			*
			*/						
			void InitializeSPI(int CS);
			
			/**
			*
			*Power on the ADXL345
			*
			*/		
			void powerOn();
			
			/**
			*
			*Give the range settings
            *Accepted values are 2g, 4g, 8g or 16g
            *Higher Values = Wider Measurement Range
            *Lower Values = Greater Sensitivity
			*
			*/				
			void setRangeSetting(int val);
			
			/**
			*
			*set the range to 2g
			*
			*/					
			int RANGE_2G = 2;

			/**
			*
			*set the range to 4g
			*
			*/					
			int RANGE_4G = 4;	

			/**
			*
			*set the range to 8g
			*
			*/					
			int RANGE_8G = 8;
			
			/**
			*
			*set the range to 16g
			*
			*/					
			int RANGE_16G = 16;			
			
			/**
			*
			*Trigger a Read of the accelerometer values
			*Use getX_Accel, getY_Accel, and getZ_Accel to get the X, Y, and Z values once a ready has been triggered
			*
			*/	
			void readAccel();
			
			/**
			*
			*get the X_Accel value
            *
			*/				
			Int getX_Accel();
			
			/**
			*
			*get the Y_Accel value
            *
			*/				
			Int getY_Accel();
			
			/**
			*
			*get the Z_Accel value
            *
			*/				
			Int getZ_Accel();
			
			/**
			*
			*Configure the device to be in 4 wire SPI mode when set to '0' or 3 wire SPI mode when set to 1
            *Default: Set to 1
            *SPI pins on the ATMega328: 11, 12 and 13 as reference in SPI Library 
            *
			*/				
			void setSpiBit(bool spiBit);
			
			/**
			*
			*Set to activate movement detection in the axes "adxl.setActivityXYZ(X, Y, Z);" (1 == ON, 0 == OFF)
            *
			*/						
			void setActivityXYZ(bool stateX, bool stateY, bool stateZ);
			
			/**
			*
			*62.5mg per increment   // Set activity   // Inactivity thresholds (0-255)
            *
			*/						
			void setActivityThreshold(int activityThreshold);
			

			/**
			*
			*Set to detect inactivity in all the axes "adxl.setInactivityXYZ(X, Y, Z);" (1 == ON, 0 == OFF)
            *
			*/						
			void setInactivityXYZ(bool stateX, bool stateY, bool stateZ);
			
			/**
			*
			*62.5mg per increment   // Set inactivity // Inactivity thresholds (0-255)
            *
			*/						
			void setInactivityThreshold(int inactivityThreshold);

			/**
			*
			*How many seconds of no activity is inactive?
            *
			*/					
			void setTimeInactivity(int timeInactivity);
			
			/**
			*
			*Detect taps in the directions turned ON "adxl.setTapDetectionOnX(X, Y, Z);" (True = ON, False = OFF)
            *
			*/				
			void setTapDetectionOnXYZ(bool stateX, bool stateY, bool stateZ);
	
			/**
			*
			*Set values for what is considered a TAP and what is a DOUBLE TAP (0-255)
			*62.5 mg per increment
            *
			*/				
			void setTapThreshold(int tapThreshold);
			
			/**
			*
			*Set values for what is considered a TAP and what is a DOUBLE TAP (0-255)
			*625 μs per increment
            *
			*/						
			void setTapDuration(int tapDuration);
			
			/**
			*
			*Set values for what is considered a TAP and what is a DOUBLE TAP (0-255)
			*1.25 ms per increment
            *
			*/					
			void setDoubleTapLatency(int doubleTapLatency);		

			/**
			*
			*Set values for what is considered a TAP and what is a DOUBLE TAP (0-255)
			*1.25 ms per increment
            *
			*/	
			void setDoubleTapWindow(int doubleTapWindow);
			
			/**
			*
			*Set values for what is considered FREE FALL (0-255)
			*(5 - 9) recommended - 62.5mg per increment	
            *
			*/				
			void setFreeFallThreshold(int freeFallthreshold);
			
			/**
			*
			*Set values for what is considered FREE FALL (0-255)
			*(20 - 70) recommended - 5ms per increment	
            *
			*/					
			void setFreeFallDuration(int freeFallDuration);
			
					
			/**
			*
			*Print Register Values to Serial Output =
			*Can be used to Manually Check the Current Configuration of Device	
            *
			*/		
			void printAllRegister();
			
			bool isActivityXEnabled();
			bool isActivityYEnabled();
			bool isActivityZEnabled();
			bool isInactivityXEnabled();
			bool isInactivityYEnabled();
			bool isInactivityZEnabled();	


			bool isActivitySourceOnX();
			bool isActivitySourceOnY();
			bool isActivitySourceOnZ();
			bool isTapSourceOnX();
			bool isTapSourceOnY();
			bool isTapSourceOnZ();
			bool isAsleep();
			bool isLowPower();	

			void setLowPower(bool state);			
			
			/**
			*
			*Turn on/off the Interrupt Inactivity (True = ON, False = OFF)
            *
			*/							
			void InactivityINT(bool status);
			
			/**
			*
			*Turn on/off the Interrupt Activity (True = ON, False = OFF)
            *
			*/					
			void ActivityINT(bool status);
			
			/**
			*
			*Turn on/off the Interrupt for Free Fall (True = ON, False = OFF)
            *
			*/					
			void FreeFallINT(bool status);
			
			/**
			*
			*Turn on/off the Interrupt for Double Tap (True = ON, False = OFF)
            *
			*/					
			void doubleTapINT(bool status);
			
			/**
			*
			*Turn on/off the Interrupt for Single Tap (True = ON, False = OFF)
            *
			*/					
			void singleTapINT(bool status);
			
 
			/**
			*
			*Look for Interrupts and Triggered Action
			*getInterruptSource clears all triggered actions after returning value
			*Do not call again until you need to recheck for triggered actions	
            *
			*/		 
			byte getInterruptSource();
			
			/**
			*
			*Check if an Action was Triggered in Interrupts
            *
			*/		 			
			bool triggered(byte interrupts, int mask);
			
			Int MASK_ADXL345_SINGLE_TAP = 0x06;
			Int MASK_ADXL345_DOUBLE_TAP = 0x05;
			Int MASK_ADXL345_ACTIVITY = 0x04;
			Int MASK_ADXL345_INACTIVITY = 0x03;
			Int MASK_ADXL345_FREE_FALL = 0x02;
			
			
	};

}