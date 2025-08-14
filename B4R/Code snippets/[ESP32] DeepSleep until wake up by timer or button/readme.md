### [ESP32] DeepSleep until wake up by timer or button by peacemaker
### 07/07/2025
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/167482/)

Code for sending ESP32-family MCU into DeepSleep.  
And checking the waking up by the counter saved into RTC-memory between sleep and wakes up.  
  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    
End Sub  
  
Public Sub Go_Sleep(ms As ULong)  
    Log("Go deep sleep for ", ms, " msecs")  
    Delay(1)  
    esp32_DeepSleep(ms)  
End Sub  
  
Private Sub esp32_DeepSleep(ms As ULong)  
    RunNative("deepSleep", ms)  
End Sub  
  
#if C  
#include <esp_sleep.h>  
#include <driver/rtc_io.h>  
  
#define BUTTON_PIN GPIO_NUM_0  
  
void deepSleep(B4R::Object* o) {  
  // wake up by timer (msec)  
  uint64_t sleep_time_us = o->toULong() * 1000;  
  if(sleep_time_us > 0) {  
    esp_sleep_enable_timer_wakeup(sleep_time_us);  
  }  
   
  #ifdef CONFIG_IDF_TARGET_ESP32  
      // ESP32: use EXT0 (just single pin)  
      esp_sleep_enable_ext0_wakeup(BUTTON_PIN, LOW);  
  #elifdef defined(CONFIG_IDF_TARGET_ESP32S2) || defined(CONFIG_IDF_TARGET_ESP32C3) || defined(CONFIG_IDF_TARGET_ESP32S3)  
      // ESP32-S2 / C3 / S3: use EXT1 (pins mask)  
      uint64_t ext1_mask = 1ULL << BUTTON_PIN;  
      //esp_sleep_enable_ext1_wakeup(ext1_mask, ESP_SLEEP_EXT1_WAKEUP_ANY_LOW);    OLD !  
      esp_deep_sleep_enable_gpio_wakeup(ext1_mask, ESP_GPIO_WAKEUP_GPIO_LOW);  
  #endif  
  
  // going To Deep Sleep  
  esp_deep_sleep_start();  
 }  
#end if
```

  
  

```B4X
'esprtc_livecounter module name  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public LiveCounter As ULong  
End Sub  
  
Sub Read_livecounter  
    RunNative("rtccount", Null)  
    Log("LiveCounter = " , LiveCounter)  
    'testing  
    Delay(2000)  
    others.Go_Sleep(2000)    'RunNative("esprestart", Null)  
End Sub  
  
  
#if C  
static RTC_NOINIT_ATTR ulong counter = 0;  
  
void rtccount(B4R::Object* u) {  
esp_reset_reason_t reason = esp_reset_reason();  
if ((reason != ESP_RST_DEEPSLEEP) && (reason != ESP_RST_SW))  
{  
  counter = 0;  
}  
counter++;  
b4r_esprtc_livecounter::_livecounter = counter;  
}  
  
void esprestart(B4R::Object* u) {  
esp_restart();  
}  
  
#end if
```

  
  
Result of the looped sleeps and wakes (manual COM-port connecting is required after each wake, [USER=1]@Erel[/USER] , maybe checkbox option for "auto re-connecting" ?):  
  
> Writing at 0x000513be… (100 %)  
> Wrote 297936 bytes (161659 compressed) at 0x00010000 in 2.3 seconds (effective 1040.5 kbit/s)…  
> Hash of data verified.  
> Leaving…  
> Hard resetting with RTC WDT…  
> New upload port: COM13 (serial)  
> AppStart  
> LiveCounter = 1  
> Go deep sleep for 2000 msecs  
> AppStart  
> LiveCounter = 2  
> Go deep sleep for 2000 msecs  
> AppStart  
> LiveCounter = 3

  
NOTE: #ifdef does not work inside Inline-C ! No solution yet.