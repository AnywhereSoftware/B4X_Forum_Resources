### ShortcutBadger V1.7 by DonManfred
### 05/20/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/64305/)

This is a wrap for this [Github project](https://github.com/leolin310148/ShortcutBadger)  
  
The ShortcutBadger makes your Android App show the count of unread messages (or whatever count you want to show) as a badge on your App shortcut on your "Desktop"  
  
**ShortCutBadger  
Author:** DonManfred (wrapper)  
**Version:** 1.5  

- **ShortcutBadger**
Methods:

- **Initialize**
- **IsInitialized As Boolean**
- **applyCount** (badgeCount As Int) **As Boolean**
*Tries to update the notification count  
context: Caller context  
badgeCount: Desired badge count  
 Return type: @return:true in case of success, false otherwise*- **applyCountOrThrow** (badgeCount As Int)
*Tries to update the notification count, throw a {@link ShortcutBadgeException} if it fails  
context: Caller context  
 badgeCount: Desired badge count*- **removeCount As Boolean**
*Tries to remove the notification count  
context: Caller context  
 Return type: @return:true in case of success, false otherwise*- **removeCountOrThrow**
*Tries to remove the notification count, throw a {@link ShortcutBadgeException} if it fails  
 context: Caller context*
  
Please note that the Example here is prepared to be used on Samsung Devices as it contains the Permissions needed on Samsung Device.  
  
[SIZE=3]Note the AppPermission commands in manifest editor:  
  
For Samsung:  

```B4X
AddPermission(com.sec.android.provider.badge.permission.READ)  
AddPermission(com.sec.android.provider.badge.permission.WRITE)
```

  
  
For HTC:  

```B4X
AddPermission(com.htc.launcher.permission.READ_SETTINGS)  
AddPermission(com.htc.launcher.permission.UPDATE_SHORTCUT)
```

  
  
For SONY:  

```B4X
AddPermission(com.sonyericsson.home.permission.BROADCAST_BADGE)
```

[/SIZE]  
  
For APEX:  
[SIZE=3]

```B4X
AddPermission(com.anddoes.launcher.permission.UPDATE_COUNT)
```

  
  
For Solid:[/SIZE]  

```B4X
AddPermission(com.majeur.launcher.permission.UPDATE_BADGE)
```

  
  
Code used  
  

```B4X
Sub Globals  
  'These global variables will be redeclared each time the activity is created.  
  'These variables can only be accessed from this module.  
  Dim badge As ShortcutBadger  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
  'Do not forget to load the layout file created with the visual designer. For example:  
  'Activity.LoadLayout("Layout1")  
  badge.Initialize()  
  
  badge.applyCount(17)  
End Sub
```

  
  
Please Note the count of 17 to find the icon in the Screenshot  
  
The Screenshot here is from the Nova Launcher running on my Samsung S6 EDGE  
![](http://snapshots.basic4android.de/Screenshot_20160303-201736.png)  
  
If you want to donate for my work building the wrapper you can do it here: [![](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=AHKKJCKJE8N7W)