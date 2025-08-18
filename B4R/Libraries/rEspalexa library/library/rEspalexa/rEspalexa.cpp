
#include "B4RDefines.h"

    void DeviceChange(EspalexaDevice* d);
namespace B4R
{

    B4REspalexa* B4REspalexa::instance = NULL;
    void B4REspalexa::Initialize(SubVoid_Byte DeviceChangedSub)
    {
       rcs = new (backend) Espalexa();
       this->DeviceChangedSub = DeviceChangedSub; 
       instance = this;
       rcs->begin();
    };

    void B4REspalexa::DeviceChanged(byte index) 
    {
       instance->DeviceChangedSub(index);
    };
    
    void B4REspalexa::RunLoop()
    {
       rcs->loop();
    };

    byte B4REspalexa::addDeviceOnOff(B4RString* DeviceName, byte initialValue)
    {
       return rcs->addDevice(DeviceName->data, DeviceChange, EspalexaDeviceType::onoff, initialValue);
    };

    byte B4REspalexa::addDeviceDimming(B4RString* DeviceName, byte initialValue)
    {
       return rcs->addDevice(DeviceName->data, DeviceChange, EspalexaDeviceType::dimmable, initialValue);
    };

    byte B4REspalexa::addDeviceWhiteSpectrum(B4RString* DeviceName, byte initialValue)
    {
       return rcs->addDevice(DeviceName->data, DeviceChange, EspalexaDeviceType::whitespectrum, initialValue);
    };
    
    byte B4REspalexa::addDeviceColor(B4RString* DeviceName, byte initialValue)
    {
       return rcs->addDevice(DeviceName->data, DeviceChange, EspalexaDeviceType::color, initialValue);
    };    
    
    byte B4REspalexa::addDevice(B4RString* DeviceName, byte DeviceType )
    {
      EspalexaDeviceType DT;
      switch (DeviceType) {
      case 0:  DT = EspalexaDeviceType::onoff;break;
      case 1:  DT = EspalexaDeviceType::dimmable;break;
      case 2:  DT = EspalexaDeviceType::whitespectrum;break;
      case 3:  DT = EspalexaDeviceType::color;break;
      case 4:  DT = EspalexaDeviceType::extendedcolor;break; 
      default: DT = EspalexaDeviceType::onoff;break;                          
      }
       EspalexaDevice* d = new EspalexaDevice(DeviceName->data, DeviceChange,  DT); 
       if (d == nullptr) return 0; 
       rcs->addDevice(d);
       return d->getId();
    };


    void B4REspalexa::setDiscoverable(bool d)
    {
       rcs->setDiscoverable(d);
    };
    
    B4RString* B4REspalexa::getName(byte index)
    {
       String rax;
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) { rax = " ";  }
       else { rax = d->getName(); }
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    }; 
    
    byte B4REspalexa::getLastChangedProperty(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       switch(d->getLastChangedProperty()) {
       case EspalexaDeviceProperty::none : return 0;break;
       case EspalexaDeviceProperty::on   : return 1;break;
       case EspalexaDeviceProperty::off  : return 2;break;
       case EspalexaDeviceProperty::bri  : return 3;break;
       case EspalexaDeviceProperty::hs   : return 4;break;
       case EspalexaDeviceProperty::ct   : return 5;break; 
       case EspalexaDeviceProperty::xy   : return 6;break; 
       default                           : return 0;break;
       }
    };        
        
    B4RString* B4REspalexa::getEscapedMac()
    {
       String rax = rcs->getEscapedMac();
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };

    byte B4REspalexa::toPercent(byte bri)
    {
       return rcs->toPercent(bri);
    };

    byte B4REspalexa::getValue(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       return d->getValue();
    };

    byte B4REspalexa::getLastValue(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       return d->getLastValue();
    };

    bool B4REspalexa::getState(byte index)
    {                          
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return false;
       return d->getState();
    };

    byte B4REspalexa::getPercent(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       return d->getPercent();
    };

    byte B4REspalexa::getDegrees(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       return d->getDegrees();
    };

    uint16_t B4REspalexa::getHue(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       return d->getHue();
    };

    byte B4REspalexa::getSat(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       return d->getSat();
    };

    uint16_t B4REspalexa::getCt(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       return d->getCt();
    };

    uint32_t B4REspalexa::getKelvin(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;    
       return d->getKelvin();
    };

    float B4REspalexa::getX(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;     
       return d->getX();
    };

    float B4REspalexa::getY(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       return d->getY();
    };

    uint32_t B4REspalexa::getRGB(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       return d->getRGB();
    };

    byte B4REspalexa::getR(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       return d->getR();
    };

    byte B4REspalexa::getG(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       return d->getG();
    };

    byte B4REspalexa::getB(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       return d->getB();
    };

    byte B4REspalexa::getW(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       return d->getW();
    };
    
    byte B4REspalexa::getColorMode(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       switch (d->getColorMode()) {
       case EspalexaColorMode::none  : return 0;break;
       case EspalexaColorMode::ct    : return 1;break;
       case EspalexaColorMode::hs    : return 2;break;
       case EspalexaColorMode::xy    : return 3;break; 
       default                       : return 0;break;                         
       }
    };
    
    byte B4REspalexa::getType(byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return 0;
       switch(d->getType()) {
       case EspalexaDeviceType::onoff          : return 0;break;
       case EspalexaDeviceType::dimmable       : return 1;break;
       case EspalexaDeviceType::whitespectrum  : return 2;break;
       case EspalexaDeviceType::color          : return 3;break;
       case EspalexaDeviceType::extendedcolor  : return 4;break;
       default                                 : return 0;break;
       }
    };        

    void B4REspalexa::setId(byte id, byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return;
       d->setId(id);
    };

    void B4REspalexa::setValue(byte bri, byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return;
       d->setValue(bri);
    };

    void B4REspalexa::setState(bool onoff, byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return;
       d->setState(onoff);
    };

    void B4REspalexa::setPercent(byte perc, byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return;
       d->setPercent(perc);
    };

    void B4REspalexa::setName(B4RString* name, byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return;
       d->setName(name->data);
    };

    void B4REspalexa::setColorCT(uint16_t ct, byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return;
       d->setColor(ct);
    };

    void B4REspalexa::setColorHS(uint16_t hue, byte sat, byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return;
       d->setColor(hue, sat);
    };

    void B4REspalexa::setColorXY(float x, float y, byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return;
       d->setColorXY(x, y);
    };

    void B4REspalexa::setColorRBG(byte r, byte g, byte b, byte index)
    {
       EspalexaDevice* d = rcs->getDevice(index);
       if (d == nullptr) return;
       d->setColor(r, g, b);
    };
    
     void B4REspalexa::processing(byte cb)
    {
       EspalexaDevice* d = rcs->getDevice(cb);
       if (d == nullptr) return ;
       rcs->processing(d);
    };


}
    void DeviceChange(EspalexaDevice* d)
    {
       if (d == nullptr) return;
       byte dout = d->getId();
       B4R::B4REspalexa::DeviceChanged(dout);
    };

