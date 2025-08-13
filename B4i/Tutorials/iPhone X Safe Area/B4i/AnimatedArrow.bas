B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'version 1.00
Sub Class_Globals
	Private xui As XUI
	Private base As B4XView
	Private cvs As B4XCanvas
	Public StrokeWidth As Float = 4dip
	Public StrokeColor As Int = 0xFFFFFA00
End Sub

Public Sub Initialize
	base = xui.CreatePanel("")
	base.SetLayoutAnimated(0, 0, 0, 400dip, 400dip)
	base.Enabled = False
	cvs.Initialize(base)
End Sub

Public Sub Show(Parent As B4XView, TargetX As Float, TargetY As Float, angle As Float, VisibleDuration As Int)
	angle = angle - 90
	Dim radius As Float = cvs.TargetRect.Width / 2
	Dim cx = (TargetX - radius * CosD(angle)), cy = (TargetY - radius * SinD(angle)) As Float
	Parent.AddView(base, cx - radius, cy - radius, radius * 2, radius * 2)
	TargetX = TargetX - (cx - radius)
	TargetY = TargetY - (cy - radius)
	cvs.ClearRect(cvs.TargetRect)
	DrawLineAnimated(300, 20, radius, radius, TargetX, TargetY, True)
	Dim ArrowHeadLen As Float = 40dip
	Dim ArrowAngle As Float = 30
	Sleep(250)
	DrawLineAnimated(300, 20, TargetX - SinD(90 - ArrowAngle - angle) * ArrowHeadLen , TargetY - CosD(90 - ArrowAngle - angle) * ArrowHeadLen, TargetX , TargetY,  False)
	DrawLineAnimated(300, 20, TargetX - CosD(angle - ArrowAngle) * ArrowHeadLen,TargetY - SinD(angle - ArrowAngle) * ArrowHeadLen, TargetX, TargetY, True)
	Sleep(300 + VisibleDuration)
	base.SetVisibleAnimated(100, False)
	Sleep(100)
	base.RemoveViewFromParent
	cvs.Release
End Sub

Public Sub DrawHouse (Parent As B4XView, TargetX As Float, TargetY As Float, VisibleDuration As Int)
	Parent.AddView(base, TargetX, TargetY, base.Width, base.Height)
	cvs.ClearRect(cvs.TargetRect)
	Dim duration As Int = 300
	DrawLineAnimated(duration, 20, 10dip, 100dip, 110dip, 100dip, True)
	Sleep(duration)
	DrawLineAnimated(duration, 20, 110dip, 100dip, 110dip, 200dip, True)
	Sleep(duration)
	DrawLineAnimated(duration, 20, 110dip, 200dip, 10dip, 200dip, True)
	Sleep(duration)
	DrawLineAnimated(duration, 20, 10dip, 200dip, 10dip, 100dip, True)
	Sleep(duration)
	DrawLineAnimated(duration, 20, 10dip, 100dip, 110dip, 200dip, False) 'It will be invalidated in the next line
	DrawLineAnimated(duration, 20, 110dip, 100dip, 10dip, 200dip, True)
	Sleep(duration)
	DrawLineAnimated(duration, 20, 10dip, 100dip, 60dip, 50dip, False)
	DrawLineAnimated(duration, 20, 110dip, 100dip, 60dip, 50dip, True)
	Sleep(duration)
	Sleep(VisibleDuration)
	base.SetVisibleAnimated(100, False)
	Sleep(100)
	base.RemoveViewFromParent
	cvs.Release
End Sub

Private Sub DrawLineAnimated(Duration As Int, Steps As Int, StartX As Float, StartY As Float, EndX As Float, EndY As Float, Invalidate As Boolean)
	#if DEBUG
	Steps = Steps / 2
	#End If
	Dim len As Float = Sqrt(Power(EndX - StartX, 2) + Power(EndY - StartY, 2)) / Steps
	Dim angle As Float = ATan2D(EndY - StartY, EndX - StartX)
	Dim x1, x2, y1, y2 As Float
	For i = 0 To Steps - 1
		x1 = StartX + len * i * CosD(angle)
		x2 = StartX + len * (i + 1) * CosD(angle)
		y1 = StartY + len * i * SinD(angle)
		y2 = StartY + len * (i + 1) * SinD(angle)
		cvs.DrawLine(x1, y1, x2, y2, StrokeColor, StrokeWidth)
		If Invalidate Then
			cvs.Invalidate
		End If
		Sleep(Duration / Steps)
	Next
End Sub

