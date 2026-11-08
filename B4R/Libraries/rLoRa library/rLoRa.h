#pragma once
#include "B4RDefines.h"
#include "LoRa.h"                                                                                                                                                           
#include <SPI.h>

    //~Event: OnReceive(packetSize as int) 
    //~Event: OnTxDone()
    //~Version: 1.0 
    //~Author - 
    //~Libray from : https://github.com/sandeepmistry/arduino-LoRa

namespace B4R { 
    typedef void (*Subvoid_int)(int16_t packetSize);
    typedef void (*Subvoid_void)();
      
    //~shortname: LoRa
    class B4RLoRa
    {
        private:
            uint8_t backend[sizeof(LoRaClass)];
            LoRaClass* rcs;
            static B4RLoRa* instance; 
            static boolean LoopOn;             
            Subvoid_int OnReceiveSub;
            Subvoid_void OnTxDoneSub;  
            PollerNode pnode;
            static void looper(void* b); 
            void LoopStart();                    

        public:   
        //   not for ARDUINO_SAMD_MKRWAN1300 , configuration with callbacks
            void Initialize();
            int16_t begin(long frequency);    
            void setOnReceive( Subvoid_int OnReceiveSub);
            void setOnTxDone( Subvoid_void OnTxDoneSub);   
            static void OnReceive(int16_t packetSize);
            static void OnTxDone();
            void end();
            int16_t beginPacket(int16_t implicitHeader);
            int16_t endPacket(bool async);
            int16_t parsePacket(int16_t size);
            int16_t packetRssi();
            float packetSnr();
            int32_t packetFrequencyError();
            int16_t rssi();
            uint16_t write(byte byte);
            uint16_t write1(ArrayByte* buffer);
            void print(B4RString* txt);
            void println(B4RString* txt);
            int16_t available();
            int16_t read();
            int16_t peek();
            void flush();
        //   not for ARDUINO_SAMD_MKRWAN1300 , working with callbacks
            void receive(int16_t size);
            void idle();
            void sleep();
            void setTxPower(int16_t level, int16_t outputPin);
            void setFrequency(int32_t frequency);
            void setSpreadingFactor(int16_t sf);
            void setSignalBandwidth(int32_t sbw);
            void setCodingRate4(int16_t denominator);
            void setPreambleLength(int32_t length);
            void setSyncWord(int16_t sw);
            void enableCrc();
            void disableCrc();
            void enableInvertIQ();
            void disableInvertIQ();
            void setOCP(byte mA);
            void setGain(byte gain);
            byte random();
            void setPins(int16_t ss, int16_t reset, int16_t dio0);
            void setSPI(byte SPIbus);
            void setSPI1(byte SPIbus,byte sck, byte miso, byte mosi, byte ss);          
            void setSPIFrequency(uint32_t frequency);
            void dumpRegisters(ArrayByte* DumpOut);        
            //SPI bus

            #define /*byte    ESP32_FSPI;*/           B4R_FSPI                  0x1 
            #define /*byte    ESP32_HSPI;*/           B4R_HSPI                  0x2
            #define /*byte    ESP32_VSPI;*/           B4R_VSPI                  0x3    
            #define /*byte    ESP32C3_FSPI;*/         B4RC3_FSPI                0x0   
            #define /*byte    ESP32C3_HSPI;*/         B4RC3_HSPI                0x1   
            #define /*byte    ESP32S2_FSPI;*/         B4RS2_FSPI                0x1   
            #define /*byte    ESP32S2_HSPI;*/         B4RS2_HSPI                0x2   
    };
}
