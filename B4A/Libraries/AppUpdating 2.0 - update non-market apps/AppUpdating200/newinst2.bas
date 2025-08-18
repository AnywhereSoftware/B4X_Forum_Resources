B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=7.3
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim pkg As String
	Dim svcVerbose As Boolean
	Private LogColor1 As Int = 0xFFFF8C00		'color for log messages
End Sub

Sub Service_Create
	LogColor("---- AppUpdating.newinst2: service created", LogColor1)
	pkg = ""
	svcVerbose = False
End Sub

Sub Service_Start (StartingIntent As Intent)
	LogColor("---- AppUpdating.newinst2: service_started", LogColor1)
	If svcVerbose Then
		Log($"${TAB}intent: ${StartingIntent}"$)
		Log($"${TAB}action: ${StartingIntent.Action}"$)
		Log($"${TAB}extra: ${StartingIntent.ExtrasToString}"$)
		Log($"${TAB}data: ${StartingIntent.GetData}"$)
	End If		
	If StartingIntent.Action = "android.intent.action.PACKAGE_REPLACED" Then
		If svcVerbose Then Log($"${TAB}Package REPLACED intent received!"$)
		pkg = GetPackageName
		If svcVerbose Then Log($"${TAB}package: ${pkg}"$)
		If StartingIntent.GetData = "package:" & pkg Then
			MyAppReload
    	End If
	End If	
End Sub

Sub Service_Destroy
End Sub

Sub GetPackageName As String
	Dim r As Reflector
	Return r.GetStaticField("anywheresoftware.b4a.BA", "packageName")
End Sub

Sub MyAppReload
	If svcVerbose Then Log("-- AppUpdating.NewInst2: processing MyAppReload")
	If IsPaused("main") Then
		StartActivity("main")
	End If
	'Dim In As Intent
	'StartActivity(pkg&"/.main")
End Sub
