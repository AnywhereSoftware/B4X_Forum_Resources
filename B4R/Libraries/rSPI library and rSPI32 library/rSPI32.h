#pragma once
#include "B4RDefines.h"
#include "SPI.h"

    //~Event: 
    //~Version: 1.1  
    // added better configuration on SPIbus for esp32 and added a begin without parameter for default config
    //~Author - 
    //~Libray from Arduino

namespace B4R {
    //~shortname:SPI32
    class B4RSPIClass
    {
        private:
            uint8_t backend[sizeof(SPIClass)];
            SPIClass* rcs;
        public: 
            void Initialize(byte SPIbus);
            // run with configured pins or with default configuration 
            void begin();  
            // run with new configuration of pins. pin=0xFF => pin already configured is used         
            void begin1(byte sck, byte miso, byte mosi, byte ss);
            void end();
            void setHwCs(bool use);
            void setBitOrder(byte bitOrder);
            void setDataMode(byte dataMode);
            void setFrequency(uint32_t freq);
            void setClockDivider(uint32_t clockDiv);
            uint32_t getClockDivider();
            void beginTransaction(uint32_t clock,byte bitOrder,byte dataMode);
            void endTransaction();
            void transfer(ArrayByte* data, uint32_t size);
            byte transfer1(byte data);
            uint16_t transfer16(uint16_t data);
            uint32_t transfer32(uint32_t data);
            void transferBytes(ArrayByte* data, ArrayByte* out, uint32_t size);
            void transferBytesR(ArrayByte* out, uint32_t size);
            void transferBytesW(ArrayByte* data, uint32_t size);                        
            void transferBits(uint32_t data, ArrayULong* out, byte bits);
            void write(byte data);
            void write16(uint16_t data);
            void write32(uint32_t data);
            void writeBytes(ArrayByte* data, uint32_t size);
 //           void writePixels( * data, uint32_t size);
            void writePattern(ArrayByte* data, byte size, uint32_t repeat);
            boolean busStatus();
            byte pinSS();
            
            //SPI bus

            #define /*byte    ESP32_FSPI;*/           B4R_FSPI                  0x1 
            #define /*byte    ESP32_HSPI;*/           B4R_HSPI                  0x2
            #define /*byte    ESP32_VSPI;*/           B4R_VSPI                  0x3    
            #define /*byte    ESP32C3_FSPI;*/         B4RC3_FSPI                0x0   
            #define /*byte    ESP32C3_HSPI;*/         B4RC3_HSPI                0x1   
            #define /*byte    ESP32S2_FSPI;*/         B4RS2_FSPI                0x1   
            #define /*byte    ESP32S2_HSPI;*/         B4RS2_HSPI                0x2   
                        
            //bitOrder
            #define /*byte    SPI_LSBFIRSTS;*/        B4R_LSBFIRST	            0x0 
            #define /*byte    SPI_MSBFIRST;*/         B4R_MSBFIRST	            0x1               

            //clock  
            #define /*Ulong   SPI_CLOCK_DIV2;*/       B4R_SPI_CLOCK_DIV2        0x00101001  //8 MHz  
            #define /*Ulong   SPI_CLOCK_DIV4;*/       B4R_SPI_CLOCK_DIV4 	    0x00241001  //4 MHz         
            #define /*Ulong   PI_CLOCK_DIV8;*/        B4R_SPI_CLOCK_DIV8        0x004c1001  //2 MHz    
            #define /*Ulong   SPI_CLOCK_DIV16;*/      B4R_SPI_CLOCK_DIV16       0x009c1001  //1 MHz            
            #define /*Ulong   SPI_CLOCK_DIV32;*/      B4R_SPI_CLOCK_DIV32       0x013c1001  //500 KHz            
            #define /*Ulong   SPI_CLOCK_DIV64;*/      B4R_SPI_CLOCK_DIV64       0x027c1001  //250 KHz            
            #define /*Ulong   SPI_CLOCK_DIV128;*/     B4R_SPI_CLOCK_DIV128      0x04fc1001  //125 KHz            
            

            //dataMode
            #define /*byte    SPI_MODE0;*/            B4R_SPI_MODE0             0x00  ///<  CPOL: 0  CPHA: 0           
            #define /*byte    SPI_MODE1;*/            B4R_SPI_MODE1             0x01  ///<  CPOL: 0  CPHA: 1           
            #define /*byte    SPI_MODE2;*/            B4R_SPI_MODE2             0x10  ///<  CPOL: 1  CPHA: 0
            #define /*byte    SPI_MODE3;*/            B4R_SPI_MODE3             0x11  ///<  CPOL: 1  CPHA: 1     
    };
}
