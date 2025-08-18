
#pragma once
#include "B4RDefines.h"
#include "PCF8574.h"

    //~Event: 
    //~Version: 1.0 
    //~Author - 
    //~Libray from Arduino

namespace B4R {
    //~shortname:PCF8574
    class B4RPCF8574
    {
        private:
            uint8_t backend[sizeof(PCF8574)];
            PCF8574* rcs;
//       rcs = new (backend) PCF8574(deviceAddress, TwoWire * wire);
        public: 
            void Initialize(byte deviceAddress);  
#if defined (ESP32)                    
            void Initializeesp32(byte deviceAddress, byte I2Cbus);
#else
   #error   function Only for esp32            
#endif 
#if defined (ESP8266) || defined(ESP32)            
            bool beginesp(byte sda, byte scl, byte initB);
#else
   #error   function Only for esp32  and esp8266             
#endif            
            bool begin(byte initB);
            bool isConnected();
            byte read8();
            byte read(byte pin);
            byte value();
            void write8(byte value);
            void write(byte pin, byte value);
            byte valueOut();
            byte readButton8();
            byte readButton8Mask(byte mask);
            byte readButton(byte pin);
            void setButtonMask(byte mask);
            void toggle(byte pin);
            void toggleMask(byte mask);
            void shiftRight(byte n);
            void shiftLeft(byte n);
            void rotateRight(byte n);
            void rotateLeft(byte n);
            void reverse();
            int16_t lastError();
            
            static const byte I2C_TwoWire0                 =0x0;
            static const byte I2C_TwoWire1                 =0x1;
            static const byte I2C_TwoWire2                 =0x2;    
            static const byte I2C_Wire                     =0xFF;              
    };
}
