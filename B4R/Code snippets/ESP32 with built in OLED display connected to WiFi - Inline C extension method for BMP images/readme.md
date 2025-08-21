### ESP32 with built in OLED display connected to WiFi - Inline C extension method for BMP images by NoNickName
### 06/23/2020
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/119383/)

Further to thread <https://www.b4x.com/android/forum/threads/esp32-with-built-in-oled-display-connected-to-wifi-inline-c.81149/> I extended the example with the following:  
  

```B4X
'***************************  
'***      BOARD TYPE      ***  
'*** ESP32 Dev Module ***  
'***************************  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public Serial1 As Serial  
  
    Private WiFiConnect As ESP8266WiFi  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Delay(1500)  
    Log("AppStart")  
  
  
    WiFiConnect.Connect2(SSID, pwd)  
  
    RunNative("setup", Null)  
    RunNative("cleardisplay", Null)  
    RunNative("drawLogo", Null)  
    RunNative("updatedisplay", Null)  
End Sub  
  
#if C  
#include "SSD1306.h"  
  
   //Initialize the OLED display  
    SSD1306 display(0x3c, 5, 4);  
  
void setup(B4R::Object* unused)  
{  
    display.init();  
    display.flipScreenVertically();  
}  
  
void drawLogo(B4R::Object* unused)  
{  
  
static char image_data_cn[] = {  
  
//your image here  
  
};  
  
  
  
   //display.drawFastImage(x_pos_from_left, y_pos_from_top, x_size, y_size, image_data_cn);  
    display.drawFastImage(0, 10, 128, 25, image_data_cn);  
}  
  
  
void cleardisplay(B4R::Object* unused)  
{  
    display.clear();  
}  
  
void updatedisplay(B4R::Object* unused)  
{  
    display.display();  
}  
  
#End if
```

  
  
Where //your image here you need to paste a byte array, that can be obtained, by converting your monochromatic bmp to an online converter like <https://convertio.co/> .  
You first need to edit your image, convert it to monochrome, rotate it 90° counterclockwise and vertically mirror it (\*), then convert it by selecting convert to Image/XBM and get the file back. It will look something like:  
  

```B4X
static char 1102c3b6b9244c8cc1cc96ee1d071f40DskbkZoCAgeoURVn_bits[] = {  
  0x00, 0xFF, 0x00, 0x00, 0xC0, 0xFF, 0x07, 0x00, 0xF0, 0x03, 0x0F, 0x00,  
  0x78, 0x00, 0x1E, 0x00, 0x3C, 0x00, 0x70, 0x00, 0x0C, 0x00, 0x70, 0x00,  
  0x0C, 0x00, 0x60, 0x00, 0x0E, 0x00, 0xC0, 0x01, 0x07, 0x00, 0xC0, 0x01,  
  0x03, 0x00, 0xC0, 0x01, 0x03, 0x00, 0xC0, 0x01, 0x83, 0xFF, 0x83, 0x01,  
etcetera, etcetera };
```

  
  
Paste the array where //your image here is and voilà.  
Adjust position by changing x\_pos\_from\_left, y\_pos\_from\_top  
Crop image by setting x\_size, y\_size  
  
Someone more proficient than me in C language could extend the method by passing an Array of int(x\_pos\_from\_left, y\_pos\_from\_top, x\_size, y\_size) to the C inline.  
  
(\*) Rotation depends on the orientation of your display in respect to the viewer