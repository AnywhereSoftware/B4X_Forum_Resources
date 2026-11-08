B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	
	Private fx As JFX
	Dim rx, ry As Double
	Dim vx, vy As Double
	Dim radius As Double
	Dim cv As Canvas
	Dim col As Paint
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (cv1 As Canvas, col1 As Paint)
	
	col = col1
	cv = cv1
	rx = cv.Width/2
	ry = cv.Height/2
	vx = Rnd(-10, 11)
	vy = Rnd(-15, 16)
	radius = Rnd(10, 21)
	
End Sub

'bounce of vertical wall by reflecting x-velocity
Private Sub bounceOffVerticalWall()
	
	vx = -vx
	
End Sub

'bounce of horizontal wall by reflecting y-velocity
Private Sub bounceOffHorizontalWall()
	
	vy = -vy
	
End Sub

'move the ball one Step
Public Sub move
	
'	Dim damp As Double = 0.99      'was 0.99
'	Dim friction As Double = 0.97   'was 0.97
'	Dim gravity As Double = 0.01
'	vx = vx * damp
'	vy = vy * damp
'	vy = vy + gravity
'	If ((rx + vx * friction) + radius > cv.Width) Then vx = -1 * vx
'	If ((rx + vx * friction) - radius < 0) Then vx = -1 * vx
'	If ((ry + vy * friction) + radius > cv.Height) Then vy = -1 * vy
'	If ((ry + vy * friction) - radius < 0) Then vy = -1 * vy
'	rx = rx + vx * friction
'	ry = ry + vy * friction
	
	If ((rx + vx) + radius > cv.Width) Then bounceOffVerticalWall
	If ((rx + vx) - radius < cv.Left) Then bounceOffVerticalWall
	If ((ry + vy) + radius > cv.Height) Then bounceOffHorizontalWall
	If ((ry + vy) - radius < cv.Top) Then bounceOffHorizontalWall
	rx = rx + vx
	ry = ry + vy
End Sub

'draw the ball
Public Sub draw As Canvas

	cv.DrawCircle(rx, ry, radius, col, True, 1dip)
	Return cv
	
End Sub
