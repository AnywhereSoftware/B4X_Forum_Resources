#include "B4RDefines.h"

namespace B4R
{
//class SPISettings

    void B4RSPIClass::Initialize(byte SPIbus)
    {
       rcs = new (backend) SPIClass(SPIbus & 0x03);
    };
    
    void B4RSPIClass::begin()
    {
       rcs->begin();
    };

    void B4RSPIClass::begin1(byte sck, byte miso, byte mosi, byte ss)
    {
       rcs->begin(sck, miso, mosi, ss);
    };

    void B4RSPIClass::end()
    {
       rcs->end();
    };

    void B4RSPIClass::setHwCs(bool use)
    {
       rcs->setHwCs(use);
    };

    void B4RSPIClass::setBitOrder(byte bitOrder)
    {
       rcs->setBitOrder(bitOrder);
    };

    void B4RSPIClass::setDataMode(byte dataMode)
    {
       rcs->setDataMode(dataMode);
    };

    void B4RSPIClass::setFrequency(uint32_t freq)
    {
       rcs->setFrequency(freq);
    };

    void B4RSPIClass::setClockDivider(uint32_t clockDiv)
    {
       rcs->setClockDivider(clockDiv);
    };

    uint32_t B4RSPIClass::getClockDivider()
    {
       return rcs->getClockDivider();
    };

    void B4RSPIClass::beginTransaction(uint32_t clock,byte bitOrder,byte dataMode)
    {
       rcs->beginTransaction(SPISettings(clock, bitOrder, dataMode));
    };

    void B4RSPIClass::endTransaction()
    {
       rcs->endTransaction();
    };

    void B4RSPIClass::transfer(ArrayByte* data, uint32_t size)
    {
       rcs->transfer((byte*)data->data, size);
    };

    byte B4RSPIClass::transfer1(byte data)
    {
       return rcs->transfer(data);
    };

    uint16_t B4RSPIClass::transfer16(uint16_t data)
    {
       return rcs->transfer16(data);
    };

    uint32_t B4RSPIClass::transfer32(uint32_t data)
    {
       return rcs->transfer32(data);
    };

    void B4RSPIClass::transferBytes(ArrayByte* data, ArrayByte* out, uint32_t size)
    {
       rcs->transferBytes((byte*)data->data, (byte*)out->data, size);
    };
    
    void B4RSPIClass::transferBytesR(ArrayByte* out, uint32_t size)
    {  
       rcs->transferBytes(NULL, (byte*)out->data, size);
    };
    
    void B4RSPIClass::transferBytesW(ArrayByte* data, uint32_t size)
    {  
       rcs->transferBytes((byte*)data->data, NULL, size);
    };

    void B4RSPIClass::transferBits(uint32_t data, ArrayULong* out, byte bits)
    {
       rcs->transferBits(data, (uint32_t*)out->data, bits);
    };

    void B4RSPIClass::write(byte data)
    {
       rcs->write(data);
    };

    void B4RSPIClass::write16(uint16_t data)
    {
       rcs->write16(data);
    };

    void B4RSPIClass::write32(uint32_t data)
    {
       rcs->write32(data);
    };

    void B4RSPIClass::writeBytes(ArrayByte* data, uint32_t size)
    {
       rcs->writeBytes((byte*)data->data, size);
    };

//   void B4RSPIClass::writePixels( * data, uint32_t size)
//    {
//       rcs->writePixels(* data, size);
//    };

    void B4RSPIClass::writePattern(ArrayByte* data, byte size, uint32_t repeat)
    {
       rcs->writePattern((byte*)data->data, size, repeat);
    };
    
    boolean B4RSPIClass::busStatus()
    {
       spi_t * _spi = rcs->bus();
       if (_spi = NULL) {return false;} else {return true;}
    };
    
    byte B4RSPIClass::pinSS()
    {
       return rcs->pinSS();
    };
}
