B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	'4 points (X,Y)
	'Point 0 : always (0,0)
	'Point 1 and 2 (X,Y)
	'Point 3 : alwas (1,1)
	Private fXY(8) As Double 
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize As cCubicBezierCurve
	fXY=Array As Double(0.0,0.0,0.0,1.0,1.0,0.0,1.0,1.0)
	Return Me
End Sub

'return (x,Y) for points 1 and 2
public Sub gPoints As Double() 
	Return Array As Double(fXY(2),fXY(3),fXY(4),fXY(5))
End Sub

'set (X,Y) for points 1 and 2
public Sub sPoints(ax1 As Double,ay1 As Double,ax2 As Double,ay2 As Double) As cCubicBezierCurve
	fXY(2)=ax1
	fXY(3)=ay1
	fXY(4)=ax2
	fXY(5)=ay2
	Return Me
End Sub

public Sub calcY(at As Double) As Double
	Return drawSubCurve(fXY,at)
End Sub

private Sub drawSubCurve(axy() As Double,at As Double) As Double
	If axy.length=2 Then
		Return axy(1)
	Else
		Dim l(axy.Length-2) As Double
		Dim i As Int
		Dim x As Double
		Dim y As Double
		For i=0 To axy.Length/2-2
			x=(1-at)*axy(i*2)+at*axy((i+1)*2)
			y=(1-at)*axy(i*2+1)+at*axy((i+1)*2+1)
			l(i*2)=x
			l(i*2+1)=y
		Next
		Return drawSubCurve(l,at)
	End If
End Sub
