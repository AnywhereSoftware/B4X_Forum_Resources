#pragma once
#include "B4RDefines.h"
#include "WString.h"

    //~Event: 
    //~Version: 1.1 
    //~Author - 
    //~Libray from Arduino

namespace B4R
{
   //~shortname:AString
   class B4RAString
    {
      private:
         String Astr;
      public:
	  
	     B4RString* get();
		 
         void setStr(B4RString* str);

         void setArr(ArrayByte* str);

         void setChr(byte c);

         void setByte( byte c, uint16_t base);

         void setInt(int16_t i, uint16_t base);

         void setUInt( uint16_t ui, uint16_t base);

         void setLong(uint32_t l, uint16_t base);

         void setULong(uint32_t ul, uint16_t base);

         void setDouble(float fl, uint16_t decimalPlaces);

//    ~String(void)
         bool reserve(uint16_t size);

         uint16_t length();

         bool isEmpty();

         bool addChr(byte str);

         bool addStr(B4RString* str);

         bool addArr(ArrayByte* str);

         bool addByte(byte c, uint16_t base);

         bool addInt(int16_t num, uint16_t base);

         bool addUInt(uint16_t num, uint16_t base);

         bool addLong(int32_t num, uint16_t base);

         bool addULong(uint32_t num, uint16_t base);

         bool addDouble(float num, uint16_t base);

         int16_t compareToStr(B4RString* s);

         int16_t compareToArr(ArrayByte* s);

         bool equalsStr(B4RString* s);

         bool equalsArr(ArrayByte* s);

         bool equalsIgnoreCase(B4RString* s);

         bool startsWith(B4RString* prefix);

         bool startsWith1(B4RString* prefix, uint16_t offset);

         bool endsWith(B4RString* suffix);

         byte charAt(uint16_t index);

         void setCharAt(uint16_t index, byte c);

         void getBytes(ArrayByte* buf, uint16_t index);

         void toCharArray(ArrayByte* buf, uint16_t index);

         int16_t indexOfChr(byte ch);

         int16_t indexOfChr1(byte ch, uint16_t fromIndex);

         int16_t indexOfStr(B4RString* str);

         int16_t indexOfStr1(B4RString* str, uint16_t fromIndex);

         int16_t lastIndexOfChr(byte ch);

         int16_t lastIndexOfChr1(byte ch, uint16_t fromIndex);

         int16_t lastIndexOfStr(B4RString* str);

         int16_t lastIndexOfStr1(B4RString* str, uint16_t fromIndex);

         B4RString* substring(uint16_t beginIndex);

         B4RString* substring1(uint16_t beginIndex, uint16_t endIndex);

         void replaceChr(byte find, byte replace);

         void replaceStr(B4RString* find, B4RString* replace);

         void remove(uint16_t index);

         void remove1(uint16_t index, uint16_t count);

         void toLowerCase();

         void toUpperCase();

         void trim();

         int32_t toInt();

         float toFloat();

    };
}