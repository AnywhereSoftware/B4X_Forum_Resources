
#pragma once
#include "B4RDefines.h"
#include "MPU6050.h"
#include "string"
    //~Event: 
    //~Version: 1.0 
    //~Author - 
    //~Libray from Arduino

namespace B4R {
    //~shortname:MPU6050
    class B4RMPU6050
    {
        private:
            uint8_t backend[sizeof(MPU6050)];
            MPU6050* rcs;
        public: 
            void Initialize();
            bool beginSoftwareI2C(int16_t sclpin, int16_t sdapin, byte scale, byte range, int16_t mpua);
            bool begin(byte scale, byte range, int16_t mpua);
            void setClockSource(byte source);
            void setScale(byte scale);
            void setRange(byte range);
            byte getClockSource();
            byte getScale();
            byte getRange();
            void setDHPFMode(byte dhpf);
            void setDLPFMode(byte dlpf);
            byte getAccelPowerOnDelay();
            void setAccelPowerOnDelay(byte delay);
            byte getIntStatus();
            bool getIntZeroMotionEnabled();
            void setIntZeroMotionEnabled(bool state);
            bool getIntMotionEnabled();
            void setIntMotionEnabled(bool state);
            bool getIntFreeFallEnabled();
            void setIntFreeFallEnabled(bool state);
            byte getMotionDetectionThreshold();
            void setMotionDetectionThreshold(byte threshold);
            byte getMotionDetectionDuration();
            void setMotionDetectionDuration(byte duration);
            byte getZeroMotionDetectionThreshold();
            void setZeroMotionDetectionThreshold(byte threshold);
            byte getZeroMotionDetectionDuration();
            void setZeroMotionDetectionDuration(byte duration);
            byte getFreeFallDetectionThreshold();
            void setFreeFallDetectionThreshold(byte threshold);
            byte getFreeFallDetectionDuration();
            void setFreeFallDetectionDuration(byte duration);
            bool getSleepEnabled();
            void setSleepEnabled(bool state);
            bool getI2CMasterModeEnabled();
            void setI2CMasterModeEnabled(bool state);
            bool getI2CBypassEnabled();
            void setI2CBypassEnabled(bool state);
            double readTemperature();
            uint16_t readActivites();
            int16_t getGyroOffsetX();
            void setGyroOffsetX(int16_t offset);
            int16_t getGyroOffsetY();
            void setGyroOffsetY(int16_t offset);
            int16_t getGyroOffsetZ();
            void setGyroOffsetZ(int16_t offset);
            int16_t getAccelOffsetX();
            void setAccelOffsetX(int16_t offset);
            int16_t getAccelOffsetY();
            void setAccelOffsetY(int16_t offset);
            int16_t getAccelOffsetZ();
            void setAccelOffsetZ(int16_t offset);
            void calibrateGyro(byte samples);
            void setThreshold(byte multiple);
            byte getThreshold();
            void readRawGyro(ArrayDouble* accel);
            void readNormalizeGyro(ArrayDouble* accel);
            void readRawAccel(ArrayDouble* accel);
            void readNormalizeAccel(ArrayDouble* accel);
            void readScaledAccel(ArrayDouble* accel);
    };
    
    //~Version: 1.00
	//~Shortname: MPU6050_data
	class B4RMPU6050_DATA
    {
	public:    
    static const uint16_t Activites_isOverflow       = 0b0000000000010000;
    static const uint16_t Activites_isFreeFall       = 0b0000000000001000;
    static const uint16_t Activites_isInactivity     = 0b0000000000000100;
    static const uint16_t Activites_isActivity       = 0b0000000000000010;
    static const uint16_t Activites_isDataReady      = 0b0000000000000001;  
    static const uint16_t Activites_isPosActivityOnX = 0b0000000100000000;
    static const uint16_t Activites_isPosActivityOnY = 0b0000001000000000;
    static const uint16_t Activites_isPosActivityOnZ = 0b0000010000000000;
    static const uint16_t Activites_isNegActivityOnX = 0b0000100000000000;
    static const uint16_t Activites_isNegActivityOnY = 0b0001000000000000;
    static const uint16_t Activites_isNegActivityOnZ = 0b0010000000000000;

    static const byte MPU6050_CLOCK_KEEP_RESET      = 0b111;
    static const byte MPU6050_CLOCK_EXTERNAL_19MHZ  = 0b101;
    static const byte MPU6050_CLOCK_EXTERNAL_32KHZ  = 0b100;
    static const byte MPU6050_CLOCK_PLL_ZGYRO       = 0b011;
    static const byte MPU6050_CLOCK_PLL_YGYRO       = 0b010;
    static const byte MPU6050_CLOCK_PLL_XGYRO       = 0b001;
    static const byte MPU6050_CLOCK_INTERNAL_8MHZ   = 0b000;

    static const byte MPU6050_DPS_SCALE_2000DPS     = 0b11;
    static const byte MPU6050_DPS_SCALE_1000DPS     = 0b10;
    static const byte MPU6050_DPS_SCALE_500DPS      = 0b01;
    static const byte MPU6050_DPS_SCALE_250DPS      = 0b00;

    static const byte MPU6050_RANGE_16G             = 0b11;
    static const byte MPU6050_RANGE_8G              = 0b10;
    static const byte MPU6050_RANGE_4G              = 0b01;
    static const byte MPU6050_RANGE_2G              = 0b00;

    static const byte MPU6050_DELAY_3MS             = 0b11;
    static const byte MPU6050_DELAY_2MS             = 0b10;
    static const byte MPU6050_DELAY_1MS             = 0b01;
    static const byte MPU6050_NO_DELAY              = 0b00;

    static const byte MPU6050_DHPF_HOLD             = 0b111;
    static const byte MPU6050_DHPF_0_63HZ           = 0b100;
    static const byte MPU6050_DHPF_1_25HZ           = 0b011;
    static const byte MPU6050_DHPF_2_5HZ            = 0b010;
    static const byte MPU6050_DHPF_5HZ              = 0b001;
    static const byte MPU6050_DHPF_RESET            = 0b000;

    static const byte MPU6050_DLPF_6                = 0b110;
    static const byte MPU6050_DLPF_5                = 0b101;
    static const byte MPU6050_DLPF_4                = 0b100;
    static const byte MPU6050_DLPF_3                = 0b011;
    static const byte MPU6050_DLPF_2                = 0b010;
    static const byte MPU6050_DLPF_1                = 0b001;
    static const byte MPU6050_DLPF_0                = 0b000;
    };


}


