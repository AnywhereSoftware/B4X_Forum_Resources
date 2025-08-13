### rTFT_eSPI + rTFT_eWidget+ rPNGdec a  wrapper for  TFT / compilation esp32 OK / need tests with real TFT by candide
### 08/09/2024
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/158996/)

it is a wrapper for TFT\_eSPI from <https://github.com/Bodmer/TFT_eSPI/>  
added a wrapper for PNGdec from <https://github.com/bitbank2/PNGdec>  
added a wrapper for TFT\_eWidget from <https://github.com/Bodmer/TFT_eWidget>  
this Wrapper is working with TFT\_eSPI library installed under arduino first.  
wrapper rPNGdec and rTFT\_eWidget are working with PNGdec and TFT\_eWidget libraries installed under arduino.  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
Cpu boards supported  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
TFT\_eSPI library is optimised for the Raspberry Pi Pico (RP2040), STM32, ESP8266 and ESP32.  
  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
TFT chips supported :  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
ILI9341 ST7735 ILI9163 S6D02A1 ILI9486 HX8357D ILI9481 ILI9486 ILI9488 ST7789 ST7789 R61581 RM68140 ST7796 SSD1351 SSD1963 ILI9225 GC9A01  
  
TFT\_Display : 160 x 128 / 320 x 240 / 480 x 320  
TFT\_WIDTH : 80 < 240  
TFT\_HEIGHT : 160 < 320  
  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
TFT\_eSPI configuration :  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
 configuration is done in file <User\_Setup.h> and in a file <User\_Setup\_Select.h> in TFT\_eSPI library directory  
 (in directory TFT\_eSPI\User-Setups\ several User-Setups are available depending of processor board and TFT chip configuration.)  
   
 1)in User\_Setup\_Select.h  
 User\_Setup file is selected and content is depending of your configuration.(CPU and TFT boards)  
 only one lines must be define  
 2)in User\_Setup.h :  
 Section 1. Define the right driver file and any options for your TFT board  
  
 Section 2. Define the CPU board pins that are used to interface with the display  
 define flag to use touch screen  
 #define TOUCH\_CS PIN\_xx // Chip select pin (T\_CS) of touch screen  
 Section 3. Define the fonts by default that can to be used  
 define fonts used by default 1<8  
 #define LOAD\_GLCD // Font 1. Original Adafruit 8 pixel font needs ~1820 bytes in FLASH  
 #define LOAD\_FONT2 // Font 2. Small 16 pixel high font, needs ~3534 bytes in FLASH, 96 characters  
 #define LOAD\_FONT4 // Font 4. Medium 26 pixel high font, needs ~5848 bytes in FLASH, 96 characters  
 #define LOAD\_FONT6 // Font 6. Large 48 pixel font, needs ~2666 bytes in FLASH, only characters 1234567890:-.apm  
 #define LOAD\_FONT7 // Font 7. 7 segment 48 pixel font, needs ~2438 bytes in FLASH, only characters 1234567890:-.  
 #define LOAD\_FONT8 // Font 8. Large 75 pixel font needs ~3256 bytes in FLASH, only characters 1234567890:-.  
 //#define LOAD\_FONT8N // Font 8. Alternative to Font 8 above, slightly narrower, so 3 digits fit a 160 pixel TFT  
 define flag to use FreeFonts   
 #define LOAD\_GFXFF // FreeFonts. Include access to the 48 Adafruit\_GFX free fonts and custom fonts  
 define flag to use smooth fonts  
 #define SMOOTH\_FONT  
 Section 4. Other options  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
this wrapper can handle:  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
 TFT\_eSPI.h  
 extension TFT\_eSPI\_Touch depending of flag #ifdef TOUCH\_CS  
 extension TFT\_eSPI\_SmoothFont depending of flag #ifdef LOAD\_GFXFF  
 extension TFT\_eSprite.h  
 extension TFT\_eSPI\_Button.h  
 extension PNGdec.h (after library and wrapper installation)  
 extension TFT\_eWidget.h (after library and wrapper installation)  
  
 not working in B4R  
 JPEGDecoder.h  
 OpenFontRender.h  
  
more information on this complex library in original site : <https://github.com/Bodmer/TFT_eSPI>  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
GFX Fonts management:  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
 GFX fonts can be managed in 2 ways:  
 ——————————-  
 1) in default configuration 8 fonts are available with parameter font = 1<8  
  
 2) after with <#ifdef LOAD\_GFXFF> added, FreeFonts/GFX/custom Fonts can be used. it give access to the 48 Adafruit\_GFX free fonts and custom fonts.  
 Short naming of font FF1 to FF48 from <Free\_Fonts.h> cannot be used with B4R but after a definition in inline C, each freefonts can be used by an index number 0 < xxx  
  
 example is depending of GFXFF flag :  
 void setFreeFont(byte GFXid); case GFXFF flag on  
 void setTextFont(byte font); case GFXFF flag on  
 void setFreeFont1(byte font); case GFXFF flag off  
 void setTextFont1(byte font); case GFXFF flag off  
  
 in B4R, GFX/FreeFonts declarations are added in B4R script, in inline C part to be selected with a byte  
example for 8 fonts:  

```B4X
#if C  
   const GFXfont * B4R::B4RTFT_eSPI::GFXfonts[7]= {  
       &FreeMono9pt7b,                 // => setFreeFont(00)  
       &FreeSans9pt7b,                 // => setFreeFont(01)  
       &FreeSerif9pt7b,                // => setFreeFont(02)  
       &FreeMonoBold9pt7b,             // => setFreeFont(03)  
       &FreeMonoBoldOblique9pt7b,      // => setFreeFont(04)  
       &FreeMonoOblique9pt7b,          // => setFreeFont(05)  
       &FreeSansBold9pt7b              // => setFreeFont(06)  
   };  
#End If
```

  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
 VLW fonts management:  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
 Anti-aliased fonts in VLW format can be used after loading in 4 ways:  
 - VLW fonts can be loaded by SPIFFS on esp8266 and esp32  
 uint8\_t loadFontLittleFS(B4RString\* fontName);  
 - VLW fonts can be loaded by LittleFS  
 void loadFontFS(B4RString\* fontName);  
 - VLW fonts can be loaded from SD card on esp32  
 uint8\_t loadFontSD(B4RString\* fontName);  
 - 8 VLW fonts can be added in flash in h files, in vlw format converted to C arrays. (h file are added at project in inline C)  
 void loadFontH(byte VLWid);  
 VLW in h files can be loaded after definition in inline C  
 8 VLW fonts can be added by <#define VLW0 font0> to <#define VLW7 font7>:  
 h files must be in directory with rTFT\_eSPI or TFT\_eSPI  
  
example of vlw fonts in h file added in inline C:  

```B4X
#if C  
   #include "NotoSansBold15.h"  
   #include "NotoSansBold36.h"  
      #undef VLW0                                 // with VLW0 to VLW7  
      #define VLW0 NotoSansBold15            // => loadFontH(00)  
      #undef VLW1  
      #define VLW1 NotoSansBold36            // => loadFontH(01)  
#end if
```

  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
PNG files management: case png in a h file  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
 library from: <https://github.com/bitbank2/PNGdec>  
 PNG can be loaded in 3 ways  
 - png can be loaded from memory  
 int16\_t openRAM(ArrayByte\* pData, SubVoid\_DblIntInt pngDrawSub);  
 - png can be loaded from a file LittleFS (esp8266 / esp32)  
 int16\_t open(B4RString\* szFilename, SubVoid\_DblIntInt pngDrawSub);  
 in this case, png must be in LittleFS partition  
 - png can ba loaded from an array in h file  
 int16\_t openFLASH(byte PNGid, SubVoid\_DblIntInt pngDrawSub);  
 in this case, png files must be in directory with rPNGdec or PNGdec  
 h files must be added by #include  
 in inline C, PNG names are included in an array , PNG size are also included in an array  
 acces is done by a PNG number  
 In B4R program, PNG arrays can be loaded with PNGdec from this array with number 0 < 8  
   
example of PNG in h file added in inline C:  

```B4X
#if C  
   #include "SpongeBob.h"  
      const uint8_t* B4R::B4RPNG::PNGfiles[2]= {  
         bob,                 // => openFLASH(00, sizeof(bob),….  
         bob1  
      };  
      const uint32_t B4R::B4RPNG::PNGsize[2]= {  
         sizeof(bob)                 // => openFLASH(00, sizeof(bob),….  
         sizeof(bob1)                // => openFLASH(01, sizeof(bob1,….  
      };  
#Enf If
```

  
  
by 24/02/09, a few modifications added on in TFT\_eSPI, library TFT\_eWidget added  
  
24/08/09 a few corrections from [USER=10954]kkaminski[/USER] tests.