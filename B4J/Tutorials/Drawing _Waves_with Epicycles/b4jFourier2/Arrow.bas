B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Dim can As Canvas
End Sub

'Initializes the object. You can add parameters to this method if needed.
'c => the canvas to draw the arrow(s) on 
Public Sub Initialize(c As Canvas) As Arrow
	
	can = c
	Return Me
	
End Sub

'startx => starting x coordinate of the arrow line
'starty => starting y coordinate of the arrow line 
'endx => ending x coordinate of the arrow line
'endy => ending y coordinate of the arrow line 
'arrowAngle => the angle that each of the arrow legs should be relative to arrow line
'arrowLength => the length of the head of the arrow as a percentage of the arrow line length (eg 5 = 5%)
'col => the color of the arrow (line and head)
'thick => the thickness of the lines making up the arrow
public Sub drawArrow(startx As Double , starty As Double, endx As Double, endy As Double, arrowAngle As Double, arrowLength As Double, col As Paint, thick As Double) As Canvas
	
	arrowAngle = 2 * cPI * arrowAngle/360
	
	
	Dim lineLength As Double = Sqrt(Power(endx - startx,2) + Power(endy - starty, 2))
	arrowLength = lineLength * (arrowLength/100)

	Dim lineAngle As Double = ATan2(starty - endy, startx - endx)

	Dim x1 As Double = Cos(lineAngle + arrowAngle) * arrowLength + endx
	Dim y1 As Double = Sin(lineAngle + arrowAngle) * arrowLength + endy

	Dim x2 As Double = Cos(lineAngle - arrowAngle) * arrowLength + endx
	Dim y2 As Double = Sin(lineAngle - arrowAngle) * arrowLength + endy

	can.DrawLine(startx, starty, endx, endy, col, thick)
	can.DrawLine(endx, endy, x1, y1, col, thick)
	can.DrawLine(endx, endy, x2, y2, col, thick)
	
	Return can
	
End Sub