B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
Sub Class_Globals
	Private ctxt As JavaObject
	Private channelId As String = "custom_channel"
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	ctxt.InitializeContext
	CreateNotificationChannel
End Sub

' Esta función devuelve el objeto JavaObject listo para StartForeground
Public Sub Build(Title As String, State As String) As JavaObject
    
	' 1. OPTIONAL: Intent to open the application by clicking on the notification background ---
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


	' 2. RemoteViews - Your personalized layout
	Dim rvCustom As JavaObject = CreateRemoteViews("notif_custom_layout")
    
	' Configure Dynamic Texts
	Private mapMainTexts As Map = CreateMap("lblTitle":"Applied Sound Profile","lblState":"Normal")
	
	For i = 0 To mapMainTexts.Size - 1
		rvCustom.RunMethod("setTextViewText", _
    	Array(GetViewId(mapMainTexts.GetKeyAt(i)), mapMainTexts.GetValueAt(i)))
	Next
	
	Private mapLabels As Map = CreateMap("label1":"Label1", "label2":"Label2", "label3":"Label3", "label4":"Label4", "label5":"Label5")
	
	For j = 0 To mapLabels.Size - 1
		rvCustom.RunMethod("setTextViewText", _
		     Array(GetViewId(mapLabels.GetKeyAt(j)), mapLabels.GetValueAt(j)))
	Next
    
	' Configure ImageViews
	Private mapImageViews As Map = CreateMap("imageView1":"speaker_icon", "imageView3":"speaker_icon","imageView4":"device_mobile_vibration_icon","imageView5":"speaker_low_icon","imageView6":"mute_icon","imageView7":"night_icon")
	'imageView2 is the base for the lblTitle and lblState in the xml file, in this case
	
	For k = 0 To mapImageViews.Size - 1
		rvCustom.RunMethod("setImageViewResource", _
	    Array(GetViewId(mapImageViews.GetKeyAt(k)), GetDrawableId(mapImageViews.GetValueAt(k))))
	Next


	' 3. Configure Clicks (Actions)
	' Of labels
	For n = 0 To mapLabels.Size - 1
		rvCustom.RunMethod("setOnClickPendingIntent", _
		        Array(GetViewId(mapLabels.GetKeyAt(n)), CreateActionPendingIntent("ACTION" & (n + 11), n + 11)))
	Next
	
	'Of images
	For m = 1 To mapImageViews.Size - 1
		rvCustom.RunMethod("setOnClickPendingIntent", _
             Array(GetViewId(mapImageViews.GetKeyAt(m)), CreateActionPendingIntent("ACTION_" & m, m + 2)))
	Next


	' 4. Builder
	Dim builder As JavaObject
	builder.InitializeNewInstance("androidx.core.app.NotificationCompat$Builder", Array(ctxt, channelId))
    
	builder.RunMethod("setSmallIcon", Array(GetAppIcon))
	
	' We assigned the custom layout
	' Perhaps the correct thing to do is to use two different layouts
	builder.RunMethod("setCustomContentView", Array(rvCustom))		'Max height = ~64dp
'	builder.RunMethod("setCustomBigContentView", Array(rvCustomBig))	'Max height = ~256dp

	builder.RunMethod("setStyle", Array(CreateDecoratedStyle))
	builder.RunMethod("setPriority", Array(2))						' 2 = (PRIORITY_MAX), 0 = PRIORITY_DEFAULT, "MIN": -2, "LOW": -1
	builder.RunMethod("setOngoing", Array(True))
	
	' WE ASSIGN THE BACKGROUND CLICK
	builder.RunMethod("setContentIntent", Array(piMain))

	Return builder.RunMethod("build", Null)
End Sub



' Private Methods:

Private Sub CreateNotificationChannel
	Dim jo As JavaObject
	jo.InitializeContext

	Dim channel As JavaObject
	channel.InitializeNewInstance("android.app.NotificationChannel", _
        Array(channelId, "Notificaciones Custom", 3)) ' 4 = IMPORTANCE_HIGH, 3 = IMPORTANCE_DEFAULT
		
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
        Array("Channel with RemoteViews"))

	Dim manager As JavaObject = jo.RunMethod("getSystemService", _
        Array("notification"))

	manager.RunMethod("createNotificationChannel", Array(channel))
End Sub

Private Sub CreateActionPendingIntent(Action As String, RequestCode As Int) As JavaObject
	Dim ctxt As JavaObject
	ctxt.InitializeContext

	Dim i As Intent
	i.Initialize(Action, "")

	' IMPORTANT: In B4A, component names are usually in LOWERCASE in the manifest
	i.SetComponent(Application.PackageName & "/.myreceiver")	'Android is case-sensitive. Point it at your receiver.

	Dim jo As JavaObject
	jo.InitializeStatic("android.app.PendingIntent")

	Dim FLAG_IMMUTABLE As Int = 67108864
	Dim FLAG_UPDATE_CURRENT As Int = 134217728

	Return jo.RunMethod("getBroadcast", _
    Array(ctxt, RequestCode, i, _
          Bit.Or(FLAG_IMMUTABLE, FLAG_UPDATE_CURRENT)))
End Sub


' Helper methods:
Private Sub CreateRemoteViews(LayoutName As String) As JavaObject
	Dim ctxt As JavaObject
	ctxt.InitializeContext
    
	Dim pkg As String = ctxt.RunMethod("getPackageName", Null)
	Dim rv As JavaObject
	rv.InitializeNewInstance("android.widget.RemoteViews", _
        Array(pkg, GetLayoutId(LayoutName)))
    
	Return rv
End Sub

Private Sub GetViewId(ViewName As String) As Int
	Dim jo As JavaObject
	jo.InitializeStatic("anywheresoftware.b4a.BA")

	Dim ctxt As JavaObject = jo.GetField("applicationContext")
	Dim res As JavaObject = ctxt.RunMethod("getResources", Null)

	Return res.RunMethod("getIdentifier", _
        Array(ViewName, "id", Application.PackageName))
End Sub

Private Sub GetDrawableId(DrawableName As String) As Int
	Dim joR As JavaObject
	joR.InitializeStatic(Application.PackageName & ".R$drawable")
	Return joR.GetField(DrawableName)
End Sub

Private Sub GetAppIcon As Int
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim appInfo As JavaObject = ctxt.RunMethod("getApplicationInfo", Null)
	Return appInfo.GetField("icon")
End Sub

Private Sub GetLayoutId(LayoutName As String) As Int
	Dim jo As JavaObject
	jo.InitializeStatic("anywheresoftware.b4a.BA")

	Dim ctxt As JavaObject = jo.GetField("applicationContext")
	Dim res As JavaObject = ctxt.RunMethod("getResources", Null)

	Return res.RunMethod("getIdentifier", _
        Array(LayoutName.ToLowerCase, "layout", Application.PackageName))
End Sub

Private Sub CreateDecoratedStyle As JavaObject
	Dim style As JavaObject
	style.InitializeNewInstance( _
        "androidx.core.app.NotificationCompat$DecoratedCustomViewStyle", Null)
	Return style
End Sub