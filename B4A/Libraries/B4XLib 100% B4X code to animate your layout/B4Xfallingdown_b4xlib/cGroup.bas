B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private fContainer As B4XView
	Private fAnimates As List
	Private fNumberOfViews As Int
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(AContainer As B4XView,aduration As Int,adelay As Int) As cGroup
	fContainer=AContainer
	fAnimates.Initialize
	Dim v As B4XView
	Dim y As Double
	fNumberOfViews=fContainer.NumberOfViews
	For i=0 To fNumberOfViews-1
		v=fContainer.GetView(i)
		y=v.Top
		v.Top=v.Height
		Dim a As cAnimate
		a.Initialize(v).delay(i*adelay).effectmove(v.left,-v.Height,v.left,y).progressCustom(0.9,1.5,1,1.5).duration(aduration)
		fAnimates.Add(a)
	Next
	Return Me
End Sub

public Sub run(astatus() As Int) As ResumableSub
	Dim status(1) As Int
	For Each a As cAnimate In fAnimates
		a.run(status)
	Next
	Do While status(0)<fNumberOfViews
		Sleep(1)
	Loop
	astatus(0)=astatus(0)+1
End Sub

public Sub gNumberOfViews As Int
	Return fNumberOfViews
End Sub