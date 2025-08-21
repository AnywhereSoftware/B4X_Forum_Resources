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
	
	Dim Drawer As B4XDrawer
	Private btnDrawer As Button
	Private lviewDrawer As ListView
	Private pnlDrawer As Panel
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	'Root.LoadLayout("Page2")
	
	Page3 = B4XPages.GetPage("Page 3")
	
	Drawer.Initialize(Me, "Drawer", Root, 200dip)
	Drawer.CenterPanel.LoadLayout("Page2")
	Drawer.LeftPanel.LoadLayout("left")
	For i = 1 To 10
		lviewDrawer.AddSingleLine("Page2 " & i)
	Next
End Sub

Sub UpdateImage
	If Page3.pnlTouch.IsInitialized Then
		ImageView1.SetBitmap(Page3.cvs.CreateBitmap)
	End If
End Sub


' Events

Sub btnDraw_Click
	B4XPages.ShowPage("Page 3")
End Sub

Sub btnSet_Click
	B4XPages.ClosePage(Me)
End Sub

Sub btnSignOut_Click
	Page3.ClearImage
	UpdateImage
	B4XPages.ShowPageAndRemovePreviousPages("MainPage")	
End Sub

Sub btnDrawer_Click
	Log("Button")
	Drawer.LeftOpen = False
End Sub

Sub lviewDrawer_ItemClick (Position As Int, Value As Object)
	Log("Listview " & Position & " " & Value)
	Drawer.LeftOpen = False	
End Sub


'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub B4XPage_Appear
	Log("Page2 Appeared")
	lblHello.Text = $"Hello ${B4XPages.MainPage.txtUser.Text}!"$
	UpdateImage
End Sub

Sub B4XPage_Disappear
	Log("Page2 Disappeared")	
End Sub

Sub B4XPage_Foreground
	Log("Page2 Foreground")	
End Sub

Sub B4XPage_Background
	Log("Page2 Background")	
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	Log("Page2 CloseRequest")
	If Drawer.LeftOpen Then
		Drawer.LeftOpen = False
		Return False
	End If
	Return True
End Sub



