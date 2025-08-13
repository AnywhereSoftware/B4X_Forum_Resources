B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.86
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private lblHello As B4XView
	Private ImageView1 As B4XView
	Private Page3 As B4XPage3
	#if B4A
	Private Model As Map
	#end if
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

Public Sub SetImage(Value As Object)
	Model.Put("Bitmap", Value)
	ImageView1.SetBitmap(Value)
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("Page2")
	Page3 = B4XPages.GetPage("Page 3")
	#if B4A
	Model = ViewModelProvider.Get

	If Model.ContainsKey("Bitmap") Then
		ImageView1.SetBitmap(Model.Get("Bitmap"))
	End If
	#end if
End Sub

Private Sub B4XPage_Appear
	lblHello.Text = $"Hello ${B4XPages.MainPage.txtUser.Text}!"$
End Sub
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub btnDraw_Click
	B4XPages.ShowPage("Page 3")
End Sub

Sub btnSignOut_Click
	B4XPages.MainPage.txtUser.Text = ""
	Page3.ClearImage
	SetImage(Null)
	B4XPages.ShowPageAndRemovePreviousPages("MainPage")	
End Sub
