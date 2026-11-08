B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13.4
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub GetContext() As JavaObject
	Dim context As JavaObject
	context.InitializeContext
	Return context
End Sub

Sub IsNotificationPolicyGranted() As Boolean
	Dim context As JavaObject
	context.InitializeContext
	Dim nm As JavaObject
	nm = context.RunMethod("getSystemService", Array("notification"))
	Return nm.RunMethod("isNotificationPolicyAccessGranted", Null)
End Sub