B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'Version: 1
'Ui max_co

#Event: itemYouClicked (ItemName As String,ItemIndex as int)

#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFF12153D, Description: Text color
#DesignerProperty: Key: ActiveColor, DisplayName: Active Color, FieldType: Color, DefaultValue: 0xFF43A047, Description: Active Color
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFffffff, Description: Background Color
#DesignerProperty: Key: BorderColor, DisplayName: BorderColor, FieldType: Color, DefaultValue: 0xFFffffff, Description: BorderColor
#DesignerProperty: Key: TextSize, DisplayName: Text Size, FieldType: Int, DefaultValue: 16, MinRange: 0, MaxRange: 100, Description: TextSize
#DesignerProperty: Key: BorderWidth, DisplayName: Border Width, FieldType: Int, DefaultValue: 1, MinRange: 0, MaxRange: 20, Description: Border Width
#DesignerProperty: Key: AnimationDuration, DisplayName: Animation Duration, FieldType: String, DefaultValue: Normal, List: Fast|Normal|Slow

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Type TabbarViewes(pnl As B4XView,Active As B4XView,Texts As List)
	Type TabbarVar(TextSize As Int,TextColor As Int,ActiveColor As Int,BackgroundColor As Int,BorderWidth As Int,BorderColor As Int,Fonte As B4XFont,LstText As List,ActiveMakan As Int,AnimationDuration As Int)
	
	
	Private Viewess As TabbarViewes
	Private var As TabbarVar

	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	
	IniViewes
	FillVar(Props)
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
	Viewess.pnl.SetLayoutAnimated(0,4dip,0,Width-4dip,Height)
	Viewess.pnl.SetColorAndBorder(var.BackgroundColor,var.BorderWidth,var.BorderColor,Height)
  	
	Private Andaze As Double = Viewess.pnl.Width / var.LstText.Size
	Private l2 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
	Viewess.Active.SetLayoutAnimated(0,Viewess.pnl.Left+l2.Left,Viewess.pnl.Top,Andaze,Viewess.pnl.Height)
	Viewess.Active.SetColorAndBorder(var.ActiveColor,0,0,Height)
	
	For i=0 To Viewess.Texts.Size-1
		Private l As B4XView = Viewess.Texts.Get(i)
		l.SetLayoutAnimated(0,Viewess.pnl.Left+(i*Andaze),0,Andaze,Viewess.pnl.Height)
	Next
  
End Sub

Private Sub FillVar(Props As Map)
	
	var.ActiveColor = xui.PaintOrColorToColor(Props.Get("ActiveColor"))
	var.TextColor = xui.PaintOrColorToColor(Props.Get("TextColor"))
	var.BackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	var.BorderColor = xui.PaintOrColorToColor(Props.Get("BorderColor"))
	var.TextSize = Props.Get("TextSize")
	var.BorderWidth = Props.Get("BorderWidth")
	var.Fonte = xui.CreateDefaultFont(var.TextSize)
	Private lst As String = Props.Get("AnimationDuration")
	Select lst
		Case "Fast"
			var.AnimationDuration = 180
		Case "Normal"
			var.AnimationDuration = 280
		Case "Slow"
			var.AnimationDuration = 380
	End Select
End Sub

Private Sub IniViewes
	Viewess.Initialize
	var.Initialize
	Viewess.Texts.Initialize
	var.LstText.Initialize
	Viewess.Texts.Initialize
End Sub

Private Sub CreateLabel(Event As String) As B4XView
	Private l As Label
	l.Initialize(Event)
	#if B4A
	l.SingleLine = True
	l.Ellipsize = "END"
	#End If
	
	Return l
End Sub

Private Sub Design
	
	mBase.SetColorAndBorder(xui.Color_Transparent,0,xui.Color_Transparent,0)
	

	''''Background

	Viewess.pnl = xui.CreatePanel("")
	
	Viewess.pnl.SetColorAndBorder(var.BackgroundColor,var.BorderWidth,var.BorderColor,mBase.Height)
	mBase.AddView(Viewess.pnl,4dip,0,mBase.Width-8dip,mBase.Height)
	
	''''Pnl Active
	Private Andaze As Double = Viewess.pnl.Width / var.LstText.Size
	Private l2 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
	Viewess.Active = xui.CreatePanel("")
	Viewess.Active.SetColorAndBorder(var.ActiveColor,0,0,Viewess.pnl.Height)
	mBase.AddView(Viewess.Active,Viewess.pnl.Left+l2.Left,Viewess.pnl.Top,Andaze,Viewess.pnl.Height)
	
	''''Texts
	For i=0 To var.LstText.Size-1
		Private l As B4XView = Viewess.Texts.Get(i)
		If i=var.ActiveMakan Then
			l.TextColor = xui.Color_White
		End If
		mBase.AddView(l,Viewess.pnl.Left+(i*Andaze),0,Andaze,Viewess.pnl.Height)
	Next
	

End Sub

Private Sub TextAjza
	
	Private str(2) As String = Array As String("a","b","c","d","e","f","g","h","u","j","k","l","n","p")
	
	Private l As B4XView = CreateLabel(str(var.LstText.Size-1))
	l.TextColor = var.TextColor
	l.Font = var.Fonte
	l.TextSize = var.TextSize
	l.SetTextAlignment("CENTER","CENTER")
	l.Text = var.LstText.Get(var.LstText.Size-1)
	Viewess.Texts.Add(l)
	
End Sub

Public Sub AddText(Text As String)
	If Viewess.Active.IsInitialized = False Then
		var.LstText.Add(Text)
		TextAjza
	Else
		Log("Add this text before calling the Show method")
	End If
End Sub

Public Sub SetActive(Number As Int)
	If Viewess.Active.IsInitialized Then
		If Not(Number = var.ActiveMakan) Then
		Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
		Private l2 As B4XView = Viewess.Texts.Get(Number)
		
		Animations(l1,l2)
		End If
	End If
	var.ActiveMakan = Number
End Sub

Public Sub Show
	Design
End Sub

#Region Clickee
#if B4j
Private Sub a_MouseClicked (EventData As MouseEvent)
#Else
Private Sub a_Click
#End If

	If Not(var.ActiveMakan=0) Then
	
	Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
	Private l2 As B4XView = Viewess.Texts.Get(0)
	
	Animations(l1,l2)
	var.ActiveMakan=0
	
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,0)
		End If
	End If
End Sub
#if B4j
Private Sub b_MouseClicked (EventData As MouseEvent)
#Else
Private Sub b_Click
#End If
	If Not(var.ActiveMakan=1) Then
	Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
	Private l2 As B4XView = Viewess.Texts.Get(1)
	
	Animations(l1,l2)
	var.ActiveMakan=1
	
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,1)
		End If
	End If
End Sub
#if B4j
Private Sub c_MouseClicked (EventData As MouseEvent)
#Else
Private Sub c_Click
#End If
	If Not(var.ActiveMakan=2) Then
	Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
	Private l2 As B4XView = Viewess.Texts.Get(2)
	
	Animations(l1,l2)
	var.ActiveMakan=2
	
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,2)
		End If
	End If
End Sub
#if B4j
Private Sub d_MouseClicked (EventData As MouseEvent)
#Else
Private Sub d_Click
#End If
	If Not(var.ActiveMakan=3) Then
	Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
	Private l2 As B4XView = Viewess.Texts.Get(3)
	
	Animations(l1,l2)
	var.ActiveMakan=3
	
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,3)
		End If
	End If
End Sub
#if B4j
Private Sub e_MouseClicked (EventData As MouseEvent)
#Else
Private Sub e_Click
#End If
	If Not(var.ActiveMakan=4) Then
	Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
	Private l2 As B4XView = Viewess.Texts.Get(4)
	
	Animations(l1,l2)
	var.ActiveMakan=4
	
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,4)
		End If
	End If
End Sub
#if B4j
Private Sub f_MouseClicked (EventData As MouseEvent)
#Else
Private Sub f_Click
#End If
	If Not(var.ActiveMakan=5) Then
	Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
	Private l2 As B4XView = Viewess.Texts.Get(5)
	
	Animations(l1,l2)
	var.ActiveMakan=5
	
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,5)
		End If
	End If
End Sub
#if B4j
Private Sub g_MouseClicked (EventData As MouseEvent)
#Else
Private Sub g_Click
#End If
	If Not(var.ActiveMakan=6) Then
	Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
	Private l2 As B4XView = Viewess.Texts.Get(6)
	
	Animations(l1,l2)
	var.ActiveMakan=6
	
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,6)
		End If
	End If
End Sub
#if B4j
Private Sub h_MouseClicked (EventData As MouseEvent)
#Else
Private Sub h_Click
#End If
	If Not(var.ActiveMakan=7) Then
	Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
	Private l2 As B4XView = Viewess.Texts.Get(7)
	
	Animations(l1,l2)
	var.ActiveMakan=7
	
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,7)
		End If
	End If
End Sub
#if B4j
Private Sub u_MouseClicked (EventData As MouseEvent)
#Else
Private Sub u_Click
#End If
	If Not(var.ActiveMakan=8) Then
	Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
	Private l2 As B4XView = Viewess.Texts.Get(8)
	
	Animations(l1,l2)
	var.ActiveMakan=8
	
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,8)
		End If
	End If
End Sub
#if B4j
Private Sub j_MouseClicked (EventData As MouseEvent)
#Else
Private Sub j_Click
#End If
	If Not(var.ActiveMakan=9) Then
		Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
		Private l2 As B4XView = Viewess.Texts.Get(9)
	
		Animations(l1,l2)
		var.ActiveMakan=9
		
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,9)
		End If
	End If
End Sub
#if B4j
Private Sub k_MouseClicked (EventData As MouseEvent)
#Else
Private Sub k_Click
#End If
	If Not(var.ActiveMakan=10) Then
		Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
		Private l2 As B4XView = Viewess.Texts.Get(10)
	
		Animations(l1,l2)
		var.ActiveMakan=10
		
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,10)
		End If
	End If
End Sub
#if B4j
Private Sub l_MouseClicked (EventData As MouseEvent)
#Else
Private Sub l_Click
#End If
	If Not(var.ActiveMakan=11) Then
		Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
		Private l2 As B4XView = Viewess.Texts.Get(11)
	
		Animations(l1,l2)
		var.ActiveMakan=11
		
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,11)
		End If
	End If
End Sub
#if B4j
Private Sub m_MouseClicked (EventData As MouseEvent)
#Else
Private Sub m_Click
#End If
	If Not(var.ActiveMakan=12) Then
		Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
		Private l2 As B4XView = Viewess.Texts.Get(12)
	
		Animations(l1,l2)
		var.ActiveMakan=12
		
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,12)
		End If
	End If
End Sub
#if B4j
Private Sub p_MouseClicked (EventData As MouseEvent)
#Else
Private Sub p_Click
#End If
	If Not(var.ActiveMakan=13) Then
		Private l1 As B4XView = Viewess.Texts.Get(var.ActiveMakan)
		Private l2 As B4XView = Viewess.Texts.Get(13)
	
		Animations(l1,l2)
		var.ActiveMakan=13
		
		If xui.SubExists(mCallBack,mEventName&"_itemYouClicked",2) Then
			CallSub3(mCallBack,mEventName&"_itemYouClicked",l2.Text,13)
		End If
	End If
End Sub
#End Region

Private Sub Animations(From As B4XView,tooe As B4XView)
	
	From.TextColor = var.TextColor
	tooe.TextColor = xui.Color_White
	
	
	If From.Left > tooe.Left Then
		Viewess.Active.SetLayoutAnimated(var.AnimationDuration,tooe.Left-4dip,Viewess.Active.Top,Viewess.Active.Width,Viewess.Active.Height)
		Sleep(var.AnimationDuration+30)
		Viewess.Active.SetLayoutAnimated(var.AnimationDuration+120,tooe.Left,Viewess.Active.Top,Viewess.Active.Width,Viewess.Active.Height)
		
	Else
		Viewess.Active.SetLayoutAnimated(var.AnimationDuration,tooe.Left+4dip,Viewess.Active.Top,Viewess.Active.Width,Viewess.Active.Height)
		Sleep(var.AnimationDuration+30)
		Viewess.Active.SetLayoutAnimated(var.AnimationDuration+120,tooe.Left,Viewess.Active.Top,Viewess.Active.Width,Viewess.Active.Height)
	End If

	
End Sub

#Region SETTER

Public Sub ActiveColor(Color As Int)
	var.ActiveColor = Color
	Viewess.Active.Color = var.ActiveColor
End Sub

Public Sub TextColor(Color As Int)
	var.TextColor = Color
	For i=0 To Viewess.Texts.Size-1
		If Not(i=var.ActiveMakan) Then
			Private l As B4XView = Viewess.Texts.Get(i)
			l.TextColor = var.TextColor
		End If
	Next
End Sub

Public Sub TextSize(sizee As Int)
	var.TextSize = sizee
	For i=0 To Viewess.Texts.Size-1
		Private l As B4XView = Viewess.Texts.Get(i)
		l.TextSize = var.TextSize
	Next
End Sub

Public Sub Fonts(setfont As B4XFont)
	var.Fonte = setfont
	For i=0 To Viewess.Texts.Size-1
		Private l As B4XView = Viewess.Texts.Get(i)
		l.Font = var.Fonte
	Next
End Sub

Public Sub AnimationTime(MilliSecond As Int)
	var.AnimationDuration = MilliSecond
End Sub

#End Region

#Region GETTER
Public Sub GetSize As Int
	Return Viewess.Texts.Size
End Sub

Public Sub GetTexts As List
	Return var.LstText
End Sub
#End Region