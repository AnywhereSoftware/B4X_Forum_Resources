B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13.4
@EndOfDesignText@
'Utils Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	Private xui As XUI
End Sub

Sub GetAppCopyright() As String
	Return $"Copyright © ${GetYearFromDate} Wayward Son - All rights reserved."$
End Sub

Sub GetAppVersion As String
	Return "Version: " & Application.VersionName
End Sub

Private Sub GetYearFromDate() As String
	Return DateTime.GetYear(DateTime.Now)
End Sub

Sub FontToBitmap(Text As String, FontSize As Float, Color As Int) As B4XBitmap
	Dim xui As XUI
	Dim p As Panel = xui.CreatePanel("")
	p.SetLayoutAnimated(0,0,0,26dip,26dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	Dim fnt As B4XFont '= xui.CreateFont(Typeface.FONTAWESOME, FontSize)
	
	'ascertain which icon type the Text is:
	If  Asc(Text.CharAt(0)) < 61440  Then
		'Log("Using MaterialIcons")
		fnt = xui.CreateMaterialIcons(FontSize)
	Else
		'Log("Using FontAwesome")
		fnt = xui.CreateFontAwesome(FontSize)
	End If
	
	Dim r As B4XRect = cvs1.MeasureText(Text,fnt)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	'cvs1.DrawText(Text, cvs1.TargetRect.CenterX,BaseLine, fnt, xui.Color_Blue, "CENTER")
	cvs1.DrawText(Text, cvs1.TargetRect.CenterX,BaseLine, fnt, Color, "CENTER")
	
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	Return b
End Sub

Sub SetETHint(et As EditText)
	Dim cs As CSBuilder
	cs.Initialize.Color(Colors.DarkGray).Typeface(Typeface.CreateNew(Typeface.DEFAULT,Typeface.STYLE_ITALIC)).Append(et.Hint).PopAll
	Dim jo As JavaObject = et
	jo.RunMethod("setHint", Array(cs))
End Sub

Sub SetETStyle(et As EditText,borderClr As Int)
	'EditText - txtSearch: round corners, Italic Hint Font
	Private cd As ColorDrawable
	cd.Initialize2(xui.Color_White,10dip,1dip,borderClr)
	et.Background = cd
	et.Padding = Array As Int(15,0,0,0)
End Sub

Sub SetPasswordETStyle(et As EditText)
	Private cd As ColorDrawable
	cd.Initialize2(xui.Color_Transparent,0dip,0dip,xui.Color_Transparent)
	et.Background = cd
	et.Padding = Array As Int(5,0,0,0)
End Sub

Sub ClickableWords(Text As String) As CSBuilder
	Dim cs As CSBuilder
	Return cs.Initialize.Underline.Color(0xFF0041EA).Clickable("word", Text).Append(Text).PopAll
End Sub

Sub TYPE_DATE As Int
	Return 4 '(0x00000004)
End Sub

Sub TYPE_CAP_WORDS As Int
	Return 8192 '(0x00002000)
End Sub

Sub TYPE_EMAIL_ADDRESS As Int
	Return 32 '(0x00000020)
End Sub

Sub TYPE_PASSWORD As Int
	Return 128 '(0x00000080)
End Sub


