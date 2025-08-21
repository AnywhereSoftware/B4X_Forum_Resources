B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
Sub Class_Globals
	'populted from initialize
	Dim CallingModule As Object, CallingActivity As Panel, SearchPanel As Panel, ViewOverlayed As View, _
	EventPrefix As String, HaloColor As Int, HaloRadiusSize As Int, _
	ExtendBeyondOverlayedView As Boolean, OverlapSize As Int, _
	UseTouchActionToStart As Boolean, AnimationDuration As Int, DisplayOnActivity As Boolean
	Dim HoldingPanel As Panel ' panel that is the parent to the view
	Dim OverlayPanel As Panel
	Private XUI As XUI
	Dim LastTouched As Long
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallingMod As Object, ParentActivity As Panel, ViewToOverlay As View, _
	Event As String, ClickColor As Int, HaloRadius As Int, ExtendBeyondView As Boolean, OverLapAmount As Int, _
	UseTouchAction As Boolean, ShowOnActivity As Boolean, Duration As Int)
'	LogColor("RippleOverlay Init Event="&Event,Colors.Red)
	CallingModule=CallingMod
	CallingActivity=ParentActivity
'	SearchViewPanel=ViewToOverlay.Parent
	HoldingPanel=ViewToOverlay.Parent
	ViewOverlayed=ViewToOverlay
	EventPrefix=Event
	HaloColor=ClickColor
	HaloRadiusSize=HaloRadius
	ExtendBeyondOverlayedView=ExtendBeyondView
	OverlapSize=OverLapAmount
	UseTouchActionToStart=UseTouchAction
	DisplayOnActivity=ShowOnActivity
	AnimationDuration=Duration
	OverlayPanel.Initialize("OverlayPanel")
	HoldingPanel.AddView(OverlayPanel,ViewToOverlay.Left-OverLapAmount*1dip,ViewToOverlay.Top-OverLapAmount*1dip, _
						ViewToOverlay.Width+OverLapAmount*1dip*2, ViewToOverlay.Height+OverLapAmount*2*1dip)	
'	OverlayPanel.Color=Colors.ARGB(100,255,255,255)
	OverlayPanel.BringToFront
End Sub


Sub CreateHaloEffect (Parent As B4XView, x As Int, y As Int, clr As Int, Radius As Int)
'	LogColor("Creating halo effect clr = "&clr&" radius = "&Radius,Colors.Red)
	Dim cvs As B4XCanvas
	Dim p As B4XView = XUI.CreatePanel("")
'	Dim Radius As Int = 150dip
	p.SetLayoutAnimated(0, 0, 0, Radius * 2, Radius * 2)
	cvs.Initialize(p)
	cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, cvs.TargetRect.Width / 2, clr, True, 0)
	Dim bmp As B4XBitmap = cvs.CreateBitmap
'	For i = 1 To 5
	CreateHaloEffectHelper(Parent,bmp, x, y, clr, Radius)
'		Sleep(800)
'	Next
End Sub

Sub CreateHaloEffectHelper (Parent As B4XView,bmp As B4XBitmap, x As Int, y As Int, clr As Int, radius As Int)
	Dim iv As ImageView
	iv.Initialize("")
	Dim p As B4XView = iv
	p.SetBitmap(bmp)
	Parent.AddView(p, x, y, 0, 0)
	Dim duration As Int = AnimationDuration
	p.SetLayoutAnimated(duration, x - radius, y - radius, 2 * radius, 2 * radius)
	p.SetVisibleAnimated(duration, False)
	Sleep(duration)
	p.RemoveViewFromParent
End Sub


Sub OverlayPanel_Touch (Action As Int, X As Float, Y As Float)
'	LogColor("OverlayPanel_touch action="&Action,Colors.Cyan)
'	Dim LastTouched=StateManager.GetSetting2(EventPrefix&"LastTouched",0) As Long
'	StateManager.SetSetting(EventPrefix&"LastTouched",DateTime.Now)
'	StateManager.SaveSettings
	Dim ShowHalo As Boolean
	If UseTouchActionToStart Then
		If Action=CallingActivity.ACTION_UP Then ShowHalo=True
	Else If DateTime.Now-LastTouched>DateTime.TicksPerSecond*1.5 Then
		ShowHalo=True
		LastTouched=DateTime.Now
	End If
	If ShowHalo Then
		Dim showPanel As Panel
		If DisplayOnActivity Then 
			showPanel=CallingActivity
		Else
			showPanel=OverlayPanel
		End If
		CreateHaloEffect(showPanel, X, Y, HaloColor, HaloRadiusSize)
		Sleep(0)
		CallSubDelayed(CallingModule,EventPrefix & "_Click")
	End If
End Sub

