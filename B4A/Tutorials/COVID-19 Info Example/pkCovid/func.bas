B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.801
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub IIF(c As Boolean, TrueRes As String, FalseRes As String) As Object
	If c Then Return TrueRes Else Return FalseRes
End Sub