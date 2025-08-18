### SSD1306 Module by Mostez
### 03/02/2021
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/127874/)

I've been working with SSD1306 OLED for long time, in some projects I was in need to add some special fonts and add some graphics or icons like blue tooth symbols. I thought to put all these features in one place and use as needed. I wrote some of my code and utilized some other's code and ideas. This is not my pure coding.  
This module is written for SSD1306 OLED with I2C interface, though it's easily to be modified for similar controllers.  
No special requirements are needed, just the 'wire' library should be installed in Arduino lib folder, to run the full demo you need to add the rESP8266rtc lib to B4R, otherwise you have to comment its related code.  
  
**This module is written for ESP, it should be modified to work with Arduino.**  
Using the module is very easy and the code is straight forward, the best way to learn about it is to follow the demo code, I added comments for help.  
  
**The module has the following features:**  
1- Customized user defined fonts.  
2- Draw full screen or custom size bitmaps.  
3- Pixel set or clear  
4- Draw basic shapes (lines, rectangles, round rectangles, circles) clear function for drawn shape is also available.  
5- Make user defined message boxes  
6- Vertical and horizontal scrolling  
7- Normal or inverted display (full screen or string)  
8- Contrast adjust  
  
**Disadvantges:**  
1- Text can only be displayed at Col Page (0~127 - 0~7) , not at Col Line (0~127 - 0~63)  
2- 'Fill' feature is not available for basic shapes(rectangle, circle)  
  
**Wiring**:  
I Tested the module with **ESP32S board**, so the wiring example is for it  
OLED SCL >> SCL pin 22 on ESP32s board  
OLED SDA >> SDA pin 21 on ESP32s board  
OLED GND >> GND  
OLED VCC >> it should work with both 3.3 or 5V  
  
**Credits and copyright notes:**  
'OLED\_I2C lib, Copyright (C)2015-2019 Rinky-Dink Electronics, Henning Karlsen.  
'Adafruit SSD1306 lib, Written by Limor Fried/Ladyada for Adafruit Industries.  
'Thanks to all members at B4X community for theire great support, especially:  
[USER=52836]@Daestrum[/USER], pass B4R user defined vars to inline C sub  
[USER=34172]@tigrot[/USER], pass B4R array to inline C sub  
[USER=119387]@moty22[/USER], OLED initialization and display image  
[USER=1]@Erel[/USER], providing rAdafruit\_ssd1306 lib, and making this possible with B4R  
  
![](https://www.b4x.com/android/forum/attachments/108937) ![](https://www.b4x.com/android/forum/attachments/108938)  
  
![](https://www.b4x.com/android/forum/attachments/108430) ![](https://www.b4x.com/android/forum/attachments/108431) ![](https://www.b4x.com/android/forum/attachments/108432) ![](https://www.b4x.com/android/forum/attachments/108433) ![](https://www.b4x.com/android/forum/attachments/108434) ![](https://www.b4x.com/android/forum/attachments/108435) ![](https://www.b4x.com/android/forum/attachments/108436) ![](https://www.b4x.com/android/forum/attachments/108437) ![](https://www.b4x.com/android/forum/attachments/108438)