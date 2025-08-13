B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Public page2 As clPage2
	
	Public b4xmp_3dot As B4XMenuPlus
	Private b4xmp_icon As B4XMenuPlus
	Private b4xmp_bmp As B4XMenuPlus

	Private colorState As Int = 0
	Private const colorList() As Int = Array As Int ( xui.Color_Red, xui.Color_Green, xui.Color_Blue )
	
	Private bmpIcon As B4XBitmap
	Private Nr(4) As B4XBitmap
	
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True

	' Load bitmaps.
	bmpIcon = xui.LoadBitmapResize(File.DirAssets, "bmpColor.bmp", 64dip, 64dip, True)
	
	Nr(0) = xui.LoadBitmapResize(File.DirAssets, "0.bmp", 64dip, 64dip, True)
	Nr(1) = xui.LoadBitmapResize(File.DirAssets, "1.bmp", 64dip, 64dip, True)
	Nr(2) = xui.LoadBitmapResize(File.DirAssets, "2.bmp", 64dip, 64dip, True)
	Nr(3) = xui.LoadBitmapResize(File.DirAssets, "3.bmp", 64dip, 64dip, True)

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	' ---------- PAGE 2 ----------------------------
	
	page2.Initialize
	B4XPages.AddPage( "Page2", page2 )
	
	' ---------- 3-DOT MENU CREATION  --------------

	b4xmp_3dot.Initialize( Me, Root, "MenuClick3dot" )
	
	b4xmp_3dot.AddSeparator()
	b4xmp_3dot.AddItem( "item", "Test menu item" )
	b4xmp_3dot.AddSeparator()
	
	b4xmp_3dot.AddToggle( "testEDtoggle", "Test Disable" )
	b4xmp_3dot.AddToggle( "testEDtoggle", "Test Enable" )
	
	b4xmp_3dot.AddToggle( "testVHtoggle", "Test Hidden" )
	b4xmp_3dot.AddToggle( "testVHtoggle", "Test Visible" )
	
	b4xmp_3dot.AddSeparator()
	
	b4xmp_3dot.AddToggle( "toggle", "Toggle item" )
	b4xmp_3dot.AddToggleIcon( "toggle", "Toggle with icon", False, Chr(0xE914),  xui.Color_Gray )
	b4xmp_3dot.AddToggleIcon( "toggle", "Toggle with icon2", False, Chr(0xE195),  xui.Color_red )
	
	b4xmp_3dot.AddCheckbox( "check", "CheckBox", True )
	
	b4xmp_3dot.AddSubMenu( "submenu", "Sub Menu" )
	b4xmp_3dot.AddSubItem( "submenu", "sub1", "Submenu 1" )
	b4xmp_3dot.AddSubItemIcon( "submenu", "subIcon", "Submenu Icon", False, Chr(0xE914),  xui.Color_Gray )

	b4xmp_3dot.AddSubCheckbox( "submenu", "subCheck", "Submenu Check", True )
	
	b4xmp_3dot.AddSubToggle( "submenu", "subToggle", "Toggle 1" )
	b4xmp_3dot.AddSubToggleIcon( "submenu", "subToggle", "Toggle 2", False, Chr(0xE195),  xui.Color_red )
	b4xmp_3dot.AddSubToggle( "submenu", "subToggle", "Toggle 3" )
	b4xmp_3dot.AddSubToggle( "submenu", "subToggle", "Toggle 4" )

	b4xmp_3dot.AddSubMenu( "submenu2", "Sub Menu 2" )
	b4xmp_3dot.AddSubItem( "submenu2", "sub21", "Submenu 2-1" )
	b4xmp_3dot.AddSubSeparator( "submenu2" )
	b4xmp_3dot.AddSubItem( "submenu2", "sub22", "Submenu 2-2" )
	
	b4xmp_3dot.AddSubSubMenu( "submenu2", "ssm", "SubSub Menu" )
	b4xmp_3dot.AddSubItem( "ssm", "subsubitem", "Sub Sub menu item" )

	b4xmp_3dot.ShowMenu		' First Time.

	' ---------- ICON MENU CREATION  ---------------

	b4xmp_icon.Initialize( Me, Root, "MenuClickIcon" )
	
	b4xmp_icon.AddBarIcon( "icon", "Icon Test", True, Chr(0xF293),  xui.Color_Red )
	b4xmp_icon.AddBarIcon( "icon12", "Icon Test12", True, Chr(0xF187),  xui.Color_Red )
	
	b4xmp_icon.AddBarToggleIcon( "fly", "Fly mode on", False, Chr(0xE195), xui.Color_Black )
	b4xmp_icon.AddBarToggleIcon( "fly", "Fly mode off", False, Chr(0xE194), xui.Color_Black )

	' ---------- BMP MENU CREATION  ----------------
	
	b4xmp_bmp.Initialize( Me, Root, "MenuClickBmp" )
	
	For i=0 To Nr.Length-1
		b4xmp_bmp.AddBarToggleBmp( "NrToggle", "Nr"&i, Nr(i) )
	Next

	b4xmp_bmp.AddBarBmp( "bmp", "bmp", bmpIcon )

End Sub

Private Sub B4XPage_MenuClick( Tag As String )
	LogColor( "B4XPage_MenuClick: " & Tag, xui.Color_Green  )
	
	b4xmp_3dot.MenuClick( Tag )
	b4xmp_icon.MenuClick( Tag )
	b4xmp_bmp.MenuClick( Tag )

End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

' ---------- 3-DOT MENU EVENTS  ----------------

Private Sub MenuClick3dot_item()
	Log( "Click 3-dot: item" )
	
End Sub

Private Sub MenuClick3dot_item2()
	Log( "Click 3-dot: item2" )
	
End Sub

Private Sub MenuClick3dot_testEDtoggle( state As Int )
	Log( "Click 3-dot: test enb/dis=" & state )
	
	b4xmp_3dot.SetEnabled( "item", IIf( state = 1, False, True ) )
	
End Sub

Private Sub MenuClick3dot_toggle( state As Int )
	Log( "Click 3-dot: toggle = " & state )
		
End Sub

Private Sub MenuClick3dot_testVHtoggle( state As Int )
	Log( "Click 3-dot: toggle visible/hidden=" & state )
	
	b4xmp_3dot.setVisible( "item", IIf( state = 1, False, True ) )

End Sub

Private Sub MenuClick3dot_check( checked As Boolean )
	Log( "Click 3-dot: Check - checked=" & checked )

End Sub

Private Sub MenuClick3dot_sub1()
	Log( "Click 3-dot Submenu: submenu 1" )

End Sub

Private Sub MenuClick3dot_subCheck( checked As Boolean )
	Log( "Click 3-dot Submenu: Check - checked=" & checked )

End Sub

' ---------- ICON / BMP MENU EVENTS  -----------

Private Sub MenuClickIcon_icon()
	Log( "Click icon: icon" )

	colorState = IIf( colorState = colorList.Length-1, 0, colorState + 1 )

	Dim c As Int = colorList( colorState )
	
	b4xmp_icon.setIconColor( "icon", c )

End Sub

Private Sub  MenuClickIcon_fly( state As Int )
	Log( "Click icon: fly - state=" & state )

End Sub

Private Sub menuclickbmp_nrtoggle( state As Int )
	Log( "Click bmp: Nr - state=" & state )

End Sub

Private Sub menuclickbmp_bmp()
	Log( "Click bmp: bmp" )

End Sub

' ---------- BUTTON CLICK  ---------------------

Private Sub threeDot_Click
	
	b4xmp_3dot.ShowMenu
	b4xmp_icon.isActive=False
	b4xmp_bmp.isActive=False
	
End Sub

Private Sub setTestEnable_Click
	
	Log( b4xmp_3dot.setToggleState( "testEDtoggle", 0 )	)	' Disable
	Log( "set Toggle Disable. Err: " & b4xmp_3dot.Error )
	b4xmp_3dot.SetEnabled( "item", True )					' Enable
	Log( "set Item Enable. Err: " & b4xmp_3dot.Error )
	
End Sub

Private Sub toggleEnbDis_Click
	
	Dim enb As Boolean = b4xmp_3dot.getEnabled( "toggle" )
	
	b4xmp_3dot.SetEnabled( "toggle", IIf( enb, False, True ) )

End Sub

Private Sub icon_Click
	
	b4xmp_icon.ShowMenu
	b4xmp_3dot.isActive=False
	b4xmp_bmp.isActive=False

End Sub

Private Sub iconEnb_Click
	
	Dim enb As Boolean = b4xmp_icon.getEnabled( "icon" )
	enb = IIf( enb, False, True )
	b4xmp_icon.setEnabled( "icon", enb )
	b4xmp_icon.setEnabled( "fly", enb )

End Sub

Private Sub iconVisible_Click
	
	Dim visible As Boolean = b4xmp_icon.getVisible( "icon" )
	visible = IIf( visible, False, True )
	b4xmp_icon.setVisible( "icon", visible )
	b4xmp_icon.setVisible( "fly", visible )

End Sub

Private Sub bmp_Click
	
	b4xmp_bmp.ShowMenu
	b4xmp_3dot.isActive=False
	b4xmp_icon.isActive=False

End Sub

Private Sub bmpEnb_Click
	
	Dim enb As Boolean = b4xmp_bmp.getEnabled( "NrToggle" )
	b4xmp_bmp.setEnabled( "NrToggle", IIf( enb, False, True ) )
	b4xmp_bmp.setEnabled( "bmp", IIf( enb, False, True ) )

End Sub

Private Sub bmpVisible_Click
	
	Dim visible As Boolean = b4xmp_bmp.getVisible( "NrToggle" )
	b4xmp_bmp.setVisible( "NrToggle", IIf( visible, False, True ) )
	b4xmp_bmp.setVisible( "bmp", IIf( visible, False, True ) )

End Sub

Private Sub bmpState_Click
	
	b4xmp_bmp.setToggleState( "NrToggle", 2 )

End Sub

Private Sub btnPage2_Click
	B4XPages.ShowPage( "page2" )
	
End Sub