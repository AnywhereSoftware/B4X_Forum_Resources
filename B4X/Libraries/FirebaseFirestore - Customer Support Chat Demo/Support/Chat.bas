B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8
@EndOfDesignText@
#IgnoreWarnings: 6
Sub Class_Globals
	Private xui As XUI	
	#if b4a or b4j
	Private TextField As B4XView
	#Else If b4i
	Private TextField As TextField
	#End If
	Private CLV As CustomListView
	Private BBCodeView1 As BBCodeView
	Private Engine As BCTextEngine
	Private bc As BitmapCreator
	Private ArrowWidth As Int = 10dip
	Private Gap As Int = 6dip
	Private pnlBottom As B4XView
	Private LastUserLeft As Boolean = True
	Private store As Firestore
	Private ChatDocID As String
	Private PageTitleLabel As B4XView
	Private ChatImagePanel As B4XView
	Private BackButton As Button
	Private Pane As B4XView
End Sub

Public Sub Initialize (Parent As B4XView, Base As Firestore, Doc As String, Data As Map)
	Pane = Parent
	Parent.LoadLayout("chat")
	Engine.Initialize(Parent)
	bc.Initialize(300, 300)
'	TextField.NextField = TextField
	PageTitleLabel.Text = Data.Get("title")
	Utils.DownloadMedia3(Data.Get("product_photo_url"),ChatImagePanel)
	#if b4a
	TextField.Color = xui.Color_Transparent
	#End If
	store = Base
	ChatDocID = Doc
End Sub

Private Sub lblSend_Click
	If TextField.Text.Length > 0 Then
		LastUserLeft = Not(LastUserLeft)
		Dim Map As Map = CreateMap( _
		"sender_id": 0, _
		"sender": "Support", _
		"message": TextField.Text, _
		"timestamp": DateTime.Now.As(Int), _
		"time": DateTime.Now _
		)
		Dim path As PathBuilder
		path.Initialize
		path.Collection("chats").Document(ChatDocID).Collection("messages")
		Log(path.Complete)
		Wait For(store.CreateDocument(path.Complete,"",Map)) Complete(Data As Map)
'		Log(Data)
		Dim Map As Map = CreateMap("last_message":TextField.Text,"timestamp":DateTime.Now.As(Int))
		Wait For(store.UpdateDocument("chats",ChatDocID,Map)) Complete(Data As Map)
'		Log(Data)
	End If
	TextField.RequestFocus
	TextField.Text = ""	
	#if B4J
	Dim ta As B4XView = TextField
	ta.SelectAll
	#else if B4A
	Dim et As B4XView = TextField
	et.SelectAll
	#else if B4i
	TextField.SelectAll
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

Public Sub AddItem (Text As String,Name As String, Right As Boolean)
	Dim p As B4XView = xui.CreatePanel("")
	p.Color = xui.Color_Transparent
	Dim User As String = Name
	'If Right Then User = "User 2" Else User = "User 1"
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
	If Right Then clr = 0xFFEFEFEF Else clr = 0xFFF4DDEE
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
	title.TextFont  = xui.CreateDefaultBoldFont(10)'BBCodeView1.ParseData.DefaultBoldFont
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
	Dim tf As View = TextField
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

Private Sub BackButton_Click
	Pane.RemoveAllViews
End Sub