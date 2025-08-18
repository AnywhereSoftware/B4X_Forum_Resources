B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=8.5
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: true
	#IncludeTitle: false
	'Set Viewer activity to unspecified in the Manifest to allow rotation
	'SetActivityAttribute(Viewer, android:screenOrientation, "unspecified")
#End Region


Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim viewx As Int
	Dim viewy As Int
	Dim imagex As Int
	Dim imagey As Int

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Dim ScaleImageView1 As ScaleImageView	
	Private Panel1 As Panel
	Private gestures As GestureDetector
	Private TouchDown As Boolean = False

End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("Viewer")
	'ScaleImageView1.Initialize("ScaleImageView1")
	'Activity.AddView(ScaleImageView1,0,0,100%x,100%y)
	'ScaleImageView1.PanLimit = ScaleImageView1.PAN_LIMIT_CENTER
	gestures.SetOnGestureListener(Panel1, "Panel1")
End Sub

Sub Activity_Resume	
	ScaleImageView1.BringToFront
	ScaleImageView1.DoubleTapZoomDuration = 250
	ScaleImageView1.Orientation = ScaleImageView1.ORIENTATION_USE_EXIF
	ScaleImageView1.ImageFile = Starter.ViewerFolder & Starter.ViewerFilename
	Dim loops As Int = 1
	Do Until ScaleImageView1.IsReady
		Sleep(100)
		loops = loops + 1
		If loops > 100 Then ' give it up to 10 seconds
			Exit
		End If		
	Loop
	' restore scale and centre location
	ScaleImageView1.SetScaleAndCenter(Starter.ViewerZoom,Starter.ViewerX, Starter.ViewerY, 1)
	 ' restore circle location
	ScaleImageView1.CircleX = Starter.CircleX
	ScaleImageView1.CircleY = Starter.CircleY
	Private TouchDown As Boolean = False
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	' save scale
	Starter.ViewerZoom = ScaleImageView1.Scale
	' save circle location 
	Starter.CircleX = ScaleImageView1.CircleX 
	Starter.CircleY = ScaleImageView1.CircleY	
	 ' save present centre as factors 0 to 1
	Try
		Starter.ViewerX = ScaleImageView1.CenterX / ScaleImageView1.SrcWidth
		Starter.ViewerY = ScaleImageView1.CenterY / ScaleImageView1.SrcHeight
	Catch
		LogColor("Error in Pause: " & LastException.Message, Colors.Red)
	End Try
End Sub

Sub ScaleImageView1_Click 'The user has tapped on the view. Use ClickImage or ClickView for the coordinates.
	Dim siv As ScaleImageView = Sender
	' Save the view and image coordinates of the point clicked.
	viewx =  siv.ClickViewX
	viewy =  siv.ClickViewY
	imagex =  siv.ClickImageX
	imagey =  siv.ClickImageY
	siv.Invalidate ' draw the new position
	Dim msg As String = "Short: X=" & viewx & " Y=" & viewy
	ToastMessageShow(msg, False)
End Sub

Sub ScaleImageView1_LongClick 'The user has long pressed the view. Use ClickImage or ClickView for the coordinates.
	Dim siv As ScaleImageView = Sender
	' Save the view and image coordinates of the point clicked.
	viewx = siv.ClickViewX
	viewy = siv.ClickViewY
	imagex =  siv.ClickImageX
	imagey =  siv.ClickImageY 
	Dim msg As String = "Long: X=" & imagex & " Y=" & imagey
	' move the circle to the selected location
	siv.CircleXPixels = imagex
	siv.CircleYPixels = imagey
	siv.Invalidate ' draw the new position
	ToastMessageShow(msg, False)	
	Panel1.BringToFront
	ToastMessageShow("Panel on", False)

End Sub

Sub ScaleImageView1_OnDraw(viewcanvas As Canvas) 'The view is being redrawn. Use viewcanvas to draw on it.
	Dim siv As ScaleImageView = Sender
	'Log("SIV_OnDraw: " & siv.CenterX)
	'Return
	' Find the pixel values for the present circle
	Dim x As Float = siv.CircleX * siv.SrcWidth
	Dim y As Float = siv.CircleY * siv.SrcHeight
	' Convert them to view pixel values
	Dim viewxy() As Float = siv.SourceXYtoViewXY(x, y)
	Dim radius As Float = siv.CircleDrawnRadius
	' Draw text that doesn't scale with the map to the right of the present circle
	Dim tx As Float = viewxy(0) + radius*1.2
	Dim ty As Float = viewxy(1)
	viewcanvas.DrawText("Some Text", tx , ty, Typeface.DEFAULT, 20, Colors.Black, "LEFT")
	'Draw a circle and crosshair that scales with the map at the last Click or LongClick position
	viewxy = siv.SourceXYtoViewXY(imagex, imagey )
	viewcanvas.DrawLine(viewxy(0) - radius, viewxy(1), viewxy(0) + radius, viewxy(1), Colors.Black, siv.CircleWidth*radius/2)
	viewcanvas.DrawLine(viewxy(0), viewxy(1) - radius, viewxy(0), viewxy(1) + radius, Colors.Black, siv.CircleWidth*radius/2)
	viewcanvas.DrawCircle(viewxy(0), viewxy(1), radius, Colors.Red, False, siv.CircleWidth*radius)
End Sub



'Sub Panel1_Click
'	ToastMessageShow("Panel click", False)
'End Sub
'
'Sub Panel1_LongClick
'	Panel1.SendToBack
'	ToastMessageShow("Panel off", False)
'End Sub

' Action Down = 0, Up = 1, Move = 2, cancel = 3
Sub Panel1_onDoubleTap(X As Float, Y As Float, MotionEvent As Object)
	Log("Panel1_onDoubleTap " & gestures.getAction(MotionEvent) & " : " & X & ", " & Y)
End Sub

Sub Panel1_onDown(X As Float, Y As Float, MotionEvent As Object)
	TouchDown = True
	Log("***************************")
	Log("Panel1_onDown " & gestures.getAction(MotionEvent) & " : " & X & ", " & Y)
End Sub

Sub Panel1_onDrag(deltaX As Float, deltaY As Float, MotionEvent As Object)
	If deltaX = 0 And deltaY = 0 Then Return
	Log("Panel1_onDrag " & gestures.getAction(MotionEvent) & " : " & deltaX & ", " & deltaY)	
End Sub

Sub Panel1_onLongPress(X As Float, Y As Float, MotionEvent As Object)
	Log("Panel1_onLongPress " & gestures.getAction(MotionEvent) & " : " & X & ", " & Y)	
	ScaleImageView1.BringToFront
End Sub

Sub Panel1_onPinchClose(NewDistance As Float, PreviousDistance As Float, MotionEvent As Object)
	Log("Panel1_onPinchClose " & gestures.getAction(MotionEvent) & " : " & NewDistance & ", " & PreviousDistance)	
End Sub

Sub Panel1_onPinchOpen(NewDistance As Float, PreviousDistance As Float, MotionEvent As Object)
	Log("Panel1_onPinchOpen " & gestures.getAction(MotionEvent) & " : " & NewDistance & ", " & PreviousDistance)	
End Sub

Sub Panel1_onRotation(Degrees As Double, MotionEvent As Object)
	Log("Panel1_onRotation " & gestures.getAction(MotionEvent) & " : " & Degrees)	
End Sub

Sub Panel1_onScroll(distanceX As Float, distanceY As Float, MotionEvent1 As Object, MotionEvent2 As Object)
	Log("Panel1_onScroll " & gestures.getAction(MotionEvent1) & " " & gestures.getAction(MotionEvent2) & " : " & distanceX &  ", " & distanceY)
End Sub

Sub Panel1_onShowPress(X As Float, Y As Float, MotionEvent As Object)
	Log("Panel1_onShowPress " & gestures.getAction(MotionEvent) & " : " & X & ", " & Y)
End Sub

Sub Panel1_onSingleTapConfirmed(X As Float, Y As Float, MotionEvent As Object)
	Log("Panel1_onSingleTapConfirmed " & gestures.getAction(MotionEvent) & " : " & X & ", " & Y)
End Sub

Sub Panel1_onTouch(Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	If Action = gestures.ACTION_UP Then
		TouchDown = False
		Log("------------------------------------")
	End If
	Return True
End Sub
