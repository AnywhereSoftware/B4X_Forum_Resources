B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.5
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim mp As MediaProjectionScreenShot
	Dim bmp As Bitmap
	Dim timRec As Timer
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
	mp.Initialize("mp")
	timRec.Initialize("timRec", 200)	'timer for screenshotting without stop
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

Sub Start_Working
	Sleep(1000)	'some time to hide the activity
	timRec_Tick
End Sub

Sub Stop_Working
	Try
		timRec.Enabled = False
		mp.stop	'stop the mediaprojection and hide the notification area icon
		Log("stopped OK")
	Catch
		Log(LastException)
	End Try
End Sub

Sub mp_imageready(bm As Object)
	Dim bmp As Bitmap = bm
	Log("mp_imageready")
	If bmp <> Null Then
		Save_Photo(bmp, "screen.png")	'see the result picture in the root folder of the device
		Log(bmp.Width)
		Log(bmp.Height)
	Else
		Log("Null bitmap")
	End If
	timRec.Enabled = True	'next screenshot
End Sub

Sub Save_Photo (Pt As Bitmap, filename As String)
	Dim Out As OutputStream
	Out = File.OpenOutput(File.DirRootExternal, filename, False)
	Pt.WriteToStream(Out, 30, "JPEG")
	Out.Close
End Sub

Sub timRec_Tick
	timRec.Enabled = False
	mp.init(0, 0, 0)	'0 for auto-calculation of each parameter
	mp.TakeScreenshot	'make one screenshot
End Sub

