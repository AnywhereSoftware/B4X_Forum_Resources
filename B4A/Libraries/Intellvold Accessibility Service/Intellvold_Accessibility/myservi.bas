B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=12.5
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim myservice2 As Intellvold_AccessibilityService

End Sub

Sub Service_Create

End Sub

Sub Service_Start (StartingIntent As Intent)
	myservice2.Initialize(Me ,"myserevent2" ,"MyAccessibilityService")
	
End Sub

Sub Service_Destroy

End Sub

Sub myserevent2_Intellvold_AccessibilityService_Event(packname As String , text As String)

Log("packname : "&packname)
Log("text : "&text)

End Sub
