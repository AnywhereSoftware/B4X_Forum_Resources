### ESP32CAM - Print Logs Workaround - b4xlib included by hatzisn
### 10/24/2022
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/143731/)

All of you that have bought the ESP32CAM you know that it does not print logs in B4R. So if you cannot go through a problem, just go around it. The around way is to post in MQTT server the logs and display them in B4J app. And it works.  
  
b4xlib usage:  
  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
    Private wifi As ESP8266WiFi  
    Public wificlient As WiFiSocket  
      
    Private tim As Timer  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
      
    'example of connecting to a local network  
    If wifi.Connect2("SSID", "WIFIPASS") Then  
        Log("Connected to network")  
        ESP32CAM.Initialize(wificlient, Array As Byte(192,168,15,124), 1883, "mqttusername", "mqttpass")  
    Else  
        Log("Failed to connect to network")  
    End If  
      
    tim.Initialize("tim_Tick", 1000)  
    tim.Enabled = True  
End Sub  
  
Sub tim_Tick  
    ESP32CAM.Log2("Tick")  
End Sub
```