
#include "B4RDefines.h"


   B4R::B4RfauxmoESP* B4R::B4RfauxmoESP::instance = NULL;
//******************
//CallBack
//******************
   void onStateCb(unsigned char device_id, const char * device_name, bool state, unsigned char value)
   {
      B4R::B4RfauxmoESP::onState( device_id, device_name, state, value);
   };   
   
   void onStateWithColorCb(unsigned char device_id, const char * device_name, bool state, unsigned char value, byte* rgb)
   {
      B4R::B4RfauxmoESP::onStateWithColor( device_id, device_name, state, value, rgb);   
   };
   
namespace B4R
{
//******************
//class fauxmoESP
//******************
    void B4RfauxmoESP::Initialize(SubVoid_State1 onSetStateSub, SubVoid_State2 onSetStateColorSub)
    {
       fmo = new (backend) fauxmoESP;
       
       this->onSetState_Sub = onSetStateSub;
       instance = this;
       fmo->onSetState((TSetStateCallback) onStateCb);

       this->onSetStateColor_Sub = onSetStateColorSub;
       fmo->onSetState((TSetStateWithColorCallback) onStateWithColorCb);
    }; 
    
    void B4RfauxmoESP::onState(unsigned char device_id, const char * device_name, bool state, unsigned char value)
    {
       const uint16_t cp = B4R::StackMemory::cp;
       B4RString* strname = CreateStackMemoryObject(B4RString);
       strname->data = device_name;
       instance->onSetState_Sub(device_id, strname, state, value);
       B4R::StackMemory::cp = cp;
    };
       
    void B4RfauxmoESP::onStateWithColor(unsigned char device_id, const char * device_name, bool state, unsigned char value, byte* rgb)
    {
       const uint16_t cp = B4R::StackMemory::cp;
       B4RString* strname = CreateStackMemoryObject(B4RString);
       strname->data = device_name;
       ArrayByte* arrrgb = CreateStackMemoryObject(ArrayByte);
       arrrgb->data = rgb;
       arrrgb->length = 3;           
       instance->onSetStateColor_Sub(device_id, strname, state, value, arrrgb);
       B4R::StackMemory::cp = cp;
    };

    byte B4RfauxmoESP::addDevice(B4RString* device_name)
    {
       return fmo->addDevice(device_name->data);
    };

    bool B4RfauxmoESP::renameDevice(byte id, B4RString* device_name)
    {
       return fmo->renameDevice(id, device_name->data);
    };

    bool B4RfauxmoESP::renameDevice1(B4RString* old_device_name, B4RString* new_device_name)
    {
       return fmo->renameDevice(old_device_name->data, new_device_name->data);
    };

    bool B4RfauxmoESP::removeDevice(byte id)
    {
       return fmo->removeDevice(id);
    };

    bool B4RfauxmoESP::removeDevice1(B4RString* device_name)
    {
       return fmo->removeDevice(device_name->data);
    };

    B4RString* B4RfauxmoESP::getDeviceName(byte id, ArrayByte* buffer)
    {
       char* raw = fmo->getDeviceName((unsigned char)id, (char*)buffer->data, buffer->length);
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw;
       return arr;
    };

    int16_t B4RfauxmoESP::getDeviceId(B4RString* device_name)
    {
       return fmo->getDeviceId(device_name->data);
    };

    void B4RfauxmoESP::setDeviceUniqueId(byte id, B4RString* uniqueid)
    {
       fmo->setDeviceUniqueId(id, uniqueid->data);
    };

    bool B4RfauxmoESP::setState(byte id, bool state, byte value)
    {
       return fmo->setState(id, state, value);
    };

    bool B4RfauxmoESP::setState1(B4RString* device_name, bool state, byte value)
    {
       return fmo->setState(device_name->data, state, value);
    };

    bool B4RfauxmoESP::setState2(byte id, bool state, byte value, ArrayByte* rgb)
    {
       return fmo->setState(id, state, value, (byte*)rgb->data);
    };

    bool B4RfauxmoESP::setState3(B4RString* device_name, bool state, byte value, ArrayByte* rgb)
    {
       return fmo->setState(device_name->data, state, value, (byte*)rgb->data);
    };

    bool B4RfauxmoESP::process(uint32_t asyncclient, bool isGet, B4RString* url, B4RString* body)
    {
       return fmo->process((AsyncClient*) asyncclient, isGet, url->data, body->data);
    };

    void B4RfauxmoESP::enable(bool enable)
    {
       fmo->enable(enable);
    };

    void B4RfauxmoESP::createServer(bool internal)
    {
       fmo->createServer(internal);
    };

    void B4RfauxmoESP::setPort(uint32_t tcp_port)
    {
       fmo->setPort(tcp_port);
    };

    void B4RfauxmoESP::handle()
    {
       fmo->handle();
    };
}
