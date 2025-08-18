### NB6 class - additional functions by wes58
### 12/08/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/104319/)

I have been using Barx's great notification builder library for a while. But now, I thought that maybe I should check current Notifications API with Channels and Erel's class NB6.  
I noticed that Google removed some methods and that some things that I used before are not  
implemented in the NB6 class.  
Therefore, I have decided to add some of them.  
  
1. First, I needed an InboxStyle Notification. A notification where you can add a list of 6 lines of text (I saw mention of max. 5 lines and somewhere else 6 lines)  
  
Here is the code to be added to NB6 class:  

```B4X
'Creates a "Inbox" notification.  
Public Sub InboxStyle(SummaryText As Object, Text As List) As NB6  
 If IsBuilder Then  
  
  Dim style As JavaObject  
  style.InitializeNewInstance("android.app.Notification$InboxStyle", Null)  
  style.RunMethod("setSummaryText", Array(SummaryText))  
  Dim i As Int  
  For i = 0 To (Min(5, Text.size-1)) 'max. number of lines is set to 6 (from 0 to 5)  
   style.RunMethod("addLine", Array(Text.Get(i)))  
  Next  
  NotificationBuilder.RunMethod("setStyle", Array(style))  
 End If  
Return Me  
End Sub
```

  
  
2 Use Chronometer  
Show the Notification#when field as a stopwatch. Instead of presenting "when" as a timestamp, the notification will show an automatically updating display of the minutes and seconds since when. Useful when showing an elapsed time (like an ongoing phone call).  
Here is the code to be added to NB6 class:  

```B4X
'Show the stopwatch.  
'Instead of presenting when as a timestamp,  
'the notification will show an automatically updating display of the minutes and seconds  
Public Sub UsesChronometer(useChronometer As Boolean) As NB6  
 If IsBuilder Then  
  NotificationBuilder.RunMethod("setShowWhen", Array(True))  
  NotificationBuilder.RunMethod("setUsesChronometer", Array(useChronometer))  
 End If  
 Return Me  
End Sub
```

  
  
3. TimeoutAfter  
Specifies a duration in milliseconds after which this notification should be canceled, if it is not already canceled.  
Here is the code to be added to NB6 class:  

```B4X
'Specifies a duration in milliseconds after which this notification should be canceled, if it is not already canceled.  
'Used in SDK > 25 only  
Public Sub TimeoutAfter(durationMs As Long) As NB6  
 If IsChannel Then  
  NotificationBuilder.RunMethod("setTimeoutAfter", Array(durationMs))  
 End If  
 Return Me  
End Sub
```

  
  
4. OnGoing  
Set whether this is an "ongoing" notification. Ongoing notifications cannot be dismissed by the user, so your application or service must take care of canceling them.  
Here is the code to be added to NB6 class:  

```B4X
Public Sub OnGoing(On_going As Boolean) As NB6  
 If IsBuilder Then  
  NotificationBuilder.RunMethod("setOngoing", Array(On_going))  
 End If  
 Return Me  
End Sub
```

  
  
5. CustomVibrate  
Vibrate with a given pattern.  
Pass in an array of ints that are the durations for which to turn on or off the vibrator in milliseconds. The first value indicates the number of milliseconds to wait before turning the vibrator on.  
The next value indicates the number of milliseconds for which to keep the vibrator on before turning it off. Subsequent values alternate between durations in milliseconds to turn the vibrator off or to turn the vibrator on.  
API >= 26  
If the provided pattern is valid (non-null, non-empty), will enable vibration as well. Otherwise, vibration will be disabled. Only modifiable before the channel is submitted.  
Here is the code to be added to NB6 class:  

```B4X
'Set the vibration pattern to use.  
'Pass in an array of ints that are the durations for which to turn on or off the vibrator in milliseconds  
'The first value indicates the number of milliseconds to wait before turning the vibrator on.  
'The next value indicates the number of milliseconds for which to keep the vibrator on before turning it off… And so on  
Public Sub CustomVibrate(vibPatern() As Long) As NB6  
 If IsChannel Then  
  Channel.RunMethod("setVibrationPattern", Array(vibPatern))  
 Else  
  If Not(IsOld) Then  
   nDefaults = Bit.And(nDefaults, 1 + 4) 'clear bit 1  
  End If  
  NotificationBuilder.RunMethod("setVibrate", Array(vibPatern))  
 End If  
 Return Me  
End Sub
```

  
  
6. CustomLight  
Set the desired color for the indicator LED on the device, as well as the blink duty cycle (specified in milliseconds). Not all devices will honor all (or even any) of these values.  
On and Off times can only be used with API < 26. They will be ignored for API >= 26 - pass 0 values  
API >= 26  
Sets the notification light color for notifications posted to this channel, if lights are enabled on this channel and the device supports that feature. Only modifiable before the channel is submitted to  
Here is the code to be added to NB6 class:  

```B4X
'Set the desired color for the indicator LED on the device, as well as the blink duty cycle (specified in milliseconds)  
'duty cycle ignored on SDK > 25. Use 0, 0 in sub call for onMs and offMs for SDK > 25  
Public Sub CustomLight(argb As Int, onMs As Int, offMs As Int) As NB6  
 If IsChannel Then  
  Channel.RunMethod("setLightColor", Array(argb))  
 Else  
   If Not(IsOld) Then  
    nDefaults = Bit.And(nDefaults, 1 + 2) 'clear bit 2  
   End If  
   NotificationBuilder.RunMethod("setLights", Array(argb, onMs, offMs))  
 End If  
 Return Me  
End Sub
```

  
  
7. Modified code for CustomSound - explanation why it had to be done, below.  
Here is the code to be added to NB6 class:  

```B4X
'Sets a custom sound.  
'The uri must be created with FileProvider.  
Public Sub CustomSound (FileProviderUri As Object) As NB6  
 If IsOld Then Return Me  
 ctxt.RunMethod("grantUriPermission", Array("com.android.systemui", FileProviderUri, 1))  
 If IsBuilder Then  
  ' NotificationBuilder.RunMethod("setSound", Array(FileProviderUri, NotificationStatic.GetField("AUDIO_ATTRIBUTES_DEFAULT")))  
   If IsChannel Then  
    ctxt.RunMethod("grantUriPermission", Array("com.android.systemui", FileProviderUri, 1))  
Channel.RunMethod("setSound", Array(FileProviderUri, NotificationStatic.GetField("AUDIO_ATTRIBUTES_DEFAULT")))  
   Else  
     If Not(IsOld) Then  
      nDefaults = Bit.And(nDefaults, 2 + 4) 'clear bit 0  
    End If  
    NotificationBuilder.RunMethod("setSound", Array(FileProviderUri, NotificationStatic.GetField("AUDIO_ATTRIBUTES_DEFAULT")))  
   End If  
 End If  
 Return Me  
End Sub
```

  
  
8. I have noticed that Sub setDefaults(sound, light, vibration) in NB6 doesn't work correctly when used with Notifications with and without Channels  
For API >= 26  
setDefaults(false, false, false) means - no sound, no lights, no vibration  
setDefaults(ture, true, true) means - enable sound (default, or custom if provided), enable light (default color or custom if provided),  
enable vibration(default vibration pattern or custom if provided)  
For API < 26  
setDefaults(false, false, false) means - custom sound, custom lights and custom vibration pattern  
setDefaults(true, true, true) means - default sound, default lights color and defualt vibration pattern.  
  
So, true values mean "enable…" (default or custom for API >= 26, and default only for API < 26.  
Therefore I had to modify existing sub CustomSound in NB6.  
I also had to modify sub Build:  
  
variable nDefaults has to be added to Class\_Globals in NB6 class:  

```B4X
Sub Class_Globals  
Private nDefaults As Int = 7 '1 (default sound) + 2 (default lighs) + 4 (default vib.)  
…  
…
```

  
  
Here is the code to be changed in Sub Build, in NB6 class:  

```B4X
'Build the notification and returns the notification object.  
'ContentTitle - Title (CharSequence)  
'ContentText - Body text (CharSequence)  
'Tag - Tag that can be intercepted in Activity_Resume when the user clicks on the notificaiton.  
'Activity - The activity that will be launched when the user clicks on the notification.  
Public Sub Build (ContentTitle As Object, ContentText As Object, Tag As String, Activity As Object) As Notification  
 If IsOld Then  
  OldNotification.SetInfo2(ContentTitle, ContentText, Tag, Activity)  
  Return OldNotification  
 Else  
 If Not(IsChannel) And nDefaults <> 7 Then 'not all true 'added code  
  NotificationBuilder.RunMethod("setDefaults", Array(nDefaults))  
 End If  
 Dim in As Intent = CreateIntent(Activity, False)  
  in.Flags = Bit.Or(268435456, 131072) 'FLAG_ACTIVITY_NEW_TASK and FLAG_ACTIVITY_REORDER_TO_FRONT  
  in.PutExtra("Notification_Tag", Tag)  
  Dim PendingIntent As Object = PendingIntentStatic.RunMethod("getActivity", Array(ctxt, Rnd(0, 0x7fffffff), in, 0))  
  NotificationBuilder.RunMethodJO("setContentTitle", Array(ContentTitle)).RunMethodJO("setContentText", Array(ContentText))  
  NotificationBuilder.RunMethod("setContentIntent", Array(PendingIntent))  
  
  If IsChannel Then  
   Dim manager As JavaObject = ctxt.RunMethod("getSystemService", Array("notification"))  
   manager.RunMethod("createNotificationChannel", Array(Channel))  
  
  End If  
  Return NotificationBuilder.RunMethod("build", Null)  
 End If  
End Sub
```

  
  
9. Colorized  
Set whether this notification should be colorized. When set, the color set with sub Color(int) will be used as the background color of this notification.  
This should only be used for high priority ongoing tasks like navigation, an ongoing call, or other similarly high-priority events for the user.  
For most styles, the coloring will only be applied if the notification is for a foreground service notification  
  
Note: Although I tried, I couldn't get this method working!!! I added the code just in case it is a Google bug and they will fix it.  
Here is the code to be added to NB6 class:  

```B4X
'Set whether this notification should be colorized.  
'When set, the color set with setColor(int) will be used as the background color of this notification.  
Public Sub Colorized(colorize As Boolean) As NB6  
 If IsChannel Then  
  NotificationBuilder.RunMethod("setColorized", Array(colorize))  
 End If  
Return Me  
End Sub
```

  
  
10. Description - API >= 26 only  
Sets the user visible description of this channel.  
The recommended maximum length is 300 characters; the value may be truncated if it is too long.  
Here is the code to be added to NB6 class:  

```B4X
Public Sub Description(text As String) As NB6  
 If IsChannel Then  
  Channel.RunMethod("setDescription", Array(text))  
 End If  
 Return Me  
End Sub
```

  
  
Here is an example for Inbox Notification using some of other added methods:  

```B4X
Sub Inbox_Notification  
Dim n As NB6  
n.Initialize(chEmail, "Email", "HIGH").SmallIcon(smiley).AutoCancel(False) '.Ongoing(True)  
n.Description("notification from Email app")  
Dim largeIcon As Bitmap = LoadBitmapResize(File.DirAssets, "logo.png", 256dip, 256dip, True)  
n.LargeIcon(largeIcon) 'optional  
n.SetDefaults(True, True, True)  
  
Dim v() As Long  
v = Array As Long(0, 200) ', 600, 800, 1200, 1600)  
n.CustomVibrate(v)  
  
n.CustomLight(Colors.Yellow, 1000, 500) 'values 1000, 500 will be ignored for API >= 26  
  
n.UsesChronometer(True)  
  
n.TimeoutAfter(1000*180) 'clear notification after 180 sec.  
  
Dim msgLine As List  
msgLine.Initialize  
msgLine.Add("this is line 1")  
msgLine.Add("this is line 2")  
msgLine.Add("this is line 3")  
msgLine.Add("this is line 4")  
msgLine.Add("this is line 5")  
msgLine.Add("this is line 6")  
Dim text As String = "+" & (msgLine.Size-1) & " More"  
n.InboxStyle(text, msgLine)  
text = "Your have " & msgLine.Size & " New Emails"  
n.Build(text, msgLine.Get(0), "tag", Me).Notify(8)  
End Sub
```

  
  
Google Description of the new notification with Channels:  
Starting in Android 8.0 (API level 26), all notifications must be assigned to a channel. For each channel, you can set the visual and auditory behavior that is applied to all notifications in that channel.  
Then, users can change these settings and decide which notification channels from your app should be intrusive or visible at all.  
After you create a notification channel, you cannot change the notification behaviors—the user has complete control at that point. Though you can still change a channel's name and description.  
  
Google says that after creation of the channel "the user has complete control at that point". Which is not true. The user has a limited (by Google) control.  
We could give user more control with previous Notification API.  
  
To provide the user access to these notification settings, you should add an item in your app's settings UI that opens these system settings.  
That's why it is important to give a meaninful "ChannelName" when creating the channel.  
I have added a "Description" sub because the Description appears in the App. Notification Settings.  
Below is the code to:  
1. Open App. Notification Settings - from there the user can choose and open channel setting.  
2. Open App. Channel Settings for selected channel - you have to specify channelID that you want to see the seetings for. The user can modify some settings.  
3. Delete Channel with specified channelID - unfortunately, this only removes the channel from the App. Notification Settings. When you re-initialise it, it will show up with the settings  
that the channel was created with before.  
  
For 2 and 3 you have to be careful, because that ChannelId that you supply to the NB6 Initialize Sub is not the ChannelId that is used when the Channel is created.  
There is a line of code in this sub that changes it.  
**ChannelId = ChannelId & "\_" & ImportanceLevel**  
I think that this line should be removed.  
Here is the code:  

```B4X
Sub deleteChannel(chID As String)  
 Dim jo As JavaObject  
 If chID = "" Then  
  ToastMessageShow("Invalid channel ID", False)  
  Return  
 End If  
 jo.InitializeContext ' = Me  
 jo.RunMethod("DelNotifChannel", Array(chID))  
End Sub  
  
Sub OpenAppNotifSet  
 Dim jo As JavaObject  
 jo.InitializeContext  
 jo.RunMethod("openAppSettings", Null)  
End Sub  
  
Sub OpenNotifChannelSet(chID As String)  
 Dim jo As JavaObject  
 If chID = "" Then  
  ToastMessageShow("Invalid channel ID", False)  
  Return  
 End If  
 jo.InitializeContext  
 jo.RunMethod("openChannelSettings", Array(chID))  
End Sub  
  
#if JAVA  
import android.content.Context;  
import android.app.NotificationManager;  
import android.content.Intent;  
import static android.provider.Settings.ACTION_CHANNEL_NOTIFICATION_SETTINGS;  
import static android.provider.Settings.ACTION_APP_NOTIFICATION_SETTINGS;  
import static android.provider.Settings.EXTRA_APP_PACKAGE;  
import static android.provider.Settings.EXTRA_CHANNEL_ID;  
  
public void DelNotifChannel(String id){  
 Context context = BA.applicationContext;  
 NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);  
 notificationManager.deleteNotificationChannel(id);  
}  
  
public void openAppSettings(){  
 Context context = BA.applicationContext;  
 Intent intent = new Intent(ACTION_APP_NOTIFICATION_SETTINGS);  
 intent.putExtra(EXTRA_APP_PACKAGE, context.getPackageName());  
 context.startActivity(intent);  
}  
  
public void openChannelSettings(String id){  
 Context context = BA.applicationContext;  
 Intent intent = new Intent(ACTION_CHANNEL_NOTIFICATION_SETTINGS);  
 intent.putExtra(EXTRA_APP_PACKAGE, context.getPackageName());  
 intent.putExtra(EXTRA_CHANNEL_ID, id);  
 context.startActivity(intent);  
}  
#End If
```

  
Because the only way to change some channel settings (like notificaion light on/off, color, vibration pattern) it is to unistall the app, or clear app data.  
The workaround (if necessary), to modify all channel settings and give the user option to modify them in your app seetings page could be like this:  
1. User opens Notification Settings page in your app and makes changes.  
2. If the changes are made. Delete the channel.  
3. Initialize new channel with new ID and old name and description. A channel ID can be changed for example like this "sms1", "sms2", "sms3" etc.  
The only drawback is, that the size of app data increases with every addition of the new channel.  
  
After all this, I can't say the new notification API is any better from the previous one. I thing it is a step back by Google. And it is not the first time.  
That's why I will stick to the old Notification API with the NB6.  
But to do this I had to modify NB6 Initialze sub, because it is using BuildOS version to determine what notifications to use.  
I changed it, to add an option to use targetSDK version specified in the manifest as well  
Becuase I don't post my app on the Google PlayStore, I don't care about Google's requirement for targetSDK version  
Here is the code just in case someone wants it.  

```B4X
#if JAVA  
import android.content.Context;  
import android.app.NotificationManager;  
  
public int getTargetSDK(){  
Context context = BA.applicationContext;  
int targetSdkVersion = context.getApplicationInfo().targetSdkVersion;  
return targetSdkVersion;  
}  
#End If  
  
'Initializes the builder.  
'ChannelId - On Android 8+ notifications are grouped by channels. Some of the features belong to the channel  
' and not to the specific notification.  
' Note that once a notification channel is created, you cannot change its behavior without uninstalling the app.  
' NB6 adds the notification level string to the ChannelId so in most cases you can use the same value for all notifications.  
'Channel Name - The channel name that appears when pressing on All Categories button (Android 8+).  
'ImportanceLevel - MIN, LOW, DEFAULT, HIGH  
'MIN - Minimum interrup. Cannot be used with foreground services.  
'LOW - Without sound.  
'DEFAULT - With sound.  
'HIGH - Might appear as a headup notification.  
'useBuildVersionSDK - TRUE use OS build SDK version. If FALSE use TargetSDK Version from manifest  
Public Sub Initialize (ChannelId As String, ChannelName As Object, ImportanceLevel As String, useBuildVersionSDK As Boolean) As NB6  
ctxt.InitializeContext  
PendingIntentStatic.InitializeStatic("android.app.PendingIntent")  
NotificationStatic.InitializeStatic("android.app.Notification")  
common.InitializeStatic("anywheresoftware.b4a.keywords.Common")  
Dim jo As JavaObject  
If useBuildVersionSDK Then  
SdkLevel = jo.InitializeStatic("android.os.Build$VERSION").GetField("SDK_INT")  
Else 'targetSDK  
jo = Me  
SdkLevel = jo.RunMethod("getTargetSDK", Null)  
End If  
If SdkLevel < 23 Then  
Log("support sOld")  
SupportLevel = S_OLD  
Else if SdkLevel >= 26 Then  
Log("support sChannel " & ChannelId & " " & ChannelName)  
SupportLevel = S_CHANNEL  
Else  
Log("support sBuilder")  
SupportLevel = S_BUILDER  
End If  
If IsOld Then  
OldNotification.Initialize  
OldNotification.Icon = "icon"  
Else if IsChannel Then  
NotificationBuilder.InitializeNewInstance("android.app.Notification$Builder", Array(ctxt, ChannelId))  
Dim im As Map = CreateMap("MIN": 1, "LOW": 2, "DEFAULT": 3, "HIGH": 4)  
Dim i As Int = im.Get(ImportanceLevel)  
Channel.InitializeNewInstance("android.app.NotificationChannel", Array(ChannelId, ChannelName, i))  
Else  
NotificationBuilder.InitializeNewInstance("android.app.Notification$Builder", Array(ctxt))  
Dim pm As Map = CreateMap("MIN": -2, "LOW": -1, "DEFAULT": 0, "HIGH": 1)  
Dim p As Int = pm.Get(ImportanceLevel)  
NotificationBuilder.RunMethod("setPriority", Array(p))  
End If  
If ImportanceLevel = "DEFAULT" Or ImportanceLevel = "HIGH" Then  
SetDefaults(True, True, True)  
Else  
SetDefaults(False, True, True)  
End If  
nDefaults = 1+2+4 'all true sound, vibration, light  
Return Me  
End Sub
```

  
  
There are some other methods available in new Notification API which could be implemented as well.