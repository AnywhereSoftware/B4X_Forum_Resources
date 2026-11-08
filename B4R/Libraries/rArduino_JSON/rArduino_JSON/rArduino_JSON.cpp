#include "B4RDefines.h"

namespace B4R
{
//****************************************************
//*** class JSONClass JSON ***************************
//****************************************************
   JSONClass json;

   void B4RJSON::parse(B4RString* s, B4RJSONVar* JVarResult)     
   {
       JSONVar tmp = json.parse((String)s->data); 
       JVarResult->setJsonVar1(tmp);
   };
   
   B4RString* B4RJSON::stringify(B4RJSONVar* JVar)
   {   JSONVar ttp = JVar->getJsonVar1();
       String tmp = json.stringify(ttp);
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(tmp);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;    
   };
   
   B4RString* B4RJSON::typeof(B4RJSONVar* JVar)
   {   JSONVar ttp = JVar->getJsonVar1();
       String tmp = json.typeof(ttp);
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(tmp);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;       
   };
   



   
   
   
//****************************************************
//*** class JSONVar Class  ***************************
//****************************************************
    JSONVar jsonV;
    
//******************************************************************************   
    JSONVar B4RJSONVar::getJsonVar1()
    {
       JSONVar tmp = jsonV;
       return tmp;
    }
    void B4RJSONVar::setJsonVar1(JSONVar Jvar)
    {    
       jsonV.operator=( Jvar);
    };
            
//??****************************************************************************
    bool B4RJSONVar::checkifJsonVar(ArrayObject* key, B4RJSONVar* JVar)
    {
       JSONVar Obj[9];
       Datas keys[9];   JSONVar tmp = JVar->getJsonVar1();
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) { return jsonV.operator==(tmp);} else {
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){return Obj[1].operator==(tmp);}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){return Obj[i].operator==(tmp);break;}
        }}     
    };

    bool B4RJSONVar::checkifNull(ArrayObject* key)
    {
       JSONVar Obj[9];
       Datas keys[9];
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) {return jsonV.operator==(NULL);} else {
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){return Obj[1].operator==(NULL);}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){return Obj[i].operator==(NULL);break;}
        }}  
    };  
//??****************************************************************************
//       B4R::Common::LogHelper(8,102,F("***keyNb: "),6,wordNb,102,F("key 0: "),102,keys[0],102,F(" key 1: "),102,keys[1],102,F(" key 2: "),102,keys[2]); 
//??****************************************************************************
    void B4RJSONVar::setNull(ArrayObject* key)
    {
       JSONVar Obj[9];
       Datas keys[9];
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) { jsonV.operator=(NULL);} else {
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){Obj[1].operator=(NULL);}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){Obj[i].operator=(NULL);break;}
        }}    
    };   

     void B4RJSONVar::setJsonVar(ArrayObject* key, B4RJSONVar* JVarResult)     
    {  
       JSONVar Obj[9];
       Datas keys[9]; JSONVar tmp;
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) { tmp.operator=(jsonV);} else {
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){tmp.operator=(Obj[1]);}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){tmp.operator=(Obj[i]);break;}
        }}  
        JVarResult->setJsonVar1(tmp);     
    };  
            
    void B4RJSONVar::setBool(ArrayObject* key, bool val)
    {  
       JSONVar Obj[9];
       Datas keys[9];
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) { jsonV.operator=((bool) val);} else {
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){Obj[1].operator=((bool) val);}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){Obj[i].operator=((bool) val);break;}
        }}           
    };
    
    void B4RJSONVar::setNumberL(ArrayObject* key, int32_t val)
    {
       JSONVar Obj[9];
       Datas keys[9];
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) { jsonV.operator=((long) val);} else {       
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){Obj[1].operator=((long) val);}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){Obj[i].operator=((long) val);break;}
        } }        
    };
    
    void B4RJSONVar::setNumberUL(ArrayObject* key, uint32_t val)
    {
       JSONVar Obj[9];
       Datas keys[9];
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) { jsonV.operator=((double) val);} else {       
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){Obj[1].operator=((double) val);} //unsigned long) val);}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){Obj[i].operator=((double) val); break;} //unsigned long) val);break;}
        }}         
    };       

    void B4RJSONVar::setNumberD(ArrayObject* key, Double val)
    {
       JSONVar Obj[9];
       Datas keys[9];
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) { jsonV.operator=((double) val);} else {
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){Obj[1].operator=((double) val);}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){Obj[i].operator=((double) val);break;}
        }}         
    };         
    
    void B4RJSONVar::setString(ArrayObject* key,B4RString* val)
    {
       JSONVar Obj[9];
       Datas keys[9];
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) { jsonV.operator=((const String) val->data);} else {
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){Obj[1].operator=((const String) val->data);}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){Obj[i].operator=((const String) val->data);break; }
            // B4R::Common::LogHelper(2,102,F("***i 2  : "),6,i);}
        }}         
    };

//??****************************************************************************  

     void B4RJSONVar::getJsonVar(ArrayObject* key, B4RJSONVar* JVar)     
    {  
       JSONVar Obj[9];
       Datas keys[9]; JSONVar tmp = JVar->getJsonVar1();
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) { jsonV.operator=(tmp);} else {
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){Obj[1].operator=(tmp);}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){Obj[i].operator=(tmp);break;}
        }}       
    };
              
    bool B4RJSONVar::getBool(ArrayObject* key)
    {    
       JSONVar Obj[9];
       Datas keys[9];
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) { return jsonV.operator bool();}
//       B4R::Common::LogHelper(8,102,F("***keyNb: "),6,wordNb,102,F("key 0: "),102,keys[0],102,F(" key 1: "),102,keys[1],102,F(" key 2: "),102,keys[2]); 
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){return Obj[1].operator bool();}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){return Obj[i].operator bool(); break;}
        }           
    };
    
    int32_t B4RJSONVar::getNumberL(ArrayObject* key)
    {
       JSONVar Obj[9];   
       Datas keys[9];
       sortKey(key, keys); int keysNb = keys[0].INT;
 //      B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) { return jsonV.operator long();}  
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){return Obj[1].operator long();}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){return Obj[i].operator long(); break;}
        }           
    };       
    
    uint32_t B4RJSONVar::getNumberUL(ArrayObject* key)
    { 
       JSONVar Obj[9];
       Datas keys[9]; unsigned long tmp;
       sortKey(key, keys); int keysNb = keys[0].INT; 
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) {return jsonV.operator double();} 
//       B4R::Common::LogHelper(8,102,F("***keyNb: "),6,wordNb,102,F("key 0: "),102,keys[0],102,F(" key 1: "),102,keys[1],102,F(" key 2: "),102,keys[2]); 
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){return Obj[1].operator double();} //unsigned long();}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){return Obj[i].operator double(); break;} //unsigned long(); break;}
        }           
    };
           
    Double B4RJSONVar::getNumberD(ArrayObject* key)
    {
       JSONVar Obj[9];
       Datas keys[9]; double tmp;
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) { return jsonV.operator double();}
//       B4R::Common::LogHelper(8,102,F("***keyNb: "),6,wordNb,102,F("key 0: "),102,keys[0],102,F(" key 1: "),102,keys[1],102,F(" key 2: "),102,keys[2]); 
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){return Obj[1].operator double();}
        for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){return Obj[i].operator double(); break;}
        }           
    };
    
    B4RString* B4RJSONVar::getString(ArrayObject* key)
    {
       JSONVar Obj[9]; 
       Datas keys[9]; String tmp;
       sortKey(key, keys);  int keysNb = keys[0].INT; 
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);     
       if (keys[0].INT==0) { tmp = jsonV.operator const String();} else {       
//       B4R::Common::LogHelper(8,102,F("***keyNb: "),6,wordNb,102,F("key 0: "),102,keys[0],102,F(" key 1: "),102,keys[1],102,F(" key 2: "),102,keys[2]); 
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){tmp= Obj[1].operator const String();}
        for (int i=2; i<=keysNb; i++) {
//            B4R::Common::LogHelper(2,102,F("***i 1  : "),6,i);
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){tmp= Obj[i].operator const String(); }
            // B4R::Common::LogHelper(2,102,F("***i 2  : "),6,i); break;}
        }}           
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(tmp);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;         
    };
   
    int16_t B4RJSONVar::Length(ArrayObject* key)
    {
       JSONVar Obj[9]; //JSONVar jvar = JVarResult->getJsonVar1();
       Datas keys[9]; JSONVar tmp=NULL;
       sortKey(key, keys); int keysNb = keys[0].INT; //0 < 9   
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);
       if (keys[0].INT==0) { return jsonV.length();}                              
//       B4R::Common::LogHelper(8,102,F("**length**keyNb: "),6,keysNb,102,F("key 0: "),6,keys[1].INT,102,F(" key 1: "),6,keys[1].INT,102,F(" key 2: "),6,keys[2].INT); 
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){tmp= Obj[1];}
       for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){tmp= Obj[i]; break;}
       }      
       return tmp.length();
    };

    void B4RJSONVar::keys( ArrayObject* key, B4RJSONVar* JVarResult)    
    { 
       JSONVar Obj[9]; JSONVar jvar ;
       Datas keys[9]; JSONVar tmp=NULL;
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);
       if (keys[0].INT==0) {tmp = jsonV;}else {                     
 //      B4R::Common::LogHelper(8,102,F("***keyNb: "),6,keysNb,102,F("key 0: "),6,keys[0].INT,102,F(" key 1: "),6,keys[1].INT,102,F(" key 2: "),6,keys[2].INT); 
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){tmp= Obj[1];}
       for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){tmp= Obj[i]; break;}
       } }                                                                                             
       jvar = tmp.keys();
       JVarResult->setJsonVar1(jvar);
    };
       
    void B4RJSONVar::parse(B4RString* s)
    {
       jsonV = JSON.parse((String) s->data);   
    }; 
    
    B4RString* B4RJSONVar::stringify(ArrayObject* key)
    {
       JSONVar Obj[9]; //JSONVar jvar = JVarResult->getJsonVar1();
       Datas keys[9]; JSONVar tmp=NULL;
       sortKey(key, keys); int keysNb = keys[0].INT;
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);
       if (keys[0].INT==0) {tmp = jsonV;}else {                          
 //      B4R::Common::LogHelper(8,102,F("***keyNb: "),6,keysNb,102,F("key 0: "),6,keys[0].INT,102,F(" key 1: "),6,keys[1].INT,102,F(" key 2: "),6,keys[2].INT); 
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){tmp= Obj[1];}
       for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){tmp= Obj[i]; break;}
       } }     
       String rax = JSON.stringify(tmp);
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    }; 
      
    B4RString* B4RJSONVar::typeof(ArrayObject* key)
    {
       JSONVar Obj[9]; //JSONVar jvar = JVarResult->getJsonVar1();
       Datas keys[9]; JSONVar tmp=NULL;
       sortKey(key, keys); int keysNb = keys[0].INT; 
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);
       if (keys[0].INT==0) {tmp = jsonV;}else {                                
 //      B4R::Common::LogHelper(8,102,F("***keyNb: "),6,keysNb,102,F("key 0: "),6,keys[0].INT,102,F(" key 1: "),6,keys[1].INT,102,F(" key 2: "),6,keys[2].INT); 
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){tmp= Obj[1];}
       for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){tmp= Obj[i]; break;}
       }}     
       String rax = JSON.typeof(tmp);
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    }; 
           
//??**************************************************************************** 
       
    bool B4RJSONVar::hasOwnProperty(ArrayObject* key, B4RString* key_)
    {
       JSONVar Obj[9];
       Datas keys[9]; JSONVar tmp=NULL;
       sortKey(key, keys); int keysNb = keys[0].INT; 
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);
       if (keys[0].INT==0) {tmp = jsonV;}else {                                
 //      B4R::Common::LogHelper(8,102,F("***keyNb: "),6,keysNb,102,F("key 0: "),6,keys[0].INT,102,F(" key 1: "),6,keys[1].INT,102,F(" key 2: "),6,keys[2].INT); 
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){tmp= Obj[1];}
       for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){tmp= Obj[i]; break;}
       }} 
       return tmp.hasOwnProperty((String)key_->data);
    };
    
    bool B4RJSONVar::hasPropertyEqualString(ArrayObject* key, B4RString* key_, B4RString* value)
    {
       JSONVar Obj[9]; 
       Datas keys[9]; JSONVar tmp=NULL;
       sortKey(key, keys); int keysNb = keys[0].INT; 
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);
       if (keys[0].INT==0) {tmp = jsonV;}else {                                
 //      B4R::Common::LogHelper(8,102,F("***keyNb: "),6,keysNb,102,F("key 0: "),6,keys[0].INT,102,F(" key 1: "),6,keys[1].INT,102,F(" key 2: "),6,keys[2].INT); 
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){tmp= Obj[1];}
       for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){tmp= Obj[i]; break;}
       }} 
       return tmp.hasPropertyEqual((const String) key_->data,(const String) value->data);
    };
    
    bool B4RJSONVar::hasPropertyEqualJsonVar(ArrayObject* key, B4RString* key_, B4RJSONVar* JVar) 
    {  
       JSONVar Obj[9];
       Datas keys[9]; JSONVar tmp=NULL;
       sortKey(key, keys); int keysNb = keys[0].INT; 
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);
       if (keys[0].INT==0) {tmp = jsonV;}else {                                
//       B4R::Common::LogHelper(8,102,F("***keyNb: "),6,keysNb,102,F("key 0: "),6,keys[0].INT,102,F(" key 1: "),6,keys[1].INT,102,F(" key 2: "),6,keys[2].INT); 
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){tmp= Obj[1];}
       for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){tmp= Obj[i]; break;}
       }}
       JSONVar ttp = JVar->getJsonVar1();  
       return tmp.hasPropertyEqual((const String) key_->data, ttp); 
    };
    
//??****************************************************************************
    void B4RJSONVar::filterString(ArrayObject* key, B4RString* key_, B4RString* value, B4RJSONVar* JVarResult) 
    {  
       JSONVar Obj[9];
       Datas keys[9]; JSONVar tmp=NULL;
       sortKey(key, keys); int keysNb = keys[0].INT; 
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);
       if (keys[0].INT==0) {tmp = jsonV;}else {                                
//       B4R::Common::LogHelper(8,102,F("***keyNb: "),6,keysNb,102,F("key 0: "),6,keys[0].INT,102,F(" key 1: "),6,keys[1].INT,102,F(" key 2: "),6,keys[2].INT); 
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){tmp= Obj[1];}
       for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){tmp= Obj[i]; break;}
       }} 
       JSONVar tmp2 = tmp.filter((const String)key_->data,(const String) value->data);
       JVarResult->setJsonVar1(tmp2);
    };
    
    void B4RJSONVar::filterJsonVar(ArrayObject* key, B4RString* key_, B4RJSONVar* value, B4RJSONVar* JVarResult)
    {
       JSONVar Obj[9];
       Datas keys[9]; JSONVar tmp=NULL;
       sortKey(key, keys); int keysNb = keys[0].INT; 
//       B4R::Common::LogHelper(2,102,F("***keyNb: "),6,keys[0].INT);
       if (keys[0].INT==0) {tmp = jsonV;}else {                                
//       B4R::Common::LogHelper(8,102,F("***keyNb: "),6,keysNb,102,F("key 0: "),6,keys[0].INT,102,F(" key 1: "),6,keys[1].INT,102,F(" key 2: "),6,keys[2].INT); 
            if (keys[1].TYP == 0) {Obj[1]=jsonV.operator [] (keys[1].INT);} else {Obj[1]=jsonV.operator [] (keys[1].STR);}
            if (keysNb == 1){tmp= Obj[1];}
       for (int i=2; i<=keysNb; i++) {
            if (keys[i].TYP == 0) {Obj[i]=Obj[i-1].operator [] (keys[i].INT);} else {Obj[i]=Obj[i-1].operator [] (keys[i].STR);} 
            if (keysNb == i){tmp= Obj[i]; break;}
       }} 
       JSONVar ttp = value->getJsonVar1(); 
       JSONVar tmp2 = tmp.filter((const String) key_->data, ttp);
       JVarResult->setJsonVar1(tmp2);
    };
    
//??****************************************************************************       
    void B4RJSONVar::sortKey(ArrayObject* key, Datas(&keys)[9])
    {
    const char* cchar1; char* char1; B4R::Array* ar2; B4R::Object** arrayOfPointers;            
        arrayOfPointers = (B4R::Object**) key->data;       
        B4R::Object* c[key->length]; int i;
        int tmp;
        for (i=0;i<9;i++){keys[i].STR="";keys[i].INT=-1;keys[i].TYP=0;}    //clear keys array
 //       B4R::Common::LogHelper(4,102,F("*** Array length : "),6,key->length,102,F("keys(0)"),6,c[0]->toLong());                 
 
	    for(i=0; i< key->length; i++) {
//        B4R::Common::LogHelper(2,102,F("***i : "),6,i);        
		  c[i]= arrayOfPointers[i];	                   
		  switch (c[i]->type) {
		    case 1:
            case 2 :
            case 3 :
            case 4 :
            case 5 : // Long
               tmp=((int) c[i]->toLong());
               keys[i].INT= tmp;            
               keys[i].TYP= 0;
  //              B4R::Common::LogHelper(2,102,F("***case 5 : "),6,tmp);
			   break;			
			case 6 : // ULong
               tmp = ((int) c[i]->toLong());    
               keys[i].INT= tmp;               
               keys[i].TYP= 0; //INT;      
   //            B4R::Common::LogHelper(2,102,F("***case 5 : "),6,tmp);                
			   break;				
			case 7 : // Double
               tmp = ((int) c[i]->toDouble()); 
               keys[i].INT= tmp;   
               keys[i].TYP = 0; //INT;
   //            B4R::Common::LogHelper(2,102,F("***case 5 : "),6,tmp);
			   break;		
			case 100 : //Pointer to char*
	    	   ar2 = (B4R::Array*)B4R::Object::toPointer(c[i]);
			   char1 = (char*)ar2->data;
               keys[i].STR = (String)char1;
               keys[i].TYP= 1;       
   //            B4R::Common::LogHelper(2,102,F("***case 100 : "),102,char1);        
			   break;		
			case 101 : //pointer to const char*		
		       cchar1 = (const char *)B4R::Object::toPointer(c[i]);	
               keys[i].STR = (String) cchar1;
               keys[i].TYP = 1;
    //           B4R::Common::LogHelper(2,102,F("***case 101 : "),102,cchar1);     
               }
          if (i>=9) break;
          if (i>= keys[0].INT) break;        
       }
    };   
} 
 