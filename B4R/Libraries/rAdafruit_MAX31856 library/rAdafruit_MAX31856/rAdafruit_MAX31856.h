#pragma once
#include "B4RDefines.h"
#include "Adafruit_MAX31856.h"

    //~Event: 
    //~Version: 1.0 
    //~Author - 
    //~Libray from Arduino

namespace B4R {
    //~shortname:Adafruit_MAX31856
    class B4RAdafruit_MAX31856
    {
        private:
            uint8_t backend[sizeof(Adafruit_MAX31856)];
            Adafruit_MAX31856* rcs;

        public: 
            bool Initialize(byte spi_cs);
            bool Initialize1(byte spi_cs,byte spi_mosi,byte spi_miso,byte spi_clk);
            void setConversionMode(byte cvmode);
            byte getConversionMode();
            void setThermocoupleType(byte tctype);
            byte getThermocoupleType();
            byte readFault();
            void triggerOneShot();
            bool conversionComplete();
            float readCJTemperature();
            float readThermocoupleTemperature();
            void setTempFaultThreshholds(float flow, float fhigh);
            void setColdJunctionFaultThreshholds(byte low, byte high);
            void setNoiseFilter(byte nFilter);
            
            #define /*byte MAX31856_NOISE_FILTER_50HZ;*/   B4R_MAX31856_NOISE_FILTER_50HZ  0
            #define /*byte MAX31856_NOISE_FILTER_60HZ;*/   B4R_MAX31856_NOISE_FILTER_60HZ  1
            //} max31856_noise_filter_t;

            #define /*byte MAX31856_TCTYPE_B;*/            B4R_MAX31856_TCTYPE_B    0b0000
            #define /*byte MAX31856_TCTYPE_E;*/            B4R_MAX31856_TCTYPE_E    0b0001
            #define /*byte MAX31856_TCTYPE_J;*/            B4R_MAX31856_TCTYPE_J    0b0010
            #define /*byte MAX31856_TCTYPE_K;*/            B4R_MAX31856_TCTYPE_K    0b0011
            #define /*byte MAX31856_TCTYPE_N;*/            B4R_MAX31856_TCTYPE_N    0b0100
            #define /*byte MAX31856_TCTYPE_R;*/            B4R_MAX31856_TCTYPE_R    0b0101
            #define /*byte MAX31856_TCTYPE_S;*/            B4R_MAX31856_TCTYPE_S    0b0110
            #define /*byte MAX31856_TCTYPE_T;*/            B4R_MAX31856_TCTYPE_T    0b0111
            #define /*byte MAX31856_TCTYPE_G8;*/           B4R_MAX31856_VMODE_G8    0b1000
            #define /*byte MAX31856_TCTYPE_G32;*/          B4R_MAX31856_VMODE_G32   0b1100
            //} max31856_thermocoupletype_t;

            #define /*byte MAX31856_CVMODE_ONESHOT;*/           B4R_MAX31856_ONESHOT        0    
            #define /*byte MAX31856_CVMODE_ONESHOT_NOWAIT;*/    B4R_MAX31856_ONESHOT_NOWAIT 1
            #define /*byte MAX31856_CVMODE_CONTINUOUS;*/        B4R_MAX31856_CONTINUOUS     2
            //} max31856_conversion_mode_t;*/  
            
            #define /*byte MAX31856_FAULT_CJRANGE;*/            B4R_MAX31856_FAULT_CJRANGE   0x80 ///< Fault status Cold Junction Out-of-Range flag
            #define /*byte MAX31856_FAULT_TCRANGE;*/            B4R_MAX31856_FAULT_TCRANGE   0x40 ///< Fault status Thermocouple Out-of-Range flag
            #define /*byte MAX31856_FAULT_CJHIGH;*/             B4R_MAX31856_FAULT_CJHIGH    0x20 ///< Fault status Cold-Junction High Fault flag
            #define /*byte MAX31856_FAULT_CJLOW;*/              B4R_MAX31856_FAULT_CJLOW     0x10 ///< Fault status Cold-Junction Low Fault flag
            #define /*byte MAX31856_FAULT_TCHIGH;*/             B4R_MAX31856_FAULT_TCHIGH    0x08 ///< Fault status Thermocouple Temperature High Fault flag
            #define /*byte MAX31856_FAULT_TCLOW;*/              B4R_MAX31856_FAULT_TCLOW     0x04 ///< Fault status Thermocouple Temperature Low Fault flag
            #define /*byte MAX31856_FAULT_OVUV;*/               B4R_MAX31856_FAULT_OVUV      0x02 ///< Fault status Overvoltage or Undervoltage Input Fault flag
            #define /*byte MAX31856_FAULT_OPEN;*/               B4R_MAX31856_FAULT_OPEN      0x01 ///< Fault status Thermocouple Open-Circuit Fault flag   
    };
}
