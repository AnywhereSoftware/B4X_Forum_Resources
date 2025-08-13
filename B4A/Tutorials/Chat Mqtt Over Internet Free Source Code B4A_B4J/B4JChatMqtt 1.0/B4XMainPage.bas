B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private fx As JFX
	Private Root As B4XView
	Private xui As XUI
	Private mqtt As MqttClient
	Private serializator As B4XSerializator	
	Private SubscribeTopic As String = "Chat_Mqtt/#"'change topic!
	Private PublishTopic As String = "Chat_Mqtt/"	'change topic!
	Private UserMqtt As String = ""	
	Private PasswordMqtt As String = ""		
	Private CLV As CustomListView
	Private BBCodeView1 As BBCodeView
	Private Engine As BCTextEngine
	Private bc As BitmapCreator
	Private ArrowWidth As Int = 10dip
	Private Gap As Int = 6dip
	Private pnlBottom As B4XView
	Private UserWriteToRight As Boolean = True
	Private UserWriteToLeft As Boolean = False
	Private FormMain As Form
	Private TextFieldUser As B4XFloatTextField
	Private TextFieldSend As B4XFloatTextField
	Private BTConnect As Button
	Private GetIDFromTopic As String	
	Private PnlConnect As Pane
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	FormMain = B4XPages.GetNativeParent(Me)
	FormMain.Resizable = False
	FormMain.Icon = fx.LoadImage(File.DirAssets, "chat.png")
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "ChatMqtt 1.0")
	TextFieldUser.TextField.SetTextAlignment("CENTER","CENTER")
	TextFieldUser.TextField.SetColorAndBorder(xui.Color_White,1dip,xui.Color_Black,8dip)
	TextFieldSend.TextField.SetColorAndBorder(xui.Color_White,2dip,xui.Color_Black,8dip)
	
	Engine.Initialize(Root)
	bc.Initialize(300, 300)
	TextFieldSend.NextField = TextFieldSend
	TextFieldUser.RequestFocusAndShowKeyboard
End Sub

'(Label) SEND MESSAGE
Private Sub lblSend_Click
	If TextFieldSend.Text.Length > 0 And TextFieldUser.Text.Length > 0 Then		
		mqtt.Publish(PublishTopic, serializator.ConvertObjectToBytes(TextFieldSend.Text))
	End If
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
'	If Right Then User = "User 2" Else User = "User 1"
	If Right Then User = TextFieldUser.Text Else User = GetIDFromTopic'"User 2"
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
	If Right Then clr = 0xFFC1F7A3 Else clr = 0xFFEFEFEF'Color Bubble chat
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
	time.TextColor = xui.Color_Black'.Color_Gray' Color text time
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

'MQTT CODE
'IF CONNECTED..
Sub mqtt_Connected (Success As Boolean)	
	If Success = False Then
		Log(LastException)
		fx.Msgbox(Root,LastException,"Ops!")
	Else
		BTConnect.Text = "Connected"
		BTConnect.TextColor = fx.Colors.Red
		TextFieldUser.TextField.Enabled = False		
		mqtt.Subscribe(SubscribeTopic, 1)
		PublishTopic = PublishTopic & mqtt.ClientId
		Sleep(1000)
		PnlConnect.Visible = False
		pnlBottom.Visible = True
	End If
End Sub

'IF DISCONNECTED
Private Sub mqtt_Disconnected
	Log("Disconnected")
End Sub

'RECEIVE MESSAGE
Private Sub mqtt_MessageArrived (Topic As String, Payload() As Byte)
'	Log(Topic)
	GetIDFromTopic = Topic.SubString(10)'get UserId
	Dim obj As Object = serializator.ConvertBytesToObject(Payload)
'	Log(obj)	
	If mqtt.ClientId = GetIDFromTopic Then
		AddItem(obj, UserWriteToRight)'Write to right chat
	Else	
		AddItem(obj, UserWriteToLeft)''Write to Left chat
	End If	
End Sub

'CONNECT TO BROKER
Private Sub BTConnect_Click
	If TextFieldUser.Text.Length > 0 Then		
		If BTConnect.Text = "Connect" Then
			If mqtt.IsInitialized Then mqtt.Close		
			Dim clientId As String = TextFieldUser.Text & "-" & Rnd(0, 999999999)'create a unique id
			mqtt.Initialize("mqtt", "tcp://broker.hivemq.com:1883", clientId)
'		    mqtt.Initialize("mqtt", "tcp://broker.emqx.io:1883", clientId)
'			mqtt.Initialize("mqtt", "tcp://test.mosquitto.org:1883", clientId)
'		    mqtt.Initialize("mqtt", "tcp://mqtt.fluux.io:1883", clientId)		
			Dim mo As MqttConnectOptions
			mo.Initialize(UserMqtt, PasswordMqtt)
			mqtt.Connect2(mo)			
'			Log(clientId)
		Else
'			If BTConnect.Text = "Connected" Then
'				BTConnect.Text = "Connect"				
'				BTConnect.TextColor = fx.Colors.Black
'				TextFieldUser.TextField.Enabled = True				
'				mqtt.Close
'			End If
		End If
	Else
		xui.MsgboxAsync("Please Insert User Name","ChatMqtt")	
	End If	
End Sub


'Button X Form
Private Sub B4XPage_CloseRequest As ResumableSub
	Dim sf As Object = xui.Msgbox2Async("Exit?", "ChatMqtt", "Yes", "", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then				
		mqtt.Close		
		Return True
	Else
		Return False
	End If
End Sub