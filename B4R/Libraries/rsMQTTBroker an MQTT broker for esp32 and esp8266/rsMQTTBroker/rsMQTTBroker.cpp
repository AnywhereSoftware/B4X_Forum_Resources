#include "B4RDefines.h"
#include "rsMQTTBroker.h"
   
    bool FullsMQTTBroker::onEvent(sMQTTEvent *event)
    { if (B4R::B4RsMQTTBroker::AllCBactive) {
        switch(event->Type())
        {
        case NewClient_sMQTTEventType:
            {
                sMQTTNewClientEvent *e=(sMQTTNewClientEvent*)event;
                std::string Log1= e->Login();    char * Log = (char*) Log1.c_str();
                std::string Pas1= e->Password(); char * Pas = (char*) Pas1.c_str();
                uint32_t Cli = reinterpret_cast<uint32_t>(e->Client());
  //              Serial.print("Event_New Client : ");Serial.print(Cli); Serial.print(" User : "); Serial.print(Log); Serial.print(" Password : "); Serial.println(Pas);  
                B4R::B4RsMQTTBroker::on_NewClientEvent(Cli, Log, Pas);
            }
            break;
        case RemoveClient_sMQTTEventType:
            {
                sMQTTRemoveClientEvent *e=(sMQTTRemoveClientEvent*)event;
                uint32_t Cli = reinterpret_cast<uint32_t>(e->Client());
 //               Serial.print("Event_Client Removed : ");Serial.println(Cli);                
                B4R::B4RsMQTTBroker::on_RemoveClientEvent(Cli);        
            }
            break;   
        case LostConnect_sMQTTEventType:
            {
               B4R::B4RsMQTTBroker::on_LostConnectEvent();
            }  
            break;              
        case Public_sMQTTEventType:
            {
                sMQTTPublicClientEvent *e=(sMQTTPublicClientEvent*)event;
                std::string Top1 = e->Topic(); char * Top = (char*) Top1.c_str();
                std::string Pay1 = e->Payload(); char * Pay = (char*) Pay1.c_str();
                uint32_t Cli = reinterpret_cast<uint32_t>(e->Client());
 //               Serial.print("Event_Publish : ");Serial.print(Cli);Serial.print(" Topic : "); Serial.print(Top);Serial.print(" Payload : "); Serial.println(Pay);              
                B4R::B4RsMQTTBroker::on_PublishEvent(Cli, Top, Pay);        
            }
            break;               
        case UnSubscribe_sMQTTEventType:
            {
                sMQTTSubUnSubClientEvent *e=(sMQTTSubUnSubClientEvent*)event;
                std::string Top1 = e->Topic(); char * Top = (char*) Top1.c_str();
                uint32_t Cli = reinterpret_cast<uint32_t>(e->Client()); 
//                Serial.print("Event_UnSubscribe : ");Serial.print(Cli);Serial.print(" Topic : "); Serial.println(Top);              
                B4R::B4RsMQTTBroker::on_UnSubscribeEvent( Cli, Top);              
            }
            break;      
        case Subscribe_sMQTTEventType:
            {
                sMQTTSubUnSubClientEvent *e=(sMQTTSubUnSubClientEvent*)event;
                std::string Top1 = e->Topic(); char * Top = (char*) Top1.c_str();
                uint32_t Cli = reinterpret_cast<uint32_t>(e->Client());
//                Serial.print("Event_Subscribe : ");Serial.print(Cli);Serial.print(" Topic : "); Serial.println(Top);                               
                B4R::B4RsMQTTBroker::on_SubscribeEvent(Cli, Top);              
            }
            break;
        }
       
    }  return true;
    }

namespace B4R
{
    B4RsMQTTBroker*  B4RsMQTTBroker::instance = NULL;
    bool B4RsMQTTBroker::AllCBactive = false;
    
    void B4RsMQTTBroker::Initialize(uint16_t port, bool checkWifiConnection)
    { 
       rcs = new (backend) FullsMQTTBroker();
       rcs->init(port, checkWifiConnection);
    };
    
    void B4RsMQTTBroker::InitCB(Subvoid_UlongStrStr OnNewClientSub, Subvoid_Ulong OnRemoveClientSub, Subvoid_UlongStrStr OnPublishSub, Subvoid_void OnLostConnectSub, Subvoid_UlongStr OnSuscribeSub, Subvoid_UlongStr OnUnSuscribeSub)
    {
       this->OnNewClient_Sub = OnNewClientSub;
       this->OnRemoveClient_Sub = OnRemoveClientSub;
       this->OnPublish_Sub = OnPublishSub;
       this->OnLostConnect_Sub = OnLostConnectSub;
       this->OnSuscribe_Sub = OnSuscribeSub;
       this->OnUnSuscribe_Sub = OnUnSuscribeSub;
       AllCBactive = true;
       instance = this;
    };          

    void B4RsMQTTBroker::update()
    {
       rcs->update();
    };

    void B4RsMQTTBroker::publish(B4RString* topic, B4RString* payload, byte qos, bool retain)
    {              
       rcs->publish(topic->data, payload->data, qos, retain);      
    };

    void B4RsMQTTBroker::restart()
    {
       rcs->restart();
    };

    uint32_t B4RsMQTTBroker::getRetainedTopicCount()
    {
       return rcs->getRetainedTopicCount();
    };
    
    B4RString* B4RsMQTTBroker::getRetaiedTopicName(uint32_t index)
    {
       char* raw = (char*) (rcs->getRetaiedTopicName(index)).c_str();
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw;
       return arr;       
    };
       
    void B4RsMQTTBroker::on_NewClientEvent(uint32_t Cli, char* Log, char* Pas)
    {
       const UInt cp = B4R::StackMemory::cp;
	   B4RString* Login = CreateStackMemoryObject(B4RString);
	   Login->data = Log;
	   B4RString* Password = CreateStackMemoryObject(B4RString);
	   Password->data = Pas;      
	   instance->OnNewClient_Sub(Cli, Login, Password);
	   B4R::StackMemory::cp = cp;
    };
    void B4RsMQTTBroker::on_RemoveClientEvent(uint32_t Cli)
    {
	   instance->OnRemoveClient_Sub(Cli); 
    };
    void B4RsMQTTBroker::on_PublishEvent(uint32_t Cli, char* Top, char* Pay)
    { 
       const UInt cp = B4R::StackMemory::cp;
	   B4RString* Topic = CreateStackMemoryObject(B4RString);
	   Topic->data = Top;
	   B4RString* Payload = CreateStackMemoryObject(B4RString);
	   Payload->data = Pay;      
	   instance->OnPublish_Sub(Cli, Topic, Payload);
	   B4R::StackMemory::cp = cp;
    };
    void B4RsMQTTBroker::on_LostConnectEvent()
    {
       instance->OnLostConnect_Sub();
    };
    void B4RsMQTTBroker::on_SubscribeEvent(uint32_t Cli, char* Top)
    {
       const UInt cp = B4R::StackMemory::cp;
	   B4RString* Topic = CreateStackMemoryObject(B4RString);
	   Topic->data = Top; 
	   instance->OnSuscribe_Sub(Cli, Topic);
	   B4R::StackMemory::cp = cp;
    };
    void B4RsMQTTBroker::on_UnSubscribeEvent(uint32_t Cli, char* Top)
    {
       const UInt cp = B4R::StackMemory::cp;
	   B4RString* Topic = CreateStackMemoryObject(B4RString);
	   Topic->data = Top;  
	   instance->OnUnSuscribe_Sub(Cli, Topic);
	   B4R::StackMemory::cp = cp;
    };
      
}
