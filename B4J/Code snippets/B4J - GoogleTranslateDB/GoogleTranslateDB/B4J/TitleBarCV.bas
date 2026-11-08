B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'TitleBar Custom View class
Sub Class_Globals
	Private fx As JFX
	Private mEventName As String 'ignore
	Private mCallBack As Object  'ignore
	Private mBase As Pane
	Private mTargetForm As Form
	Private FormWithFixedSize As Boolean = False

	Private CloseIcon As Label
	Private MaximizeIcon As Label
	Private MinimizeIcon As Label
	
	Type MaxResizeWindowType(MaxWindowWidth As Double, MaxWindowHeight As Double)
	Public  SetResizeWindow As MaxResizeWindowType

	Type ResizeWindowType(ResizeDirection As String, LastScreenX As Double, LastScreenY As Double, Resized As Boolean, ReleaseTimer As Timer)
	Private ResizeWindow As ResizeWindowType
	Type DragWindowType(LastScreenX As Double,LastScreenY As Double)
	Private DragWindow As DragWindowType

	Private TitleBarHeight As Double

	Private TitleBarBG As Pane
	Private ControlBtnPane As Pane
	Private TitleLabel As Label
	Private IconSelectedColor As Paint
	Private IconHoveredColor As Paint
	Private IconNormalColor As Paint
	Private IconExitSelectedColor As Paint
	Private IconExitHoveredColor As Paint
	Private FormIcon As ImageView
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	ResizeWindow.Initialize
	ResizeWindow.ReleaseTimer.Initialize("ReleaseTimer",500)
	DragWindow.Initialize
	SetResizeWindow.Initialize
	IconSelectedColor = fx.Colors.ARGB(75,0,0,0)
	IconHoveredColor = fx.Colors.ARGB(25,255,255,255)
	IconNormalColor = fx.Colors.Transparent
	IconExitHoveredColor = fx.Colors.Red
	IconExitSelectedColor = fx.Colors.ARGB(120,255,0,0)
End Sub

Public Sub DesignerCreateView (Base As Pane, Lbl As Label, Props As Map)
	mBase = Base
	mBase.LoadLayout("TitleBar")
	TitleBarHeight = TitleBarBG.PrefHeight
	
	mTargetForm = Props.Get("Form")
	mTargetForm.SetFormStyle("TRANSPARENT")
	mTargetForm.BackColor = fx.Colors.Transparent
	mTargetForm.RootPane.MouseCursor = fx.Cursors.DEFAULT
	
	SetEventHandlers
End Sub

Public Sub SetIcon(Img As Image)
	FormIcon.SetImage(Img)
	FormUtils.GetIcons(mTargetForm).Add(Img)
End Sub

Private Sub FormIcon_MouseClicked (EventData As MouseEvent)
	If Not(FormUtils.IsMaximized(mTargetForm)) Then
		Dim pp As PagePosition = Main.kvs.Get(B4XPages.GetPageId(B4XPages.MainPage.B4XPage))
		If  pp = Null Then Return
		
		If pp.Width  < SetResizeWindow.MaxWindowWidth  Then pp.Width  = SetResizeWindow.MaxWindowWidth
		If pp.Height < SetResizeWindow.MaxWindowHeight Then pp.Height = SetResizeWindow.MaxWindowHeight
		B4XPages.MainPage.SetFormFromMap(pp, mTargetForm)
	End If
End Sub

Public Sub SetTitle(Title As String)
	TitleLabel.Text = Title
End Sub

'Form with fixed size if isFixedSize = True.
Public Sub SetResize(isFixedSize As Boolean)
	FormWithFixedSize = isFixedSize
End Sub

Public Sub getTitle As String
	Return TitleLabel.Text
End Sub

Public Sub SetMinimizeIcon(Title As String)
	MinimizeIcon.TooltipText = Title
End Sub

Public Sub SetMaximizeIcon(Title As String)
	MaximizeIcon.TooltipText = Title
End Sub

Public Sub SetCloseIcon(Title As String)
	CloseIcon.TooltipText = Title
End Sub

Private Sub SetEventHandlers
	Dim JO As JavaObject = mTargetForm
	Dim Stage As JavaObject = JO.GetField("stage")
	Dim Scene As JavaObject = Stage.RunMethod("getScene",Null)
	
	Dim O As Object = JO.CreateEventFromUI("javafx.event.EventHandler","SceneMouseDragged",Null)
	Scene.RunMethod("setOnMouseDragged",Array(O))
	Dim O As Object = JO.CreateEventFromUI("javafx.event.EventHandler","SceneMouseMoved",Null)
	Scene.RunMethod("setOnMouseMoved",Array(O))
	Dim O As Object = JO.CreateEventFromUI("javafx.event.EventHandler","SceneMouseReleased",Null)
	Scene.RunMethod("setOnMouseReleased",Array(O))
	
	JO = MinimizeIcon
	Dim O As Object = JO.CreateEventFromUI("javafx.event.EventHandler","IconMouseEntered",Null)
	Dim O1 As Object = JO.CreateEventFromUI("javafx.event.EventHandler","IconMouseExited",Null)
	JO.RunMethod("setOnMouseEntered",Array(O))
	JO.RunMethod("setOnMouseExited",Array(O1))

	JO = MaximizeIcon
	Dim O As Object = JO.CreateEventFromUI("javafx.event.EventHandler","IconMouseEntered",Null)
	Dim O1 As Object = JO.CreateEventFromUI("javafx.event.EventHandler","IconMouseExited",Null)
	JO.RunMethod("setOnMouseEntered",Array(O))
	JO.RunMethod("setOnMouseExited",Array(O1))
	
	JO = CloseIcon
	Dim O As Object = JO.CreateEventFromUI("javafx.event.EventHandler","IconMouseEntered",Null)
	Dim O1 As Object = JO.CreateEventFromUI("javafx.event.EventHandler","IconMouseExited",Null)
	JO.RunMethod("setOnMouseEntered",Array(O))
	JO.RunMethod("setOnMouseExited",Array(O1))
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	
End Sub

Public Sub GetBase As Pane
	Return mBase
End Sub

Private Sub SceneMouseReleased_Event (MethodName As String, Args() As Object)
	If ResizeWindow.Resized Then
		ResizeWindow.ReleaseTimer.Enabled = True
	End If
End Sub

Private Sub SceneMouseMoved_Event (MethodName As String, Args() As Object)
	
	Dim Event As MouseEvent = Args(0)
	Dim EventJO As JavaObject = Args(0)
	Dim Offset As Int = 8
	
	Dim Cursors As JavaObject
	Dim Cursor As Object
	
	Cursors.InitializeStatic("javafx.scene.Cursor")
	Cursor = fx.Cursors.DEFAULT
	ResizeWindow.ResizeDirection = ""
	ResizeWindow.LastScreenX = EventJO.RunMethod("getScreenX",Null)
	ResizeWindow.LastScreenY  = EventJO.RunMethod("getScreenY",Null)

	If Event.X < Offset Then
		If Event.Y < Offset Then
			Cursor = Cursors.GetField("NW_RESIZE")
			ResizeWindow.ResizeDirection = "NW"
		Else If Event.Y > mTargetForm.WindowHeight - Offset Then
			Cursor = Cursors.GetField("SW_RESIZE")
			ResizeWindow.ResizeDirection = "SW"
		Else
			Cursor = Cursors.GetField("W_RESIZE")
			ResizeWindow.ResizeDirection = "W"
		End If
	Else If Event.Y < Offset Then
		If Event.X > mTargetForm.WindowWidth - Offset Then
			Cursor = Cursors.GetField("NE_RESIZE")
			ResizeWindow.ResizeDirection = "NE"
		Else
			Cursor = Cursors.GetField("N_RESIZE")
			ResizeWindow.ResizeDirection = "N"
		End If
	Else If Event.X > mTargetForm.WindowWidth - Offset Then
		If Event.Y > mTargetForm.WindowHeight - Offset Then
			Cursor = Cursors.GetField("SE_RESIZE")
			ResizeWindow.ResizeDirection = "SE"
		Else
			Cursor = Cursors.GetField("E_RESIZE")
			ResizeWindow.ResizeDirection = "E"
		End If
	Else If Event.Y > mTargetForm.WindowHeight - Offset Then
		Cursor = Cursors.GetField("S_RESIZE")
		ResizeWindow.ResizeDirection = "S"
	Else
		If mTargetForm.RootPane.MouseCursor = fx.Cursors.DEFAULT Then Return
	End If
	If ResizeWindow.Resized Then
	End If
	mTargetForm.RootPane.MouseCursor = Cursor

End Sub

Private Sub SceneMouseDragged_Event (MethodName As String, Args() As Object)
	If ResizeWindow.ResizeDirection = "" Then Return
	Dim EventJO As JavaObject = Args(0)
	Dim ScreenX As Double = EventJO.RunMethod("getScreenX",Null)
	Dim ScreenY As Double = EventJO.RunMethod("getScreenY",Null)
	
	ResizeWindow.ReleaseTimer.Enabled = False
	If ResizeWindow.ResizeDirection <> "" Then ResizeWindow.Resized = True
	
	Select ResizeWindow.ResizeDirection
		Case "N"
			mTargetForm.WindowTop = ScreenY
			mTargetForm.WindowHeight = Max(TitleBarHeight, mTargetForm.WindowHeight - (ScreenY - ResizeWindow.LastScreenY ))
		Case "S"
			mTargetForm.WindowHeight = Max(TitleBarHeight, mTargetForm.WindowHeight + (ScreenY - ResizeWindow.LastScreenY ))
		Case "E"
			mTargetForm.WindowWidth = Max(1, mTargetForm.WindowWidth + (ScreenX - ResizeWindow.LastScreenX ))
		Case "W"
			mTargetForm.WindowLeft = ScreenX
			mTargetForm.WindowWidth = Max(1, mTargetForm.WindowWidth - (ScreenX - ResizeWindow.LastScreenX ))
		Case "NW"
			'N
			mTargetForm.WindowTop = ScreenY
			mTargetForm.WindowHeight = Max(TitleBarHeight, mTargetForm.WindowHeight - (ScreenY - ResizeWindow.LastScreenY ))
			'W
			mTargetForm.WindowLeft = ScreenX
			mTargetForm.WindowWidth = Max(1, mTargetForm.WindowWidth - (ScreenX - ResizeWindow.LastScreenX ))
		Case "NE"
			'N
			mTargetForm.WindowTop = ScreenY
			mTargetForm.WindowHeight = Max(TitleBarHeight, mTargetForm.WindowHeight - (ScreenY - ResizeWindow.LastScreenY ))
			'E
			mTargetForm.WindowWidth = Max(1, mTargetForm.WindowWidth + (ScreenX - ResizeWindow.LastScreenX ))
		Case "SE"
			'S
			mTargetForm.WindowHeight = Max(TitleBarHeight, mTargetForm.WindowHeight + (ScreenY - ResizeWindow.LastScreenY ))
			'E
			mTargetForm.WindowWidth = Max(1, mTargetForm.WindowWidth + (ScreenX - ResizeWindow.LastScreenX ))
		Case "SW"
			'S
			mTargetForm.WindowHeight = Max(TitleBarHeight, mTargetForm.WindowHeight + (ScreenY - ResizeWindow.LastScreenY ))
			'W
			mTargetForm.WindowLeft = ScreenX
			mTargetForm.WindowWidth = Max(1, mTargetForm.WindowWidth - (ScreenX - ResizeWindow.LastScreenX ))
	End Select
	
	If FormWithFixedSize Then
		If mTargetForm.WindowWidth  <> SetResizeWindow.MaxWindowWidth  Then mTargetForm.WindowWidth  = SetResizeWindow.MaxWindowWidth
		If mTargetForm.WindowHeight <> SetResizeWindow.MaxWindowHeight Then mTargetForm.WindowHeight = SetResizeWindow.MaxWindowHeight
	End If
	ResizeWindow.LastScreenY = ScreenY
	ResizeWindow.LastScreenX = ScreenX
End Sub

Private Sub Resize_Complete
	ResizeWindow.Resized = False
End Sub

Private Sub MinimizeIcon_MousePressed (EventData As MouseEvent)
	CSSUtils.SetBackgroundColor(Sender,IconSelectedColor)
End Sub

Private Sub MinimizeIcon_MouseClicked (EventData As MouseEvent)
	If ResizeWindow.Resized Then
		EventData.Consume
		Return
	End If
	FormUtils.SetIconified(mTargetForm,True)
End Sub

Private Sub MaximizeIcon_MousePressed (EventData As MouseEvent)
	CSSUtils.SetBackgroundColor(Sender,IconSelectedColor)
End Sub

Private Sub MaximizeIcon_MouseClicked (EventData As MouseEvent)
	If ResizeWindow.Resized Then
		EventData.Consume
		Return
	End If
	If FormWithFixedSize Then
		FormUtils.SetMinSize(mTargetForm,mTargetForm.Width,mTargetForm.Height)
	Else
		FormUtils.SetMaximized(mTargetForm,Not(FormUtils.IsMaximized(mTargetForm)))
	End If
End Sub

Private Sub IconMouseEntered_Event (MethodName As String, Args() As Object)
	If Sender  = CloseIcon Then
		CSSUtils.SetBackgroundColor(Sender,IconExitHoveredColor)
	Else
		CSSUtils.SetBackgroundColor(Sender,IconHoveredColor)
	End If
End Sub

Private Sub IconMouseExited_Event (MethodName As String, Args() As Object)
	CSSUtils.SetBackgroundColor(Sender,IconNormalColor)
End Sub

Private Sub CloseIcon_MousePressed (EventData As MouseEvent)
	CSSUtils.SetBackgroundColor(Sender,IconExitSelectedColor)
End Sub

Private Sub CloseIcon_MouseClicked (EventData As MouseEvent)
	Wait For (B4XPages.MainPage.MainPageCloseRequest) Complete (Result As Int) 'Returns Integer with Yes = 1, No = 0, Cancel = -1
	If Result = 1 Then
		If ResizeWindow.Resized Then
			EventData.Consume
			Return
		End If
		If FormUtils.IsMaximized(mTargetForm) Then
			FormUtils.SetMaximized(mTargetForm,Not(FormUtils.IsMaximized(mTargetForm)))
			Sleep(2)
		End If
		SharedCode.ClearSystemClipboard
		mTargetForm.Close
	End If
End Sub

Private Sub TitleLabel_MouseReleased (EventData As MouseEvent)
	If EventData.PrimaryButtonPressed And EventData.ClickCount > 1 Then
		FormUtils.SetMaximized(mTargetForm,Not(FormUtils.IsMaximized(mTargetForm)))
		EventData.Consume
		Return
	End If
End Sub

Private Sub TitleLabel_MousePressed (EventData As MouseEvent)
	Dim EventDataJO As JavaObject = EventData
	DragWindow.LastScreenX = EventDataJO.RunMethod("getSceneX",Null)
	DragWindow.LastScreenY = EventDataJO.RunMethod("getSceneY",Null)
End Sub

Private Sub TitleLabel_MouseDragged (EventData As MouseEvent)
	Dim EventDataJO As JavaObject = EventData
	mTargetForm.WindowLeft = EventDataJO.RunMethod("getScreenX", Null) - DragWindow.LastScreenX
	mTargetForm.WindowTop = EventDataJO.RunMethod("getScreenY", Null) - DragWindow.LastScreenY
End Sub

Private Sub ReleaseTimer_Tick
	ResizeWindow.ReleaseTimer.Enabled = False
	Resize_Complete
End Sub