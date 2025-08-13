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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=BillingExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public billing As BillingClient
	Public AdsRemoved As Boolean
	Public const ADS_SDK_ID As String = "android.test.purchased"
	Public const BILLING_KEY As String = "3434ABCDEF..."
	Private btnRemoveAds As B4XView
	Private lblAd As B4XView
	Private btnReset As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	billing.Initialize("billing")
	RestorePurchases
End Sub

Private Sub UpdateAdsState
	lblAd.Visible = Not(AdsRemoved)
	btnRemoveAds.Enabled = Not(AdsRemoved)
	btnReset.Enabled = AdsRemoved
End Sub

Private Sub RestorePurchases
	Wait For (billing.ConnectIfNeeded) Billing_Connected (Result As BillingResult)
	If Result.IsSuccess Then
		Wait For (billing.QueryPurchases("inapp")) Billing_PurchasesQueryCompleted (Result As BillingResult, Purchases As List)
		Log("Query completed: " & Result.IsSuccess)
		If Result.IsSuccess Then
			For Each p As Purchase In Purchases
				If p.Sku = ADS_SDK_ID Then HandleAdsPurchase(p)
			Next
		End If
	End If
End Sub

Sub btnRemoveAds_Click
	'make sure that the store service is connected
	Wait For (billing.ConnectIfNeeded) Billing_Connected (Result As BillingResult)
	If Result.IsSuccess Then
		'get the sku details
		Dim sf As Object = billing.QuerySkuDetails("inapp", Array(ADS_SDK_ID))
		Wait For (sf) Billing_SkuQueryCompleted (Result As BillingResult, SkuDetails As List)
		If Result.IsSuccess And SkuDetails.Size = 1 Then
			Result = billing.LaunchBillingFlow(SkuDetails.Get(0))
			If Result.IsSuccess Then Return
		End If
	End If
	ToastMessageShow("Error starting billing process", True)
End Sub

Sub btnReset_Click
	ResetAds
End Sub



Sub billing_PurchasesUpdated (Result As BillingResult, Purchases As List)
	'This event will be raised when the status of one or more of the purchases has changed.
	'It will usually happen as a result of calling LaunchBillingFlow however it can be called in other cases as well.
	If Result.IsSuccess Then
		For Each p As Purchase In Purchases
			If p.Sku = ADS_SDK_ID Then
				HandleAdsPurchase(p)
			Else
				Log("Unexpected product...")
			End If
		Next
	End If
End Sub

Private Sub HandleAdsPurchase (p As Purchase)
	If p.PurchaseState <> p.STATE_PURCHASED Then Return
	'Verify the purchase signature.
	'This cannot be done with the test id.
	If p.Sku.StartsWith("android.test") = False And billing.VerifyPurchase(p, BILLING_KEY) = False Then
		Log("Invalid purchase")
		Return
	End If
	If p.IsAcknowledged = False Then
		'we either acknowledge the product or consume it.
		Wait For (billing.AcknowledgePurchase(p.PurchaseToken, "")) Billing_AcknowledgeCompleted (Result As BillingResult)
		Log("Acknowledged: " & Result.IsSuccess)
	End If
	AdsRemoved = True
	Log("AdsRemoved")
	UpdateAdsState
End Sub

Public Sub ResetAds
	'we want to get the ads product and consume it
	Wait For (billing.ConnectIfNeeded) Billing_Connected (Result As BillingResult)
	If Result.IsSuccess Then
		Wait For (billing.QueryPurchases("inapp")) Billing_PurchasesQueryCompleted (Result As BillingResult, Purchases As List)
		If Result.IsSuccess Then
			ConsumeAdsProduct(Purchases)
		End If
	End If
End Sub

Private Sub ConsumeAdsProduct(Purchases As List)
	For Each p As Purchase In Purchases
		If p.Sku = ADS_SDK_ID Then
			Wait For (billing.Consume(p.PurchaseToken, "")) Billing_ConsumeCompleted (Result As BillingResult)
			If Result.IsSuccess Then
				Log("consumed")
				AdsRemoved = False
				UpdateAdsState
			End If
		End If
	Next
End Sub


