B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'###############
'## InfoBar
'## Version: 	2.0
'## Language:	B4J
'## Licence:	Royalty Free for private and commercial use
'## (C) Günter Becker, licensed B4X Developer

#region custom event
#Event: Clicked
#end region

#region View
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private fx As JFX
	Public Pane As Pane
	
	Private cvs As B4XCanvas
	Private rect As B4XRect
	Public Label As B4XView
	Public flashTimer As Timer
	Public Barcolor As Int
	Public BeepNo As Int = 0
	Public Parent As Object
	Public ParentViewNO As Int
	Public mParentMe As Object
	'# Layout LOI
	Private B4XGifView1 As B4XGifView
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	flashTimer.Initialize("flash",500)
	#if B4A
		beep.initialize(300,300)
	#End If
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	mBase.LoadLayout("GBEInfoBar_B4J")
End Sub
'## Function:	Resize progressbar
'## Tested:		2025/07
Private Sub Base_Resize (Width As Double, Height As Double)
	rect.Height = Pane.Height
End Sub
#end region

#region custom properties
'## Function:	create/show/update progressbar
'## Parameter:	Progress in Percent, color Barcolor, Text labeltext
'## Tested:		2025/09
public Sub ProgBar(Progress As Int, color As Int, Text As String)
	Barcolor=color
	cvs.Initialize(Pane)
	cvs.ClearRect(cvs.TargetRect)
	rect.Height = Pane.Height
	Dim fact As Double = (Pane.Width) / 100
	rect.Width = fact * Progress
	cvs.DrawRect(rect,Barcolor,True,2)
	cvs.Invalidate
	If Text.Contains("%") Then
		Text = Text.Replace("%","")
		Label.Text = Text & " " & fact & "%" 
	Else
		Label.Text = Text
	End If
End Sub
'## Function:	activate/stop beep sound
'## Parameter:	Activate True=stop=false
'## Tested:		2025/09
public Sub setBeep(Number As Int)
	BeepNo = Number
End Sub
'## Function:	show label text
'## Parameter:	Text
'## Tested:		2025/09
public Sub setText(Text As String)
	Label.Text=Text
End Sub
'## Function:	activate/stop flashing label text
'## Parameter:	Activate True=stop=false
'## Tested:		2025/09
public Sub setFlash(Activate As Boolean)
	flashTimer.Enabled = Activate
	If flashTimer.Enabled=False Then Label.Visible=True
End Sub
'## Function:	show/hide loading indicator
'## Parameter:	Activate True=show hide=false
'## Tested:		2025/09
public Sub LOI(Activate As Boolean)
	Dim p As Pane = mBase.Parent
	If Activate Then
		ParentViewNO = p.NumberOfNodes
		Dim p1 As Pane:p1.initialize("")
		p1.SetLayoutAnimated(0,0,0,100dip,100dip)
		p1.LoadLayout("LOI")
		B4XGifView1.SetGif(File.DirAssets,"spinner2.gif")
		p.AddNode(p1,p.Width/2-50dip,p.Height/2-50dip,p1.Width,p1.height)
	Else
		If ParentViewNO > 0 Then
			p.RemoveNodeAt(ParentViewNO)
			ParentViewNO=-1
		End If
	End If
End Sub
#end region

#region event
'## Function:	Event Clicked
'## Tested:		2025/07
Private Sub Label_MouseClicked (EventData As MouseEvent)
	If BeepNo >0 Then doBeep
	If SubExists(mCallBack, mEventName & "_Clicked") Then
		CallSub(mCallBack, mEventName & "_Clicked")
	End If
End Sub
#end region

#region timer
'## Function:	Flastimer
'## Tested:		2025/07
private Sub flash_tick
	Label.Visible = Not(Label.visible)
	If BeepNo >0 Then doBeep
End Sub
#end region
#region helpers
'## Function:	Play Beep Sound
'## Parameter:	1 beep, 2 smooth beep, 3 alarm
'##(C)			Royalty free from pixabay.com
'## Tested:		2025/07
public Sub doBeep
	Dim whistle As AudioClip
	whistle.initialize
	Select BeepNo
		Case 1
			whistle.Create2(File.DirAssets,"infobleep-87963.mp3")
			whistle.Play2(.35)
		Case 2
			whistle.Create2(File.DirAssets,"point-smooth-beep-230573.mp3")
			whistle.Play2(.35)
		Case 3
			whistle.Create2(File.DirAssets,"point-smooth-beep-230573.mp3")
			'whistle.Create2(File.DirAssets,"infobleep-87963.mp3")
			For x = 0 To 5
			whistle.Play2(.5)
			Sleep(150)
			Next
	End Select
	If BeepNo > 0 Then whistle.Play2(.35)
End Sub

#end region