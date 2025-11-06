B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=11
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
End Sub
Sub ChangeBothColor(color As Int)
	SetStatusBarColor(color)
	SetNavigationBarColor(color)
End Sub
Sub SetStatusBarColor(color As Int)
	Dim p As Phone
	If p.SdkVersion >= 21 Then
		Dim jo As JavaObject
		jo.InitializeContext
		Dim window As JavaObject = jo.RunMethodJO("getWindow", Null)
		window.RunMethod("addFlags", Array (0x80000000))
		window.RunMethod("clearFlags", Array (0x04000000))
		window.RunMethod("setStatusBarColor", Array(color))
	End If
End Sub

Sub SetNavigationBarColor(color As Int)
	Dim p As Phone
	If p.SdkVersion >= 21 Then
		Dim jo As JavaObject
		jo.InitializeContext
		Dim window As JavaObject = jo.RunMethodJO("getWindow", Null)
		window.RunMethod("addFlags", Array (0x80000000))
		window.RunMethod("clearFlags", Array (0x04000000))
		window.RunMethod("setNavigationBarColor", Array(color))
	End If
End Sub

' This function returns a contrasting color (either white or black) based on the lightness or darkness of the given color.
' It calculates the YIQ value of the color and returns a specified color for light or dark colors accordingly.
Public Sub GetContrastColor(Color As Int, ForLightColor As Int, ForDarkColor As Int) As Int
	Dim a, r, g, b, yiq As Int    ' Variables for ARGB components and YIQ value
    
	' Extract the ARGB components of the color
	a = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)  ' Alpha component
	r = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)    ' Red component
	g = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)      ' Green component
	b = Bit.And(Color, 0xff)                                      ' Blue component
    
	' Calculate the YIQ value, which determines the brightness of the color
	yiq = r * 0.299 + g * 0.587 + b * 0.114
    
	' Return the appropriate color depending on the YIQ value
	If yiq > 200 Then
		Return ForLightColor  ' Return light color if the color is light
	Else
		Return ForDarkColor   ' Return dark color if the color is dark
	End If
End Sub

' This function takes a color in ARGB format and adjusts its RGB components 
' by subtracting a given value ('ajust') from the Red, Green, and Blue components. 
' The Alpha component (transparency) remains unchanged. The function ensures 
' that the RGB components stay within the valid range of 0 to 255. It then 
' creates and returns a new color with the adjusted RGB values while keeping 
' the original Alpha value intact.
Public Sub colortobackcolor(color As Int, ajust As Float) As Int
	' Get the ARGB components of the color
	Dim a, r, g, b As Int
	a = Bit.UnsignedShiftRight(Bit.And(color, 0xFF000000), 24)  ' Extract the Alpha component
	r = Bit.UnsignedShiftRight(Bit.And(color, 0x00FF0000), 16)  ' Extract the Red component
	g = Bit.UnsignedShiftRight(Bit.And(color, 0x0000FF00), 8)   ' Extract the Green component
	b = Bit.And(color, 0x000000FF)                              ' Extract the Blue component

	' Adjust the RGB values by subtracting 'ajust'
	' Alpha value remains unchanged.
	r = r - ajust  ' Adjust the Red component
	g = g - ajust  ' Adjust the Green component
	b = b - ajust  ' Adjust the Blue component

	' Ensure RGB values are within the valid range (0-255)
	r = Max(0, Min(255, r))  ' Ensure Red value is between 0 and 255
	g = Max(0, Min(255, g))  ' Ensure Green value is between 0 and 255
	b = Max(0, Min(255, b))  ' Ensure Blue value is between 0 and 255

	' Create the new ARGB color with the adjusted values
	Dim newColor As Int = Bit.Or(Bit.ShiftLeft(a, 24), Bit.Or(Bit.ShiftLeft(r, 16), Bit.Or(Bit.ShiftLeft(g, 8), b)))

	' Return the new color with adjusted components
	Return newColor
End Sub

Public Sub Lblcolor(Lbl As B4XView, TextColor As Int, textSize As Int, text As String, font As B4XFont, Aligment As String)
	Lbl.Font = font             ' Set the font of the label
	Lbl.TextColor = TextColor   ' Set the text color of the label
	Lbl.TextSize = textSize     ' Set the text size of the label
	Lbl.Text = text             ' Set the content of the label
	Lbl.SetTextAlignment("CENTER", Aligment) ' Set the text alignment for the label
End Sub

