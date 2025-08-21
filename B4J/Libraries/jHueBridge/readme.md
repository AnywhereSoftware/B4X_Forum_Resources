### jHueBridge by Blueforcer
### 04/19/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/116567/)

This is a library that emulates a Philips Hue bridge v1 with Lights and allows you to control them (and therefore your App) from Alexa-powered devices like the Amazon Echo or the Dot.  
  
**Ive tested it with the big Amazon Echo 1.Gen and it works perfectly.  
Unfortunately it does not work for my friend with Echo Dot 3.gen. I have not found out why yet. But his echo find other emulators like for ESP8266 that use the same protocol. Maybe there are tinkerers here who can help me.  
  
  
Functions:**  
- add many devices as you like  
- supports On/off  
- supports dimming  
- supports colorchanging  
  
**Usage:**  

```B4X
Sub Process_Globals  
    Dim bridge As jHueBridge  
End Sub  
  
Sub AppStart (Args() As String)  
    bridge.initialize(Me,"Bridge",80)  
    bridge.addDevice("MyDevice",True) 'You can call this as many as you like with different names  
    bridge.startPairing 'Pairing is active for 2 minutes  
    StartMessageLoop  
End Sub  
  
'Return true to allow the default exceptions handler to handle the uncaught exception.  
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean  
    Return True  
End Sub  
  
Sub Bridge_StateChanged(DeviceName As String,State As Boolean)  
    Log("Client switch device " & DeviceName & " to " & State)  
End Sub  
  
Sub Bridge_BrightnessChanged(DeviceName As String,Brightness As Int)  
    Log("Client sets the brightness of device " & DeviceName & " to " & Brightness)  
End Sub  
  
Sub Bridge_ColorChanged(DeviceName As String, Color() As Int)  
    Log("Client sets the color of device " & DeviceName & " to " & "R="&Color(0)& " G="&Color(1)& " B="&Color(2))  
End Sub
```

  
  
**Depends on:**  
- JavaObject  
- jNetwork  
- jRandomAccessFile  
- Json