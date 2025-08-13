### AS Alarm - Alarm clock or keep app active in the background by Alexander Stolte
### 01/24/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/163593/)

I needed a way to play a sound at a certain time even though the app is in the background. The problem is that the app is paused as soon as it goes into the background, you can delay this by 30 seconds, but if you take longer, the app is stopped and no more code is executed. Now I have found a way to work around this.  
  
I came across the following flutter library:  
<https://pub.dev/packages/alarm>  
When building the B4X library, I used it as a guide and learned a lot from it.  
  
I've been using AS\_Alarm in my [EasyPlate](https://apps.apple.com/de/app/easyplate/id1643722813) app for a few months now to get a countdown in the gym between sets when my break is coming to an end. So far I haven't had any problems, the alarm has always been issued reliably, even though I was using several apps and listening to music at the same time. My next goal is to build an alarm clock app with it, but so far I haven't had the time to implement this.  
I am looking forward to any feedback.  
  
**How it works**  
As soon as an alarm is set, a silent sound is played in the background and repeated until the alarm is set to go off, keeping the app active in the background. You can listen to your music normally during this time without any problems, the silent sound does not affect this.  
The only thing that is affected is the battery life, which should also be communicated to the user if you have an alarm clock app.  
  
**Setup**  
1. Paste the following code to the [ICODE]Project Attributes[/ICODE] in the "Main" module  
Replace [ICODE]com.stoltex.alarm[/ICODE] with your package name  

```B4X
    #PlistExtra: <key>BGTaskSchedulerPermittedIdentifiers</key>  
    #PlistExtra: <array>  
    #PlistExtra:       <string>com.stoltex.alarm</string>  
    #PlistExtra: </array>  
    #PlistExtra: <key>UIBackgroundModes</key>  
    #PlistExtra: <array>  
    #PlistExtra:    <string>audio</string>  
    #PlistExtra:    <string>fetch</string>  
    #PlistExtra: </array>
```

  
  
2. Initialize the lib. in the [ICODE]Application\_Start[/ICODE] sub on the "Main" module  
3. We need the [ICODE]Application\_Terminate[/ICODE] event  
If the user stops the app by terminating the process, a notification is displayed that the alarm is not being executed  

```B4X
'Add this to the main menu if you want to notify the user if the app is terminated and the alarm will not triggered  
Private Sub Application_Terminate  
    Alarm.ApplicationTerminated  
End Sub
```

  
3.1. Dont miss the [ICODE]App.RegisterUserNotifications(True,True,True)[/ICODE] for the notifications  
3.2 You need the [UserNotificationCenter class](https://www.b4x.com/android/forum/threads/usernotificationcenter-class.117925/) and add this to the project  
3.3 You can customize the title and body of the message  

```B4X
Alarm.SetNotificationOnAppKillContent("Your alarms may not ring","You killed the app. Please reopen so your alarms can be rescheduled.")
```

  
  
**Example project is attached  
  
Examples**  

```B4X
Private Sub xlbl_Start_Click  
   
    'Trigger the alarm in one minute  
    CreateAlarm(1,DateTime.Now + DateTime.TicksPerMinute*1,File.Combine(File.DirAssets,"alarm_1.mp3"),False)  
  
End Sub  
  
Private Sub CreateAlarm(Id As Int,Date As Long,AssetPath As String,LoopAudio As Boolean)  
    Dim NewAlarmSettings As AS_AlarmSettings  
    NewAlarmSettings.Initialize  
    NewAlarmSettings.Id = Id 'Unique id for the alarm  
    NewAlarmSettings.Date = Date 'When the alarm should be triggered  
    NewAlarmSettings.AssetAudioPath = AssetPath 'Path to the sound file  
    NewAlarmSettings.LoopAudio = LoopAudio 'Should the music be played until Alarm.StopAlarm is called up  
    NewAlarmSettings.Volume = 1 '0-1 Volume  
    NewAlarmSettings.FadeDuration = DateTime.TicksPerSecond*11 'Should the sound be played from quiet to loud  
  
    Main.Alarm.SetAlarm(NewAlarmSettings)  
    Log(DateUtils.TicksToString(NewAlarmSettings.Date))  
  
End Sub
```

  
  
Notes:  

- The App termination notification is only displayed if an active alarm is still set

**Changelog**  

- **1.00**

- Release

**Github:** [github.com/StolteX/AS\_Alarm](https://github.com/StolteX/AS_Alarm)  
  
Have Fun :)