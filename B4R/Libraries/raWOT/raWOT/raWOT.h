#pragma once
#include "B4RDefines.h"
#include "aWOT.h"
#include "MimeTypes.h"

    //~Event: MiddlewareCBSub(Mindex as byte)
    //~Event: FinallyCBSub()
    //~Event: NotFoundCBSub()
    //~Version: 1.3
    //~Author - 
    //~Libray from https://github.com/lasselukkari/aWOT v3.5

namespace B4R {
    typedef void (*SubVoid_Void)(void);
    //~shortname:aWOT
    class B4RaWOT
    {
        private:
            static B4RaWOT* instance;
            static Response* resSV;
            static Request*  reqSV;    
            MimeTypes mime;       
            SubVoid_Void MiddlewareCBSub;
            SubVoid_Void FinallyCBSub;
            SubVoid_Void NotFoundCBSub;
            uint8_t backend[sizeof(awot::Application)];
            awot::Application* rcs;
            awot::Router m_router[64];
 //           WiFiClient client;
        public:  
            //~hide  
            static boolean ptrON; 
            //~hide     
            static IPAddress _IP; 
            //~hide              
            static void middlewareCB(Request* req, Response* res, SubVoid_Void middlewareSub); 
            
//************************************************            
//*****    awot::Appilcation application;    *****   
//************************************************ 
            void       initialize();                
            void       initialize1(SubVoid_Void FinallyCBSub, SubVoid_Void NotFoundCBSub);            
            void       process();             
            B4RString* getClientIP();
            ArrayByte* getClientIP1();
            //~hide
            void       error();
            
            void       app_del(B4RString* path, SubVoid_Void middlewareSub);
            void       app_del1(SubVoid_Void middlewareSub);         
            void       app_finally(SubVoid_Void middlewareSub);
            void       app_get(B4RString* path, SubVoid_Void middlewareSub);
            void       app_get1(SubVoid_Void middlewareSub);
            void       app_head(B4RString* path, SubVoid_Void middlewareSub);
            void       app_head1(SubVoid_Void middlewareSub);
            void       app_header(B4RString* name, ArrayByte* buffer);
            void       app_notFound(SubVoid_Void middlewareSub);
            void       app_options(B4RString* path, SubVoid_Void middlewareSub);
            void       app_options1(SubVoid_Void middlewareSub);
            void       app_patch(B4RString* path, SubVoid_Void middlewareSub);
            void       app_patch1(SubVoid_Void middlewareSub);
            void       app_post(B4RString* path, SubVoid_Void middlewareSub);
            void       app_post1(SubVoid_Void middlewareSub);
            void       app_put(B4RString* path, SubVoid_Void middlewareSub);
            void       app_put1(SubVoid_Void middlewareSub);
//            void       app_process(B4RStream * client);
            void       app_setTimeout(uint32_t timeoutMillis);
            void       app_useR(B4RString* path,uint8_t Rindex);
            void       app_useR1(uint8_t Rindex);
            void       app_use(B4RString* path, SubVoid_Void middlewareSub);
            void       app_use1(SubVoid_Void middlewareSub);
           
            B4RString* Mime_getType(B4RString* filename);            

//*****    awot::Response response;    *****    
            int32_t    res_availableForWrite();
            int32_t    res_bytesSent();
            void       res_beginHeaders();
            void       res_end();
            void       res_endHeaders();
            bool       res_ended();
            void       res_flush();
            B4RString* res_get(B4RString* name);
            bool       res_headersSent();  

            void       res_print(B4RString* string);
            void       res_println(B4RString* string);
            void       res_printCRLF();

            void       res_sendStatus(int16_t code);
            void       res_set(B4RString* name, B4RString* value);
            void       res_setDefaults();
            void       res_status(int16_t code);
            int16_t    res_statusSent();
            uint16_t   res_write(uint8_t data);
            uint16_t   res_write1(ArrayByte* buffer, uint16_t length);
//            void       res_writeP(ArrayByte* data);

//*****    awot::Request request;    *****
            int32_t    req_available();
            int32_t    req_availableForWrite();
            int32_t    req_bytesRead();
//            B4RStream* req_stream();                    
            void       req_flush();
            bool       req_form(ArrayByte* name, ArrayByte* value);
            B4RString* req_get(B4RString* name);
            int32_t    req_left();
            Byte       req_method();
            B4RString* req_path();
            int32_t    req_peek();
            void       req_push(uint8_t ch);
            B4RString* req_query();
            bool       req_query1(B4RString* name, ArrayByte* buffer);
            int32_t    req_read();
            int32_t    req_read1(ArrayByte* buf);
            bool       req_route(B4RString* name, ArrayByte* buffer);
            bool       req_route1(int16_t number, ArrayByte* buffer);
            int16_t    req_minorVersion();
            uint16_t   req_write(uint8_t data);
            uint16_t   req_write1(ArrayByte* buffer, uint16_t length);

//*****    awot::Router router;    *****    
            void       rout_del(uint8_t RindexO, B4RString* path, SubVoid_Void middlewareSub);
            void       rout_del1(uint8_t RindexO, SubVoid_Void middlewareSub);
            void       rout_get(uint8_t RindexO, B4RString* path, SubVoid_Void middlewareSub);
            void       rout_get1(uint8_t RindexO, SubVoid_Void middlewareSub);
            void       rout_head(uint8_t RindexO, B4RString* path, SubVoid_Void middlewareSub);
            void       rout_head1(uint8_t RindexO, SubVoid_Void middlewareSub);
            void       rout_options(uint8_t RindexO, B4RString* path, SubVoid_Void middlewareSub);
            void       rout_options1(uint8_t RindexO, SubVoid_Void middlewareSub);
            void       rout_patch(uint8_t RindexO, B4RString* path, SubVoid_Void middlewareSub);
            void       rout_patch1(uint8_t RindexO, SubVoid_Void middlewareSub);
            void       rout_post(uint8_t RindexO, B4RString* path, SubVoid_Void middlewareSub);
            void       rout_post1(uint8_t RindexO, SubVoid_Void middlewareSub);
            void       rout_put(uint8_t RindexO, B4RString* path, SubVoid_Void middlewareSub);
            void       rout_put1(uint8_t RindexO, SubVoid_Void middlewareSub);
            void       rout_useR(uint8_t RindexO, B4RString* path, uint8_t Rindex);
            void       rout_useR1(uint8_t RindexO, uint8_t Rindex);
            void       rout_use(uint8_t RindexO, B4RString* path, SubVoid_Void middlewareSub);
            void       rout_use1(uint8_t RindexO, SubVoid_Void middlewareSub);

     
//*****     enum MethodType {UNKNOWN, GET, HEAD, POST, PUT, DELETE, PATCH, OPTIONS, ALL};    *****
            #define /*byte MethodType::UNKNOWN;*/    B4R_MethodType_UNKNOWN     0
            #define /*byte MethodType::GET;*/        B4R_MethodType_GET         1            
            #define /*byte MethodType::HEAD;*/       B4R_MethodType_HEAD        2            
            #define /*byte MethodType::POST;*/       B4R_MethodType_POST        3
            #define /*byte MethodType::PUT;*/        B4R_MethodType_PUT         4
            #define /*byte MethodType::DELETE;*/     B4R_MethodType_DELETE      5            
            #define /*byte MethodType::PATCH;*/      B4R_MethodType_PATCH       6            
            #define /*byte MethodType::OPTIONS;*/    B4R_MethodType_OPTIONS     7
            #define /*byte MethodType::ALL;*/        B4R_MethodType_ALL         8            
    };        
}
