B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.51
@EndOfDesignText@
'Static code module
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