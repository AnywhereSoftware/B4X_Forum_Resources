
#include "B4RDefines.h"
#pragma once
#include "B4RDefines.h"
#include "PCF8574.h"

    //~Event: 
    //~Version: 1.1 
    //~Author - 
    //~Libray from Arduino

namespace B4R {
    //~shortname:PCF8574
    class B4RPCF8574
    {
        private:
            uint8_t backend[sizeof(PCF8574)];
            PCF8574* pcf;
        public: 
            void Initialize(byte deviceAddr);
            void InitializeEsp8266(byte deviceAddr, int sda, int scl);            
            void InitializeEsp32(byte deviceAddr,byte I2Cbus, int sda, int scl);
                  
            bool begin(byte value);
            bool isConnected();
            bool setAddress(byte deviceAddr);
            byte getAddress();
            byte read8();
            byte read(byte pin);
            byte value();
            void write8(byte value);
            void write(byte pin, byte value);
            byte valueOut();
            bool writeArray(ArrayByte* array, byte size);
            bool readArray(ArrayByte* array, byte size);
            byte readButton8();
            byte readButton81(byte mask);
            byte readButton(byte pin);
            void setButtonMask(byte mask);
            byte getButtonMask();
            void toggle(byte pin);
            void toggleMask(byte mask);
            void shiftRight(byte n);
            void shiftLeft(byte n);
            void rotateRight(byte n);
            void rotateLeft(byte n);
            void reverse();
            void select(byte pin);
            void selectN(byte pin);
            void selectNone();
            void selectAll();
            int16_t lastError();

            #define /*byte  Wire0;*/                        B4R_Wire0                        0x0
            #define /*byte  Wire1;*/                        B4R_Wire1                        0x1
            #define /*byte  Wire2;*/                        B4R_Wire2                        0x2 
            #define /*byte  Wire;*/                         B4R_Wire                         0xFF 
            
            #define /*byte  PCF8574_INITIAL_VALUE;*/        B4R_PCF8574_INITIAL_VALUE        0xFF
            #define /*byte PCF8574_Address;*/               B4R_PCF8574_Address              0x20

            #define /*byte PCF8574_OK;*/                    B4R_PCF8574_OK                   0x00
            #define /*byte PCF8574_PIN_ERROR;*/             B4R_PCF8574_PIN_ERROR            0x81
            #define /*byte PCF8574_I2C_ERROR;*/             B4R_PCF8574_I2C_ERROR            0x82
            #define /*byte PCF8574_BUFFER_LENGTH_ERROR ;*/  B4R_ PCF8574_BUFFER_LENGTH_ERROR 0x83
    };            
}
