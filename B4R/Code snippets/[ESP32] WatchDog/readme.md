### [ESP32] WatchDog by peacemaker
### 08/05/2023
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/149346/)

```B4X
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Private timWDTfeeder As Timer  
End Sub  
  
Sub Start(timeout_millis As Int)  
    Dim gap As Int = 50  
    '———hardware WDT———–  
    If timeout_millis < gap Then  
        timeout_millis = timeout_millis + gap  
    End If  
    timWDTfeeder.Initialize("timWDTfeeder_Tick", (Min(500, (timeout_millis/2)))  
    'timWDTfeeder.Enabled=True    'comment this line to test rebooting MCU !!!  
    RunNative("setup", (timeout_millis/1000))  
End Sub  
  
Sub Stop  
    RunNative("wdt_stop", Null)  
    timWDTfeeder.Enabled = False  
    Log("Watchdog is disalarmed")  
End Sub  
  
Private Sub timWDTfeeder_Tick  
    RunNative("wdt_reset", Null)  
    Log("Watchdog is fed up")  
End Sub  
  
#if c  
#include <esp_task_wdt.h>  
  
void setup(B4R::Object* o) {  
  Serial.println("Configuring WDT…");    
  esp_reset_reason_t reason = esp_reset_reason();  
    if ((reason == ESP_RST_INT_WDT)) Serial.println("Was restarted due to ESP_RST_INT_WDT");  
    if ((reason == ESP_RST_TASK_WDT)) Serial.println("Was restarted due to ESP_RST_TASK_WDT");  
    if ((reason == ESP_RST_WDT)) Serial.println("Was restarted due to ESP_RST_WDT");   
    
  esp_task_wdt_init(o->toLong(), true); //enable panic so ESP32 restarts  
  esp_task_wdt_add(NULL); //add current thread to WDT watch  
}  
  
void wdt_reset(B4R::Object* o) {  
    //Serial.println("Resetting WDT…");  
    esp_task_wdt_reset();  
}  
  
void wdt_stop(B4R::Object* o) {  
    Serial.println("WDT is stopped");  
    esp_task_wdt_delete(NULL);  
    esp_task_wdt_deinit();  
}  
#End If
```

  
  

```B4X
mode:DIO, clock div:1  
load:0x3fff0030,len:1344  
load:0x40078000,len:13964  
load:0x40080400,len:3600  
entry 0x400805f0  
AppStart  
Configuring WDT…  
E (6116) task_wdt: Task watchdog got triggered. The following tasks did not reset the watchdog in time:  
E (6116) task_wdt:  - loopTask (CPU 1)  
E (6116) task_wdt: Tasks currently running:  
E (6116) task_wdt: CPU 0: IDLE  
E (6116) task_wdt: CPU 1: loopTask  
E (6116) task_wdt: Aborting.  
abort() was called at PC 0x400d8d71 on core 0  
Backtrace: 0x40083349:0x3ffbe9cc |<-CORRUPTED  
ELF file SHA256: 6bc82a9473af7e00  
Rebooting…  
ets Jun  8 2016 00:22:57  
rst:0xc (SW_CPU_RESET),boot:0x13 (SPI_FAST_FLASH_BOOT)  
configsip: 0, SPIWP:0xee  
clk_drv:0x00,q_drv:0x00,d_drv:0x00,cs0_drv:0x00,hd_drv:0x00,wp_drv:0x00  
mode:DIO, clock div:1  
load:0x3fff0030,len:1344  
load:0x40078000,len:13964  
load:0x40080400,len:3600  
entry 0x400805f0  
AppStart  
Configuring WDT…
```