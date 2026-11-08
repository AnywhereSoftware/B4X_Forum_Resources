B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'desinger scripts for YearPlannerView V1.00
Sub Class_Globals
	Private xui As XUI	
	Private textSizesSteps() As Float = Array As Float(1, 0.8)
	Private cvsCreated As Boolean
	Private cvs As B4XCanvas
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub



'Based on SpreadControlsHorizontally in DesignerUtils b4xlib
'https://www.b4x.com/android/forum/threads/b4x-dse-designer-script-extensions.141312/
'Spreads the controls evenly.
'Parameters: Panel, Maximum size of each control (0 for no maximum), Minimum gap between controls.
Private Sub SpreadControlsVertially (DesignerArgs As DesignerArgs)
	Dim Panel As B4XView = DesignerArgs.GetViewFromArgs(0)
	If Panel.IsInitialized = False Then Return
	Dim MaxSize As Int = DesignerArgs.Arguments.Get(1)
	If MaxSize = 0 Then MaxSize = 0x7fffffff
	Dim MinGap As Int = DesignerArgs.Arguments.Get(2)
	
	Dim AllHeight As Int = Panel.Height
	Dim h As Int = Min(AllHeight / Panel.NumberOfViews - MinGap, MaxSize)
	Dim gap As Int = (AllHeight - Panel.NumberOfViews * h) / Panel.NumberOfViews
	For i = 0 To Panel.NumberOfViews - 1
		Dim v As B4XView = Panel.GetView(i)
		v.SetLayoutAnimated(0, v.left, (i + 0.5) * gap + i * h, v.Width, h)
	Next
End Sub


'Parameters: panel containing the Days Header labels
Private Sub SetMonthsLabelText(DesignerArgs As DesignerArgs)

	Dim pnlMonths As B4XView = DesignerArgs.GetViewFromArgs(0)
	For Each v As B4XView In pnlMonths.GetAllViewsRecursive
		
		If v.Tag<>"" Then	'kept getting java.lang.NumberFormatException: empty String. Don't know why
			
			Dim monthName As String = DateUtils.GetMonthsNames.Get(v.tag-1)
			
			SetTextAndSize2(v, 13, monthName, monthName.SubString2(0, 3), monthName.SubString2(0,1))
			
		End If
		
				
	Next
	
End Sub


'Parameters: panel containing the Days Header labels
Private Sub SetDaysHeaderLabelText(DesignerArgs As DesignerArgs)
	
	Dim pnlDaysHeader As B4XView = DesignerArgs.GetViewFromArgs(0)
	
	For Each v As B4XView In pnlDaysHeader.GetAllViewsRecursive
		
		If v.Tag<>"" Then	'kept getting java.lang.NumberFormatException: empty String
			
			Dim i As Int  = v.Tag
			Dim dayName As String = DateUtils.GetDaysNames.Get(i-1 Mod 7)	'v.tag is day number, Sun=1
			SetTextAndSize2(v, 12, dayName, dayName.SubString2(0, 3), dayName.SubString2(0,1))
			
		End If
		
	Next
	
End Sub


'Created based on DesignerUtils.ddd.SetTextAndSize, adjusted so we can pass the arguments directly
'Extends SetText with adjustment of the text size. Note that the second parameter is the base text size.
'Parameters: View, Base text size, One or more strings.
'https://www.b4x.com/android/forum/threads/b4x-dse-designer-script-extensions.141312/
Private Sub SetTextAndSize2(v As B4XView, OriginalTextSize As Int, text1 As String, text2 As String, text3 As String)
	
	If v.IsInitialized = False Then Return
	Dim text As String
	Dim fnts As List
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
			fnts.Add(xui.CreateFont2(v.Font, OriginalTextSize * f))
		Next
	End If
	
	Dim l As List 
	l.Initialize2(Array As String(text1, text2, text3))
	For i = 0 To l.Size - 1
		text = l.Get(i)
		If SetTextHelper(v, text, fnts) Then Exit
	Next
	v.Text = text
	
End Sub



'adjust the size and position of the day labels in pnlDays
'Parameters: pnlDays
Private Sub ScaleDayLabels(DesignerArgs As DesignerArgs)
		
	Dim pnlDays As B4XView = DesignerArgs.GetViewFromArgs(0)
	
	Dim lblWidth As Int = pnlDays.Width/37
	Dim lblHeight As Int = pnlDays.Height/12
	
	For Each b As B4XView In pnlDays.GetAllViewsRecursive
		
		If b Is Label Then
'			Log(lbl.Text)
'			Log(lbl.Tag)
			Dim dld As DayLabelData = b.Tag
		
			b.Width=lblWidth
			b.Height=lblHeight
			b.Top=(dld.row-1)*lblHeight
			b.Left=dld.column*lblWidth
		End If
		
	Next	
	
End Sub




#Region copied from DesignerUtils.ddd
'Below subs all copied from DesignerUtils.ddd class 
'https://www.b4x.com/android/forum/threads/b4x-dse-designer-script-extensions.141312/
	
'Spreads the controls evenly.
'Parameters: Panel, Maximum size of each control (0 for no maximum), Minimum gap between controls.
Private Sub SpreadControlsHorizontally (DesignerArgs As DesignerArgs)
	Dim Panel As B4XView = DesignerArgs.GetViewFromArgs(0)
	If Panel.IsInitialized = False Then Return
	Dim MaxSize As Int = DesignerArgs.Arguments.Get(1)
	If MaxSize = 0 Then MaxSize = 0x7fffffff
	Dim MinGap As Int = DesignerArgs.Arguments.Get(2)
	Dim AllWidth As Int = Panel.Width
	Dim w As Int = Min(AllWidth / Panel.NumberOfViews - MinGap, MaxSize)
	Dim gap As Int = (AllWidth - Panel.NumberOfViews * w) / Panel.NumberOfViews
	For i = 0 To Panel.NumberOfViews - 1
		Dim v As B4XView = Panel.GetView(i)
		v.SetLayoutAnimated(0, (i + 0.5) * gap + i * w, v.Top, w, v.Height)
	Next
End Sub
	

Private Sub SetTextHelper(View As B4XView, text As String, Fonts As List) As Boolean
	CreateCVSIfNeeded
	For Each fnt As B4XFont In Fonts
		Dim width As Int = cvs.MeasureText(text, fnt).Width
		If width + 30dip < View.Width Then
			If Fonts.Size > 1 Then
				View.Font = fnt
			End If
			Return True
		End If
	Next
	Return False
End Sub
	


Private Sub CreateCVSIfNeeded
	If cvsCreated Then Return
	cvsCreated = True
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 2dip, 2dip)
	cvs.Initialize(p)
End Sub


#End Region copied from DesignerUtils.ddd




