
#include "B4RDefines.h"

namespace B4R
{

    void B4RMCP23017::InitializeI2C(byte addr,byte rp)
    {
       rcs = new (backend) MCP23017(addr, rp);
    };
    
    void B4RMCP23017::BeginI2C()
    {
       Wire.begin();
    };
    
    void B4RMCP23017::InitializeI2C_Esp(byte wire, byte addr, byte rp) 
    {
    #if defined (ESP32)                                                                              //case esp32
       if (wire==1) { rcs = new (backend) MCP23017(&Wire1, addr, rp);}
       else  {rcs = new (backend) MCP23017(&Wire, addr, rp);};
    #else 
       {rcs = new (backend) MCP23017( &Wire, addr, rp);};    //case esp8266
    #endif    
    };
    
    void B4RMCP23017::BeginI2C_Esp(byte wire, int16_t sda, int16_t scl)
    {
    #if defined (ESP32)                                                                              //case esp32
       if (wire==1) {Wire1.begin( sda, scl);}
       else  {Wire.begin( sda, scl);};
    #else
       Wire.begin( sda, scl);
    #endif   
    };    
    
    void B4RMCP23017::InitializeSPI(byte cs, byte rp, byte addr)
    {
       rcs = new (backend) MCP23017( cs, rp, addr); 
    };
    
    void B4RMCP23017::BeginSPI()
    {
       SPI.begin();
    };    
    
    void B4RMCP23017::InitializeSPI_ESP32(Byte SPIbus, byte cs, byte rp, byte addr)
    {
    #if ( defined(ESP32) )       
       if (SPIbus==2) { SPIClass SPI2 = SPIClass(HSPI); rcs = new (backend) MCP23017(&SPI2, cs, rp, addr);}
       else { SPIClass SPI1 = SPIClass(VSPI); rcs = new (backend) MCP23017(&SPI1, cs, rp, addr);};
    #else
      {rcs = new (backend) MCP23017( &SPI, cs, rp, addr);}
    #endif
    };
    
    void B4RMCP23017::BeginSPI_ESP32(Byte SPIbus, int16_t SCK, int16_t MISO, int16_t MOSI, int16_t SS)
    {
    #if ( defined(ESP32) )       
       if (SPIbus==2) {SPI2.begin(SCK, MISO, MOSI, SS);}
       else {SPI1.begin(SCK, MISO, MOSI, SS);};};
    #else
      {SPI.begin();};
    #endif
    };    

    bool B4RMCP23017::Init()
    {
       return rcs->Init();
    };

    void B4RMCP23017::reset()
    {
       rcs->reset();
    };

    void B4RMCP23017::setPinMode( uint8_t pin, byte port, uint8_t pinState)
    {
       rcs->setPinMode(pin, (mcp_port) (port & 0x1) , pinState);
    };

    void B4RMCP23017::setPortMode(uint8_t portState, byte port)
    {
       rcs->setPortMode( portState, (mcp_port) (port & 0x1));
    };

    void B4RMCP23017::setPortMode1(uint8_t val, byte port, uint8_t pu)
    {
       rcs->setPortMode(val, (mcp_port)(port & 0x1), pu);
    };

    void B4RMCP23017::setPin(uint8_t pin, byte port, uint8_t pinLevel)
    {
       rcs->setPin( pin, (mcp_port)(port & 0x1), pinLevel);
    };

    void B4RMCP23017::togglePin(uint8_t pin, byte port)
    {
       rcs->togglePin( pin, (mcp_port)(port & 0x1));
    };

    void B4RMCP23017::setPinX(uint8_t pin, byte port, uint8_t pinState, uint8_t pinLevel)
    {
       rcs->setPinX( pin, (mcp_port)(port & 0x1), pinState, pinLevel);
    };

    void B4RMCP23017::setAllPins(byte port, uint8_t pinLevel)
    {
       rcs->setAllPins((mcp_port)(port & 0x1), pinLevel);
    };

    void B4RMCP23017::setPort(uint8_t portLevel, byte port)
    {
       rcs->setPort( portLevel, (mcp_port)(port & 0x1));
    };

    void B4RMCP23017::setPortAll(uint8_t portLevelA, uint8_t portLevelB)
    {
       rcs->setPort( portLevelA, portLevelB);
    };

    void B4RMCP23017::setPortX(uint8_t portState, uint8_t portLevel, byte port)
    {
       rcs->setPortX( portState, portLevel, (mcp_port)(port & 0x1));
    };

    void B4RMCP23017::setInterruptPinPol(uint8_t level)
    {
       rcs->setInterruptPinPol( level);
    };

    void B4RMCP23017::setIntOdr(uint8_t openDrain)
    {
       rcs->setIntOdr( openDrain);
    };

    void B4RMCP23017::setInterruptOnChangePin(uint8_t pin, mcp_port port)
    {
       rcs->setInterruptOnChangePin( pin, (mcp_port) (port&01));
    };

    void B4RMCP23017::setInterruptOnDefValDevPin(uint8_t pin, byte port, uint8_t pinIntLevel)
    {
       rcs->setInterruptOnDefValDevPin( pin, (mcp_port)(port & 0x1), pinIntLevel);
    };

    void B4RMCP23017::setInterruptOnChangePort(uint8_t intOnChangePins, byte port)
    {
       rcs->setInterruptOnChangePort( intOnChangePins, (mcp_port)(port & 0x1));
    };

    void B4RMCP23017::setInterruptOnDefValDevPort(uint8_t intPins, byte port, uint8_t defVal)
    {
       rcs->setInterruptOnDefValDevPort( intPins, (mcp_port)(port & 0x1), defVal);
    };

    void B4RMCP23017::deleteAllInterruptsOnPort(byte port)
    {
       rcs->deleteAllInterruptsOnPort((mcp_port)(port & 0x1));
    };

    void B4RMCP23017::setPinPullUp(uint8_t pin, byte port, uint8_t pinLevel)
    {
       rcs->setPinPullUp( pin, (mcp_port)(port & 0x1), pinLevel);
    };

    void B4RMCP23017::setPortPullUp(uint8_t pulledUpPins, byte port)
    {
       rcs->setPortPullUp( pulledUpPins, (mcp_port)(port & 0x1));
    };

    byte B4RMCP23017::getPortPullUp(byte port)
    {
       return rcs->getPortPullUp((mcp_port)(port & 0x1));
    };

    void B4RMCP23017::setIntMirror(uint8_t mirrored)
    {
       rcs->setIntMirror( mirrored);
    };

    byte B4RMCP23017::getIntFlag(byte port)
    {
       return rcs->getIntFlag((mcp_port)(port & 0x1));
    };

    bool B4RMCP23017::getPin(uint8_t pin, byte port)
    {
       return rcs->getPin( pin, (mcp_port)(port & 0x1));
    };

    byte B4RMCP23017::getPort(byte port)
    {
       return rcs->getPort((mcp_port)(port & 0x1));
    };

    byte B4RMCP23017::getIntCap(byte port)
    {
       return rcs->getIntCap((mcp_port)(port & 0x1));
    };

    void B4RMCP23017::setSPIClockSpeed(uint32_t clock)
    {
       rcs->setSPIClockSpeed(clock);
    };

    void B4RMCP23017::softReset()
    {
       rcs->softReset();
    };
    
}
