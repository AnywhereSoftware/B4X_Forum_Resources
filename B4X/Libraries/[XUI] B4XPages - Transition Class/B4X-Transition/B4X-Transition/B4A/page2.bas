B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
Sub Class_Globals
	Public Root As B4XView 'ignore
	Private xui As XUI 'ignore
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root1.LoadLayout("page2")
End Sub

Public Sub loadpageinadvance
	'we call this sub to reload data here and make the transition with the correct loading layout
	Root.Color = xui.Color_RGB(Rnd(0,255),Rnd(0,255),Rnd(0,255))
	'...
End Sub

Private Sub btn1_Click
	B4x_Transition.PrepareTransition_CloseDoor(xui, Root.Width, Root.Height, Root, B4XPages.GetPage("mainpage").As(B4XMainPage).Root)
	B4XPages.ShowPageAndRemovePreviousPages("mainpage")
End Sub