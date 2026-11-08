B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4APagesAppBase_v00.zip
#End Region

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	#if B4i
	Private ImageView1 As B4XView
	#end if

	'------------------------------------------------- ADD
	'to manage the menu bar hamburger
	Private Drawer As B4XDrawer
	Private HamburgerIcon As B4XBitmap

	'------------------------------------------------- ADD
	'to manage the menu bar options Left menu
	Private SettingBitmap As B4XBitmap
	Private IconCanvas As B4XCanvas
	Public BadgeNumber As Int 'Var badge with counter
	'-------------------------------------------------

End Sub

Public Sub Initialize
	
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	'Log("MainPage 1")
	B4XPages.GetManager.TransitionAnimationDuration=0
	
	Root = Root1
	Wait For (ShowSplashScreen) Complete (Unused As Boolean)
	
'	Root.LoadLayout("MainPage") 'Modifi

	'------------------------------------------------- ADD
	'to manage the menu bar options: Left menu
	Drawer.Initialize(Me, "Drawer", Root, 200dip)
	Drawer.CenterPanel.LoadLayout("MainPage")
	Drawer.LeftPanel.LoadLayout("Page2Left")
	'-------------------------------------------------
	
	'don't use %y in your code! Use Root.Height instead.
	B4XPages.SetTitle(Me, "MainPage")

	'------------------------------------------------- ADD
	'to manage the menu bar options: Left menu
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
	'-------------------------------------------------

	'------------------------------------------------- ADD
	'to manage the menu bar options: Items with image
	'SettingBitmap = xui.LoadBitmap(File.DirAssets, "settings36.png")
	SettingBitmap = xui.LoadBitmapResize(File.DirAssets, "settings36.png", 32dip, 32dip, True)
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	IconCanvas.Initialize(p)	
	UpdateMenuItems
	
	'to manage the menu bar options: Three points with text
	UpdateMenuText
	'-------------------------------------------------

	'Log("MainPage 2")
End Sub

	'------------------------------------------------- ADD
	'to manage the menu bar options: Left menu
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
	'-------------------------------------------------
	
Sub ShowSplashScreen As ResumableSub
#if B4i
	Main.NavControl.NavigationBarVisible = False
	Root.LoadLayout("Splash")
	ImageView1.SetBitmap(xui.LoadBitmapResize(File.DirAssets, "logo.png", ImageView1.Width, ImageView1.Height, True))
	Sleep(3000)
	Root.RemoveAllViews
	Main.NavControl.NavigationBarVisible = True
 #else if B4A
 	Dim start As Long = DateTime.Now
	Do While Activity2.HeightChangedFired = False And DateTime.Now < start + 500
		Sleep(50)
	Loop
	Root.Height = Activity2.CorrectHeight
#End If
	Return True
End Sub

Sub Button1_Click
	xui.MsgboxAsync("The message is displayed and the app closes.", "B4X")

	'remove, it's for testing and leave quickly ;)
	Sleep(2000)
	Root.RemoveAllViews
	ExitApplication
	'---------------
End Sub

Private Sub Button2_Click
	BadgeNumber = BadgeNumber + 1
	UpdateMenuItems
	UpdateMenuText
End Sub

	'------------------------------------------------- ADD
	'to manage the menu bar options: Left menu
Private Sub B4XPage_CloseRequest As ResumableSub
	#if B4A
	'home button
	If Activity2.ActionBarHomeClicked Then
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
	#if B4A
	Sleep(0)
	B4XPages.GetManager.ActionBar.RunMethod("setDisplayHomeAsUpEnabled", Array(True))
	Dim bd As BitmapDrawable
	HamburgerIcon = xui.LoadBitmapResize(File.DirAssets, "menu36.png", 32dip, 32dip, True)
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

Sub btnSignOut_Click
	Log("btnSignOut")
	Drawer.LeftOpen = False
'	B4XPages.ShowPageAndRemovePreviousPages("MainPage")

	xui.MsgboxAsync("Your session has been closed", "Sign Out")

	'remove, it's for testing and leave quickly ;)
	'Sleep(2000)
	'Root.RemoveAllViews
	'ExitApplication
End Sub
'-------------------------------------------------

'------------------------------------------------- ADD
'to manage the menu bar options
Private Sub UpdateMenuText
	B4XPages.AddMenuItem(Me, "Language")
	B4XPages.AddMenuItem(Me, "Admin")
End Sub

Private Sub B4XPage_MenuClick (Tag As String)
	'Log(Tag)
	If Tag="settings" Then 'menu options
		Log(Tag)
	End If
	If Tag="Language" Then 'menu options
		Log(Tag)
	End If
	If Tag="Admin" Then 'menu options
		Log(Tag)
	End If
End Sub

Sub UpdateMenuItems
	Dim bmp As B4XBitmap = CreateIconWithBadge(SettingBitmap, BadgeNumber)
	#if B4A
	Dim menus As List = B4XPages.GetManager.GetPageInfoFromRoot(Root).Parent.MenuItems
	menus.Clear
	'add menu items
	Dim mi As B4AMenuItem = B4XPages.AddMenuItem(Me, "settings")
	mi.AddToBar = True
	mi.Bitmap = bmp
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	ctxt.RunMethod("invalidateOptionsMenu", Null)
	#else if B4i
	Dim bb As BarButton
	bb.InitializeBitmap(Main.KeepOriginalColors(bmp), "cart")
	B4XPages.GetNativeParent(Me).TopRightButtons = Array(bb)
	#end if
End Sub

Sub CreateIconWithBadge(bmp As B4XBitmap, Number As Int) As B4XBitmap
	IconCanvas.ClearRect(IconCanvas.TargetRect)
	IconCanvas.DrawBitmap(bmp, IconCanvas.TargetRect)
	Number = Min(Number, 99) '1 o 2 cifras
	If Number > 0 Then
		Dim cx As Int = IconCanvas.TargetRect.Width - 8dip
		Dim cy As Int = 8dip
		IconCanvas.DrawCircle(cx, cy, cy, Colors.Red, True, 0)
		Dim fnt As B4XFont = xui.CreateDefaultBoldFont(12)
		Dim r As B4XRect = IconCanvas.MeasureText(Number, fnt)
		Dim BaseLine As Int = cy - r.Height / 2 - r.Top
		IconCanvas.DrawText(Number, cx, BaseLine, fnt, xui.Color_White, "CENTER")
	End If
	Return IconCanvas.CreateBitmap
End Sub
'-------------------------------------------------

