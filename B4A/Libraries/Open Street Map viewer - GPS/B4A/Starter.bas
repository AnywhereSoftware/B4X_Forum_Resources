B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.9
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private fGPSStarted As Boolean=False
	Public fRP As RuntimePermissions
	Public fGPS As GPS
	Public fGPSCallback As Object=Null
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
	fGPS.Initialize("GPS")
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

Sub Service_TaskRemoved
	'This event will be raised when the user removes the app from the recent apps list.
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub

Public Sub Start_Gps
	If fGPSStarted = False Then
		fGPS.Start(0,0)
		fGPSStarted=True
	End If
End Sub

Public Sub Stop_Gps
	If fGPSStarted Then
		fGPS.Stop
		fGPSStarted=False
	End If
End Sub

public Sub setGPSCallback(aObject As Object)
	fGPSCallback=aObject
End Sub

private Sub GPS_LocationChanged (aLocation As Location)
	If fGPSCallback<>Null Then
   		CallSub2(fGPSCallback,"GPS_LocationChanged",aLocation)
	End If
End Sub