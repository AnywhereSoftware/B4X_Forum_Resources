#include "B4RDefines.h"

namespace B4R
{

    bool B4RAdafruit_MAX31856::Initialize(byte spi_cs)
    {
       rcs = new (backend) Adafruit_MAX31856(spi_cs);
       return rcs->begin();
    };
    
    bool B4RAdafruit_MAX31856::Initialize1(byte spi_cs,byte spi_mosi,byte spi_miso,byte spi_clk)
    {  
       rcs = new (backend) Adafruit_MAX31856(spi_cs, spi_mosi, spi_miso, spi_clk);
       return rcs->begin();
    };

    void B4RAdafruit_MAX31856::setConversionMode(byte cvmode)
    { Adafruit_MAX31856::max31856_conversion_mode_t mode;
      switch (cvmode) {
      case 2:   mode = (Adafruit_MAX31856::max31856_conversion_mode_t) (cvmode);break;  //::MAX31856_CONTINUOUS;break;
      case 1:   mode = (Adafruit_MAX31856::max31856_conversion_mode_t) (cvmode);break;  //::MAX31856_ONESHOT_NOWAIT;break;
      default:  mode = (Adafruit_MAX31856::max31856_conversion_mode_t) (0);break; }     //::MAX31856_ONESHOT;break; }            
      rcs->setConversionMode( mode);
    };

    byte B4RAdafruit_MAX31856::getConversionMode()
    {
       return rcs->getConversionMode();
    };
    
    void B4RAdafruit_MAX31856::setThermocoupleType(byte tctype)
    {  Adafruit_MAX31856::max31856_thermocoupletype_t type;
      switch (tctype) {
      case 0b1100: type = (Adafruit_MAX31856::max31856_thermocoupletype_t) (tctype);break;  //::MAX31856_TCTYPE_G32;break;
      case 0b1000: type = (Adafruit_MAX31856::max31856_thermocoupletype_t) (tctype);break;  //::MAX31856_TCTYPE_G8;break;
      case 0b0111: type = (Adafruit_MAX31856::max31856_thermocoupletype_t) (tctype);break;  //::MAX31856_TCTYPE_T;break;
      case 0b0110: type = (Adafruit_MAX31856::max31856_thermocoupletype_t) (tctype);break;  //::MAX31856_TCTYPE_S;break;
      case 0b0101: type = (Adafruit_MAX31856::max31856_thermocoupletype_t) (tctype);break;  //::MAX31856_TCTYPE_R;break;
      case 0b0100: type = (Adafruit_MAX31856::max31856_thermocoupletype_t) (tctype);break;  //::MAX31856_TCTYPE_N;break;
      case 0b0011: type = (Adafruit_MAX31856::max31856_thermocoupletype_t) (tctype);break;  //::MAX31856_TCTYPE_K;break;
      case 0b0010: type = (Adafruit_MAX31856::max31856_thermocoupletype_t) (tctype);break;  //::MAX31856_TCTYPE_J;break;
      case 0b0001: type = (Adafruit_MAX31856::max31856_thermocoupletype_t) (tctype);break;  //::MAX31856_TCTYPE_E;break;
      default:     type = (Adafruit_MAX31856::max31856_thermocoupletype_t) ( 0);break; }    //::MAX31856_TCTYPE_B;break; }           
      rcs->setThermocoupleType( type);
    };

    byte B4RAdafruit_MAX31856::getThermocoupleType()
    {
       return rcs->getThermocoupleType();                                          
    };
    
    byte B4RAdafruit_MAX31856::readFault()
    {
       return rcs->readFault();
    };

    void B4RAdafruit_MAX31856::triggerOneShot()
    {
       rcs->triggerOneShot();
    };

    bool B4RAdafruit_MAX31856::conversionComplete()
    {
       return rcs->conversionComplete();
    };

    float B4RAdafruit_MAX31856::readCJTemperature()
    {
       return rcs->readCJTemperature();
    };

    float B4RAdafruit_MAX31856::readThermocoupleTemperature()
    {
       return rcs->readThermocoupleTemperature();
    };

    void B4RAdafruit_MAX31856::setTempFaultThreshholds(float flow, float fhigh)
    {
       rcs->setTempFaultThreshholds(flow, fhigh);
    };

    void B4RAdafruit_MAX31856::setColdJunctionFaultThreshholds(byte low, byte high)
    {
       rcs->setColdJunctionFaultThreshholds(low, high);
    };

    void B4RAdafruit_MAX31856::setNoiseFilter(byte nFilter)
    { Adafruit_MAX31856::max31856_noise_filter_t noiseFilter;
      switch (nFilter) {
      case 1:   noiseFilter = (Adafruit_MAX31856::max31856_noise_filter_t) (nFilter);break;   //::MAX31856_NOISE_FILTER_60HZ;break;
      default:  noiseFilter = (Adafruit_MAX31856::max31856_noise_filter_t) (0);break; } //::MAX31856_NOISE_FILTER_50HZ;break; }  
      rcs->setNoiseFilter( noiseFilter);
    };


}
