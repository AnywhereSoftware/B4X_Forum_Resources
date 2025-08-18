### Uploading data to ThingSpeak using MQTT by Mark Read
### 03/21/2021
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/128921/)

As I was not able to find a complete example for doing this, just snippets of code, I offer this to everyone who needs help. You will need to add your own WiFi credentials and API Keys of course.  
  
Libraries required: rCore, rESP8266WiFi, rMQTT  
  
Upload is based on the timer tick, not on a sleep mode!  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 300  
#End Region  
  
'Ctrl+Click to open the C code folder: ide://run?File=%WINDIR%\System32\explorer.exe&Args=%PROJECT%\Objects\Src  
  
'Thingspeak_test by Mark Read 2021  
'Hardware:  Wemos D1 Mini  
  
  
Sub Process_Globals  
    Public Serial1 As Serial  
    Public WiFi As ESP8266WiFi  
      
    Public MQTTApiKey As String="xxxxxxxxxxxx"                'Get from MyProfile in Thingspeak  
    Public WriteAPIKey As String="xxxxxxxxxxxx"                'Same here  
    Public UserName As String="xxxxxxxxxxxx"                'obvious  
    Public WifiSSID As String="xxxxxxxxxxxx"                'your WiFi name  
    Public WifiPass As String="xxxxxxxxxxxx"                'and password  
    Public ThinkspeakServer As String="mqtt.thingspeak.com"  
    Private ChannelID As String="xxxxxxxxxxxx"                'The destination channel number  
    Private ClientID As String="MrW"                        'can be anything you like  
      
    Public WiFiClient As WiFiSocket  
    Private MQTT As MqttClient  
    Private MQTTOptions As MqttConnectOptions  
     
    Public TEMPERATURE, PRESSURE, HUMIDITY As Double  
    Public HeatIndex, DewPoint, Altitude As Double  
              
    Public DelayTimer As Timer  
      
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
          
    DelayTimer.Initialize("DelayTimer_Tick", 1*60*1000)    '1 mins  
      
    MQTT.Initialize2(WiFiClient.Stream, ThinkspeakServer,1883, ClientID,"MQTT_MessageArrived", "MQTT_Disconnected")  
    MQTTOptions.Initialize(UserName, MQTTApiKey)  
  
    DelayTimer_Tick        'call the tick sub once or we will have to wait for the timer!  
      
    DelayTimer.Enabled=True  
End Sub  
  
Sub DelayTimer_Tick  
    If WiFi.IsConnected=False Then  
        ConnectToNetwork  
    End If  
      
    'Generate some data  
    TEMPERATURE=Rnd(0,40)  
    PRESSURE=Rnd(925,975)  
    HUMIDITY=Rnd(0,30)  
    HeatIndex=Rnd(0,40)  
    DewPoint=Rnd(10,15)  
    Altitude=Rnd(525,275)  
      
    UploadThinkgspeak     
    MQTT_Disconnected  
    Log("Going to sleep …")  
End Sub  
  
Sub UploadThinkgspeak  
    If MQTT.Connect2(MQTTOptions) Then  
        Log("MQTT Connected")  
        Dim PayLoad, Topic As String  
        PayLoad=JoinStrings(Array As String("field1=",TEMPERATURE,"&field2=",PRESSURE,"&field3=",HUMIDITY,"&field4=",HeatIndex,"&field5=",DewPoint,"&field6=",Altitude))  
        Log("Sending data: ",PayLoad)  
          
        Topic=JoinStrings(Array As String("channels/", ChannelID, "/publish/", WriteAPIKey))  
          
        Log(MQTT.Publish(Topic,PayLoad))  
          
    Else  
        Log("Error - Not connected")     
    End If  
          
End Sub  
  
Sub MQTT_MessageArrived (Topic As String, Payload() As Byte)  
    Log("Message arrived. Topic=", Topic, " payload: ", Payload)  
End Sub  
  
Sub MQTT_Disconnected  
    Log("MQTT Disconnected")  
    MQTT.Close  
End Sub  
  
Sub ConnectToNetwork  
    If    WiFi.IsConnected Then Return  
    If WiFi.Connect2(WifiSSID, WifiPass) Then  
        Log("Connected successfully to: ", WifiSSID)  
        Log("With IP: ",WiFi.LocalIp)  
          
    Else  
        Log("Failed to connect.")  
    End If  
End Sub
```