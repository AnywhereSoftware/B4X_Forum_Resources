B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6
@EndOfDesignText@
#Event: OnClick(Title As String, Msg As String, ID As Int)

Sub Class_Globals
	Private xui As XUI
	Private left As Int
	Private mCallback As Object
	Private mEventName As String
	Private TitleEvent As String
	Private lstMex As List
	Private msgMap As Map
	Private shown As Boolean
	Private ID As Int
	Dim iphone As Phone
End Sub

Public Sub Initialize(Callback As Object,EventName As String)
	mCallback = Callback
	mEventName = EventName
	lstMex.Initialize
	msgMap.Initialize
	shown = False
	ID = 0
End Sub

Sub ShowNotification (Parent As B4XView, Title As String, Msg As String, Icon As String, Height As Int, BackgroundColor As Int, TextColor As Int, ShowTime As Int, Vibrate As Boolean)
	If (Not(shown)) Then
		shown = True
		Dim p As B4XView = xui.CreatePanel("pnlNotification")
		p.Color = BackgroundColor
		
		If lstMex.Size == 0 Then
			ID = ID + 1
			msgMap = CreateMap("Parent":Parent, "Title":Title, "Msg":Msg, "Icon":Icon, "Height":Height, "BackgroundColor":BackgroundColor, "TextColor":TextColor, "ShowTime":ShowTime, "ID":ID)
			lstMex.Add(msgMap)
			p.Tag = ID
		Else
			Dim m As Map 
			m = lstMex.Get(0)
			p.tag = m.Get("ID")
			Vibrate = m.Get("Vibrate")
		End If
		
		Dim Height As Int = Height
		Parent.AddView(p, 0, -Height, Parent.Width, Height)

		Dim Titlelbl As Label
		Dim Msglbl As Label
		Titlelbl.Initialize("")
		Msglbl.Initialize("")

		Dim xTitle As B4XView = Titlelbl
		Dim xMsg As B4XView = Msglbl

		Dim xIcon As ImageView
		xIcon.Initialize("")
		If (Icon <> "") And (Icon <> Null) Then
			xIcon.Visible = True
			xIcon.Bitmap = LoadBitmapResize(File.DirAssets, Icon, Height-20dip, Height-20dip, True)
			p.AddView(xIcon, 10dip, 10dip, Height - 20dip, Height-20dip)

			left = (10dip + (Height-20dip) + 10dip)
		Else
			xIcon.Visible = False
			p.AddView(xIcon, 10dip, 10dip, Height - 20dip, Height-20dip)
			left = 10dip
		End If

		xTitle.Text = Title
		TitleEvent = xTitle.Text
		xTitle.Font = Font.CreateNewBold(17)
		xTitle.TextColor = TextColor
		xTitle.SetTextAlignment("TOP", "LEFT")
		p.AddView(xTitle, left, 10dip, (p.Width - (5dip + 70dip) -10dip), 20dip)

		xMsg.Text = Msg
		xMsg.TextSize = 16
		xMsg.TextColor = TextColor
		xMsg.SetTextAlignment("TOP", "LEFT")
		p.AddView(xMsg, left, (xTitle.Height + 10dip), (p.Width - (5dip + 70dip) -10dip), (p.Height - (xTitle.Height + 10dip)-10dip))
		
		
		If Vibrate Then
			iphone.Vibrate
		End If
		
		p.SetLayoutAnimated(200, 0, 0, p.Width, p.Height)
		Sleep(ShowTime)
		p.SetLayoutAnimated(200, 0, -p.Height, p.Width, p.Height)
		p.SetVisibleAnimated(200, False)
		Sleep(500)
		p.RemoveViewFromParent
		
		If p.Tag == 1 Then
			lstMex.RemoveAt(0)
		End If
		
		shown = False
		Queue
	Else
		ID = ID + 1
		msgMap = CreateMap("Parent":Parent, "Title":Title, "Msg":Msg, "Icon":Icon, "Height":Height, "BackgroundColor":BackgroundColor, "TextColor":TextColor, "ShowTime":ShowTime, "Vibrate":Vibrate, "ID":ID)
		lstMex.Add(msgMap)
	End If
End Sub

Private Sub pnlNotification_Click
	Dim p As B4XView = Sender
	p.SetLayoutAnimated(200, 0, -p.Height, p.Width, p.Height)
	Sleep(200)
	p.SetVisibleAnimated(100, False)
	
	Dim m As Map
	For i=0 To lstMex.Size-1
		m = lstMex.Get(i)
		
		If p.Tag == m.Get("ID") Then
			'lstMex.RemoveAt(i)
			Exit
		End If
	Next
	Dim t As String = p.GetView(1).Text
	Dim m1 As String = p.GetView(2).Text
	
	Dim Data() As String = Array As String (t, m1)
	
	CallSub3(mCallback, mEventName & "_OnClick", Data, p.Tag)
End Sub

Private Sub Queue
	Dim m As Map
	Dim v As Boolean
	If lstMex.Size > 0 Then
		m = lstMex.Get(0)
		If m.Get("Vibrate") == "1" Then
			v=True
		Else
			v= False
		End If
		ShowNotification(m.Get("Parent"), m.Get("Title"), m.Get("Msg"), m.Get("Icon"), m.Get("Height"), m.Get("BackgroundColor"), m.Get("TextColor"), m.Get("ShowTime"), v)
		lstMex.RemoveAt(0)
	Else
		ID = 0
	End If
End Sub