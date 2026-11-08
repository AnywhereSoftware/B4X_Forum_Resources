B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Code Module
Sub Process_Globals

End Sub

'The color black.
Public Sub BLACK As AWTColor
	Dim Wrapper As AWTColor
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Color")
	Wrapper.SetObject(Tjo.GetField("BLACK"))
	Return Wrapper
End Sub


'The color blue.
Public Sub BLUE As AWTColor
	Dim Wrapper As AWTColor
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Color")
	Wrapper.SetObject(Tjo.GetField("BLUE"))
	Return Wrapper
End Sub

'The color cyan.
Public Sub CYAN As AWTColor
	Dim Wrapper As AWTColor
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Color")
	Wrapper.SetObject(Tjo.GetField("CYAN"))
	Return Wrapper
End Sub

'The color dark gray.
Public Sub DARK_GRAY As AWTColor
	Dim Wrapper As AWTColor
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Color")
	Wrapper.SetObject(Tjo.GetField("DARK_GRAY"))
	Return Wrapper
End Sub

'The color gray.
Public Sub GRAY As AWTColor
	Dim Wrapper As AWTColor
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Color")
	Wrapper.SetObject(Tjo.GetField("GRAY"))
	Return Wrapper
End Sub

'The color green.
Public Sub GREEN As AWTColor
	Dim Wrapper As AWTColor
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Color")
	Wrapper.SetObject(Tjo.GetField("GREEN"))
	Return Wrapper
End Sub

'The color light gray.
Public Sub LIGHT_GRAY As AWTColor
	Dim Wrapper As AWTColor
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Color")
	Wrapper.SetObject(Tjo.GetField("LIGHT_GRAY"))
	Return Wrapper
End Sub

'The color magenta.
Public Sub MAGENTA As AWTColor
	Dim Wrapper As AWTColor
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Color")
	Wrapper.SetObject(Tjo.GetField("MAGENTA"))
	Return Wrapper
End Sub

'The color orange.
Public Sub ORANGE As AWTColor
	Dim Wrapper As AWTColor
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Color")
	Wrapper.SetObject(Tjo.GetField("ORANGE"))
	Return Wrapper
End Sub

'The color pink.
Public Sub PINK As AWTColor
	Dim Wrapper As AWTColor
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Color")
	Wrapper.SetObject(Tjo.GetField("PINK"))
	Return Wrapper
End Sub

'The color red.
Public Sub RED As AWTColor
	Dim Wrapper As AWTColor
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Color")
	Wrapper.SetObject(Tjo.GetField("RED"))
	Return Wrapper
End Sub
'The color white.
Public Sub WHITE As AWTColor
	Dim Wrapper As AWTColor
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Color")
	Wrapper.SetObject(Tjo.GetField("WHITE"))
	Return Wrapper
End Sub

'The color yellow.
Public Sub YELLOW As AWTColor
	Dim Wrapper As AWTColor
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Color")
	Wrapper.SetObject(Tjo.GetField("YELLOW"))
	Return Wrapper
End Sub

