### rArduinoLEDMatrix by rwblinn
### 08/27/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/171917/)

**B4R Library rArduinoLEDMatrix**  
  

---

  
  
**Brief  
rArduinoLEDMatrix** is an open-source library wrapper for the built-in 12x8 LED Matrix on the **Arduino UNO R4 WiFi board**, specifically optimized for high-performance 2D rendering, native text scrolling, and vector geometric shapes.  
  

---

  
  
**Purpose**  

- Provides a high-level B4R abstraction layer for the native Renesas RA4M1 hardware matrix.
- Integrates seamless vector line, rectangle, and circle drawing loops with automatic canvas clearing.
- Exposes built-in factory flash memory icons using professional uppercase constant syntax.
- Enables smooth, speed-regulated horizontal text scrolling via the ArduinoGraphics core framework.

---

  
  
**Development Info**  
This B4R library is:  

- An [Arduino\_LED\_Matrix](http://arduino.cc) and ArduinoGraphics library wrapper.
- Written in C++ using Arduino IDE 2.3.10 and the *B4Rh2xml* / *XMLTool* parsing pipeline.
- Depends on (minimum version) the platform Arduino UNO R4 Boards (1.6.0) and native libraries Arduino\_LED\_Matrix (2.3.8+) and ArduinoGraphics (1.1.5+).
- Tested with Arduino UNO R4 WiFi (32-bit Renesas RA4M1 architecture, 5V logic).
- Tested with B4R 4.00 (64-bit).
- **Not supported:** Animations.

---

  
  
**Screenshots**  
Arduino UNO R4 WiFi onboard 12x8 LED Matrix display, powered directly via the USB-C interface.  
![](https://www.b4x.com/android/forum/attachments/173175)  
  

---

  
  
**Compatibility**  

- Supports boards based on the Arduino UNO R4 architecture featuring the 12x8 Charlieplexed LED matrix array.

---

  
  
**Files**  
The *rArduinoLEDMatrix.zip* archive contains the compiled library assets (.h, .cpp, .xml) and multiple usage examples.  

---

  
  
**Install**  
Copy the *rArduinoLEDMatrix* library folder from the ZIP into your B4R **Additional Libraries** folder, keeping the directory structure intact.  
*Ensure* the core underlying ArduinoGraphics library is installed using your Arduino IDE libraries manager first.  
Several examples can be found in the folder *examples*.  
  

---

  
  
**Functions**  

- **Initialize**
Initializes the LED matrix peripheral and fires up the background multiplexing hardware driver.- **SetPixel (X As Byte, Y As Byte, TurnOn As Byte)**
Toggles a single isolated pixel coordinate. X ranges from 0 to 11 (left to right), Y ranges from 0 to 7 (top to bottom). Set TurnOn to 1 to illuminate, 0 to turn off.- **Clear**
Wipes the internal frame representation buffer instantly, turning off all matrix lines.- **DrawFrame (FrameData() As Byte)**
Draws a full custom frame on the screen using a flattened 1D B4R byte array containing exactly 96 elements (8 rows \* 12 columns).- **PrintText (Text As String, X As Int, Y As Int, Direction As Byte, ScrollSpeedMS As ULong)**
Renders strings using the native vector-graphics engine.

- X, Y: Starting coordinate anchors (use 0, 1 for centered scrolling text).
- Direction: 0 = Static Text, 1 = Scroll Left, 2 = Scroll Right.
- ScrollSpeedMS: Scrolling pacing animation delay in milliseconds (e.g., 50 to 100).

- **DrawLine (X1 As Int, Y1 As Int, X2 As Int, Y2 As Int, TurnOn As Byte)**
Draws a sharp vector line between two coordinates. Wipes previous canvas elements before drawing.- **DrawRect (X As Int, Y As Int, Width As Int, Height As Int, TurnOn As Byte)**
Draws an empty bounding rectangle layout framework on the display grid.- **DrawCircle (X As Int, Y As Int, Radius As Int, TurnOn As Byte)**
Draws an empty geometric circle perimeter centered around focal location coordinate (X, Y).- **LoadFrame (FrameAddress As ULong)**
Loads an official, factory pre-defined stock icon asset from flash memory into the background rendering register via its direct memory address pointer mapping.- **ScrollText (Text As String, SpeedMS As ULong)**
A custom software text scrolling implementation that shifts an uppercase text string from right to left using local bit-shifting logic frames synchronously.

---

  
**Constants (Property Getters)**  
The following read-only public property methods provide clean autocomplete matching the factory image tokens inside the core gallery.h firmware:  

- **ICON\_BLUETOOTH As ULong** - Bluetooth logo
- **ICON\_BOOTLOADER\_ON As ULong** - Bootloader active symbol
- **ICON\_CHIP As ULong** - Integrated circuit microchip icon
- **ICON\_CLOUD\_WIFI As ULong** - Wi-Fi cloud networking symbol
- **ICON\_DANGER As ULong** - Warning/Alert triangular exclamation mark
- **ICON\_EMOJI\_BASIC As ULong** - Standard smiley face
- **ICON\_EMOJI\_HAPPY As ULong** - Large smiling grin emoji
- **ICON\_EMOJI\_SAD As ULong** - Frowned sad face emoji
- **ICON\_HEART\_BIG As ULong** - Large heart symbol
- **ICON\_HEART\_SMALL As ULong** - Smaller localized heart layout
- **ICON\_LIKE As ULong** - Thumbs-up review confirmation icon
- **ICON\_MUSIC\_NOTE As ULong** - Musical eighth-note icon

---

  
  
**Example**  

```B4X
Sub Process_Globals  
    Private VERSION As String = "rArduinoLEDMatrix Basic v20260827"  
    ' Communication  
    Public Serial1 As Serial  
    ' Matrix  
    Private Matrix As ArduinoLEDMatrix  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "[AppStart] ", VERSION)  
    ' Matrix init and clear  
    Matrix.Initialize  
    Matrix.Clear  
    
    ' Display a native stock emoji constant frame  
    Log("Loading stock emoji icon…")  
    Matrix.LoadFrame(Matrix.ICON_EMOJI_HAPPY)  
    Delay(2000)  
    
    ' Clear canvas and draw a vector geometric circle  
    Log("Drawing vector circle shape…")  
    Matrix.Clear  
    Matrix.DrawCircle(5, 3, 3, 1) ' Centered at X=5, Y=3 with 3px Radius  
    Delay(2000)  
    
    ' Trigger a hardware-accelerated text scroll loop  
    Log("Streaming vector text scroll sequence…")  
    Matrix.Clear  
    Matrix.PrintText(" B4R UNO R4 WI-FI ", 0, 1, Matrix.TEXT_SCROLL_LEFT, 500)  
End Sub
```

  
  

---

  
  
**Troubleshooting**  

- Text Artifacts ("|"): Ensure you pass Direction = 0 only when intending to print static text frames. The internal engine auto-appends newline structural padding to drop border errors cleanly.
- ArduinoGraphics Include Order: If manually editing source architectures, ArduinoGraphics.h must always be declared before Arduino\_LED\_Matrix.h or compilation throws a token error.
- Memory Clear: Geometric objects automatically wipe out previous frames using a structural context layout refresh. Call Matrix.Clear manually if transitioning between custom flat arrays or vector loops.

---

  
  
**License**  
MIT License - see LICENSE file.  
  

---

  
  
**Credits**  

- Developers & maintainers of the official Arduino [UNO R4 Core Architecture Framework](http://github.com) and native vector display libraries.

---

  
**Disclaimer**  

- All product names, logos, and brands are property of their respective owners.