### [algorithm] First post. Map a value from one range to another range. The simple way. by max123
### 10/24/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/144391/)

Hi all,  
  
I want create this [algorithm] branch of Code Snippets where I want discuss with users about some useful algorithms which I have used a lot in 20 years of development and have often helped me to save a lot of time and sometime do things not possible in other ways.  
  
Please if create a tematic branch is a problem, inform me and I will remove or place somewhere is not a problem.  
  
Note that this is not only related to B4A, but they are applicable to B4J, B4i, B4R, and any other language as well.  
  
Some of these 'algorithms' are things that every programmer should know, others are only useful in certain situations.  
  
Some are simples, others are more complex. Note that I not played with all, but only certains and on these I will post some Code Snippets, time permitting.  
  
**The purpose of this branch is not only to publish the explanation of some algorithms by applying them to the code (I'm not an engineer, just read and try to apply), but to invite every user to do the same thing, if you have good, reliable algorithms and have used them many times with success, not keep them to yourself, post as I did by specifying [algorithm] in the title of the Code Snippets post, so other users can see and use them.**  
  
What I want discuss with you are:  
  
- **Map** (Map a value from one range to another range in a simple way). I discuss it on this post.  
- **Digital Low-Pass Filter** (Used in situations where you want remove noise from a signal. This can be applied eg. to realtime audio, to remove noise from sensors and more. I used it a lot and works very well, I even apply it in realtime on audio sent to external DAC from ESP8266/ESP32. I always use it to remove ADC noise, it can remove completely any noise from a signal and works much better than averaging values. For electronicians, it works the same way as RC circuit (Resistor + Capacitor). See [Low-Pass filter](https://en.wikipedia.org/wiki/Low-pass_filter)). I discuss it here: <https://www.b4x.com/android/forum/threads/algorithm-digital-low-pass-filter.144946/>  
- **PID Control** (This can be used in certain situations when we want a certain value stay in the range we decided, eg. this is largely used to stabilize a drone, to stabilize a certain temperature using a temperature sensor as feedback and more. See [PID Control](https://en.wikipedia.org/wiki/PID_controller))  
- **Bresenham's Line Algorithm** (This is used eg. to calculate points in a line on a screen, I used this to do linear interpolation on 3D Printers and CNC machines using stepper motors. See [Bresenham](https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm)). I discuss it here: <https://www.b4x.com/android/forum/threads/algorithm-bresenham-line-algorithm-linear-interpolation.145218/#post-920459>  
- **Kalman Filter** (this is a real complex algorithm I never used, but I want to know, maybe some peoples used it ? See [Kalman Filter](https://en.wikipedia.org/wiki/Kalman_filter))  
  
Many thanks to **Wikipedia** (The free encyclopedia) for great detailed explanations.  
  
————————————————————————————————————————–  
  
Starting from my list, today I want discuss about map values from one range to another range in a simple way. This is not a true algorithm but helped me a lot to save time.  
This mimic the Arduino Map function. See <https://www.arduino.cc/reference/en/language/functions/math/map/>  
  
The simple code I wrote (just taken from the link Appendix) worked well, better than original Arduino map(), it return right values even where map() sometime fails, expecially when map negative or floating point values. Arduino map() function uses integer math so will not generate fractions, when the math might indicate that it should do so. Fractional remainders are truncated, and are not rounded or averaged. My **MapFloat** and **MapDouble** implementations calculate and return fractional values without rounded and truncated values, I want suggest you to use these even on Arduino C++ and B4R side instead of map() function.  
  
From Arduino reference:  
**The map() command  
function uses integer math so will not generate fractions, when the math might indicate that it should do so.  
Fractional remainders are truncated, and are not rounded or averaged.**  
  
Because it worked with better results, I always use it on Arduino side instead of original map() function. It is two+ times faster and more precise.  
  
Here need a precisation, I use it on ESP8266 and ESP32 that have 32 bit MCU, probably on an 8 bit Arduino the floating point math slow down. I never tried because I do not have Arduino to try, I have one but actually is wired on my CNC machine controller. If you have an 8 bit Arduino like Uno, Mega and so… you can try yourself and test the elapsed time calling a function in a long loop that repeat eg 1.000.000 times and compare the same loop using map(). If you try it maybe post here results.  
  
If floating point is a problem we can just use the one that use integer math, like MapByte, MapInt, MapShort, MapLong.  
  
This can be improved because use slow divisions but the speed is acceptable, I never had problems.  
  
For sure this can be improved and optimized in speed, if you think have a best solution, please feel free to post here your best solution.  
  
Because B4X cannot override methods, I created more than one sub to map values from/to a range.  
Personally I wrapped these subs inside a small class and compiled as library because I use it a lot on my projects.  
I wanted release this library (named Mapper for B4A and jMapper for B4J) but because it is really small and very simple code I just  
post the code here. Use it as you like.  
  
Here the code to remap values:  

```B4X
'***********************************************************************  
  
'Re-maps a Byte number from one range to another.  
Sub MapByte(Value As Byte, fromLow As Byte, fromHigh As Byte, toLow As Byte, toHigh As Byte) As Byte  
    Return ( (Value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow) + toLow )  
End Sub  
  
'Re-maps a Short number from one range to another.  
Sub MapShort(Value As Short, fromLow As Short, fromHigh As Short, toLow As Short, toHigh As Short) As Short  
    Return ( (Value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow) + toLow )  
End Sub  
  
'Re-maps a Integer number from one range to another.  
Sub MapInt(Value As Int, fromLow As Int, fromHigh As Int, toLow As Int, toHigh As Int) As Int  
    Return ( (Value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow) + toLow )  
End Sub  
  
'Re-maps a Long number from one range to another.  
Sub MapLong(Value As Long, fromLow As Long, fromHigh As Long, toLow As Long, toHigh As Long) As Long  
    Return ( (Value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow) + toLow )  
End Sub  
   
'Re-maps a Float number from one range to another.  
Sub MapFloat(Value As Float, fromLow As Float, fromHigh As Float, toLow As Float, toHigh As Float) As Float  
    Return ( (Value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow) + toLow )  
End Sub  
  
'Re-maps a Double number from one range to another.  
Sub MapDouble(Value As Double, fromLow As Double, fromHigh As Double, toLow As Double, toHigh As Double) As Double  
    Return ( (Value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow) + toLow )  
End Sub  
  
' Simple example usages:  
Dim intNum As Int = MapInt(ValueToMap, 0, 5000, 0, 100)  ' Map a value from 0-5000 to a range 0-100  
intNum = MapInt(ValueToMap, 5000, 0, 0, 100)  ' Map a value in reverse order, from 5000-0 will be mapped to 0-100  
intNum = MapInt(ValueToMap, -3400, 200, 500, 1600) ' Map a value from -3400-200 to a range 500-1600  
Dim doubleNum = MapDouble(ValueToMap, 0, 1000, 0, 1)  ' Map a double value from a range 0-1000 to a range 0-1  
doubleNum = MapDouble(ValueToMap, 157.36, -62.44, -80.32, 144.24) '  … and more …  
  
' Note that values you pass not necessary has to be the same format, eg in this last example you  
' can pass a Byte, Short, Int, Long, Float, B4X as you know will automatically convert for you.  
  
'***********************************************************************
```

  
  
In the next [algorithm] Code Spippets I will discuss about Digital Low-Pass Filter you can use to remove noise from audio signal or sensor read like accelerometer, gyroscope etc.  
  
Feel free to comment.  
Have fun !!!  
  
EDIT:  
  
These functions in general are faster than Arduino map command and produce best results expecially when use negative numbers.  
Sometime Arduino map function failed and this seem do not happen here.  
For this reasons even on Arduino environment I always use my functions when use Arduino, ESP8266, ESP32, Raspberry Pico, RP2040 in general.  
  
Here an inline simple speed test where I test 5.000.000 calls using Arduino map compared with mapDouble (that is same) , mapFloat, and mapInt  
that is a bit faster and can be used with integer values. You can try it yourself.  
  
The test was done on ESP32 Arduino Core 2.0.6 using ESP32 32 bit at normal CPU speed 240 Mhz.  
Next when I have some time I will try to compare these results on ESP8266 and other devices.  
  

```B4X
   float floatNumber;  
   for (int n = 0; n < 10; n++) { // Repeat 10 times so we ensure result validity  
      uint32_t start = millis();  
      for (int i = 0; i < 5000000; i++) {  
         floatNumber = mapFloat  (i, 0, 5000000, 0, 8400);  
         if (i % 5000 == 0) yield();  // Required on ESP8266 to reset watchdog timer  
      }  
      uint32_t elaps = millis() - start;  
      Serial.printf ("mapFloat require %lu ms\n", (long unsigned int)elaps);  
   }  
  
   //   Embedded Arduino map require 1105 ms  
   //   mapDouble require 465 ms  
   //   mapFloat require 465 ms  
   //   mapInt require 402 ms
```