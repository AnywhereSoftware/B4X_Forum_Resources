#include "B4RDefines.h"

/* event callbacks  */
  static void On_Receive(int packetSize) { 
     B4R::B4RLoRa::OnReceive((uint16_t) packetSize);
  };
  void On_TxDone() { 
       B4R::B4RLoRa::OnTxDone();
  }; 
//end callbacks   

   
namespace B4R
{
    B4RLoRa*  B4RLoRa::instance = NULL;
    boolean  B4RLoRa::LoopOn = NULL; 
    
    void B4RLoRa::Initialize()
    {
       rcs = new (backend) LoRaClass();
    }; 
    
    void B4RLoRa::looper(void* b) 
    {
       B4RLoRa* me = (B4RLoRa*)b;
       me->rcs->processing();
    };

/* event callbacks  */    
    void B4RLoRa::OnReceive(int16_t packetSize)
    {
       instance->OnReceiveSub(packetSize);
    };
    
    void B4RLoRa::OnTxDone()
    {
       instance->OnTxDoneSub();
    };
 //end callbacks    
    void B4RLoRa::LoopStart()
    { if (LoopOn == false) {
       instance = this;
       FunctionUnion fu; 
       fu.PollerFunction = looper;
       pnode.functionUnion = fu;
       pnode.tag = this;  
       if (pnode.next == NULL) {pollers.add(&pnode);}  
       LoopOn = true;}    
    };
    
    
    int16_t B4RLoRa::begin(long frequency)
    {
       return rcs->begin(frequency);
    };    

    void B4RLoRa::setOnReceive( Subvoid_int OnReceiveSub)
    {
       rcs->onReceive(On_Receive);
       this -> OnReceiveSub = OnReceiveSub;  
       LoopStart();
    };  
    void B4RLoRa::setOnTxDone( Subvoid_void OnTxDoneSub)
    {
       rcs->onTxDone(On_TxDone);
       this -> OnTxDoneSub = OnTxDoneSub;  
       LoopStart();
    };   
    
    void B4RLoRa::end()
    {
       rcs->end();
    };

    int16_t B4RLoRa::beginPacket(int16_t implicitHeader)
    {
       return rcs->beginPacket(implicitHeader);
    };

    int16_t B4RLoRa::endPacket(bool async)
    {
       return rcs->endPacket(async);
    };

    int16_t B4RLoRa::parsePacket(int16_t size)
    {
       return rcs->parsePacket(size);
    };

    int16_t B4RLoRa::packetRssi()
    {
       return rcs->packetRssi();
    };

    float B4RLoRa::packetSnr()
    {
       return rcs->packetSnr();
    };

    int32_t B4RLoRa::packetFrequencyError()
    {
       return rcs->packetFrequencyError();
    };

    int16_t B4RLoRa::rssi()
    {
       return rcs->rssi();
    };

    uint16_t B4RLoRa::write(byte byte)
    {
       return rcs->write(byte);
    };

    uint16_t B4RLoRa::write1(ArrayByte* buffer)
    {
       return rcs->write((byte*)buffer->data, buffer->length);
    };
    
    void B4RLoRa::print(B4RString* txt)
    {
       rcs->print(txt->data);
    };
        
    void B4RLoRa::println(B4RString* txt)
    {
       rcs->println(txt->data);
    };
    
    int16_t B4RLoRa::available()
    {
       return rcs->available();
    };

    int16_t B4RLoRa::read()
    {
       return rcs->read();
    };

    int16_t B4RLoRa::peek()
    {
       return rcs->peek();
    };

    void B4RLoRa::flush()
    {
       rcs->flush();
    };

    void B4RLoRa::receive(int16_t size)
    {
       rcs->receive(size);
    };

    void B4RLoRa::idle()
    {
       rcs->idle();
    };

    void B4RLoRa::sleep()
    {
       rcs->sleep();
    };

    void B4RLoRa::setTxPower(int16_t level, int16_t outputPin)
    {
       rcs->setTxPower(level, outputPin);
    };

    void B4RLoRa::setFrequency(int32_t frequency)
    {
       rcs->setFrequency(frequency);
    };

    void B4RLoRa::setSpreadingFactor(int16_t sf)
    {
       rcs->setSpreadingFactor(sf);
    };

    void B4RLoRa::setSignalBandwidth(int32_t sbw)
    {
       rcs->setSignalBandwidth(sbw);
    };

    void B4RLoRa::setCodingRate4(int16_t denominator)
    {
       rcs->setCodingRate4(denominator);
    };

    void B4RLoRa::setPreambleLength(int32_t length)
    {
       rcs->setPreambleLength(length);
    };

    void B4RLoRa::setSyncWord(int16_t sw)
    {
       rcs->setSyncWord(sw);
    };

    void B4RLoRa::enableCrc()
    {
       rcs->enableCrc();
    };

    void B4RLoRa::disableCrc()
    {
       rcs->disableCrc();
    };

    void B4RLoRa::enableInvertIQ()
    {
       rcs->enableInvertIQ();
    };

    void B4RLoRa::disableInvertIQ()
    {
       rcs->disableInvertIQ();
    };

    void B4RLoRa::setOCP(byte mA)
    {
       rcs->setOCP(mA);
    };

    void B4RLoRa::setGain(byte gain)
    {
       rcs->setGain(gain);
    };

    byte B4RLoRa::random()
    {
       return rcs->random();
    };

    void B4RLoRa::setPins(int16_t ss, int16_t reset, int16_t dio0)
    {
       rcs->setPins(ss, reset, dio0);
    };
// case multi SPI hard on esp32
    void B4RLoRa::setSPI(byte SPIbus)
    {
    #if ( defined(ESP32) )  
       SPIClass spiLoRa = SPIClass(SPIbus & 0x03);
       spiLoRa.begin();
       rcs->setSPI(spiLoRa);
     #endif  
    };
    void B4RLoRa::setSPI1(byte SPIbus,byte sck, byte miso, byte mosi, byte ss)
    {
    #if ( defined(ESP32) )  
       SPIClass spiLoRa = SPIClass(SPIbus & 0x03);
       spiLoRa.begin(sck, miso, mosi, ss);
       rcs->setSPI(spiLoRa);
     #endif  
    };

//*******************************************
    void B4RLoRa::setSPIFrequency(uint32_t frequency)
    {
       rcs->setSPIFrequency(frequency);
    };

    void B4RLoRa::dumpRegisters(ArrayByte* DumpOut)
    {
       rcs->dumpRegisters((byte*)DumpOut->data);
    };
}
