B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=12.2
@EndOfDesignText@
Sub Process_Globals
	Private client As JavaObject
	Private context As JavaObject
	Private PendingIntent As Object
	Type Geofence (Id As String, Center As Location, RadiusMeters As Float, ExpirationMs As Long)

End Sub

Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
	If FirstTime Then
		context.InitializeContext
		Dim LocationServices As JavaObject
		LocationServices.InitializeStatic("com.google.android.gms.location.LocationServices")
		client = LocationServices.RunMethod("getGeofencingClient", Array(context))
		PendingIntent = CreatePendingIntent
	End If
	Dim GeofencingEvent As JavaObject
	GeofencingEvent.InitializeStatic("com.google.android.gms.location.GeofencingEvent")
	GeofencingEvent = GeofencingEvent.RunMethod("fromIntent", Array(StartingIntent))
	if GeofencingEvent.IsInitialized = False Then Return
	Dim transtion As Int = GeofencingEvent.RunMethod("getGeofenceTransition", Null)
	If transtion > 0 Then
		Dim geofences As List = GeofencingEvent.RunMethod("getTriggeringGeofences", Null)
		If geofences.Size > 0 Then
			Dim geofence As JavaObject = geofences.Get(0)
			Dim id As String = geofence.RunMethod("getRequestId", Null)
			If transtion = 1 Then
				Geofence_Enter(id)
			Else If transtion = 2 Then
				Geofence_Exit(id)
			End If
		End If
		
	End If
End Sub

Private Sub Geofence_Enter (Id As String)
	Log("Geofence_Enter: " & Id)
	Dim n As Notification
	n.Initialize
	n.Icon = "icon"
	n.SetInfo("Enter: " & Id, "Enter", Main)
	n.Notify(1)
	ToastMessageShow("Enter: " & Id, True)
End Sub

Private Sub Geofence_Exit (Id As String)
	Log("Geofence_Exit: " & Id)
	ToastMessageShow("Exit: " & Id, True)
	Dim n As Notification
	n.Initialize
	n.Icon = "icon"
	n.SetInfo("Exit: " & Id, "Exit", Main)
	n.Notify(2)
End Sub

Public Sub AddGeofence(Callback As Object, geo As Geofence)
	Dim gb As JavaObject = CreateGeofenceBuilder(geo)
	Dim req As JavaObject = CreateGeofenceRequest(gb)
	Dim task As JavaObject = client.RunMethod("addGeofences", Array(req, PendingIntent))
	Do While task.RunMethod("isComplete", Null) = False
		Sleep(50)
	Loop
	Dim success As Boolean = task.RunMethod("isSuccessful", Null)
	If success = False Then
		Log(task.RunMethod("getException", Null))
	End If
	CallSubDelayed2(Callback, "Geofence_Added", success)
End Sub

Private Sub CreateGeofenceBuilder (geo As Geofence) As JavaObject
	Dim builder As JavaObject
	builder.InitializeNewInstance("com.google.android.gms.location.Geofence$Builder", Null)
	builder.RunMethod("setRequestId", Array(geo.Id))
	builder.RunMethod("setExpirationDuration", Array(geo.ExpirationMs))
	builder.RunMethod("setCircularRegion", Array(geo.Center.Latitude, geo.Center.Longitude, geo.RadiusMeters))
	builder.RunMethod("setTransitionTypes", Array(3)) 'GEOFENCE_TRANSITION_ENTER | GEOFENCE_TRANSITION_EXIT
	builder.RunMethod("setNotificationResponsiveness", Array(5000)) '5000ms
	Return builder
End Sub

Private Sub CreateGeofenceRequest (GeofenceBuilder As JavaObject) As JavaObject
	Dim builder As JavaObject
	builder.InitializeNewInstance("com.google.android.gms.location.GeofencingRequest$Builder", Null)
	builder.RunMethod("setInitialTrigger", Array(1)) 'INITIAL_TRIGGER_ENTER
	builder.RunMethod("addGeofence", Array(GeofenceBuilder.RunMethod("build", Null)))
	Return builder.RunMethod("build", Null)
End Sub

Private Sub CreatePendingIntent As Object
	Dim jo As JavaObject
	jo.InitializeStatic("anywheresoftware.b4a.keywords.Common")
	Dim cls As Object = jo.RunMethod("getComponentClass", Array(Null, "GeofenceReceiver", True))
	Dim in As JavaObject
	in.InitializeNewInstance("android.content.Intent", Array(context, cls))
	
	Dim flags As Int = 134217728
	Dim p As Phone
	if p.SdkVersion >= 31 Then flags = Bit.Or(flags, 33554432) 'FLAG_MUTABLE
	Dim pi As JavaObject
	pi = pi.InitializeStatic("android.app.PendingIntent").RunMethod("getBroadcast", _
  		Array(context, 1, in, flags))
	Return pi
End Sub