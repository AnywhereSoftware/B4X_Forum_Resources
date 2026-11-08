B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' formHelpers - .NET WinForms-style API wrapper around a B4J Form (JavaFX Stage).
' Initialize with a Form, then use the properties/methods below. The underlying Stage is
' resolved lazily via RootPane -> Scene -> Window (a B4J Form does not unwrap to the Stage).
' See DOCS/FormHelper-ToDo.md for the full roadmap.
'
' Properties: WindowState, FormBorderStyle, StartPosition, Text, TopMost, Opacity,
'   Left, Top, Width, Height, ClientWidth, ClientHeight, BackColor, Cursor, DialogResult.
' Methods:    SetLocation, SetSize, SetBounds, SetMinimumSize, SetMaximumSize, CenterToScreen,
'   SetIcon, SetIconFromFile, Show, Hide, Close, Activate, BringToFront, SendToBack, Focus,
'   ShowDialog (ResumableSub).
' Enums (Public Const): STATE_*, BORDER_*, POS_*, CURSOR_*, RESULT_*.
' No events (use B4J's native Form events: _Resize, _FocusChanged, _Closed, etc.).
Sub Class_Globals
	Private fx As JFX
	Private frm As Form
	Private stage As JavaObject				'underlying javafx.stage.Stage
	Private scene As JavaObject				'underlying javafx.scene.Scene

	'WindowState enum
	Public Const STATE_NORMAL As Int = 0
	Public Const STATE_MINIMIZED As Int = 1
	Public Const STATE_MAXIMIZED As Int = 2

	'FormBorderStyle enum
	Public Const BORDER_NONE As Int = 0			'undecorated, no title bar
	Public Const BORDER_SIZABLE As Int = 1		'decorated + resizable
	Public Const BORDER_FIXED As Int = 2		'decorated + not resizable
	Public Const BORDER_TRANSPARENT As Int = 3	'transparent background
	Public Const BORDER_UTILITY As Int = 4		'utility (no min/max buttons)

	'StartPosition enum
	Public Const POS_MANUAL As Int = 0
	Public Const POS_CENTERSCREEN As Int = 1

	'Cursor names (javafx.scene.Cursor)
	Public Const CURSOR_DEFAULT As String = "DEFAULT"
	Public Const CURSOR_WAIT As String = "WAIT"
	Public Const CURSOR_HAND As String = "HAND"
	Public Const CURSOR_CROSSHAIR As String = "CROSSHAIR"
	Public Const CURSOR_TEXT As String = "TEXT"
	Public Const CURSOR_MOVE As String = "MOVE"

	'DialogResult values (WinForms DialogResult)
	Public Const RESULT_NONE As Int = 0
	Public Const RESULT_OK As Int = 1
	Public Const RESULT_CANCEL As Int = 2

	'cached state (JavaFX has no getter for stage style / start position / etc.)
	'NOTE: do not initialize globals from other globals here - B4X throws at runtime.
	Private mBorderStyle As Int
	Private mStartPosition As Int
	Private mBackColor As Int
	Private mCursor As String
	Private mDialogResult As Int
End Sub

'Initializes the helper with the Form to wrap.
Public Sub Initialize(f As Form)
	frm = f
	mBorderStyle = BORDER_SIZABLE
	mStartPosition = POS_MANUAL
End Sub

'Returns the underlying JavaFX Scene (lazy - the RootPane has a scene once the form is shown).
Private Sub GetScene As JavaObject
	If scene.IsInitialized = False Then
		Dim joPane As JavaObject = frm.RootPane
		scene = joPane.RunMethod("getScene", Null)
	End If
	Return scene
End Sub

'Returns the underlying JavaFX Stage (lazy) via Scene -> Window.
'A B4J Form does not unwrap to the Stage directly, so we resolve it through the scene.
Private Sub GetStage As JavaObject
	If stage.IsInitialized = False Then
		stage = GetScene.RunMethod("getWindow", Null)
	End If
	Return stage
End Sub

'===================== Phase 1: Window state & style =====================

'WindowState: Normal / Minimized / Maximized
Public Sub getWindowState As Int
	Dim st As JavaObject = GetStage
	Dim iconified As Boolean = st.RunMethod("isIconified", Null)
	If iconified Then Return STATE_MINIMIZED
	Dim maximized As Boolean = st.RunMethod("isMaximized", Null)
	If maximized Then Return STATE_MAXIMIZED
	Return STATE_NORMAL
End Sub

Public Sub setWindowState(State As Int)
	Dim st As JavaObject = GetStage
	Select State
		Case STATE_MINIMIZED
			st.RunMethod("setIconified", Array(True))
		Case STATE_MAXIMIZED
			st.RunMethod("setIconified", Array(False))
			st.RunMethod("setMaximized", Array(True))
		Case Else 'STATE_NORMAL
			st.RunMethod("setIconified", Array(False))
			st.RunMethod("setMaximized", Array(False))
	End Select
End Sub

'FormBorderStyle. NOTE: JavaFX only applies the stage style before the form is shown.
'Resizable can be changed at any time.
Public Sub getFormBorderStyle As Int
	Return mBorderStyle
End Sub

Public Sub setFormBorderStyle(Style As Int)
	mBorderStyle = Style
	Dim styleName As String
	Dim resizable As Boolean = True
	Select Style
		Case BORDER_NONE
			styleName = "UNDECORATED"
		Case BORDER_FIXED
			styleName = "DECORATED"
			resizable = False
		Case BORDER_TRANSPARENT
			styleName = "TRANSPARENT"
		Case BORDER_UTILITY
			styleName = "UTILITY"
		Case Else 'BORDER_SIZABLE
			styleName = "DECORATED"
	End Select
	'Resizable can be changed at any time.
	frm.Resizable = resizable
	'The stage style can only be set BEFORE the form is shown - JavaFX throws otherwise.
	Dim shown As Boolean = GetStage.RunMethod("isShowing", Null)
	If shown Then
		Log($"FormBorderStyle: stage style '${styleName}' can only be applied before the form is shown; only Resizable was changed."$)
	Else
		frm.SetFormStyle(styleName)
	End If
End Sub

'StartPosition: CenterScreen applies immediately; Manual leaves Left/Top to the caller.
Public Sub getStartPosition As Int
	Return mStartPosition
End Sub

Public Sub setStartPosition(Position As Int)
	mStartPosition = Position
	If Position = POS_CENTERSCREEN Then
		GetStage.RunMethod("centerOnScreen", Null)
	End If
End Sub

'Text == window title (WinForms Form.Text)
Public Sub getText As String
	Return frm.Title
End Sub

Public Sub setText(Title As String)
	frm.Title = Title
End Sub

'TopMost == always on top
Public Sub getTopMost As Boolean
	Return frm.AlwaysOnTop
End Sub

Public Sub setTopMost(Value As Boolean)
	frm.AlwaysOnTop = Value
End Sub

'Opacity 0.0 (transparent) .. 1.0 (opaque)
Public Sub getOpacity As Double
	Return GetStage.RunMethod("getOpacity", Null)
End Sub

Public Sub setOpacity(Value As Double)
	GetStage.RunMethod("setOpacity", Array(Value))
End Sub

'===================== Phase 2: Size & position =====================

'Left/Top == window position on screen (WinForms Form.Left / Top).
Public Sub getLeft As Double
	Return GetStage.RunMethod("getX", Null)
End Sub

Public Sub setLeft(Value As Double)
	GetStage.RunMethod("setX", Array(Value))
End Sub

Public Sub getTop As Double
	Return GetStage.RunMethod("getY", Null)
End Sub

Public Sub setTop(Value As Double)
	GetStage.RunMethod("setY", Array(Value))
End Sub

'Width/Height == outer window size, decorations included (WinForms Form.Width / Height / Size).
Public Sub getWidth As Double
	Return frm.WindowWidth
End Sub

Public Sub setWidth(Value As Double)
	frm.WindowWidth = Value
End Sub

Public Sub getHeight As Double
	Return frm.WindowHeight
End Sub

Public Sub setHeight(Value As Double)
	frm.WindowHeight = Value
End Sub

'ClientWidth/ClientHeight == content (scene) area, read-only (WinForms Form.ClientSize).
Public Sub getClientWidth As Double
	Return frm.Width
End Sub

Public Sub getClientHeight As Double
	Return frm.Height
End Sub

'Convenience setters (no struct types in B4X, so these take separate args).
Public Sub SetLocation(Left As Double, Top As Double)
	setLeft(Left)
	setTop(Top)
End Sub

Public Sub SetSize(Width As Double, Height As Double)
	setWidth(Width)
	setHeight(Height)
End Sub

Public Sub SetBounds(Left As Double, Top As Double, Width As Double, Height As Double)
	SetLocation(Left, Top)
	SetSize(Width, Height)
End Sub

'MinimumSize / MaximumSize (WinForms Form.MinimumSize / MaximumSize).
Public Sub SetMinimumSize(Width As Double, Height As Double)
	Dim st As JavaObject = GetStage
	st.RunMethod("setMinWidth", Array(Width))
	st.RunMethod("setMinHeight", Array(Height))
End Sub

Public Sub SetMaximumSize(Width As Double, Height As Double)
	Dim st As JavaObject = GetStage
	st.RunMethod("setMaxWidth", Array(Width))
	st.RunMethod("setMaxHeight", Array(Height))
End Sub

'CenterToScreen (WinForms Form.CenterToScreen).
Public Sub CenterToScreen
	GetStage.RunMethod("centerOnScreen", Null)
End Sub

'===================== Phase 3: Appearance =====================

'Icon (WinForms Form.Icon). Adds an image to the stage's icon list.
Public Sub SetIcon(Image As Image)
	Dim icons As JavaObject = GetStage.RunMethod("getIcons", Null)
	Dim joImg As JavaObject = Image			'unwrap to javafx.scene.image.Image
	icons.RunMethod("add", Array(joImg))
End Sub

'Convenience: load an icon from a folder/file and apply it.
Public Sub SetIconFromFile(Dir As String, FileName As String)
	SetIcon(fx.LoadImage(Dir, FileName))
End Sub

'BackColor (WinForms Form.BackColor) - applied to the form's RootPane.
'NOTE: in a B4XPages app the page panel may cover the form RootPane.
Public Sub getBackColor As Int
	Return mBackColor
End Sub

Public Sub setBackColor(Clr As Int)
	mBackColor = Clr
	Dim bx As B4XView = frm.RootPane
	bx.Color = Clr
End Sub

'Cursor (WinForms Form.Cursor) - use one of the CURSOR_* constants.
Public Sub getCursor As String
	Return mCursor
End Sub

Public Sub setCursor(Name As String)
	mCursor = Name
	Dim cursorClass As JavaObject
	cursorClass.InitializeStatic("javafx.scene.Cursor")
	Dim c As Object = cursorClass.RunMethod("cursor", Array(Name))
	GetScene.RunMethod("setCursor", Array(c))
End Sub

'===================== Phase 4: Behavior & dialog =====================

'Show the form (WinForms Form.Show).
Public Sub Show
	'restore the default "exit when last window closes" behavior
	SetImplicitExit(True)
	frm.Show
End Sub

'Hide the form without closing it (WinForms Form.Hide).
'By default JavaFX exits the app when the last visible window is hidden, so we disable
'implicit exit first - otherwise hiding the only window would quit the program.
Public Sub Hide
	SetImplicitExit(False)
	GetStage.RunMethod("hide", Null)
End Sub

Private Sub SetImplicitExit (Value As Boolean)
	Dim platform As JavaObject
	platform.InitializeStatic("javafx.application.Platform")
	platform.RunMethod("setImplicitExit", Array(Value))
End Sub

'Close the form (WinForms Form.Close).
Public Sub Close
	frm.Close
End Sub

'Bring the window to the front and give it focus (WinForms Form.Activate).
Public Sub Activate
	GetStage.RunMethod("toFront", Null)
End Sub

Public Sub BringToFront
	GetStage.RunMethod("toFront", Null)
End Sub

Public Sub SendToBack
	GetStage.RunMethod("toBack", Null)
End Sub

Public Sub Focus
	GetStage.RunMethod("requestFocus", Null)
End Sub

'DialogResult carried by a modal form (WinForms Form.DialogResult).
Public Sub getDialogResult As Int
	Return mDialogResult
End Sub

Public Sub setDialogResult(Value As Int)
	mDialogResult = Value
End Sub

'ShowDialog - shows the form modally and resumes when it is closed (WinForms Form.ShowDialog).
'Must be called on a form that has NOT been shown yet. Caller uses:
'   Wait For (helper.ShowDialog) Complete (Result As Int)
'Throws if the form is already visible - JavaFX cannot make a live window modal.
'NOTE: this uses modal Show + Wait For (not showAndWait) on purpose - showAndWait spins a
'nested event loop that breaks B4XPages event delivery in debug mode.
Public Sub ShowDialog As ResumableSub
	mDialogResult = RESULT_NONE
	Dim st As JavaObject = GetStage
	Dim shown As Boolean = st.RunMethod("isShowing", Null)
	If shown Then
		ThrowError("ShowDialog: the form is already shown. Call ShowDialog before the form is visible.")
	End If
	Dim modality As JavaObject
	modality.InitializeStatic("javafx.stage.Modality")
	st.RunMethod("initModality", Array(modality.GetField("APPLICATION_MODAL")))
	frm.Show
	'Poll for close with Sleep instead of a native onHidden proxy: a Sleep resume runs on a
	'clean event-loop tick, whereas resuming inside JavaFX's synchronous event dispatch
	'(setOnHidden / showAndWait) raises "missing RaiseSynchronousEvents".
	Dim showing As Boolean = True
	Do While showing
		Sleep(50)
		showing = st.RunMethod("isShowing", Null)
	Loop
	Return mDialogResult
End Sub

'B4X has no Throw keyword; raise a runtime exception via the inline-Java helper below.
Private Sub ThrowError(Message As String)
	Dim me_jo As JavaObject = Me
	me_jo.RunMethod("throwError", Array(Message))
End Sub

#If JAVA
public void throwError(String message) {
	throw new RuntimeException(message);
}
#End If
