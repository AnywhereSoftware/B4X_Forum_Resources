### Benchmark of Microcontrollers by hatzisn
### 12/05/2022
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/144624/)

Good afternoon everyone,  
  
Today I woke up and I was not in a mood to work so I decided to mesh around creating benchmarks for my microprocessors.  
I created thus this code which needs the rESP32CAM.b4xlib to work. You can find the library in this thread. The code follows:  
  
<https://www.b4x.com/android/forum/threads/esp32cam-print-logs-workaround-b4xlib-included.143731/>  
  
It counts 200 cycles and logs the mean time between two cycles (in Millis). The results are the following:  
  

```B4X
ESP8266 No WiFi             0.01  
ESP8266 With WiFi           0.02  
Arduino NANO old            0.03  
Arduino Mega 2560           0.03  
Arduino UNO                 0.03  
ESP32CAM (WiFi+MQTTLogs)    0.14
```

  
  
  
The project is attached. The project has three compilation conditional symbols (ESP32CAM, ESP8266 and GENERAL\_ARDUINO).