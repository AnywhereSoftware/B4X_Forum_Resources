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
	Private AS_TabMenuAdvanced_Design1 As AS_TabMenuAdvanced
	Private AS_TabMenuAdvanced_Design2 As AS_TabMenuAdvanced
	Private AS_TabMenuAdvanced_Design3 As AS_TabMenuAdvanced
	Private AS_TabMenuAdvanced_Design4 As AS_TabMenuAdvanced
	
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS TabMenuAdvanced")
	
	'Design #1
	AS_TabMenuAdvanced_Design1.Index = 2
	AS_TabMenuAdvanced_Design1.CornerRadius = AS_TabMenuAdvanced_Design1.mBase.Height
	AS_TabMenuAdvanced_Design1.IndicatorVisible = True
	AS_TabMenuAdvanced_Design1.IndicatorProperties.Color = xui.Color_White
	AddTabs(AS_TabMenuAdvanced_Design1)
	
	AddTabs(AS_TabMenuAdvanced_Design2)
	
	AddTabs2(AS_TabMenuAdvanced_Design3)
	
	'Design #4
	AS_TabMenuAdvanced_Design4.TabProperties.TextFont = xui.CreateDefaultBoldFont(17)
	AddTabs3(AS_TabMenuAdvanced_Design4)

End Sub

Private Sub AddTabs(TabMenu As AS_TabMenuAdvanced)
	TabMenu.AddTab("Home",xui.LoadBitmap(File.DirAssets,"home_active.png"),xui.LoadBitmap(File.DirAssets,"home_inactive.png"))
	TabMenu.AddTab("Parking",xui.LoadBitmap(File.DirAssets,"parking_active.png"),xui.LoadBitmap(File.DirAssets,"parking_inactive.png"))
	TabMenu.AddTab("Maps",xui.LoadBitmap(File.DirAssets,"maps_active.png"),xui.LoadBitmap(File.DirAssets,"maps_inactive.png"))
	TabMenu.AddTab("Maps",xui.LoadBitmap(File.DirAssets,"maps_active.png"),xui.LoadBitmap(File.DirAssets,"maps_inactive.png"))
	TabMenu.AddTab("Maps",xui.LoadBitmap(File.DirAssets,"maps_active.png"),xui.LoadBitmap(File.DirAssets,"maps_inactive.png"))
	
	TabMenu.GetTab(0).xTab.BadgeValue = 5
	
	TabMenu.Refresh
End Sub

Private Sub AddTabs2(TabMenu As AS_TabMenuAdvanced)
	TabMenu.AddTab("",xui.LoadBitmap(File.DirAssets,"home_active.png"),xui.LoadBitmap(File.DirAssets,"home_inactive.png"))
	TabMenu.AddTab("",xui.LoadBitmap(File.DirAssets,"parking_active.png"),xui.LoadBitmap(File.DirAssets,"parking_inactive.png"))
	TabMenu.AddTab("",xui.LoadBitmap(File.DirAssets,"maps_active.png"),xui.LoadBitmap(File.DirAssets,"maps_inactive.png"))
	TabMenu.AddTab("",xui.LoadBitmap(File.DirAssets,"maps_active.png"),xui.LoadBitmap(File.DirAssets,"maps_inactive.png"))
	TabMenu.AddTab("",xui.LoadBitmap(File.DirAssets,"maps_active.png"),xui.LoadBitmap(File.DirAssets,"maps_inactive.png"))
	
	TabMenu.GetTab(0).xTab.BadgeValue = 5
	TabMenu.GetTab(0).xBadgeProperties.LeftPadding = -5dip
	
	TabMenu.Refresh
End Sub

Private Sub AddTabs3(TabMenu As AS_TabMenuAdvanced)
	TabMenu.AddTab("Home",Null,Null)
	TabMenu.AddTab("Parking",Null,Null)
	TabMenu.AddTab("Maps",Null,Null)
	TabMenu.AddTab("Maps",Null,Null)
	TabMenu.AddTab("Maps",Null,Null)
	
	TabMenu.Refresh
End Sub