### "Raise left hand" - tracking with Smartwatch (WearOS) by Watchkido1
### 08/18/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/149665/)

Hi  
Anyone who wants to track whether the user touches their nose, mouth, ear or face can use this code.  
Used here to remind the user that he eats, smokes or bites his nails.  
  

```B4X
Sub btnStart_Click  
    CallSubDelayed(Player, "Play")  
End Sub  
  
Sub btnStop_Click  
    CallSubDelayed(Player, "Stop")  
Sub
```

beenden  
  

```B4X
#Region  Service Attributes  
    #StartAtBoot: False  
#End Region  
  
Sub Process_Globals  
    Private nid As Int = 1  
    Private lock As PhoneWakeState  
    'Private pl As SimpleExoPlayer  
    Dim ps As PhoneSensors  
    Dim X,Y,Z As Float  
    Private counter As Long  
    'Dim v As PhoneVibrate  
    Dim b As Beeper  
    Public Provider As FileProvider  
End Sub  
  
Sub Service_Create  
    lock.PartialLock  
    ps.Initialize(9)  
    b.Initialize(100,400)  
End Sub  
  
  
Sub Service_Start (StartingIntent As Intent)  
    Public Provider As FileProvider  
    Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.  
    Service.StopAutomaticForeground  
    Log(ps.MaxValue)  
    If ps.StartListening("Sensor") = False Then  
        'lbl.Text = sd.Name & " is not supported."  
        Log(ps.Timestamp & " is not supported.")  
    End If  
End Sub  
  
Public Sub Play  
    Service.StartForeground(nid, CreateNotification("Fettwarner An"))  
    ps.StartListening("Sensor")  
End Sub  
  
Sub pl_Error (Message As String)  
    Log(Message)  
End Sub  
  
Sub pl_Complete  
    Log("complete")  
End Sub  
  
Public Sub Stop  
      
    Service.StopForeground(nid)  
    ps.StopListening  
    'pl.Pause  
    StopService("Player")  
End Sub  
  
  
Sub CreateNotification (Body As String) As Notification  
    Dim notification As Notification  
    notification.Initialize2(notification.IMPORTANCE_LOW)  
    notification.Icon = "icon"  
    notification.SetInfo("Tracking Essen", Body, Main)  
    Return notification  
End Sub  
  
Sub Service_Destroy  
    'pl.Pause  
    lock.ReleasePartialLock  
End Sub  
  
Sub Sensor_SensorChanged (Values() As Float)  
      
    counter = counter + 1  
    If counter Mod 100 = 0 Then  
        X = Values(0)*1000  
        Y = Values(1)*1000  
        Z = Values(2)*1000  
        'X = Round(X)  
        'y = Round(y)  
        'z = Round(Z)  
  
          
        Log("                "&X & "," & Y & "," & Z)  
          
        If  x <10000 And x >5000 Then  
            If y > -8000 And y < 6000 Then  
                If z < 9300 And z > -2000 Then  
                    Dim v As PhoneVibrate  
                    Log("Treffer bei ,"& X& ","&Y&","&Z)  
                    v.Vibrate(600)  
'                    If LEDCorona.KVS2.Get("Beepsound") Then  
'                        b.Beep  
'                    End If  
                End If  
            End If  
        End If  
    End If  
End Sub
```