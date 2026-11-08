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
	Public AdsRemovedSubscription As Boolean
	Public const ADS_SDK_ID As String = "subs_remove_ads"  '"android.test.purchased" 'android.test.purchased id no longer works.
	Public const BILLING_KEY As String = "MIIBIjANBg..."  '
	Private btnRemoveAds As B4XView
	Private lblAd As B4XView
	Private btnReset As B4XView
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	billing.Initialize("billing")
	RestorePurchases
End Sub

Private Sub UpdateAdsState
	lblAd.Visible = Not(AdsRemovedSubscription)
	btnRemoveAds.Enabled = Not(AdsRemovedSubscription)
	btnReset.Enabled = AdsRemovedSubscription
End Sub

Private Sub RestorePurchases
	Wait For (billing.ConnectIfNeeded) Billing_Connected (Result As BillingResult)
	If Result.IsSuccess Then
		Wait For (billing.QueryPurchases("subs")) Billing_PurchasesQueryCompleted (Result As BillingResult, Purchases As List)
		Log("Query completed: " & Result.IsSuccess)
		If Result.IsSuccess Then
			For Each p As Purchase In Purchases
				If p.Sku = ADS_SDK_ID Then HandleAdsPurchase(p)
			Next
		End If
	End If
End Sub

Public Sub LaunchBillingFlow (Client As BillingClient, Sku As SkuDetails, OfferToken As String) As BillingResult
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim ProductDetailsParamsBuilder As JavaObject
	ProductDetailsParamsBuilder = ProductDetailsParamsBuilder.InitializeStatic("com.android.billingclient.api.BillingFlowParams.ProductDetailsParams").RunMethod("newBuilder", Null)
	ProductDetailsParamsBuilder.RunMethod("setProductDetails", Array(Sku))
	ProductDetailsParamsBuilder.RunMethod("setOfferToken", Array(OfferToken))
	Dim ProductDetails As List = Array(ProductDetailsParamsBuilder.RunMethod("build", Null))
    
	Dim BillingFlowParamsBuilder As JavaObject
	BillingFlowParamsBuilder = BillingFlowParamsBuilder.InitializeStatic("com.android.billingclient.api.BillingFlowParams").RunMethod("newBuilder", Null)
	BillingFlowParamsBuilder.RunMethod("setProductDetailsParamsList", Array(ProductDetails))
    
	Return Client.As(JavaObject).GetFieldJO("client").RunMethod("launchBillingFlow", Array(ctxt, BillingFlowParamsBuilder.RunMethod("build", Null)))
End Sub

Sub btnRemoveAds_Click
	'make sure that the store service is connected
	Wait For (billing.ConnectIfNeeded) Billing_Connected (Result As BillingResult)
	If Result.IsSuccess Then
		'get the sku details
		Dim sf As Object = billing.QuerySkuDetails("subs", Array(ADS_SDK_ID))
		Wait For (sf) Billing_SkuQueryCompleted (Result As BillingResult, SkuDetails As List)
'		If Result.IsSuccess And SkuDetails.Size = 1 Then
'			Result = billing.LaunchBillingFlow(SkuDetails.Get(0))
'			If Result.IsSuccess Then Return
'		End If
		If Result.IsSuccess Then
			If SkuDetails.Size > 0 Then
				Dim offers As List = SkuDetails.Get(0).As(JavaObject).RunMethod("getSubscriptionOfferDetails", Null)
				Dim offer As JavaObject = offers.Get(0)
				Dim OfferToken As String = offer.RunMethod("getOfferToken", Null)
'				Result = billing.LaunchBillingFlow(SkuDetails.Get(0))
				Result = LaunchBillingFlow(billing, SkuDetails.Get(0), OfferToken)
				If Result.IsSuccess Then Return
			Else
				ToastMessageShow("Error SKU not found", True)
				Return
			End If
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
	If p.Sku.StartsWith("subs_remove_ads") = False And billing.VerifyPurchase(p, BILLING_KEY) = False Then
		Log("Invalid purchase")
		Return
	End If
	
	If p.IsAcknowledged = False Then
		'we either acknowledge the product or consume it.
		Wait For (billing.AcknowledgePurchase(p.PurchaseToken, "")) Billing_AcknowledgeCompleted (Result As BillingResult)
		Log("Acknowledged: " & Result.IsSuccess)
	End If
	
	AdsRemovedSubscription = True
	Log("AdsRemovedSubscription")
	UpdateAdsState
End Sub

Public Sub ResetAds
	'we want to get the ads product and consume it
	Wait For (billing.ConnectIfNeeded) Billing_Connected (Result As BillingResult)
	If Result.IsSuccess Then
		Wait For (billing.QueryPurchases("subs")) Billing_PurchasesQueryCompleted (Result As BillingResult, Purchases As List)
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
				AdsRemovedSubscription = False
				UpdateAdsState
			End If
		End If
	Next
End Sub


