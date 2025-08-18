### rSPI library and rSPI32 library by candide
### 01/29/2022
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/137133/)

i would like to add in this section 2 wrappers i wrote:  
 - a wrapper for SPI library from esp8266 project  
 - and a wrapper for SPI32 from esp32 project  
  
all functions available in arduino are available in B4R.  
except one in SPI32: void writePixels(const void \* data, uint32\_t size);//ili9341 compatible => i don't konw how to handle "const void \* data"  
  
2 function are added at rSPI to handle the 3 cases of transferBytes  
 void transferBytes(ArrayByte\* data, ArrayByte\* out, uint32\_t size); => both sides  
 void transferBytesR(ArrayByte\* out, uint32\_t size); => Read only  
 void transferBytesW(ArrayByte\* data, uint32\_t size); => Write only   
  
i hope it can help B4R users…  
  
29/01/2021 update of SPI32 including more information on esp32 configurations