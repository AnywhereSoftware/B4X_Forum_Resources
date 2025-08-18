### Turn on/off light connected to Home Assistant on Raspberry Pi by raphael75
### 12/22/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/137054/)

I have lights connected to Home Assistant via Wi-Fi and ZigBee.  
Using the REST API in Home Assistant I can turn on/off lights and change other attributes such as brightness and RGB color.  
Documentation about Home Assistant REST API:  
<https://developers.home-assistant.io/docs/api/rest>  
See section POST /api/services/<domain>/<service>.  
  
Example of POST request sent to Home Assistant to turn on a LED strip with RGBW colors:  
POST <http://192.168.0.xxx:8123/api/services/light/turn_on>  
{"entity\_id": "light.xxxxxxxxxxxxx", "rgbw\_color": [255, 0, 127, 0]}  
  
Example of feedback received from Home Assistant:  
[{"entity\_id": "light.xxxxxxxxxxxxx", **"state": "on"**, "attributes": {"effect\_list": ["blue\_fade", "blue\_strobe", "colorjump", "colorloop", "colorstrobe", "cyan\_fade", "cyan\_strobe", "gb\_cross\_fade", "green\_fade", "green\_strobe", "purple\_fade", "purple\_strobe", "rb\_cross\_fade", "red\_fade", "red\_strobe", "rg\_cross\_fade", "white\_fade", "white\_strobe", "yellow\_fade", "yellow\_strobe", "random"], "supported\_color\_modes": ["rgbw"], "color\_mode": "rgbw", "brightness": 128, "hs\_color": [330.118, 100.0], "rgb\_color": [255, 0, 127], **"rgbw\_color": [255, 0, 127, 0]**, "xy\_color": [0.581, 0.245], "ip\_address": "192.168.0.24", "friendly\_name": "XXXXXXXXXXXXXXXX", "supported\_features": 36}, "last\_changed": "2021-12-22T11:10:55.254677+00:00", "last\_updated": "2021-12-22T11:10:55.254677+00:00", "context": {"id": "xxxxxxxxxxxxxxxxxxxxx", "parent\_id": null, "user\_id": "xxxxxxxxxxxxxxxxxxxx"}}]  
  
You need following libraries in B4J:  
- jOkHttpUtils2  
- Json  
  
Example of code in B4J:  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
   
    ' Button view  
    Dim btnLedBedroom As Button  
   
    ' Local IP address of Raspberry Pi with Home Assistant  
    Dim sIpHomeAssistant As String = "http://192.168.0.xxx"  ' <<< Type the IP address of your own RPi  
    Dim sPortHomeAssistant As String = "8123"  
    ' Token to get access to Home Assistant  
    Dim sTokenHA As String = "xxxxxxxxxxxxxxxxxxxxxxxxxx"  ' <<< Type your own token, generated from your profile in Home Assistant  
   
    ' Entities in Home Assistant  
    Dim sEntityId_LedBedroom As String = "light.xxxxxxxxxxxxxxx"  ' <<< Type your own entity ID from Home Assistant  
End Sub  
  
' Action when clicking on button  
Sub btnLedBedroom_Click  
    Dim sEntityId As String = sEntityId_LedBedroom  
   
    ' Turn on the light without additional parameters  
    'SendPostRequestToHomeAssistant(sEntityId, "Light", "On", Null)  ' <<< Null as last parameter  
   
    ' Turn on the light with additional parameters  
    Dim mapParams As Map = CreateMap("rgbw_color": Array As Int(255, 0, 127, 0))  
    'Dim mapParams As Map = CreateMap("brightness": 200)  
    SendPostRequestToHomeAssistant(sEntityId, "Light", "On", mapParams)  ' <<< mapParams as last parameter  
End Sub  
  
' Parameters:  
' - sEntityType: Light, Switch  
' - sAction: Toggle, On, Off  
' - mapParams: Optional map containing additional parameters, such as brightness, RGB color, light temperature (warm/cold white) etc.  
'              Type Null if not used.  
Sub SendPostRequestToHomeAssistant(sEntityId As String, sEntityType As String, sAction As String, mapParams As Map)  
    Dim sApiEntityType As String  
    If sEntityType.ToLowerCase = "light" Then  
        sApiEntityType = "light"  
    Else If sEntityType.ToLowerCase = "switch" Then  
        sApiEntityType = "switch"  
       
    End If  
   
    Dim sApiAction As String  
    If sAction.ToLowerCase = "toggle" Then  
        sApiAction = "toggle"  
    Else If sAction.ToLowerCase = "on" Then  
        sApiAction = "turn_on"  
    Else If sAction.ToLowerCase = "off" Then  
        sApiAction = "turn_off"  
       
    End If  
   
    ' Create map and then JSON string with parameters  
    Dim mapParamsPost As Map = CreateMap("entity_id": sEntityId)  
    ' Compléter avec paramètres supplémentaires  
    ' Complete the map with additional parameters, such as brightness, RGB color, light temperature (warm/cold white) etc.  
    If mapParams.IsInitialized Then  
        For Each key As String In mapParams.Keys  
            mapParamsPost.Put(key, mapParams.Get(key))  
        Next  
    End If  
   
    Dim jg As JSONGenerator  
    jg.Initialize(mapParamsPost)  
    Log("jg.ToString: " & jg.ToString)  
    Log("jg.ToPrettyString(2): " & jg.ToPrettyString(2))  
    
    Dim hj As HttpJob  
    hj.Initialize("", Me)  
    ' POST http://192.168.0.xxx:8123/api/services/light/turn_on  
    ' {"entity_id": "light.xxxxxxxxxxxxxx", "rgbw_color": [255, 0, 127, 0]}  
    hj.PostString(sIpHomeAssistant & ":" & sPortHomeAssistant & "/api/services/" & sApiEntityType & "/" & sApiAction, jg.ToString)  
    hj.GetRequest.SetHeader("Authorization", "Bearer " & sTokenHA)  
    hj.GetRequest.SetContentType("application/json")  
   
    ' Send POST request and wait for result  
    Wait For (hj) JobDone(hj As HttpJob)  
   
    If hj.Success Then  
        Dim sResult As String = hj.GetString  
        Log("hj.GetString: " & sResult)  
        ' Extract state (on/off) from JSON string  
        ' Remove "[" at the beginning and "]" at the end  
        If sResult.Length > 2 And sResult.StartsWith("[") And sResult.EndsWith("]") Then  
            sResult = sResult.SubString2(1, sResult.Length - 1)  
            Try  
                Dim jp As JSONParser  
                jp.Initialize(sResult)  
                Dim mapJson As Map = jp.NextObject  
                Dim sState As String = mapJson.Get("state")  
                Log("sState: " & sState)  
                ' Change text on button  
                btnLedBedroom.Text = IIf(sState = "on", "On", "Off")  
                btnLedBedroom.TextColor = IIf(sState = "on", fx.Colors.RGB(0, 191, 0), fx.Colors.Black)  
            Catch  
                Log("Error: Try JSONParser => LastException: " & LastException)  
            End Try  
        Else  
            '  
        End If  
       
    Else  
        Log("Error: hj.Success ERROR")  
        Log("Error: hj.ErrorMessage: " & hj.ErrorMessage)  
    End If  
   
    hj.Release  
End Sub
```