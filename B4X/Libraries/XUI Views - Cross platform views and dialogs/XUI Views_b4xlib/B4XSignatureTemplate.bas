B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.98
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public mBase As B4XView
	Private cvs As B4XCanvas
	Private LastX, LastY As Float
	Public StrokeWidth As Float = 2dip
	Public StrokeColor As Int = xui.Color_Black
	Public TextColor As Int = 0xFFFF8800
	Public BackgroundColor As Int = xui.Color_White
	Public AddDateAndTime As Boolean = True
	Public TextFont As B4XFont
	Public NumberOfPoints As Int
End Sub

Public Sub Initialize
	mBase = xui.CreatePanel("mBase")
	mBase.SetLayoutAnimated(0, 0, 0, 300dip, 200dip)
	cvs.Initialize(mBase)
	TextFont = xui.CreateDefaultFont(14)
End Sub

Public Sub Resize(Width As Int, Height As Int)
	mBase.SetLayoutAnimated(0, 0, 0, Width, Height)
	cvs.Resize(Width, Height)
End Sub


Public Sub GetPanel (Dialog As B4XDialog) As B4XView
	Return mBase
End Sub

Private Sub Show (Dialog As B4XDialog) 'ignore
	cvs.DrawRect(cvs.TargetRect, BackgroundColor, True, 0)
	cvs.Invalidate
	NumberOfPoints = 0
End Sub

Private Sub mBase_Touch (Action As Int, X As Float, Y As Float)
	Select Action
		Case mBase.TOUCH_ACTION_DOWN
			LastX = X
			LastY = Y
		Case mBase.TOUCH_ACTION_MOVE
			cvs.DrawLine(LastX, LastY, X, Y, StrokeColor, StrokeWidth)
			LastX = X
			LastY = Y
			cvs.Invalidate
			NumberOfPoints = NumberOfPoints + 1
	End Select
End Sub

Public Sub getBitmap As B4XBitmap
	Return cvs.CreateBitmap
End Sub

Private Sub DialogClosed (Result As Int)
	If Result = xui.DialogResponse_Positive And AddDateAndTime Then
		Dim r As B4XRect = cvs.MeasureText("M", TextFont)
		Dim Baseline As Int = cvs.TargetRect.Bottom - r.Height - r.Top - 2dip
		cvs.DrawText($"$DateTime{DateTime.Now}"$, 2dip, Baseline, TextFont, TextColor, "LEFT")
	End If
End Sub