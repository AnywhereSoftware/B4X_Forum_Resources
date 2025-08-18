#include "B4RDefines.h"
//#include <Wire.h>

namespace B4R
{
    void B4RMPU9250_asukiaaa::Initialize1(byte I2Cbus, byte MPU9250_ADDR)
    {       
       rcs = new (backend) MPU9250_asukiaaa(MPU9250_ADDR);
       if (I2Cbus==2) {TwoWire Wire2; Wire2.begin(); rcs->setWire(&Wire2);};
       if (I2Cbus==1) {TwoWire Wire1; Wire1.begin(); rcs->setWire(&Wire1);}
       else {Wire.begin(); rcs->setWire(&Wire);}; 
    }; 
       
    void B4RMPU9250_asukiaaa::Initialize2(byte I2Cbus,byte sda, byte scl, byte MPU9250_ADDR)
    {       
       rcs = new (backend) MPU9250_asukiaaa(MPU9250_ADDR);
       if (I2Cbus==2) {TwoWire Wire2; Wire2.begin(sda, scl); rcs->setWire(&Wire2);};
       if (I2Cbus==1) {TwoWire Wire1; Wire1.begin(sda, scl); rcs->setWire(&Wire1);}
       else {Wire.begin(sda, scl); rcs->setWire(&Wire);}; 
//       Wire.begin(sda, scl); rcs->setWire(&Wire);
    };
 
    byte B4RMPU9250_asukiaaa::readId()
    {
      uint8_t sensorId=0, sensorR=0;
      sensorR = rcs->readId(&sensorId);
 //     rcs->Serialprintln(String(sensorR)+","+String(sensorId));
      if (sensorR == 0) {return sensorId;} else {return 255;}
    };

    void B4RMPU9250_asukiaaa::beginAccel(byte Acc_mode)
    {
       if (Acc_mode==255) {rcs->beginAccel();} else {rcs->beginAccel(Acc_mode);};
    };

    byte B4RMPU9250_asukiaaa::accelUpdate()
    {
       return rcs->accelUpdate();
    };

    float B4RMPU9250_asukiaaa::accelX()
    {
       return rcs->accelX();
    };

    float B4RMPU9250_asukiaaa::accelY()
    {
       return rcs->accelY();
    };

    float B4RMPU9250_asukiaaa::accelZ()
    {
       return rcs->accelZ();
    };

    float B4RMPU9250_asukiaaa::accelSqrt()
    {
       return rcs->accelSqrt();
    };

    void B4RMPU9250_asukiaaa::beginGyro(byte Gyro_mode)
    {
       if (Gyro_mode==255) {rcs->beginGyro();} else {rcs->beginGyro(Gyro_mode);};    
    };

    byte B4RMPU9250_asukiaaa::gyroUpdate()
    {
       return rcs->gyroUpdate();
    };

    float B4RMPU9250_asukiaaa::gyroX()
    {
       return rcs->gyroX();
    };

    float B4RMPU9250_asukiaaa::gyroY()
    {
       return rcs->gyroY();
    };

    float B4RMPU9250_asukiaaa::gyroZ()
    {
       return rcs->gyroZ();
    };

    void B4RMPU9250_asukiaaa::beginMag(byte Mag_mode)
    {
       if (Mag_mode==255) {rcs->beginMag();} else {rcs->beginMag(Mag_mode);};
    };

    void B4RMPU9250_asukiaaa::magSetMode(byte Mag_mode)
    {
       rcs->magSetMode(Mag_mode);
    };

    byte B4RMPU9250_asukiaaa::magUpdate()
    {
       return rcs->magUpdate();
    };

    float B4RMPU9250_asukiaaa::magX()
    {
       return rcs->magX();
    };

    float B4RMPU9250_asukiaaa::magY()
    {
       return rcs->magY();
    };

    float B4RMPU9250_asukiaaa::magZ()
    {
       return rcs->magZ();
    };

    float B4RMPU9250_asukiaaa::magHorizDirection()
    {
       return rcs->magHorizDirection();
    };
    
    void B4RMPU9250_asukiaaa::setmagXOffset(int16_t offset)
    {
       rcs->setmagXOffset(offset);
    };
    
    void B4RMPU9250_asukiaaa::setmagYOffset(int16_t offset)
    {
       rcs->setmagYOffset(offset);
    };

    void B4RMPU9250_asukiaaa::setmagZOffset(int16_t offset) 
    {
       rcs->setmagXOffset(offset);    
    };
}
