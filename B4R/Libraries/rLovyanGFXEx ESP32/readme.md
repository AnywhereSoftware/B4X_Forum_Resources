### rLovyanGFXEx ESP32 by rwblinn
### 06/08/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/166606/)

**B4R Library rLovyanGFXEx ESP32  
  
Purpose  
rLovyanGFXEx** is an open source SPI LCD graphics library for selected displays controlled by an ESP32.  
  
**Information**  

- This library is partial wrapped (functions to set text, draw basic shapes and colors) from the [LovyanGFX library](https://github.com/lovyan03/LovyanGFX).
- Enhanced with additional colors, fonts and many functions to set text, the RGB LED and more.
- 24-bit color codes; selected fonts like Font0 [Default], FREEMONO\_12, FREESANS\_12, TOMTHUMB\_1, FREESERIF\_12 and more.
- Touch is enabled (depends on the display).
- Library developed in Arduino C++.
- Software: B4R 4.00 (64 bit), arduino-cli 1.2.2, ESP32 library 3.2.0, LovyanGFX 1.2.7.
- Hardware: Tested with following displays:

- Sunton ESP32 2.8" TFT, w320xh240, touch, driver ILI9341.
- SSD1306 0.96" OLED, I2C w128xh64, monochrome, no touch, pins SCL 22, SDA 21, I2C address 0x3C.
- SH1106 1.3" OLED, I2C w128xh64, monochrome, no touch, pins SCL 22, SDA 21, I2C address 0x3C.
- diymore ESP32-WROOM-32 0.96" OLED, w128xh64, no touch, pins SCL 22, SDA 21, I2C address 0x3C.
- ESP32 WIFIKITV3 SSD1306 0.96" OLED , I2C, w128xh64, no touch, pins SCL 18, SDA 17, PWR 21, I2C address 0x3C.

- ESP32 communicates with the TFT Display and Touchscreen using SPI communication protocol.
- Not wrapped are the classes Sprites (LGFX\_Sprite), Buttons (LGFX\_Button) [not planned to wrap].
- This library has been developed for personal use only.

**Notes**  
The background to develop this library, is using a small TFT display as a [Solar Info Panel](https://www.b4x.com/android/forum/threads/home-assistant-solar-info-panel.166710/#post-1022123) (multi pages touch panel) for the production@home, but of course there are many other use cases.  
This library is a further development of the [rESP3228CYD](https://www.b4x.com/android/forum/threads/resp3228cyd.166140/) library.  
  
**Screenshots for some of the examples**  
![](https://www.b4x.com/android/forum/attachments/163580)  
![](https://www.b4x.com/android/forum/attachments/163391)  
![](https://www.b4x.com/android/forum/attachments/163392)  
  
**Files**  
rLovyanGFXEx-NNN.zip archive contains the library and sample projects.  
  
**Install**  
In the Arduino IDE install the library [LovyanGFX](https://github.com/lovyan03/LovyanGFX) - TFT LCD Graphics driver.  
From the zip archive rLovyanGFXEx-NNN.zip, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.  
  
**Display Driver**  
The library includes three display drivers, which are defined in the header files ESP32\_2432S028.h, ESP32\_SSD1306.h, ESP32\_SSD1306\_WIFIKITV3.h and ESP32\_SH110x. Make changes as required (see source comments).  
  
In the B4R code, the **display driver must be defined (mandatory)** using the Project Attribute #DefineExtra.  

- Sunton ESP32 = #define ESP32\_2432S028
- SSD1306 = #define ESP32\_SSD1306
- SH1106 = #define ESP32\_SH110x
- DIYMOREESP32OLED = #define ESP32\_SSD1306
- ESP32\_SSD1306\_WIFIKITV3.h = #define ESP32\_SSD1306\_WIFIKITV3

Examples setting the display driver in B4R code for the SSD1306:  

```B4X
#Region Project Attributes  
    #DefineExtra: #define ESP32_SSD1306  
#End Region
```

  
  
**Functions**  
See the folder examples, but also the chapter **Get Started** below.  
The folder examples has sub-folders depending the display used: CYD2432S028, DIYMOREESP32OLED, SH110X, SSD1306, SSD1306WIFIKITV3.  
Most of the examples are for the CYD2432S028 display.  
For the SH110x, SSD1306, SSD1306WIFIKITV3 the examples are just the classic Hello World.  
For the DIYMOREESP32OLED. there is an example using the 7-Segment-Font to display a number (max 9999).  
  
**Examples CYD2432S028**  

- HelloWorld-InlineC - Use the native LovyanGFX library with B4R Inline C. To explore how to use the library prior wrapping.
- Touch-InlineC - As previous.
- Touch-InlineC-CallSub - As previous.
- HelloWorld - The classic starter.
- Basic - Show some of the basic functions (see below source).
- Touch - Touch the display and show the touch x,y position.
- Button - Create buttons and showinfo when touched.
- Fonts - List the various fonts, like DEFAULT, FREEMONO\_12, FREESANS\_12, TOMTHUMB\_1, FREESERIF\_12, ORBITRON\_LIGHT\_24 (my fav) and more.
- RGBLED - Control the RGB LED at the back of the device.
- Icons - Define and show simple icons.
- MyShapes - Define and show own defined shapes (B4X code).
- 7-Segment-Display - 7-Segment font.
- HeaderFooter - Header and footer which could be used for pages.
- StopWatch - Stopwatch with 7-segment display and touch buttons.
- Linechart - Simple line chart.
- Gauge - 4 gauges with min, max, actual value.
- MultiPages - Define multiple pages and select via touch.
- Helper - Helper methods (B4X code) to be used in own programs.

**B4R Basic Example**  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 600  
    'Set the display driver (mandatory)  
    #DefineExtra: #define ESP32_2432S028  
#End Region  
  
Sub Process_Globals  
    Private VERSION As String = "rLovyanGFXEx Basic v20250409"  
    Public Serial1 As Serial  
    Private lcd As LovyanGFXEx  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, CRLF, "[AppStart]", VERSION)  
    lcd.Initialize(Null)  
    CallSubPlus("Demo", 500, 5)  
End Sub  
  
Private Sub Demo(tag As Byte)  
    lcd.DisplayRotation = 1  
    lcd.BackgroundColor = lcd.COLOR_WHITE  
    lcd.DrawHeader(VERSION, lcd.FONT_FONT2, lcd.TEXT_ALIGN_CENTER, 1, lcd.COLOR_WHITE, lcd.COLOR_NAVY, lcd.COLOR_RED)  
    lcd.DrawFooter("B4X=great… enjoy", lcd.FONT_FONT2, lcd.TEXT_ALIGN_CENTER, 1, lcd.COLOR_WHITE, lcd.COLOR_NAVY, lcd.COLOR_RED)  
    lcd.FillCircle(30, 30, 15, lcd.COLOR_RED)  
    lcd.FillRoundRect(10, 70, 50, 20, 5, lcd.COLOR_RED)  
   
    ' Set cursor at x,y position  
    Dim x,y As ULong  
    x = 100  
    y = 100  
    lcd.SetCursor(x,y)  
  
    ' Print text in red at cursor position  
    lcd.Font = lcd.FONT_FONT0  
    lcd.SetTextSize(3)  
    lcd.SetTextColor(lcd.ColorRGB(255,0,0))  
    lcd.Print("HELLO")  
  
    ' Print text in white at new cursor position  
    lcd.SetCursor(100,200)  
    lcd.SetTextSize(3)  
    lcd.SetTextColor(lcd.ColorRGB(255,255,255))  
    lcd.Print("World")  
  
    ' Draw blue pixel  
    lcd.DrawPixel(50, lcd.Height / 2 , lcd.COLOR_BLUE)  
  
    ' Draw lines  
    lcd.DrawLine(60, 60, 100, 100, lcd.ColorRGB(255,0,0))  
    'lcd.DrawLine(10, lcd.Height - 20, lcd.Width - 20, lcd.Height - 20, lcd.COLOR_BLUE)  
    lcd.DrawGradientLine(10, lcd.Height - 20, lcd.Width - 20, lcd.Height - 20, lcd.COLOR_RED, lcd.color_BLACK)  
    lcd.DrawWideLine(10, lcd.Height / 2, lcd.Width / 2, lcd.Height / 2, 5, lcd.COLOR_CYAN)  
  
    ' 3-point black Bezier curve  
    lcd.drawBezier3(10, 200, 100, 150, 150, 200, lcd.COLOR_BLACK)  
   
    ' Draw circles  
    lcd.DrawCircle(60, 60, 20, lcd.COLOR_BLUE)  
    'lcd.FillCircle(60, 60, 20, lcd.ColorRGB(255,0,0))  
    'Dim c As ULong = Bit.ParseInt("000000FF", 32)  
    'lcd.FillCircle(60, 60, 20, c)  
    'lcd.FillCircle(150, 150, 20, lcd.COLOR_RED)  
  
    ' Little triangle  
    lcd.fillTriangle(80, 80, 60, 80, 80, 60, lcd.COLOR_YELLOW)  
   
    ' Draw TextBox  
    lcd.DrawTextBox((lcd.Width / 2) - (100 / 2), 30, 100, 40, "INFO", lcd.COLOR_BLACK, 2, lcd.COLOR_WHITE, lcd.COLOR_RED, 4)  
    lcd.DrawTextBoxMultiLIne(200, 80, 100, 130, "Line1", "Line2", "Line3", lcd.COLOR_BLACK, 0, lcd.COLOR_LIGHTGRAY, lcd.COLOR_RED, 4)  
End Sub
```

  
  
**To-Do**  

- Sunton test GPIO to connect peripherals: GPIO 35 (P3 connector), GPIO 22 (P3 and CN1 connector), GPIO 27 (CN1 connector)

**Credits**  

- Developer(s) of the [LovyanGFX](https://github.com/lovyan03/LovyanGFX) library.
- and of course Anywhere Software for providing the B4X suite of development tools plus the B4X community for sharing solutions&hints.

**License**  
GNU General Public License v3.0.  
  
**Hints**  
Some hints gathered during library development using the Sunton ESP32 2.8" TFT Cheap Yellow Display.  
  
**Get Started**  
To get started with the LovyanGFX library, open the Arduino IDE and add the LovyanGFX library (manage libraries).  
Create a new sketch, copy the TFT LCD Display Driver ILI9341 header file "ESP32\_2432S028.h" to the sketch folder location, compile & upload.  
The goal of using the Arduino IDE first prior B4R developments, is to test if the LovyanGFX library is working with the selected hardware.  
Lookup and modify the TFT LCD Display Driver ILI9341 header file "ESP32\_2432S028.h" as required.  
If another device is used, checkout the [LovyanGFX](https://github.com/lovyan03/LovyanGFX) GitHub repository.  
  
After successful use of the library in the Arduino IDE, start with B4R Inline C calling the library functions. If that is working, wrapping the library can begin…  
  
**Arduino CPP Sketch LovyanGFX\_HelloWorld**  
Show the text Hello World.  

```B4X
// LovyanGFX_HelloWorld - Sunton ESP32 2.8" TFT Cheap Yellow Display  
#define LGFX_USE_V1  
#include <LovyanGFX.hpp>  
#include "ESP32_2432S028.h"  
  
LGFX lcd;  
int32_t x;  
int32_t y;  
  
void hello_world()  
{  
  lcd.fillScreen(TFT_WHITE);  
  
  x = lcd.width() / 2;  
  y = lcd.height() / 4;  
  
  // Show text using set cursor and println  
  lcd.setCursor(x, y);  
  lcd.setTextSize(2);  
  lcd.setTextColor(TFT_BLACK);  
  lcd.println("HELLO");  
  
  // Show text using drawString  
  y = lcd.height() / 2;  
  lcd.setTextSize(3);  
  lcd.setTextColor(TFT_RED);  
  lcd.setTextDatum(MR_DATUM);  
  lcd.drawString("WORLD", x, y);  
}  
  
void setup(void)  
{  
  Serial.begin(115200);  
  lcd.init();  
  delay(100);  
  hello_world();  
}  
  
void loop(void)  
{  
  // No tasks  
}
```

  
  
**Arduino CPP Sketch LovyanGFX\_Touch**  
Handle touch > show position.  

```B4X
// LovyanGFX_Touch - Sunton ESP32 2.8" TFT Cheap Yellow Display  
#define LGFX_USE_V1  
#include <LovyanGFX.hpp>  
#include "ESP32_2432S028.h"  
#define MAX_X 319  
#define MAX_Y 239  
  
uint16_t touchX = 0, touchY = 0, touchZ = 0;  
  
static LGFX lcd;  
  
void setup(void) {  
  Serial.begin(115200);  
  lcd.init();  
  lcd.setRotation(1);  
  lcd.fillScreen(TFT_WHITE);  
  delay(100);  
  
  // Show text using drawString  
  lcd.setTextSize(2);  
  lcd.setTextColor(TFT_RED);  
  lcd.setTextDatum(MC_DATUM);  
  lcd.drawString("Touch Example", lcd.width() / 2, lcd.height() / 2);  
}  
  
void loop() {  
  // Listen to touch  
  touchZ = lcd.getTouch(&touchX, &touchY);  
  
  // If panel touched, 1 is returned  
  if (touchZ == 1) {  
  
    // Check touch boundaries  
    if (touchX < 1 || touchX > MAX_X * 2) touchX = 0;  
    if (touchX > MAX_X && touchX < MAX_Y * 2) touchX = MAX_Y;  
    if (touchY < 1 || touchY > MAX_Y * 2) touchY = 0;  
    if (touchY > MAX_Y && touchY < MAX_Y * 2) touchY = MAX_Y;  
  
    // Clear the screen  
    lcd.clear(TFT_WHITE);  
  
    // Show touch position @ screen top left  
    lcd.setCursor(10, 10);  
    lcd.setTextSize(1);  
    lcd.setTextColor(TFT_BLACK);  
    lcd.printf("touchX=%d, touchY=%d, touchZ=%d", touchX, touchY, touchZ);  
  
    // Show red dot at touch position  
    lcd.fillCircle( (int32_t) touchX, (int32_t) touchY, (int32_t) 10, TFT_RED);  
  }  
  
  delay(100);  
}
```

  
  
After testing the library with the Ardiuno IDE, test the library with \*\*B4R and Inline C\*\*.  
Next two programs to show Hello World and handle touch events.  
  
**B4R Inline C Hello World**  
Test using the LovyanGFX library direct in B4R code with Inline C.  

```B4X
Sub Process_Globals  
    Private VERSION As String = "LovyanGFX InlineC v20250320"  
    Public Serial1 As Serial  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, CRLF, "[AppStart]", VERSION)  
  
    'Init display without touch  
    RunNative("initDisplay", Null)  
  
    'Call method demo  
    CallSubPlus("Demo", 500, 5)  
End Sub  
  
Private Sub Demo(tag As Byte)  
    RunNative("setHelloWorld", Null)  
End Sub  
  
#If C  
  
#define LGFX_USE_V1  
#include <LovyanGFX.hpp>  
  
// Set the path to the display driver header located in the same folder as the B4R program.  
// The B4R compiled source is in folder Object/src/ and references in b4r_main.cpp  
#include "..\..\ESP32_2432S028.h"  
  
LGFX lcd;  
  
int32_t x;  
int32_t y;  
  
void initDisplay(B4R::Object* o) {  
  
  lcd.init();  
  lcd.setRotation(1);  
  lcd.fillScreen(TFT_WHITE);  
}  
  
void setHelloWorld(B4R::Object* o)  
{  
  lcd.fillScreen(TFT_WHITE);  
  
  x = lcd.width() / 2;  
  y = lcd.height() / 4;  
  
  // Show text using set cursor and println  
  lcd.setCursor(x, y);  
  lcd.setTextSize(2);  
  lcd.setTextColor(TFT_BLACK);  
  lcd.println("HELLO");  
  
  // Show text using drawString  
  y = lcd.height() / 2;  
  lcd.setTextSize(3);  
  lcd.setTextColor(TFT_RED);  
  lcd.setTextDatum(MR_DATUM);  
  lcd.drawString("WORLD", x, y);  
}  
#End If
```

  
  
**B4R Inline C Touch**  
Test using the LovyanGFX library direct in B4R code with Inline C.  

```B4X
Sub Process_Globals  
    Private VERSION As String = "LovyanGFX InlineC Touch v20250320"  
    'Communication  
    Public Serial1 As Serial  
    ' Define the user defined type  
    Type TTouchPosition(x As Int, y As Int)  
    Private TouchPos As TTouchPosition  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, CRLF, "[AppStart]", VERSION)  
    'Init display without touch  
    RunNative("initDisplay", Null)  
    'Start the looper to handle touch  
    AddLooper("LooperTouch")  
End Sub  
  
Private Sub LooperTouch  
    RunNative("getTouch", Null)  
End Sub  
  
Private Sub OnTouch(x As Int, y As Int)    'ignore  
    Log("[OnTouch] x=",x,",y=",y)  
    TouchPos.x = x  
    TouchPos.y = y  
    RunNative("setText", TouchPos)  
End Sub  
  
#If C  
  
#define LGFX_USE_V1  
#include <LovyanGFX.hpp>  
  
// Set the path to the display driver header located in the same folder as the B4R program.  
// The B4R compiled source is in folder Object/src/ and references in b4r_main.cpp  
#include "..\..\ESP32_2432S028.h"  
  
#define MAX_X 319  
#define MAX_Y 239  
  
uint16_t touchX = 0, touchY = 0, touchZ = 0;  
  
static LGFX lcd;  
  
void initDisplay(B4R::Object* o) {  
  
  lcd.init();  
  lcd.setRotation(1);  
  lcd.fillScreen(TFT_WHITE);  
}  
  
void getTouch(B4R::Object* o) {  
  // Listen to touch  
  touchZ = lcd.getTouch(&touchX, &touchY);  
  
  // If panel touched, 1 is returned  
  if (touchZ == 1) {  
  
    // Check touch boundaries  
    if (touchX < 1 || touchX > MAX_X * 2) touchX = 0;  
    if (touchX > MAX_X && touchX < MAX_Y * 2) touchX = MAX_Y;  
    if (touchY < 1 || touchY > MAX_Y * 2) touchY = 0;  
    if (touchY > MAX_Y && touchY < MAX_Y * 2) touchY = MAX_Y;  
  
    // Clear the screen  
    lcd.clear(TFT_WHITE);  
  
    // Show touch position @ screen top left  
    lcd.setCursor(10, 10);  
    lcd.setTextSize(1);  
    lcd.setTextColor(TFT_BLACK);  
    lcd.printf("touchX=%d, touchY=%d, touchZ=%d", touchX, touchY, touchZ);  
  
    // Show red dot at touch position  
    lcd.fillCircle( (int32_t) touchX, (int32_t) touchY, (int32_t) 10, TFT_RED);  
  
    // Call the B4R Sub (note the lowercase)  
    b4r_main::_ontouch(touchX, touchY);  
  }  
  
  delay(100);  
}  
  
void setText(B4R::Object* o) {  
    // Get the defined object  
    _ttouchposition* touchpos = (_ttouchposition *)B4R::Object::toPointer(o);  
  
    // Get data from the object pointer with structure x,y  
    int x = touchpos->x;  
    int y = touchpos->y;  
    char posString[20];  
    sprintf(posString, "%3d,%3d",x,y);  
    lcd.setTextSize(2);  
    lcd.setTextDatum(MC_DATUM);  
    lcd.drawString(posString, x, y);  
}  
#End If
```