### MCUs comparison 2023 by peacemaker
### 10/24/2023
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/156789/)

One popular MCU programmer made an YouTube stream with online testing and comparing the MCUs.  
1. pin out high  
2. make a test operation: a + b, a - b, a \* b, a / b, sin(a), power(a, b), power(b, a), log(a), sqrt(a)  
3. pin out = low  
  
And measuring the execution time between the signal edges by the oscilloscope.  
[SPOILER="Screenshots"]  
![](https://www.b4x.com/android/forum/attachments/147122)  
![](https://www.b4x.com/android/forum/attachments/147123)  
[/SPOILER]  
  
![](https://www.b4x.com/android/forum/attachments/147138)  
  
First column Tio = min time of the pulse without any operation between, it will be subtracted from all test timings.  
  
![](https://www.b4x.com/android/forum/attachments/147139)  
![](https://www.b4x.com/android/forum/attachments/147140)  
Latest table - the Flops per megahertz MCU clock frequency.  
  
ATmega328 - oldest and slowest, 8-bit one.  
ESP all families - very slow switching ports.  
ESP32 - is with very unstable timings, jitter all the time (small wobbling of the operation execution time).  
RP2040 - modern, but not good.  
ESP32-S2 - modern, but … old classic ESP32 is much faster, and old ESP8266 is not so worse.  
STM32G4 - modern, best, but just a bit faster than classic ESP32.  
And STM32G4 with switched off FPU - is anyway better than RP2040.  
ESP32-C3 - RISC-V MCU is also not good, like RP2040, the old ESP8266 is sometimes even better.  
sin(a) and sinf(a) = the same results.  
power(a, b) - execution time depends on the a and b. It's more fast if a < b.  
  
RP2040 in Arduino (comparing the native its SDK) is even more slow - like ATmega328.  
  
![](https://www.b4x.com/android/forum/attachments/147143)  
  
p.s. ESP and RP2040 IO operation speed: it looks like the Arduino makes port switching of any MCU very slow.