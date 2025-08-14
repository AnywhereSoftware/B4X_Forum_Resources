B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
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
	  esp_sleep_enable_ext1_wakeup(ext1_mask, ESP_SLEEP_EXT1_WAKEUP_ANY_HIGH);
  #endif

  // going To Deep Sleep
  esp_deep_sleep_start();
 }
#end if