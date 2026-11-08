B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=13.4
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private notificationId As Int = 2001
End Sub

Sub Service_Create

End Sub

Sub Service_Start (StartingIntent As Intent)
	
	'In this case, it's because the service is always active:
	Dim notification As JavaObject = ShowExtendedNotification
	
	' ⚠️ FOREGROUND
	Service.StartForeground(notificationId, notification)	'Notification ID
End Sub

Sub Service_Destroy

End Sub

Sub ShowExtendedNotification As JavaObject
	Dim ctxt As JavaObject
	ctxt.InitializeContext

	' === Canal ===
	CreateNotificationChannel
	
	
	' --- OPTIONAL: Intent to open the application by clicking on the notification background ---
	' To open your app when the notification body is tapped. You must configure the ContentIntent after.
	' This also applies To elements without a PendingIntent:
	Dim intentMain As Intent
	intentMain.Initialize("", "")
	intentMain.SetComponent(Application.PackageName & "/.main")
    
	Dim joPendingIntent As JavaObject
	Dim FLAG_IMMUTABLE As Int = 67108864
	Dim FLAG_UPDATE_CURRENT As Int = 134217728
    
	Dim piMain As JavaObject = joPendingIntent.InitializeStatic("android.app.PendingIntent") _
        .RunMethod("getActivity", Array(ctxt, 0, intentMain, Bit.Or(FLAG_IMMUTABLE, FLAG_UPDATE_CURRENT)))
	' ---------------------------------------------------------
	
	
	' RemoteViews - Tu layout personalizado
	Dim rvCustom As JavaObject = CreateRemoteViews("notif_custom_layout")
    
	' === CONFIGURE TEXTS ===
	Private mapMainTexts As Map = CreateMap("lblTitle":"Applied Sound Profile","lblState":"Normal")
	
	For i = 0 To mapMainTexts.Size - 1
		rvCustom.RunMethod("setTextViewText", _
    	Array(GetViewId(mapMainTexts.GetKeyAt(i)), mapMainTexts.GetValueAt(i)))
	Next
	
'	rvCustom.RunMethod("setTextViewText", _
'    	Array(GetViewId("lblTitle"), "Applied Sound Profile"))
'    
'	rvCustom.RunMethod("setTextViewText", _
'    	Array(GetViewId("lblState"), "Normal"))


	Private mapLabels As Map = CreateMap("label1":"Label1", "label2":"Label2", "label3":"Label3", "label4":"Label4", "label5":"Label5")
	
	For j = 0 To mapLabels.Size - 1
		rvCustom.RunMethod("setTextViewText", _
		     Array(GetViewId(mapLabels.GetKeyAt(j)), mapLabels.GetValueAt(j)))
	Next
        
'	rvCustom.RunMethod("setTextViewText", _
'        Array(GetViewId("label1"), "Label1"))
'        
'	rvCustom.RunMethod("setTextViewText", _
'        Array(GetViewId("label2"), "Label2"))
'        
'	rvCustom.RunMethod("setTextViewText", _
'        Array(GetViewId("label3"), "Label3"))
'        
'	rvCustom.RunMethod("setTextViewText", _
'        Array(GetViewId("label4"), "Label4"))
'        
'	rvCustom.RunMethod("setTextViewText", _
'        Array(GetViewId("label5"), "Label5"))
    
	
	
	' === CONFIGURE IMAGES ===
	Private mapImageViews As Map = CreateMap("imageView1":"speaker_icon", "imageView3":"speaker_icon","imageView4":"device_mobile_vibration_icon","imageView5":"speaker_low_icon","imageView6":"mute_icon","imageView7":"night_icon")
	'imageView2 is the base for the lblTitle and lblState in the xml file, in this case
	
	For k = 0 To mapImageViews.Size - 1
		rvCustom.RunMethod("setImageViewResource", _
	    Array(GetViewId(mapImageViews.GetKeyAt(k)), GetDrawableId(mapImageViews.GetValueAt(k))))
	Next
	
	
'	rvCustom.RunMethod("setImageViewResource", _
'	    Array(GetViewId("imageView1"), GetDrawableId("speaker_icon")))
'		
'	rvCustom.RunMethod("setImageViewResource", _
'	    Array(GetViewId("imageView3"), GetDrawableId("speaker_icon")))
'		
'	rvCustom.RunMethod("setImageViewResource", _
'	    Array(GetViewId("imageView4"), GetDrawableId("device_mobile_vibration_icon")))
'		
'	rvCustom.RunMethod("setImageViewResource", _
'	    Array(GetViewId("imageView5"), GetDrawableId("speaker_low_icon")))
'		
'	rvCustom.RunMethod("setImageViewResource", _
'	    Array(GetViewId("imageView6"), GetDrawableId("mute_icon")))
'		
'	rvCustom.RunMethod("setImageViewResource", _
'	    Array(GetViewId("imageView7"), GetDrawableId("night_icon")))
		
		
    
	' ===CONFIGURE CLICKS IN IMAGEVIEWS ===
'	rvCustom.RunMethod("setOnClickPendingIntent", _
'        Array(GetViewId("imageView1"), CreateActionPendingIntent("IMG1_CLICK", 1)))
'        
'	rvCustom.RunMethod("setOnClickPendingIntent", _
'        Array(GetViewId("imageView2"), CreateActionPendingIntent("IMG2_CLICK", 2)))

	For m = 1 To mapImageViews.Size - 1
		rvCustom.RunMethod("setOnClickPendingIntent", _
             Array(GetViewId(mapImageViews.GetKeyAt(m)), CreateActionPendingIntent("ACTION_" & m, m + 2)))
	Next
        
'	rvCustom.RunMethod("setOnClickPendingIntent", _
'        Array(GetViewId("imageView3"), CreateActionPendingIntent("ACTION_1", 3)))
'        
'	rvCustom.RunMethod("setOnClickPendingIntent", _
'        Array(GetViewId("imageView4"), CreateActionPendingIntent("ACTION_2", 4)))
'        
'	rvCustom.RunMethod("setOnClickPendingIntent", _
'        Array(GetViewId("imageView5"), CreateActionPendingIntent("ACTION_3", 5)))
'        
'	rvCustom.RunMethod("setOnClickPendingIntent", _
'        Array(GetViewId("imageView6"), CreateActionPendingIntent("ACTION_4", 6)))
'        
'	rvCustom.RunMethod("setOnClickPendingIntent", _
'        Array(GetViewId("imageView7"), CreateActionPendingIntent("ACTION_5", 7)))
    
	
	
	' === CONFIGURE CLICKS IN LABELS ===
	For n = 0 To mapLabels.Size - 1
		rvCustom.RunMethod("setOnClickPendingIntent", _
		        Array(GetViewId(mapLabels.GetKeyAt(n)), CreateActionPendingIntent("ACTION" & (n + 11), n + 11)))
	Next
	
'	rvCustom.RunMethod("setOnClickPendingIntent", _
'        Array(GetViewId("label1"), CreateActionPendingIntent("ACTION11", 11)))
'        
'	rvCustom.RunMethod("setOnClickPendingIntent", _
	'    Array(GetViewId("label2"), CreateActionPendingIntent("ACTION12", 12)))
'        
'	rvCustom.RunMethod("setOnClickPendingIntent", _
	'    Array(GetViewId("label3"), CreateActionPendingIntent("ACTION13", 13)))
'        
'	rvCustom.RunMethod("setOnClickPendingIntent", _
	'    Array(GetViewId("label4"), CreateActionPendingIntent("ACTION14", 14)))
'        
'	rvCustom.RunMethod("setOnClickPendingIntent", _
	'    Array(GetViewId("label5"), CreateActionPendingIntent("ACTION15", 15)))
		
				
    
	' === BUILDER ===
	Dim builder As JavaObject
	builder.InitializeNewInstance( _
        "androidx.core.app.NotificationCompat$Builder", _
        Array(ctxt, "custom_channel"))
        
	Private iconId As Int = GetAppIcon

	builder.RunMethod("setSmallIcon", Array(iconId))
    
	' We assigned the custom layout
	' Perhaps the correct thing to do is to use two different layouts
	builder.RunMethod("setCustomContentView", Array(rvCustom))		'Max height = ~64dp
'	builder.RunMethod("setCustomBigContentView", Array(rvCustomBig))	'Max height = ~256dp
    
	builder.RunMethod("setStyle", Array(CreateDecoratedStyle))
	builder.RunMethod("setPriority", Array(2))						' 2 = (PRIORITY_MAX), 0 = PRIORITY_DEFAULT, "MIN": -2, "LOW": -1
	builder.RunMethod("setOngoing", Array(True))
	
	
	' WE ASSIGN THE BACKGROUND CLICK
	builder.RunMethod("setContentIntent", Array(piMain))
	

	Dim notification As JavaObject = builder.RunMethod("build", Null)
	Return notification
End Sub

Sub GetAppIcon As Int
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim appInfo As JavaObject = ctxt.RunMethod("getApplicationInfo", Null)
	Return appInfo.GetField("icon")
End Sub

Sub CreateNotificationChannel
	Dim jo As JavaObject
	jo.InitializeContext

	Dim channel As JavaObject
	channel.InitializeNewInstance("android.app.NotificationChannel", _
        Array("custom_channel", "Notificaciones Custom", 3)) ' 4 = IMPORTANCE_HIGH, 3 = IMPORTANCE_DEFAULT

		
	'Turn on sound. Android creates the channel only once when you install the app. If that channel was created without sound, there will be no sound. Reinstall the app:
	
	'Option 1:
'	Dim rm As JavaObject
'	rm.InitializeStatic("android.media.RingtoneManager")
'
'	Dim uri As JavaObject
'	uri = rm.RunMethod("getDefaultUri", Array(rm.GetField("TYPE_NOTIFICATION")))
'	
'	channel.RunMethod("setSound", Array(uri, Null))

	'Option 2:
	Dim uri As JavaObject
	uri.InitializeStatic("android.net.Uri")
	uri = uri.RunMethod("parse", Array("content://settings/system/notification_sound"))
	
	channel.RunMethod("setSound", Array(uri, Null))


	channel.RunMethod("enableVibration", Array(True))
	channel.RunMethod("setShowBadge", Array(True))

	channel.RunMethod("setDescription", _
        Array("Canal con RemoteViews"))

	Dim manager As JavaObject = jo.RunMethod("getSystemService", _
        Array("notification"))

	manager.RunMethod("createNotificationChannel", Array(channel))
End Sub

Sub CreateActionPendingIntent(Action As String, RequestCode As Int) As JavaObject
	Dim ctxt As JavaObject
	ctxt.InitializeContext

	Dim intentAction As Intent
	intentAction.Initialize(Action, "")

	' IMPORTANT: In B4A, component names are usually in LOWERCASE in the manifest
	intentAction.SetComponent(Application.PackageName & "/.myreceiver")	'Android is case-sensitive (distinguishes between uppercase and lowercase letters)
	
	' Another option would be to send and process the Extra instead:
'	intentAction.GetExtra(ActionName)	'Action1, Action2...

	Dim jo As JavaObject
	jo.InitializeStatic("android.app.PendingIntent")

	Dim FLAG_IMMUTABLE As Int = 67108864
	Dim FLAG_UPDATE_CURRENT As Int = 134217728

	Return jo.RunMethod("getBroadcast", _
    Array(ctxt, RequestCode, intentAction, _
          Bit.Or(FLAG_IMMUTABLE, FLAG_UPDATE_CURRENT)))
End Sub

Sub CreateDecoratedStyle As JavaObject
	Dim style As JavaObject
	style.InitializeNewInstance( _
        "androidx.core.app.NotificationCompat$DecoratedCustomViewStyle", Null)
	Return style
End Sub

Sub CreateRemoteViews(LayoutName As String) As JavaObject
	Dim ctxt As JavaObject
	ctxt.InitializeContext
    
	Dim pkg As String = ctxt.RunMethod("getPackageName", Null)
	Dim rv As JavaObject
	rv.InitializeNewInstance("android.widget.RemoteViews", _
        Array(pkg, GetLayoutId(LayoutName)))
    
	Return rv
End Sub

Sub GetLayoutId(LayoutName As String) As Int
	Dim jo As JavaObject
	jo.InitializeStatic("anywheresoftware.b4a.BA")

	Dim ctxt As JavaObject = jo.GetField("applicationContext")
	Dim res As JavaObject = ctxt.RunMethod("getResources", Null)

	Return res.RunMethod("getIdentifier", _
        Array(LayoutName.ToLowerCase, "layout", Application.PackageName))
End Sub

Sub GetViewId(ViewName As String) As Int
	Dim jo As JavaObject
	jo.InitializeStatic("anywheresoftware.b4a.BA")

	Dim ctxt As JavaObject = jo.GetField("applicationContext")
	Dim res As JavaObject = ctxt.RunMethod("getResources", Null)

	Return res.RunMethod("getIdentifier", _
        Array(ViewName, "id", Application.PackageName))
End Sub

Sub GetDrawableId(DrawableName As String) As Int
	Dim joR As JavaObject
	joR.InitializeStatic(Application.PackageName & ".R$drawable")
	Return joR.GetField(DrawableName)
End Sub



' Debe ser Public para que el Receiver la vea
Public Sub ProcessActionButton(Accion As String)
	Log("Processing action: " & Accion)
	Select Accion
		Case "ACTION_1"
			' Logic
		Case "ACTION_2"
			' Logic
		Case "ACTION_3"
			' Logic
		Case "ACTION_4"
			' Logic
		Case "ACTION_5"
			' Logic
		Case "ACTION_11"
			' Logic
		Case "ACTION_12"
			' Logic
		Case "ACTION_13"
			' Logic
		Case "ACTION_14"
			' Logic
		Case "ACTION_15"
			' Logic
	End Select
End Sub
