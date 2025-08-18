
#include "B4RDefines.h"

namespace B4R
{

    void B4RMPU6050::Initialize()
    {
       rcs = new (backend) MPU6050();
    };

    bool B4RMPU6050::beginSoftwareI2C(int16_t sclpin, int16_t sdapin, byte scale, byte range, int16_t mpua)
    {  mpu6050_dps_t d; mpu6050_range_t e;
       switch(scale) {
        case 0b11 : d = mpu6050_dps_t::MPU6050_SCALE_2000DPS;break;
        case 0b10 : d = mpu6050_dps_t::MPU6050_SCALE_1000DPS;break;
        case 0b01 : d = mpu6050_dps_t::MPU6050_SCALE_500DPS ;break;
        case 0b00 : d = mpu6050_dps_t::MPU6050_SCALE_250DPS ;break;
        default   : d = mpu6050_dps_t::MPU6050_SCALE_2000DPS;break;
       }
       switch (range) {
        case 0b11 : e = mpu6050_range_t::MPU6050_RANGE_16G;break;
        case 0b10 : e = mpu6050_range_t::MPU6050_RANGE_8G ;break;
        case 0b01 : e = mpu6050_range_t::MPU6050_RANGE_4G ;break;
        case 0b00 : e = mpu6050_range_t::MPU6050_RANGE_2G ;break;
        default   : e = mpu6050_range_t::MPU6050_RANGE_2G ;break;
       }
       return rcs->beginSoftwareI2C(sclpin,sdapin, d, e, mpua);
    };

    bool B4RMPU6050::begin(byte scale, byte range, int16_t mpua)
       {  mpu6050_dps_t d; mpu6050_range_t e;
       switch(scale) {
        case 0b11 : d = mpu6050_dps_t::MPU6050_SCALE_2000DPS;break;
        case 0b10 : d = mpu6050_dps_t::MPU6050_SCALE_1000DPS;break;
        case 0b01 : d = mpu6050_dps_t::MPU6050_SCALE_500DPS ;break;
        case 0b00 : d = mpu6050_dps_t::MPU6050_SCALE_250DPS ;break;
        default   : d = mpu6050_dps_t::MPU6050_SCALE_2000DPS;break;
       }
       switch (range) {
        case 0b11 : e = mpu6050_range_t::MPU6050_RANGE_16G;break;
        case 0b10 : e = mpu6050_range_t::MPU6050_RANGE_8G ;break;
        case 0b01 : e = mpu6050_range_t::MPU6050_RANGE_4G ;break;
        case 0b00 : e = mpu6050_range_t::MPU6050_RANGE_2G ;break;
        default   : e = mpu6050_range_t::MPU6050_RANGE_2G ;break;
       }
       return rcs->begin(d, e, mpua);
    };

    void B4RMPU6050::setClockSource(byte source)
    { mpu6050_clockSource_t d;
    switch (source) {
     case 0b111 : d = mpu6050_clockSource_t::MPU6050_CLOCK_KEEP_RESET       ;break;
     case 0b101 : d = mpu6050_clockSource_t::MPU6050_CLOCK_EXTERNAL_19MHZ   ;break;
     case 0b100 : d = mpu6050_clockSource_t::MPU6050_CLOCK_EXTERNAL_32KHZ   ;break;
     case 0b011 : d = mpu6050_clockSource_t::MPU6050_CLOCK_PLL_ZGYRO        ;break;
     case 0b010 : d = mpu6050_clockSource_t::MPU6050_CLOCK_PLL_YGYRO        ;break;
     case 0b001 : d = mpu6050_clockSource_t::MPU6050_CLOCK_PLL_XGYRO        ;break;
     case 0b000 : d = mpu6050_clockSource_t::MPU6050_CLOCK_INTERNAL_8MHZ    ;break;
     default    : d = mpu6050_clockSource_t::MPU6050_CLOCK_INTERNAL_8MHZ ;break;
     }
       rcs->setClockSource(d);
    };

    void B4RMPU6050::setScale(byte scale)
    { mpu6050_dps_t d;
       switch(scale) {
        case 0b11 : d =  mpu6050_dps_t::MPU6050_SCALE_2000DPS;break;
        case 0b10 : d =  mpu6050_dps_t::MPU6050_SCALE_1000DPS;break;
        case 0b01 : d =  mpu6050_dps_t::MPU6050_SCALE_500DPS ;break;
        case 0b00 : d =  mpu6050_dps_t::MPU6050_SCALE_250DPS ;break;
        default   : d =  mpu6050_dps_t::MPU6050_SCALE_2000DPS;break;
       }
       rcs->setScale(d);
    };

    void B4RMPU6050::setRange(byte range)
    { mpu6050_range_t e;
       switch (range) {
        case 0b11 : e = mpu6050_range_t::MPU6050_RANGE_16G;break;
        case 0b10 : e = mpu6050_range_t::MPU6050_RANGE_8G ;break;
        case 0b01 : e = mpu6050_range_t::MPU6050_RANGE_4G ;break;
        case 0b00 : e = mpu6050_range_t::MPU6050_RANGE_2G ;break;
        default   : e = mpu6050_range_t::MPU6050_RANGE_2G ;break;
       }
       rcs->setRange( e);
    };

    byte B4RMPU6050::getClockSource()
    {
      mpu6050_clockSource_t det = rcs->getClockSource();
      return det; 
    };

    byte B4RMPU6050::getScale()
    {
       byte d = rcs->getScale();
       return d;
    };

    byte B4RMPU6050::getRange()
    {
       byte d = rcs->getRange();
       return d;
    };

    void B4RMPU6050::setDHPFMode(byte dhpf)
    {  mpu6050_dhpf_t d;
       switch (dhpf) {
        case 0b111 : d = mpu6050_dhpf_t::MPU6050_DHPF_HOLD   ;break;
        case 0b100 : d = mpu6050_dhpf_t::MPU6050_DHPF_0_63HZ ;break;
        case 0b011 : d = mpu6050_dhpf_t::MPU6050_DHPF_1_25HZ ;break;
        case 0b010 : d = mpu6050_dhpf_t::MPU6050_DHPF_2_5HZ  ;break;
        case 0b001 : d = mpu6050_dhpf_t::MPU6050_DHPF_5HZ    ;break;
        case 0b000 : d = mpu6050_dhpf_t::MPU6050_DHPF_RESET  ;break;
        default    : d = mpu6050_dhpf_t::MPU6050_DHPF_RESET  ;break;
       }
       rcs->setDHPFMode(d);
    };

    void B4RMPU6050::setDLPFMode(byte dlpf)
    {  mpu6050_dlpf_t d;
       switch (dlpf) {    
        case 0b110 : d = mpu6050_dlpf_t::MPU6050_DLPF_6 ;break;
        case 0b101 : d = mpu6050_dlpf_t::MPU6050_DLPF_5 ;break;
        case 0b100 : d = mpu6050_dlpf_t::MPU6050_DLPF_4 ;break;
        case 0b011 : d = mpu6050_dlpf_t::MPU6050_DLPF_3 ;break;
        case 0b010 : d = mpu6050_dlpf_t::MPU6050_DLPF_2 ;break;
        case 0b001 : d = mpu6050_dlpf_t::MPU6050_DLPF_1 ;break;
        case 0b000 : d = mpu6050_dlpf_t::MPU6050_DLPF_0 ;break;
        default    : d = mpu6050_dlpf_t::MPU6050_DLPF_0 ;break;
        }
       rcs->setDLPFMode(d);
    };

    byte B4RMPU6050::getAccelPowerOnDelay()
    {
       return rcs->getAccelPowerOnDelay();
    };

    void B4RMPU6050::setAccelPowerOnDelay(byte delay)
    {  mpu6050_onDelay_t d;
       switch (delay) {
        case 0b11 : d = mpu6050_onDelay_t::MPU6050_DELAY_3MS ;break;
        case 0b10 : d = mpu6050_onDelay_t::MPU6050_DELAY_2MS ;break;
        case 0b01 : d = mpu6050_onDelay_t::MPU6050_DELAY_1MS ;break;
        case 0b00 : d = mpu6050_onDelay_t::MPU6050_NO_DELAY  ;break;
        default   : d = mpu6050_onDelay_t::MPU6050_NO_DELAY  ;break;
       } 
       rcs->setAccelPowerOnDelay( d);
    };

    byte B4RMPU6050::getIntStatus()
    {
       return rcs->getIntStatus();
    };

    bool B4RMPU6050::getIntZeroMotionEnabled()
    {
       return rcs->getIntZeroMotionEnabled();
    };

    void B4RMPU6050::setIntZeroMotionEnabled(bool state)
    {
       rcs->setIntZeroMotionEnabled(state);
    };

    bool B4RMPU6050::getIntMotionEnabled()
    {
       return rcs->getIntMotionEnabled();
    };

    void B4RMPU6050::setIntMotionEnabled(bool state)
    {
       rcs->setIntMotionEnabled(state);
    };

    bool B4RMPU6050::getIntFreeFallEnabled()
    {
       return rcs->getIntFreeFallEnabled();
    };

    void B4RMPU6050::setIntFreeFallEnabled(bool state)
    {
       rcs->setIntFreeFallEnabled(state);
    };

    byte B4RMPU6050::getMotionDetectionThreshold()
    {
       return rcs->getMotionDetectionThreshold();
    };

    void B4RMPU6050::setMotionDetectionThreshold(byte threshold)
    {
       rcs->setMotionDetectionThreshold(threshold);
    };

    byte B4RMPU6050::getMotionDetectionDuration()
    {
       return rcs->getMotionDetectionDuration();
    };

    void B4RMPU6050::setMotionDetectionDuration(byte duration)
    {
       rcs->setMotionDetectionDuration(duration);
    };

    byte B4RMPU6050::getZeroMotionDetectionThreshold()
    {
       return rcs->getZeroMotionDetectionThreshold();
    };

    void B4RMPU6050::setZeroMotionDetectionThreshold(byte threshold)
    {
       rcs->setZeroMotionDetectionThreshold(threshold);
    };

    byte B4RMPU6050::getZeroMotionDetectionDuration()
    {
       return rcs->getZeroMotionDetectionDuration();
    };

    void B4RMPU6050::setZeroMotionDetectionDuration(byte duration)
    {
       rcs->setZeroMotionDetectionDuration(duration);
    };

    byte B4RMPU6050::getFreeFallDetectionThreshold()
    {
       return rcs->getFreeFallDetectionThreshold();
    };

    void B4RMPU6050::setFreeFallDetectionThreshold(byte threshold)
    {
       rcs->setFreeFallDetectionThreshold(threshold);
    };

    byte B4RMPU6050::getFreeFallDetectionDuration()
    {
       return rcs->getFreeFallDetectionDuration();
    };

    void B4RMPU6050::setFreeFallDetectionDuration(byte duration)
    {
       rcs->setFreeFallDetectionDuration(duration);
    };

    bool B4RMPU6050::getSleepEnabled()
    {
       return rcs->getSleepEnabled();
    };

    void B4RMPU6050::setSleepEnabled(bool state)
    {
       rcs->setSleepEnabled(state);
    };

    bool B4RMPU6050::getI2CMasterModeEnabled()
    {
       return rcs->getI2CMasterModeEnabled();
    };

    void B4RMPU6050::setI2CMasterModeEnabled(bool state)
    {
       rcs->setI2CMasterModeEnabled(state);
    };

    bool B4RMPU6050::getI2CBypassEnabled()
    {
       return rcs->getI2CBypassEnabled();
    };

    void B4RMPU6050::setI2CBypassEnabled(bool state)
    {
       rcs->setI2CBypassEnabled(state);
    };

    double B4RMPU6050::readTemperature()
    {
       return rcs->readTemperature();
    };
    
      uint16_t B4RMPU6050::readActivites()
      {  uint16_t raw = 0;
       Activites Active = rcs->readActivites(); 
       if (Active.isOverflow      ) {raw=raw | 0b0000000000010000;};
       if (Active.isFreeFall      ) {raw=raw | 0b0000000000001000;};
       if (Active.isInactivity    ) {raw=raw | 0b0000000000000100;};
       if (Active.isActivity      ) {raw=raw | 0b0000000000000010;};
       if (Active.isDataReady     ) {raw=raw | 0b0000000000000001;}; 
       if (Active.isPosActivityOnX) {raw=raw | 0b0000000100000000;}; 
       if (Active.isPosActivityOnY) {raw=raw | 0b0000001000000000;}; 
       if (Active.isPosActivityOnZ) {raw=raw | 0b0000010000000000;}; 
       if (Active.isNegActivityOnX) {raw=raw | 0b0000100000000000;}; 
       if (Active.isNegActivityOnY) {raw=raw | 0b0001000000000000;}; 
       if (Active.isNegActivityOnZ) {raw=raw | 0b0010000000000000;};                                
       return raw ;
    };
    
    int16_t B4RMPU6050::getGyroOffsetX()
    {
       return rcs->getGyroOffsetX();
    };

    void B4RMPU6050::setGyroOffsetX(int16_t offset)
    {
       rcs->setGyroOffsetX(offset);
    };

    int16_t B4RMPU6050::getGyroOffsetY()
    {
       return rcs->getGyroOffsetY();
    };

    void B4RMPU6050::setGyroOffsetY(int16_t offset)
    {
       rcs->setGyroOffsetY(offset);
    };

    int16_t B4RMPU6050::getGyroOffsetZ()
    {
       return rcs->getGyroOffsetZ();
    };

    void B4RMPU6050::setGyroOffsetZ(int16_t offset)
    {
       rcs->setGyroOffsetZ(offset);
    };

    int16_t B4RMPU6050::getAccelOffsetX()
    {
       return rcs->getAccelOffsetX();
    };

    void B4RMPU6050::setAccelOffsetX(int16_t offset)
    {
       rcs->setAccelOffsetX(offset);
    };

    int16_t B4RMPU6050::getAccelOffsetY()
    {
       return rcs->getAccelOffsetY();
    };

    void B4RMPU6050::setAccelOffsetY(int16_t offset)
    {
       rcs->setAccelOffsetY(offset);
    };

    int16_t B4RMPU6050::getAccelOffsetZ()
    {
       return rcs->getAccelOffsetZ();
    };

    void B4RMPU6050::setAccelOffsetZ(int16_t offset)
    {
       rcs->setAccelOffsetZ(offset);
    };

    void B4RMPU6050::calibrateGyro(byte samples)
    {
       rcs->calibrateGyro(samples);
    };

    void B4RMPU6050::setThreshold(byte multiple)
    {
       rcs->setThreshold(multiple);
    };

    byte B4RMPU6050::getThreshold()
    {
       return rcs->getThreshold();
    };

    void B4RMPU6050::readRawGyro(ArrayDouble* accel)
    {
       Vector accel1 = rcs->readScaledAccel();
       float * raw = (float*)accel->data;
       raw[0]=accel1.XAxis; raw[1]=accel1.YAxis; raw[2]=accel1.ZAxis;
       accel->data = raw;
    };

    void B4RMPU6050::readNormalizeGyro(ArrayDouble* accel)
    {
       Vector accel1 = rcs->readScaledAccel();
        float * raw = (float*)accel->data;
       raw[0]=accel1.XAxis; raw[1]=accel1.YAxis; raw[2]=accel1.ZAxis;
       accel->data = raw;
    };

    void B4RMPU6050::readRawAccel(ArrayDouble* accel)
    {
        Vector accel1 = rcs->readScaledAccel();
        float * raw = (float*)accel->data;
       raw[0]=accel1.XAxis; raw[1]=accel1.YAxis; raw[2]=accel1.ZAxis;
       accel->data = raw;
    };
    
    void B4RMPU6050::readNormalizeAccel(ArrayDouble* accel)
    {
        Vector accel1 = rcs->readScaledAccel();
       float * raw = (float*)accel->data;
       raw[0]=accel1.XAxis; raw[1]=accel1.YAxis; raw[2]=accel1.ZAxis;
       accel->data = raw;
    };

    void B4RMPU6050::readScaledAccel(ArrayDouble* accel)
    {
       Vector accel1 = rcs->readScaledAccel();
       float * raw = (float*)accel->data;
       raw[0]=accel1.XAxis; raw[1]=accel1.YAxis; raw[2]=accel1.ZAxis;
       accel->data = raw;
    };
}

