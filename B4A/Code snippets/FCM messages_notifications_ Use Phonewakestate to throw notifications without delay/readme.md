### FCM messages/notifications: Use Phonewakestate to throw notifications without delay by KMatle
### 04/26/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/130137/)

I mentioned that my fcm messages arrive without delay (data messages), but throwing a notification (even with high priority) doesn't work all the time when the phone sleeps.  
  
Setting the phonewakestate before throwing the notification and releasing it after seems to work:  
  

```B4X
    pws.PartialLock  
    Dim n As NB6  
    MyIcon = LoadBitmapResize(File.DirAssets, "Someicon.JPG", 24dip, 24dip, False)  
    n.Initialize("default", Application.LabelName, "HIGH").AutoCancel(True).SmallIcon(MyIcon)  
    n.Build("FCM", "Message sent: " & MyData.get("time") & ", Notification created at " & DateTime.Time(DateTime.Now), "tag1", Main).Notify(4)  
    pws.ReleasePartialLock
```

  
  
Phone Lib is needed pws is defined as phonewakestate in globals in the fcm service (code above is in the service, too)