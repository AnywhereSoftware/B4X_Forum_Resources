### [ESP32] enable BT or BLE and get MAC-address by peacemaker
### 02/25/2025
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/149314/)

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public MacArray(6) As Byte  
End Sub  
  
  
Sub Get_btMacAddress(ble As Boolean)  
    RunNative("getBTMac", ble)  
End Sub  
#if C  
#include "esp_bt.h"  
#include "esp_bt_main.h"  
#include "esp_bt_device.h"  
#include "esp_mac.h"                          //added for ESP32 SDK v.3+  
  
  void getBTMac(B4R::Object* o) {  
      if (o->toLong() == 0) {  
        esp_bt_controller_enable(ESP_BT_MODE_CLASSIC_BT);  
    }else{  
        esp_bt_controller_enable(ESP_BT_MODE_BLE);  
    }  
    esp_bluedroid_init();  
    esp_bluedroid_enable();  
    esp_read_mac((Byte*)b4r_others::_macarray->data, ESP_MAC_BT);  
  }  
#end if
```

  
  
Note: [WiFi mac-address](https://www.b4x.com/android/forum/threads/how-to-use-global-arrays-from-inline-c.68747/post-436143) and BT mac address are different.