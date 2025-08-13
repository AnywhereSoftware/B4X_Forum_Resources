### Wake the screen up at Firebase push-message by peacemaker
### 04/30/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/166800/)

Manipulating of the KeepAlive when the push-message is arrived - helps to switch the screen on for some seconds: and this awoke allows to play a voice message !  
Tested on Samsung phone Android14.   
  

```B4X
Sub fm_MessageArrived (Message As RemoteMessage)  
    Log("Message arrived")  
    Log($"Message data: ${Message.GetData}"$)  
     
'if B4XPages framwork is used  
'    If B4XPages.IsInitialized And B4XPages.GetManager.IsForeground Then  
'        Log("App is in the foreground. In iOS a notification will not appear while the app is in the foreground (unless UserNotificationCenter is used).")  
'    End If  
  
    Dim n2 As Notification  
    n2.Initialize2(n2.IMPORTANCE_HIGH)  
    n2.Icon = "icon"  
    n2.Light = True  
    n2.SetInfo(Message.GetData.Get("title"), Message.GetData.Get("body"), Main)  
    n2.Notify(1)  
     
    Dim wake As PhoneWakeState  
    wake.ReleaseKeepAlive  
    Sleep(20)  
    wake.KeepAlive(False)  
    Sleep(20)  
    Speak_Text("I'm awoked !")  
End Sub
```