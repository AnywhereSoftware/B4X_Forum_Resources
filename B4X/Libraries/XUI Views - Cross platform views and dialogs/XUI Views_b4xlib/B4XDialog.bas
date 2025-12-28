B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.78
@EndOfDesignText@
#RaisesSynchronousEvents: ShowTemplate
#RaisesSynchronousEvents: Show
#RaisesSynchronousEvents: ShowCustom
Sub Class_Globals
	Private xui As XUI 
	Public ButtonsHeight As Int = 40dip
	Public TitleBarHeight As Int = 30dip
	Private ButtonWidth As Int = 80dip
	Public Base As B4XView
	Public BackgroundColor As Int = 0xFF555555 'base panel color
	Public OverlayColor As Int = 0xaa000000
	Public BorderColor As Int = 0xff000000
	Public BorderCornersRadius As Int = 2dip
	Public BorderWidth As Int = 2dip
	Public ButtonsColor As Int = 0xFF555555
	Public ButtonsTextColor As Int = 0xFF89D5FF
	Private Background As B4XView
	Private BlurImageView As B4XView
	Public BlurBackground As Boolean
	Private BlurReduceScale As Int
	Public mParent As B4XView
	Public Title As Object = ""
	Public TitleBarColor As Int = 0xFF0083B8
	Public TitleBarTextColor As Int
	Public BodyTextColor As Int = xui.Color_White
	Public TitleBar As B4XView
	Public PutAtTop As Boolean
	Public TitleBarFont As B4XFont
	Public ButtonsFont As B4XFont
	Public ButtonsTextColorDisabled As Int = 0xFF808080
	Public VisibleAnimationDuration As Int = 100
	Public ButtonsOrder() As Int = Array As Int(xui.DialogResponse_Positive, xui.DialogResponse_Negative, xui.DialogResponse_Cancel)
	Public ButtonsState As Map
End Sub

Public Sub Initialize (Parent As B4XView)
	BlurBackground = False
	If xui.IsB4i Then
		BlurReduceScale = 3
	Else If xui.IsB4J Then
		BlurReduceScale = 1
	Else if xui.IsB4A Then
		BlurReduceScale = 3
	End If
	mParent = Parent
	#if B4J
	Dim node As JavaObject = mParent
	Dim stylesheets As List = node.RunMethodJO("getScene", Null).RunMethod("getStylesheets", Null)
	stylesheets.Add(File.GetUri(File.DirAssets, "Dialog.css"))
	#End If
	TitleBarFont = xui.CreateDefaultBoldFont(16)
	ButtonsFont = xui.CreateDefaultBoldFont(15)
	TitleBarTextColor = xui.Color_White
	ButtonsState.Initialize
End Sub

'Example:<code>
'Dim options As B4XListTemplate
'options.Initialize
'options.Options = Array("Cat", "Dog", "Fish", "Crocodile")
'Wait For (Dialog.ShowTemplate(options, "OK", "", "CANCEL")) Complete (Result As Int)
'If Result = xui.DialogResponse_Positive Then
'	Dialog.Show($"You selected: ${options.SelectedItem}"$, "OK", "", "")
'End If</code>
Public Sub ShowTemplate (DialogTemplate As Object, Yes As Object, No As Object, Cancel As Object) As ResumableSub
	Dim content As B4XView = CallSub2(DialogTemplate, "GetPanel", Me)
	CallSub2(DialogTemplate, "Show", Me)
	Wait For (ShowCustom(content , Yes, No, Cancel)) Complete (Result As Int)
	CallSub2(DialogTemplate, "DialogClosed", Result)
	PutAtTop = False
	Return Result
End Sub

Public Sub Show (Text As Object, Yes As Object, No As Object, Cancel As Object) As ResumableSub
	Dim p As B4XView
	p = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 300dip, 100dip)
	Dim lbl As Label
	lbl.Initialize("")
	#if B4J
	lbl.WrapText = True
	#else if B4A
	lbl.SingleLine = False
	#else if B4i
	lbl.Multiline = True
	#end if
	Dim xlbl As B4XView = lbl
	p.AddView(xlbl, 5dip, 0, p.Width - 10dip, p.Height)
	xlbl.TextColor = BodyTextColor
	xlbl.Font = TitleBarFont
	XUIViewsUtils.SetTextOrCSBuilderToLabel(xlbl, Text)
	xlbl.SetTextAlignment("CENTER", "LEFT")
	Wait For (ShowCustom(p, Yes, No, Cancel)) Complete (Result As Int)
	Return Result
End Sub

Public Sub ShowCustom (Content As B4XView, Yes As Object, No As Object, Cancel As Object) As ResumableSub
	For Each v As B4XView In mParent.GetAllViewsRecursive
		If v.Tag <> Null And v.Tag = "b4xdialog_background" Then
			v.RemoveViewFromParent
			Exit
		End If
	Next
	ButtonsState.Clear
	Dim Background As B4XView = xui.CreatePanel("background")
	Background.Tag = "b4xdialog_background"
	If BlurBackground Then
		Dim iv As ImageView
		iv.Initialize("")
		BlurImageView = iv
		Background.AddView(BlurImageView, 0, 0, Background.Width, Background.Height)
		Background.Color = xui.Color_Transparent
	Else
		Background.Color = OverlayColor
	End If
	#if B4A
	Dim p As Panel = Background
	p.Elevation = 4dip
	#End If
	If mParent.Width = 0 Or mParent.Height = 0 Then
		Log("Warning: dialog shown with zero sized parent.")
	End If
	mParent.AddView(Background, 0, 0, mParent.Width, mParent.Height)
	UpdateBlur
	Base = xui.CreatePanel("")
	Base.SetColorAndBorder(BackgroundColor, BorderWidth, BorderColor, BorderCornersRadius)
	Base.RequestFocus
	Dim IncludeTitle As Boolean = Title <> ""
	Dim TempTitleBarHeight As Int = 0
	If IncludeTitle Then
		TempTitleBarHeight = TitleBarHeight
	End If
	Dim height As Int = Content.Height + ButtonsHeight + 3dip + 3dip + TempTitleBarHeight
	Dim width As Int = Content.Width + 4dip
	Dim Top As Int = Round(Background.Height / 2 - height / 2)
	Dim RemoveTitle As Boolean
	If PutAtTop Then
		Top = 20dip
		If Background.Height - Top - height < 200dip Then RemoveTitle = True
	End If
	If RemoveTitle Or Background.Height < height Then
		Top = 1dip
		IncludeTitle = False
		height = height - TempTitleBarHeight - 3dip
		TempTitleBarHeight = 0
	End If
	Background.AddView(Base, Round(Background.Width / 2 - width / 2), _
		 Top, Round(width), Round(height))
	For i = ButtonsOrder.Length - 1 To 0 Step - 1
		Dim btype As Int = ButtonsOrder(i)
		Select btype
			Case xui.DialogResponse_Cancel
				CreateButton(Cancel, btype)
			Case xui.DialogResponse_Negative
				CreateButton(No, btype)
			Case xui.DialogResponse_Positive
				CreateButton(Yes, btype)
		End Select
	Next
	Base.Visible = False
	If IncludeTitle Then
		TitleBar = xui.CreatePanel("TitleBar")
		TitleBar.Color = TitleBarColor
		Base.AddView(TitleBar, 2dip, 2dip, Content.Width, TempTitleBarHeight)
		Dim lbl As Label
		lbl.Initialize("")
		Dim xlbl As B4XView = lbl
		XUIViewsUtils.SetTextOrCSBuilderToLabel(xlbl, Title)
		xlbl.TextColor = TitleBarTextColor
		xlbl.Font = TitleBarFont
		xlbl.SetTextAlignment("CENTER", "CENTER")
		TitleBar.AddView(xlbl, 0, 0, TitleBar.Width, TitleBar.Height)
	End If
	Content.RemoveViewFromParent
	Base.AddView(Content, 2dip, 2dip + TempTitleBarHeight, Content.Width, Content.Height)
	Base.SetVisibleAnimated(VisibleAnimationDuration, True)
	For Each v As B4XView In Background.GetAllViewsRecursive
		v.Enabled = True
	Next
	Wait For CloseMessage (Result As Int)
	For Each v As B4XView In Background.GetAllViewsRecursive
		v.Enabled = False
	Next
	Base.SetVisibleAnimated(VisibleAnimationDuration, False)
	If VisibleAnimationDuration > 0 Then
		Sleep(VisibleAnimationDuration)
	End If
	Background.RemoveViewFromParent
	Return Result
End Sub

Public Sub getVisible As Boolean
	Return Background.IsInitialized And Background.Parent.IsInitialized
End Sub

Private Sub CreateButton (Text As Object, Code As Int)
	If Text = "" Then Return
	#if B4J
	Dim btn As Button
	#else
	Dim btn As Label
	#End If
	btn.Initialize("Button")	
	Dim xbtn As B4XView = btn
	XUIViewsUtils.SetTextOrCSBuilderToLabel(xbtn, Text)
	xbtn.Tag = Code
	xbtn.SetColorAndBorder(ButtonsColor, 0dip, BorderColor, 5dip)
	xbtn.SetTextAlignment("CENTER", "CENTER")
	xbtn.TextColor = ButtonsTextColor
	xbtn.Font = ButtonsFont
	Dim numberOfButtons As Int = Base.NumberOfViews 'nothing was added yet except of buttons
	Base.AddView(xbtn, Base.Width - 4dip - numberOfButtons * (ButtonWidth + 5dip) - ButtonWidth, _
		 Base.Height - ButtonsHeight - 4dip, ButtonWidth, ButtonsHeight)
	If Code = xui.DialogResponse_Cancel Then xbtn.RequestFocus
End Sub

'Returns one of the Yes, No or Cancel buttons.
Public Sub GetButton (ResultCode As Int) As B4XView
	For Each b As B4XView In Base.GetAllViewsRecursive
		If b.Tag = ResultCode Then Return b 'ignore
	Next
	Return Null
End Sub

'Sets the enabled state of a button.
Public Sub SetButtonState (ResultCode As Int, Enabled As Boolean)
	Dim b As B4XView = GetButton(ResultCode)
	If b.IsInitialized Then
		b.Enabled = Enabled
		If Enabled Then b.TextColor = ButtonsTextColor Else b.TextColor = ButtonsTextColorDisabled
		ButtonsState.Put(ResultCode, Enabled)
	End If
End Sub


Private Sub Button_Click
	Dim b As B4XView = Sender
	If ButtonsState.GetDefault(b.Tag, True) = False Then Return
	Close(b.Tag)
End Sub

Public Sub Close (Result As Int) As Boolean
	If getVisible Then
		CallSubDelayed2(Me, "CloseMessage", Result)
		Return True
	End If
	Return False
End Sub

#if B4J
Private Sub Background_MouseClicked (EventData As MouseEvent)
	EventData.Consume
End Sub
#end if

Private Sub Background_Touch (Action As Int, X As Float, Y As Float)
	
End Sub


Private Sub Background_Click
	
End Sub

'should be called when the parent page or form resizes. Will recenter the dialog.
Public Sub Resize (Width As Int, Height As Int)
	
	Dim Top As Int = Round(Background.Height / 2 - Base.Height / 2)
	If PutAtTop Then Top = 20dip
	Background.SetLayoutAnimated(0, 0, 0, Width, Height)
	Base.SetLayoutAnimated(200, Round(Background.Width / 2 - Base.Width / 2), Top, Base.Width, Base.Height)
	If xui.IsB4J Then
		UpdateBlur
	End If
End Sub

Private Sub UpdateBlur
	If BlurBackground = False Then Return
	Background.Visible = False
	Dim source As B4XBitmap = Background.Parent.Snapshot
	If source.Width > Background.Width Or source.Height > Background.Height Then
		source = source.Crop(0, 0, Background.Width, Background.Height)
	End If
	Background.Visible = True
	BlurImageView.SetLayoutAnimated(0, 0, 0, Background.Width, Background.Height)
	Dim blurred As BitmapCreator = Blur(source)
	blurred.SetBitmapToImageView(blurred.Bitmap, BlurImageView)
End Sub

Private Sub Blur (bmp As B4XBitmap) As BitmapCreator
	Dim bc As BitmapCreator
	Dim ReduceScale As Int = BlurReduceScale
	bc.Initialize(bmp.Width / ReduceScale / bmp.Scale, bmp.Height / ReduceScale / bmp.Scale)
	bc.CopyPixelsFromBitmap(bmp)
	Dim count As Int = 2
	Dim clrs(3) As ARGBColor
	Dim temp As ARGBColor
	Dim m As Int
	For steps = 1 To count
		For y = 0 To bc.mHeight - 1
			For x = 0 To 2
				bc.GetARGB(x, y, clrs(x))
			Next
			SetAvg(bc, 1, y, clrs, temp)
			m = 0
			For x = 2 To bc.mWidth - 2
				bc.GetARGB(x + 1, y, clrs(m))
				m = (m + 1) Mod 3
				SetAvg(bc, x, y, clrs, temp)
			Next
		Next
		For x = 0 To bc.mWidth - 1
			For y = 0 To 2
				bc.GetARGB(x, y, clrs(y))
			Next
			SetAvg(bc, x, 1, clrs, temp)
			m = 0
			For y = 2 To bc.mHeight - 2
				bc.GetARGB(x, y + 1, clrs(m))
				m = (m + 1) Mod 3
				SetAvg(bc, x, y, clrs, temp)
			Next
		Next
	Next
	Return bc
End Sub

Private Sub SetAvg(bc As BitmapCreator, x As Int, y As Int, clrs() As ARGBColor, temp As ARGBColor)
	temp.Initialize
	For Each c As ARGBColor In clrs
		temp.r = temp.r + c.r
		temp.g = temp.g + c.g
		temp.b = temp.b + c.b
	Next
	temp.a = 255
	temp.r = temp.r / 3
	temp.g = temp.g / 3
	temp.b = temp.b / 3
	bc.SetARGB(x, y, temp)
End Sub

Public Sub InternalSetTextOrCSBuilderToLabel(xlbl As B4XView, Text As Object)
	XUIViewsUtils.SetTextOrCSBuilderToLabel(xlbl, Text)
End Sub

Public Sub InternalAddStubToCLVIfNeeded(CustomListView1 As CustomListView, Color As Int)
	XUIViewsUtils.AddStubToCLVIfNeeded(CustomListView1, Color)
End Sub



Private Sub Stub_Click
	
End Sub



