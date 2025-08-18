### Adafruit IO: Sending multiple data feeds with only one mqtt Publish message by inakigarm
### 03/02/2021
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/128209/)

Hi, trying to send 4 feeds (IPPubl,IPLocal, SCATemp,SCAHum) from a NodeMCU skecth + DHT11 sensor I wish to do it like Thingspeak in one MQTT publish message (see [USER=11192]@barx[/USER] post at <https://www.b4x.com/android/forum/threads/mqtt-connect-to-thingspeak.89453/post-566218>)  
  
Adafruit has a facility named **Group**: you can add feeds to a Group and Publish/Subscribe to/a Group (you can test it on Windows 10 with mqtt fx <http://www.jensd.de/apps/mqttfx/1.7.1/>)  
  
The syntax of the Publish message is:  
  
 username/groups/default/json (you can change default name or create another group  
  
and the json payload:  
{  
 "feeds": {  
 "SCAIPPubl": "88.0.16.194",  
 "SCAIPLocal": "192.168.1.4",  
 "SCATemp": "28",  
 "SCAHum": "38"  
 },  
 "location": {  
 "lat":41.80,  
 "lon": 2.5,  
 "ele": 500.0 }  
}  
With only one MQTT Publish, you can send several feeds (to a Group):  
  

```B4X
    Dim bc As ByteConverter  
     
    Dim IPPubl As String="88.10.2.174"                     '"https://api.myip.com"  
    Dim IPLocal As String="192.168.1.165"                 'Wifi.IPlocal  
    Dim Temp As String=GetTemp                              'From DHT11  
    Dim Hum As String=GetHum                                'From DHT11  
     
    Dim fullstring As String  
    fullstring=JoinStrings(Array As String _  
    ("{""feeds"": {""SCAIPPubl"":""",IPPubl,""",""SCAIPLocal"":""",IPLocal,""",""SCATemp"":""",Temp,""",""SCAHum"":""",Hum,"""},""location"":  {""lat"":41.80,""lon"":2.5,""ele"":500}}"))  
     
    mqtt.Publish("username/groups/default/json",bc.StringToBytes(fullstring))  
    Log(fullstring)
```

  
  
 Adafruit IO DashBoard  
  
![](https://www.b4x.com/android/forum/attachments/108956)