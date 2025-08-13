
#include "B4RDefines.h"
#pragma once
#include "B4RDefines.h"
#include "fauxmoESP.h"

    //~Version: 1 
    //~Author - 
    //~Libray from Arduino https://github.com/vintlabs/fauxmoESP

namespace B4R {

//******************
//class fauxmoESP
//******************
    typedef void (*SubVoid_State1)(byte device_id, B4RString* name, bool state, byte value); 
    typedef void (*SubVoid_State2)(byte device_id, B4RString* name, bool state, byte value, Array* rgb); 
      
    //~Event: onSetState_Sub(device_id as Byte, name as String,  state as bool, value as Byte)
    //~Event: onSetStateColor_Sub(device_id as Byte, name as String,  state as bool, value as Byte, rgb() as Byte  
    //~shortname:fauxmoESP
    class B4RfauxmoESP
    {
        private:
            static B4RfauxmoESP* instance;
            uint8_t backend[sizeof(fauxmoESP)];
            fauxmoESP* fmo;
            SubVoid_State1 onSetState_Sub;
            SubVoid_State2 onSetStateColor_Sub;
        public: 
            void Initialize(SubVoid_State1 onSetStateSub, SubVoid_State2 onSetStateColorSub);
            //~hide
            static void onState(unsigned char device_id, const char * device_name, bool state, unsigned char value);
            //~hide
            static void onStateWithColor(unsigned char device_id, const char * device_name, bool state, unsigned char value, byte* rgb);
            
            byte addDevice(B4RString* device_name);
            bool renameDevice(byte id, B4RString* device_name);
            bool renameDevice1(B4RString* old_device_name, B4RString* new_device_name);
            bool removeDevice(byte id);
            bool removeDevice1(B4RString* device_name);
            B4RString* getDeviceName(byte id, ArrayByte* buffer);
            int16_t getDeviceId(B4RString* device_name);
            void setDeviceUniqueId(byte id, B4RString* uniqueid);
            bool setState(byte id, bool state, byte value);
            bool setState1(B4RString* device_name, bool state, byte value);
            bool setState2(byte id, bool state, byte value, ArrayByte* rgb);
            bool setState3(B4RString* device_name, bool state, byte value, ArrayByte* rgb);
            bool process(uint32_t asyncclient, bool isGet, B4RString* url, B4RString* body);
            void enable(bool enable);
            void createServer(bool internal);
            void setPort(uint32_t tcp_port);
            void handle();
    };
}
