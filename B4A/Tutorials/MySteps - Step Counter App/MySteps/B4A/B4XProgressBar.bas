B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.95
@EndOfDesignText@
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF757575, Description: 
#DesignerProperty: Key: ProgressColor, DisplayName: Progress Color, FieldType: Color, DefaultValue: 0xFF38B8FF, Description: 
#DesignerProperty: Key: Thickness, DisplayName: Thickness, FieldType: Int, DefaultValue: 5, Description: 
#DesignerProperty: Key: Orientation, DisplayName: List Orientation, FieldType: String, DefaultValue: Horizontal, List: Vertical|Horizontal 

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private bcolor, pcolor As Int
	Private thickness As Float
	Private cvs As B4XCanvas
	Private vertical As Boolean
	Private currentValue As Float
	Private DurationFromZeroTo100 As Int = 500
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	bcolor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	pcolor = xui.PaintOrColorToColor(Props.Get("ProgressColor"))
	thickness = DipToCurrent(Props.Get("Thickness"))
	vertical = Props.Get("Orientation") = "Vertical"
	cvs.Initialize(mBase)
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	cvs.Resize(Width, Height)
	AnimateValueTo(currentValue)
End Sub

Public Sub getProgress As Float
	Return currentValue
End Sub

Public Sub setProgress(v As Float)
	AnimateValueTo(v)
End Sub

Private Sub AnimateValueTo(NewValue As Float)
	Dim n As Long = DateTime.Now
	Dim duration As Int = Abs(currentValue - NewValue) / 100 * DurationFromZeroTo100 + 1000
	Dim start As Float = currentValue
	currentValue = NewValue
	Dim tempValue As Float
	Do While DateTime.Now < n + duration
		tempValue = ValueFromTimeEaseInOut(DateTime.Now - n, start, NewValue - start, duration)
		DrawValue(tempValue)
		Sleep(10)
		If NewValue <> currentValue Then Return 'will happen if another update has started
	Loop
	DrawValue(currentValue)
End Sub

'quartic easing in/out from http://gizma.com/easing/
Private Sub ValueFromTimeEaseInOut(Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time = Time / (Duration / 2)
	If Time < 1 Then
		Return ChangeInValue / 2 * Time * Time * Time * Time + Start
	Else
		Time = Time - 2
		Return -ChangeInValue / 2 * (Time * Time * Time * Time - 2) + Start
	End If
End Sub

Private Sub DrawValue(Value As Float)
	cvs.ClearRect(cvs.TargetRect)
	If vertical Then
		cvs.DrawLine(cvs.TargetRect.CenterX, 0, cvs.TargetRect.CenterX, cvs.TargetRect.Bottom, bcolor, thickness)
		cvs.DrawLine(cvs.TargetRect.CenterX, 0, cvs.TargetRect.CenterX,  Value / 100 * cvs.TargetRect.Bottom, pcolor, thickness)
	Else
		cvs.DrawLine(0, cvs.TargetRect.CenterY, cvs.TargetRect.Right, cvs.TargetRect.CenterY, bcolor, thickness)
		cvs.DrawLine(0, cvs.TargetRect.CenterY, Value / 100 * cvs.TargetRect.Right, cvs.TargetRect.CenterY, pcolor, thickness)
	End If
	cvs.Invalidate
End Sub