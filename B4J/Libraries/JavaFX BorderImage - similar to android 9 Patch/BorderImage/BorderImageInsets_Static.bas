B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.9
@EndOfDesignText@
'Code Module
Sub Process_Globals
	
End Sub

'Empty insets.
Public Sub EMPTY As BorderImageInsets
	Dim Wrapper As BorderImageInsets
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javafx.geometry.Insets")
	Wrapper.SetObject(Tjo.GetField("EMPTY"))
	Return Wrapper
End Sub

