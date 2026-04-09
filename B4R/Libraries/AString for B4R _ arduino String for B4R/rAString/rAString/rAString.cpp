#include "B4RDefines.h"

namespace B4R
{

//class AString
    String  Astr();
	
	B4RString* B4RAString::get()
	{
	   String rax = Astr;
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
	};

    void B4RAString::setStr(B4RString* str)
    {
       Astr = String(str->data);
    };
	
	void B4RAString::setArr(ArrayByte* str)
    {
       Astr = String((char*)str->data,str->length);
    };

    void B4RAString::setChr(byte c)
    {
       Astr = String((char) c);
    };

    void B4RAString::setByte( byte c, uint16_t base)
    {
       Astr = String((unsigned char)c, base);
    };

    void B4RAString::setInt(int16_t i, uint16_t base)
    {
       Astr = String(i, base);
    };

    void B4RAString::setUInt( uint16_t ui, uint16_t base)
    {
       Astr = String(ui, base);
    };

    void B4RAString::setLong(uint32_t l, uint16_t base)
    {
       Astr = String( l, base);
    };

    void B4RAString::setULong(uint32_t ul, uint16_t base)
    {
       Astr = String(ul,base);
    };

    void B4RAString::setDouble(float fl, uint16_t decimalPlaces)
    {
       Astr = String(fl, decimalPlaces);
    };

    bool B4RAString::reserve(uint16_t size)
    {
       return Astr.reserve(size);
    };

    uint16_t B4RAString::length()
    {
       return Astr.length();
    };

    bool B4RAString::isEmpty()
    {
       return Astr.isEmpty();
    };

    bool B4RAString::addChr(byte str)
    {
       return Astr.concat((char)str);
    };

    bool B4RAString::addStr(B4RString* str)
    {
       return Astr.concat((const char*)str->data);
    };

    bool B4RAString::addArr(ArrayByte* cstr)
    {
       return Astr.concat((char*)cstr->data, cstr->length);
    };

    bool B4RAString::addByte(byte c, uint16_t base)
    {
       return (bool) Astr.concat(String((unsigned char)c, base));
    };

    bool B4RAString::addInt(int16_t num, uint16_t base)
    {
        return (bool) Astr.concat(String(num, base));
    };

    bool B4RAString::addUInt(uint16_t num, uint16_t base)
    {
        return (bool) Astr.concat(String(num, base));
    };

    bool B4RAString::addLong(int32_t num, uint16_t base)
    {
        return (bool) Astr.concat(String(num, base));
    };

    bool B4RAString::addULong(uint32_t num, uint16_t base)
    {
        return (bool) Astr.concat(String(num, base));
    };

    bool B4RAString::addDouble(float num, uint16_t base)
    {
        return (bool) Astr.concat(String(num, base));
    };
	
    // return 0 if compate OK
    int16_t B4RAString::compareToStr(B4RString* s)
    {		
	    return Astr.compareTo(s->data);
	};
	
    // return 0 if compate OK	
    int16_t B4RAString::compareToArr(ArrayByte* s)
    {  
		return Astr.compareTo(String((char*)s->data,s->length));
    };

    // return 1 if equal
    bool B4RAString::equalsStr(B4RString* s)
    {
        return Astr.equals(s->data);
    };
	
    // return 1 if equal
    bool B4RAString::equalsArr(ArrayByte* s)
    {   
		return Astr.equals(String((char*)s->data,s->length));
    };

    bool B4RAString::equalsIgnoreCase(B4RString* s)
    {
        return Astr.equalsIgnoreCase(s->data);
    };

    bool B4RAString::startsWith(B4RString* prefix)
    {
        return Astr.startsWith(prefix->data);
    };

    bool B4RAString::startsWith1(B4RString* prefix, uint16_t offset)
    {
        return Astr.startsWith(prefix->data, offset);
    };

    bool B4RAString::endsWith(B4RString* suffix)
    {
        return Astr.endsWith(suffix->data);
    };

    byte B4RAString::charAt(uint16_t index)
    {
        return Astr.charAt(index);
    };

    void B4RAString::setCharAt(uint16_t index, byte c)
    {
        Astr.setCharAt(index, c);
    };

    void B4RAString::getBytes(ArrayByte* buf, uint16_t index)
    { 
        Astr.getBytes((byte*) buf->data, buf->length, index); 
    };

    void B4RAString::toCharArray(ArrayByte* buf, uint16_t index) 
    {
        Astr.toCharArray((char*) buf, buf->length, index);
    };
 
    int16_t B4RAString::indexOfChr(byte ch)
    {
       return Astr.indexOf((char)ch);
    };

    int16_t B4RAString::indexOfChr1(byte ch, uint16_t fromIndex)
    {
       return Astr.indexOf((char)ch, fromIndex);
    };

    int16_t B4RAString::indexOfStr(B4RString* str)
    {
       return Astr.indexOf(str->data);
    };

    int16_t B4RAString::indexOfStr1(B4RString* str, uint16_t fromIndex)
    {
       return Astr.indexOf(str->data, fromIndex);
    };

    int16_t B4RAString::lastIndexOfChr(byte ch)
    {
       return Astr.lastIndexOf((char)ch);
    };

    int16_t B4RAString::lastIndexOfChr1(byte ch, uint16_t fromIndex)
    {
       return Astr.lastIndexOf((char)ch, fromIndex);
    };

    int16_t B4RAString::lastIndexOfStr(B4RString* str)
    {
       return Astr.lastIndexOf(str->data);
    };

    int16_t B4RAString::lastIndexOfStr1(B4RString* str, uint16_t fromIndex)
    {
       return Astr.lastIndexOf(str->data, fromIndex);
    };

    B4RString* B4RAString::substring(uint16_t beginIndex)
    {
       String rax = Astr.substring(beginIndex);
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };

    B4RString* B4RAString::substring1(uint16_t beginIndex, uint16_t endIndex)
    {
       String rax = Astr.substring(beginIndex, endIndex);
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };

    void B4RAString::replaceChr(byte find, byte replace)
    {
       Astr.replace((char)find,(char) replace);
    };

    void B4RAString::replaceStr(B4RString* find, B4RString* replace)
    {
       Astr.replace(find->data, replace->data);
    };

    void B4RAString::remove(uint16_t index)
    {
       Astr.remove(index);
    };

    void B4RAString::remove1(uint16_t index, uint16_t count)
    {
       Astr.remove(index, count);
    };

    void B4RAString::toLowerCase()
    {
       Astr.toLowerCase();
    };

    void B4RAString::toUpperCase()
    {
       Astr.toUpperCase();
    };

    void B4RAString::trim()
    {
       Astr.trim();
    };

    int32_t B4RAString::toInt()
    {
       return Astr.toInt();
    };

    float B4RAString::toFloat()
    {
       return Astr.toFloat();
    };

}
