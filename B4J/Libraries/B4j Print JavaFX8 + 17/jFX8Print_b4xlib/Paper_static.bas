B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=2.8
@EndOfDesignText@
'Code Module
Sub Process_Globals
	'Private fx As JFX ' Uncomment if required for B4j only
'
'	Private PaperJO As JavaObject
'	
'	'Constants / Fields are defined here and initialized in Sub UpdateConstants
'	'Specifies the ISO A0 size, 841 mm by 1189 mm.
'	Public Const A0 As Paper
'	'Specifies the ISO A1 size, 594 mm by 841 mm.
'	Public Const A1 As Paper
'	'Specifies the ISO A2 size, 420 mm by 594 mm.
'	Public Const A2 As Paper
'	'Specifies the ISO A3 size, 297 mm by 420 mm.
'	Public Const A3 As Paper
'	'Specifies the ISO A4 size, 210 mm by 297 mm.
'	Public Const A4 As Paper
'	'Specifies the ISO A5 size, 148 mm by 210 mm.
'	Public Const A5 As Paper
'	'Specifies the ISO A6 size, 105 mm by 148 mm.
'	Public Const A6 As Paper
'	'Specifies the engineering C size, 17 inch by 22 inch.
'	Public Const C As Paper
'	'Specifies the ISO Designated Long size, 110 mm by 220 mm.
'	Public Const DESIGNATED_LONG As Paper
'	'Specifies the executive size, 7.25 inches by 10.5 inches.
'	Public Const EXECUTIVE As Paper
'	'Specifies the Japanese postcard size, 100 mm by 148 mm.
'	Public Const JAPANESE_POSTCARD As Paper
'	'Specifies the JIS B4 size, 257 mm by 364 mm.
'	Public Const JIS_B4 As Paper
'	'Specifies the JIS B5 size, 182 mm by 257 mm.
'	Public Const JIS_B5 As Paper
'	'Specifies the JIS B6 size, 128 mm by 182 mm.
'	Public Const JIS_B6 As Paper
'	'Specifies the North American legal size, 8.5 inches by 14 inches.
'	Public Const LEGAL As Paper
'	'Specifies the Monarch envelope size, 3.87 inch by 7.5 inch.
'	Public Const MONARCH_ENVELOPE As Paper
'	'Specifies the North American 8 inch by 10 inch paper.
'	Public Const NA_8X10 As Paper
'	'Specifies the North American letter size, 8.5 inches by 11 inches
'	Public Const NA_LETTER As Paper
'	'Specifies the North American Number 10 business envelope size, 4.125 inches by 9.5 inches.
'	Public Const NA_NUMBER_10_ENVELOPE As Paper
'	'Specifies the tabloid size, 11 inches by 17 inches.
'	Public Const TABLOID As Paper
	
	Private mIsInitialized As Boolean

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
'	PaperJO.InitializeStatic("javafx.print.Paper")
'	If Not(PageOrientation_Static.IsInitialized) Then PageOrientation_Static.Initialize
'	UpdateConstants
	mIsInitialized = True
End Sub


'Specifies the ISO A0 size, 841 mm by 1189 mm.
Public Sub A0 As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("A0"))
	Return Wrapper
End Sub

'Specifies the ISO A1 size, 594 mm by 841 mm.
Public Sub A1 As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("A1"))
	Return Wrapper
End Sub

'Specifies the ISO A2 size, 420 mm by 594 mm.
Public Sub A2 As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("A2"))
	Return Wrapper
End Sub

'Specifies the ISO A3 size, 297 mm by 420 mm.
Public Sub A3 As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("A3"))
	Return Wrapper
End Sub

'Specifies the ISO A4 size, 210 mm by 297 mm.
Public Sub A4 As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("A4"))
	Return Wrapper
End Sub

'Specifies the ISO A5 size, 148 mm by 210 mm.
Public Sub A5 As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("A5"))
	Return Wrapper
End Sub

'Specifies the ISO A6 size, 105 mm by 148 mm.
Public Sub A6 As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("A6"))
	Return Wrapper
End Sub

'Specifies the engineering C size, 17 inch by 22 inch.
Public Sub C As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("C"))
	Return Wrapper
End Sub

'Specifies the ISO Designated Long size, 110 mm by 220 mm.
Public Sub DESIGNATED_LONG As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("DESIGNATED_LONG"))
	Return Wrapper
End Sub

'Specifies the executive size, 7.25 inches by 10.5 inches.
Public Sub EXECUTIVE As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("EXECUTIVE"))
	Return Wrapper
End Sub

'Specifies the Japanese postcard size, 100 mm by 148 mm.
Public Sub JAPANESE_POSTCARD As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("JAPANESE_POSTCARD"))
	Return Wrapper
End Sub

'Specifies the JIS B4 size, 257 mm by 364 mm.
Public Sub JIS_B4 As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("JIS_B4"))
	Return Wrapper
End Sub

'Specifies the JIS B5 size, 182 mm by 257 mm.
Public Sub JIS_B5 As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("JIS_B5"))
	Return Wrapper
End Sub

'Specifies the JIS B6 size, 128 mm by 182 mm.
Public Sub JIS_B6 As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("JIS_B6"))
	Return Wrapper
End Sub

'Specifies the North American legal size, 8.5 inches by 14 inches.
Public Sub LEGAL As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("LEGAL"))
	Return Wrapper
End Sub

'Specifies the Monarch envelope size, 3.87 inch by 7.5 inch.
Public Sub MONARCH_ENVELOPE As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("MONARCH_ENVELOPE"))
	Return Wrapper
End Sub

'Specifies the North American 8 inch by 10 inch paper.
Public Sub NA_8X10 As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("NA_8X10"))
	Return Wrapper
End Sub

'Specifies the North American letter size, 8.5 inches by 11 inches
Public Sub NA_LETTER As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("NA_LETTER"))
	Return Wrapper
End Sub

'Specifies the North American Number 10 business envelope size, 4.125 inches by 9.5 inches.
Public Sub NA_NUMBER_10_ENVELOPE As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("NA_NUMBER_10_ENVELOPE"))
	Return Wrapper
End Sub

'Specifies the tabloid size, 11 inches by 17 inches.
Public Sub TABLOID As Paper
	Dim Wrapper As Paper
	Wrapper.Initialize
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.print.Paper")
	Wrapper.SetObject(TJO.GetField("TABLOID"))
	Return Wrapper
End Sub



'Private Sub UpdateConstants
'
'	A0.Initialize
'	A0.SetObject(PaperJO.GetField("A0"))
'	
'	A1.Initialize
'	A1.SetObject(PaperJO.GetField("A1"))
'	
'	A2.Initialize
'	A2.SetObject(PaperJO.GetField("A2"))
'	
'	A3.Initialize
'	A3.SetObject(PaperJO.GetField("A3"))
'	
'	A4.Initialize
'	A4.SetObject(PaperJO.GetField("A4"))
'	
'	A5.Initialize
'	A5.SetObject(PaperJO.GetField("A5"))
'	
'	A6.Initialize
'	A6.SetObject(PaperJO.GetField("A6"))
'	
'	C.Initialize
'	C.SetObject(PaperJO.GetField("C"))
'	
'	DESIGNATED_LONG.Initialize
'	DESIGNATED_LONG.SetObject(PaperJO.GetField("DESIGNATED_LONG"))
'	
'	EXECUTIVE.Initialize
'	EXECUTIVE.SetObject(PaperJO.GetField("EXECUTIVE"))
'	
'	JAPANESE_POSTCARD.Initialize
'	JAPANESE_POSTCARD.SetObject(PaperJO.GetField("JAPANESE_POSTCARD"))
'	
'	JIS_B4.Initialize
'	JIS_B4.SetObject(PaperJO.GetField("JIS_B4"))
'	
'	JIS_B5.Initialize
'	JIS_B5.SetObject(PaperJO.GetField("JIS_B5"))
'	
'	JIS_B6.Initialize
'	JIS_B6.SetObject(PaperJO.GetField("JIS_B6"))
'	
'	LEGAL.Initialize
'	LEGAL.SetObject(PaperJO.GetField("LEGAL"))
'	
'	MONARCH_ENVELOPE.Initialize
'	MONARCH_ENVELOPE.SetObject(PaperJO.GetField("MONARCH_ENVELOPE"))
'	
'	NA_8X10.Initialize
'	NA_8X10.SetObject(PaperJO.GetField("NA_8X10"))
'	
'	NA_LETTER.Initialize
'	NA_LETTER.SetObject(PaperJO.GetField("NA_LETTER"))
'	
'	NA_NUMBER_10_ENVELOPE.Initialize
'	NA_NUMBER_10_ENVELOPE.SetObject(PaperJO.GetField("NA_NUMBER_10_ENVELOPE"))
'	
'	TABLOID.Initialize
'	TABLOID.SetObject(PaperJO.GetField("TABLOID"))
'End Sub

Public Sub IsInitialized As Boolean
	Return mIsInitialized
End Sub