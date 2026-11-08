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
	Private AS_TabMenuAdvanced1 As AS_TabMenuAdvanced
	
			#If B4I
	Private xpnl_bottom As B4XView
#End If
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS TabMenuAdvanced")
	
	
	#If B4I
	xpnl_bottom = xui.CreatePanel("")
	Root.AddView(xpnl_bottom,0,0,Root.Width,B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom)
	xpnl_bottom.Color = 0xFF202125
	#End If
	
	AS_TabMenuAdvanced1.AddTab("",xui.LoadBitmap(File.DirAssets,"home_active.png"),xui.LoadBitmap(File.DirAssets,"home_inactive.png"))
	AS_TabMenuAdvanced1.AddTab("Parking",xui.LoadBitmap(File.DirAssets,"parking_active.png"),xui.LoadBitmap(File.DirAssets,"parking_inactive.png"))
	AS_TabMenuAdvanced1.AddTab("Maps",xui.LoadBitmap(File.DirAssets,"maps_active.png"),xui.LoadBitmap(File.DirAssets,"maps_inactive.png"))
	AS_TabMenuAdvanced1.AddTab("Maps",xui.LoadBitmap(File.DirAssets,"maps_active.png"),xui.LoadBitmap(File.DirAssets,"maps_inactive.png"))
	AS_TabMenuAdvanced1.AddTab("More",AS_TabMenuAdvanced1.FontToBitmap(Chr(0xE5D4),True,45,xui.Color_White),AS_TabMenuAdvanced1.FontToBitmap(Chr(0xE5D4),True,45,xui.Color_White))
	AS_TabMenuAdvanced1.Refresh

	'Sleep(3000)
	AS_TabMenuAdvanced1.GetTab(2).xTab.BadgeValue = 5
	AS_TabMenuAdvanced1.GetTab(3).xTab.Enabled = False
	AS_TabMenuAdvanced1.Refresh

End Sub

#If B4I
Private Sub B4XPage_Resize (Width As Int, Height As Int)
	xpnl_bottom.SetLayoutAnimated(0,0,Height - B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom,Width,B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom)
	AS_TabMenuAdvanced1.mBase.Top = Height - AS_TabMenuAdvanced1.mBase.Height - B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom
End Sub
#End If

Private Sub AS_TabMenuAdvanced1_TabClick (Index As Int)
	If Index = 4 Then
		
		Dim xpnl_Tab As B4XView = AS_TabMenuAdvanced1.GetTab(Index).xTabViews.xpnl_TabBackground 'Get the tab
		'Log("The middle of the tab is: " & (xpnl_Tab.Left + xpnl_Tab.Width/2))
		
		Dim PopupMenuAdvanced As ASPopupMenuAdvanced
		PopupMenuAdvanced.Initialize(Root,Me,"PopupMenuAdvanced")
		
		Dim PopupMenuWidth As Float = 150dip
		Dim PopupMenuHeight As Float = 250dip
		Dim MenuLeft As Float = xpnl_Tab.Left + xpnl_Tab.Width/2 - PopupMenuWidth/2
		
		'Adds the items
		For i = 0 To 10 -1
		
			Dim xpnl As B4XView = xui.CreatePanel("")
			xpnl.SetLayoutAnimated(0,0,0,PopupMenuWidth,40dip)
			xpnl.LoadLayout("frm_Item1")
			xpnl.GetView(0).Text = "Test " & i
		
			PopupMenuAdvanced.AddItem(xpnl,"")
			If i <> 9 Then PopupMenuAdvanced.AddSeparator
		Next
		
		'Triangle properties
		PopupMenuAdvanced.ShowTriangle = True
		PopupMenuAdvanced.TriangleProperties.Left = PopupMenuWidth/2 - PopupMenuAdvanced.TriangleProperties.Width/2 + ((MenuLeft + PopupMenuWidth)-Root.Width)
		PopupMenuAdvanced.TriangleProperties.Top = AS_TabMenuAdvanced1.mBase.Top
		PopupMenuAdvanced.TriangleProperties.Color = xui.Color_White
		PopupMenuAdvanced.OrientationHorizontal = PopupMenuAdvanced.OrientationHorizontal_RIGHT
		PopupMenuAdvanced.OrientationVertical = PopupMenuAdvanced.OrientationVertical_TOP
	
		
		'Show the menu
		If MenuLeft + PopupMenuWidth > Root.Width Then MenuLeft = MenuLeft - ((MenuLeft+PopupMenuWidth)-Root.Width)
		
		PopupMenuAdvanced.OpenMenuAdvanced(MenuLeft,AS_TabMenuAdvanced1.mBase.Top - PopupMenuHeight - PopupMenuAdvanced.TriangleProperties.Height,PopupMenuWidth,PopupMenuHeight)
		
		
	End If
End Sub
