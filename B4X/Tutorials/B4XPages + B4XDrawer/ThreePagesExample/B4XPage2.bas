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
	Private Drawer As B4XDrawer
	Private HamburgerIcon As B4XBitmap 
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Drawer.Initialize(Me, "Drawer", Root, 200dip)
	Drawer.CenterPanel.LoadLayout("Page2")
	Drawer.LeftPanel.LoadLayout("Page2Left")
	Page3 = B4XPages.GetPage("Page 3")
	HamburgerIcon = xui.LoadBitmapResize(File.DirAssets, "hamburger.png", 32dip, 32dip, True)
	#if B4i
	Dim bb As BarButton
	bb.InitializeBitmap(HamburgerIcon, "hamburger")
	B4XPages.GetNativeParent(Me).TopLeftButtons = Array(bb)
	#Else If B4J
	Dim iv As ImageView
	iv.Initialize("imgHamburger")
	iv.SetImage(HamburgerIcon)
	Drawer.CenterPanel.AddView(iv, 2dip, 2dip, 32dip, 32dip)
	iv.PickOnBounds = True
	#end if
End Sub

#if B4J
Sub imgHamburger_MouseClicked (EventData As MouseEvent)
	Drawer.LeftOpen = True
End Sub
#else if B4i
Private Sub B4XPage_MenuClick (Tag As String)
	If Tag = "hamburger" Then
		Drawer.LeftOpen = Not(Drawer.LeftOpen)
	End If
End Sub
#end if

Private Sub B4XPage_CloseRequest As ResumableSub
	#if B4A
	'home button
	If Main.ActionBarHomeClicked Then
		Drawer.LeftOpen = Not(Drawer.LeftOpen)
		Return False
	End If
	'back key
	If Drawer.LeftOpen Then
		Drawer.LeftOpen = False
		Return False
	End If
	#end if
	Return True
End Sub

Private Sub B4XPage_Appear
	lblHello.Text = $"Hello ${B4XPages.MainPage.txtUser.Text}!"$
	UpdateImage
	#if B4A
	Sleep(0)
	B4XPages.GetManager.ActionBar.RunMethod("setDisplayHomeAsUpEnabled", Array(True))
	Dim bd As BitmapDrawable
	bd.Initialize(HamburgerIcon)
	B4XPages.GetManager.ActionBar.RunMethod("setHomeAsUpIndicator", Array(bd))
	#End If
End Sub

Private Sub B4XPage_Disappear
	#if B4A
	B4XPages.GetManager.ActionBar.RunMethod("setHomeAsUpIndicator", Array(0))
	#end if
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	Drawer.Resize(Width, Height)
End Sub

Sub btnDraw_Click
	B4XPages.ShowPage("Page 3")
End Sub

Sub UpdateImage
	If Page3.Panel1.IsInitialized Then
		ImageView1.SetBitmap(Page3.cvs.CreateBitmap)
	End If
End Sub

Sub btnSignOut_Click
	Page3.ClearImage
	Drawer.LeftOpen = False
	UpdateImage
	B4XPages.ShowPageAndRemovePreviousPages("MainPage")	
End Sub


