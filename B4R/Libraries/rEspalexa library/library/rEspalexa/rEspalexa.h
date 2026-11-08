
#pragma once
#include "B4RDefines.h"
#include "Espalexa.h"

    //~Event: DeviceChanged(index As byte)
    //~Version: 1.0 
    //~Author - 
    //~Libray from Arduino

namespace B4R {
    typedef void (*SubVoid_Byte)(byte index);
    //~shortname:Espalexa
    class B4REspalexa
    {
        private:
            static B4REspalexa* instance;
            uint8_t backend[sizeof(Espalexa)];
            Espalexa* rcs;
            SubVoid_Byte DeviceChangedSub;
        public: 
            void Initialize(SubVoid_Byte DeviceChangedSub);
            static void DeviceChanged(byte index);
            void RunLoop();
            byte addDeviceOnOff(B4RString* DeviceName, byte initialValue);
            byte addDeviceDimming(B4RString* DeviceName, byte initialValue);
            byte addDeviceWhiteSpectrum(B4RString* DeviceName, byte initialValue);
            byte addDeviceColor(B4RString* DeviceName, byte initialValue);        
            byte addDevice(B4RString* DeviceName, byte DeviceType);             
            void setDiscoverable(bool d);
            B4RString* getEscapedMac();
            byte toPercent(byte bri);
            
            B4RString* getName(byte index);
            byte getLastChangedProperty(byte index);  
            byte getValue(byte index);
            byte getLastValue(byte index);
            bool getState(byte index);
            byte getPercent(byte index);
            byte getDegrees(byte index);
            uint16_t getHue(byte index);
            byte getSat(byte index);
            uint16_t getCt(byte index);
            uint32_t getKelvin(byte index);
            float getX(byte index);
            float getY(byte index);
            uint32_t getRGB(byte index);
            byte getR(byte index);
            byte getG(byte index);
            byte getB(byte index);
            byte getW(byte index);
            byte getColorMode(byte index);
            byte getType(byte index); 
                       
            void setId(byte id, byte index);
            void setValue(byte bri, byte index);
            void setState(bool onoff, byte index);
            void setPercent(byte perc, byte index);
            void setName(B4RString* name, byte index);
            void setColorCT(uint16_t ct, byte index);
            void setColorHS(uint16_t hue, byte sat, byte index);
            void setColorXY(float x, float y, byte index);
            void setColorRBG(byte r, byte g, byte b, byte index);
            void processing(byte cb);
    }; 
	//~Version: 1.00
	//~Shortname: Color
	class B4RColor 
    {
		public:       
              static const byte Mode_none = 0;
              static const byte Mode_ct = 1;
              static const byte Mode_hs = 2;
              static const byte Mode_xy = 3;           
    };
	//~Version: 1.00
	//~Shortname: Device
	class B4RDevice 
    {
		public:       
              static const byte Type_onoff = 0;
              static const byte Type_dimmable = 1;
              static const byte Type_whitespectrum = 2;
              static const byte Type_color = 3;
              static const byte Type_extendedcolor = 4;   

              static const byte Property_none = 0;
              static const byte Property_on = 1;
              static const byte Property_off = 2;
              static const byte Property_bri = 3;
              static const byte Property_hs = 4;          
              static const byte Property_ct = 5;
              static const byte Property_xy = 6;                
    };    
    
}

