#pragma once
#include "B4RDefines.h"
#include "ESPAsyncTCP.h" //https://github.com/me-no-dev/ESPAsyncTCP

    //~Event: OnConnectSub(argID as ulong, clientID as ulong)
    //~Event: OnDiscnnectSub(argID as ulong, clientID as ulong)
    //~Event: OnPollSub(argID as ulong, clientID as ulong)
    //~Event: OnAckSub(argID as ulong, clientID as ulong, length as uint, time as ulong)
    //~Event: OnErrorSub(argID as ulong, clientID as ulong, error as byte)
    //~Event: OnDataSub(argID as ulong, clientID as ulong, payload() as Byte)
    //~Event: OnTimeOutSub(argID as ulong, clientID as ulong, time as ulong)                        
    //~Version: 1.0 
    //~Author - 
    //~Libray from https://github.com/me-no-dev/ESPAsyncTCP
    //~Event: OnClientSub(clientID as ulong)  
namespace B4R {
    typedef void (*Subvoid_Ulong)(uint32_t clientID);
    typedef void (*Subvoid_UlongUlong)(uint32_t argID, uint32_t clientID);
    typedef void (*Subvoid_UlongUlongUintUlong)(uint32_t argID, uint32_t clientID, uint16_t tmp2, uint32_t time);
    typedef void (*Subvoid_UlongUlongByte)(uint32_t argID, uint32_t clientID, uint8_t error);
    typedef void (*Subvoid_UlongUlongBarray)(uint32_t argID, uint32_t clientID, Array* barray); 
    typedef void (*Subvoid_UlongUlongUlong)(uint32_t argID, uint32_t clientID, uint32_t time);   
    //~shortname:ESPAsyncClient    
    class B4RAsyncClient
    {
        private:
            AsyncClient rcc;
            static B4RAsyncClient* instance;
            Subvoid_UlongUlong OnConnectSub;
            Subvoid_UlongUlong OnDisconnectSub;
            Subvoid_UlongUlong OnPollSub;
            Subvoid_UlongUlongUintUlong  OnAckSub;
            Subvoid_UlongUlongByte OnErrorSub;
            Subvoid_UlongUlongBarray OnDataSub;
            Subvoid_UlongUlongUlong OnTimeOutSub;

        public:
            // client library initialisation
            void Initialize();
            //creation new client in case of AsyncSSL Client configuration
            uint32_t newClient();
            
            uint32_t getprev(uint32_t clientID);
   
            uint32_t getnext(uint32_t clientID);
            // initialisation of each CallBacks needed (7 CallBacks possible)
            // argID will store clientID in CallBack init to provide it in callback )
            void InitOnConnect(uint32_t argID, uint32_t clientID, Subvoid_UlongUlong OnConnectSub);
            void InitOnDisconnect(uint32_t argID, uint32_t clientID, Subvoid_UlongUlong OnDisconnectSub);
            void InitOnPoll(uint32_t argID, uint32_t clientID, Subvoid_UlongUlong OnllctSub);
            void InitOnAck(uint32_t argID, uint32_t clientID, Subvoid_UlongUlongUintUlong  OnAckSub);
            void InitOnError(uint32_t argID, uint32_t clientID, Subvoid_UlongUlongByte OnErrorSub);
            void InitOnData(uint32_t argID, uint32_t clientID, Subvoid_UlongUlongBarray OnDataSub);
            void InitOnTimeOut(uint32_t argID, uint32_t clientID, Subvoid_UlongUlongUlong OnTimeOutSub);
            // clientID will release pcb and take pcb of otherID
            uint32_t loadClient(uint32_t clientID, uint32_t otherID);
            // all clients can be linked by "prev" and "next". otherID is added at end of links, starting from clientID
            uint32_t linktoClient(uint32_t clientID, uint32_t otherID);
            // check if clientID and otherID are pointing to same pcb
            bool ClientEqual(uint32_t clientID, uint32_t otherID);
            // check if clientID and otherID are NOT pointing to same pcb
            bool ClientDiff(uint32_t clientID, uint32_t otherID);
            
            static void OnConnect(void* arg, AsyncClient* client);                         //on successful connect
            static void OnDisconnect(void* arg, AsyncClient* client);                      //disconnected
            static void OnAck(void* arg, AsyncClient* client, size_t len, uint32_t time);  //ack received
            static void OnError(void* arg, AsyncClient* client, int8_t error);             //unsuccessful connect or error
            static void OnData(void* arg, AsyncClient* client, uint8_t *data, size_t len); //data received (called if onPacket is not used)
            static void OnTimeOut(void* arg, AsyncClient* client, uint32_t time);          //ack timeout
            static void OnPoll(void* arg, AsyncClient* client);                            //every 125ms when connected
            //connect for client case
            bool connect(uint32_t clientID, ArrayByte* ip, uint16_t port);   
            bool connect1(uint32_t clientID, B4RString* host, uint16_t port);
            //close client and standard release ressources => pcb = NULL after
            void close(uint32_t clientID);
            // stop is same as close
            void stop(uint32_t clientID);
            //close client and "hard" release of ressources =>  pcb = NULL after
            void abort(uint32_t clientID);
            //check for client pointing to pcb = NULL 
            bool free(uint32_t clientID); 
                 
            bool canSend(uint32_t clientID);

            uint16_t space(uint32_t clientID);

            uint16_t add(uint32_t clientID, ArrayByte* datas, byte apiflags);

            bool send(uint32_t clientID);
            
            uint16_t ack(uint32_t clientID, uint16_t len);   //ack data that you have not acked using the method below

            void ackLater(uint32_t clientID);                //will not ack the current packet. Call from onData

            bool isRecvPush(uint32_t clientID);
            //     #if DEBUG_ESP_ASYNC_TCP             
            uint16_t getConnectionId(uint32_t clientID);            

            uint16_t write(uint32_t clientID, B4RString* datas);

            uint16_t write1(uint32_t clientID, ArrayByte* datas, byte apiflags);

            byte state(uint32_t clientID);

            bool connecting(uint32_t clientID);

            bool connected(uint32_t clientID);

            bool disconnecting(uint32_t clientID);

            bool disconnected(uint32_t clientID);

            bool freeable(uint32_t clientID);

            uint16_t getMss(uint32_t clientID);

            uint32_t getRxTimeout(uint32_t clientID);

            void setRxTimeout(uint32_t clientID, uint32_t timeout);

            uint32_t getAckTimeout(uint32_t clientID);

            void setAckTimeout(uint32_t clientID, uint32_t timeout);

            void setNoDelay(uint32_t clientID, bool nodelay);

            bool getNoDelay(uint32_t clientID);

            uint32_t getRemoteAddress(uint32_t clientID);

            uint16_t getRemotePort(uint32_t clientID);

            uint32_t getLocalAddress(uint32_t clientID);

            uint16_t getLocalPort(uint32_t clientID);

            B4RString* getremoteIP1(uint32_t clientID);

            uint16_t getremotePort1(uint32_t clientID);

            B4RString* getlocalIP1(uint32_t clientID);

            uint16_t getlocalPort1(uint32_t clientID);
    

            B4RString* errorToString(uint32_t clientID, byte error);

            B4RString* stateToString(uint32_t clientID);

            uint16_t getCloseError(uint32_t clientID);    
     };
    
    //~shortname:ESPAsyncServer    
    class B4RAsyncServer
    {
        private:
            uint8_t backend[sizeof(AsyncServer)];
            AsyncServer* rcs;
            static B4RAsyncServer* instance;
            Subvoid_Ulong OnClientSub;            
        public: 
            // case no SSL
            void Initialize(ArrayByte* IP, uint16_t port, Subvoid_Ulong OnClientSub);
            void Initialize1(uint16_t port, Subvoid_Ulong OnClientSub);
            // call back
            static void OnClient(void* arg, AsyncClient* client);

            void end();
            
            void setNoDelay(bool nodelay);
            
            bool getNoDelay();
            
            byte status();
            //  case DEBUG_MORE
            int16_t getEventCount(uint16_t ee);
            
    };
}
