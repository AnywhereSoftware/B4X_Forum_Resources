B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3.5
@EndOfDesignText@
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	Private vX1 As Byte
	Private vY1 As Byte
	'Private vX2 As Byte
	Private vY2 As Byte
	Private vWidth As Byte
	Private vHeight As Byte
	Private vLastValue As Double
	Private vResolution As Double
	Private CurrentY As Int
End Sub
Public Sub Draw(X1 As Byte, Y1 As Byte, X2 As Byte, Y2 As Byte,MaxVal As Double,Val As Double)
	SSD.DrawRect(X1 , Y1 , X2 , Y2 )
	vX1 = X1
	vY1 = Y1 + 1
	'vX2 = X2
	vY2 = Y2 - 1
	vWidth = X2 - X1
	vHeight = Y2 - Y1
	vResolution = vHeight / MaxVal
	'CurrentY = vY1
	vLastValue = 0
	Reset
	If Val <= 0 Then Return
	If Val > MaxVal Then Val = MaxVal
	Dim NewVal As Double  = Val - vLastValue
	Dim NumLines As Double =  NewVal * vResolution
	Dim FullScale As Double = MaxVal * vResolution
	CurrentY = vY1 +(FullScale - NumLines) + 1' get offset
	Dim EndL As Int = (CurrentY + NumLines)
	If EndL > vY2 Then EndL = vY2
	DrawLines(EndL)
	vLastValue = Val
End Sub

private Sub DrawLines(EndL As Int)
	For Ru =  CurrentY To EndL 
		SSD.Drawhline(vX1+2,Ru,vWidth-3)
	Next
End Sub

private Sub Reset()
	For Rr = vY1 To vY2 
		SSD.ClearHline(vX1+2,Rr,vWidth-3)
	Next
End Sub

Public Sub GetValue() As Double
	Return vLastValue
End Sub

Public Sub GetResolution () As Double
	Return vResolution
End Sub
