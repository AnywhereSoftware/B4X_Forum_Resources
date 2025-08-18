#pragma once
#include "B4RDefines.h"
#include "SPI.h"

    //~Event: 
    //~Version: 1.0 
    //~Author - 
    //~Libray from Arduino

namespace B4R {
    //~shortname:SPI
    class B4RSPIClass
    {
        private:
            uint8_t backend[sizeof(SPIClass)];
            SPIClass* rcs;
 
        public: 
            bool Initialize(byte sck, byte miso, byte mosi, byte ss);
            void begin();
            void end();
            void setHwCs(bool use);
            void setBitOrder(byte bitOrder);
            void setDataMode(byte dataMode);
            void setFrequency(uint32_t freq);
            void setClockDivider(uint32_t clockDiv);
            void beginTransaction(uint32_t clock,byte bitOrder,byte dataMode);
            byte transfer8(byte data);
            uint16_t transfer16(uint16_t data);
            void transfer(ArrayByte* buf, uint16_t count);
            void write(byte data);
            void write16(uint16_t data);
            void write161(uint16_t data, bool msb);
            void write32(uint32_t data);
            void write321(uint32_t data, bool msb);
            void writeBytes(ArrayByte* data, uint32_t size);
            void writePattern(ArrayByte* data, byte size, uint32_t repeat);
            void transferBytes(ArrayByte* out, ArrayByte* in, uint32_t size);
            void endTransaction();
            
            //bitOrder
            #define /*byte bitOrder_LSBFIRSTS;*/        B4R_LSBFIRST	     0x0 
            #define /*byte bitOrder_MSBFIRST;*/         B4R_MSBFIRST	     0x1               

            //clock  
            #define /*Ulong  clock_SPI_CLOCK_DIV2;*/    B4R_SPI_CLOCK_DIV2 	     0x00101001  //8 MHz  
            #define /*Ulong  clock_SPI_CLOCK_DIV4;*/    B4R_SPI_CLOCK_DIV4 	     0x00241001  //4 MHz         
            #define /*Ulong  clock_SPI_CLOCK_DIV8;*/    B4R_SPI_CLOCK_DIV8       0x004c1001  //2 MHz    
            #define /*Ulong  clock_SPI_CLOCK_DIV16;*/   B4R_SPI_CLOCK_DIV16      0x009c1001  //1 MHz            
            #define /*Ulong  clock_SPI_CLOCK_DIV32;*/   B4R_SPI_CLOCK_DIV32      0x013c1001  //500 KHz            
            #define /*Ulong  clock_SPI_CLOCK_DIV64;*/   B4R_SPI_CLOCK_DIV64      0x027c1001  //250 KHz            
            #define /*Ulong  clock_SPI_CLOCK_DIV128;*/  B4R_SPI_CLOCK_DIV128     0x04fc1001  //125 KHz            
            

            //dataMode
            #define /*byte dataMode_SPI_MODE0;*/        B4R_SPI_MODE0            0x00  ///<  CPOL: 0  CPHA: 0           
            #define /*byte dataMode_SPI_MODE1;*/        B4R_SPI_MODE1            0x01  ///<  CPOL: 0  CPHA: 1           
            #define /*byte dataMode_SPI_MODE2;*/        B4R_SPI_MODE2            0x10  ///<  CPOL: 1  CPHA: 0
            #define /*byte dataMode_SPI_MODE3;*/        B4R_SPI_MODE3            0x11  ///<  CPOL: 1  CPHA: 1           
    };
}
