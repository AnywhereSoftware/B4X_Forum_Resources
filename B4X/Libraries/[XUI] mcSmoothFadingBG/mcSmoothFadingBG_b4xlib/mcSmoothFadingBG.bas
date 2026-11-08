B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
#DesignerProperty: Key: transDuration, DisplayName: Duration, FieldType: Int, DefaultValue: 3000
'#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
'	Public Tag As Object

	
	Private R_initial_color, G_initial_color,B_initial_color As Int
	Private R_second_color, G_second_color, B_second_color As Int
	Private mDuration As Int
	Private mStatus As Boolean = False
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mDuration = Props.Get("transDuration")
		
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	'mBase.SetLayoutAnimated(0,0,0,Width,Height)
End Sub


Private Sub smoothFadingBg
	mStatus = True
	
	'Generate Initial color
	R_initial_color = Rnd(0,256)
	G_initial_color = Rnd(0,256)
	B_initial_color = Rnd(0,256)
	
	
	Do While mStatus = True
		'Generate secondary color
		R_second_color = Rnd(0,256)
		G_second_color = Rnd(0,256)
		B_second_color = Rnd(0,256)
			
		mBase.SetColorAnimated(mDuration,xui.Color_RGB(R_initial_color,G_initial_color,B_initial_color),xui.Color_RGB(R_second_color,G_second_color,B_second_color))
			
		Sleep(mDuration)
				
		R_initial_color = R_second_color
		G_initial_color = G_second_color
		B_initial_color = B_second_color
	Loop
End Sub

'Starting the Smooth Color fading background transition
Public Sub Start
	smoothFadingBg
End Sub

'Stops the Background color transition
Public Sub Stop
	mStatus = False
End Sub

'Set the Transition Duration
Public Sub setDuration(duration As Int)
	mDuration = duration
End Sub

'Get the Duration 
Public Sub getTransitionDuration As Int
	Return mDuration
End Sub

'Check the the background transitioning status
Public Sub getStatus As Boolean
	Return mStatus
End Sub

