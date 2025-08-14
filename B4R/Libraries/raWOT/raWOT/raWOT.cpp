#include "B4RDefines.h"
#if defined(ESP8266)
#include <ESP8266WiFi.h>
#else
#include <WiFi.h>
#endif
#include "raWOT.h"
//#include "MimeTypes.h"

 WiFiServer server(80); 
 
  // middleware, finally, notFound calls back
  void awot::middlewareCB(Request* req, Response* res, Router::MIDDLEWARE_PARAM Mindex) 
  {
     B4R::B4RaWOT::middlewareCB(req, res, (B4R::SubVoid_Void) Mindex);
 //    B4R::Common::LogHelper(4,102,F("***middlewareCB_1 *** Resp_statusSent: "),6,((uint32_t)res->statusSent()),102,("  Resp_ended: "),6,((uint32_t)res->ended())); 
  };

namespace B4R
{
    B4RaWOT*  B4RaWOT::instance = NULL;
    Response* B4RaWOT::resSV ;
    Request*  B4RaWOT::reqSV  ;   
    boolean   B4RaWOT::ptrON = false ; 
    IPAddress B4RaWOT::_IP; 
        
//******************************************************
//*****    awot::Application awot::Application;    *****
//******************************************************    
     void B4RaWOT::initialize()
    { 
       server.begin();
//       MimeTypes mime; 
       rcs = new (backend) awot::Application; 
       instance = this;
    };     
    void B4RaWOT::initialize1( SubVoid_Void FinallyCBSub, SubVoid_Void NotFoundCBSub)
    { 
       server.begin();
//       MimeTypes mime; 
       rcs = new (backend) awot::Application; 
       instance = this;
       rcs->notFound((Router::MIDDLEWARE_PARAM) NotFoundCBSub);
       rcs->finally((Router::MIDDLEWARE_PARAM) FinallyCBSub);
    };  
//*************    B4RaWOT::Call Back; ***************  
    void B4RaWOT::middlewareCB(Request* req, Response* res, SubVoid_Void middlewareSub)
    { 
       B4RaWOT::ptrON = true; resSV = res; reqSV = req;
       middlewareSub();  
//       B4R::Common::LogHelper(4,102,F("***middlewareCB_2*** Resp_statusSent: "),6,((uint32_t)res->statusSent()),102,("  Resp_ended: "),6,((uint32_t)res->ended()));   
       B4RaWOT::ptrON = false;    
    };
//************* end call back *************************
     void B4RaWOT::error()
    {
         B4R::Common::LogHelper(1,102,F("<error> middleware used out of sequence"));     
    }

    void B4RaWOT::process()
    {  
       WiFiClient client = server.available();
      if (client.connected()) {
         _IP = client.remoteIP();
          B4R::Common::LogHelper(2,102,F("RemoteIP connected: "),102,(_IP.toString()));  
          rcs->process(&client);
         client.stop();  }
   	} 
   
    B4RString* B4RaWOT::getClientIP()
    {
       return B4RString::PrintableToString(&_IP);
    } 
    
    ArrayByte* B4RaWOT::getClientIP1()
    {
       ArrayByte* ip = CreateStackMemoryObject(ArrayByte);
   	   ip->data = StackMemory::buffer + StackMemory::cp;
	   ip->length = 4;   
	   for (byte i = 0;i < 4;i++) {
	     ((Byte*)ip->data)[i] = _IP[i];
    	}
	   return ip;
    }     
     
    void B4RaWOT::app_del(B4RString* path,SubVoid_Void middlewareSub)
    {  
       rcs->del(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub); 
    }

    void B4RaWOT::app_del1(SubVoid_Void middlewareSub)
    { 
       rcs->del((Router::MIDDLEWARE_PARAM) middlewareSub);
    }
    
    void B4RaWOT::app_finally(SubVoid_Void middlewareSub)
    { 
       this->FinallyCBSub = FinallyCBSub;      
       rcs->finally((Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_get(B4RString* path,SubVoid_Void middlewareSub)
    {  
       rcs->get(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_get1(SubVoid_Void middlewareSub)
    {  
       rcs->get( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_head(B4RString* path,SubVoid_Void middlewareSub)
    {  
       rcs->head(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_head1(SubVoid_Void middlewareSub)
    {  
       rcs->head( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_header(B4RString* name, ArrayByte* buffer)
    {  
       rcs->header(name->data, (char*)buffer->data, buffer->length);
    }

    void B4RaWOT::app_notFound(SubVoid_Void middlewareSub)
    {  
       this->NotFoundCBSub = NotFoundCBSub;  
       rcs->notFound((Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_options(B4RString* path,SubVoid_Void middlewareSub)
    {  
       rcs->options(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_options1(SubVoid_Void middlewareSub)
    {  
       rcs->options( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_patch(B4RString* path,SubVoid_Void middlewareSub)
    { 
       rcs->patch(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_patch1(SubVoid_Void middlewareSub)
    {  
       rcs->patch( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_post(B4RString* path,SubVoid_Void middlewareSub)
    { 
       rcs->post(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_post1(SubVoid_Void middlewareSub)
    {  
       rcs->post( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_put(B4RString* path,SubVoid_Void middlewareSub)
    {  
       rcs->put(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_put1(SubVoid_Void middlewareSub)
    {  
       rcs->put( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_setTimeout(uint32_t timeoutMillis)
    {
       rcs->setTimeout(timeoutMillis);
    }

    void B4RaWOT::app_useR(B4RString* path,uint8_t Rindex) 
    {  
       rcs->useR(path->data, &m_router[Rindex]);
    }

    void B4RaWOT::app_useR1(uint8_t Rindex)
    { 
       rcs->useR( &m_router[Rindex]);
    }

    void B4RaWOT::app_use(B4RString* path,SubVoid_Void middlewareSub)
    { 
       rcs->use(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::app_use1(SubVoid_Void middlewareSub)
    { 
       rcs->use( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }
    
    B4RString* B4RaWOT::Mime_getType(B4RString* filename)
    {  const char* raw = mime.MimeTypes::getType(filename->data);
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw;
       return arr;       
    }
       

//************************************************
//*****    awot::Response awot::response;    *****
//************************************************    
    int32_t B4RaWOT::res_availableForWrite()
    {  if (!ptrON) {error(); return 0;}
       return resSV->availableForWrite();
    }

    int32_t B4RaWOT::res_bytesSent()
    {  if (!ptrON) {error(); return 0;}
       return resSV->bytesSent();
    }

    void B4RaWOT::res_beginHeaders()
    {  if (!ptrON) {error(); return;}
       resSV->beginHeaders();
    }

    void B4RaWOT::res_end()
    {  if (!ptrON) {error(); return;}
       resSV->end();
    }

    void B4RaWOT::res_endHeaders()
    {  if (!ptrON) {error(); return;}
       resSV->endHeaders();
    }

    bool B4RaWOT::res_ended()
    {  if (!ptrON) {error(); return false;}
       return resSV->ended();
    }

    void B4RaWOT::res_flush()
    {  if (!ptrON) {error(); return;}
       resSV->flush();
    }

    B4RString* B4RaWOT::res_get(B4RString* name)
    {  const char* raw = resSV->get(name->data);
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw;
       return arr;       
    }

    bool B4RaWOT::res_headersSent()
    {  if (!ptrON) {error(); return false;}
       return resSV->headersSent();
    }
    
//    void B4RaWOT::Response::printP(B4RString* Ustring)//    {//       response.printP(Ustring->data); //    }

    void B4RaWOT::res_print(B4RString* string)
    {  if (!ptrON) {error(); return;}
       resSV->printA(string->data);
    }
    void B4RaWOT::res_println(B4RString* string)
    {  if (!ptrON) {error(); return;}
       resSV->printlnA(string->data);
    }
    void B4RaWOT::res_printCRLF()
    {  if (!ptrON) {error(); return;}
       resSV->printCRLF();
    }

    
    void B4RaWOT::res_sendStatus(int16_t code)
    {  if (!ptrON) {error(); return;}
       resSV->sendStatus(code);
    }

    void B4RaWOT::res_set(B4RString* name, B4RString* value)
    {  if (!ptrON) {error(); return;}
       resSV->set(name->data, value->data);
    }

    void B4RaWOT::res_setDefaults()
    {  if (!ptrON) {error(); return;}
       resSV->setDefaults();
    }

    void B4RaWOT::res_status(int16_t code)
    {  if (!ptrON) {error(); return;}
       resSV->status(code);
    }

    int16_t B4RaWOT::res_statusSent()
    {  if (!ptrON) {error(); return 0;}
       return resSV->statusSent();
    }

    uint16_t B4RaWOT::res_write(uint8_t data)
    {  if (!ptrON) {error(); return 0;}
       return resSV->write(data);
    }

    uint16_t B4RaWOT::res_write1(ArrayByte* buffer, uint16_t length)
    {  if (!ptrON) {error(); return 0;}
       return resSV->write((byte*)buffer->data, length);
    }

//    void B4RaWOT::res_writeP(ArrayByte* data)
//    {
//       resSV->writeP((byte*)data->data, data->length);
//    }

//**********************************************
//*****    awot::Request awot::request;    *****
//**********************************************
    int32_t B4RaWOT::req_available()
    {  if (!ptrON) {error(); return 0;}
       return reqSV->available();
    }

    int32_t B4RaWOT::req_availableForWrite()
    {  if (!ptrON) {error(); return 0;}
       return reqSV->availableForWrite();
    }

    int32_t B4RaWOT::req_bytesRead()
    {  if (!ptrON) {error(); return 0;}
       return reqSV->bytesRead();
    }

//    B4RStream* B4RaWOT::req_stream() //    { //       stream* str = reqSV->stream(); //       return  &str; //    }                     

    void B4RaWOT::req_flush()
    {  if (!ptrON) {error(); return;}
       reqSV->flush();
    }

    bool B4RaWOT::req_form(ArrayByte* name,ArrayByte* value)
   {  if (!ptrON) {error(); return false;}    
      char a; char* na = (char*)name->data; int na_l = name->length; char* va = (char*)value->data; int va_l = value->length;
       boolean ret = reqSV->form(na, na_l, va, va_l);
       for (int i=0; i< na_l; i++) {if (na[i] < 32) {na[i]=32;};};value->data=va;value->length=va_l;
       for (int i=0; i< va_l; i++) {if (va[i] < 32) {va[i]=32;};};value->data=va;value->length=va_l;
       return ret;
 //      return reqSV->form((char*)name->data, name->length, (char*)value->data, value->length); 
    }


    B4RString* B4RaWOT::req_get(B4RString* name)
    {  char* raw = reqSV->get(name->data);
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw;
       return arr;
    }

    int32_t B4RaWOT::req_left()
    {  if (!ptrON) {error(); return 0;}
       return reqSV->left();
    }

    Byte B4RaWOT::req_method()
    {  if (!ptrON) {error(); return 0;}
//     enum MethodType {UNKNOWN, GET, HEAD, POST, PUT, DELETE, PATCH, OPTIONS, ALL}; 
       switch (reqSV->method()) {
       case Request::MethodType::UNKNOWN   : return 0;break;
       case Request::MethodType::GET       : return 1;break;
       case Request::MethodType::HEAD      : return 2;break;
       case Request::MethodType::POST      : return 3;break;
       case Request::MethodType::PUT       : return 4;break;
       case Request::MethodType::DELETE    : return 5;break; 
       case Request::MethodType::PATCH     : return 6;break; 
       case Request::MethodType::OPTIONS   : return 7;break;
       case Request::MethodType::ALL       : return 8;break;
       default                    : return 0;break;
       }   
    };
    
     B4RString* B4RaWOT::req_path()
    {  char* raw = reqSV->path();;
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw;
       return arr;       
    }

    int32_t B4RaWOT::req_peek()
    {  if (!ptrON) {error(); return 0;}
       return reqSV->peek();
    }

    void B4RaWOT::req_push(uint8_t ch)
    {  if (!ptrON) {error(); return;}
       reqSV->push(ch);
    }

    B4RString* B4RaWOT::req_query()
    {  char* raw = reqSV->query();
       B4RString* arr = CreateStackMemoryObject(B4RString);
       arr->data = raw;
       return arr;              
    }

    bool B4RaWOT::req_query1(B4RString* name, ArrayByte* buffer)
    {  if (!ptrON) {error(); return false;}
       return reqSV->query(name->data, (char*)buffer->data, buffer->length);
    }

    int32_t B4RaWOT::req_read()
    {  if (!ptrON) {error(); return 0;}
       return reqSV->read();
    }

    int32_t B4RaWOT::req_read1(ArrayByte* buf)
    {  if (!ptrON) {error(); return 0;}
       return reqSV->read((byte*)buf->data, buf->length);
    }

    bool B4RaWOT::req_route(B4RString* name, ArrayByte* buffer)
    {  if (!ptrON) {error(); return false;}
       return reqSV->route(name->data,  (char*)buffer->data, buffer->length);
    }

    bool B4RaWOT::req_route1(int16_t number, ArrayByte* buffer)
    {  if (!ptrON) {error(); return false;}
       return reqSV->route(number,  (char*)buffer->data, buffer->length);
    }

    int16_t B4RaWOT::req_minorVersion()
    {  if (!ptrON) {error(); return 0;}
       return reqSV->minorVersion();
    }

    uint16_t B4RaWOT::req_write(uint8_t data)
    {  if (!ptrON) {error(); return 0;}
       return reqSV->write(data);
    }

    uint16_t B4RaWOT::req_write1(ArrayByte* buffer, uint16_t length)
    {  if (!ptrON) {error(); return 0;}
       return reqSV->write((byte*)buffer->data, length);
    }    

//**************************************
//*****    awot::Router router;    *****  
//**************************************  
    void B4RaWOT::rout_del(uint8_t RindexO, B4RString* path,SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].del(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_del1(uint8_t RindexO, SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].del( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_get(uint8_t RindexO, B4RString* path,SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].get(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_get1(uint8_t RindexO, SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].get( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_head(uint8_t RindexO, B4RString* path,SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].head(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_head1(uint8_t RindexO, SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].head( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_options(uint8_t RindexO, B4RString* path,SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].options(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_options1(uint8_t RindexO, SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].options( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_patch(uint8_t RindexO, B4RString* path,SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].patch(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_patch1(uint8_t RindexO, SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].patch( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_post(uint8_t RindexO, B4RString* path,SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].post(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_post1(uint8_t RindexO, SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].post( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_put(uint8_t RindexO, B4RString* path,SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].put(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_put1(uint8_t RindexO, SubVoid_Void middlewareSub)
    { 
       m_router[RindexO].put( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_useR(uint8_t RindexO, B4RString* path,uint8_t Rindex)
    {  
       m_router[RindexO].useR(path->data, &m_router[Rindex]);
    }

    void B4RaWOT::rout_useR1(uint8_t RindexO, uint8_t Rindex)
    {  
       m_router[RindexO].useR( &m_router[Rindex]);
    }

    void B4RaWOT::rout_use(uint8_t RindexO, B4RString* path,SubVoid_Void middlewareSub)
    {  
       m_router[RindexO].use(path->data, (Router::MIDDLEWARE_PARAM) middlewareSub);
    }

    void B4RaWOT::rout_use1(uint8_t RindexO, SubVoid_Void middlewareSub)
    {  
       m_router[RindexO].use( (Router::MIDDLEWARE_PARAM) middlewareSub);
    }
    
}
