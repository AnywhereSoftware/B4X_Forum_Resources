B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11
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
	Root.LoadLayout("laypagSomething")
End Sub

Private Sub B4XPage_Appear
	B4XPages.MainPage.CheckInternet.ParentView = Root
	Wait For (B4XPages.MainPage.CheckInternet.Check(True)) Complete(Result As Boolean)
	
	Dim Toast As BCToast
	Dim Msg As String = "Internet enabled = " & Result
	Toast.Initialize(Root)
	Toast.Show(Msg)
End Sub
