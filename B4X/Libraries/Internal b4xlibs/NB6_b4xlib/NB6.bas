B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.08
@EndOfDesignText@
Sub Class_Globals
	Private Channel As JavaObject
	Private NotificationBuilder As JavaObject
	Private SdkLevel As Int
	Private ctxt As JavaObject
	Private const S_OLD = 0, S_BUILDER = 1, S_CHANNEL = 2 As Int
	Private SupportLevel As Int
	Private OldNotification As Notification
	Private PendingIntentStatic As JavaObject
	Private NotificationStatic As JavaObject
	Private common As JavaObject
	
End Sub

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
Public Sub Initialize (ChannelId As String, ChannelName As Object, ImportanceLevel As String) As NB6
	ctxt.InitializeContext
	PendingIntentStatic.InitializeStatic("android.app.PendingIntent")
	NotificationStatic.InitializeStatic("android.app.Notification")
	common.InitializeStatic("anywheresoftware.b4a.keywords.Common")
	Dim jo As JavaObject
	SdkLevel = jo.InitializeStatic("android.os.Build$VERSION").GetField("SDK_INT")
	If SdkLevel < 23 Or (SdkLevel = 23 And IsIncompatibleDevice) Then
		SupportLevel = S_OLD
	Else if SdkLevel >= 26 Then
		SupportLevel = S_CHANNEL
	Else
		SupportLevel = S_BUILDER
	End If
	If IsOld Then
		OldNotification.Initialize
		OldNotification.Icon = "icon"
	Else if IsChannel Then
		ChannelId = ChannelId & "_" & ImportanceLevel
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
	Return Me
End Sub

Private Sub IsIncompatibleDevice As Boolean
	Dim jo As JavaObject
	Dim model As String = jo.InitializeStatic("android.os.Build").GetField("MODEL")
	Dim manufacturer As String = jo.InitializeStatic("android.os.Build").GetField("MANUFACTURER")
	Dim key As String = manufacturer & " " & model
	Log("key: " & key)
	Dim ProblematicDevices As Map = CreateMap("Samsung Galaxy S5": "", "Sony XPreria M5": "")
	If ProblematicDevices.ContainsKey(key) Then
		Log("Problematic device. Switching to 'old' mode.")
		Return True
	End If
	Return False
End Sub

'Adds a button action.
'Bmp - Button image. Not always appears.
'Title - Button title (CharSequence)
'Service - The service that will receive the action. <b>Cannot be the Starter service.</b>
'Action - The action in the StartingIntent.
Public Sub AddButtonAction (Bmp As Bitmap, Title As Object,  Service As Object, Action As String) As NB6
	If IsBuilder = False Then Return Me
	Dim ac As Object = CreateAction(Bmp, Title, CreateReceiverPendingIntent(Service, Action))
	NotificationBuilder.RunMethod("addAction", Array(ac))
	Return Me
End Sub

'Similar to AddButtonAction. Starts an activity instead of a service.
Public Sub AddButtonAction2 (Bmp As Bitmap, Title As Object,  Activity As Object, Action As String) As NB6
	If IsBuilder = False Then Return Me
	Dim in As Intent = CreateIntent(Activity, False)
	in.Action = Action
	in.Flags = Bit.Or(268435456, 131072) 'FLAG_ACTIVITY_NEW_TASK and FLAG_ACTIVITY_REORDER_TO_FRONT
	Dim PendingIntent As Object = PendingIntentStatic.RunMethod("getActivity", Array(ctxt, Rnd(0, 0x7fffffff), in, GetPendingIntentFlag))
	NotificationBuilder.RunMethod("setContentIntent", Array(PendingIntent))
	Dim Ac As Object = CreateAction(Bmp, Title, PendingIntent)
	NotificationBuilder.RunMethod("addAction", Array(Ac))
	Return Me
End Sub

'Used for reply fields: <link>more information|https://www.b4x.com/android/forum/threads/notification-with-reply-field.130039/</link>
Public Sub AddRemoteInput (Bmp As Bitmap, Title As Object, ResultKey As String, Service As Object) As NB6
	If IsBuilder = False Then Return Me
	Dim RemoteInputBuilder As JavaObject
	RemoteInputBuilder.InitializeNewInstance("android.app.RemoteInput$Builder", Array(ResultKey))
	RemoteInputBuilder.RunMethod("setLabel", Array(Title))
	Dim builder As JavaObject
	builder.InitializeNewInstance("android.app.Notification$Action$Builder", Array(CreateIconFromBitmap(Bmp), Title, CreateReceiverPendingIntent(Service, ResultKey)))
	builder.RunMethod("addRemoteInput", Array(RemoteInputBuilder.RunMethod("build", Null)))
	Dim ac As JavaObject = builder.RunMethod("build", Null)
	NotificationBuilder.RunMethod("addAction", Array(ac))
	Return Me
End Sub



'Action intent that will be sent when the notification is deleted.
'Service - The service that will receive the action. <b>Cannot be the Starter service.</b>
'Action - The action in the StartingIntent.
Public Sub DeleteAction (Service As Object, Action As String) As NB6
	If IsBuilder Then
		NotificationBuilder.RunMethod("setDeleteIntent", Array(CreateReceiverPendingIntent(Service, Action)))
	End If
	Return Me
End Sub

'Sets the notification icon on old devices. By default the app icon will be used.
Public Sub OldNotificationIcon (ResourceName As String) As NB6
	If IsOld Then
		OldNotification.Icon = ResourceName		
	End If
	Return Me
End Sub

'Sets the status bar icon. The icon size should be 24 x 24.
Public Sub SmallIcon (Icon As Bitmap) As NB6
	If IsBuilder Then
		NotificationBuilder.RunMethod("setSmallIcon", Array(CreateIconFromBitmap(Icon)))
	End If
	Return Me
End Sub

'Sets the content icon. Should be 256 x 256.
Public Sub LargeIcon (Icon As Bitmap) As NB6
	If IsBuilder Then
		NotificationBuilder.RunMethod("setLargeIcon", Array(CreateIconFromBitmap(Icon)))
	End If
	Return Me
End Sub

'Only plays a sound if the notification is not already displayed.
Public Sub OnlyAlertOnce (Once As Boolean) As NB6
	If IsBuilder Then
		NotificationBuilder.RunMethod("setOnlyAlertOnce", Array(Once))
	End If
	Return Me
End Sub

'Cancels the notification when the user clicks on it.
Public Sub AutoCancel (Cancel As Boolean) As NB6
	If IsOld Then
		OldNotification.AutoCancel = Cancel
	Else
		NotificationBuilder.RunMethod("setAutoCancel", Array(Cancel))
	End If
	Return Me
End Sub

Public Sub OnGoing (OnGoingEvent As Boolean) As NB6
	If IsOld Then
		OldNotification.OnGoingEvent = OnGoingEvent
	Else 
		NotificationBuilder.RunMethod("setOngoing", Array(OnGoingEvent))
	End If
	Return Me
End Sub

'One of the following values: NONE, SMALL, LARGE
'Not supported by all launchers.
Public Sub BadgeIconType (IconType As String) As NB6
	If SdkLevel >= 26 Then
		Dim m As Map = CreateMap("LARGE": 2, "NONE": 0, "SMALL": 1)
		NotificationBuilder.RunMethod("setBadgeIconType", Array(m.Get(IconType)))
	End If
	Return Me
End Sub

'Sets whether notifications posted to this channel can appear as application icon badges in a Launcher
Public Sub ShowBadge (Show As Boolean) As NB6
	If SdkLevel >= 26 Then
		Channel.RunMethod("setShowBadge", Array(Show))
	End If
	Return Me
End Sub

'Sets the accent color.
Public Sub Color (Clr As Int) As NB6
	If IsBuilder Then
		NotificationBuilder.RunMethod("setColor", Array(Clr))
	End If
	Return Me
End Sub

'Whether to use the accent color for the background. Not applied in all cases.
'For most styles, the coloring will only be applied if the notification is for a foreground service notification.
Public Sub Colorized (Enabled As Boolean) As NB6
	If IsBuilder Then
		If SdkLevel >= 26 Then
			NotificationBuilder.RunMethod("setColorized", Array(True))
		End If
	End If
	Return Me
End Sub

'Sets a number that might be displayed as a badge.
Public Sub Number (Num As Int) As NB6
	If IsOld Then
		OldNotification.Number = Num
	Else
		NotificationBuilder.RunMethod("setNumber", Array(Num))
	End If
	Return Me
End Sub

'Shows a timestamp
Public Sub ShowWhen (Time As Long) As NB6
	If IsBuilder Then
		NotificationBuilder.RunMethod("setShowWhen", Array(True))
		NotificationBuilder.RunMethod("setWhen", Array(Time))
	End If
	Return Me
End Sub

'Shows a progress bar. Cannot be used with SubText.
'Value - Current value.
'MaxValue - Maximum value.
'Indeterminate - Set to true for an indeterminate progress bar.
Public Sub Progress (Value As Int, MaxValue As Int, Indeterminate As Boolean) As NB6
	If IsBuilder Then
		NotificationBuilder.RunMethod("setProgress", Array(MaxValue, Value, Indeterminate))
	End If
	Return Me
End Sub

'Additional text. Occupies the same place as the progress bar so do not use both features.
Public Sub SubText (Text As Object) As NB6
	If IsBuilder Then
		NotificationBuilder.RunMethod("setSubText", Array(Text))
	End If
	Return Me
End Sub

'Set which features will be inherited from the system defaults.
'The defaults are also set based on the importance level.
Public Sub SetDefaults (Sound As Boolean, Light As Boolean, Vibrate As Boolean) As NB6
	If IsOld Then
		OldNotification.Sound = Sound
		OldNotification.Light = Light
		OldNotification.Vibrate = Vibrate
	Else
		If IsChannel Then
			Channel.RunMethod("enableLights", Array(Light))
			Channel.RunMethod("enableVibration", Array(Vibrate))
		Else
			Dim CurrentDefaults As Int
			If Sound Then CurrentDefaults = 1
			If Vibrate Then CurrentDefaults = Bit.Or(CurrentDefaults, 2)
			If Light Then CurrentDefaults = Bit.Or(CurrentDefaults, 4)
			NotificationBuilder.RunMethod("setDefaults", Array(CurrentDefaults))
		End If
	End If
	Return Me
End Sub

'Sets a custom sound.
'The uri must be created with FileProvider.
Public Sub CustomSound (FileProviderUri As Object) As NB6
	If IsOld Then Return Me
	ctxt.RunMethod("grantUriPermission", Array("com.android.systemui", FileProviderUri, 1))
	If IsBuilder Then
		NotificationBuilder.RunMethod("setSound", Array(FileProviderUri, NotificationStatic.GetField("AUDIO_ATTRIBUTES_DEFAULT")))
		If IsChannel Then
			Channel.RunMethod("setSound", Array(FileProviderUri, NotificationStatic.GetField("AUDIO_ATTRIBUTES_DEFAULT")))
		End If
	End If
	Return Me
End Sub

'Possible values: PUBLIC, PRIVATE or SECRET
'Default value is PRIVATE.
'PRIVATE - notification content will not appear above secure lock screen. Title and icon will appear.
'PUBLIC - notification content will appear everywhere.
'SECRET - notification will not appear at all above secure lock screen.
Public Sub Visibility (Value As String) As NB6
	If IsBuilder Then
		Dim m As Map = CreateMap("PUBLIC": 1, "SECRET": -1, "PRIVATE": 0)
		Dim i As Int = m.Get(Value)
		NotificationBuilder.RunMethod("setVisibility", Array(i))
	End If
	Return Me
End Sub

'Creates a "big picture" notification.
Public Sub BigPictureStyle(LargeIconBmp As Bitmap, Picture As Bitmap, ContentTitle As Object, SummaryText As Object) As NB6
	If IsBuilder Then
		SetStyle("android.app.Notification$BigPictureStyle", _
			CreateMap("bigLargeIcon": LargeIconBmp, _
				"bigPicture": Picture, _
				"setBigContentTitle": ContentTitle, _
				"setSummaryText": SummaryText))
	End If
	Return Me
End Sub

'Creates a media style notification
Public Sub MediaStyle As NB6
	If IsBuilder Then
		SetStyle("android.app.Notification$MediaStyle", CreateMap("setShowActionsInCompactView": Array As Int(0, 1, 2)))
	End If
	Return Me
End Sub

'Creates a "big text" notification.
Public Sub BigTextStyle (ContentTitle As Object, SummaryText As Object, Text As Object) As NB6
	If IsBuilder Then
		SetStyle("android.app.Notification$BigTextStyle", _
			CreateMap("bigText": Text, "setBigContentTitle": ContentTitle, "setSummaryText": SummaryText))
	End If
	Return Me
End Sub

Public Sub SetLights (Clr As Int, OnMs As Int, OffMs As Int) As NB6
	NotificationBuilder.RunMethod("setLights", Array(Clr, OnMs, OffMs))
	Return Me
End Sub

'Sets the notification category.
'Value should be a CATEGORY constant: <link>docs|https://developer.android.com/reference/android/app/Notification</link>
Public Sub SetCategory (Category As String) As NB6
	If IsBuilder Then
		NotificationBuilder.RunMethod("setCategory", Array(NotificationStatic.GetField(Category)))
	End If
	Return Me
End Sub




Private Sub SetStyle(StyleName As String, Props As Map)
	Dim style As JavaObject
	style.InitializeNewInstance(StyleName, Null)
	For Each method As String In Props.Keys
		Dim value As Object = Props.Get(method)
		If value <> Null Then
			style.RunMethod(method, Array(value))
		End If
	Next
	NotificationBuilder.RunMethod("setStyle", Array(style))
End Sub

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
		Dim in As Intent = CreateIntent(Activity, False)
		in.Flags = Bit.Or(268435456, 131072) 'FLAG_ACTIVITY_NEW_TASK and FLAG_ACTIVITY_REORDER_TO_FRONT
		in.PutExtra("Notification_Tag", Tag)
		
		Dim PendingIntent As Object = PendingIntentStatic.RunMethod("getActivity", Array(ctxt, Rnd(0, 0x7fffffff), in, GetPendingIntentFlag))
		NotificationBuilder.RunMethodJO("setContentTitle", Array(ContentTitle)).RunMethodJO("setContentText", Array(ContentText))
		NotificationBuilder.RunMethod("setContentIntent", Array(PendingIntent))
		
		If IsChannel Then
			Dim manager As JavaObject = ctxt.RunMethod("getSystemService", Array("notification"))
			manager.RunMethod("createNotificationChannel", Array(Channel))
			
		End If
		Return NotificationBuilder.RunMethod("build", Null)
	End If
End Sub

Private Sub CreateReceiverPendingIntent (Service As Object, Action As String) As Object
	Dim in As Intent = CreateIntent(Service, True)
	in.Action = Action
	Return PendingIntentStatic.RunMethod("getBroadcast", Array(ctxt, 1, in, GetPendingIntentFlag))
End Sub

Private Sub GetPendingIntentFlag As Int
	Dim flags As Int = 0
	If SdkLevel >= 31 Then flags = Bit.Or(flags, 33554432) 'FLAG_MUTABLE
	Return flags
End Sub

Private Sub CreateIntent (Target As Object, Receiver As Boolean) As Intent
	Target = common.RunMethod("getComponentClass", Array(Null, Target, Receiver))
	Dim in As JavaObject
	in.InitializeNewInstance("android.content.Intent", Array(ctxt, Target))
	Return in
End Sub

Private Sub CreateAction (Bmp As Bitmap, Title As Object, PendingIntent As Object) As Object
	Dim builder As JavaObject
	builder.InitializeNewInstance("android.app.Notification$Action$Builder", Array(CreateIconFromBitmap(Bmp), Title, PendingIntent))
	Return builder.RunMethod("build", Null)
End Sub

Private Sub CreateIconFromBitmap(bmp As Bitmap) As Object
	If bmp = Null Or bmp.IsInitialized = False Then Return 0
	Dim icon As JavaObject
	Return icon.InitializeStatic("android.graphics.drawable.Icon").RunMethod("createWithBitmap", Array(bmp))
End Sub

Private Sub IsBuilder As Boolean
	Return SupportLevel >= S_BUILDER
End Sub

Private Sub IsOld As Boolean
	Return SupportLevel = S_OLD
End Sub

Private Sub IsChannel As Boolean
	Return SupportLevel = S_CHANNEL
End Sub

