B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	B4XPages.SetTitle(Me, "")
	For i = 1 To 10
		If Main.ActionBarHeight = 0 Then
			Sleep(50)
		Else
			Exit
		End If
	Next
	If Main.ActionBarHeight = 0 Then Main.ActionBarHeight = 60dip
	Root.Parent.Height = 100%y + Main.ActionBarHeight
	Root.Height = Root.Parent.Height
	Root.LoadLayout("SecondPage")
End Sub

Private Sub B4XPage_appear
	Dim jo As JavaObject = B4XPages.GetManager.ActionBar
    jo.RunMethod("hide",Null)   
	Root.Parent.Height = 100%y + Main.ActionBarHeight
End Sub

Private Sub Button1_Click
	B4XPages.ClosePage(Me)
End Sub