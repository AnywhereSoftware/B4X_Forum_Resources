### [ESP32] NVS storage by peacemaker
### 07/28/2023
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/149284/)

Based on <https://github.com/rpolitex/ArduinoNvs> (download the lib and install into Arduino, copy the "ArduinoNvs" folder to "C:\Users\%USERNAME%\Documents\Arduino" by default).  
  

```B4X
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Type KeyValueType(key() As Byte, value() As Byte)  
    Private result_string() As Byte    'ignore  
End Sub  
  
Sub Init  
    RunNative("nvs_setup", Null)  
End Sub  
  
Sub WriteString(key_string() As Byte, value() As Byte)  
    Dim source As KeyValueType  
    source.key = key_string  
    source.value = value  
    RunNative("nvs_write_string", source)  
    Log("Saved to NVS")  
End Sub  
  
Sub ReadString(key_string() As Byte)  
    RunNative("nvs_read_string", key_string)  
    Log(Main.bc.StringFromBytes(result_string))  
End Sub  
  
#if C  
#include "ArduinoNvs.h"  
  
void nvs_setup(B4R::Object* o) {  
NVS.begin();  
}  
  
void nvs_write_string(B4R::Object* o) {  
    /*** String ***/  
    // write to flash  
  
    _keyvaluetype* tmp = (_keyvaluetype*)B4R::Object::toPointer(o);  
   
    B4R::Array* b = tmp->key;  
    char* c = (char*)b->data;  
    String key = (String)c;  
   
    B4R::Array* b2 = tmp->value;  
    char* c2 = (char*)b2->data;  
    String value = (String)c2;  
   
    NVS.setString(key, value);  
}  
  
void nvs_read_string(B4R::Object* o) {  
    // read from flash  
    B4R::Array* b = (B4R::Array*)B4R::Object::toPointer(o);  
     char* c = (char*)b->data;  
    String st = (String)c;  
   
    String res = NVS.getString(st);  
   
    byte b1[res.length() + 1];  
       res.getBytes(b1, sizeof(b1));  
    b4r_espnvs::_result_string->data = b1;  
    b4r_espnvs::_result_string->length = sizeof(b1);  
}  
  
#end if
```

  
  
Usage:  

```B4X
    espnvs.Init  
    espnvs.WriteString("testkey", "testkey!_value!")  
    …  
    …  
    espnvs.ReadString("testkey")  
    Log(bc.StringFromBytes(espnvs.result_string))
```

  
  
Pls, help   
1) to re-check inline-C code (it's very difficult to find correct way for me, with nothing in C-programming)  
2) to add functions for storing other data types variables