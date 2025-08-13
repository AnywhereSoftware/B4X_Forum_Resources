#include "B4RDefines.h"

namespace B4R
{

    void B4RArduinoNvs::Initialize()
    {
       rcs = new (backend) ArduinoNvs();
    };


//  ArduinoNvs()
    bool B4RArduinoNvs::begin(B4RString* namespaceNvs)
    {
       return rcs->begin(namespaceNvs->data);
    };

    void B4RArduinoNvs::close()
    {
       rcs->close();
    };

    bool B4RArduinoNvs::eraseAll(bool forceCommit)
    {
       return rcs->eraseAll(forceCommit);
    };

    bool B4RArduinoNvs::erase(B4RString* key, bool forceCommit)
    {
       return rcs->erase(key->data, forceCommit);
    };

    bool B4RArduinoNvs::setByte(B4RString* key, byte value, bool forceCommit)
    {
       return rcs->setInt(key->data, value, forceCommit);
    };

    bool B4RArduinoNvs::setInt(B4RString* key, int16_t value, bool forceCommit)
    {
       return rcs->setInt(key->data, value, forceCommit);
    };

    bool B4RArduinoNvs::setUInt(B4RString* key, uint16_t value, bool forceCommit)
    {
       return rcs->setInt(key->data, value, forceCommit);
    };

    bool B4RArduinoNvs::setLong(B4RString* key, int32_t value, bool forceCommit)
    {
       return rcs->setInt(key->data, value, forceCommit);
    };

    bool B4RArduinoNvs::setULong(B4RString* key, uint32_t value, bool forceCommit)
    {
       return rcs->setInt(key->data, value, forceCommit);
    };

    bool B4RArduinoNvs::setDouble(B4RString* key, double value, bool forceCommit)
    {
       return rcs->setFloat(key->data, value, forceCommit);
    };

    bool B4RArduinoNvs::setString(B4RString* key, B4RString* value, bool forceCommit)
    {
       return rcs->setString(key->data, value->data, forceCommit);
    };

    byte B4RArduinoNvs::getByte(B4RString* key, byte default_value)
    {
       return rcs->getInt(key->data, default_value);
    };

    int16_t B4RArduinoNvs::getInt(B4RString* key, int16_t default_value)
    {
       return rcs->getInt(key->data, default_value);
    };

    uint16_t B4RArduinoNvs::getUInt(B4RString* key, uint16_t default_value)
    {
       return rcs->getInt(key->data, default_value);
    };

    int32_t B4RArduinoNvs::getLong(B4RString* key, int32_t default_value)
    {
       return rcs->getInt(key->data, default_value);
    };

    uint32_t B4RArduinoNvs::getULong(B4RString* key, uint32_t default_value)
    {
       return rcs->getInt(key->data, default_value);
    };

    double B4RArduinoNvs::getDouble(B4RString* key, double default_value)
    {
       return rcs->getFloat(key->data, default_value);
    };

    bool B4RArduinoNvs::getString(B4RString* key, ArrayByte* buff, ArrayByte* len)
    {  
       String res; 
       byte* len1 = (byte*) len->data; 
       bool err = rcs->getString(key->data, res);
       uint16_t res_len = res.length()+1;
       if (! err){ 
         len1[0] =0; return false;}
       if (len1[0] < res_len){
         len1[0] =0; return false;}
       byte * res1 = (byte*)buff->data ;
       for (int t=0; t<res_len+1; t++) {res1[t] = res[t];}
       len1[0] = res_len;
       return true;
    };

    B4RString* B4RArduinoNvs::getString1(B4RString* key)
    {
       String rax = rcs->getString(key->data);
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };

    bool B4RArduinoNvs::setBlobArray(B4RString* key, ArrayByte* blob, uint16_t length, bool forceCommit)
    {
       return rcs->setBlob(key->data, (byte*)blob->data, length, forceCommit);
    };

    bool B4RArduinoNvs::getBlobArray(B4RString* key, ArrayByte* blob, uint16_t length)
    {
        return rcs->getBlob(key->data, (byte*)blob->data, length);
    };

    uint16_t B4RArduinoNvs::getBlobSize(B4RString* key)
    {
       return rcs->getBlobSize(key->data);
    };

    bool B4RArduinoNvs::commit()
    {
       return rcs->commit();
    };


}
