B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private fPane1 As B4XView
	Private fPane2 As B4XView
	Private fd As cFallingDown
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("B4XPage3")
	fd.Initialize(Root,1000,50)
	fd.add(fPane1,1000,50)
	fd.add(fPane2,1000,50)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Private Sub B4XPage_appear
	'run animation and wait for complete
	wait for (fd.run) complete (n As Int)
	Log(n & " B4XView - down")
End Sub

