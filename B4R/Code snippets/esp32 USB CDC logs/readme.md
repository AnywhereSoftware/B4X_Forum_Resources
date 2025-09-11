### esp32 USB CDC logs by peacemaker
### 09/08/2025
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/168558/)

Modern Espressif's MCUs esp32 models are with built-in USB bridge UART controller (instead of external USB bridge IC with classical ESP32, CP2102 or CH340… chips).  
And the logs and data exchange in whole depends directly on the config where "USB CDC on boot" must be enabled.  
![](https://www.b4x.com/android/forum/attachments/166616)  
  
But when it is enabled - the MCU at start is waiting for you will establish a USB COM-port connection for going on.  
To disable this waiting i have tried this code:  
  

```B4X
'module esp32_usblog.bas  
'v.1.3  
  
Private Sub Process_Globals  
  
End Sub  
  
Public Sub EnableUSB_CDC_Logs(BaudRate As ULong)  
    RunNative("InitUniversalUSB", BaudRate)  
End Sub  
  
#If C  
#include <Arduino.h>  
// Explicitly include USB.h if compiling for chips with USB CDC  
#ifdef USB  
    #include "USB.h"  
#endif  
  
  
void InitUniversalUSB(B4R::Object* o) {  
    // Activate USB CDC on chips that support it,  note - CONFIG_IDF_TARGET_ESP32C3 is NOT included !  
    #ifdef CONFIG_IDF_TARGET_ESP32S2 || \  
        defined(CONFIG_IDF_TARGET_ESP32S3) || \  
        defined(CONFIG_IDF_TARGET_ESP32C6) || \  
        defined(CONFIG_IDF_TARGET_ESP32H2)  
  
        #ifdef USB  
            USB.begin(); // Start USB stack  
        #endif  
  
    #endif  
  
    //Initialize Serial — it will be USB CDC or UART  
    Serial.begin(o->toLong());  
    Serial.setTimeout(0);  
  
    //Against freezing: wait for Serial no more than 100 ms  
    uint32_t timeout = millis() + 100;  
    while (!Serial && millis() < timeout) {  
        delay(1);  
    }  
}  
#End If
```

  
  

```B4X
Private Sub AppStart  
    esp32_usblog.EnableUSB_CDC_Logs(115200)    'it's instead of Serial1.Initialize(115200) !  
…
```