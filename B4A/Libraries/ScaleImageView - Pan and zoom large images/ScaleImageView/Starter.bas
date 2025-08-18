B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=8.5
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	

	' Parameters for Viewer Activity
	Public ViewerTitle As String = "Viewer"
	Public ViewerFolder As String =  File.DirRootExternal & "/Download/"
	Public ViewerFilename As String =  "OS Search Map.jpg"
	Public ViewerX As Float = 0.5 ' Easting of map point, 0 to 1
	Public ViewerY As Float = 0.5 ' Northing of map point, 0 to 1
	Public ViewerZoom As Float = 2 ' Zoom level to open map
	Public CircleX As Float = 0.5 ' Easting of circle position, 0 to 1
	Public CircleY As Float = 0.5 ' Northing of circle position, 0 to 1
	
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
End Sub

Sub Service_Start (StartingIntent As Intent)
	

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
