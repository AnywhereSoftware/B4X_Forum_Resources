B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=10.7
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	
	Private nid As Int = 1
	Private lock As PhoneWakeState
	
	'**********************
	
	Dim kvs As KeyValueStore
	Dim sdir As String
	Dim count As Int
	
End Sub

Sub Service_Create
	
	Service.AutomaticForegroundMode = Service.AUTOMATIC_FOREGROUND_NEVER 'we are handling it ourselves
	lock.PartialLock

End Sub

Sub Service_Start (StartingIntent As Intent)

	Dim rp As RuntimePermissions
	Service.StartForeground(nid, CreateNotification(""))

	sdir=rp.GetSafeDirDefaultExternal("")
	
	If IsPaused(Main)=True Then 
		kvs.Initialize(sdir,"KVSDir")
		count=kvs.Get("count")
		count=count+1
		kvs.Put("count",count)
		kvs.Close
	
		ToastMessageShow("count=" & count,False)
		
	Else
		
		CallSubDelayed(Main,"Button1_Click")
	
	End If

	'schedule next run
	StartServiceAt(Me, DateTime.Now+5*DateTime.TicksPerSecond,True)
	
End Sub

Sub Service_Destroy
	lock.ReleasePartialLock
End Sub

Sub CreateNotification (Body As String) As Notification
	Dim notification As Notification
	notification.Initialize2(notification.IMPORTANCE_LOW)
	notification.Icon = Null
	notification.SetInfo("Auto ON", Body, Main)
	Return notification
End Sub