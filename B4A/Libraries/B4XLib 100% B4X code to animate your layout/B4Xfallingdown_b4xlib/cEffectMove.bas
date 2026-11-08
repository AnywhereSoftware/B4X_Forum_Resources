B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private fx1 As Double
	Private fY1 As Double
	Private fX2 As Double
	Private fY2 As Double
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ax1 As Double,ay1 As Double,ax2 As Double,ay2 As Double) As cEffectMove
	fx1=ax1
	fY1=ay1
	fX2=ax2
	fY2=ay2
	Return Me
End Sub

public Sub do_Step(aB4XView As B4XView,apercent As Double) As cEffectMove
	aB4XView.Left=(fX2-fx1)*apercent+fx1
	aB4XView.top=(fY2-fY1)*apercent+fY1
	Return Me
End Sub