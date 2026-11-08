B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private fB4XView As B4XView
	Private fDuration As Int
	Private fDelay As Int=0
	Private fprogress As cCubicBezierCurve
	Private fstartTime As Long
	Private fEffect As Object
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(aB4XView As B4XView)  As cAnimate
	fDuration=1000
	fprogress.Initialize.spoints(0,0,1,1)
	fB4XView=aB4XView
	Return Me
End Sub

public Sub effectMove(ax1 As Double,ay1 As Double,ax2 As Double,ay2 As Double) As cAnimate
	Dim e As cEffectMove
	e.Initialize(ax1,ay1,ax2,ay2)
	fEffect=e
	Return Me
End Sub

public Sub progressEaseInOut As cAnimate
	fprogress.spoints(0.42,0,0.58,1)
	Return Me
End Sub

public Sub progressCustom(ax1 As Double,ay1 As Double,ax2 As Double,ay2 As Double) As cAnimate
	fprogress.spoints(ax1,ay1,ax2,ay2)
	Return Me
End Sub

public Sub duration(aduration As Int) As cAnimate
	fDuration=aduration	
	Return Me
End Sub

public Sub delay(adelay As Int) As cAnimate
	fDelay=adelay	
	Return Me
End Sub

public Sub run(astatus() As Int)
	Dim p As Double=0
	Dim e As Long
	Dim y As Double
	fstartTime=DateTime.now
	Do While p<1
		e=DateTime.Now-fstartTime-fDelay
		If e>0 Then
			p=Min((DateTime.Now-fstartTime-fDelay)/fDuration,1)
			y=fprogress.calcY(p)
			CallSub3(fEffect,"do_step",fB4XView,y)
		End If
		Sleep(10)
	Loop
	astatus(0)=astatus(0)+1
End Sub