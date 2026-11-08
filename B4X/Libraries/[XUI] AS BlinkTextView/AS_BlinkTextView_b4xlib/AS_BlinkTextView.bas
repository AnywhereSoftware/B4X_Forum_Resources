B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@

#DesignerProperty: Key: AutoBlink, DisplayName: Auto Blink, FieldType: Boolean, DefaultValue: False, Description: If False then call StartBlink
#DesignerProperty: Key: Duration, DisplayName: Duration, FieldType: Int, DefaultValue: 1000, MinRange: 0, Description: Duration between show and hide
#DesignerProperty: Key: AnimationDuration, DisplayName: Animation Duration, FieldType: Int, DefaultValue: 0, MinRange: 0, Description: smooth fade in and out effect

#Event: Click

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xlbl_Text As B4XView
	
	Private m_AutoBlink As Boolean
	Private m_Duration As Long = 1000
	Private m_AnimationDuration As Long = 0
	
	Private tmr_Blink As Timer
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	tmr_Blink.Initialize("tmr_Blink",m_Duration)
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	IniProps(Props)
	
	xlbl_Text = CreateLabel("xlbl_Text")
	mBase.AddView(xlbl_Text,0,0,mBase.Width,mBase.Height)
	
	xlbl_Text.TextColor = Lbl.As(B4XView).TextColor
	xlbl_Text.Font = Lbl.As(B4XView).Font
	xlbl_Text.SetTextAlignment("CENTER","CENTER")
	xlbl_Text.Text = Lbl.Text
	xlbl_Text.Color = Lbl.As(B4XView).Color
	xlbl_Text.Enabled = Lbl.As(B4XView).Enabled
	
	tmr_Blink.Enabled = m_AutoBlink
	
End Sub

Private Sub IniProps(Props As Map)
	
	m_AutoBlink = Props.GetDefault("AutoBlink",False)
	m_Duration = Props.GetDefault("Duration",1000)
	m_AnimationDuration = Props.GetDefault("AnimationDuration",0)
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	xlbl_Text.SetLayoutAnimated(0,0,0,Width,Height)
End Sub

Private Sub tmr_Blink_Tick
	tmr_Blink.Enabled = False
	mBase.SetVisibleAnimated(m_AnimationDuration,False)
	Sleep(m_Duration)
	mBase.SetVisibleAnimated(m_AnimationDuration,True)
	tmr_Blink.Enabled = True
End Sub

#Region Properties

Public Sub AddToParent(Parent As B4XView,Left As Float,Top As Float,Width As Float,Height As Float)
	
	mBase = xui.CreatePanel("Base")
	Parent.AddView(mBase,Left,Top,Width,Height)
	
	Dim lbl As B4XView = CreateLabel("")
	
	Dim m As Map
	m.Initialize
	
	DesignerCreateView(mBase,lbl,m)
	
	
	
End Sub

Public Sub RemoveView
	mBase.RemoveViewFromParent
End Sub

Public Sub StartBlink
	tmr_Blink.Enabled = True
End Sub

Public Sub StopBlink
	tmr_Blink.Enabled = False
End Sub

Public Sub setDuration(Duration As Long)
	m_Duration = Duration
End Sub

Public Sub getAnimationDuration As Long
	Return m_AnimationDuration
End Sub

Public Sub setAnimationDuration(Duration As Long)
	m_AnimationDuration = Duration
End Sub

Public Sub getLabel As B4XView
	Return xlbl_Text
End Sub

Public Sub setText(Text As String)
	xlbl_Text.Text = Text
End Sub

Public Sub getText As String
	Return xlbl_Text.Text
End Sub

Public Sub setFont(xFont As B4XFont)
	xlbl_Text.Font = xFont
End Sub

Public Sub getFont As B4XFont
	Return xlbl_Text.Font
End Sub

Public Sub setTextColor(Color As Int)
	xlbl_Text.TextColor = Color
End Sub

Public Sub getTextColor As Int
	Return xlbl_Text.TextColor
End Sub

Public Sub setRotation(Rotation As Double)
	mBase.Rotation = Rotation
End Sub

Public Sub getRotation As Double
	Return mBase.Rotation
End Sub

#End Region

#Region Events


#End Region

#Region ViewEvents

#If B4J
Private Sub xlbl_Text_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_Text_Click
#End If
	If xui.SubExists(mCallBack, mEventName & "_Click",0) Then
		CallSub(mCallBack, mEventName & "_Click")
	End If
End Sub

#End Region

#Region Functions

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

#End Region