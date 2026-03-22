### Data Logging to Supabase Using ESP32 by embedded
### 03/20/2026
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/170642/)

```B4X
' Requires the following libraries to be checked in B4R:  
' - rESP8266WiFi  
' - rRandom  
  
Sub Process_Globals  
    Public Serial1 As Serial  
    Private wifi As ESP8266WiFi  
    Private tmr As Timer  
End Sub  
  
Private Sub AppStart  
    ' Using 115200 baud rate to match your C++ code  
    Serial1.Initialize(115200)  
    Log("Connecting to WiFi…")  
      
    ' Connect to WiFi using the credentials from your code  
    If wifi.Connect2("LRxxx", "xxxx") Then  
        Log("Connected! IP Address: ", wifi.LocalIp)  
          
        ' Initialize the Supabase C++ library  
        RunNative("SetupSupabase", Null)  
          
        ' Initialize timer to send data every 10 seconds  
        tmr.Initialize("tmr_Tick", 10000)  
        tmr.Enabled = True  
    Else  
        Log("Failed to connect to WiFi.")  
    End If  
End Sub  
  
Private Sub tmr_Tick  
    ' Generate a random value between 1 and 100  
    Dim randomValue As Int = Rnd(1, 101)  
      
    Log("Sending value: ", randomValue)  
      
    ' Pass ONLY the integer to our Inline C++ function  
    RunNative("InsertSupabase", randomValue)  
End Sub  
  
  
#if C  
#include <ESPSupabase.h>  
  
Supabase db;  
  
// ─── Initialize Supabase ───  
void SetupSupabase(B4R::Object* o) {  
    String supabase_url = "https://xxxx.supabase.co";  
    String anon_key = "xxxxxx";  
      
    db.begin(supabase_url, anon_key);  
    ::Serial.println("Supabase C++ Database Initialized!");  
}  
  
// ─── Insert Data ───  
void InsertSupabase(B4R::Object* o) {  
    // Extract the integer passed from B4R  
    long randomValue = o->toLong();  
      
    // Build the JSON exactly like your working Arduino C++ sketch  
    String jsonStr = "{\"sender\":\"ESP32 Sensor\",\"content\":\"" + String(randomValue) + "\"}";  
      
    ::Serial.print("C++ Payload: ");  
    ::Serial.println(jsonStr);  
      
    String table = "messages";//table name in which data is insert data  
    bool upsert = false;  
      
    // Execute the insert using the ESPSupabase library  
    int code = db.insert(table, jsonStr, upsert);  
      
    ::Serial.print("HTTP Response Code: ");  
    ::Serial.println(code);  
      
    // Reset URL queries to prevent parameters from stacking  
    db.urlQuery_reset();  
}  
#End If
```