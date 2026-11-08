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
	Private fList As List
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(AContainer As B4XView,aduration As Int,adelay As Int) As cFallingDown
	fList.Initialize
	add(AContainer,aduration,adelay)
	Return Me
End Sub

public Sub add(AContainer As B4XView,aduration As Int,adelay As Int) As cFallingDown
	Dim g As cGroup
	g.Initialize(AContainer,aduration,adelay)
	fList.Add(g)
	Return Me
End Sub

public Sub run As ResumableSub
	Dim status(1) As Int
	For Each g As cGroup In fList
		g.run(status)
	Next
	Do While status(0)<fList.size
		Sleep(1)
	Loop
	Dim n As Int=0
	For Each g As cGroup In fList
		n=n+g.gNumberOfViews
	Next
	Return n
End Sub