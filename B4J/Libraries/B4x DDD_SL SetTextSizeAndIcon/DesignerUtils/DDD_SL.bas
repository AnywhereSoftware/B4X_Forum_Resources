B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.71
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private cvs As B4XCanvas
	Private cvsCreated As Boolean
	Private textSizesSteps() As Float = Array As Float(1, 0.8)
	Public TextWidthGap As Int = 30dip
	Private OrigFonts As Map
	
End Sub

Public Sub Initialize
	OrigFonts.Initialize
End Sub

Private Sub CreateCVSIfNeeded
	If cvsCreated Then Return
	cvsCreated = True
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 2dip, 2dip)
	cvs.Initialize(p)
End Sub
'Sets the text size steps that will be used when setting the text with SetTextAndSize. Default value is 1, 0.8.
Private Sub SetTextSizeSteps(DesignerArgs As DesignerArgs)
	If textSizesSteps.Length <> DesignerArgs.Arguments.Size Then
		Dim textSizesSteps(DesignerArgs.Arguments.Size) As Float
	End If
	For i = 0 To textSizesSteps.Length - 1
		textSizesSteps(i) = DesignerArgs.Arguments.Get(i)
	Next
End Sub

'Extends DDD.SetText with adjustment of the text size and Icon. Note that the second parameter is the base text size.
'Third parameter should be "True" for Font Awesome or "" for Material Icons
'Parameters: View, Base text size, Icon Type, Icon size,  One or more strings, Icon hexvalue i.e. "0xF209".
Private Sub SetTextAndSizeIcon(DesignerArgs As DesignerArgs)
	Dim v As B4XView = DesignerArgs.GetViewFromArgs(0)
	Dim OriginalTextSize As Int = DesignerArgs.Arguments.Get(1)
	If v.IsInitialized = False Then Return
	Dim Text As String
	Dim fnts As List
	Dim FontAwesome As Boolean = DesignerArgs.Arguments.Get(2) = "True"
	If OrigFonts.ContainsKey(v) = False Then OrigFonts.Put(v,v.Font)
	Dim IconSize As Int = DesignerArgs.Arguments.Get(3)
	#if B4I
	If v.Font.ToNativeFont.Name.StartsWith(".") Then
		fnts.Initialize
		For Each f As Float In textSizesSteps
			fnts.Add(xui.CreateDefaultFont(OriginalTextSize * f))
		Next
	End If
	#end if
	If fnts.IsInitialized = False Then
		fnts.Initialize
		For Each f As Float In textSizesSteps
			fnts.Add(xui.CreateFont2(OrigFonts.Get(v), OriginalTextSize * f))
		Next
	End If
	
	Dim Found As Boolean
	For i = 4 To DesignerArgs.Arguments.Size - 2
		Text = DesignerArgs.Arguments.Get(i)
		If SetTextHelper(v, Text, fnts) Then
			Found = True
			Exit
		End If
	Next
	
	If Found = False Then
		Dim CH As Int = Bit.ParseInt(DesignerArgs.Arguments.Get(i).As(String).SubString(2),16)
		Text = Chr(CH)
		If FontAwesome Then
			V.Font = xui.CreateFontAwesome(IconSize)
		Else
			v.Font = xui.CreateMaterialIcons(IconSize)
		End If
	End If
	
	v.Text = Text
End Sub

Private Sub SetTextHelper(View As B4XView, text As String, Fonts As List) As Boolean
	CreateCVSIfNeeded
	For Each fnt As B4XFont In Fonts
		Dim width As Int = cvs.MeasureText(text, fnt).Width
		If width + TextWidthGap < View.Width Then
			If Fonts.Size > 1 Then
				View.Font = fnt
			End If
			Return True
		End If
	Next
	Return False
End Sub
