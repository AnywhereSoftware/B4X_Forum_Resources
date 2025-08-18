### Setting the hostname of an ESP32 by KMatle
### 09/01/2020
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/121824/)

Important is this line:  
  
 **WiFi.config(INADDR\_NONE, INADDR\_NONE, INADDR\_NONE);**   
which seems to reset the settings. My ESP32 showed up as "Espressif"  
  

```B4X
Private Sub SetHostName  
    
    Dim bb() As Byte = "TheHostname"  
    RunNative("SetHostName", bb)  
End Sub  
  
#if C  
  void SetHostName(B4R::Object* o) {  
   B4R::Array* b = (B4R::Array*)B4R::Object::toPointer(o);  
   char* c = (char*)b->data;  
   WiFi.config(INADDR_NONE, INADDR_NONE, INADDR_NONE);  
   WiFi.setHostname( c );  
  }  
#end if
```