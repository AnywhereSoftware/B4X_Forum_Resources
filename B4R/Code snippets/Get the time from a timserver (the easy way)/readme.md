### Get the time from a timserver (the easy way) by KMatle
### 02/01/2022
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/138106/)

Note: The ESP must be connected to the internet (e.g. WiFi)  
  
  
  

```B4X
Sub GetTime  
    RunNative("GetTime", Null)  
End Sub  
  
#if c  
  
#include "time.h"  
void GetTime (B4R::Object* o) {  
  
    const char* ntpServer = "pool.ntp.org";  
    const long  gmtOffset_sec = 3600;  
    const int   daylightOffset_sec = 3600;  
  
    configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);  
  
    struct tm timeinfo;  
      if(!getLocalTime(&timeinfo)){  
        Serial.println("Failed to obtain time");  
          
      }  
    else  
    {  
          Serial.println(&timeinfo, "%A, %B %d %Y %H:%M:%S");  
    }  
   
}  
  
#End If
```