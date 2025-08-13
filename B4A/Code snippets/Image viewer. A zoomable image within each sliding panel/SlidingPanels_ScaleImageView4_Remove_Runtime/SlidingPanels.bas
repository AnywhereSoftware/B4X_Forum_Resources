Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.52
@EndOfDesignText@
#Region Library Attributes
	#Event: Click
	#Event: LongClick
	#Event: Change
#End Region

'Class Name: SlidingPanels
'Author: Dominex
'Version: 1.20
'B4A Version Used: 2.50
'Last Modified: 10/02/2013
'-------------------------
'Class module
Private Sub Class_Globals
	Private UseFriction,FRICTION_DEC = 0.96,FRICTION_INC = 1.02,FRICTION_ACCELERATE = 1.5 As Float
	Private ACTION_DOWN = 0,ACTION_UP = 1,ACTION_MOVE = 2 As Int
'	Private DisXtest = 160*Density/5,VelTest = 200 As Int
'	Private MargineTouch As Int = 10dip
	
	'my modification
	Private MargineTouch As Int = 4dip
	'-------------------------------------------------
	Private Timer1 As Timer
'	Private TimerLC As Timer
	Private Display As Panel
	Private X0,X1,CurrentPanel,Velocity,vDistance,Touched As Int
	Private vWidth, vYpos As Int
'	Private vWidth,vYpos,vZoom,vZoomArea,OrigH,OrigW As Int
	Private NoLoop,FirstTime,vFriction,SlidingInProgress,vActivityTouch,LongClick As Boolean
	Private RapidSliding As Long
	Private vEventName,EventTouch As String
	Type JumpData (Panel As Int,Delay As Int,Speed As Int)
	Private Jump As JumpData
	Type MovesPanel (PanelNumber As Int,Start As Float,Destination As Int,Increase As Float)
	Private Move As MovesPanel
	Private vModule As Object
	Type TouchData (X As Int,Y As Int,Tag As Object)
	Private vTouchData As TouchData
	'-------------------------------------------------
	Public Panels() As Panel
	
	Dim ScaleImageView2() As ScaleImageView		'my modification
	Dim lstScales2 As List
End Sub

Private Sub Timer_Tick
	If Not(SlidingInProgress) Then
		Timer1.Enabled = False
		Return
	End If
	Dim c = Move.PanelNumber,GCP = GetCenterPosition(c) As Int
	If Abs(GCP-Move.Destination) < Abs(Move.Increase) Or GCP = Move.Destination Then
		SetLeftPosition(c,Move.Destination)
		CurrentPanel = Move.PanelNumber
		SlidingInProgress = False
	Else If Abs(Move.Increase) < 0.5 Then
		SlidingInProgress = False
	Else
		If UseFriction = FRICTION_DEC Then
			Move.Increase = Move.Increase*FRICTION_DEC
		Else If UseFriction = FRICTION_INC Then
			Move.Increase = Min(Move.Increase*FRICTION_INC,20)
		End If
		Move.Start = Move.Start + Move.Increase
		SetLeftPosition(c,Move.Start)
	End If
	Concatenates(c)
	If SlidingInProgress = False Then
		If UseFriction = FRICTION_INC Then
			UseFriction = 0
			If SubExists(vModule,vEventName&"_Change") Then CallSub2(vModule,vEventName&"_Change",CurrentPanel)
		Else If UseFriction = FRICTION_DEC Then
			FrictionPanelBack
		Else If Jump.Panel = -1 And FirstTime = False Then
			If SubExists(vModule,vEventName&"_Change") Then CallSub2(vModule,vEventName&"_Change",CurrentPanel)
		Else
			FirstTime = False
		End If
		If Jump.Panel > -1 Then JumpToPanel(Jump.Panel,Jump.Speed,Jump.Delay)
	End If
End Sub

Private Sub FrictionPanelBack
	UseFriction = FRICTION_INC
	PanelToCentre(CalcCurrentPanel,Velocity*5) '*10)
End Sub

Private Sub CalcCurrentPanel As Int
	Dim c,Tmp,TmpDisX,TmpPanel As Int
	TmpDisX = Abs(vWidth/2-GetCenterPosition(0))
	If Panels.Length > 1 Then
		For c = 1 To Panels.Length-1
			Tmp = Abs(vWidth/2-GetCenterPosition(c))
			If Tmp < TmpDisX Then
				TmpDisX = Tmp
				TmpPanel = c
			End If
		Next
	End If
	CurrentPanel = TmpPanel
	Return CurrentPanel
End Sub

Private Sub Concatenates (PanelNumber As Int)
	Dim c,dist As Int
	For c = 0 To Panels.Length-1
		If c <> PanelNumber Then
			dist = CalcCenterPosition(c,PanelNumber)
			If dist-Panels(c).Width/2 < Display.Width Or dist+Panels(c).Width/2 > 0 Then
				SetLeftPosition(c,dist)
			End If
		End If
	Next
'	If vZoom > 0 Then CalculatesZoom
	If NoLoop Then
		If CalcCenterPosition(0,PanelNumber) > Display.Width+vWidth Or _
			CalcCenterPosition(Panels.Length-1,PanelNumber) < -vWidth Then FrictionPanelBack
	Else If FirstTime = False Then
		If PanelNumber = 0 And Panels(PanelNumber).Left > 0 Then
			Panels(Panels.Length-1).Left = Panels(PanelNumber).Left-Panels(PanelNumber).Width
		Else If PanelNumber = Panels.Length-1 And Panels(PanelNumber).Left < 0 Then
			Panels(0).Left = Panels(PanelNumber).Left+Panels(PanelNumber).Width
		End If
	End If
	Display.Invalidate
End Sub

'Private Sub CalculatesZoom
'	Dim c,tmpZoom,topZoom,DisP As Int
'	For c = 0 To Panels.Length-1
'		DisP = Min(Abs(Panels(c).Left+Panels(c).Width/2-Display.Width/2),vZoomArea/2)
'		DisP = (vZoom-100)/(vZoomArea/2)*DisP
'		tmpZoom = vZoom-DisP
'		If tmpZoom > topZoom Then
'			topZoom = tmpZoom
'			Panels(c).BringToFront
'		End If
'		ZoomPanel(Panels(c),tmpZoom)
'	Next
'End Sub

Private Sub PanelToCentre (PanelNumber As Int,Speed As Int)
	Move.PanelNumber = PanelNumber
	Move.Start = CalcCenterPosition(PanelNumber,CurrentPanel)
	Move.Destination = Display.Width/2
	Speed = Speed/Display.Width*Abs(Move.Destination-Move.Start)
	If UseFriction  = FRICTION_DEC Then
		Move.Increase = 1
	Else
		Move.Increase = (Move.Destination-Move.Start)/(Speed/Timer1.Interval)
	End If
	SlidingInProgress = True
	Timer1.Enabled = True
End Sub

Private Sub CalcCenterPosition (PanelNumber As Int,Reference As Int) As Int
	Return (PanelNumber-Reference)*(vWidth+vDistance)+Panels(Reference).left+Panels(Reference).Width/2
End Sub

Private Sub GetCenterPosition (PanelNumber As Int) As Int
	PanelNumber = Min(Max(0,PanelNumber),Panels.Length-1)
	Return Panels(PanelNumber).Width/2+Panels(PanelNumber).Left
End Sub

Private Sub SetLeftPosition (PanelNumber As Int,CenterPosition As Int)
	Panels(PanelNumber).Left = CenterPosition-(Panels(PanelNumber).Width/2)
End Sub

Private Sub ClickedPanel (X As Int,Y As Int) As Int
	Dim c,dimension,idx = -1 As Int
	For c = 0 To Panels.Length-1
		If X >= Panels(c).Left And Y >= Panels(c).Top And X <= Panels(c).Left+Panels(c).Width And _
			Y <= Panels(c).Top+Panels(c).Height Then
			If Panels(c).Width > dimension Then
				dimension = Panels(c).Width
				idx = c
			End If
		End If
	Next
	Return idx
End Sub

'Private Sub TimerLC_Tick
''	Dim margine = 5dip As Int
'	TimerLC.Enabled = False
'	If SubExists(vModule,vEventName&"_LongClick") Then
'		vTouchData.Tag = Panels(Touched).Tag
'		CallSub2(vModule,vEventName&"_LongClick",vTouchData)
'		LongClick = True
'	End If
'End Sub

Public Sub Panels_Touch (Action As Int,X As Float,Y As Float)
	If SlidingInProgress Then
		SlidingInProgress = False
		Timer1.Enabled = False
		Jump.Panel = -1
	End If
	Select Action
		
		Case ACTION_DOWN
			
			'my modification
			ScaleImageView2(CurrentPanel) = Panels(CurrentPanel).GetView(0)
			Log("ScaleImageView2(CurrentPanel).Scale on Panels_Touch = " & ScaleImageView2(CurrentPanel).Scale)
			
			If vActivityTouch Then
				Touched = ClickedPanel(X,Y)
				If Touched = -1 Then
					Return
				End If
				X = X - Panels(Touched).Left
			Else
				Dim Send  = Sender As Panel
				Touched = Send.Tag
			End If
			RapidSliding = DateTime.Now
			X0 = X
			X1 = GetCenterPosition(Touched)
			'---Stores the position for LongClick---
			vTouchData.X = X
			vTouchData.Y = Y
			LongClick = False
'			TimerLC.Enabled = True
			
		Case ACTION_MOVE
			
			'my modification
			Log("ScaleImageView2(CurrentPanel).Scale = " & ScaleImageView2(CurrentPanel).Scale & ", lstScales2.Get(CurrentPanel) = " & lstScales2.Get(CurrentPanel))

			If ScaleImageView2(CurrentPanel).Scale - lstScales2.Get(CurrentPanel) <> 0 Then
				Log("zoomed in")
				Return
			End If
						
			
			If Touched = -1 Then Return
			If vActivityTouch Then X = X - Panels(Touched).Left
'			If Abs(vTouchData.X-X) > MargineTouch Or Abs(vTouchData.Y-Y) > MargineTouch Then TimerLC.Enabled = False
			SetLeftPosition(Touched,X-X0+GetCenterPosition(Touched))
			Concatenates(Touched)
			If DateTime.Now-RapidSliding > 1000 Then
				RapidSliding = DateTime.Now
			End If
			
		Case ACTION_UP
			
'			TimerLC.Enabled = False
			If Touched = -1 Then Touched = CurrentPanel
			Dim DisX = GetCenterPosition(Touched)-X1 As Int
			'---Click Event---
			If Abs(DisX) < MargineTouch  Then
				If SubExists(vModule,vEventName&"_Click") And LongClick = False Then
					If vActivityTouch Then
						X = X - Panels(Touched).Left
						Y = Y - Panels(Touched).Top
					End If
					vTouchData.X = X
					vTouchData.Y = Y
					vTouchData.Tag = Panels(Touched).Tag
					FrictionPanelBack
					CallSub2(vModule,vEventName&"_Click",vTouchData)
				End If
				Return
			End If
			'---SlidingPanels with Friction---
			Dim Vel = DateTime.Now-RapidSliding As  Long
			If vFriction Then
				Move.PanelNumber = Touched
				Move.Start = CalcCenterPosition(Touched,CurrentPanel)
				If DisX > 0 Then '---------Right direction
					Move.Destination = Touched*(vWidth+vDistance)+Display.Width+vWidth
				Else If DisX < 0 Then '-----Left direction
					Move.Destination = (Panels.Length-1-Touched)*(vWidth+vDistance)-vWidth
				End If
				Move.Increase = DisX/(Vel/Timer1.Interval)*FRICTION_ACCELERATE
				UseFriction = FRICTION_DEC
				SlidingInProgress = True
				Timer1.Enabled = True
				Return
			End If
			'---SlidingPanels without Friction---
			Dim NextPanel,ReturnBack As Int
			If DisX > 0 Then '---------Right direction
				NextPanel = CurrentPanel - 1
				ReturnBack = 0
			Else If DisX < 0 Then '-----Left direction
				NextPanel = CurrentPanel + 1
				ReturnBack = Panels.Length-1
			End If
			If NoLoop And Touched = ReturnBack Then
				PanelToCentre(Touched,Velocity)
				Return
			Else
				
				'The lines commented here and the size of the MargineTouch control that the panel is returned to the central position if the conditions are not met
				'This is how it goes more fluidly and without return of the panels
				Dim TestVelocity As Boolean
				DisX = Abs(DisX)
				
			'my modifications
'			If DisX > DisXtest And Vel < VelTest Then TestVelocity = True Else TestVelocity = False
				TestVelocity = True
'			If Max(GetCenterPosition(Touched),X1)-Min(GetCenterPosition(Touched),X1) > vWidth/2 Or TestVelocity Then
				If NextPanel < 0 Then
					NextPanel = Panels.Length-1
					CurrentPanel = NextPanel
				Else If NextPanel > Panels.Length-1 Then
					NextPanel = 0
					CurrentPanel = NextPanel
				End If
				If TestVelocity Then
					Vel = Max(Vel/DisX*Abs(Display.Width/2-Abs(GetCenterPosition(Touched))),Velocity)
					PanelToCentre(NextPanel,Vel)
'				Else
'					PanelToCentre(NextPanel,Velocity) '---Forward
				End If
'			Else
'				PanelToCentre(Touched,Velocity) '----------Back
'			End If
			End If
	End Select
End Sub

'Start the SlidingPanels showing Panels indicated.
'The Class must first be initialized, and choosing a mode of SlidingPanels.
'PanelNumber - number of panels to start.
Public Sub Start (PanelNumber As Int)
	If FirstTime = False Then Return
	PanelNumber = Max(Min(PanelNumber,Panels.Length-1),0)
	Wait(200)
	PanelToCentre(PanelNumber,Velocity)
	JumpToPanel(PanelNumber,Velocity,0)
End Sub

'Runs the SlidingPanels up to a specific Panel.
'Return False if it is already in the Panel indicated.
'PanelNumber - number of panels to jump to.
'Speed - is the sliding speed in milliseconds.
'Delay - delay before the next jump.
Public Sub JumpToPanel (PanelNumber As Int,Speed As Int,Delay As Int) As Boolean
	PanelNumber = Max(Min(PanelNumber,Panels.Length-1),0)
	Jump.Panel = PanelNumber
	If PanelNumber = CurrentPanel Then
		Jump.Panel = -1
		Return False
	End If
	If SlidingInProgress Then SlidingInProgress = False
	Jump.Delay = Delay
	Jump.Speed = Speed
	Wait(Delay)
	Dim NextPanel As Int
	If PanelNumber < CurrentPanel Then '---Right direction
		NextPanel = CurrentPanel - 1
	Else '----------------------------------Left direction
		NextPanel = CurrentPanel + 1
	End If
	PanelToCentre(NextPanel,Jump.Speed)
	Return True
End Sub

'Returns the number of the current Panel.
Public Sub GetCurrentPanel As Int
	Return CurrentPanel
End Sub

'Return if the SlidingPaneles is in progress.
Public Sub GetSlidingInProgress As Boolean
	Return SlidingInProgress
End Sub

'Sets the speed of sliding.
'Speed - speed in milliseconds.
Public Sub SetSpeedScroll (Speed As Int)
	Velocity = Speed
End Sub

'Private Sub ZoomPanel (obj As Panel,NewZoom As Int)
'	Dim sWidth,sHeight As Int
'	sWidth = OrigW/100*NewZoom
'	sHeight = OrigH/OrigW*sWidth
'	Dim Left,Top As Int
'	Left = obj.Left+obj.Width/2-sWidth/2
'	Top = vYpos-sHeight/2
'	obj.SetLayout(Left,Top,sWidth,sHeight)
'End Sub

Private Sub Wait(Milliseconds As Int)
	Dim Time As Long
	Time = DateTime.Now + (Milliseconds)
	Do While DateTime.Now < Time
		DoEvents
'		Doesn't work well with Sleep(0)
	Loop
End Sub

'Initialize the SlidingPanels.
'EventName - name of the event Click and Change.
'Speed - is the sliding speed in milliseconds.
'Horizontal - if it is True means horizontal scrolling, vertical otherwise.
'Parent - where is the Activity create the SlidingPanels.
'Module - must be "Me"
'ActivityTouch - if True use the event Touch the Activity rather than the individual Panels. [Recommended]
'
'If ActivityTouch if True, adds this code in Main Activity:<code>
'Sub Activity_Touch (Action As Int, X As Float, Y As Float)
'	SD.Panels_Touch(Action,X,Y)
'End Sub</code>
Public Sub Initialize (EventName As String,Speed As Int,Parent As Panel,Module As Object,ActivityTouch As Boolean,Lst As List)
	vEventName = EventName
	Velocity = Speed
	Display = Parent
	vModule = Module
	FirstTime = True
	NoLoop = True
	vActivityTouch = ActivityTouch
	If vActivityTouch = False Then EventTouch = "Panels"
	Jump.Panel = -1
	Timer1.Initialize("Timer",15)
'	TimerLC.Initialize("TimerLC",500)

	'New
	lstScales2 = Lst
End Sub

'Creates the SlidingPanels with Panels full screen.
'The Class must first be initialized.
'NumberOfPanels - is the number of panels to be created, Min 2.
'SlidingInLoop - indicates whether the SlidingPanels is in Loop (True = Loop).
Public Sub ModeFullScreen (NumberOfPanels As Int,SlidingInLoop As Boolean)
	Dim c As Int
	
	'my modification
	Dim Panels(Max(NumberOfPanels,1)) As Panel				'<-- Changed from 2 to 1, so a single panel can remain
	Dim ScaleImageView2(Max(NumberOfPanels,1)) As ScaleImageView	'<-- New
	
	vYpos = Display.Height/2
	vWidth = Display.Width
	For c = 0 To Panels.Length-1
		Panels(c).Initialize(EventTouch)
		Panels(c).Tag = c
'		Display.AddView(Panels(c),vWidth,0,vWidth,Display.Height)
		
		'my modification
		Display.AddView(Panels(c),vWidth,0,vWidth,Display.Height - 60dip)	'<-- If you want to set the space for the Horizontal ScrollView
	Next
	NoLoop = Not(SlidingInLoop)
	vDistance = 0
	vFriction = False
End Sub

'Creates the SlidingPanels with smaller Panels of the screen.
'The Class must first be initialized.
'NumberOfPanels - Is the number of Panels To be created, Min 2.
'Width - width of the Panels.
'Height - height of the Panels.
'Ypost - vertical central position of the Panels.
'Distance - Is the distance separating the Panels.
'Friction - enable/disable the friction.
'Public Sub ModeLittlePanels (NumberOfPanels As Int,Width As Int,Height As Int,Ypos As Int,Distance As Int,Friction As Boolean)
'	Dim c As Int
'	Dim Panels(Max(NumberOfPanels,2)) As Panel
'	vWidth = Min(Width,Display.Width)
'	vYpos = Ypos
'	Height = Min(Height,Display.Height)
'	For c = 0 To Panels.Length-1
'		Panels(c).Initialize(EventTouch)
'		Panels(c).Tag = c
'		Display.AddView(Panels(c),Display.Width,vYpos-(Height/2),vWidth,Height)
'	Next
'	vDistance = Distance
'	vFriction = Friction
'End Sub

'Creates the SlidingPanels with smaller Panels of the screen with zoom.
'The Class must first be initialized.
'NumberOfPanels - Is the number of Panels To be created, Min 2.
'Width - Width of the Panels.
'Height - Height of the Panels.
'Ypost - vertical central position of the Panels.
'Distance - Is the Distance separating the Panels.
'Friction - enable/disable the Friction.
'Zoom - set the zoom (150 = 150%).
'ZoomArea - area in which it calculates the zoom.
'Public Sub ModeLittlePanelsZoom (NumberOfPanels As Int,Width As Int,Height As Int,Ypos As Int,Distance As Int,Friction As Boolean,Zoom As Int,ZoomArea As Int)
'	ModeLittlePanels(NumberOfPanels,Width,Height,Ypos,Distance,Friction)
'	OrigW = vWidth
'	OrigH = Height
'	vZoom = Zoom
'	vZoomArea = ZoomArea
'End Sub

'Public Sub RemovePanel (index As Int)
'	
'	Panels(index).RemoveView
'End Sub
