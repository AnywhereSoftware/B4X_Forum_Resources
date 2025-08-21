B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private xlbl As B4XView
	Private currentValue As Int
	Private tempValue As Int
	Public Text As String = "Score: "
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	xlbl = Lbl
	
	xlbl.SetTextAlignment("CENTER", "LEFT")
	mBase.AddView(xlbl, 0, 0, 0, 0)
	Base_Resize(mBase.Width, mBase.Height)
	setValue(0)
	
End Sub

Public Sub getBase As B4XView
	Return mBase
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
 	xlbl.SetLayoutAnimated(0, 0, 0, Width, Height)
End Sub

Public Sub setValue(NewValue As Int)
	currentValue = NewValue
End Sub

Public Sub getValue As Int
	Return currentValue
End Sub

Public Sub IncreaseScore (Delta As Int)
	setValue(currentValue + Delta)
End Sub

Public Sub SetValueNow (score As Int)
	currentValue = score
	tempValue = score
	xlbl.Text = $"${Text}$1.0{score}"$
End Sub

Public Sub Tick
	Dim dx As Int = currentValue - tempValue
	If dx <> 0 Then
		tempValue = tempValue + Ceil(dx / 5)
	End If
	xlbl.Text = $"${Text}$1.0{tempValue}"$
End Sub


