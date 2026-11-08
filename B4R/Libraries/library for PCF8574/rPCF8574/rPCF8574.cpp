
#include "B4RDefines.h"

namespace B4R
{
    void B4RPCF8574::Initialize(byte deviceAddr)
    {
      pcf = new (backend) PCF8574(deviceAddr);
    };
    
    void B4RPCF8574::InitializeEsp8266(byte deviceAddr, int sda, int scl)
    {  
    #if defined (ESP8266)   
      Wire.begin(sda, scl); pcf = new (backend) PCF8574(deviceAddr);
    #endif  
    };
    
    void B4RPCF8574::InitializeEsp32(byte deviceAddr,byte I2Cbus, int sda, int scl)
    { 
    #if defined (ESP32)             
      if (I2Cbus==2)      {TwoWire Wire2=TwoWire(2); Wire2.begin(sda, scl); pcf = new (backend) PCF8574(deviceAddr, &Wire2);}
      else if (I2Cbus==1) {TwoWire Wire1=TwoWire(1); Wire1.begin(sda, scl); pcf = new (backend) PCF8574(deviceAddr, &Wire1);}
      else if (I2Cbus==0) {TwoWire Wire0=TwoWire(0); Wire0.begin(sda, scl); pcf = new (backend) PCF8574(deviceAddr, &Wire0);}
      else                {Wire.begin(sda, scl); pcf = new (backend) PCF8574(deviceAddr);}
    #endif  
    };
    
    bool B4RPCF8574::begin(byte value)
    {
       return pcf->begin(value);
    };

    bool B4RPCF8574::isConnected()
    {
       return pcf->isConnected();
    };

    bool B4RPCF8574::setAddress(byte deviceAddr)
    {
       return pcf->setAddress(deviceAddr);
    };

    byte B4RPCF8574::getAddress()
    {
       return pcf->getAddress();
    };

    byte B4RPCF8574::read8()
    {
       return pcf->read8();
    };

    byte B4RPCF8574::read(byte pin)
    {
       return pcf->read(pin);
    };

    byte B4RPCF8574::value()
    {
       return pcf->value();
    };

    void B4RPCF8574::write8(byte value)
    {
       pcf->write8(value);
    };

    void B4RPCF8574::write(byte pin, byte value)
    {
       pcf->write(pin, value);
    };

    byte B4RPCF8574::valueOut()
    {
       return pcf->valueOut();
    };

    bool B4RPCF8574::writeArray(ArrayByte* array, byte size)
    {
       return pcf->writeArray((byte*)array->data, size);
    };

    bool B4RPCF8574::readArray(ArrayByte* array, byte size)
    {
       return pcf->readArray((byte*)array->data, size);
    };

    byte B4RPCF8574::readButton8()
    {
       return pcf->readButton8();
    };

    byte B4RPCF8574::readButton81(byte mask)
    {
       return pcf->readButton8(mask);
    };

    byte B4RPCF8574::readButton(byte pin)
    {
       return pcf->readButton(pin);
    };

    void B4RPCF8574::setButtonMask(byte mask)
    {
       pcf->setButtonMask(mask);
    };

    byte B4RPCF8574::getButtonMask()
    {
       return pcf->getButtonMask();
    };

    void B4RPCF8574::toggle(byte pin)
    {
       pcf->toggle(pin);
    };

    void B4RPCF8574::toggleMask(byte mask)
    {
       pcf->toggleMask(mask);
    };

    void B4RPCF8574::shiftRight(byte n)
    {
       pcf->shiftRight(n);
    };

    void B4RPCF8574::shiftLeft(byte n)
    {
       pcf->shiftLeft(n);
    };

    void B4RPCF8574::rotateRight(byte n)
    {
       pcf->rotateRight(n);
    };

    void B4RPCF8574::rotateLeft(byte n)
    {
       pcf->rotateLeft(n);
    };

    void B4RPCF8574::reverse()
    {
       pcf->reverse();
    };

    void B4RPCF8574::select(byte pin)
    {
       pcf->select(pin);
    };

    void B4RPCF8574::selectN(byte pin)
    {
       pcf->selectN(pin);
    };

    void B4RPCF8574::selectNone()
    {
       pcf->selectNone();
    };

    void B4RPCF8574::selectAll()
    {
       pcf->selectAll();
    };

    int16_t B4RPCF8574::lastError()
    {
       return pcf->lastError();
    };


}
