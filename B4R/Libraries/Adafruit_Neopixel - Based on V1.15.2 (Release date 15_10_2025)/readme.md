### Adafruit_Neopixel - Based on V1.15.2 (Release date 15/10/2025) by Peter Simpson
### 02/01/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/170173/)

Hello Everyone,  
I wanted a few extra functions in the Adafruit Neopixel libraries on the forum, so instead of editing one of them and adding the functions, I decided to rewrap the latest [Adafruit NeoPixel Library](https://github.com/adafruit/Adafruit_NeoPixel) on Github. Another reason why I wrapped this library was because I thought that I was having issues with the current libraries, which in fact turned out to be a simple coding error on my behalf :rolleyes:  
Anyway, I added some extra functions that might come in handy for B4R developers.  
  
**B4R library tab**  
![](https://www.b4x.com/android/forum/attachments/169621)  
  
**3 IDE build options in example**  
![](https://www.b4x.com/android/forum/attachments/169619)  
  
**Animation included in example**   
![](https://www.b4x.com/android/forum/attachments/169628)  
  
**Animation included in example**  
![](https://www.b4x.com/android/forum/attachments/169620)  
  
**rAda\_NeoPixel  
  
Author:** Peter Simpson  
**Version:** 1.15  

- **Ada\_NeoPixel**
*Wrapper for Adafruit NeoPixel (WS2812 / WS2812B) LED strips and matrices.  
 Provides pixel‑level control, brightness management, and colour helpers.*

- **Functions:**

- **AnimatePixelColor** (Start As UInt, Finish As UInt, Colour As ULong, Delay As UInt)
*Animates a pixel sequence from Start to Finish.  
 Start The first pixel index.  
 Finish The last pixel index.  
 Colour The packed colour value.  
 Delay Time each pixel stays lit (ms).*- **Begin**
*Prepares the NeoPixel driver for operation.  
 Must be called after Initialize before any pixel updates.*- **Clear**
*Clears the internal pixel buffer (sets all LEDs to off).  
 Call Show afterwards to apply the change to the LEDs.*- **Fill** (Colour As ULong, First As UInt, Count As UInt)
*Fills a range of pixels with a single packed colour.  
 Colour The packed colour value.  
 First The starting pixel index.  
 Count The number of pixels to fill.*- **GetBrightness** As Byte
*Returns the current global brightness level.  
 Returns A value between 0 and 255.*- **GetNumPixels** As UInt
*Returns the number of pixels configured during Initialize().*- **GetPixelColor** (Index As UInt) As ULong
*Returns the packed 32‑bit colour value of a pixel.  
 Index The pixel index (0‑based).  
 Returns The packed colour value.*- **Initialize** (NumberOfPixels As UInt, Pin As Byte, PixelType As ULong)
*Initialises the NeoPixel strip or matrix.  
 NumberOfPixels The total number of LEDs in the strip or matrix.  
 Pin The GPIO pin used for the NeoPixel data line.  
 PixelType The pixel format flags such as NeoGRB + NeoKHZ800.*- **MovePixel** (From As UInt, To As UInt)
*Moves a pixel from one index to another.  
 From The source pixel index.  
 To The destination pixel index.*- **Neo\_GRB** As ULong
*Returns the GRB colour order flag.  
 Use this for WS2812B and most modern NeoPixel strips.*- **Neo\_KHZ400** As ULong
*Returns the 400 KHz timing flag.  
 Used by older WS2811‑based strips.*- **Neo\_KHZ800** As ULong
*Returns the 800 KHz timing flag.  
 Required for WS2812 / WS2812B LEDs.*- **Neo\_RGB** As ULong
*Returns the RGB colour order flag.  
 Used by some older or non‑standard LED strips.*- **SetBrightness** (Brightness As Byte)
*Sets the global brightness level.  
 Brightness A value from 0 (off) to 255 (maximum brightness).  
 Note: This does not modify stored pixel colours.*- **SetPixelColor** (Index As UInt, Red As Byte, Green As Byte, Blue As Byte)
*Sets the RGB colour of a single pixel.  
 Index The pixel index (0‑based).  
 Red The red component (0‑255).  
 Green The green component (0‑255).  
 Blue The blue component (0‑255).*- **SetPixelColorPacked** (Index As UInt, Colour As ULong)
*Sets a pixel using a packed 32‑bit colour value.  
 Index The pixel index (0‑based).  
 Colour The packed colour created by Color() or ColorW().*- **SetPixelColorW** (Index As UInt, Red As Byte, Green As Byte, Blue As Byte, White As Byte)
*Sets the RGBW colour of a single pixel.  
 Index The pixel index (0‑based).  
 Red The red component (0‑255).  
 Green The green component (0‑255).  
 Blue The blue component (0‑255).  
 White The white component (0‑255) for RGBW strips.*- **SetRGB** (Red As Byte, Green As Byte, Blue As Byte) As ULong
*Creates a packed RGB colour value.  
 Red The red component (0‑255).  
 Green The green component (0‑255).  
 Blue The blue component (0‑255).*- **Show**
*Sends the internal pixel buffer to the LEDs.  
 Call this after modifying pixel colours to update the display.*
  
**Enjoy…**