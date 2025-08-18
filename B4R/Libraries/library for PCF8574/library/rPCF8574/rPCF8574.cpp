
#include "B4RDefines.h"

namespace B4R
{
    void B4RPCF8574::Initialize(byte deviceAddress)
    {
      rcs = new (backend) PCF8574(deviceAddress); 
    };

#if defined (ESP32)             
    void B4RPCF8574::Initializeesp32(byte deviceAddress, byte I2Cbus)
    {  
      if (I2Cbus==2) {TwoWire Wire2=TwoWire(2); rcs = new (backend) PCF8574(deviceAddress, &Wire2);}
      else if (I2Cbus==1) {TwoWire Wire1=TwoWire(1); rcs = new (backend) PCF8574(deviceAddress, &Wire1);}
      else if (I2Cbus==0) {TwoWire Wire0=TwoWire(0); rcs = new (backend) PCF8574(deviceAddress, &Wire0);}
      else {rcs = new (backend) PCF8574(deviceAddress);};       
    };
#endif      
        
#if defined (ESP8266) || defined(ESP32)
    bool B4RPCF8574::beginesp(byte sda, byte scl, byte add)
    {
       return rcs->begin(sda, scl, add);
    };
#endif      
          
    bool B4RPCF8574::begin(byte add)
    {
       return rcs->begin(add);
    };

    bool B4RPCF8574::isConnected()
    {
       return rcs->isConnected();
    };

    byte B4RPCF8574::read8()
    {
       return rcs->read8();
    };

    byte B4RPCF8574::read(byte pin)
    {
       return rcs->read(pin);
    };

    byte B4RPCF8574::value()
    {
       return rcs->value();
    };

    void B4RPCF8574::write8(byte value)
    {
       rcs->write8(value);
    };

    void B4RPCF8574::write(byte pin, byte value)
    {
       rcs->write(pin, value);
    };

    byte B4RPCF8574::valueOut()
    {
       return rcs->valueOut();
    };

    byte B4RPCF8574::readButton8()
    {
       return rcs->readButton8();
    };

    byte B4RPCF8574::readButton8Mask(byte mask)
    {
       return rcs->readButton8(mask);
    };

    byte B4RPCF8574::readButton(byte pin)
    {
       return rcs->readButton(pin);
    };

    void B4RPCF8574::setButtonMask(byte mask)
    {
       rcs->setButtonMask(mask);
    };

    void B4RPCF8574::toggle(byte pin)
    {
       rcs->toggle(pin);
    };

    void B4RPCF8574::toggleMask(byte mask)
    {
       rcs->toggleMask(mask);
    };

    void B4RPCF8574::shiftRight(byte n)
    {
       rcs->shiftRight(n);
    };

    void B4RPCF8574::shiftLeft(byte n)
    {
       rcs->shiftLeft(n);
    };

    void B4RPCF8574::rotateRight(byte n)
    {
       rcs->rotateRight(n);
    };

    void B4RPCF8574::rotateLeft(byte n)
    {
       rcs->rotateLeft(n);
    };

    void B4RPCF8574::reverse()
    {
       rcs->reverse();
    };

    int16_t B4RPCF8574::lastError()
    {
       return rcs->lastError();
    };
}
