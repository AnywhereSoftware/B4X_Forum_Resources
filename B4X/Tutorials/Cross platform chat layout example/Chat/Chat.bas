B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8
@EndOfDesignText@
#IgnoreWarnings: 6
Sub Class_Globals
	Private xui As XUI
	Private TextField As B4XFloatTextField
	Private CLV As CustomListView
	Private BBCodeView1 As BBCodeView
	Private Engine As BCTextEngine
	Private bc As BitmapCreator
	Private ArrowWidth As Int = 10dip
	Private Gap As Int = 6dip
	Private pnlBottom As B4XView
	Private LastUserLeft As Boolean = True
End Sub

Public Sub Initialize (Parent As B4XView)
	Parent.LoadLayout("1")
	Engine.Initialize(Parent)
	bc.Initialize(300, 300)
	TextField.NextField = TextField
End Sub

Private Sub lblSend_Click
	If TextField.Text.Length > 0 Then
		LastUserLeft = Not(LastUserLeft)
		AddItem(TextField.Text, LastUserLeft)
	End If
	TextField.RequestFocusAndShowKeyboard
	#if B4J
	Dim ta As TextArea = TextField.TextField
	ta.SelectAll
	#else if B4A
	Dim et As EditText = TextField.TextField
	et.SelectAll
	#else if B4i
	Dim ta As TextView = TextField.TextField
	ta.SelectAll
	#end if
End Sub

'Modifies the layout when the keyboard state changes.
Public Sub HeightChanged (NewHeight As Int)
	Dim c As B4XView = CLV.AsView
	c.Height = NewHeight - pnlBottom.Height
	CLV.Base_Resize(c.Width, c.Height)
	pnlBottom.Top = NewHeight - pnlBottom.Height
	ScrollToLastItem
End Sub

Private Sub AddItem (Text As String, Right As Boolean)
	Dim p As B4XView = xui.CreatePanel("")
	p.Color = xui.Color_Transparent
	Dim User As String
	If Right Then User = "User 2" Else User = "User 1"
	BBCodeView1.ExternalRuns = BuildMessage(Text, User)
	BBCodeView1.ParseAndDraw
	Dim ivText As B4XView = CreateImageView
	'get the bitmap from BBCodeView1 foreground layer.
	Dim bmpText As B4XBitmap = GetBitmap(BBCodeView1.ForegroundImageView)
	'the image might be scaled by Engine.mScale. The "correct" dimensions are:
	Dim TextWidth As Int = bmpText.Width / Engine.mScale
	Dim TextHeight As Int = bmpText.Height / Engine.mScale
	'bc is not really used here. Only the utility method.
	bc.SetBitmapToImageView(bmpText, ivText)
	Dim ivBG As B4XView = CreateImageView
	'Draw the bubble.
	Dim bmpBG As B4XBitmap = DrawBubble(TextWidth, TextHeight, Right)
	bc.SetBitmapToImageView(bmpBG, ivBG)
	p.SetLayoutAnimated(0, 0, 0, CLV.sv.ScrollViewContentWidth - 2dip, TextHeight + 3 * Gap)
	If Right Then
		p.AddView(ivBG, p.Width - bmpBG.Width * xui.Scale, Gap, bmpBG.Width * xui.Scale, bmpBG.Height * xui.Scale)
		p.AddView(ivText, p.Width - Gap - ArrowWidth - TextWidth, 2 * Gap, TextWidth, TextHeight)
	Else
		p.AddView(ivBG, 0, Gap, bmpBG.Width * xui.Scale, bmpBG.Height * xui.Scale)
		p.AddView(ivText, Gap + ArrowWidth, 2 * Gap, TextWidth, TextHeight)
	End If
	CLV.Add(p, Null)
	ScrollToLastItem
End Sub

Private Sub ScrollToLastItem
	Sleep(50)
	If CLV.Size > 0 Then
		If CLV.sv.ScrollViewContentHeight > CLV.sv.Height Then
			CLV.ScrollToItem(CLV.Size - 1)
		End If
	End If
End Sub

Private Sub DrawBubble (Width As Int, Height As Int, Right As Boolean) As B4XBitmap
	'The bubble doesn't need to be high density as it is a simple drawing.
	Width = Ceil(Width / xui.Scale)
	Height = Ceil(Height / xui.Scale)
	Dim ScaledGap As Int = Ceil(Gap / xui.Scale)
	Dim ScaledArrowWidth As Int = Ceil(ArrowWidth / xui.Scale)
	Dim nw As Int = Width + 2 * ScaledGap + ScaledArrowWidth
	Dim nh As Int = Height + 2 * ScaledGap
	If bc.mWidth < nw Or bc.mHeight < nh Then
		bc.Initialize(Max(bc.mWidth, nw), Max(bc.mHeight, nh))
	End If
	bc.DrawRect(bc.TargetRect, xui.Color_Transparent, True, 0)
	Dim r As B4XRect
	Dim path As BCPath
	Dim clr As Int
	If Right Then clr = 0xFFEFEFEF Else clr = 0xFFC1F7A3
	If Right Then
		r.Initialize(0, 0, nw - ScaledArrowWidth, nh)
		path.Initialize(nw - 1, 1)
		path.LineTo(nw - 1 - (10 + ScaledArrowWidth), 1)
		path.LineTo(nw - 1 - ScaledArrowWidth, 10)
		path.LineTo(nw - 1, 1)
	Else
		r.Initialize(ScaledArrowWidth, 1, nw, nh)
		path.Initialize(1, 1)
		path.LineTo((10 + ScaledArrowWidth), 1)
		path.LineTo(ScaledArrowWidth, 10)
		path.LineTo(1, 1)
	End If
	bc.DrawRectRounded(r, clr, True, 0, 10)
	bc.DrawPath(path, clr, True, 0)
	bc.DrawPath(path, clr, False, 2)
	Dim b As B4XBitmap = bc.Bitmap
	Return b.Crop(0, 1, nw, nh)
End Sub

Private Sub BuildMessage (Text As String, User As String) As List
	Dim title As BCTextRun = Engine.CreateRun(User & CRLF)
	title.TextFont  = BBCodeView1.ParseData.DefaultBoldFont
	Dim TextRun As BCTextRun = Engine.CreateRun(Text & CRLF)
	Dim time As BCTextRun = Engine.CreateRun(DateTime.Time(DateTime.Now))
	time.TextFont = xui.CreateDefaultFont(10)
	time.TextColor = xui.Color_Gray
	Return Array(title, TextRun, time)
End Sub

Private Sub GetBitmap (iv As ImageView) As B4XBitmap
	#if B4J
	Return iv.GetImage
	#Else If B4A or B4i
	Return iv.Bitmap
	#End If
End Sub

Private Sub CLV_ItemClick (Index As Int, Value As Object)
	#if B4i
	Dim tf As View = TextField.TextField
	tf.ResignFocus
	#End If
End Sub

Private Sub CreateImageView As B4XView
	Dim iv As ImageView
	iv.Initialize("")
	Return iv
End Sub

#if B4J
Sub lblSend_MouseClicked (EventData As MouseEvent)
	lblSend_Click
	EventData.Consume
End Sub
#end if