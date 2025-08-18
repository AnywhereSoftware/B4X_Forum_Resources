#include "B4RDefines.h"

/* event callbacks -case AsyncTCP Client */
static void On_Connect(void* arg, AsyncClient* client) {  
     B4R::B4RAsyncClient::OnConnect(arg, client);
      };
static void On_Disconnect(void* arg, AsyncClient* client) { 
     B4R::B4RAsyncClient::OnDisconnect(arg, client);
      }; 
static void On_Poll(void* arg, AsyncClient* client) { 
     B4R::B4RAsyncClient::OnPoll(arg, client);
     };      
static void On_Ack(void* arg, AsyncClient* client, size_t len, uint32_t time) {   
     B4R::B4RAsyncClient::OnAck( arg, client, len, time);
      };              
static void On_Error(void* arg, AsyncClient* client, int8_t error) {  
     B4R::B4RAsyncClient::OnError( arg, client, error); 
     };     
static void On_Data(void* arg, AsyncClient* client, void *data, size_t len) {
     B4R::B4RAsyncClient::OnData( arg, client, (uint8_t*)data, len);
      };          
static void On_TimeOut(void* arg, AsyncClient* client, uint32_t time) {  
     B4R::B4RAsyncClient::OnTimeOut( arg, client, time);
     };
  
/* event callbacks -case AsyncTCP Server  */    
static void On_Client(void* arg, AsyncClient* client) {
     B4R::B4RAsyncServer::OnClient( arg, client);
     };       
//static void On_SslFileRequest(void* arg, AsyncClient* client) {
//     B4R::B4RAsyncServer::OnSslFileRequest( arg, client);
//     };
namespace B4R
{
    B4RAsyncClient*  B4RAsyncClient::instance = NULL;
    B4RAsyncServer*  B4RAsyncServer::instance = NULL;

    void B4RAsyncClient::Initialize()
    {
       AsyncClient rcc;
       instance = this;
    };
    
    uint32_t B4RAsyncClient::newClient()
    {
       AsyncClient* newcli = new  AsyncClient;
       return reinterpret_cast<uint32_t>(newcli); 
    };  
    
    //??     AsyncClient * prev
    uint32_t B4RAsyncClient::getprev(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return reinterpret_cast<uint32_t>(tmp->prev);
    };
    //??     AsyncClient * next
    uint32_t B4RAsyncClient::getnext(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return reinterpret_cast<uint32_t>(tmp->next);
    };    

    void B4RAsyncClient::InitOnConnect(uint32_t argID, uint32_t clientID, Subvoid_UlongUlong OnConnectSub)
    {  
       AsyncClient* tmq = reinterpret_cast<AsyncClient*>(argID);   
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);     
	   tmp->onConnect(&On_Connect, tmq); this -> OnConnectSub = OnConnectSub;                
    };    
    void B4RAsyncClient::InitOnDisconnect(uint32_t argID, uint32_t clientID, Subvoid_UlongUlong OnDisconnectSub)
    {   
       AsyncClient* tmq = reinterpret_cast<AsyncClient*>(argID);  
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);     
	   tmp->onDisconnect(&On_Disconnect, tmq); this -> OnDisconnectSub = OnDisconnectSub;                
    };  
    void B4RAsyncClient::InitOnPoll(uint32_t argID, uint32_t clientID, Subvoid_UlongUlong OnPollSub)
    {   
       AsyncClient* tmq = reinterpret_cast<AsyncClient*>(argID);  
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);     
	   tmp->onPoll(&On_Poll,tmq); this -> OnPollSub = OnPollSub;               
    };  
    void B4RAsyncClient::InitOnAck(uint32_t argID, uint32_t clientID, Subvoid_UlongUlongUintUlong  OnAckSub)
    {   
       AsyncClient* tmq = reinterpret_cast<AsyncClient*>(argID);  
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);     
	   tmp->onAck(&On_Ack,tmq); this -> OnAckSub = OnAckSub;              
    };      
    void B4RAsyncClient::InitOnError(uint32_t argID, uint32_t clientID, Subvoid_UlongUlongByte OnErrorSub)
    {   
       AsyncClient* tmq = reinterpret_cast<AsyncClient*>(argID);  
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);     
	   tmp->onError(&On_Error,tmq); this -> OnErrorSub = OnErrorSub;                
    };    
    void B4RAsyncClient::InitOnData(uint32_t argID, uint32_t clientID, Subvoid_UlongUlongBarray OnDataSub)
    {   
       AsyncClient* tmq = reinterpret_cast<AsyncClient*>(argID);  
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);     
	   tmp->onData(&On_Data,tmq); this -> OnDataSub = OnDataSub;             
    };    
    void B4RAsyncClient::InitOnTimeOut(uint32_t argID, uint32_t clientID, Subvoid_UlongUlongUlong OnTimeOutSub)
    {   
       AsyncClient* tmq = reinterpret_cast<AsyncClient*>(argID);  
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);     
	   tmp->onTimeout(&On_TimeOut,tmq); this -> OnTimeOutSub = OnTimeOutSub;               
    }; 


         

    //  pcb of client closed and  client = other
    //??     AsyncClient & operator=(AsyncClient &other)
    uint32_t B4RAsyncClient::loadClient(uint32_t clientID, uint32_t otherID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);
       const AsyncClient* tmq = reinterpret_cast<AsyncClient*>(otherID);         
       AsyncClient& tmp2 = tmp->operator=(*tmq); 
       return reinterpret_cast<uint32_t>(&tmp2);
    };

    // "other" linked to client
    //??     AsyncClient & operator+=(AsyncClient &other)    
    uint32_t B4RAsyncClient::linktoClient(uint32_t clientID, uint32_t otherID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);
       const AsyncClient* tmq = reinterpret_cast<AsyncClient*>(otherID);           
       AsyncClient& tmp2 = tmp->operator+=(*tmq);
       return reinterpret_cast<uint32_t>(&tmp2);
    };

    // check if other  =  client
    //??    bool operator==(const AsyncClient &other);
    bool B4RAsyncClient::ClientEqual(uint32_t clientID, uint32_t otherID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);
       const AsyncClient* tmq = reinterpret_cast<AsyncClient*>(otherID);        
       return tmp->operator==(*tmq);
    };

    // check if client <> other
    //??    bool operator!=(const AsyncClient &other);
    bool B4RAsyncClient::ClientDiff(uint32_t clientID, uint32_t otherID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);
       const AsyncClient* tmq = reinterpret_cast<AsyncClient*>(otherID);        
       return tmp->operator!=(*tmq);
    };
    
    //****************************************************
    //callback *******************************************
    //****************************************************
    void B4RAsyncClient::OnConnect(void* arg, AsyncClient* client)
    {
       uint32_t clientID = reinterpret_cast<uint32_t>(client);
       uint32_t argID = reinterpret_cast<uint32_t>(arg);
       instance->OnConnectSub(argID, clientID);
    };

    void B4RAsyncClient::OnDisconnect(void* arg, AsyncClient* client)
    {
       uint32_t clientID = reinterpret_cast<uint32_t>(client);
       uint32_t argID = reinterpret_cast<uint32_t>(arg);
       instance->OnDisconnectSub(argID, clientID);
    };

    void B4RAsyncClient::OnAck(void* arg, AsyncClient* client, size_t len, uint32_t time) 
    {
       uint32_t clientID = reinterpret_cast<uint32_t>(client); uint16_t leng=len;
       uint32_t argID = reinterpret_cast<uint32_t>(arg);
       instance->OnAckSub(argID, clientID, leng, time);
    };

    void B4RAsyncClient::OnError(void* arg, AsyncClient* client, int8_t error)
    {
       uint32_t clientID = reinterpret_cast<uint32_t>(client);
       uint32_t argID = reinterpret_cast<uint32_t>(arg);
       instance->OnErrorSub(argID, clientID, error);
    };

    void B4RAsyncClient::OnData(void* arg, AsyncClient* client, uint8_t *data, size_t len)
    {
       uint32_t clientID = reinterpret_cast<uint32_t>(client);
       uint32_t argID = reinterpret_cast<uint32_t>(arg);
       const UInt cp = B4R::StackMemory::cp;
	   ArrayByte* Payload = CreateStackMemoryObject(ArrayByte);
	   Payload->data = data;
	   Payload->length = len;
	   instance->OnDataSub(argID, clientID, Payload);
	   B4R::StackMemory::cp = cp;
    };

//    void HandlePacket(void* arg, AsyncClient* client, struct pbuf *pb)

    void B4RAsyncClient::OnTimeOut(void* arg, AsyncClient* client, uint32_t time)
    {
       uint32_t clientID = reinterpret_cast<uint32_t>(client);
       uint32_t argID = reinterpret_cast<uint32_t>(arg);
       instance->OnTimeOutSub(argID, clientID, time);
    };

    void B4RAsyncClient::OnPoll(void* arg, AsyncClient* client)
    {
       uint32_t clientID = reinterpret_cast<uint32_t>(client);
       uint32_t argID = reinterpret_cast<uint32_t>(arg);       
       instance->OnPollSub(argID, clientID);
    };
    //end callback ***********************************************





    bool B4RAsyncClient::connect(uint32_t clientID, ArrayByte* ip, uint16_t port)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID); 
       return tmp->connect((Byte*)ip->data, port);
    };

    bool B4RAsyncClient::connect1(uint32_t clientID, B4RString* host, uint16_t port)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID); 
       return tmp->connect(host->data, port);
    };
             
    //close connexion
    void B4RAsyncClient::close(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       tmp->close();
    };
    // stop and release client => = NULL after
    void B4RAsyncClient::stop(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       tmp->stop();
    };
    // client closed and released =>  = NULL after
    void B4RAsyncClient::abort(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       tmp->abort();
    };
    //check if client is free (NULL)
    bool B4RAsyncClient::free(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->free();
    };

    bool B4RAsyncClient::canSend(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->canSend();
    };

    uint16_t B4RAsyncClient::space(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->space();
    };

    uint16_t B4RAsyncClient::add(uint32_t clientID, ArrayByte* datas, byte apiflags)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->add( (char*)datas->data, datas->length, apiflags);
    };

    bool B4RAsyncClient::send(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->send();
    };


    uint16_t B4RAsyncClient::ack(uint32_t clientID, uint16_t len)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->ack(len);
    };

    void B4RAsyncClient::ackLater(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       tmp->ackLater();
    };

    bool B4RAsyncClient::isRecvPush(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->isRecvPush();    
    };
    
    uint16_t B4RAsyncClient::getConnectionId(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID); 
     #if DEBUG_ESP_ASYNC_TCP 
       return tmp-> getConnectionId(void);
     #else
       return 0;  
     #endif  
    };    

    uint16_t B4RAsyncClient::write(uint32_t clientID, B4RString* datas)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->write(datas->data);
    };

    uint16_t B4RAsyncClient::write1(uint32_t clientID, ArrayByte* datas, byte apiflags)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->write( (char*)datas->data, datas->length, apiflags);
    };

    byte B4RAsyncClient::state(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->state();
    };

    bool B4RAsyncClient::connecting(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->connecting();
    };

    bool B4RAsyncClient::connected(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->connected();
    };

    bool B4RAsyncClient::disconnecting(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->disconnecting();
    };

    bool B4RAsyncClient::disconnected(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->disconnected();
    };

    bool B4RAsyncClient::freeable(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->freeable();
    };

    uint16_t B4RAsyncClient::getMss(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->getMss();
    };

    uint32_t B4RAsyncClient::getRxTimeout(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->getRxTimeout();
    };

    void B4RAsyncClient::setRxTimeout(uint32_t clientID, uint32_t timeout)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       tmp->setRxTimeout(timeout);
    };

    uint32_t B4RAsyncClient::getAckTimeout(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->getAckTimeout();
    };

    void B4RAsyncClient::setAckTimeout(uint32_t clientID, uint32_t timeout)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       tmp->setAckTimeout(timeout);
    };

    void B4RAsyncClient::setNoDelay(uint32_t clientID, bool nodelay)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       tmp->setNoDelay(nodelay);
    };

    bool B4RAsyncClient::getNoDelay(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->getNoDelay();
    };

    uint32_t B4RAsyncClient::getRemoteAddress(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->getRemoteAddress();
    };

    uint16_t B4RAsyncClient::getRemotePort(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->getRemotePort();
    };

    uint32_t B4RAsyncClient::getLocalAddress(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->getLocalAddress();
    };

    uint16_t B4RAsyncClient::getLocalPort(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->getLocalPort();
    };

    B4RString* B4RAsyncClient::getremoteIP1(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       IPAddress ip = tmp->remoteIP();
       return B4RString::PrintableToString(&ip);
    };

    uint16_t B4RAsyncClient::getremotePort1(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->remotePort();
    };

    B4RString* B4RAsyncClient::getlocalIP1(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       IPAddress ip = tmp->localIP();
       return B4RString::PrintableToString(&ip);
    };

    uint16_t B4RAsyncClient::getlocalPort1(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       return tmp->localPort();
    };

    B4RString* B4RAsyncClient::errorToString(uint32_t clientID, byte error)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       const char* raw = tmp->errorToString(error);
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw;
       return arr;
    };

    B4RString* B4RAsyncClient::stateToString(uint32_t clientID)
    {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);  
       const char* raw = tmp->stateToString();
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw;
       return arr;
    };
    
    uint16_t B4RAsyncClient::getCloseError(uint32_t clientID)
   {
       AsyncClient* tmp = reinterpret_cast<AsyncClient*>(clientID);          
       return tmp->getCloseError();
    };
            
    //************************************************
    //AsyncServer *************************************
    //************************************************  
    void B4RAsyncServer::Initialize(ArrayByte* IP, uint16_t port, Subvoid_Ulong OnClientSub)
    {
        rcs = new (backend) AsyncServer((Byte*)IP->data, port);
       rcs -> onClient(&On_Client, NULL); this -> OnClientSub = OnClientSub;
       B4RAsyncServer::instance = this; 
       rcs-> begin();   
    };

    void B4RAsyncServer::Initialize1(uint16_t port, Subvoid_Ulong OnClientSub)
    {
       rcs = new (backend) AsyncServer( port);
       rcs -> onClient(&On_Client, NULL); this -> OnClientSub = OnClientSub;
       B4RAsyncServer::instance = this;  
       rcs-> begin();   
    };
      
    //callback *******************************************
    void B4RAsyncServer::OnClient(void* arg, AsyncClient* client)
    {
       uint32_t clientID = reinterpret_cast<uint32_t>(client);
       B4RAsyncServer::instance->OnClientSub(clientID);
    };

    //end callback *************************************
    void B4RAsyncServer::end()
    {
       rcs->end();
    };

    void B4RAsyncServer::setNoDelay(bool nodelay)
    {
       rcs->setNoDelay(nodelay);
    };

    bool B4RAsyncServer::getNoDelay()
    {
       return rcs->getNoDelay();
    };

    byte B4RAsyncServer::status()
    {
       return rcs->status();
    };

    int16_t B4RAsyncServer::getEventCount(uint16_t ee)
    {
      #ifdef DEBUG_MORE
        return rcs->getEventCount(ee);
      #else 
        return 0; 
      #endif
    };
    
}                                         
