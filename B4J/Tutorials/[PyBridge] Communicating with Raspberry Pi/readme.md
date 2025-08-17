### [PyBridge] Communicating with Raspberry Pi by Erel
### 03/12/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/166095/)

This sophisticated project does one thing - the user clicks on a hardware button, connected to the RPi, and a notification appears on the PC.  
  
![](https://www.b4x.com/android/forum/attachments/162492)  
  
The setup:  
RPi running Mosquitto broker as a service: <https://randomnerdtutorials.com/how-to-install-mosquitto-broker-on-raspberry-pi/>  
  
The RPi runs this console program:  

```B4X
Sub Process_Globals  
    Private Py As PyBridge  
    Private ButtonPin As Int  
    Private gpio As LGPIO  
    Private mqtt As MqttClient  
End Sub  
  
Sub AppStart (Args() As String)  
    Start  
    StartMessageLoop  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub Start  
    Py.Initialize(Me, "Py")  
    Dim opt As PyOptions = Py.CreateOptions("/usr/bin/python")  
    Py.Start(opt)  
    Wait For Py_Connected (Success As Boolean)  
    If Success = False Then  
        LogError("Failed to start Python process.")  
        Return  
    End If  
    ButtonPin = 20  
    gpio.Initialize(Py, Me, "gpio")  
    gpio.Open(0)  
    gpio.ClaimAlert(ButtonPin, gpio.EDGE_BOTH, gpio.SET_PULL_UP)  
    gpio.DebounceMicros(ButtonPin, 10000)  
    mqtt.Initialize("mqtt", "tcp://127.0.0.1:1883", "rpi")  
    mqtt.Connect  
    Wait For mqtt_Connected (Success As Boolean)  
    Log($"connected? ${Success}"$)  
    If Success = False Then  
        CloseProgram  
    End If  
End Sub  
  
Private Sub CloseProgram 'ignore  
    gpio.Close  
    Sleep(100)  
    Py.KillProcess  
    Sleep(100)  
    StopMessageLoop  
End Sub  
  
  
Private Sub GPIO_StateChanged (Pin As Int, Level As Int)  
    Log(Pin & ": " & Level)  
    If Level = 0 Then  
        mqtt.Publish("rpi", "button clicked!".GetBytes("utf8"))  
    End If  
End Sub  
  
  
Private Sub Py_Disconnected  
    Log("PyBridge disconnected")  
End Sub
```

  
LGPIO is a library that is currently distributed as a class. You can find it here: <https://www.b4x.com/android/forum/threads/pybridge-lgpio-raspberry-pi-gpio.166064/#post-1018259>  
  
The following console app is running on the PC:  

```B4X
Sub Process_Globals  
    Private Py As PyBridge  
    Private mqtt As MqttClient  
    Private MqttWorking As Boolean = True  
End Sub  
  
Sub AppStart (Args() As String)  
    Start  
    StartMessageLoop  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub Start  
    Py.Initialize(Me, "Py")  
    Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")  
    Py.Start(opt)  
    Wait For Py_Connected (Success As Boolean)  
    If Success = False Then  
        LogError("Failed to start Python process.")  
        Return  
    End If  
    ConnectAndReconnect ("tcp://192.168.1.153:1883", "PC")  
End Sub  
  
Sub ConnectAndReconnect (uri As String, ClientId As String)  
    Do While MqttWorking  
        If mqtt.IsInitialized Then mqtt.Close  
        Do While mqtt.IsInitialized  
            Sleep(100)  
        Loop  
        mqtt.Initialize("mqtt", uri, ClientId)  
        Dim mo As MqttConnectOptions  
        mo.Initialize("", "")  
        Log("Trying to connect")  
        mqtt.Connect2(mo)  
        Wait For Mqtt_Connected (Success As Boolean)  
        If Success Then  
            Log("Mqtt connected")  
            AfterConnected  
            Do While MqttWorking And mqtt.Connected  
                mqtt.Publish2("ping", Array As Byte(0), 1, False) 'change the ping topic as needed  
                Sleep(5000)  
            Loop  
            Log("Disconnected")  
        Else  
            Log("Error connecting.")  
        End If  
        Sleep(5000)  
    Loop  
End Sub  
  
Private Sub AfterConnected  
    mqtt.Subscribe("rpi", mqtt.QOS_1_LEAST_ONCE)  
End Sub  
  
Private Sub Mqtt_MessageArrived (Topic As String, Payload() As Byte)  
    Log($"message arrived: ${Topic}"$)  
    If Topic = "rpi" Then  
        ShowNotification("Message from RPi", BytesToString(Payload, 0, Payload.Length, "utf8"), "B4J") _  
            .ArgNamed("image", "C:\Users\H\Downloads\172694.png")  
    End If  
End Sub  
  
Private Sub mqtt_Disconnected  
    Log("disconnected")  
End Sub  
  
Private Sub ShowNotification(Title As String, Body As String, AppId As String) As PyWrapper  
    Dim toast As PyWrapper = Py.ImportModuleFrom("win11toast", "toast")  
    Return toast.Call.Arg(Title).Arg(Body).ArgNamed("app_id", AppId)  
End Sub  
  
  
Private Sub CloseProgram 'ignore  
    MqttWorking = False  
    Py.KillProcess  
    Sleep(100)  
    StopMessageLoop  
End Sub  
  
Private Sub Py_Disconnected  
    Log("PyBridge disconnected")  
End Sub
```

  
Note that notifications depend on:  

```B4X
pip install win11toast
```

  
<https://www.b4x.com/android/forum/threads/pybridge-windows-10-11-notifications.166091/#post-1018409>  
  
This example can be expanded for real usage where sensors connected to the RPi send their status to a PC app.  
  
Edit: update PC code with ConnectAndReconnect sub to better handle network issues.