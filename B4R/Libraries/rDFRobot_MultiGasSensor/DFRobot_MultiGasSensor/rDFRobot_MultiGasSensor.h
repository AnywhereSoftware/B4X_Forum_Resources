/**
 * File:        rDFRobot_MultiGasSensor.h
 * Brief:       B4R library partial wrapper for the DFRobot Grafity CO Sensor.
 *              Based on the DFRobot MultiGasSensor library: https://github.com/DFRobot/DFRobot_MultiGasSensor
 *				To note is that several function names have been renamed for consistency with B4X standards and sensor-library idioms.
 * Author: 		Robert W.B. Linn (Wrapper)
 * Date:		2025-10-06
 *
 * Original Library (DFRobot):
 *   Copyright (c) 2021 DFRobot
 *   Licensed under the MIT License
 *   (see LICENSE file in the original repository).
 *
 * This Wrapper (B4R):
 *   Enhancements for B4R integration:
 *     - None (yet)
 *   Requires DFRobot_MultiGasSensor v2.0.0
 *
 * Notes:
 * Communication mode select, DIP switch SEL: 0: I2C, 1: UART
 * 
 * License for this wrapper: MIT
 *   Copyright © 2025 Robert W.B. Linn
 *   Permission is hereby granted, free of charge, to use, copy, modify, merge,
 *   publish, distribute, sublicense, and/or sell copies of this software.
 *
 * Note: The DFRobot library remains under the MIT license.
 *       This wrapper code is MIT licensed. When distributing, both licenses apply.
 */

#pragma once
#include "B4RDefines.h"

// DFRobot library in the same folder as the wrapped library
#include "DFRobot_MultiGasSensor.h"

namespace B4R {
    //~Version: 1.0
    //~shortname: DFRobot_MultiGasSensor
    /**
     * @class DFRobot_MultiGasSensor
     * @brief Wrapper class that exposes the DFRobot MultiGasSensor to B4R.
	 *        Enhanced with custom constants & functions.
     */
    class B4RDFRobot_MultiGasSensor {
        private:
            /** Internal buffer to hold the DFRobot_MultiGasSensor instance. */
            Byte beDFRobot_GAS_I2C[sizeof(DFRobot_GAS_I2C)];
            
			/** Assign the default I2C address. */
			Byte i2cAddress = I2C_DEFAULT_ADDRESS;
			
        public:
		
            /** Pointer to the underlying DFRobot_MultiGasSensor object. */
			/** Keep type hidden from the parser. */
            //~hide
            DFRobot_GAS_I2C* sensor;

            /** 
			 * @fn Initialize
			 * @brief Initialize with default I2C address (0x74)
			 * @n Mode of obtaining data is passiv and the temperature compensation is turned on
			 * @return bool type, indicating whether the initialization is successful
			 * @retval True succeed
			 * @retval False failed
			 */
            bool Initialize();

            /** 
			 * @fn InitializeWithAddress
			 * @brief Initialize with a custom I2C address
			 * @n Mode of obtaining data is passiv and the temperature compensation is turned on
			 * @param addr Byte I2C address
			 * @n Default address 0x74
			 * @return bool type, indicating whether the initialization is successful
			 * @retval True succeed
			 * @retval False failed
			 */
            bool InitializeWithAddress(const Byte addr);

			/**
			 * @fn SetAcquireMode
			 * @brief Set the mode of acquiring sensor data
			 * @param mode Mode select
			 * @n INITIATIVE The sensor proactively reports data
			 * @n PASSIVITY The main controller needs to request data from sensor
			 * @return bool type, indicating whether the setting is successful
			 * @retval True succeed
			 * @retval False failed
			 */
			bool SetAcquireMode(Byte mode);

			/**
			 * @fn ReadConcentrationPPM
			 * @brief Read the gas concentration from sensor, unit PPM
			 * @return float type, indicating return gas concentration, if data is transmitted normally, return gas concentration, otherwise, return 0.0
			 */
			float ReadConcentrationPPM(void);

			/**
			 * @fn ReadGasType
			 * @brief Read the type of current gas probe, i.e. O2,CO,H2S,NO2,O3,CL2,NH3,H2,HCL,SO2,HF,PH3
			 * @return String type, indicating the gas type as string
			 */
			B4RString* ReadGasType(void);

			/**
			 * @fn ReadGasTypeID
			 * @brief Read the type of current gas probe, i.e. O2=0x05,CO=0x04,H2S=0x03,NO2=0x2C,O3=0x2A,CL2=0x31,NH3=0x02,H2=0x06,HCL=0X2E,SO2=0X2B,HF=0x33,PH3=0x45
			 * @return Byte type, indicating gas type ID as byte
			 */
			Byte ReadGasTypeID(void);

			/**
			 * @fn setThresholdAlarm
			 * @brief Set sensor alarm threshold
			 * @n Function modified to use the type of the current gas probe (using QueryGasType)
			 * @n Recommend to create own threshold solution in B4R
			 * @param switchoff Whether to turn on threshold alarm switch
			 * @n ON turn on
			 * @n OFF turn off
			 * @param threshold The threshold for starting alarm
			 * @param alamethod Set sensor high or low threshold alarm
			 * @return bool type, indicating whether the setting is successful
			 * @retval True succeed
			 * @retval False failed
			 */
			bool SetThresholdAlarm(Byte switchoff, UInt threshold, Byte alamethod);

			/**
			 * @fn ReadTemperatureC
			 * @brief Get sensor onboard temperature
			 * @return float type, indicating return the current onboard temperature
			 */
			float ReadTemperatureC(void);

			/**
			 * @fn SetTemperatureCompensation
			 * @brief Set whether to turn on temperature compensation, values output by sensor under different temperatures are various.
			 * @n To get more accurate gas concentration, temperature compensation is necessary when calculating gas concentration.
			 * @param tempswitch Whether to turn on temperature compensation
			 * @n ON Turn on temperature compensation
			 * @n OFF Turn off temperature compensation
			 */
			void SetTemperatureCompensation(Byte tempswitch);

			/**
			 * @fn ReadVoltage
			 * @brief Read voltage output by sensor probe (for calculating the current gas concentration)
			 * @n This is the original voltage output V0 of the gas probe
			 * @return float type, indicating return voltage value
			 */
			float ReadVoltage(void);
            
			/**
			 * @fn IsDataAvailable
			 * @brief Call this function in active mode to determine the presence of data on data line
			 * @return bool type, indicating whether there is data coming from the sensor 
			 * @retval True Has uploaded data
			 * @retval False No data uploaded
			 */
			bool IsDataAvailable(void);

			/**
			 * @fn SetI2CAddrGroup
			 * @brief Set the I2C address group
			 * @param group Address group select
			 * @return int type, indicating return init status
			 * @retval bool type
			 * @retval True Change succeed
			 * @retval False Change failed
			 */
			bool SetI2CAddrGroup(Byte group);
  
            /**
             * Constants
             */

            /** I2C Default Address. */
            static const Byte I2C_DEFAULT_ADDRESS = 0x74;

			//** Acquire modes (Mode of obtaining data). */
			static const Byte MODE_INITIATIVE 	= 0x03;
			static const Byte MODE_PASSIVITY  	= 0x04;

			//** Gas types. */
			static const Byte GASTYPE_UNKNOWN	= 0x00;
			static const Byte GASTYPE_O2		= 0x05;
			static const Byte GASTYPE_CO 		= 0x04;
			static const Byte GASTYPE_H2S 		= 0x03;
			static const Byte GASTYPE_NO2 		= 0x2C;
			static const Byte GASTYPE_O3 		= 0x2A;
			static const Byte GASTYPE_CL2 		= 0x31;
			static const Byte GASTYPE_NH3 		= 0x02;
			static const Byte GASTYPE_H2 		= 0x06;
			static const Byte GASTYPE_HCL 		= 0X2E;
			static const Byte GASTYPE_SO2		= 0X2B;
			static const Byte GASTYPE_HF 		= 0x33;
			static const Byte GASTYPE_PH3 		= 0x45;
        
    };
    
}
