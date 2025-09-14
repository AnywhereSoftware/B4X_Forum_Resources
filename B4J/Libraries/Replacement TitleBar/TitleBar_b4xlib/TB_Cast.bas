B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.5
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

Public Sub AsJavaObject(JO As JavaObject) As JavaObject
	Return JO
End Sub

Public Sub AsLabel(L As Label) As Label
	Return L
End Sub

Public Sub AsNode(N As Node) As Node
	Return N
End Sub

Public Sub AsB4XView(B As B4XView) As B4XView
	Return B
End Sub