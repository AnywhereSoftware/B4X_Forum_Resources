### Read data from a temperature sensor connected to Home Assistant on Raspberry Pi by raphael75
### 12/21/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/137006/)

I am using Home Assistant installed on a Raspberry Pi, and I have temperature sensors transmitting temperature values to Home Assistant.  
Home Assistant has a REST API that may be used by a B4J application to get access to the temperature values.   
Documentation about Home Assistant REST API:   
<https://developers.home-assistant.io/docs/api/rest>  
See section GET /api/states/<entity\_id>.  
  
Example of JSON string received from Home Assistant, where "state" is the temperature:   
{"entity\_id": "sensor.xxxxxxxxxx\_temperature", **"state": "-1.06"**, "attributes": {"state\_class": "measurement", "battery": 86, "humidity": 67.3, "linkquality": 57, "pressure": 1033.8, "temperature": -1.06, "voltage": 2975, "unit\_of\_measurement": "\u00b0C", "device\_class": "temperature", "friendly\_name": "XXXXXXXXXXX temperature"}, "last\_changed": "2021-12-20T23:23:29.434520+00:00", "last\_updated": "2021-12-20T23:23:29.434520+00:00", "context": {"id": "xxxxxxxxxxxxxxxxxxx", "parent\_id": null, "user\_id": null}}  
  
You need following libraries in B4J:   
- jOkHttpUtils2  
- Json  
  
Example of code in B4J:  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
      
    ' TextFields used to show temperatures  
    Dim txtTempBath As TextField  
    Dim txtTempExt As TextField  
      
    ' Local IP address of Raspberry Pi with Home Assistant  
    Dim sIpHomeAssistant As String = "http://192.168.0.xxx"  ' <<< Type your own IP address  
    Dim sPortHomeAssistant As String = "8123"  
    ' Token to get access to Home Assistant  
    Dim sTokenHA As String = "xxxxxxxxxxxxxxxxxxxxxxxxxx"  ' <<< Type your own token, generated from your profile in Home Assistant  
      
    ' Entities in Home Assistant  
    Dim sEntityId_TEMP_EXT As String = "sensor.xxxxxxxxxxx_temperature"  ' <<< Type your own entity ID from Home Assistant  
    Dim sEntityId_TEMP_BATH As String = "sensor.xxxxxxxxxxx_temperature"  
          
    ' Timer to update temperatures at regular intervals  
    Dim tmrUpdateStates As Timer  
      
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
      
    ' Initialize timer to update temperatures  
    tmrUpdateStates.Initialize("tmrUpdateStates",  5 * DateTime.TicksPerSecond)  ' 5000 ms  
    tmrUpdateStates.Enabled = True  
    ' => See automatic timer event in Sub tmrUpdateStates_Tick  
End Sub  
  
' Automatic timer event every 5 seconds  
Sub tmrUpdateStates_Tick  
    'Handle tick events  
      
    ' Get external temperature and show in text field txtTempExt  
    SendGetRequestToHomeAssistant(sIdentityId_TEMP_EXT, txtTempExt)  
      
    ' Get temperature in bathroom and show in text field txtTempBath  
    SendGetRequestToHomeAssistant(sIdentityId_TEMP_BATH, txtTempBath)  
      
End Sub  
  
Sub SendGetRequestToHomeAssistant(sEntityId As String, txtState As TextField)  
    Dim hj As HttpJob  
    hj.Initialize("", Me)  
    ' GET http://192.168.0.xxx:8123/api/states/sensor.xxxxxxxxxxx_temperature  
    hj.Download(sIpHomeAssistant & ":" & sPortHomeAssistant & "/api/states/" & sEntityId)  
    hj.GetRequest.SetHeader("Authorization", "Bearer " & sTokenHA)  
      
    ' Send GET request and wait for result  
    Wait For (hj) JobDone(hj As HttpJob)  
      
    If hj.Success Then  
        Dim sResult As String = hj.GetString  
        Log("hj.GetString: " & sResult)  
        ' Extract temperature from JSON ("state": "-1.06")  
        Dim jp As JSONParser  
        jp.Initialize(sResult)  
        Dim mapJson As Map = jp.NextObject  
        Dim sState As String = mapJson.Get("state")  
        Log("sState: " & sState)  
        ' Show temperature in text field  
        txtState.Text = sState  
          
    Else  
        Log("Error: hj.Success ERROR")  
        Log("Error: hj.ErrorMessage: " & hj.ErrorMessage)  
    End If  
    hj.Release  
End Sub
```