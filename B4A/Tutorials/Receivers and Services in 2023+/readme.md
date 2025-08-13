### Receivers and Services in 2023+ by Erel
### 07/28/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/145370/)

In the early days of Android services were simple to use and powerful. They allowed doing all kinds of things in the backgrounds with very few restrictions. That's not the case with newer versions of Android.  
With a few exceptions (that aren't 100% reliable), the only use case for services is to let the app **continue** to do its job while it moves to the background - for example a music player app or navigation app.  
  
B4A v12.2 includes a new type of module named Receiver or the Java term *static Broadcast Receiver*. Receivers "listen" to intents and are started when a relevant intent is received.  
The default code is:  

```B4X
Sub Process_Globals  
   
End Sub  
  
'Called when an intent is received.  
'Do not assume that anything else, including the starter service, has run before this method.  
Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)  
   
End Sub
```

  
Receivers aren't actively listening to intents. It is the OS that is responsible for starting the process after a relevant intent was sent.  
There are two types of intents that are deemed relevant:  
1. Intents that explicitly target the receiver. For example, such intent is created when we schedule a receiver to start with StartReceiverAt.  
2. Intents with actions that are defined in the manifest editor. For example, if we want to run something after boot:  

```B4X
AddPermission(android.permission.RECEIVE_BOOT_COMPLETED)  
AddReceiverText(MyReceiver, <intent-filter>  
<action android:name="android.intent.action.BOOT_COMPLETED"/>  
</intent-filter>)
```

  
A few use cases for receivers:  

- Handling push notifications
- Scheduling receivers to run
- Home screen widgets
- Activity recognition
- Run after boot
- And more…

**Q. Can receivers do everything that services can?**  
  
A. No. Receivers run for a short time. There is no similar feature to foreground services where a service can continue to run in the background indefinitely.  
  
**Q. I don't need new stuff. I will continue to use my beloved services for all of these use cases.**  
  
A. Good for you, but your app will crash on Android 12+ devices with this error when the process is started from the background:  
  
*Fatal Exception: java.lang.RuntimeException: Unable to start receiver b4a.example.starter$starter\_BR: android.app.ForegroundServiceStartNotAllowedException: startForegroundService() not allowed due to mAllowStartForeground false: service b4a.example/.starter*  
  
Related tutorial: <https://www.b4x.com/android/forum/threads/android-14-targetsdkversion-34-and-services.162140/#content>  
  
**Notes**  

- The starter service will not start before the receiver when a process starts from a receiver.
- The *CancelScheduledService* keyword, which cancels services scheduled with *StartServiceAt*, also works with receivers scheduled with *StartReceiverAt*.
- B4A services are actually made of a receiver + service. These automatic receivers are named <service>\_BR. Not too important but you might encountered those in the past.