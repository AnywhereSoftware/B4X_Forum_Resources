B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
'github desktop ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=git&Args=..\..\

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	Private pPurchases As Purchases

End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	pPurchases.Initialize
	B4XPages.AddPage("page_purchases", pPurchases)
End Sub

'to show all skus to purchase
Private Sub btnPurchases_Click
	pPurchases.skutype = "ALL"
	B4XPages.ShowPage("page_purchases")
End Sub

'to show only one sku to purchase
Private Sub btnShow1sku_Click
	pPurchases.skutype = "INAPP"
	pPurchases.sku = "pro.gpbtest2"
	B4XPages.ShowPage("page_purchases")
End Sub

'consume sku
Private Sub btnConsume_Click
	pPurchases.ConsumeProduct("inapp", "pro.gpbtest2")
End Sub