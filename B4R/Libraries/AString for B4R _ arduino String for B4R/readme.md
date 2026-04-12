### AString for B4R : arduino String for B4R by candide
### 04/09/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/170767/)

it is a wrapper for wString from Arduino.  
  
with this library, String are managed like in arduino, in memory and without constraint of B4R stack.  
=>AString are available and modifiable from all parts of your script, from all sub, and after a callsubplus.  
  
function ".setxxx" are used to store something in a string, ".addxxx" are used to join something at a string and ".getxxx' are used to load a string from B4R  
  
AString are available / modifiable in inline C : it can be used to move String between B4R script and inline C (see example of script)   
  
list of features from String in arduino and available from B4R :  
 void setStr(B4RString\* str);  
 void setArr(ArrayByte\* str);  
 void setChr(byte c);  
 void setByte( byte c, uint16\_t base);  
 void setInt(int16\_t i, uint16\_t base);  
 void setUInt( uint16\_t ui, uint16\_t base);  
 void setLong(uint32\_t l, uint16\_t base);  
 void setULong(uint32\_t ul, uint16\_t base);  
 void setDouble(float fl, uint16\_t decimalPlaces);  
 bool reserve(uint16\_t size);  
 uint16\_t length();  
 bool isEmpty();  
 bool addChr(byte str);  
 bool addStr(B4RString\* str);  
 bool addArr(ArrayByte\* str);  
 bool addByte(byte c, uint16\_t base);  
 bool addInt(int16\_t num, uint16\_t base);  
 bool addUInt(uint16\_t num, uint16\_t base);  
 bool addLong(int32\_t num, uint16\_t base);  
 bool addULong(uint32\_t num, uint16\_t base);  
 bool addDouble(float num, uint16\_t base);  
 int16\_t compareToStr(B4RString\* s);  
 int16\_t compareToArr(ArrayByte\* s);  
 bool equalsStr(B4RString\* s);  
 bool equalsArr(ArrayByte\* s);  
 bool equalsIgnoreCase(B4RString\* s);  
 bool startsWith(B4RString\* prefix);  
 bool startsWith1(B4RString\* prefix, uint16\_t offset);  
 bool endsWith(B4RString\* suffix);  
 byte charAt(uint16\_t index);  
 void setCharAt(uint16\_t index, byte c);  
 void getBytes(ArrayByte\* buf, uint16\_t index);  
 void toCharArray(ArrayByte\* buf, uint16\_t index);  
 int16\_t indexOfChr(byte ch);  
 int16\_t indexOfChr1(byte ch, uint16\_t fromIndex);  
 int16\_t indexOfStr(B4RString\* str);  
 int16\_t indexOfStr1(B4RString\* str, uint16\_t fromIndex);  
 int16\_t lastIndexOfChr(byte ch);  
 int16\_t lastIndexOfChr1(byte ch, uint16\_t fromIndex);  
 int16\_t lastIndexOfStr(B4RString\* str);  
 int16\_t lastIndexOfStr1(B4RString\* str, uint16\_t fromIndex);  
 B4RString\* substring(uint16\_t beginIndex);  
 B4RString\* substring1(uint16\_t beginIndex, uint16\_t endIndex);  
 void replaceChr(byte find, byte replace);  
 void replaceStr(B4RString\* find, B4RString\* replace);  
 void remove(uint16\_t index);  
 void remove1(uint16\_t index, uint16\_t count);  
 void toLowerCase();  
 void toUpperCase();  
 void trim();  
 int32\_t toInt();  
 float toFloat();  
  
new delivery 1.1 after an issue with esp8266. Now tested with esp32 and esp8266