#include "B4RDefines.h"

namespace B4R
{

    bool B4RSPIClass::Initialize(byte sck, byte miso, byte mosi, byte ss)
    {
       rcs = new (backend) SPIClass();     
       return rcs->pins(sck, miso, mosi, ss);  
    };

    void B4RSPIClass::begin()
    {
       rcs->begin();
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

    void B4RSPIClass::beginTransaction(uint32_t clock,byte bitOrder,byte dataMode)
    { //SPISettings settings; settings._clock=clock; settings._bitOrder=bitOrder; settings._dataMode= dataMode;  
//       rcs->beginTransaction(settings);
       rcs->beginTransaction(SPISettings(clock, bitOrder, dataMode));
    };

    byte B4RSPIClass::transfer8(byte data)
    {
       return rcs->transfer(data);
    };

    uint16_t B4RSPIClass::transfer16(uint16_t data)
    {
       return rcs->transfer16(data);
    };

    void B4RSPIClass::transfer(ArrayByte* buf, uint16_t count)
    {
       rcs->transfer((byte*)buf->data, count);
    };

    void B4RSPIClass::write(byte data)
    {
       rcs->write(data);
    };

    void B4RSPIClass::write16(uint16_t data)
    {
       rcs->write16(data);
    };

    void B4RSPIClass::write161(uint16_t data, bool msb)
    {
       rcs->write16(data, msb);
    };

    void B4RSPIClass::write32(uint32_t data)
    {
       rcs->write32(data);
    };

    void B4RSPIClass::write321(uint32_t data, bool msb)
    {
       rcs->write32(data, msb);
    };

    void B4RSPIClass::writeBytes(ArrayByte* data, uint32_t size)
    {
       rcs->writeBytes((byte*)data->data, size);
    };

    void B4RSPIClass::writePattern(ArrayByte* data, byte size, uint32_t repeat)
    {
       rcs->writePattern((byte*)data->data, size, repeat);
    };

    void B4RSPIClass::transferBytes(ArrayByte* out, ArrayByte* in, uint32_t size)
    {
       rcs->transferBytes((byte*)out->data, (byte*)in->data, size);
    };

    void B4RSPIClass::endTransaction()
    {
       rcs->endTransaction();
    };


}
