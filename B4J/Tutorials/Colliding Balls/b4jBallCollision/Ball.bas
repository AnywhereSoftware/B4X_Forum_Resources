B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	
	Private fx As JFX
	Dim x, y As Double 'collision.Ball's center x and y
	Dim speedX, speedY As Double 'collision.Ball's speed per step in x and y
	Dim radius As Double 'collision.Ball's radius
	Dim color As Paint 'collision.Ball's color
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(x1 As Double, y1 As Double, radius1 As Double, speed1 As Double, angleInDegree1 As Double, color1 As Paint) As Ball

	x = x1
	y = y1
	speedX = speed1  * Cos(2 * cPI* angleInDegree1/360)
	speedY = -speed1 * Sin(2 * cPI* angleInDegree1/360)
	radius = radius1
	color = color1
	
	Return Me
	
End Sub

Public Sub update(incr As Double)
	
    x = x + speedX * incr
    y = y + speedY * incr
End Sub

'Draw itself on the canvas
Public Sub draw(cv As CanvasExt) As CanvasExt
 
    cv.DrawOval((x - radius).As(Int), (y - radius).As(Int), (2 * radius).As(Int), (2 * radius).As(Int), color, True, 2dip)
	Return cv
	
End Sub

'Return mass
Public Sub getMass As Double
	
    Return 2 * radius * radius * radius / 1000.0f
	
End Sub

