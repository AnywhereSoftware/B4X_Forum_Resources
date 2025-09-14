B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Custom View class
#Event: CloseRequest (EventData As Event)

#DesignerProperty: Key: DropShadow, DisplayName: DropShadow, FieldType: Boolean, DefaultValue: False, Description: Add Dropshadow to the view. IMPORTANT! Layout Must be constrained with insets of 8px on all sides.
#DesignerProperty: Key: DropshadowColor, DisplayName: Dropshadow Color, FieldType: Color, DefaultValue: #FF6A6A6A, Description: Color for the dropshadow
#DesignerProperty: Key: ShowMinimize, DisplayName: Show Minimize, FieldType: Boolean, DefaultValue: True, Description: Show the minimize button
#DesignerProperty: Key: MinimizeAnimation, DisplayName: Minimize Animation, FieldType: Boolean, DefaultValue: True, Description: Use Animation when minimized
#DesignerProperty: Key: ShowMaximize, DisplayName: Show Maximize, FieldType: Boolean, DefaultValue: True, Description: Show/hide the maximize button
#DesignerProperty: Key: WindowsSnapping, DisplayName: Enable Windows Snapping, FieldType: Boolean, DefaultValue: True, Description: Turns on Windows snapping emulation
#DesignerProperty: Key: WindowsSnappingOffset, DisplayName: Snap Trigger Offset, FieldType: Int, DefaultValue: 20, Description: Offset used to trigger display of the drop indicator
#DesignerProperty: Key: WindowsSnappingBGColor, DisplayName: Snapping background color,FieldType: Color, DefaultValue: #82303030, Description: Snapping background color
#DesignerProperty: Key: WindowsSnappingBdrColor, DisplayName: Snapping border color,FieldType: Color, DefaultValue: #FF303030, Description: Snapping border color
#DesignerProperty: Key: ShowIcon, DisplayName: Show Icon, FieldType: Boolean, DefaultValue: True, Description: Show/hide the Form icon
#DesignerProperty: Key: IconSelectedColor, DisplayName: Icon Selected Color,FieldType: Color, DefaultValue: #32000000, Description: Selected Icon Color
#DesignerProperty: Key: IconHoveredColor, DisplayName: Icon Hovered Color, FieldType: Color, DefaultValue: #19000000, Description: Hovered Icon Color
#DesignerProperty: Key: IconNormalColor, DisplayName: Icon Normal Color, FieldType: Color, DefaultValue: #00000000, Description: Normal Icon Color
#DesignerProperty: Key: IconExitHoveredColor, DisplayName: Icon Close Hovered Color, FieldType: Color, DefaultValue: #FFFF0000, Description: Exit Icon hovered Color
#DesignerProperty: Key: IconExitSelectedColor, DisplayName: Icon Close Selected Color, FieldType: Color, DefaultValue: #78FF0000, Description: Exit icon Selected Color
#DesignerProperty: Key: LayoutName, DisplayName: Layout for Titlebar, FieldType: String, DefaultValue: titlebar, Description: Layout to load with the titlebar
#DesignerProperty: Key: ManagePosition, DisplayName: Manage window position, FieldType: Boolean, DefaultValue: False, Description: Will record window position, size and state on closing and reinstate them on opening.
#DesignerProperty: Key: TitleDelim, DisplayName: Form Title Delimiter, FieldType: String, DefaultValue: -, Description: Used to capture the form name to save it's position (if selected) if the name changes with loaded files etc.
#DesignerProperty: Key: UsingStylesheet, DisplayName: UsingStylesheet, FieldType: Boolean, DefaultValue: False, Description: whether you are using an external stylesheet to style the TitleBar

#if Version
V1.0
	Reworked the drag logic
	Added Emulation of windows snap to screen (Press control to ignore)
	Added more designer properties

V1.1
	Added listener to getChildrenUnmodifiable to automatically call ResetMouseListeners as needed.
	Made important Titlebar views public for styling.
	Removed redundant code
	Added CloseRequst(EventData as Event) Event to delegate to  MainForm_CloseRequest(EventData as Event) 
	Set default icon so that its click can be captured if required.
	Stop the form closing on Right mouse button click
	Added override for Maximize size, mainly for Mac users.

V1.2
	Implemented FullScreen Mode
	Bug Fixes
		- Window dragged to top could end up across two screens
		- Double click on maximized form titlebar did not always set Maximized to false
		- Correct Snap sizing of dropshadow forms

V1.3
	Added Snapping background and border colors to designer properties.
	Fixed bug on Snapping background for multiple screens
	improved Linux compatibility

V1.4
	Added Right To Left Compatibility
	Options added
		Show Icon
		Show Maximize
	Fixed a bug that stopped the titlebar taking the full width of the window particularly when dropped in a corner of the screen.
	
V1.5
	Added option to designer UsingStylesheet to stop colors being updated in code.
	Renamed class Popup to TB_Popup to minimize the risk of the same class being loaded in multiple libraries.
	Added Class TB_DSE containing : ClearAllStyles
									AddStyleClass
	Added some styleclassnames to the views in the titlebar layout
	Changed default icon
	Added width adjustment to layout to allow border all around the Rootpane
	Added ResetScreensub for use as panic mode if the titlebar becomes inaccessible.
	Added option to save and restore windowposition on shutdown / startup which maintains the Maximized property
									
#End iF
Sub Class_Globals
	Private fx As JFX
	Private XUI As XUI
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Private mTargetForm As Form
	
	'Flag set when window is being resized
	Private WindowResizing As Boolean
	
	Public CloseIcon As B4XView
	Public MaximizeIcon As B4XView
	Public MinimizeIcon As B4XView
	
	'Holds variables for resizing the form
	Type ResizeWindowType(ResizeDirection As String, LastScreenX As Double, LastScreenY As Double)
	Private ResizeWindow As ResizeWindowType
	
	'Records the last position of the screen while dragging
	Type DragWindowType(LastScreenX As Double,LastScreenY As Double)
	Private DragWindow As DragWindowType
	
	'Record reset values and current docked status.  Also used for maximized and Fullscreen.
	Type DockedWindowType(Left As Double,Top As Double,Width As Double,Height As Double,Docked As Boolean)
	Private DockedWindow As DockedWindowType
	
	'Parameters for the dropshadow
	Type DropShadowType(On As Boolean,BorderWidth As Double,BorderInsets As Double, BackgroundInsets As Double, BackgroundInsets2 As Double, MouseOffset As Double,Color As Paint)
	Private DropShadow As DropShadowType
	
	'Parameters for Iconified Animation
	Type IconifiedimageType(F As Form, Img As Image)
	Private IconifiedImage As IconifiedimageType
	
	Type LayoutType (Left As Double,Top As Double,Width As Double,Height As Double)
	Private MaximizedLayout As LayoutType
	
	'Used to make sure the window doesn't get any smaller than this when it's resized
	'The developer should set the min width / height on the stage if it's important, this is just a fallback
	' and can be removed if required, but the form could disappear.
	Private TitleBarHeight As Double
	Private WindowMinWidth As Double = 20
	
	
	Public TitleBarBG As B4XView												'ignore
	Private ControlBtnPane As B4XView											'ignore
	Public TitleLabel As B4XView												'ignore
	
	'Colors to control the appearence of the control buttons.
	Public IconSelectedColor As Int
	Public IconHoveredColor As Int
	Public IconNormalColor As Int
	Public IconExitSelectedColor As Int
	Public IconExitHoveredColor As Int
	
	Private ShowMinimize,ShowMaximize,ShowIcon As Boolean
	Private MinimizeAutomation As Boolean
	
	'Holds the icon image.
	Public FormIcon As B4XView													
	
	'Windows Snapping
	Private DropIndicator As TB_Popup
	Private DropBoxDirection,LastDropBoxDirection As String
	Private WindowsSnappingEnabled As Boolean
	Private WindowsSnappingOffset As Int
	Private WindowsSnappingBackgroundColor As Int
	Private WindowsSnappingBorderColor As Int
	
	Private CurrentScreen As Screen
	
	Private mTag As Object
	Private pnTBLeft As B4XView
	Private pnTBRight As B4XView
	Private pnTBTop As B4XView
	Private pnTBBottom As B4XView
	
	Private DragBarSize As Double = 5
	
	Private ChildCount As Int
	
	Private Maximized As Boolean
	Private OveerrideMaximize As Boolean
	Private UsingStylesheet As Boolean
	Private TitleBarWidthAdj As Double
	
	#if Release
	Dim LinuxDelay As Long = 200						'ignore
	Dim LinuxShortDelay As Long = 50					'ignore
	#Else
	Dim LinuxDelay As Long = 400						'ignore
	Dim LinuxShortDelay As Long = 50					'ignore
	#End If

	Private NodeOrientation As String
	Private ManagePosition As Boolean
	
	Private TitleDelimiter As String = "-"
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	'Initialize Types
	ResizeWindow.Initialize
	DragWindow.Initialize
	IconifiedImage.Initialize
	DockedWindow.Initialize
	MaximizedLayout = CreateLayoutType(0,0,0,0)
	
	DropShadow.Initialize
	
End Sub

Public Sub DesignerCreateView (Base As Pane, Lbl As Label, Props As Map)
	mBase = Base
	mTag = mBase.Tag
	mBase.Tag = Me
	
	TitleBarWidthAdj = mBase.Parent.Width - mBase.Width

	Dim LayoutName As String = Props.GetDefault("LayoutName","titlebar")
	mBase.LoadLayout(LayoutName)
	
	'Record the minimum height for the Form window
	TitleBarHeight = TitleBarBG.Height
	
	'Deal with Custom properties.
	mTargetForm = Props.Get("Form")
	mTargetForm.SetFormStyle("TRANSPARENT")
	mTargetForm.RootPane.MouseCursor = fx.Cursors.DEFAULT
	
	TitleLabel.Text = mTargetForm.Title
	
	Dim Stage As JavaObject = mTargetForm
	Dim O As Object = Stage.CreateEvent("javafx.event.EventHandler","FormShown",Null)
	Stage = Stage.GetField("stage")
	Stage.RunMethod("setOnShown",Array(O))
	
	Dim O As Object = Stage.CreateEventFromUI("javafx.beans.value.ChangeListener","FormResize",Null)
	Dim P As JavaObject = Stage.RunMethod("widthProperty",Null)
	P.RunMethod("addListener",Array(O))
	P = Stage.RunMethod("heightProperty",Null)
	P.RunMethod("addListener",Array(O))
	
	ShowMinimize = Props.GetDefault("ShowMinimize",True)
	ShowMaximize = Props.GetDefault("ShowMaximize",True)
	ShowIcon = Props.GetDefault("ShowIcon",True)
	MinimizeAutomation = Props.GetDefault("MinimizeAnimation",True)
	DropShadow.On = Props.GetDefault("DropShadow",False)
	DropShadow.Color = Props.GetDefault("DropshadowColor",5)
	If DropShadow.On Then
		DropShadow.BackgroundInsets = 8
		DropShadow.BackgroundInsets2 = 16
		DropShadow.BorderInsets = 6
		DropShadow.BorderWidth = 5
		DropShadow.MouseOffset = DropShadow.BackgroundInsets
	End If
	
	WindowsSnappingEnabled = Props.GetDefault("WindowsSnapping",False)
	WindowsSnappingOffset = Props.GetDefault("WindowsSnappingOffset",20)
	WindowsSnappingBackgroundColor = XUI.PaintOrColorToColor(Props.GetDefault("WindowsSnappingBGColor",XUI.Color_ARGB(130,30,30,30)))
	WindowsSnappingBorderColor = XUI.PaintOrColorToColor(Props.GetDefault("WindowsSnappingBdrColor",XUI.Color_LightGray))
	
	UsingStylesheet = Props.GetDefault("UsingStylesheet",False)
	
	If Not(UsingStylesheet) Then
		'Colors to control the appearence of the control buttons.
		IconExitSelectedColor = XUI.PaintOrColorToColor(Props.GetDefault("IconExitSelectedColor",fx.Colors.ARGB(120,255,0,0)))
		IconExitHoveredColor = XUI.PaintOrColorToColor(Props.GetDefault("IconExitHoveredColor",fx.Colors.Red))
		IconSelectedColor =  XUI.PaintOrColorToColor(Props.GetDefault("IconSelectedColor",fx.Colors.ARGB(50,0,0,0)))
		IconHoveredColor = XUI.PaintOrColorToColor(Props.GetDefault("IconHoveredColor",fx.Colors.ARGB(25,0,0,0)))
		IconNormalColor = XUI.PaintOrColorToColor(Props.GetDefault("IconNormalColor",fx.Colors.Transparent))
	End If
	
	DropIndicator.Initialize
	DropIndicator.AutoHide = False
	DropIndicator.HideOnEscape = False
	DropIndicator.GetBase.SetColorAndBorder(WindowsSnappingBackgroundColor,2,WindowsSnappingBorderColor,0)
	
	
	Dim Height As Double = Stage.RunMethod("getHeight",Null)
	Dim Width As Double = Stage.RunMethod("getWidth",Null)
	
	pnTBLeft = XUI.CreatePanel("pnDrag")
	mTargetForm.RootPane.AddNode(pnTBLeft,0,0,DragBarSize,Height)
	pnTBLeft.Color = XUI.Color_Transparent
	
	pnTBTop = XUI.CreatePanel("pnDrag")
	mTargetForm.RootPane.AddNode(pnTBTop,DragBarSize,0,Width-DragBarSize * 2,DragBarSize)
	pnTBTop.Color = XUI.Color_Transparent
	
	pnTBRight = XUI.CreatePanel("pnDrag")
	mTargetForm.RootPane.AddNode(pnTBRight,Width - DragBarSize,0,DragBarSize,Height)
	pnTBRight.Color = XUI.Color_Transparent
	
	pnTBBottom = XUI.CreatePanel("pnDrag")
	mTargetForm.RootPane.AddNode(pnTBBottom,DragBarSize,Height - DragBarSize,Width - DragBarSize * 2,DragBarSize)
	pnTBBottom.Color = XUI.Color_Transparent

	ChildCount = mTargetForm.RootPane.NumberOfNodes
	
	SetEventHandlers
	
	If DropShadow.On Then CallSubDelayed(Me,"SetWindowSize")
	If ShowIcon = False Then
		FormIcon.RemoveViewFromParent
		Sleep(0)
		TitleLabel.Left = 5
	End If
	
	If ShowMinimize = False Then
		MinimizeIcon.RemoveViewFromParent
		If ShowMaximize = False Then
			MaximizeIcon.RemoveViewFromParent
			ControlBtnPane.Width = ControlBtnPane.Width - MinimizeIcon.Width - MaximizeIcon.Width
			ControlBtnPane.Left = ControlBtnPane.Left + MinimizeIcon.Width + MaximizeIcon.Width
			CloseIcon.Left = 0
'			CloseIcon.Left = MaximizeIcon.Width
		Else
			ControlBtnPane.Width = ControlBtnPane.Width - MinimizeIcon.Width
			ControlBtnPane.Left = ControlBtnPane.Left + MinimizeIcon.Width
			MaximizeIcon.Left = 0
			CloseIcon.Left = MaximizeIcon.Width
		End If
	Else If ShowMaximize = False Then
		MaximizeIcon.RemoveViewFromParent
		ControlBtnPane.Width = ControlBtnPane.Width - MaximizeIcon.Width
		ControlBtnPane.Left = ControlBtnPane.Left + MaximizeIcon.Width
		MinimizeIcon.Left = 0
		CloseIcon.Left = MinimizeIcon.Width
	End If
	
	LayoutTitleBar
	
	If TB_Utils.isUnix Then OverrideMaximizedLayout(0,0,0,0)
	
	CallSubDelayed(Me,"Set_Overlay")
	
	NodeOrientation = mTargetForm.RootPane.As(JavaObject).RunMethodJO("getEffectiveNodeOrientation",Null).RunMethod("toString",Null)
	If NodeOrientation = "RIGHT_TO_LEFT" Then SetTitleOrientation
	
	TitleDelimiter = Props.GetDefault("TitleDelim","-")
	
	ManagePosition = Props.GetDefault("ManagePosition",False)
	
	If ManagePosition Then 
		Sleep(0)
		SetWindowPosition
	End If
	
End Sub

Public Sub SaveWindowPosition
	
	If mTargetForm.Title = "Form" Then
		Log(mTargetForm.Title & " Cannot set for metrics for a form with an unmodified title")
		Return
	End If
	Dim FormName As String = mTargetForm.Title
	If FormName.Contains(TitleDelimiter) Then
		FormName = FormName.SubString2(0,FormName.IndexOf(TitleDelimiter)).Trim
	End If
	
	Dim M As Map
	M.Initialize
	
	Dim M1 As Map
	M1.Initialize
	M1.Put("winleft",mTargetForm.WindowLeft)
	M1.Put("wintop",mTargetForm.WindowTop)
	M1.Put("winwidth",mTargetForm.WindowWidth)
	M1.Put("winheight",mTargetForm.WindowHeight)
	M1.Put("ismaximized",IsMaximized)
	
	M.Put(FormName,M1)
	
	Dim RAF As RandomAccessFile
	RAF.Initialize(XUI.DefaultFolder,"win.dat",False)
	RAF.WriteB4XObject(M,0)
	RAF.Close
	
End Sub

Public Sub SetWindowPosition
	Dim FormName As String = mTargetForm.Title
	If FormName.Contains(TitleDelimiter) Then
		FormName = FormName.SubString2(0,FormName.IndexOf(TitleDelimiter)).Trim
	End If
	
	Dim WindRect As B4XRect
	WindRect.Initialize(1,1,2,2)
	
	Dim M As Map
	M.Initialize
	
	If File.Exists(XUI.DefaultFolder,"win.dat") Then
		Dim RAF As RandomAccessFile
		RAF.Initialize(XUI.DefaultFolder,"win.dat",True)
		M = RAF.ReadB4XObject(0)
		RAF.Close
		
		Dim M1 As Map = M.GetDefault(FormName,CreateMap())
		
		If M1.GetDefault("ismaximized",False) Then
			MaximizeForm(mTargetForm,True)
			Return
		End If
		
		WindRect.Left = M1.GetDefault("winleft", mTargetForm.WindowLeft)
		WindRect.top = M1.GetDefault("wintop",mTargetForm.WindowTop)
		WindRect.Width = M1.GetDefault("winwidth",mTargetForm.WindowWidth)
		WindRect.Height = M1.GetDefault("winheight",mTargetForm.WindowHeight)
		
	Else
		WindRect.Left = mTargetForm.WindowLeft
		WindRect.Top = mTargetForm.WindowTop
		WindRect.Width = mTargetForm.WindowWidth
		WindRect.Height = mTargetForm.WindowHeight
	End If
	
	Dim Scr As Screen = GetScreen(WindRect.CenterX,WindRect.CenterY)
	
	mTargetForm.WindowLeft = Max(Scr.MinX,WindRect.Left)
	mTargetForm.WindowTop = Max(Scr.MinY, WindRect.Top)
	mTargetForm.WindowWidth = Min(Scr.MaxX - mTargetForm.WindowLeft, WindRect.Width)
	mTargetForm.WindowHeight = Min(Scr.MaxY - mTargetForm.WindowTop, WindRect.Height)

End Sub

Private Sub GetScreen(X As Double,Y As Double) As Screen
	Dim Screen As JavaObject
	Screen.InitializeStatic("javafx.stage.Screen")
	Dim Screens As List = Screen.RunMethod("getScreensForRectangle",Array(X,Y,1.0,1.0))
	If Screens.Size = 0 Then Return fx.PrimaryScreen
	Return Screens.Get(0)
End Sub

Private Sub LayoutTitleBar
	Sleep(0)
	TitleBarBG.Width = mTargetForm.WindowWidth - TitleBarWidthAdj
	TitleLabel.Width = TitleBarBG.Width - TitleLabel.Left
	ControlBtnPane.Left =TitleBarBG.Width - ControlBtnPane.Width
End Sub

'Set the position for the maximized screen.  Also changes the Snap display.
'If you change the left or top, you also need to make the opposite change to the width or height.
'Set all to -1 to turn off.
Public Sub OverrideMaximizedLayout(Left As Double,Top As Double,Width As Double,Height As Double)
	If Left = -1 And Top = -1 And Width = -1 And Height = -1 Then
		OveerrideMaximize = False
	Else
		MaximizedLayout = CreateLayoutType(Left,Top,Width,Height)
		OveerrideMaximize = True
	End If
End Sub

Private Sub Set_Overlay
	pnTBLeft.BringToFront
	pnTBTop.BringToFront
	pnTBRight.BringToFront
	pnTBBottom.BringToFront
End Sub

Private Sub FormShown_Event (MethodName As String, Args() As Object)
	DockedWindow = CreateDockedWindowType(mTargetForm.WindowLeft,mTargetForm.WindowTop,mTargetForm.WindowWidth,mTargetForm.WindowHeight,False)
	CurrentScreen = FormUtils.GetCurrentScreen(FormUtils.GetFURectFromForm(mTargetForm))
End Sub

Private Sub SetWindowSize
	'Enlarge the window by the size of the insets, so that it looks the same size.
	'The transparent border holds the drop shadow.
	mTargetForm.WindowWidth = mTargetForm.WindowWidth + DropShadow.BackgroundInsets2
	mTargetForm.WindowHeight = mTargetForm.WindowHeight + DropShadow.BackgroundInsets2
	mTargetForm.RootPane.Style = $"-fx-border-width: ${DropShadow.BorderWidth};-fx-background-insets: ${DropShadow.BackgroundInsets};-fx-border-insets: ${DropShadow.BorderInsets};"$
End Sub

Private Sub SetEventHandlers
	Dim JO As JavaObject = mTargetForm
	Dim Stage As JavaObject = JO.GetField("stage")
	
	'Called when the form is maximized or restored
	Dim O As Object = Stage.CreateEventFromUI("javafx.beans.InvalidationListener","MaximizedChanged",Null)
	Stage.RunMethodJO("maximizedProperty",Null).RunMethod("addListener",Array(O))
	
	'Called when the form is maximized or restored
	Dim O As Object = Stage.CreateEventFromUI("javafx.beans.InvalidationListener","FullScreenChanged",Null)
	Stage.RunMethodJO("fullScreenProperty",Null).RunMethod("addListener",Array(O))
	
	'Called when the form is iconized or restored
'	Dim O As Object = Stage.CreateEventFromUI("javafx.beans.InvalidationListener","IconifiedChanged",Null)
'	Stage.RunMethodJO("iconifiedProperty",Null).RunMethod("addListener",Array(O))
	
	'Called whrn the input focus of the form changes
	Dim O As Object = Stage.CreateEventFromUI("javafx.beans.InvalidationListener","InputFocusChanged",Null)
	Stage.RunMethodJO("focusedProperty",Null).RunMethod("addListener",Array(O))
	
	'Called when the title on the form is changed
	Dim O As Object = Stage.CreateEventFromUI("javafx.beans.InvalidationListener","TitleChanged",Null)
	Stage.RunMethodJO("titleProperty",Null).RunMethod("addListener",Array(O))
	
	'Called when the Icon on the form is changed
	Dim O As Object = Stage.CreateEventFromUI("javafx.beans.InvalidationListener","IconChanged",Null)
	Stage.RunMethodJO("getIcons",Null).RunMethod("addListener",Array(O))
	
	JO = Stage.RunMethod("getScene",Null)
	
	If DropShadow.On Then
		'Set the scene almost transparent so the drop shadow appears to be outside of the window
		'If it were fully transparent it would receive no mouse events, and could not be resized.
		JO.RunMethod("setFill",Array(fx.Colors.ARGB(1,0,0,0)))
	End If

	JO = MinimizeIcon
	Dim O As Object = JO.CreateEventFromUI("javafx.event.EventHandler","IconMouseEntered",Null)
	JO.RunMethod("setOnMouseEntered",Array(O))
	Dim O As Object = JO.CreateEventFromUI("javafx.event.EventHandler","IconMouseExited",Null)
	JO.RunMethod("setOnMouseExited",Array(O))

	JO = MaximizeIcon
	Dim O As Object = JO.CreateEventFromUI("javafx.event.EventHandler","IconMouseEntered",Null)
	JO.RunMethod("setOnMouseEntered",Array(O))
	Dim O As Object = JO.CreateEventFromUI("javafx.event.EventHandler","IconMouseExited",Null)
	JO.RunMethod("setOnMouseExited",Array(O))
	
	JO = CloseIcon
	Dim O As Object = JO.CreateEventFromUI("javafx.event.EventHandler","IconMouseEntered",Null)
	JO.RunMethod("setOnMouseEntered",Array(O))
	Dim O As Object = JO.CreateEventFromUI("javafx.event.EventHandler","IconMouseExited",Null)
	JO.RunMethod("setOnMouseExited",Array(O))
	
	Dim JOR As JavaObject = mTargetForm.RootPane
	JOR = JOR.RunMethod("getChildrenUnmodifiable",Null)
	Dim O As Object = JOR.CreateEventFromUI("javafx.collections.ListChangeListener","ChildrenChanged",Null)
	JOR.RunMethod("addListener",Array(O))
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)

End Sub

Private Sub ChildrenChanged_Event (MethodName As String, Args() As Object)
	If mTargetForm.RootPane.NumberOfNodes > ChildCount Then ResetMouseListeners
	ChildCount = mTargetForm.RootPane.NumberOfNodes
End Sub

Private Sub FormResize_Event(MethodName As String,Args() As Object)
	Dim P As JavaObject = Args(0)
	Dim DropAdj As Double = 0
	If DropShadow.On Then DropAdj = DropShadow.BackgroundInsets
	Select P.RunMethod("getName",Null)
		Case "width"
			Dim Width As Double = P.RunMethod("getValue",Null) - DropAdj * 2
			pnTBTop.SetLayoutAnimated(0,DragBarSize + DropAdj,DropAdj,Width - DragBarSize * 2,DragBarSize)
			pnTBBottom.SetLayoutAnimated(0,DragBarSize + DropAdj,pnTBBottom.Top,Width-DragBarSize * 2,DragBarSize)
			pnTBRight.SetLayoutAnimated(0,Width - DragBarSize + DropAdj,DropAdj,DragBarSize,pnTBRight.Height)
		Case "height"
			Dim Height As Double = P.RunMethod("getValue",Null) - DropAdj * 2
			pnTBLeft.SetLayoutAnimated(0,DropAdj,DropAdj,DragBarSize,Height)
			pnTBRight.SetLayoutAnimated(0,pnTBRight.Left,DropAdj,DragBarSize,Height)
			pnTBBottom.SetLayoutAnimated(0,DragBarSize + DropAdj,Height - DragBarSize + DropAdj ,pnTBBottom.Width,DragBarSize)
	End Select
	LayoutTitleBar
End Sub

'Deprecated, should no longer be necessary.
Public Sub ResetMouseListeners
	pnTBLeft.BringToFront
	pnTBTop.BringToFront
	pnTBRight.BringToFront
	pnTBBottom.BringToFront
End Sub

Public Sub GetBase As B4XView
	Return mBase
End Sub


'Private Sub iconifiedChanged_Event (MethodName As String, Args() As Object)
'	Dim Prop As JavaObject = Args(0)
'
'End Sub

Public Sub SetFullscreen(State As Boolean)
	If TB_Utils.isUnix Then
		Log("Full screen is not yet implemented on Linux")
		Return
	End If
	FormUtils.SetFullScreen(mTargetForm,State)
	
	If State Then
		mTargetForm.WindowTop = mTargetForm.WindowTop - mBase.Height - DropShadow.BackgroundInsets
		mTargetForm.WindowLeft = mTargetForm.WindowLeft - DropShadow.BackgroundInsets
		mTargetForm.WindowWidth = mTargetForm.WindowWidth + DropShadow.BackgroundInsets2
		mTargetForm.WindowHeight = mTargetForm.WindowHeight + mBase.Height + DropShadow.BackgroundInsets2
	End If
	
End Sub


Public Sub ResetScreen(Width As Double, Height As Double)
	If FormUtils.IsFullScreen(mTargetForm) Then SetFullscreen(False)
	If IsMaximized Then MaximizeForm(mTargetForm,False)
	mTargetForm.WindowWidth = Width
	mTargetForm.WindowHeight = Height
	Dim Stage As JavaObject = mTargetForm.As(JavaObject).GetFieldJO("stage")
	Stage.RunMethod("centerOnScreen",Null)
End Sub

Private Sub FullScreenChanged_Event (MethodName As String, Args() As Object)
	Dim Prop As JavaObject = Args(0)
	Dim State As Boolean
	State = Prop.RunMethod("getValue",Null)
	If State = False Then
		If Maximized Then MaximizeForm(mTargetForm,True)
	End If
	
	If State Then
		pnTBLeft.Enabled = False
		pnTBTop.Enabled = False
		pnTBRight.Enabled = False
		pnTBBottom.Enabled = False
		DockWindow(False)
		DropIndicator.Hide
	Else
		If Maximized = False Then
			pnTBLeft.Enabled = True
			pnTBTop.Enabled = True
			pnTBRight.Enabled = True
			pnTBBottom.Enabled = True
		End If
	End If
End Sub


Private Sub pnDrag_MouseMoved (EventData As MouseEvent)
	
	Dim EventJO As JavaObject = EventData
	Dim Offset As Double = pnTBLeft.Width
	Dim OffSetAdj As Double = DropShadow.BorderInsets * 2
	'Cursor class
	Dim Cursors As JavaObject
	Cursors.InitializeStatic("javafx.scene.Cursor")
	
	'Holds the cursor to display dependant on start position
	Dim Cursor As Object
	Cursor = fx.Cursors.DEFAULT
	
	'Resize parameters
	ResizeWindow.ResizeDirection = ""
	ResizeWindow.LastScreenX = EventJO.RunMethod("getScreenX",Null)
	ResizeWindow.LastScreenY  = EventJO.RunMethod("getScreenY",Null)
	
	'Drop shadow has a large transparent border so offset needs to be larger.
	If DropShadow.On Then Offset = DropShadow.MouseOffset

	Select NodeOrientation
		Case "LEFT_TO_RIGHT"
			Select Sender
				Case pnTBLeft
					Dim Jo As JavaObject = pnTBLeft
					If EventData.Y < Offset Then
						Jo.RunMethod("setCursor",Array(Cursors.GetField("NW_RESIZE")))
						ResizeWindow.ResizeDirection = "NW"
					else If EventData.Y > mTargetForm.WindowHeight - Offset - OffSetAdj Then
						Jo.RunMethod("setCursor",Array(Cursors.GetField("SW_RESIZE")))
						ResizeWindow.ResizeDirection = "SW"
					Else
						Jo.RunMethod("setCursor",Array(Cursors.GetField("W_RESIZE")))
						ResizeWindow.ResizeDirection = "W"
					End If
		
				Case pnTBTop
					Dim Jo As JavaObject = pnTBTop
					Jo.RunMethod("setCursor",Array(Cursors.GetField("N_RESIZE")))
					ResizeWindow.ResizeDirection = "N"
				Case pnTBRight
					Dim Jo As JavaObject = pnTBRight
					If EventData.Y < Offset Then
						Jo.RunMethod("setCursor",Array(Cursors.GetField("NE_RESIZE")))
						ResizeWindow.ResizeDirection = "NE"
					else If EventData.Y > mTargetForm.WindowHeight - Offset - OffSetAdj Then
						Jo.RunMethod("setCursor",Array(Cursors.GetField("SE_RESIZE")))
						ResizeWindow.ResizeDirection = "SE"
					Else
						Jo.RunMethod("setCursor",Array(Cursors.GetField("E_RESIZE")))
						ResizeWindow.ResizeDirection = "E"
					End If
				Case pnTBBottom
					Dim Jo As JavaObject = pnTBBottom
					Jo.RunMethod("setCursor",Array(Cursors.GetField("S_RESIZE")))
					ResizeWindow.ResizeDirection = "S"
			End Select
		Case "RIGHT_TO_LEFT"
			Select Sender
				Case pnTBLeft
					Dim Jo As JavaObject = pnTBLeft
					If EventData.Y < Offset Then
						Jo.RunMethod("setCursor",Array(Cursors.GetField("NE_RESIZE")))
						ResizeWindow.ResizeDirection = "NE"
					else If EventData.Y > mTargetForm.WindowHeight - Offset - OffSetAdj Then
						Jo.RunMethod("setCursor",Array(Cursors.GetField("SE_RESIZE")))
						ResizeWindow.ResizeDirection = "SE"
					Else
						Jo.RunMethod("setCursor",Array(Cursors.GetField("E_RESIZE")))
						ResizeWindow.ResizeDirection = "E"
					End If
		
				Case pnTBTop
					Dim Jo As JavaObject = pnTBTop
					Jo.RunMethod("setCursor",Array(Cursors.GetField("N_RESIZE")))
					ResizeWindow.ResizeDirection = "N"
				Case pnTBRight
					Dim Jo As JavaObject = pnTBRight
					If EventData.Y < Offset Then
						Jo.RunMethod("setCursor",Array(Cursors.GetField("NW_RESIZE")))
						ResizeWindow.ResizeDirection = "NW"
					else If EventData.Y > mTargetForm.WindowHeight - Offset - OffSetAdj Then
						Jo.RunMethod("setCursor",Array(Cursors.GetField("SW_RESIZE")))
						ResizeWindow.ResizeDirection = "SW"
					Else
						Jo.RunMethod("setCursor",Array(Cursors.GetField("W_RESIZE")))
						ResizeWindow.ResizeDirection = "W"
					End If
				Case pnTBBottom
					Dim Jo As JavaObject = pnTBBottom
					Jo.RunMethod("setCursor",Array(Cursors.GetField("S_RESIZE")))
					ResizeWindow.ResizeDirection = "S"
			End Select
	End Select
	
	mTargetForm.RootPane.MouseCursor = Cursor
End Sub

Private Sub pnDrag_MouseDragged (EventData As MouseEvent)
	If DockedWindow.Docked Then DockWindow(False)
	
	Dim EventJO As JavaObject = EventData
	Dim ScreenX As Double = EventJO.RunMethod("getScreenX",Null)
	Dim ScreenY As Double = EventJO.RunMethod("getScreenY",Null)
	
	WindowResizing = True
	
	'Do the resize when the mouse cursor is dragged (Moved with a button down)
	Select ResizeWindow.ResizeDirection
		Case "N"
			mTargetForm.WindowTop = ScreenY - DropShadow.BorderInsets
			mTargetForm.WindowHeight = Max(TitleBarHeight, mTargetForm.WindowHeight - (ScreenY - ResizeWindow.LastScreenY ))
			
		Case "S"
			mTargetForm.WindowHeight = Max(TitleBarHeight, mTargetForm.WindowHeight + (ScreenY - ResizeWindow.LastScreenY ))
		Case "E"
			mTargetForm.WindowWidth = Max(WindowMinWidth, mTargetForm.WindowWidth + (ScreenX - ResizeWindow.LastScreenX ))
		Case "W"
			mTargetForm.WindowLeft = ScreenX - DropShadow.BorderInsets
			mTargetForm.WindowWidth = Max(WindowMinWidth, mTargetForm.WindowWidth - (ScreenX - ResizeWindow.LastScreenX ))
		Case "NW"
			'N
			mTargetForm.WindowTop = ScreenY - DropShadow.BorderInsets
			mTargetForm.WindowHeight = Max(TitleBarHeight, mTargetForm.WindowHeight - (ScreenY - ResizeWindow.LastScreenY ))
			'W
			mTargetForm.WindowLeft = ScreenX - DropShadow.BorderInsets
			mTargetForm.WindowWidth = Max(WindowMinWidth, mTargetForm.WindowWidth - (ScreenX - ResizeWindow.LastScreenX ))
		Case "NE"
			'N
			mTargetForm.WindowTop = ScreenY - DropShadow.BorderInsets
			mTargetForm.WindowHeight = Max(TitleBarHeight, mTargetForm.WindowHeight - (ScreenY - ResizeWindow.LastScreenY ))
			'E
			mTargetForm.WindowWidth = Max(WindowMinWidth, mTargetForm.WindowWidth + (ScreenX - ResizeWindow.LastScreenX ))
		Case "SE"
			'S
			mTargetForm.WindowHeight = Max(TitleBarHeight, mTargetForm.WindowHeight + (ScreenY - ResizeWindow.LastScreenY ))
			'E
			mTargetForm.WindowWidth = Max(WindowMinWidth, mTargetForm.WindowWidth + (ScreenX - ResizeWindow.LastScreenX ))
		Case "SW"
			'S
			mTargetForm.WindowHeight = Max(TitleBarHeight, mTargetForm.WindowHeight + (ScreenY - ResizeWindow.LastScreenY ))
			'W
			mTargetForm.WindowLeft = ScreenX - DropShadow.BorderInsets
			mTargetForm.WindowWidth = Max(WindowMinWidth, mTargetForm.WindowWidth - (ScreenX - ResizeWindow.LastScreenX ))
	End Select
	
	LayoutTitleBar
	ResizeWindow.LastScreenY = ScreenY
	ResizeWindow.LastScreenX = ScreenX
	
End Sub


Private Sub pnDrag_MouseExited (EventData As MouseEvent)
	mTargetForm.RootPane.MouseCursor = fx.Cursors.DEFAULT
End Sub

Private Sub pnDrag_MouseReleased (EventData As MouseEvent)
	WindowResizing = False
End Sub

Private Sub InputFocusChanged_Event (MethodName As String, Args() As Object)

	If DropShadow.On Then
		Dim Prop As JavaObject = Args(0)
		Dim JO As JavaObject = mTargetForm.RootPane
		Dim Effect As JavaObject
		'Only show the shadow when the form has input focus.
		If Prop.RunMethod("getValue",Null)  Then
			CSSUtils.SetBorder(mTargetForm.RootPane,2,fx.Colors.aRGB(100,0,0x96,0xc9),0)
			Effect.InitializeNewInstance("javafx.scene.effect.DropShadow",Array(10.0,5.0,5.0,DropShadow.Color))
			JO.RunMethod("setEffect",Array(Effect))
		Else
			CSSUtils.SetBorder(mTargetForm.RootPane,2,fx.Colors.Transparent,0)
			Effect.InitializeNewInstance("javafx.scene.effect.DropShadow",Array(10.0,5.0,5.0,fx.Colors.Transparent))
			JO.RunMethod("setEffect",Array(Effect))
		End If
	End If
End Sub

Private Sub TitleChanged_Event (MethodName As String, Args() As Object)
	Dim Prop As JavaObject = Args(0)
	'Update the title with that assigned to the original form.
	TitleLabel.Text = Prop.RunMethod("getValue",Null)
End Sub

Private Sub IconChanged_Event (MethodName As String, Args() As Object)
	Dim L As List = Args(0)
	'Update the Icon with that assigned to the original form.
	FormIcon.SetBitmap(L.Get(L.Size - 1))
	
End Sub

'Control the hover, selected and normal color of the control labels and their clicked actions.
#Region Control icons Mouse Event handelers

Private Sub MinimizeIcon_MousePressed (EventData As MouseEvent)
	If UsingStylesheet Then
		ToggleList(Sender.As(Node).StyleClasses,"title-bar-minimize-icon-hover","title-bar-minimize-icon-pressed")
	Else
		Sender.As(B4XView).Color = IconSelectedColor
	End If
End Sub

Private Sub MinimizeIcon_MouseReleased (EventData As MouseEvent)
	If UsingStylesheet Then
		ToggleList(Sender.As(Node).StyleClasses,"title-bar-minimize-icon-pressed","title-bar-minimize-icon")
	Else
		Sender.As(B4XView).Color = IconNormalColor
	End If
End Sub

Private Sub ToggleList(L As List, Remove As String, Add As String)
	Dim Pos As Int = L.IndexOf(Remove)
	If Pos > -1 Then L.RemoveAt(Pos)
	Pos = L.IndexOf(Add)
	If Pos = -1 Then L.Add(Add)
End Sub

Private Sub MinimizeIcon_MouseClicked (EventData As MouseEvent)
	If MinimizeAutomation Then
		IconifiedImage.Img = mTargetForm.RootPane.Snapshot
		IconifyAutomationInit
	Else
		FormUtils.SetIconified(mTargetForm,True)
	End If
	EventData.Consume
End Sub


Private Sub WinChange_Event (MethodName As String, Args() As Object)
	Dim Prop As JavaObject = Args(0)
	If Prop.RunMethod("getName",Null) = "XProp" Then 
		IconifiedImage.F.WindowLeft = Prop.RunMethod("getValue",Null)
	Else If Prop.RunMethod("getName",Null) = "YProp" Then 
		IconifiedImage.F.WindowTop = Prop.RunMethod("getValue",Null)
	Else If Prop.RunMethod("getName",Null) = "WProp" Then 
		IconifiedImage.F.WindowWidth = Prop.RunMethod("getValue",Null)
	Else If Prop.RunMethod("getName",Null) = "HProp" Then
		IconifiedImage.F.WindowHeight = Prop.RunMethod("getValue",Null)
	Else
		IconifiedImage.F.RootPane.Alpha = Prop.RunMethod("getValue",Null)
	End If
End Sub

Private Sub IconifyAutomationInit
	
	IconifiedImage.F.Initialize("",mTargetForm.Width,mTargetForm.Height)
	IconifiedImage.F.SetFormStyle("TRANSPARENT")
	IconifiedImage.F.WindowLeft = mTargetForm.WindowLeft  + DropShadow.BorderInsets
	IconifiedImage.F.WindowTop = mTargetForm.WindowTop  + DropShadow.BorderInsets
	IconifiedImage.F.WindowWidth = mTargetForm.WindowWidth
	IconifiedImage.F.WindowHeight = mTargetForm.WindowHeight
	If DropShadow.On Then
		CropImage(IconifiedImage.F,IconifiedImage.img,DropShadow.BackgroundInsets,DropShadow.BackgroundInsets,IconifiedImage.Img.Width - DropShadow.BackgroundInsets,IconifiedImage.Img.Height - DropShadow.BackgroundInsets)
	Else
		Dim IV As ImageView
		IV.Initialize("")
		IV.SetImage(IconifiedImage.Img)
		IconifiedImage.F.RootPane.AddNode(IV,0,0,IV.Width,IV.PrefHeight)
	End If
	IconifiedImage.F.Show
	Dim S As Int = 0
	If Maximized Then S = 250
	
	Sleep(S)
	Dim Scr As Screen = FormUtils.GetCurrentScreen(FormUtils.GetFURectFromForm(IconifiedImage.F))
	FormUtils.SetIconified(mTargetForm,True)
	Dim RS As ResumableSub = SetFormLayoutAnimated(IconifiedImage.F,200,Scr.MinX,Scr.MaxY,IconifiedImage.F.WindowWidth / 2,IconifiedImage.F.WindowHeight / 2,0)
	
	Wait For (RS) Complete (Resp As Boolean)
	
	IconifiedImage.F.Close
	IconifiedImage.F.RootPane.RemoveAllNodes
'	Release the Form and Image that we've just used from memory
	Dim F As Form
	IconifiedImage.F = F
	Dim Img As Image
	IconifiedImage.Img = Img
End Sub

'https://www.b4x.com/android/forum/threads/capture-part-of-an-imageviews-image-and-return-it-as-an-image.73635/#post-467681
Private Sub CropImage(F As Form, img As Image, Left As Int, Top As Int, Width As Int, Height As Int)
	Dim cvs As Canvas
	cvs.Initialize("")
	F.RootPane.AddNode(cvs, 0, 0, Width, Height)
	cvs.DrawImage2(img, Left, Top, Width, Height, 0, 0, Width, Height)
End Sub




'Pass -1 to leave alpha unchanged
Private Sub SetFormLayoutAnimated(Target As Form, Duration As Double,X As Double,Y As Double, Width As Double, Height As Double, Alpha As Double) As ResumableSub

	Dim Interval As Double = 15
	Dim Steps As Double = Duration / Interval
	
	Dim Stage As JavaObject
	Dim TargetJO As JavaObject = Target
	
	
	Dim XStep, YStep, WidthStep, HeightStep As Double
	Dim OpacityStep As Double
	
	Stage = TargetJO.GetFieldJO("stage")
	XStep = (X - Stage.RunMethod("getX",Null)) / Steps
	YStep  = (Y - Stage.RunMethod("getY",Null)) / Steps
	WidthStep = (Width - Stage.RunMethod("getWidth",Null)) / Steps
	HeightStep = (Height - Stage.RunMethod("getHeight",Null)) / Steps
		
	If Alpha = -1 Then
		OpacityStep = 0
	Else
		OpacityStep = (Alpha - Stage.RunMethod("getOpacity",Null)) / Steps
	End If
	
	
	For i = 0 To Steps
		Stage.RunMethod("setX",Array(Stage.RunMethod("getX",Null) + XStep))
		Stage.RunMethod("setY",Array(Stage.RunMethod("getY",Null) + YStep))
		Stage.RunMethod("setWidth",Array(Stage.RunMethod("getWidth",Null) + WidthStep))
		Stage.RunMethod("setHeight",Array(Stage.RunMethod("getHeight",Null) + HeightStep))
		Stage.RunMethod("setOpacity",Array(Max(0,Stage.RunMethod("getOpacity",Null) + OpacityStep)))
		Sleep(Interval)
	Next
	
	Return True
End Sub

Private Sub MaximizeIcon_MousePressed (EventData As MouseEvent)
	If UsingStylesheet Then
		ToggleList(Sender.As(Node).StyleClasses,"title-bar-maximize-icon-hover","title-bar-maximize-icon-pressed")
	Else
		TB_Cast.AsB4XView(Sender).Color = IconSelectedColor
	End If
End Sub

Private Sub MaximizeIcon_MouseReleased (EventData As MouseEvent)
	If UsingStylesheet Then
		ToggleList(Sender.As(Node).StyleClasses,"title-bar-maximize-icon-pressed","title-bar-maximize-icon")
	Else
		TB_Cast.AsB4XView(Sender).Color = IconNormalColor
	End If
End Sub
Private Sub MaximizeIcon_MouseClicked (EventData As MouseEvent)
	MaximizeForm(mTargetForm,Not(Maximized))
	EventData.Consume
End Sub

Public Sub IsMaximized As Boolean
	Return Maximized
End Sub

Private Sub IconMouseEntered_Event (MethodName As String, Args() As Object)
	mTargetForm.RootPane.MouseCursor = fx.Cursors.DEFAULT
	If UsingStylesheet Then
		If Sender  = CloseIcon Then
			ToggleList(Sender.As(Node).StyleClasses,"title-bar-close-icon","title-bar-close-icon-hover")
		Else If Sender = MinimizeIcon Then
			ToggleList(Sender.As(Node).StyleClasses,"title-bar-minimize-icon","title-bar-minimize-icon-hover")
		Else
			ToggleList(Sender.As(Node).StyleClasses,"title-bar-maximize-icon","title-bar-maximize-icon-hover")
			
		End If
	Else
		If Sender  = CloseIcon Then
			TB_Cast.AsB4XView(Sender).Color = IconExitHoveredColor
		Else
			TB_Cast.AsB4XView(Sender).Color = IconHoveredColor
		End If
	End If
End Sub

Private Sub IconMouseExited_Event (MethodName As String, Args() As Object)
	If UsingStylesheet Then
		If Sender  = CloseIcon Then
			ToggleList(Sender.As(Node).StyleClasses,"title-bar-close-icon-hover","title-bar-close-icon")
			ToggleList(Sender.As(Node).StyleClasses,"title-bar-close-icon-pressed","title-bar-close-icon")
		Else If Sender = MinimizeIcon Then
			ToggleList(Sender.As(Node).StyleClasses,"title-bar-minimize-icon-hover","title-bar-minimize-icon")
			ToggleList(Sender.As(Node).StyleClasses,"title-bar-minimize-icon-pressed","title-bar-minimize-icon")
		Else
			ToggleList(Sender.As(Node).StyleClasses,"title-bar-maximize-icon-hover","title-bar-maximize-icon")
			ToggleList(Sender.As(Node).StyleClasses,"title-bar-maximize-icon-pressed","title-bar-maximize-icon")
		End If
	Else
		TB_Cast.AsB4XView(Sender).Color = IconNormalColor
	End If
End Sub

Private Sub CloseIcon_MousePressed (EventData As MouseEvent)
	If UsingStylesheet Then
			ToggleList(Sender.As(Node).StyleClasses,"title-bar-close-icon-hover","title-bar-close-icon-pressed")
	Else
		If EventData.PrimaryButtonPressed Then TB_Cast.AsB4XView(Sender).Color = IconExitSelectedColor
	End If
End Sub

Private Sub CloseIcon_MouseReleased (EventData As MouseEvent)
	If UsingStylesheet Then
		ToggleList(Sender.As(Node).StyleClasses,"title-bar-close-icon-pressed","title-bar-close-icon")
	Else
		If EventData.PrimaryButtonPressed Then TB_Cast.AsB4XView(Sender).Color = IconNormalColor
	End If
End Sub

Public Sub Close_Request
	Dim MEVTS As JavaObject
	MEVTS.InitializeStatic("javafx.scene.input.MouseEvent")
	Dim MEVT As JavaObject
	MEVT.InitializeNewInstance("javafx.scene.input.MouseEvent", Array( _
	MEVTS.GetField("MOUSE_CLICKED"),0.0,0.0,15.0,15.0,"PRIMARY",1,False,False,False,False,True,False,False,True,False,True,Null))
	CloseIcon.As(JavaObject).RunMethod("fireEvent",Array(MEVT))
End Sub

Private Sub CloseIcon_MouseClicked (EventData As MouseEvent)
	If EventData.PrimaryButtonPressed Then
		'The For _CloseRequest sub doesn't get called when we call Form.Close, and we can't know the name of the
		'form in the calling module.  The best we can do is provide a mathcing _Close request call which can be delegated directly to
		'the Form _Closerequest sub.
		'We can cast the MouseEvent to it's parent type Event.
		Dim Evt As Event = EventData
		If SubExists(mCallBack,mEventName & "_CloseRequest") Then CallSub2(mCallBack,mEventName & "_CloseRequest",Evt)
		'If the event has not been consumed then close the form.
		If ManagePosition Then SaveWindowPosition
		Dim Jo As JavaObject = EventData
		If Jo.RunMethod("isConsumed",Null) = False Then
			mTargetForm.Close
			EventData.Consume
		End If
	End If
End Sub

#End Region

#Region DragWindow
Private Sub TitleLabel_MousePressed (EventData As MouseEvent)
	Dim EventDataJO As JavaObject = EventData
	'Record the initial mouse pressed position.
	DragWindow.LastScreenX = EventDataJO.RunMethod("getSceneX",Null)
	DragWindow.LastScreenY = EventDataJO.RunMethod("getSceneY",Null)
	If DockedWindow.Docked = False And Maximized = False Then
		DockedWindow = CreateDockedWindowType(mTargetForm.WindowLeft,mTargetForm.WindowTop,mTargetForm.WindowWidth,mTargetForm.WindowHeight,False)
	End If
End Sub

Private Sub TitleLabel_MouseDragged (EventData As MouseEvent)
	If WindowResizing Then Return
	Dim EventDataJO As JavaObject = EventData
	
	Dim ScreenX As Double = EventDataJO.RunMethod("getScreenX", Null)
	Dim ScreenY As Double = EventDataJO.RunMethod("getScreenY", Null)
	
	
	If Maximized Then
		'Restore position relative to the mouse x pos
		Dim MaximizedWidth As Double = mTargetForm.WindowWidth
		MaximizeForm(mTargetForm,False)
		mTargetForm.WindowLeft = ScreenX - mTargetForm.WindowWidth / 2
		mTargetForm.WindowTop = ScreenY
		DragWindow.LastScreenX = (EventDataJO.RunMethod("getSceneX",Null) / MaximizedWidth) * mTargetForm.WindowWidth
		DragWindow.LastScreenY = EventDataJO.RunMethod("getSceneY",Null)
		DockWindow(False)
		Return
	Else If DockedWindow.Docked Then
		'Undock, restore previous window size and position relative to the mouse x pos
		Dim DockedWidth As Double = mTargetForm.WindowWidth
		mTargetForm.WindowLeft = ScreenX - DockedWindow.Width / 2
		mTargetForm.WindowWidth = DockedWindow.Width
		mTargetForm.WindowHeight = DockedWindow.Height
		DragWindow.LastScreenX = (EventDataJO.RunMethod("getSceneX",Null) / DockedWidth) * mTargetForm.WindowWidth
		DragWindow.LastScreenY = EventDataJO.RunMethod("getSceneY",Null)
		DockWindow(False)
	Else
		'Move the form
		mTargetForm.WindowLeft = ScreenX - DragWindow.LastScreenX
		mTargetForm.WindowTop = ScreenY - DragWindow.LastScreenY
	End If
	
	If WindowsSnappingEnabled = False Or EventDataJO.RunMethod("isControlDown",Null) Then
		If DropIndicator.IsShowing Then DropIndicator.Hide
		Return
	End If
	
	Dim R As FURect = FormUtils.CreateFURect(ScreenX,ScreenY,1,1)
	CurrentScreen = FormUtils.GetCurrentScreen(R)
	
	Dim MinX As Double = CurrentScreen.MinX
	Dim MinY As Double = CurrentScreen.MinY
	Dim Width As Double = CurrentScreen.MaxX - CurrentScreen.MinX
	Dim Height As Double = CurrentScreen.MaxY - CurrentScreen.MinY

	If OveerrideMaximize Then
		MinX = MinX + MaximizedLayout.Left
		MinY = MinY + MaximizedLayout.Top
		Width = Width + MaximizedLayout.Width
		Height = Height + MaximizedLayout.Height
	End If

	
	Dim NormalizedScreenX As Double = ScreenX - MinX
	Dim NormalizedScreenY As Double = ScreenY - MinY
	Dim TargetX, TargetY, TargetWidth, TargetHeight As Double
	
	'Check if the mouse cursor is at an edge of the window and show the anchor boxes

	If NormalizedScreenX <= WindowsSnappingOffset Then
		If NormalizedScreenY < WindowsSnappingOffset Then
			DropBoxDirection = "NW"
			TargetX = MinX
			TargetY = MinY
			TargetWidth = Width / 2
			TargetHeight = Height / 2
			
		Else If NormalizedScreenY >= Height - WindowsSnappingOffset Then
			DropBoxDirection = "SW"
			TargetX = MinX
			TargetY =  MinY + Height / 2
			TargetWidth = Width / 2
			TargetHeight = Height / 2
		Else
			DropBoxDirection = "W"
			TargetX = MinX
			TargetY = MinY
			TargetWidth = Width / 2
			TargetHeight = Height
		End If
	Else If NormalizedScreenY <= WindowsSnappingOffset Then
		If NormalizedScreenX >= Width - WindowsSnappingOffset Then
			DropBoxDirection = "NE"
			TargetX = MinX + Width / 2
			TargetY = MinY
			TargetWidth = Width / 2
			TargetHeight = Height / 2
		Else
			DropBoxDirection = "N"
			TargetX = MinX
			TargetY = MinY
			TargetWidth = Width
			TargetHeight = Height
		End If
	Else If NormalizedScreenX >= Width - WindowsSnappingOffset Then
		If NormalizedScreenY >= Height - WindowsSnappingOffset Then
			DropBoxDirection = "SE"
			TargetX = MinX + Width / 2
			TargetY = MinY + Height / 2
			TargetWidth = Width / 2
			TargetHeight = Height / 2
		Else
			DropBoxDirection = "E"
			TargetX = MinX + Width / 2
			TargetY = MinY
			TargetWidth = Width / 2
			TargetHeight = Height
		End If
	Else If NormalizedScreenY >= Height - WindowsSnappingOffset Then
		DropBoxDirection = "S"
		TargetX = MinX
		TargetY = MinY
		TargetWidth = Width
		TargetHeight = Height
	Else
		DropBoxDirection = "Clear"
		DropIndicator.Hide
		LastDropBoxDirection = DropBoxDirection
		Return
	End If
	
	If DropBoxDirection <> LastDropBoxDirection Then
		DropIndicator.Hide
		LastDropBoxDirection = DropBoxDirection
	End If
	
	DropIndicator.Height = TargetHeight
	DropIndicator.Width = TargetWidth
	DropIndicator.X = TargetX
	DropIndicator.Y = TargetY
	
	If DropIndicator.IsShowing = False Then DropIndicator.Show2(mTargetForm)
End Sub

Private Sub MaximizeForm(F As Form,State As Boolean)
	Maximized = State
	If OveerrideMaximize Then
		If Maximized Then
			CurrentScreen = FormUtils.GetCurrentScreen(FormUtils.GetFURectFromForm(mTargetForm))
			If TB_Utils.isUnix Then Sleep(LinuxDelay)
			mTargetForm.WindowLeft = CurrentScreen.MinX + MaximizedLayout.Left - DropShadow.BackgroundInsets
			mTargetForm.WindowTop = CurrentScreen.MinY + MaximizedLayout.Top  - DropShadow.BackgroundInsets
			mTargetForm.WindowWidth = CurrentScreen.MaxX - CurrentScreen.MinX + MaximizedLayout.Width  + DropShadow.BackgroundInsets2
			mTargetForm.WindowHeight = CurrentScreen.MaxY - CurrentScreen.MinY + MaximizedLayout.Height + DropShadow.BackgroundInsets2
			MaximizedChanged_Event ("Override" , Array(State))
		Else
			mTargetForm.WindowWidth = DockedWindow.Width
			mTargetForm.WindowHeight = DockedWindow.Height
			If TB_Utils.isUnix Then Sleep(LinuxDelay)
			mTargetForm.WindowLeft = DockedWindow.Left
			mTargetForm.WindowTop = DockedWindow.Top
			MaximizedChanged_Event ("Override" , Array(State))
		End If
	Else
		If Maximized = False And DockedWindow.Docked Then
			mTargetForm.WindowLeft = DockedWindow.Left
			mTargetForm.WindowTop = DockedWindow.Top
			mTargetForm.WindowWidth = DockedWindow.Width
			mTargetForm.WindowHeight = DockedWindow.Height
			DockWindow(False)
		End If
		FormUtils.SetMaximized(F,State)
	End If
	
	If State Then
		pnTBLeft.Enabled = False
		pnTBTop.Enabled = False
		pnTBRight.Enabled = False
		pnTBBottom.Enabled = False
		DropIndicator.Hide
	Else
		pnTBLeft.Enabled = True
		pnTBTop.Enabled = True
		pnTBRight.Enabled = True
		pnTBBottom.Enabled = True
	End If
	LayoutTitleBar
End Sub

Private Sub MaximizedChanged_Event (MethodName As String, Args() As Object)
	Dim Prop As JavaObject = Args(0)
	Dim PropVal As Boolean
	If OveerrideMaximize And MethodName = "Override" Then
		PropVal = Args(0)
	Else
		PropVal = Prop.RunMethod("getValue",Null)
	End If
	If DropShadow.On Then
		Dim JO As JavaObject = mTargetForm.RootPane
		If PropVal = True Then
			'Scale the rootpane so that the shadow is hidden.
			Dim ScaleX As Double = 1 + (DropShadow.BackgroundInsets2 / mTargetForm.WindowWidth)
			Dim ScaleY As Double = 1 + (DropShadow.BackgroundInsets2 / mTargetForm.WindowHeight)
			JO.RunMethod("setScaleX",Array(ScaleX))
			JO.RunMethod("setScaleY",Array(ScaleY))
		
		Else
			'Reset the scale
			JO.RunMethod("setScaleX",Array(1.0))
			JO.RunMethod("setScaleY",Array(1.0))
		End If
	End If
	If OveerrideMaximize And MethodName = "Override" Then
		Maximized = PropVal
	Else
		MaximizeForm(mTargetForm,PropVal)
	End If
	If  Maximized = False Then
		If TB_Utils.isUnix Then Sleep(LinuxShortDelay)
		mTargetForm.WindowTop = Min(Max(0,mTargetForm.WindowTop),CurrentScreen.MaxY - mTargetForm.WindowHeight)
	End If
End Sub

Private Sub TitleLabel_MouseReleased (EventData As MouseEvent)
	If EventData.PrimaryButtonPressed And EventData.ClickCount > 1 Then
		If DockedWindow.Docked Then
			'undock the window
'			If TB_Utils.isUnix Then Sleep(300)
			mTargetForm.WindowWidth = DockedWindow.Width
			mTargetForm.WindowHeight = DockedWindow.Height
			If TB_Utils.isUnix Then Sleep(LinuxDelay)
			mTargetForm.WindowLeft = DockedWindow.Left
			mTargetForm.WindowTop = DockedWindow.Top
			DockWindow(False)
			If Maximized Then MaximizeForm(mTargetForm,False)
		Else
			'Maximize the window on double click
			MaximizeForm(mTargetForm,Not(Maximized))
		End If
		EventData.Consume
		Return
	End If
	
	If DropIndicator.IsShowing Then
		DockWindow(True)
		Select DropBoxDirection
			Case "N","S"
				If mTargetForm.WindowLeft + mTargetForm.WindowWidth * 0.75 >= CurrentScreen.MaxX Then
					mTargetForm.WindowLeft = CurrentScreen.MaxX - mTargetForm.WindowWidth
					Sleep(50)
				End If
				MaximizeForm(mTargetForm,True)
				
			Case Else
				If TB_Utils.isUnix Then Sleep(LinuxDelay)
				mTargetForm.WindowLeft = DropIndicator.X - DropShadow.BackgroundInsets
				mTargetForm.WindowTop = DropIndicator.Y - DropShadow.BackgroundInsets
				mTargetForm.WindowWidth = DropIndicator.Width + DropShadow.BackgroundInsets2
				mTargetForm.WindowHeight = DropIndicator.Height + DropShadow.BackgroundInsets2
		End Select
		DropIndicator.Hide
	End If
End Sub

Private Sub DockWindow(State As Boolean)
	DockedWindow.Docked = State
	If DropShadow.On Then
		Dim JO As JavaObject = mTargetForm.RootPane
		If DockedWindow.Docked = True Then
			'Scale the rootpane so that the shadow is hidden.
			Dim ScaleX As Double = 1 + (DropShadow.BackgroundInsets2 / mTargetForm.WindowWidth)
			Dim ScaleY As Double = 1 + (DropShadow.BackgroundInsets2 / mTargetForm.WindowHeight)
			JO.RunMethod("setScaleX",Array(ScaleX))
			JO.RunMethod("setScaleY",Array(ScaleY))
		
		Else
			'Reset the scale
			JO.RunMethod("setScaleX",Array(1.0))
			JO.RunMethod("setScaleY",Array(1.0))
		End If
	End If
End Sub
#End Region DragWindow

Private Sub CreateDockedWindowType (Left As Double, Top As Double, Width As Double, Height As Double, Docked As Boolean) As DockedWindowType
	Dim t1 As DockedWindowType
	t1.Initialize
	t1.Left = Left
	t1.Top = Top
	t1.Width = Width
	t1.Height = Height
	t1.Docked = Docked
	Return t1
End Sub


Public Sub getTag As Object
	Return mTag
End Sub

Public Sub setTag(Tag As Object)
	mTag = Tag
End Sub



Private Sub CreateLayoutType (Left As Double, Top As Double, Width As Double, Height As Double) As LayoutType
	Dim t1 As LayoutType
	t1.Initialize
	t1.Left = Left
	t1.Top = Top
	t1.Width = Width
	t1.Height = Height
	Return t1
End Sub

Private Sub SetTitleOrientation
	Dim jo As JavaObject = TitleBarBG
	jo.RunMethod("setNodeOrientation", Array("LEFT_TO_RIGHT"))

End Sub