B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private TF As TextFlowClass
	Private XUI As XUI
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(PL As PageLayout)
	TF = NewInstance_TextFlow.TextFlow
	TF.GetObject.As(B4XView).SetLayoutAnimated(0,0,0, PL.GetPrintableWidth, PL.GetPrintableHeight)
End Sub

Sub Measure(Text As String,TFont As Font) As B4XRect
	TF.Clear
	Dim T As TextClass = NewInstance_TextFlow.Text.setText(Text).SetFont(TFont)
	TF.AddNode(T)
	T.ApplyCss
	Dim Bounds As JavaObject = T.GetLayoutBounds
	Dim R As B4XRect
	R.Initialize(Bounds.RunMethod("getMinX",Null),Bounds.RunMethod("getMinY",Null),Bounds.RunMethod("getMaxX",Null),Bounds.RunMethod("getMaxY",Null))
	Return R
End Sub