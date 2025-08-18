B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4.4
@EndOfDesignText@
'Code module

Sub Process_Globals

End Sub

Public Sub CreatePoint(X As Float, Y As Float) As Point
	Dim aPoint As Point
	aPoint.Initialize(X,Y)
	Return aPoint
End Sub
 
Public Sub CreateVector(Dx As Float,Dy As Float) As Vector
	Dim aVector As Vector
	aVector.Initialize(Dx,Dy)
	Return aVector
End Sub

Public Sub CreateSize(Width As Float, Height As Float) As Size
	Dim aSize As Size
	aSize.Initialize(Width,Height)
	Return aSize
End Sub

Public Sub distance(x1 As Float, x2 As Float, y1 As Float, y2 As Float) As Double
    Return Sqrt(Power(x2-x1,2)+Power(y2-y1,2)) 'simple distance calculation
End Sub

Public Sub distancewonder(x1 As Float, x2 As Float, y1 As Float, y2 As Float) As Double
    Dim dX = x2 - x1 As Double
    Dim dY = y2 - y1 As Double       
    Return Sqrt((dX * dX) + (dY * dY)) 'simple distance calculation
End Sub

Public Sub CalcAngleBetween2Lines(x11 As Double, y11 As Double, x12 As Double, y12 As Double, x21 As Double, y21 As Double, x22 As Double, y22 As Double, Degree As Boolean, Mode360 As Boolean) As Double
    Private Angle As Double
   
    If Mode360 = True Then
        Angle = ATan2D(y22 - y21, x22 - x21) - ATan2D(y12 - y11, x12 - x11)
        If Angle < 0 Then
            Angle = 360 + Angle
        End If
    Else
        Angle = Abs((ATan2D(y12 - y11, x12 - x11) - ATan2D(y22 - y21, x22 - x21)))
        If Angle > 180 Then
            Angle = 360 - Angle
        End If
    End If
	
    If Degree = True Then
        Return Angle
    Else
        Return Angle*cPI / 180
    End If
End Sub