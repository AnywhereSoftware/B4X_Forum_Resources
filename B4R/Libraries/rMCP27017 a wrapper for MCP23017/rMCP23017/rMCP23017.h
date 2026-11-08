#pragma once
#include "B4RDefines.h"
#include "MCP23017.h"

    //~Event: 
    //~Version: 1.0 
    //~Author - 
    //~Libray from https://github.com/wollewald/MCP23017_WE

namespace B4R {
    //~shortname:MCP23017
    class B4RMCP23017
    {
        private:
            uint8_t backend[sizeof(MCP23017)];
            MCP23017* rcs;

        public: 
//Initialize MCP using I2C.
// I2C is by default : Wire 
//param i2c_addr I2C address
//param rp reset pin for reset / 99 = no reset pin   
            void InitializeI2C(byte addr,byte rp);
//begin I2C.
// I2C is by default : Wire 
//sda and scl are pins by default                
            void BeginI2C();
//Initialize MCP using I2C.
// param wire is Wire, Wire1 for ESP32, Wire for others
//param i2c_addr I2C address
//param rp reset pin for reset / 99 = no reset pin        
            void InitializeI2C_Esp(byte wire, byte addr, byte rp);
//begin I2C for ESP32 and ESP8266.
// param wire is Wire, Wire1 for ESP32, Wire for others 
// param sda and scl             
            void BeginI2C_Esp(byte wire, int16_t sda, int16_t scl);       
// Initialize MCP using SPI.
// SPI used by default
//param cs_pin Pin to use for SPI chip select
//param _hw_addr Hardware address (pins A2, A1, A0)  
//param rp reset pin for reset / 99 = no reset pin         
            void InitializeSPI(byte cs, byte rp, byte addr);
//begin SPI.  
// SPI used by default
// SCK, MISO, MOSI, SS are values by default          
            void BeginSPI();     
// Initialize MCP using SPI.
// SPI can be HSPI, VSPI for ESP32, or SPI by default
//param cs_pin Pin to use for SPI chip select
//param _hw_addr Hardware address (pins A2, A1, A0)  
//param rp reset pin for reset / 99 = no reset pin  
            void InitializeSPI_ESP32(Byte SPIbus, byte cs, byte rp, byte addr);
// begin SPI for ESP32.  
// SPI can be HSPI, VSPI for ESP32, or SPI by default
//param SCK, MISO, MOSI, SS : if change of pins for SPI is need / if =-1 value by default               
            void BeginSPI_ESP32(Byte SPIbus, int16_t SCK, int16_t MISO, int16_t MOSI, int16_t SS);   
                                
//initiates the MCP23017 with some register values, 
//sets some private variables; returns false if not connected            
            bool Init();
//reset of the MCP23107 by reset pin           
            void reset();
//sets INPUT/OUTPUT/INPUT_PULLUP for a single pin            
            void setPinMode( uint8_t pin, byte port, uint8_t pinState);
//sets  INPUT/OUTPUT for a complete port            
            void setPortMode(uint8_t portState, byte port);
//with this variant input pins are pulled up; no effect on output pins            
            void setPortMode1(uint8_t val, byte port, uint8_t pu);
//LOW/HIGH for a single pin            
            void setPin(uint8_t pin, byte port, uint8_t pinLevel);
//switches LOW to HIGH or HIGH to LOW            
            void togglePin(uint8_t pin, byte port);
//combination of setPin and setPinMode            
            void setPinX(uint8_t pin, byte port, uint8_t pinState, uint8_t pinLevel);
//sets HIGH/LOW for all Pins            
            void setAllPins(byte port, uint8_t pinLevel);
//sets HIGH/LOW for all Pins            
            void setPort(uint8_t portLevel, byte port);
//sets HIGH / LOW for pins of both ports (A, B);
            void setPortAll(uint8_t portLevelA, uint8_t portLevelB);
//sets pinMode and HIGH/LOW for a complete port 
//(combination of setPortMode and setPort)            
            void setPortX(uint8_t portState, uint8_t portLevel, byte port);
//sets the polarity of INTA and INTB (active-high or active-low)            
            void setInterruptPinPol(uint8_t level);                              //#Meth
//sets INTA and INTB as open drain             
            void setIntOdr(uint8_t openDrain);
//sets interrupt-on-change for a single pin            
            void setInterruptOnChangePin(uint8_t pin, mcp_port port);
//sets interrupt-on-defval-deviation a single pin            
            void setInterruptOnDefValDevPin(uint8_t pin, byte port, uint8_t pinIntLevel);
//sets interrupt-on-change for a port            
            void setInterruptOnChangePort(uint8_t intOnChangePins, byte port);
//sets interrupt-on-defval-deviation a single pin            
            void setInterruptOnDefValDevPort(uint8_t intPins, byte port, uint8_t defVal);
//interrupt pins turn into "normal" pins            
            void deleteAllInterruptsOnPort(byte port);
//sets internal pull-up for a single pin (only input pins are affected)            
            void setPinPullUp(uint8_t pin, byte port, uint8_t pinLevel);
//sets internal pull-up for a port (only input pins are affected)            
            void setPortPullUp(uint8_t pulledUpPins, byte port);
//provides internal pull-up for a port               
            byte getPortPullUp(byte port);
//0/OFF: INTA and INTB working separately; 1/ON: INTA and INTB are mirrored            
            void setIntMirror(uint8_t mirrored);
//provides the content of the INTFLAG register            
            byte getIntFlag(byte port);
//provides the logic level of a single pin            
            bool getPin(uint8_t pin, byte port);
//provides the logic level of a port            
            byte getPort(byte port);
//provides the content of the interrupt capture register
            byte getIntCap(byte port);
//only for TINY_WIRE_M            
            void setSPIClockSpeed(uint32_t clock);
//reset of the MCP23107 withoout reset pin             
            void softReset();
            
            #define /*byte    ESP32_HSPI;*/           B4R_HSPI                  0x2
            #define /*byte    ESP32_VSPI;*/           B4R_VSPI                  0x3    
                           
            #define /*byte ESP_Wire;*/      B4R_I2C_Wire                        0x0
            #define /*byte ESP32_Wire1;*/   B4R_I2C_Wire1                       0x1           
            
            #define /*byte PortA;*/          B4R_PortA                          0x0            
            #define /*byte PortB;*/          B4R_PortB                          0x1 
            
            #define /*byte INPUT;*/          B4R_INPUT                          0x0
            #define /*byte OUTPUT;*/         B4R_OUTPUT                         0x1
            #define /*byte INPUT_PULLUP;*/   B4R_INPUT_PULLUP                   0x2
            
            #define /*byte HIGH;*/           B4R_HIGH                           0x1
            #define /*byte LOW;*/            B4R_LOW                            0x0
            
            #define /*byte ADDRESS_0x20;*/            B4R_ADDRESS_0x20          0x20            
            #define /*byte ADDRESS_0x21;*/            B4R_ADDRESS_0x21          0x21     
            #define /*byte ADDRESS_0x22;*/            B4R_ADDRESS_0x22          0x22     
            #define /*byte ADDRESS_0x23;*/            B4R_ADDRESS_0x23          0x23     
            #define /*byte ADDRESS_0x24;*/            B4R_ADDRESS_0x24          0x24     
            #define /*byte ADDRESS_0x25;*/            B4R_ADDRESS_0x25          0x25  
            #define /*byte ADDRESS_0x26;*/            B4R_ADDRESS_0x26          0x26                 
            #define /*byte ADDRESS_0x27;*/            B4R_ADDRESS_0x27          0x27                    
    };
}
