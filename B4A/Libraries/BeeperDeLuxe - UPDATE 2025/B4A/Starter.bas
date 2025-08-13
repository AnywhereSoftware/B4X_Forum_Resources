B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.85
@EndOfDesignText@
'###############################################
' Starter - App starting point
'-----------------------------------------------
' Name:			Starter
' Version:		1		
' Depend Libs:	Core
' Depend Mod.:	-
' Depend Class:	-
' Layout:		-
' Files:		-
' Other:		-
'-----------------------------------------------
' (C) TechDoc G. Becker | TD_ProjTemplateB4XPages 1.0
'###############################################

'## Standard Code not modified ##

#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

'###############################################

#region Globals
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
End Sub
#end region

'###############################################

#region Service
Sub Service_Create
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
#end region

'###############################################
' (C) TechDoc G. Becker 
'###############################################