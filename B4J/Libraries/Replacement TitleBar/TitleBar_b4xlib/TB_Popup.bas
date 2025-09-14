B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.47
@EndOfDesignText@
#IgnoreWarnings:12
#Event: Event(Args())
'Class Module
Sub Class_Globals
	Private XUI As XUI
	Private TJO As JavaObject
	Private ListenersMap As Map
	'You may need to remove this if another class has already defined it.
	Type PO_ListenerType (Module As Object,EventName As String, Listener As Object)
	
	Private Base As B4XView
End Sub

'Initialize the Popup, Documentation for Popup in Javafx8 can be found here:<link>JavaFX 8 Popup|https://docs.oracle.com/javase/8/javafx/api/javafx/stage/Popup.html</link>
Public Sub Initialize
	ListenersMap.Initialize
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javafx.stage.Popup",Null)
	Base = XUI.CreatePanel("")
	
	getContent.Add(Base)
End Sub

'Registers an event filter to this node.
Public Sub AddEventFilter(Module As Object, EventName As String, EventType As JavaObject) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.get("AddEventFilter")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener1" ,Null)
		TJO.RunMethod("addEventFilter",Array As Object(EventType, EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And PO_ListenerType if they are not needed.
	Dim LT As PO_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("AddEventFilter",Listeners)
	Return EventObject
End Sub
Private Sub Listener1_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.get("AddEventFilter")
	If Listeners.IsInitialized Then
		For Each LT As PO_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'Registers an event handler to this node.
Public Sub AddEventHandler(Module As Object, EventName As String, EventType As JavaObject) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.get("AddEventHandler")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener2" ,Null)
		TJO.RunMethod("addEventHandler",Array As Object(EventType, EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And PO_ListenerType if they are not needed.
	Dim LT As PO_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("AddEventHandler",Listeners)
	Return EventObject
End Sub
Private Sub Listener2_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.get("AddEventHandler")
	If Listeners.IsInitialized Then
		For Each LT As PO_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub

'sets x and y properties on this Window so that it is centered on the curent screen.
Public Sub CenterOnScreen
	TJO.RunMethod("centerOnScreen",Null)
End Sub

'gets / sets the value of the property anchorLocation.
'One Of - CONTENT_BOTTOM_LEFT, CONTENT_BOTTOM_RIGHT, CONTENT_TOP_LEFT, CONTENT_TOP_RIGHT, WINDOW_BOTTOM_LEFT, WINDOW_BOTTOM_RIGHT, WINDOW_TOP_LEFT, WINDOW_TOP_RIGHT
Public Sub getAnchorLocation As String
	Return TJO.RunMethod("getAnchorLocation",Null)
End Sub
'gets the value of the property anchorX.
Public Sub getAnchorX As Double
	Return TJO.RunMethod("getAnchorX",Null)
End Sub
'gets the value of the property anchorY.
Public Sub getAnchorY As Double
	Return TJO.RunMethod("getAnchorY",Null)
End Sub

Public Sub GetBase As B4XView
	Return Base
End Sub
'gets the value of the property consumeAutoHidingEvents.
Public Sub getConsumeAutoHidingEvents As Boolean
	Return TJO.RunMethod("getConsumeAutoHidingEvents",Null)
End Sub
'The ObservableList of Nodes to be rendered on this Popup.
Public Sub getContent As List
	Return TJO.RunMethod("getContent",Null)
End Sub
'gets the value of the property height.
Public Sub getHeight As Double
	Return TJO.RunMethod("getHeight",Null)
End Sub

Public Sub getMouseCursor As Object
	Dim Scene As JavaObject = getScene
	Return Scene.RunMethod("getCursor",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub
'gets the value of the property opacity.
Public Sub getOpacity As Double
	Return TJO.RunMethod("getOpacity",Null)
End Sub
'gets the value of the property ownerNode.
Public Sub getOwnerNode As Node
	Return TJO.RunMethod("getOwnerNode",Null)
End Sub
'gets the value of the property ownerWindow.
Public Sub getOwnerWindow As JavaObject
	Return TJO.RunMethod("getOwnerWindow",Null)
End Sub
'gets the value of the property scene.
Public Sub getScene As JavaObject
	Return TJO.RunMethod("getScene",Null)
End Sub

Public Sub getStyle As String
	Dim N As Node = getContent.Get(0)
	Return N.Style
End Sub
'Returns a previously set Object property, or null if no such property has been set using the setUserData(java.lang.Object) method.
Public Sub getUserData As Object
	Return TJO.RunMethod("getUserData",Null)
End Sub
'gets the value of the property width.
Public Sub getWidth As Double
	Return TJO.RunMethod("getWidth",Null)
End Sub
'gets the value of the property x.
Public Sub getX As Double
	Return TJO.RunMethod("getX",Null)
End Sub
'gets the value of the property y.
Public Sub getY As Double
	Return TJO.RunMethod("getY",Null)
End Sub
'Hide this Popup and all its children
Public Sub Hide
	TJO.RunMethod("hide",Null)
End Sub
'Attempts to hide this Window by setting the visibility to false.
Public Sub Hide2
	TJO.RunMethod("hide",Null)
End Sub
'gets the value of the property autoFix.
Public Sub IsAutoFix As Boolean
	Return TJO.RunMethod("isAutoFix",Null)
End Sub
'gets the value of the property autoHide.
Public Sub IsAutoHide As Boolean
	Return TJO.RunMethod("isAutoHide",Null)
End Sub
'gets the value of the property focused.
Public Sub IsFocused As Boolean
	Return TJO.RunMethod("isFocused",Null)
End Sub
'gets the value of the property hideOnEscape.
Public Sub IsHideOnEscape As Boolean
	Return TJO.RunMethod("isHideOnEscape",Null)
End Sub
'gets the value of the property showing.
Public Sub IsShowing As Boolean
	Return TJO.RunMethod("isShowing",Null)
End Sub
'Unregisters a previously registered event filter from this node.
Public Sub RemoveEventFilter(Module As Object, EventName As String, EventType As JavaObject) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.get("RemoveEventFilter")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener3" ,Null)
		TJO.RunMethod("removeEventFilter",Array As Object(EventType, EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And PO_ListenerType if they are not needed.
	Dim LT As PO_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("RemoveEventFilter",Listeners)
	Return EventObject
End Sub
Private Sub Listener3_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.get("RemoveEventFilter")
	If Listeners.IsInitialized Then
		For Each LT As PO_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'Unregisters a previously registered event handler from this node.
Public Sub RemoveEventHandler(Module As Object, EventName As String, EventType As JavaObject) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.get("RemoveEventHandler")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener4" ,Null)
		TJO.RunMethod("removeEventHandler",Array As Object(EventType, EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And PO_ListenerType if they are not needed.
	Dim LT As PO_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("RemoveEventHandler",Listeners)
	Return EventObject
End Sub
Private Sub Listener4_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.get("RemoveEventHandler")
	If Listeners.IsInitialized Then
		For Each LT As PO_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'Requests that this Window get the input focus.
Public Sub RequestFocus
	TJO.RunMethod("requestFocus",Null)
End Sub
'sets the value of the property anchorLocation.
Public Sub setAnchorLocation(Value As String)
	TJO.RunMethod("setAnchorLocation",Array As Object(Value))
End Sub
'sets the value of the property anchorX.
Public Sub setAnchorX(Value As Double)
	TJO.RunMethod("setAnchorX",Array As Object(Value))
End Sub
'sets the value of the property anchorY.
Public Sub setAnchorY(Value As Double)
	TJO.RunMethod("setAnchorY",Array As Object(Value))
End Sub
'sets the value of the property autoFix.
Public Sub setAutoFix(Value As Boolean)
	TJO.RunMethod("setAutoFix",Array As Object(Value))
End Sub
'sets the value of the property autoHide.
Public Sub setAutoHide(Value As Boolean)
	TJO.RunMethod("setAutoHide",Array As Object(Value))
End Sub
'sets the value of the property consumeAutoHidingEvents.
Public Sub setConsumeAutoHidingEvents(Value As Boolean)
	TJO.RunMethod("setConsumeAutoHidingEvents",Array As Object(Value))
End Sub
'sets the value of the property eventDispatcher.
Public Sub setEventDispatcher(Value As JavaObject)
	TJO.RunMethod("setEventDispatcher",Array As Object(Value))
End Sub
'sets the handler to use for this event type.
Public Sub setEventHandler(Module As Object, EventName As String, EventType As JavaObject) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.get("setEventHandler")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener5" ,Null)
		TJO.RunMethod("setEventHandler",Array As Object(EventType, EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And PO_ListenerType if they are not needed.
	Dim LT As PO_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("setEventHandler",Listeners)
	Return EventObject
End Sub
Private Sub Listener5_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.get("setEventHandler")
	If Listeners.IsInitialized Then
		For Each LT As PO_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'sets the value of the property height.
Public Sub setHeight(Value As Double)
	TJO.RunMethod("setHeight",Array As Object(Value))
	Base.Height = Value
End Sub
'sets the value of the property hideOnEscape.
Public Sub setHideOnEscape(Value As Boolean)
	TJO.RunMethod("setHideOnEscape",Array As Object(Value))
End Sub

Public Sub setMouseCursor(Cursor As Object)
	Dim Scene As JavaObject = getScene
	Scene.RunMethod("setCursor",Array(Cursor))
End Sub
'sets the value of the property onAutoHide.
'Replace "FullClassName" with the full name of the listener class in B4a, or the EventHandler in B4j
Public Sub setOnAutoHide(Module As Object, EventName As String) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.get("setOnAutoHide")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener0" ,Null)
		TJO.RunMethod("setOnAutoHide",Array As Object(EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And PO_ListenerType if they are not needed.
	Dim LT As PO_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("setOnAutoHide",Listeners)
	Return EventObject
End Sub
Private Sub Listener0_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.get("setOnAutoHide")
	If Listeners.IsInitialized Then
		For Each LT As PO_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'sets the value of the property onCloseRequest.
Public Sub setOnCloseRequest(Module As Object, EventName As String) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.get("setOnCloseRequest")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener6" ,Null)
		TJO.RunMethod("setOnCloseRequest",Array As Object(EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And PO_ListenerType if they are not needed.
	Dim LT As PO_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("setOnCloseRequest",Listeners)
	Return EventObject
End Sub
Private Sub Listener6_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.get("setOnCloseRequest")
	If Listeners.IsInitialized Then
		For Each LT As PO_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'sets the value of the property onHidden.
Public Sub setOnHidden(Module As Object, EventName As String) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.get("setOnHidden")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener7" ,Null)
		TJO.RunMethod("setOnHidden",Array As Object(EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And PO_ListenerType if they are not needed.
	Dim LT As PO_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("setOnHidden",Listeners)
	Return EventObject
End Sub
Private Sub Listener7_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.get("setOnHidden")
	If Listeners.IsInitialized Then
		For Each LT As PO_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'sets the value of the property onHiding.
Public Sub setOnHiding(Module As Object, EventName As String) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.get("setOnHiding")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener8" ,Null)
		TJO.RunMethod("setOnHiding",Array As Object(EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And PO_ListenerType if they are not needed.
	Dim LT As PO_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("setOnHiding",Listeners)
	Return EventObject
End Sub
Private Sub Listener8_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.get("setOnHiding")
	If Listeners.IsInitialized Then
		For Each LT As PO_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'sets the value of the property onShowing.
Public Sub setOnShowing(Module As Object, EventName As String) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.get("setOnShowing")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener9" ,Null)
		TJO.RunMethod("setOnShowing",Array As Object(EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And PO_ListenerType if they are not needed.
	Dim LT As PO_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("setOnShowing",Listeners)
	Return EventObject
End Sub
Private Sub Listener9_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.get("setOnShowing")
	If Listeners.IsInitialized Then
		For Each LT As PO_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'sets the value of the property onShown.
Public Sub setOnShown(Module As Object, EventName As String) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.get("setOnShown")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener10" ,Null)
		TJO.RunMethod("setOnShown",Array As Object(EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And PO_ListenerType if they are not needed.
	Dim LT As PO_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("setOnShown",Listeners)
	Return EventObject
End Sub
Private Sub Listener10_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.get("setOnShown")
	If Listeners.IsInitialized Then
		For Each LT As PO_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'sets the value of the property opacity.
Public Sub setOpacity(Value As Double)
	TJO.RunMethod("setOpacity",Array As Object(Value))
End Sub
'Convenience method for setting a single Object property that can be retrieved at a later date.
Public Sub setUserData(Value As Object)
	TJO.RunMethod("setUserData",Array As Object(Value))
End Sub
'sets the value of the property width.
Public Sub setWidth(Value As Double)
	TJO.RunMethod("setWidth",Array As Object(Value))
	Base.Width = Value
End Sub
'sets the value of the property x.
Public Sub setX(Value As Double)
	TJO.RunMethod("setX",Array As Object(Value))
End Sub
'sets the value of the property y.
Public Sub setY(Value As Double)
	TJO.RunMethod("setY",Array As Object(Value))
End Sub
'Shows the popup at the specified location on the screen.
Public Sub Show(OwnerNode As Node, AnchorX As Double, AnchorY As Double)
	TJO.RunMethod("show",Array As Object(OwnerNode, AnchorX, AnchorY))
End Sub
'Show the popup.
Public Sub Show2(Ownerform As JavaObject)
	Dim Stage As Object = Ownerform.GetField("stage")
	TJO.RunMethod("show",Array As Object(Stage))
End Sub
'Shows the popup at the specified location on the screen.
Public Sub Show3(OwnerWindow As JavaObject, AnchorX As Double, AnchorY As Double)
	TJO.RunMethod("show",Array As Object(OwnerWindow, AnchorX, AnchorY))
End Sub

'set the width and height of this Window to match the size of the content of this Window's Scene.
Public Sub SizeToScene
	TJO.RunMethod("sizeToScene",Null)
End Sub

'Comment if not needed
'set the underlying Object, must be of correct type
Public Sub setObject(Obj As Object)
	TJO = Obj
End Sub

Public Sub setStyle(Style As String)
	Dim N As Node = getContent.Get(0)
	N.Style = Style
End Sub

'set the Tag for this object
Public Sub setTag(Tag As Object)
	TJO.RunMethod("setUserData",Array(Tag))
End Sub

'get the Tag for this object
Public Sub getTag As Object
	Dim Tag As Object = TJO.RunMethod("getUserData",Null)
	If Tag = Null Then Tag = ""
	Return Tag
End Sub



'The following subs are here as a convienience and may not alwasy be appropriate for the type of listener added.
Private Sub FindChangeListener(Module As Object,EventName As String) As Map
	'An uninitialized list to return if not found
	Dim L As List
	Dim M As Map
	M.Initialize
	M.Put("List",L)
	M.Put("Index",-1)
	M.Put("SubName","")
	For Each K As Object In ListenersMap.Keys
		Dim Listeners As List = ListenersMap.get(K)
		If Listeners.IsInitialized Then
			For  i = 0 To Listeners.Size - 1
				Dim LT As PO_ListenerType = Listeners.get(i)
				If LT.Module = Module And LT.EventName = EventName Then
					M.Put("List",Listeners)
					M.Put("Index",i)
					M.Put("SubName",K)
					Return M
				End If
			Next
		End If
	Next
	Return M
End Sub
Public Sub RemoveChangeListener(Module As Object,EventName As String) As Boolean
	'It is not always possible to remove a listener, but this will try the default method.  This may need to be changed. or removed.
	Dim M As Map = FindChangeListener(Module,EventName)
	Dim Listeners As List = M.get("List")
	If Listeners.IsInitialized Then
		Dim Pos As Int = M.get("Index")
		If Pos > -1 Then
			Dim LT As PO_ListenerType = Listeners.get(Pos)
			Listeners.RemoveAt(Pos)
			If Listeners.Size = 0 Then
				Dim SubName As String = M.getDefault("SubName","")
				If SubName.Contains("Listener") Then
					Try
						TJO.RunMethod("removeListener",Array(LT.Listener))
					Catch
						Log(LastException)
					End Try
				End If
			End If
			Return True
		End If
	End If
	Return False
End Sub
Public Sub RemoveAllChangeListeners(Module As Object, EventName As String)
	Dim M As Map = FindChangeListener(Module,EventName)
	Dim Listeners As List = M.get("List")
	If Listeners.IsInitialized Then
		Dim Pos As Int = M.get("Index")
		If Pos > -1 Then
			Dim LT As PO_ListenerType = Listeners.get(Pos)
			Try
				TJO.RunMethod("removeListener",Array(LT.Listener))
			Catch
				Log(LastException)
			End Try
		End If
	End If
	Listeners.clear
End Sub
