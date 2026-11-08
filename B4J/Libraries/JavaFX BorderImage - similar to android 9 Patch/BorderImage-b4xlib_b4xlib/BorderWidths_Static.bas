B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.9
@EndOfDesignText@
'Code Module
Sub Process_Globals
	
	End Sub

'When used by a BorderStroke, the value of AUTO is interpreted as the value of BorderStroke.MEDIUM for the corresponding side.
Public Sub AUTO As Double
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javafx.scene.layout.BorderWidths")
	Return Tjo.GetField("AUTO")
End Sub

'The default BorderWidths that is used by a BorderImage when null is specified.
Public Sub DEFAULT As BorderWidths
	Dim Wrapper As BorderWidths
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javafx.scene.layout.BorderWidths")
	Wrapper.SetObject(Tjo.GetField("DEFAULT"))
	Return Wrapper
End Sub

'An empty set of widths, such that all values are 0 and are literal values.
Public Sub EMPTY As BorderWidths
	Dim Wrapper As BorderWidths
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javafx.scene.layout.BorderWidths")
	Wrapper.SetObject(Tjo.GetField("EMPTY"))
	Return Wrapper
End Sub

'A set of widths representing 100% on each side.
Public Sub FULL As BorderWidths
	Dim Wrapper As BorderWidths
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javafx.scene.layout.BorderWidths")
	Wrapper.SetObject(Tjo.GetField("FULL"))
	Return Wrapper
End Sub

