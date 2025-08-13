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
	
	Private p_Settings As b4xp_Settings
	Private p_Premium As b4xp_Premium
	Private PurchaseHelper As RevenueCatPurchaseHelper
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.AddPageAndCreate("b4xp_Settings",p_Settings.Initialize)
	B4XPages.AddPage("b4xp_Premium",p_Premium.Initialize)
	
	B4XPages.SetTitle(Me,"RevenueCat Premium Subscription")
	
	PurchaseHelper.Initialize(Me,"PurchaseHelper",Main.m_RevenuecatApiKey)
	PurchaseHelper.ProductIndentififer = Array As String("all_access_1_month_easyplate","all_access_1_year_easyplate")
	
	Log("Has Premium? " & Main.HasPremium)
	
	Wait For (PurchaseHelper.CheckPurchases) complete (Success As Boolean)
	
	Log("Has Premium? " & Main.HasPremium)
	
	If PurchaseHelper.ProVersionExpired Then
		
		xui.MsgboxAsync("The Pro version has been canceled or not renewed, you are now using the basic version","Pro Version expired")
		
	End If
	
	
End Sub


Private Sub xlbl_Settings_Click
	B4XPages.ShowPage("b4xp_Settings")
End Sub