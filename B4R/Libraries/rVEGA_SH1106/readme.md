### rVEGA_SH1106 by candide
### 04/07/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/166503/)

it is a wrapper for VEGA\_SH1106 library  
  
library for adafruit SSD1306 was changed to SH1106: SH1106 driver similar to SSD1306 so, just change the display() method.  
  
However, SH1106 driver don't provide several functions such as scroll commands.  
// Address for 128x32 is 0x3C  
// Address for 128x64 is 0x3D (default) or 0x3C (if SA0 is grounded)  
/\*=========================================================================  
 SH1106 Displays  
 ———————————————————————–  
 The driver is used in multiple displays (128x64, 128x32, etc.).  
 Select the appropriate display below to create an appropriately  
 sized framebuffer, etc in Adafruit\_SH1106.h  
  
 SH1106\_128\_64 128x64 pixel display  
  
 SH1106\_128\_32 128x32 pixel display  
  
 SH1106\_96\_16