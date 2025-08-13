B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.9
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private ICallBack As CallBackObject
	Private EventMap As Map
	Private fx As JFX
	Type FUEventType(CallBack As Object, EventSub As String, Event As Object)
	Type FURect(Left As Double, Top As Double, Width As Double,Height As Double)
End Sub


'Gets the icon images to be used in the window decorations and when minimized.
'Also adds the icon to the form
'<code>Dim Img As Image = fx.LoadImage(File.DirAssets,"icon.png")
'FormUtils.GetIcons(MainForm).Add(Img)</code>
Public Sub GetIcons(F As Form) As List
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("getIcons",Null)
End Sub
'Gets the value of the property minHeight.
Public Sub GetMinHeight(F As Form) As Double
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("getMinHeight",Null)
End Sub
'Gets the value of the property minWidth.
Public Sub GetMinWidth(F As Form) As Double
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("getMinWidth",Null)
End Sub
'Gets the value of the property alwaysOnTop.
Public Sub IsAlwaysOnTop(F As Form) As Boolean
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("isAlwaysOnTop",Null)
End Sub
'Gets the value of the property fullScreen.
Public Sub IsFullScreen (F As Form) As Boolean
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("isFullScreen",Null)
End Sub
'Gets the value of the property iconified.
Public Sub IsIconified (F As Form) As Boolean
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("isIconified",Null)
End Sub
'Gets the value of the property maximized.
Public Sub IsMaximized (F As Form) As Boolean
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("isMaximized",Null)
End Sub
'Gets the value of the property resizable.
Public Sub IsResizable (F As Form) As Boolean
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("isResizable",Null)
End Sub
'Sets the value of the property fullScreen.
Public Sub SetFullScreen(F As Form, Value As Boolean)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setFullScreen",Array As Object(Value))
End Sub
'Specifies the text to show when a user enters full screen mode, usually used to indicate the way a user should go about exiting out of full screen mode.
Public Sub SetFullScreenExitHint(F As Form, Value As String)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setFullScreenExitHint",Array As Object(Value))
End Sub
'Specifies the KeyCombination that will allow the user to exit full screen mode.
Public Sub SetFullScreenExitKeyCombination(F As Form,TKeyCombination As Object)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setFullScreenExitKeyCombination",Array As Object(TKeyCombination))
End Sub
'Sets the value of the property iconified.
Public Sub SetIconified(F As Form, Value As Boolean)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setIconified",Array As Object(Value))
End Sub
'Sets the value of the property maxHeight.
Public Sub SetMaxHeight(F As Form, Value As Double)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setMaxHeight",Array As Object(Value))
End Sub
'Sets the value of the property maximized.
Public Sub SetMaximized(F As Form, Value As Boolean)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setMaximized",Array As Object(Value))
End Sub
'Sets the value of the property maxWidth.
Public Sub SetMaxWidth(F As Form, Value As Double)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setMaxWidth",Array As Object(Value))
End Sub
'Sets the value of the property minHeight.
Public Sub SetMinHeight(F As Form, Value As Double)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setMinHeight",Array As Object(Value))
End Sub
'Sets the value of the property minWidth.
Public Sub SetMinWidth(F As Form, Value As Double)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setMinWidth",Array As Object(Value))
End Sub
'Send the Window to the background.
Public Sub ToBack(F As Form)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("toBack",Null)
End Sub
'Bring the Window to the foreground.
Public Sub ToFront(F As Form)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("toFront",Null)
End Sub

Private Sub GetStage(F As JavaObject) As JavaObject
	Return F.GetField("stage")
End Sub

Public Sub SetOnIconified(F As Form, CallBack As Object, EventName As String)
	ICallBack.Initialize(CallBack,EventName)
	
	If Not(SubExists(CallBack,EventName & "_Changed")) Then Return
	
	Dim Stage As JavaObject = GetStage(F)
	Dim BoolProp As JavaObject
	
	BoolProp = Stage.RunMethod("iconifiedProperty",Null)
	
	Dim O As Object = BoolProp.CreateEventFromUI("javafx.beans.value.ChangeListener","Iconified",Null)
	BoolProp.RunMethod("addListener",Array(O))
End Sub

Public Sub Iconified_Event (MethodName As String, Args() As Object)
	CallSubDelayed2(ICallBack.CallBack,ICallBack.EventName & "_Changed",Args(2))
End Sub

Public Sub AddDefaultListeners(F As JavaObject,CallBack As Object, EventName As String)
	If EventMap.IsInitialized = False Then EventMap.Initialize
	
	Dim Stage As JavaObject = F.GetField("stage")
	
	If SubExists(CallBack, EventName & "_FocusChanged") Then
		Dim O As Object = Stage.CreateEventFromUI("javafx.beans.value.ChangeListener","FocusChanged",Null)
		Dim BoolProp As JavaObject = Stage.RunMethod("focusedProperty",Null)
		BoolProp.RunMethod("addListener",Array(O))
		Dim EventType As FUEventType
		EventType.Initialize
		EventType.CallBack = CallBack
		EventType.EventSub = EventName & "_FocusChanged"
		EventType.Event = O
		EventMap.Put("FocusChanged",EventType)
	End If
	If SubExists(CallBack, EventName & "_IconifiedChanged") Then
		Dim O As Object = Stage.CreateEventFromUI("javafx.beans.value.ChangeListener","IconifiedChanged",Null)
		Dim BoolProp As JavaObject = Stage.RunMethod("iconifiedProperty",Null)
		BoolProp.RunMethod("addListener",Array(O))
		Dim EventType As FUEventType
		EventType.Initialize
		EventType.CallBack = CallBack
		EventType.EventSub = EventName & "_IconifiedChanged"
		EventType.Event = O
		EventMap.Put("IconifiedChanged",EventType)
	End If
	
	If SubExists(CallBack, EventName & "_CloseRequest") Then
		Dim O As Object = Stage.CreateEventFromUI("javafx.event.EventHandler","CloseRequest",Null)
		Stage.RunMethod("setOnCloseRequest",Array(O))
		Dim EventType As FUEventType
		EventType.Initialize
		EventType.CallBack = CallBack
		EventType.EventSub = EventName & "_CloseRequest"
		EventType.Event = O
		EventMap.Put("CloseRequest",EventType)
	End If
	
	If SubExists(CallBack, EventName & "_Closed") Then
		Dim O As Object = Stage.CreateEventFromUI("javafx.event.EventHandler","Closed",Null)
		Stage.RunMethod("setOnHidden",Array(O))
		Dim EventType As FUEventType
		EventType.Initialize
		EventType.CallBack = CallBack
		EventType.EventSub = EventName & "_Closed"
		EventType.Event = O
		EventMap.Put("Closed",EventType)
	End If
	
End Sub

Private Sub FocusChanged_Event(MethodName As String, Args() As Object)
	Dim EventType As FUEventType = EventMap.Get("FocusChanged")
	CallSubDelayed2(EventType.CallBack,EventType.EventSub,Args(2))
End Sub

Private Sub IconifiedChanged_Event(MethodName As String, Args() As Object)
	Dim EventType As FUEventType = EventMap.Get("IconifiedChanged")
	CallSubDelayed2(EventType.CallBack,EventType.EventSub,Args(2))
End Sub

Private Sub CloseRequest_Event(MethodName As String, Args() As Object)
	Dim EventType As FUEventType = EventMap.Get("CloseRequest")
	Dim E As Event = Args(0)
	CallSubDelayed2(EventType.CallBack,EventType.EventSub,E)
End Sub

Private Sub Closed_Event(MethodName As String, Args() As Object)
	Dim EventType As FUEventType = EventMap.Get("Closed")
	CallSubDelayed(EventType.CallBack,EventType.EventSub)
End Sub

Public Sub GetCurrentScreen(R As FURect) As Screen
	
	Dim Screens As JavaObject
	Screens.InitializeStatic("javafx.stage.Screen")
	Dim Rect2d As JavaObject
	Rect2d.InitializeNewInstance("javafx.geometry.Rectangle2D",Array(R.Left,R.Top,R.Width,R.Height))
	Dim L As List = Screens.RunMethod("getScreensForRectangle",Array(Rect2d))
	If L.Size = 0 Then Return fx.Screens.Get(0)
	Return L.Get(0)
End Sub

Public Sub GetFURectFromForm(F As Form) As FURect
	Dim R As FURect
	R.Initialize
	R.Left = F.WindowLeft
	R.Top = F.WindowTop
	R.Width = F.WindowWidth
	R.Height = F.WindowHeight
	Return R
End Sub

Public Sub CreateFURect (Left As Double, Top As Double, Width As Double, Height As Double) As FURect
	Dim t1 As FURect
	t1.Initialize
	t1.Left = Left
	t1.Top = Top
	t1.Width = Width
	t1.Height = Height
	Return t1
End Sub