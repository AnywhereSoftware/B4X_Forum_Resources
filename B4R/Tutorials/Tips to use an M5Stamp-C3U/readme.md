### Tips to use an M5Stamp-C3U by thali
### 03/29/2023
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/147108/)

It's a very small and quite powerful ESP32-board with WIFI/BLE and B4R support!  
  
Use following board library in the Arduino-IDE in 'Settings':  
 <https://m5stack.oss-cn-shenzhen.aliyuncs.com/resource/arduino/package_m5stack_index.json>  
Do not use any other board library that includes the same board: 'STAMP-C3'!  
  
To **debug** your program with log output, you need to inititialize Serial1 with 115000 baud and connection to the USB port.  
In the B4R-IDE you must set the board parameter 'CDCnBoot' to 'cdc'.  
  
When using M5Stamp in **operation mode** without USB connection, powered by 5V, the board parameter 'CDCnBoot' must be set to 'default'   
Also disable any log output, otherwise your program get stuck!  
  
Your program may also get stuck when sending commands to the onboard-LED with Freenove\_WS2812\_Lib\_for\_ESP32 without any delay(of ca. 100ms) between!  
  
May this save you wasted time ;)