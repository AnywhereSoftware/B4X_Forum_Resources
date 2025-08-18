### 7 segment display (with dots) by derez
### 11/02/2020
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/123859/)

Following Kevins post here <https://www.b4x.com/android/forum/threads/tm1637-7-segment-4-digit-led-display-not-working.93929/post-594225> and finding myself with similar problem, I wrote some inline c code to control the display.  
Sorry to say, I still can't get the dots to light :(  
I used the display for a night clock:  
![](https://www.b4x.com/android/forum/attachments/102035)  
  
Using the library mentioned by Kevin in the post above I have found that Arduino UNO, NANO, ESP32 (WEMOS or ESP32S) compile and show on the display, while ESP8266, nodemcu and LGT8F328P don't. Accordingly I could use either ESP32 (display and wifi) or NANO (display)+ Nodemcu (wifi).  
The following code is used for the clock:  

```B4X
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("appstart")  
  
  
    RunNative("begin", Null)  
    Light = 20  
    RunNative("setbacklight", Null)  
    RunNative("setcolon", Null)  
  
    RunNative("printtxt", Null)  
    …  
End Sub  
  
Sub print_at(num As UInt, place As UInt)  
    Number = num  
    Position = place  
    RunNative("setcursor", Null)  
    RunNative("print", Null)  
End Sub  
  
Sub showtime  
    If hour = 0 Then  
        print_at( minute + 1000, 0)  
      
        Raw = 0x0  
        Position = 0  
        RunNative("printRaw", Null)  
  
    else if hour < 10 Then  
        print_at(hour * 100 + minute, 1)  
  
        Raw = 0x0  
        Position = 0  
        RunNative("printRaw", Null)  
  
    Else  
        print_at(hour * 100 + minute, 0)  
  
    End If  
End Sub  
  
  
#if c  
  
// include the SevenSegmentTM1637 library  
#include "SevenSegmentTM1637.h"  
const byte PIN_CLK = 5;   // define CLK pin (any digital pin)  
const byte PIN_DIO = 6;   // define DIO pin (any digital pin)  
SevenSegmentTM1637    display(PIN_CLK,  PIN_DIO);  
  
void begin (B4R::Object* o) {  
   display.begin();  
}  
  
void print (B4R::Object* o) {  
   //lower case variables  
      display.print(b4r_main::_number);  
}  
  
void printtxt (B4R::Object* o) {  
//    display.print(b4r_main::_txt) ;  
      display.print("____");  
}  
  
void setcolon (B4R::Object* o) {  
      display.setColonOn(1);  
}  
  
void clear (B4R::Object* o) {  
   display.print("    ");  
}  
  
void setbacklight (B4R::Object* o) {  
   display.setBacklight(b4r_main::_light);  
}  
  
void printRaw (B4R::Object* o) {  
   display.printRaw(b4r_main::_raw, b4r_main::_position);  
}  
  
void setcursor (B4R::Object* o) {  
   display.setCursor(0, b4r_main::_position);  
}  
  
#end if
```

  
  
I don't know how to pass a string to this function (the commented line) , if someone can teach me I'll appreciate ! Until then, only predefined strings can be displayed with this code.  

```B4X
void printtxt (B4R::Object* o) {  
//    display.print(b4r_main::_txt) ;  
      display.print("____");  
}
```

  
  
In the h file of the library there is a list of all RAW codes for the various characters.