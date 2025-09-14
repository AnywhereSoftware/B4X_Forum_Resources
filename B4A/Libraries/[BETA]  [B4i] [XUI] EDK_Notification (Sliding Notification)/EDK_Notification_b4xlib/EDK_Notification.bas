B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
#If documentation
Versions:
V1.00
	-Release
#End If

Private Sub Class_Globals
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private mProps As Map
	
	Private MyPanelb4x As B4XView
	Private MyPanel As Panel
	Private Text_Label As Label
End Sub

Public Sub Initialize (vCallback As Object, vEventName As String)
	mEventName = vEventName
	mCallBack = vCallback
End Sub

Private Sub My_initialize
	MyPanel.Initialize("")
	Text_Label.Initialize("")
	mProps.Initialize
	
	MyPanelb4x=MyPanel
	
End Sub

Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	My_initialize
	mBase=Base
	Tag = mBase.Tag
	mBase.Tag = Me
	mProps = Props
	
	mBase.SetColorAndBorder(0,0,0,0)
	MyPanelb4x.SetColorAndBorder(Colors.RGB(6,125,193),0,0,50) 'ignore


	mBase.AddView(MyPanel, 0,mBase.Height, mBase.Width, mBase.Height+30dip)
	MyPanelb4x.AddView(Text_Label,0,mBase.Height/4.2,mBase.Width,mBase.Height/2)

End Sub

Sub Notification_Start(AnimationTime As Int,Text As String)
	MyPanelb4x.SetLayoutAnimated(AnimationTime,0,0, mBase.Width, mBase.Height+30dip)
	MyPanelb4x.SetColorAndBorder(Colors.RGB(6,125,193),0,0,50) 'ignore
	Text_Label.TextColor=Colors.White
	Text_Label.Text=Text
	 #if b4a
	Text_Label.Gravity=Gravity.CENTER_HORIZONTAL
	#else if b4i
	Text_Label.TextAlignment=Text_Label.ALIGNMENT_CENTER
	#end if
End Sub

Sub Notification_Finish(Time As Int,AnimationTime As Int,Text As String)

 	#if b4a
	Text_Label.Gravity=Gravity.CENTER_HORIZONTAL
	#else if b4i
	Text_Label.TextAlignment=Text_Label.ALIGNMENT_CENTER
	#end if
	Text_Label.TextColor=Colors.White

	MyPanelb4x.SetLayoutAnimated(AnimationTime, 0,mBase.Height, mBase.Width, mBase.Height+30dip)
	Sleep(Time)
	MyPanelb4x.SetColorAndBorder(Colors.RGB(90,179,67),0,0,50) 'ignore
	MyPanelb4x.SetLayoutAnimated(AnimationTime,0,0, mBase.Width, mBase.Height+30dip)
	Text_Label.Text=Text
	Sleep(Time)
	MyPanelb4x.SetLayoutAnimated(AnimationTime, 0,mBase.Height, mBase.Width, mBase.Height+30dip)
End Sub