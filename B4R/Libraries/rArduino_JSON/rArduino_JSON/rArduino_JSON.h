#include "B4RDefines.h"
#pragma once
#include "B4RDefines.h"
#include "Arduino_JSON.h"
#include "variant"
    //~Event: 
    //~Version: 1 
    //~Author - 
    //~Libray from Arduino :https://github.com/arduino-libraries/Arduino_JSON

namespace B4R {
//****************************************************
//*** class JSONClass JSON ***************************
//****************************************************
    class B4RJSONVar;
    // ~shortname:B4RJSON
        //~hide
    class B4RJSON
    {
        private:
            JSONClass json;
            friend class B4RJSONVar;
  //      public:    
            void parse(B4RString* s, B4RJSONVar* JVarRet); 
            B4RString* stringify(B4RJSONVar* JVar);
//return "undefined" "boolean" "null" "number" "string" "array" "object"             
            B4RString* typeof( B4RJSONVar* JVar);           
    }; 

         
//****************************************************
//*** class JSONVar Class  ***************************
//****************************************************
    //~shortname:B4RJSONVar
    class B4RJSONVar
    {
        private:
            struct Datas { 
              bool    TYP;   // To track the type stored    
              int     INT;
              String  STR; 
            }; 
            friend class B4RJSONVar;
            JSONVar    jsonV;              
            void       sortKey(ArrayObject* key, Datas(&keys)[9]); 
        public:    
//??***********************************************************************  
            //~hide
            JSONVar    getJsonVar1(); 
            //~hide   
            void       setJsonVar1(JSONVar Jvar); 
//??***********************************************************************  
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed                                                              
            bool       checkifJsonVar(ArrayObject* key, B4RJSONVar* Jvar);
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed                 
            bool       checkifNull(ArrayObject* key);
//??*************************************************************
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed     
//make a JsonVar NULL                     
            void       setNull(ArrayObject* key); 
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed     
//copy JsonVar(ArrayObject* key) in JVarResult
            void       setJsonVar(ArrayObject* key, B4RJSONVar* JVarResult); 
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed     
            void       setBool(ArrayObject* key, bool val); 
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed             
            void       setNumberL(ArrayObject* key, int32_t val);
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed     
            void       setNumberUL(ArrayObject* key, uint32_t val);                                   
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed     
            void       setNumberD(ArrayObject* key, float val);
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed     
            void       setString(ArrayObject* key, B4RString* val); 
// JVar added at original JsonVar(ArrayObject* key) from JVar
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed                
            void       getJsonVar(ArrayObject* key, B4RJSONVar* JVar);    
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed                   
            bool       getBool(ArrayObject* key); 
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed     
            int32_t    getNumberL(ArrayObject* key);
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed     
            uint32_t   getNumberUL(ArrayObject* key);                                   
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed     
            float      getNumberD(ArrayObject* key);
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed     
            B4RString* getString(ArrayObject* key);
   
//??************************************************************
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed     
// 2 cases:              
// for Array, return number of member of this Array
// for String, return = String length                                        
            int16_t    Length(ArrayObject* key);
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed                 
// for Array, return an array of string corresponding at all key of a JSONVar_Array
// nothing done on objects            
//            ArrayObject*       keys();   
            void       keys(ArrayObject* key, B4RJSONVar* JVarResult);           
//create  a JSONVar from a String                   
            void       parse(B4RString* s);              
//return "undefined" "boolean" "null" "number" "string" "array" "object" 
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed     
            B4RString* typeof(ArrayObject* key);
//ArrayObject* = array of Int or String only. if first = 0 => JSONVar without index is managed               
//create a String from JSONVar                                     
            B4RString* stringify(ArrayObject* key);  
             
//??********************************************************************************************************  
// for array only
//  check if key is pointing to Object
//  return true if next JSONVar not NULL  
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed      
            bool       hasOwnProperty(ArrayObject* key, B4RString* key_);
//for Array only              
//  check if JSONVar pointed by key = value 
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed                           
            bool       hasPropertyEqualString(ArrayObject* key, B4RString* key_, B4RString* value);
//for array only            
//  check if JSONVar pointed by key = (String)value->string  
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed             
            bool       hasPropertyEqualJsonVar(ArrayObject* key, B4RString* key_, B4RJSONVar* value);
//for array only            
// return in JvarResult an array of all JSONVAR with same (String)value 
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed     
            void       filterString(ArrayObject* key, B4RString* key_, B4RString* value, B4RJSONVar* JvarResult);
//for array only            
// return in JvarResult an array of all JSONVAR with same (String)JSONVar->value  
//ArrayObject* = array of Int or String only.  
// first = Nb index keys, 8 index keys possibles. if first = 0 => JSONVar without index is managed              
            void       filterJsonVar(ArrayObject* key, B4RString* key_, B4RJSONVar* value, B4RJSONVar* JvarResult); 
    };  
}
