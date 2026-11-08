B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
' this class shows various custom dialogs, the size of each can be determined by the TextSize parameter
' note that only one of these dialogs can be shown at a time. eg calling the imputbox will cancel the msgbox
'
' 1) Show2ColumnDialog			Show a custom dialog with 2 columns and multiple lines, scalable using TextSize variable.
' 2) ShowMsgbBox				Show a custom message box dialog, scalable using TextSize variable.
' 3) ShowInputBox				Show a custom input box dialog, scalable using TextSize variable.
' 4) SelectColorFromList		Show a list of colours

Sub Class_Globals
	Public TxtSize As Int
	Public MinWidthRatio As Float = .33
	Public DialogBackGroundColor As Int = Colors.LightGray
	Public TitleBarColor As Int  = 0
	Public TitleBarTextColor As Int = 0
	Public Text1Color As Int = Colors.Black
	Public Text2Color As Int = Colors.Black
	Public DialogResult As Int
	Public DialogInputText As String
	
	Private Dialog As B4XDialog
	Private XUI As XUI
	Private MinWidth As Int
	Private ActivityWidth, ActivityHeight As Int
	Private Base As B4XView
End Sub

'Initializes the object. The TextSize can be changed any time (TxtSize) but before any call to a method
Public Sub Initialize(Act As Object,TextSize As Int)
	Base = Act
	Dialog.Initialize (Base)
	TxtSize = TextSize
	'sf.Initialize
	ActivityWidth = 100%x
	ActivityHeight = 100%y
	MinWidth = ActivityWidth * MinWidthRatio
End Sub

' Show a custom dialog with 2 columns and multiple lines, scalable using TextSize variable.
' Example:<code>Dim BGViews As XUIViewsBG
'            	BGViews.Initialize(Activity,35)
'               Dim rs As ResumableSub = BGViews.Show2ColumnDialog("Track info","Track:" & CRLF & "Type:" & CRLF & "Length:" & CRLF & "Words:","TrackName" & CRLF & ".mp3" & CRLF & "3:00" & CRLF & "False",35)
'	            Wait For (rs) Complete (Result As Int)</code>
Public Sub Show2ColumnDialog(DialogTitle As String, TextLeft As String, TextRight As String, TextSize As Int) As ResumableSub 
	' the order of statements in this sub is critical, do NOT change it 
	Dim TextHeightSingle As Int 
	Dim TextHeightMultiple As Int
	Dim TextWidth As Int, ButtonTextWidth As Int
	If TextSize <= 0 Then TextSize = TxtSize
	
	' create panel to put views on
	Dim p As B4XView = XUI.CreatePanel("")
	' 1st label
 	Dim LblLeft As Label
	LblLeft.Initialize("")
	LblLeft.TextSize = TextSize
	LblLeft.Text = TextLeft
	LblLeft.TextColor = Text1Color
	LblLeft.Gravity = Gravity.TOP
	LblLeft.Padding = Array As Int (0, 0, 0, 0)
	LblLeft.Visible = True
	' 2nd label
	Dim LblRight As Label
	LblRight.Initialize("")
	LblRight.TextSize = TextSize
	LblRight.Text = TextRight
	LblRight.TextColor = Text2Color
	LblRight.Gravity = Gravity.TOP
	LblRight.Padding = Array As Int (0, 0, 0, 0)
	LblRight.Visible = True
	' Measure text width and heights
	TextWidth = MeasureTextWidth(p,TextSize,TextLeft)  * 1.5
	TextHeightSingle = MeasureTextHeight(p,TextSize,"") * 1.2
	TextHeightMultiple = MeasureTextHeight(p,TextSize,LblLeft.Text & CRLF &"W") * 1.2
	TextHeightMultiple = Min(TextHeightMultiple,Base.height - (TextHeightSingle * 2))
	' set dimensions of panel and add the labels
    p.SetLayoutAnimated(0, 0, 0, 100%x, TextHeightMultiple ) 
	p.AddView(LblLeft,10dip,TextHeightSingle / 2,TextWidth  , TextHeightMultiple)
	p.AddView(LblRight,LblLeft.Left + LblLeft.Width + 100dip,TextHeightSingle / 2,p.Width - (LblLeft.Left + LblLeft.Width + 100dip - LblLeft.Left) , TextHeightMultiple)
	' set up the dialog
    Dialog.Title = DialogTitle
	If TitleBarColor <> 0 Then Dialog.TitleBarColor = TitleBarColor
	If TitleBarTextColor <> 0 Then Dialog.TitleBarTextColor = TitleBarTextColor
    Dialog.BackgroundColor = DialogBackGroundColor
	ButtonTextWidth = MeasureTextWidth(p,TextSize,"OK")
	' show the dialog
    Dim rs As ResumableSub = Dialog.ShowCustom(p,"OK","","")
    ' these cannot be changed until the dialog is showing
	Dialog.Base.Height = TextHeightMultiple
    Dim OkButton As B4XView = Dialog.GetButton(XUI.DialogResponse_Positive)
    OkButton.TextSize = TextSize * .8
    OkButton.Width = ButtonTextWidth * 1.2 : OkButton.height = TextHeightSingle
	OkButton.SetLayoutAnimated(0,ActivityWidth - OkButton.Width - 10dip,Dialog.Base.Height - OkButton.height- 10dip,OkButton.Width,OkButton.Height)
	Dialog.TitleBar.GetView(0).Textsize = TextSize
	Dialog.TitleBar.Height = TextHeightSingle
	Dialog.TitleBar.GetView(0).Height = TextHeightSingle
	If TitleBarColor <> 0 Then Dialog.TitleBar.GetView(0).Color = TitleBarColor
	If TitleBarTextColor <> 0 Then Dialog.TitleBar.GetView(0).TextColor = TitleBarTextColor
	AnimateDialog(Dialog, "bottom")
	OkButton.RequestFocus
	' now wait for user to press OK
 	 Wait For (rs) Complete (Result As Int)
	 DialogResult = Result
	 Return Result
   	'If Result = XUI.DialogResponse_Positive Then
       'do something
   	'End If 
End Sub

' Show a custom message box dialog, scalable using TextSize variable.
' Example:<code>Dim BGViews As XUIViewsBG
'            	BGViews.Initialize(Activity,35)
'               Dim rs As ResumableSub = BGViews.ShowMsgBox("The Dialog result was " & BGViews.DialogResult & CRLF & "Next line","Test Messagebox","OK","No","Cancel",35)
'           	Wait For (rs) Complete (Result As Int)</code>
Public Sub ShowMsgBox(Message As String, DialogTitle As String, Positive As String,  Negative As String, Cancel As String,TextSize As Int) As ResumableSub 
	' the order of statements in this sub is critical, do NOT change it 
	Dim TextHeightSingle As Int 
	Dim TextHeightMessage As Int
	Dim TextWidth As Int, ButtonTextWidth, DialogTitleWidth As Int
	Dim Margin As Int = 10dip
	If TextSize <= 0 Then TextSize = TxtSize

	' create panel to put views on
	Dim p As Panel
	p.Initialize("")
	' determine minimum width
	DialogTitleWidth = MeasureTextWidth(p,TextSize,DialogTitle) * 1.2	
	ButtonTextWidth = MeasureTextWidth(p,TextSize,"Cancel") * 1.2
	MinWidth = Max(DialogTitleWidth,ButtonTextWidth * 3 + (Margin * 4))	
	MinWidth = Max(ActivityWidth * MinWidthRatio, MinWidth)

	' Message label
 	Dim LblMsg As Label
	LblMsg.Initialize("")
	LblMsg.TextSize = TextSize
	LblMsg.Text = Message
	LblMsg.TextColor = Text1Color
	LblMsg.Gravity = Gravity.CENTER_HORIZONTAL
	LblMsg.Padding = Array As Int (0, 0, 0, 0)
	LblMsg.Visible = True

	' Measure text width and heights
	TextHeightSingle = MeasureTextHeight(p,TextSize,"") * 1.2
	TextHeightMessage = MeasureTextHeight(p,TextSize,Message) * 1.2
	TextWidth = MeasureTextWidth(p,TextSize,Message)  * 1.2
	' set dimensions of panel and add the label
	Dim DialogWidth As Int 
	DialogWidth = Max(MinWidth,TextWidth + (Margin *2))
	DialogWidth = Min(DialogWidth,ActivityWidth)
    p.SetLayoutAnimated(0, 0, 0, DialogWidth, TextHeightMessage + (TextHeightSingle * 2)) 
	p.AddView(LblMsg,Margin,TextHeightSingle / 2,DialogWidth, TextHeightMessage)
	' set up the dialog
    Dialog.Title = DialogTitle
    Dialog.BackgroundColor = DialogBackGroundColor
	' show the dialog
    Dim rs As ResumableSub = Dialog.ShowCustom(p,Positive,Negative,Cancel)
    ' these cannot be changed until the dialog is showing
	Dialog.Base.Width = DialogWidth
	Dialog.Base.Height = TextHeightMessage + (TextHeightSingle * 2)
	ButtonTextWidth = MeasureTextWidth(p,TextSize,Positive & CRLF & Negative & CRLF & Cancel) * 1.2	' gets the width of the widest one and uses it for all buttons
	Dim NumberOfButtons As Int = 0
	If Not(Positive = "") Then NumberOfButtons = NumberOfButtons +1
	If Not(Negative = "") Then NumberOfButtons = NumberOfButtons +1
	If Not(Cancel = "") Then NumberOfButtons = NumberOfButtons +1
	Dim ButtonLeft As Int
	If Not(Positive = "") Then
	    Dim PositiveButton As B4XView = Dialog.GetButton(XUI.DialogResponse_Positive)
	    PositiveButton.TextSize = TextSize * .8
	    PositiveButton.Width = ButtonTextWidth  : PositiveButton.height = TextHeightSingle
		Select Case NumberOfButtons
			Case 1
				ButtonLeft = p.Width - ButtonTextWidth - Margin
			Case 2
				ButtonLeft = (p.Width - ButtonTextWidth)/2
			Case 3
				ButtonLeft = Margin
		End Select
		NumberOfButtons = NumberOfButtons - 1
		PositiveButton.SetLayoutAnimated(0,ButtonLeft,Dialog.Base.Height - PositiveButton.height- Margin,PositiveButton.Width,PositiveButton.Height)
	End If
	If Not(Negative = "") Then
	    Dim NegativeButton As B4XView = Dialog.GetButton(XUI.DialogResponse_Negative)
	    NegativeButton.TextSize = TextSize * .8
	    NegativeButton.Width = ButtonTextWidth  : NegativeButton.height = TextHeightSingle
		Select Case NumberOfButtons
			Case 1
				ButtonLeft = p.Width - ButtonTextWidth - Margin
			Case 2
				ButtonLeft = (p.Width - ButtonTextWidth)/2
			Case 3
				ButtonLeft = Margin
		End Select
		NumberOfButtons = NumberOfButtons - 1
		NegativeButton.SetLayoutAnimated(0,ButtonLeft,Dialog.Base.Height - NegativeButton.height- Margin,NegativeButton.Width,NegativeButton.Height)
	End If	
	If Not(Cancel = "") Then
	    Dim CancelButton As B4XView = Dialog.GetButton(XUI.DialogResponse_Cancel)
	    CancelButton.TextSize = TextSize * .8
	    CancelButton.Width = ButtonTextWidth  : CancelButton.height = TextHeightSingle
		Select Case NumberOfButtons
			Case 1
				ButtonLeft = p.Width - ButtonTextWidth - Margin
			Case 2
				ButtonLeft = (p.Width - ButtonTextWidth)/2
			Case 3
				ButtonLeft = Margin
		End Select
		NumberOfButtons = NumberOfButtons - 1
		CancelButton.SetLayoutAnimated(0,ButtonLeft,Dialog.Base.Height - CancelButton.height- Margin,CancelButton.Width,CancelButton.Height)
	End If	
	Dialog.TitleBar.GetView(0).Textsize = TextSize
	Dialog.TitleBar.Height = TextHeightSingle
	Dialog.TitleBar.GetView(0).Height = TextHeightSingle
	If TitleBarColor <> 0 Then Dialog.TitleBar.GetView(0).Color = TitleBarColor
	If TitleBarTextColor <> 0 Then Dialog.TitleBar.GetView(0).TextColor = TitleBarTextColor
 	' now wait for user to press a button
 	 Wait For (rs) Complete (Result As Int)
	 DialogResult = Result
	 Return Result
End Sub

' Show a custom input box dialog, scalable using TextSize variable.
' Example:<code>Dim BGViews As XUIViewsBG
'            	BGViews.Initialize(Activity,35)
'               Dim rs As ResumableSub = BGViews.ShowInputBox("Enter text","Default response","Dialog Title",35)
' 	            Wait For (rs) Complete (sResult As String)</code>
Public Sub ShowInputBox(Message As String, DefaultResponse As String, DialogTitle As String, TextSize As Int) As ResumableSub 
	' the order of statements in this sub is critical, do NOT change it
	Dim TextHeightSingle As Int 
	Dim TextHeightMessage As Int
	Dim TextWidth As Int, ButtonTextWidth, DialogTitleWidth As Int
	Dim Margin As Int = 10dip
	If TextSize <= 0 Then TextSize = TxtSize

	' create panel to put views on
	Dim p As B4XView = XUI.CreatePanel("")
	' determine minimum width
	DialogTitleWidth = MeasureTextWidth(p,TextSize,DialogTitle) * 1.2	
	ButtonTextWidth = MeasureTextWidth(p,TextSize,"Cancel") * 1.2
	MinWidth = Max(DialogTitleWidth,ButtonTextWidth * 3 + (Margin * 4))	
	MinWidth = Max(ActivityWidth * MinWidthRatio, MinWidth)
	
	' Message label
 	Dim LblMsg As Label
	LblMsg.Initialize("")
	LblMsg.TextSize = TextSize
	LblMsg.Text = Message
	LblMsg.TextColor = Text1Color
	LblMsg.Gravity = Gravity.CENTER_HORIZONTAL
	LblMsg.Padding = Array As Int (0, 0, 0, 0)
	LblMsg.Visible = True
	Dim EditTextInput As EditText
	EditTextInput.Initialize("")
	EditTextInput.Padding = Array As Int (0, 0, 0, 0)
	EditTextInput.TextSize = TextSize
	EditTextInput.Text = DefaultResponse
	EditTextInput.Color = Colors.white
	EditTextInput.TextColor = Text2Color
	EditTextInput.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.LEFT)
	EditTextInput.Padding = Array As Int (0, 0, 0, 0)
	EditTextInput.SingleLine = True
	EditTextInput.ForceDoneButton = True
	EditTextInput.InputType = Bit.Or(EditTextInput.INPUT_TYPE_TEXT, 0x00080000)	' stops auto suggestions
	EditTextInput.Visible = True
	' Measure text width and heights
	TextHeightSingle = MeasureTextHeight(p,TextSize,"") * 1.2
	TextHeightMessage = MeasureTextHeight(p,TextSize,Message) * 1.2
	TextWidth = MeasureTextWidth(p,TextSize,Message)  * 1.2	'1.5
	Dim DialogWidth As Int 
	DialogWidth = Max(MinWidth,TextWidth + (Margin *2))
	DialogWidth = Min(DialogWidth,ActivityWidth)
	' set dimensions of panel and add the label
    p.SetLayoutAnimated(0, 0, 0, DialogWidth, TextHeightMessage + (TextHeightSingle * 4)) 
	p.AddView(LblMsg,Margin,TextHeightSingle / 2, DialogWidth, TextHeightMessage)
	p.AddView(EditTextInput,Margin,LblMsg.Top + LblMsg.Height, DialogWidth,TextHeightSingle)
	' set up the dialog
    Dialog.Title = DialogTitle
    Dialog.BackgroundColor = DialogBackGroundColor
	' show the dialog
    Dim rs As ResumableSub = Dialog.ShowCustom(p,"OK","","Cancel")
    ' these cannot be changed until the dialog is showing
	Dialog.Base.Height = TextHeightMessage + (TextHeightSingle * 4)
	Dialog.Base.Top = Dialog.Base.Parent.top
	Dim ButtonLeft As Int
    Dim PositiveButton As B4XView = Dialog.GetButton(XUI.DialogResponse_Positive)
    PositiveButton.TextSize = TextSize * .8
    PositiveButton.Width = ButtonTextWidth  : PositiveButton.height = TextHeightSingle
	ButtonLeft = (p.Width - ButtonTextWidth)/2
	PositiveButton.SetLayoutAnimated(0,ButtonLeft,Dialog.Base.Height - PositiveButton.height- Margin,PositiveButton.Width,PositiveButton.Height)
    Dim CancelButton As B4XView = Dialog.GetButton(XUI.DialogResponse_Cancel)
    CancelButton.TextSize = TextSize * .8
    CancelButton.Width = ButtonTextWidth  : CancelButton.height = TextHeightSingle
	ButtonLeft = p.Width - ButtonTextWidth - Margin
	CancelButton.SetLayoutAnimated(0,ButtonLeft,Dialog.Base.Height - CancelButton.height- Margin,CancelButton.Width,CancelButton.Height)
	Dialog.TitleBar.GetView(0).Textsize = TextSize
	Dialog.TitleBar.Height = TextHeightSingle
	Dialog.TitleBar.GetView(0).Height = TextHeightSingle
	If TitleBarColor <> 0 Then Dialog.TitleBar.GetView(0).Color = TitleBarColor
	EditTextInput.RequestFocus
	AnimateDialog(Dialog,"top")
 	' now wait for user to press a button
 	 Wait For (rs) Complete (Result As Int)
	 DialogResult = Result
	 If Result = XUI.DialogResponse_Cancel Then EditTextInput.Text = ""
	DialogInputText = EditTextInput.Text
	 Return DialogInputText
End Sub

' Shows a list of colours
'	Example:<code>Dim BGViews As XUIViewsBG
'	BGViews.Initialize(Activity,35)
'	Dim rs As ResumableSub = BGViews.SelectColorFromList
'	Wait For (rs) Complete (iResult As Int)
'	If iResult <> DialogResponse.CANCEL Then ColorSelected = iResult</code>
 Public Sub SelectColorFromList() As ResumableSub
 	Dim ListOfColorsPanel As Panel
	Dim sv As ScrollView2D
	Dim svHeight As Int = 0
	Dim Margin As Int = 5dip
	
	ListOfColorsPanel.Initialize("")
	ListOfColorsPanel.SetLayoutAnimated(0, 0, 0, 300dip, 100%y - Dialog.ButtonsHeight - 30dip - 10dip)
	ListOfColorsPanel.Color = Colors.White	'Dialog.BackgroundColor
	
	sv.Initialize(300dip, 0,"")
	sv.Panel.Height = Margin
	
	Dim lstUseColors As List
	lstUseColors.Initialize2(Array As String("Black:000000","Maroon:800000","Green:008000","Navy:000080","Purple:800080","Teal:008080","Grey:808080", _
												"Red:FF0000","Lime:00FF00","Blue:0000FF","Fuchsia:FF00FF","Aqua:00FFFF"))
	' For Each line As String In File.ReadList(File.DirAssets, "colors.txt")
	For Each line As String In lstUseColors
		Dim s() As String = Regex.Split(":", line)
		Dim Name As String = s(0)
		Dim Color As Int = Bit.Or(0xff000000, Bit.ParseInt(s(1), 16))
		Dim pnl As Panel
		pnl.Initialize("")
		pnl.Tag = Color
		Dim ControlBackground As ColorDrawable
		ControlBackground.initialize2(Color,20,1,Colors.black)
		Dim ColorPanel As Label
		ColorPanel.Initialize("")
		ColorPanel.Background = ControlBackground	'gd
		ColorPanel.visible = True
		pnl.AddView(ColorPanel,15dip,0,100dip,50dip)

		Dim ColorLabel As Label
		ColorLabel.Initialize("")
		ColorLabel.TextSize = 30
		ColorLabel.Gravity = Gravity.CENTER_VERTICAL
		ColorLabel.Padding = Array As Int (0, 0, 0, 0)
		ColorLabel.Text = Name
		ColorLabel.TextColor= Colors.Black'Colors.white
		ColorLabel.Visible = True 
		pnl.AddView(ColorLabel,140dip,0,160dip,50dip)
		sv.Panel.AddView(pnl, 0, svHeight, 300dip, 50dip)
		svHeight = svHeight + 50dip + Margin
		sv.panel.Height = svHeight
		' Assigning Touch, Click, and LongClick Events
		Dim r As Reflector
		r.Target = pnl
		'r.SetOnTouchListener("pnlSV_Touch")
		r.SetOnClickListener("pnlSV_Click")
	Next
	sv.Visible=True
	ListOfColorsPanel.AddView(sv,0,0,300dip,ListOfColorsPanel.height)
	Dialog.Title = "Choose Colour"
	' show dialog
   Dim rs As ResumableSub = Dialog.ShowCustom(ListOfColorsPanel, "", "", "CANCEL")
	' these cannot be changed until the dialog is showing
	Dim CancelButton As B4XView = Dialog.GetButton(XUI.DialogResponse_Cancel)
    CancelButton.TextSize = 20
	Dialog.TitleBar.GetView(0).Textsize = 20
	Dialog.TitleBar.Height = 30dip
	Dialog.TitleBar.GetView(0).Height = 30dip
	' If cancelled then comes here and returns Cancelled (-3)
	' If colour selected then handled by pnlSV_Click event which closes the dialog and returns the colour
	Wait For (rs) Complete (Result As Int)
	Return Result
End Sub

Private Sub pnlSV_Click(ViewTag As Object) As Boolean
	Dim pnl As Panel
	pnl = Sender
	Dialog.Close(pnl.tag)
	Return True
End Sub

' measures the height of a text in a singleline or multiline label
Private Sub MeasureTextHeight(ParentView As View, TextSize As Int, Text As String) As Float
	Dim LblCheckSize As Label
	LblCheckSize.Initialize("")
	If Text.Contains(CRLF) Then LblCheckSize.SingleLine = False Else LblCheckSize.SingleLine =True
	LblCheckSize.Visible=True
	LblCheckSize.Color = Colors.Transparent
	LblCheckSize.TextColor= Colors.Transparent
	LblCheckSize.TextSize= TextSize
	LblCheckSize.Gravity = Gravity.TOP
	LblCheckSize.padding = Array As Int (0dip, 0dip,0dip, 0dip)
	If Text = "" Then LblCheckSize.Text = "W" Else	LblCheckSize.Text = Text 
	LblCheckSize.Typeface=Typeface.DEFAULT
	If ParentView Is Panel Then
		Dim Parent As Panel = ParentView
		Parent.AddView(LblCheckSize,10dip,10dip,ActivityWidth,ActivityHeight)	
		Dim su As StringUtils
	    Dim Height As Int = su.MeasureMultilineTextHeight(LblCheckSize,LblCheckSize.Text)
		Parent.RemoveViewAt(Parent.NumberOfViews -1)
		Return Height
	End If
	Return 0
End Sub

' measures the width of text in a label. For multiline labels , uses the longest word.
Private Sub MeasureTextWidth(ParentView As View, TextSize As Int, Text As String) As Float
	' the measurement is incorrect if a line with CRLF's in it is measured as a whole
	' so in multiline text, get longest word in Text and use that for measuring width
	Dim Words() As String = Regex.Split(CRLF, Text)
	Dim WordList As List :	WordList.Initialize2(Words)
	'Dim WordList As List = sf.Split(Text,CRLF)	
	Dim Len As Int = 0 : Dim LongestWord As String = ""
	For I  = 0 To WordList.Size -1
		Dim Word As String = WordList.Get(I)
		If Word.Length > Len Then 
			Len = Word.length : LongestWord = Word
		End If
	Next
	Dim LblCheckSize As Label
	LblCheckSize.Initialize("")
	LblCheckSize.Visible=False
	LblCheckSize.TextSize= TextSize
	LblCheckSize.SingleLine = False
	LblCheckSize.Gravity = Gravity.TOP
	LblCheckSize.padding = Array As Int (0dip, 0dip,0dip, 0dip)
	If Text.Contains(CRLF) Then LblCheckSize.SingleLine = False Else LblCheckSize.SingleLine =True
	If Text = "" Then LblCheckSize.Text = "W" Else	LblCheckSize.Text = LongestWord 
	LblCheckSize.Typeface=Typeface.DEFAULT
	If ParentView Is Panel Then
		Dim Parent As Panel = ParentView
		Parent.AddView(LblCheckSize,0,0,200dip,200dip)
		Dim measure As Canvas
		measure.Initialize(LblCheckSize)
		Dim Width As Int = measure.MeasureStringWidth(LblCheckSize.Text ,LblCheckSize.Typeface,LblCheckSize.TextSize)	' the '|' is a compensating fudge factor as width returned is not quite enough for labels etc.
		Parent.RemoveViewat(Parent.NumberOfViews -1)
		Return Width
	End If
	LblCheckSize = Null
	Return 0
End Sub

Private Sub AnimateDialog (dlg As B4XDialog, FromEdge As String)
    Dim Base As B4XView = dlg.Base
    Dim top As Int = Base.Top
    Dim left As Int = Base.Left
    Select FromEdge.ToLowerCase
        Case "bottom"
            Base.Top = Base.Parent.Height
        Case "top"
            Base.Top = -Base.Height
        Case "left"
            Base.Left = -Base.Width
        Case "right"
            Base.Left = Base.Parent.Width
    End Select
    Base.SetLayoutAnimated(300, left, top, Base.Width, Base.Height)
End Sub
