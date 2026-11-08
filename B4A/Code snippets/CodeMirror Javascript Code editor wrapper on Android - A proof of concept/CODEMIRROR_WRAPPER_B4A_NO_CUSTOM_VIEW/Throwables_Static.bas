B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'Static code module
'Subs in this code module will be accessible from all modules.

Sub Process_Globals
	
End Sub

'Constructs an IllegalArgumentException with the specified detail message.
Public Sub NewIllegalArgumentException(S As String) As IllegalArgumentException
	Dim TObj As IllegalArgumentException
	TObj.Initialize
	TObj.Create(S)
	Return TObj
End Sub
'
'Constructs an IllegalArgumentException with the specified detail message.
Public Sub NewNumberFormatException(S As String) As NumberFormatException
	Dim TObj As NumberFormatException
	TObj.Initialize
	TObj.Create(S)
	Return TObj
End Sub
