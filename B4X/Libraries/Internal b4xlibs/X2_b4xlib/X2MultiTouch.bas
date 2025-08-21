B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
Sub Class_Globals
	Type X2Touch (X As Float, Y As Float, DownX As Float, DownY As Float, Handled As Boolean, FingerUp As Boolean, EventCounter As Int, PointerId As Object)
	Public Keys As B4XSet
	Private ViewsFingers As Map
	#if B4J
	Private gmh As GameViewHelper
	#Else If B4A
	Private gd As Gestures
	#Else If B4i
	Dim NativeMe As NativeObject
	#end if
End Sub

'Initialies the object.
'Page - The B4XPages that hosts the game.
'TouchPanels - One or more panels that will be tracked. Note that in B4i all panels will be tracked automatically (thouch mutlitouch will only be enabled on the passed panels).
Public Sub Initialize (Page As Object, TouchPanels As List)
	Keys.Initialize
	ViewsFingers.Initialize
	#if B4A
	If TouchPanels.IsInitialized Then
		For Each v As B4XView In TouchPanels
			gd.SetOnTouchListener(v, "Gestures_Touch")
		Next
	End If
	#else if B4J
	gmh.AddKeyListener("gmh", B4XPages.GetNativeParent(Page))
	#Else If B4i
	NativeMe = Me
	If TouchPanels.IsInitialized Then
		For Each v As B4XView In TouchPanels
			Dim no As NativeObject = v
			no.SetField("multipleTouchEnabled", True)
		Next
	End If
	#end if
End Sub

'Resets the state. Prevents cases where a key was held while the app moved to the background for example.
Public Sub ResetState
	Keys.Clear
	ViewsFingers.Clear	
End Sub

'Gets a list with the current touches. It will include touches with FingerUp = True. Such touches will be cleared after this call.
'The EventCounter field of each touch will be incremented by 1. With this field you can treat the "down" event differently (the value will be 0).
Public Sub GetTouches (Panel As B4XView) As List
	Dim Res As List
	Res.Initialize
	If ViewsFingers.ContainsKey(Panel) = False Then
		Return Res
	End If
	Dim fingers As Map = ViewsFingers.Get(Panel)
	For Each touch As X2Touch In fingers.Values
		Res.Add(touch)
	Next
	For Each touch As X2Touch In Res
		If touch.FingerUp Then fingers.Remove(touch.PointerId)
		touch.EventCounter = touch.EventCounter + 1
	Next
	Return Res
End Sub
'Same as GetTouches. Returns a single touch or an uninitialized touch if there are none.
Public Sub GetSingleTouch(Panel As B4XView) As X2Touch
	Dim t As List = GetTouches(Panel)
	If t.Size > 0 Then Return t.Get(0)
	Dim touch As X2Touch
	Return touch
End Sub

'Should be called like this:<code>
'#If B4i
'Private Sub Panel_Multitouch (Stage As Int, Data As Object)
'	MultiTouch.B4iDelegateMultitouchEvent(Sender, Stage, Data)
'End Sub
'#End If</code>
Public Sub B4iDelegateMultitouchEvent(pnl As B4XView, Action As Int, Data As Object)
	#if B4i
	If ViewsFingers.ContainsKey(pnl) = False Then
		ViewsFingers.Put(pnl, CreateMap())
	End If
	Dim fingers As Map = ViewsFingers.Get(pnl)
	Dim list As List = Data
	For Each t As NativeObject In list
		Dim point As List = NativeMe.RunMethod("UITouchToPoint::", Array(t, pnl))
		Select Action
			Case 0 'down
				fingers.Put(t, CreateX2Touch(point.Get(0), point.Get(1), t))
			Case 1, 2 'move, up
				If fingers.ContainsKey(t) Then
					Dim touch As X2Touch = fingers.Get(t)
					touch.X = point.Get(0)
					touch.Y = point.Get(1)
					touch.FingerUp = Action = 2
				End If
		End Select
	Next
	#end if
End Sub
'Should be called like this:<code>
'#If B4J
'Private Sub Panel_Touch (Action As Int, X As Float, Y As Float)
'	MultiTouch.B4JDelegateTouchEvent(Sender, Action, X, Y)
'End Sub
'#End If</code>
Public Sub B4JDelegateTouchEvent (pnl As B4XView, Action As Int, X As Float, Y As Float)
	#if B4J
	If ViewsFingers.ContainsKey(pnl) = False Then
		ViewsFingers.Put(pnl, CreateMap())
	End If
	Dim fingers As Map = ViewsFingers.Get(pnl)
	Dim pointerid As Int = 0
	Select Action
		Case pnl.TOUCH_ACTION_DOWN
			fingers.Put(pointerid, CreateX2Touch(X, Y, pointerid))
		Case pnl.TOUCH_ACTION_MOVE, pnl.TOUCH_ACTION_UP
			If fingers.ContainsKey(pointerid) Then
				Dim touch As X2Touch = fingers.Get(pointerid)
				touch.X = X
				touch.Y = Y
				touch.FingerUp = Action = pnl.TOUCH_ACTION_UP
			End If
	End Select
	#end if
End Sub

#if B4J
Private Sub gmh_KeyPressed (KeyCode As String) As Boolean
	Keys.Add(KeyCode)
	Return True
End Sub

Private Sub gmh_KeyReleased (KeyCode As String) As Boolean
	Keys.Remove(KeyCode)
	Return True
End Sub
#else if B4A

Private Sub Gestures_Touch(View As Object, PointerID As Int, Action As Int, X As Float, Y As Float) As Boolean
	Dim pnl As B4XView = Sender
	If ViewsFingers.ContainsKey(pnl) = False Then
		ViewsFingers.Put(pnl, CreateMap())
	End If
	Dim fingers As Map = ViewsFingers.Get(pnl)
	Select Action
		Case gd.ACTION_DOWN, gd.ACTION_POINTER_DOWN
			'New Point is assigned to the new touch
			NewPointerId = PointerID
			fingers.Put(PointerID, CreateX2Touch(X, Y, PointerID))
		Case gd.ACTION_POINTER_UP, gd.ACTION_UP
			If fingers.ContainsKey(PointerID) Then
				Dim touch As X2Touch = fingers.Get(PointerID)
				touch.FingerUp = True
			End If
	End Select
	For Each id As Int In fingers.Keys
		Dim touch As X2Touch = fingers.Get(id)
		touch.X = gd.GetX(id)
		touch.Y = gd.GetY(id)
	Next
	Return True
End Sub
#end if

Private Sub CreateX2Touch (X As Float, Y As Float, pid As Object) As X2Touch 'ignore
	Dim t1 As X2Touch
	t1.Initialize
	t1.X = X
	t1.Y = Y
	t1.DownX = X
	t1.DownY = y
	t1.PointerId = pid
	t1.EventCounter = -1
	Return t1
End Sub


#if OBJC
- (NSArray*)UITouchToPoint:(UITouch*)t :(UIView*)view {
	CGPoint p = [t locationInView:view];
	return @[@(p.x), @(p.y)];
}
@end

@implementation B4IPanelView (override)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [B4IObjectWrapper raiseEvent:self :@"_multitouch::" :@[@(0), [touches allObjects]]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
     [B4IObjectWrapper raiseEvent:self :@"_multitouch::" :@[@(1), [touches allObjects]]];
   
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	   [B4IObjectWrapper raiseEvent:self :@"_multitouch::" :@[@(2), [touches allObjects]]];
}

#End If
