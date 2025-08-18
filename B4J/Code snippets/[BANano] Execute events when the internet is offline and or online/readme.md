### [BANano] Execute events when the internet is offline and or online by Mashiane
### 03/17/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/139232/)

Hi there  
  
The browser has a very nice way to detect whether its offline (internet off) and online (internet on), without one having to define a timer. The window object has an online and an offline status event. This can be useful when you want, when the internet goes off, log off a user etc etc.  
  
![](https://www.b4x.com/android/forum/attachments/126737)  
  
  
So I have a class (in a library) that I initialize when my app starts. In the Initialize event I have added  
  

```B4X
'each time a connection changes, call the handleConnectionChange callback  
    Dim e As BANanoEvent  
    Dim ch As BANanoObject = BANano.CallBack(Me, "handleConnectionChange", Array(e))  
    BANano.window.addEventListener("online", ch, True)  
    BANano.window.addEventListener("offline", ch, True)
```

  
   
The **handleConnectionChange** callback will be fired whenever the internet is offline and online. This will call a sub called **ConnectionChange** in my project.  
  
What I do is to pass a true (online) and a false (offline) result to another sub I need called  
  

```B4X
Private Sub handleConnectionChange(e As BANanoEvent)        'ignoreDeadCode  
    Dim status As String = e.Type  
    Dim bOn As Boolean  
    Select Case status  
    Case "online"  
        bOn = True  
    Case "offline"  
        bOn = False          
    End Select  
    If SubExists(EventHandler, "ConnectionChange") Then  
        CallSub2(EventHandler, "ConnectionChange", bOn)  
    End If  
End Sub
```

  
  
I later ran my app, turned toggled my wifi state. works like a charm.  
  

```B4X
Private Sub ConnectionChange (status As Boolean)  
    Log("ConnectionChange…")  
    Log(status)  
End Sub
```

  
  
#SharingTheGoodness