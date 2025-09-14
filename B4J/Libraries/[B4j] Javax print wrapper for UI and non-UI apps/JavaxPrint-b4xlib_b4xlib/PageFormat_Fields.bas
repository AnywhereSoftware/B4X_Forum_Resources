B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Code Module
Sub Process_Globals
	
End Sub

'The origin is at the bottom left of the paper with x running bottom to top and y running left to right.
Public Sub LANDSCAPE As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.print.PageFormat")
	Return Tjo.GetField("LANDSCAPE")
End Sub

'The origin is at the top left of the paper with x running to the right and y running down the paper.
Public Sub PORTRAIT As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.print.PageFormat")
	Return Tjo.GetField("PORTRAIT")
End Sub

'The origin is at the top right of the paper with x running top to bottom and y running right to left.
Public Sub REVERSE_LANDSCAPE As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.print.PageFormat")
	Return Tjo.GetField("REVERSE_LANDSCAPE")
End Sub

