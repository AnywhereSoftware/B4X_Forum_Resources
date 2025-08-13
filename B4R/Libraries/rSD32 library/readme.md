### rSD32 library by candide
### 08/22/2024
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/138019/)

it is a wrapper based on SD library in esp32 package for arduino.  
SPI configuration is depending of esp32 version:  
ESP32:  
 - FSPI = 1, SPI attached To flash / normally Not used   
 - HSPI = 2, uses SPI2 => MOSI (13), SCK (14), MISO (12), SS (15)  
 - VSPI = 3, uses SPI3 => MOSI (23), SCK (18), MISO (19), SS (5)  
 - VSPI is SPI by default  
  
ESP32-S2:  
 - FSPI = 1, uses SPI2 =>MOSI (13), SCK (14), MISO (15) And SS (12) / 6 SS lines any other pin  
 - HSPI = 2, uses SPI3 =>MOSI (35), SCK (36), MISO (37) And SS (34) / 3 SS lines at any other pin  
 - VSPI Not defined  
  
ESP32 C3:  
 - FSPI = 0, uses SPIx =>MOSI (5), SCK (6), MISO (7) And SS (10) / 6 SS lines any other pin  
 - HSPI Not defined  
 - VSPI Not defined  
  
  
' \* SPI Standard case: Connect the SD card To the following pins:  
' \*  
' \* SD Card | ESP32 | HSPI | VSPI  
' \* D2 -  
' \* D3 SS 15 5  
' \* CMD MOSI 13 23  
' \* VSS GND  
' \* VDD 3.3V  
' \* CLK SCK 14 18  
' \* VSS GND  
' \* D0 MISO 12 19  
' \* D1 -  
' \*/  
a personal configuration is also possible when pins are added in begin.  
  
new functions in esp32 package are added:  
 byte getcardType();  
 ULong getcardSize();  
 ULong gettotalBytes();  
 ULong getusedBytes();  
 bool readRAW(ArrayByte\* buffer, ULong sector);  
 bool writeRAW(ArrayByte\* buffer, ULong sector);  
  
  
2024/08/22 new version 1.02 with a few fix for SPI after issues found by [USER=1637]peacemaker[/USER]  
 tested for VSPI and HSPI on esp32 30 pins