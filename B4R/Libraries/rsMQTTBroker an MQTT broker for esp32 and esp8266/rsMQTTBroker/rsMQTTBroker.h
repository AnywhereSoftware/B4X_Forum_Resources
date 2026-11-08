
#pragma once
#include "B4RDefines.h"
#include "sMQTTBroker.h"

//~hide
class FullsMQTTBroker : public sMQTTBroker
{
   public:
      bool onEvent(sMQTTEvent *event) override;
};  

    //~Event:onNewClientEvent(ulong ClientID, B4RString* Login, B4RString* Password)
    //~Event: onRemoveClientEvent(ulong ClientID)
    //~Event: onPublishEvent(ulong ClientID, B4RString* Topic, B4RString* Payload)
    //~Event: onLostConnectEvent()
    //~Event: onSubscribeEvent(ulong ClientID, B4RString* Topic)
    //~Event: onUnSubscribeEvent(ulong ClientID, B4RString* Topic) 
    //~Version: 1.0 
    //~Author - 
    //~Libray from https://github.com/terrorsl/sMQTTBroker

namespace B4R {
    typedef void (*Subvoid_UlongStrStr)(uint32_t Client, B4RString* str1, B4RString* str2);
    typedef void (*Subvoid_UlongStr)(uint32_t Client, B4RString* str);
    typedef void (*Subvoid_Ulong)(uint32_t Client);  
    typedef void (*Subvoid_void)(void);
    //~shortname:sMQTTBroker
    class B4RsMQTTBroker
    {
        private:
            uint8_t backend[sizeof(FullsMQTTBroker)];
            FullsMQTTBroker* rcs;
            static B4RsMQTTBroker* instance;
            Subvoid_UlongStrStr OnNewClient_Sub;
            Subvoid_UlongStrStr OnPublish_Sub;
            Subvoid_UlongStr OnSuscribe_Sub;
            Subvoid_UlongStr OnUnSuscribe_Sub;
            Subvoid_Ulong  OnRemoveClient_Sub;
            Subvoid_void OnLostConnect_Sub;
        public: 
            //~hide
            static bool AllCBactive;
            void Initialize(uint16_t port, bool checkWifiConnection);
            void InitCB(Subvoid_UlongStrStr OnNewClienttSub,Subvoid_Ulong OnRemoveClienttSub, Subvoid_UlongStrStr OnPublishSub,Subvoid_void OnLostConnectSub, Subvoid_UlongStr OnSuscribeSub, Subvoid_UlongStr OnUnSuscribeSub);
            void update();
            void publish(B4RString* topic, B4RString* payload, byte qos, bool retain);
            void restart();
            uint32_t getRetainedTopicCount();
            B4RString* getRetaiedTopicName(uint32_t index);
            static void on_NewClientEvent(uint32_t Cli, char* Log, char* Pas);
            static void on_RemoveClientEvent(uint32_t Cli);
            static void on_PublishEvent(uint32_t Cli, char* Top, char* Pay);
            static void on_LostConnectEvent();
            static void on_SubscribeEvent(uint32_t Cli, char* Top);
            static void on_UnSubscribeEvent(uint32_t Cli, char* Top);
            
            #define /*byte Qos0;*/ B4RQoS0                                      0
            #define /*byte QoS1;*/ B4RQoS1                                      1
            #define /*byte QoS2;*/ B4RQoS2                                      2
            #define /*byte QoS3;*/ B4RQoS3                                      3
            
    };
}
