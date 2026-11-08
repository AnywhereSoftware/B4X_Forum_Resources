B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Code Module
Sub Process_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
End Sub

'The bold style constant.
Public Sub BOLD As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("BOLD")
End Sub

'The baseline used in ideographic scripts like Chinese, Japanese, and Korean when laying out text.
Public Sub CENTER_BASELINE As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("CENTER_BASELINE")
End Sub

'A String constant for the canonical family name of the logical font 'Dialog'.
Public Sub DIALOG As String
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("DIALOG")
End Sub

'A String constant for the canonical family name of the logical font 'DialogInput'.
Public Sub DIALOG_INPUT As String
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("DIALOG_INPUT")
End Sub

'The baseline used in Devanigiri and similar scripts when laying out text.
Public Sub HANGING_BASELINE As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("HANGING_BASELINE")
End Sub

'The italicized style constant.
Public Sub ITALIC As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("ITALIC")
End Sub

'A flag to layoutGlyphVector indicating that text is left-to-right as determined by Bidi analysis.
Public Sub LAYOUT_LEFT_TO_RIGHT As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("LAYOUT_LEFT_TO_RIGHT")
End Sub

'A flag to layoutGlyphVector indicating that text in the char array after the indicated limit should not be examined.
Public Sub LAYOUT_NO_LIMIT_CONTEXT As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("LAYOUT_NO_LIMIT_CONTEXT")
End Sub

'A flag to layoutGlyphVector indicating that text in the char array before the indicated start should not be examined.
Public Sub LAYOUT_NO_START_CONTEXT As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("LAYOUT_NO_START_CONTEXT")
End Sub

'A flag to layoutGlyphVector indicating that text is right-to-left as determined by Bidi analysis.
Public Sub LAYOUT_RIGHT_TO_LEFT As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("LAYOUT_RIGHT_TO_LEFT")
End Sub

'A String constant for the canonical family name of the logical font 'Monospaced'.
Public Sub MONOSPACED As String
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("MONOSPACED")
End Sub

'The plain style constant.
Public Sub PLAIN As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("PLAIN")
End Sub

'The baseline used in most Roman scripts when laying out text.
Public Sub ROMAN_BASELINE As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("ROMAN_BASELINE")
End Sub

'A String constant for the canonical family name of the logical font 'SansSerif'.
Public Sub SANS_SERIF As String
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("SANS_SERIF")
End Sub

'A String constant for the canonical family name of the logical font 'Serif'.
Public Sub SERIF As String
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("SERIF")
End Sub

'Identify a font resource of type TRUETYPE.
Public Sub TRUETYPE_FONT As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("TRUETYPE_FONT")
End Sub

'Identify a font resource of type TYPE1.
Public Sub TYPE1_FONT As Int
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("java.awt.Font")
	Return Tjo.GetField("TYPE1_FONT")
End Sub

