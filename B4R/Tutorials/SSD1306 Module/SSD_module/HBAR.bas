B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3.5
@EndOfDesignText@


Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
Private hX1 As Byte
Private hY1 As Byte
Private hX2 As Byte
'Private hY2 As Byte
Private hWidth As Byte
Private hHeight As Byte
Private hLastValue As Double
Private hResolution As Double
Private CurrentX As Int
End Sub

Public Sub Draw(X1 As Byte, Y1 As Byte, X2 As Byte,Y2 As Byte,MaxVal As Double,Val As Double)
	SSD.DrawRect(X1 , Y1 , X2 , Y2 )
	hX1 = X1 + 1
	hY1 = Y1
	hX2 = X2 - 1
	'hY2 = Y2
	hWidth = X2 - X1
	hHeight = Y2 - Y1
	hResolution = hWidth / MaxVal
	CurrentX = hX1
	hLastValue = 0
	Reset
	If Val <= 0 Then Return
	If Val > MaxVal Then Val = MaxVal
	Dim NewVal As Double  = Val - hLastValue
	Dim NumLines As Double =  NewVal * hResolution
	Dim EndL As Int = (CurrentX + NumLines) -1
	If EndL > hX2 Then EndL = X2
	DrawLines(EndL)
	hLastValue = Val
End Sub

private Sub DrawLines(EndL As Int)
	For Cu = CurrentX To EndL
		SSD.DrawVline(Cu,hY1+2,hHeight-3)
	Next
End Sub

private Sub Reset()
	For Cr = hX1 To hX2 
		SSD.ClearVline(Cr,hY1+2,hHeight-3)
	Next
End Sub

Public Sub GetValue() As Double
	Return hLastValue
End Sub

Public Sub GetResolution () As Double
	Return hResolution
End Sub