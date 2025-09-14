B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

Public Sub TextFlow As TextFlowClass
	Dim TF As TextFlowClass
	TF.Initialize
	TF.Create
	Return TF
End Sub

Public Sub Text As TextClass
	Dim TC As TextClass
	TC.Initialize
	TC.Create
	Return TC
End Sub
