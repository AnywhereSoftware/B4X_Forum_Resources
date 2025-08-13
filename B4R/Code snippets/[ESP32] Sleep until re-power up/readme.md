### [ESP32] Sleep until re-power up by peacemaker
### 08/11/2023
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/149523/)

Switch all radio off and sleeeeeeeep…  
  

```B4X
'espsleep module  
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
     
End Sub  
  
Sub Sleep_ESP32  
    RunNative("sleep_esp", Null)  
End Sub  
  
#if C  
#include "esp_bt_main.h"  
#include "esp_wifi.h"  
#include "esp_bt.h"  
#include "esp_gap_ble_api.h"  
  
void sleep_esp(B4R::Object* o) {  
esp_wifi_stop();  
esp_bt_controller_disable();  
esp_ble_gap_stop_scanning();  
esp_bluedroid_disable();  
esp_bluedroid_deinit();  
esp_deep_sleep_start();  
}  
#End If
```