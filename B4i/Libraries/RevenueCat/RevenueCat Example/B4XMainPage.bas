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
	Private PurchaseHelper As RevenueCatPurchaseHelper
	Private CustomListView1 As CustomListView
	
	Private B4XLoadingIndicator1 As B4XLoadingIndicator
	Private xpnl_LoadingIndicator As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"RevenueCat Example")
	
	PurchaseHelper.Initialize(Me,"PurchaseHelper","YourRevenueCatApiKey")
	PurchaseHelper.ProductIndentififer = Array As String("all_access_1_month_lognote","all_access_1_year_lognote") 'The Product identifyer
	
	Wait For (PurchaseHelper.CheckPurchases) complete (Success As Boolean) 'Must be called at app start, as we check here whether the user has the Premium version
	Log("Do I have a premium version? " & Success)
	
	Wait For (PurchaseHelper.GetProductsInformation(PurchaseHelper.ProductIndentififer)) complete (lstPurchases As List)
	
	For Each ProductInfo As ProductInformation In lstPurchases
		'Log(ProductInfo.Tag)
		'Log(ProductInfo.Description)	
		CustomListView1.AddTextItem(ProductInfo.Title & " - " & ProductInfo.LocalizedPrice,ProductInfo.ProductIdentifier)	
	Next
	
	
End Sub


Private Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	
	Dim sf As Object = xui.Msgbox2Async("Do you want to buy?", "Title", "Yes", "", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		
		xpnl_LoadingIndicator.Visible = True
		B4XLoadingIndicator1.Show
		
		Wait For (PurchaseHelper.RequestPayment(Value)) Complete (Success As Boolean)
		
		xpnl_LoadingIndicator.Visible = False
		B4XLoadingIndicator1.Hide
		
		If Success Then
			'Unlock Premium Features
		End If
		
	End If
	
End Sub