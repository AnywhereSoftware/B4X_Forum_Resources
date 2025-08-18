#pragma once
#include "B4RDefines.h"
#include "MPU9250_asukiaaa.h"

    //~Event: 
    //~Version: 1.0 
    //~Author - 
    //~Libray from Arduino

namespace B4R {
    //~shortname:MPU9250
    class B4RMPU9250_asukiaaa
    {
        private:
            uint8_t backend[sizeof(MPU9250_asukiaaa)];
            MPU9250_asukiaaa* rcs;

        public: 
            void Initialize1(byte I2Cbus, byte MPU9250_ADDR);
            void Initialize2(byte I2Cbus, byte sda, byte scl, byte MPU9250_ADDR);
            byte readId();
            void beginAccel(byte Acc_mode);
            byte accelUpdate();
            float accelX();
            float accelY();
            float accelZ();
            float accelSqrt();
            void beginGyro(byte Gyro_mode);
            byte gyroUpdate();
            float gyroX();
            float gyroY();
            float gyroZ();
            void beginMag(byte Mag_mode);
            void magSetMode(byte Mag_mode);
            byte magUpdate();
            float magX();
            float magY();
            float magZ();
            float magHorizDirection();
            void setmagXOffset(int16_t offset);
            void setmagYOffset(int16_t offset);
            void setmagZOffset(int16_t offset); 
             
            static const byte ACC_Full_SCALE_2_G       =0x00;
            static const byte ACC_Full_SCALE_4_G       =0x08;
            static const byte ACC_Full_SCALE_8_G       =0x10;
            static const byte ACC_Full_SCALE_16_G      =0x18;
            static const byte ACC_void                 =0xFF;

            static const byte GYRO_Full_SCALE_250_DPS  =0x00;
            static const byte GYRO_Full_SCALE_500_DPS  =0x08;
            static const byte GYRO_Full_SCALE_1000_DPS =0x10;
            static const byte GYRO_Full_SCALE_2000_DPS =0x18;
            static const byte GYRO_void                =0xFF;            

            static const byte MAG_Mode_POWERDOWN        =0x0;
            static const byte MAG_Mode_SINGLE           =0x1;
            static const byte MAG_Mode_CONTINUOUS_8HZ   =0x2;
            static const byte MAG_Mode_EXTERNAL         =0x4;
            static const byte MAG_Mode_CONTINUOUS_100HZ =0x6;
            static const byte MAG_Mode_SELFTEST         =0x8;
            static const byte MAG_Mode_FUSEROM          =0xF;
            static const byte MAG_void                  =0xFF;           
            
            static const byte I2C_Wire                  =0x0;
            static const byte I2C_Wire1                 =0x1;
            static const byte I2C_Wire2                 =0x2;    

            static const byte MPU9250_Address_AD0_LOW  =0x68;
            static const byte MPU9250_Address_AD0_HIGH =0x69;
        
    };      
}


