B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#ModuleVisibility: B4XLib
' clsSubscriptions - Android Subscription Handler
' Manages recurring subscriptions via Google Play Billing Library 3
' Works with UnlockManager for backend validation

Sub Class_Globals
	Private xui As XUI
	Private ParentPanel As B4XView 'Ignore
	
	#if B4A
	Private billing As BillingClient
	#End If
	
	#if B4i
	Private iStore As Store
	#End If
	
	' Properties - Set these before calling Initialize
	Public BillingKey As String
	Public UnlockManager As clsUnlockManager
	
	' Subscription list for multiple subscription options
	Public Subscriptions As List  ' List of subscription_info types
	
	' Purchase screen customization
	Public DisplayAppName As String = ""  ' Leave empty to use Application.LabelName
	Public DisplayTagline As String = "Choose Your Plan"  ' Subtitle text
	
	' Terms & Privacy customization (required for subscriptions)
	Public PolicyCompanyName As String = ""  ' Your company name
	Public PolicyEmailAddress As String = ""  ' Support email address
	Public PolicyEffectiveDate As String = ""  ' Effective date (e.g., "January 1, 2025")
	Public CustomPrivacyPolicyInapp As String = ""
	Public CustomPrivacyPolicySubscription As String = ""
	Public CustomTermsOfService As String = ""
	
	' Color scheme customization (same as clsInapp)
	Public ColorPrimary As String = ""
	Public ColorSecondary As String = ""
	Public ColorAccent As String = ""
	Public ColorBackground1 As String = ""
	Public ColorBackground2 As String = ""
	
	' Dark mode toggle
	Public DarkMode As Boolean = False  ' Set to True for dark theme (overrides color properties)
	
	' Feature customization (dynamic list)
	Public Features As List
	
	' State
	Private mIsInitialized As Boolean = False
	Private mSubscriptionActive As Boolean = False
	Private mActiveSubscriptionId As String = ""
	Private mPurchaseInProgress As Boolean = False
	Private mProcessedTransactions As List  ' Track processed transaction IDs to prevent duplicates
	#If B4i
		Private mRestoreInProgress As Boolean = False  ' Track restore operations separately	
	#End If
	#if B4A
	' Android-specific state for purchase flow (event-driven pattern)
	Private mPurchaseSuccess As Boolean
	Private mPurchaseError As String
	#End If
	
	' State for Wait For pattern
	Private mSubscriptionScreenResult As Boolean
	Private mSubscriptionScreenActive As Boolean
	
	' Views (shared with clsInapp - same layout)
	Private wvPurchase As WebView
	Private mWebViewInitialized As Boolean = False
End Sub

' Subscription info type
Public Sub CreateSubscriptionInfo(pProductId As String, pBasePlanId As String, pTitle As String, pDescription As String, pBillingPeriod As String) As Map
	Dim subscription As Map
	subscription.Initialize
	subscription.Put("product_id", pProductId)
	subscription.Put("base_plan_id", pBasePlanId)
	subscription.Put("title", pTitle)
	subscription.Put("description", pDescription)
	subscription.Put("billing_period", pBillingPeriod)  ' e.g., "Monthly", "Annual"
	subscription.Put("price", "...")  ' Will be fetched from store
	Return subscription
End Sub

' Add a subscription to the purchase screen
Public Sub AddSubscription(pProductId As String, pBasePlanId As String, pTitle As String, pDescription As String, pBillingPeriod As String)
	If Subscriptions.IsInitialized = False Then
		Subscriptions.Initialize
	End If
	Subscriptions.Add(CreateSubscriptionInfo(pProductId, pBasePlanId, pTitle, pDescription, pBillingPeriod))
End Sub

' Clear all subscriptions
Public Sub ClearSubscriptions
	If Subscriptions.IsInitialized Then
		Subscriptions.Clear
	Else
		Subscriptions.Initialize
	End If
End Sub

' Initialize subscription system
' Parent: The parent panel where the subscription screen will be displayed
' pBillingKey: Your Google Play license key (ignored on iOS)
' UnlockMgr: Reference to UnlockManager instance (handles validation)
Public Sub Initialize(Parent As B4XView, pBillingKey As String, UnlockMgr As clsUnlockManager)
	ParentPanel = Parent
	
	' Set properties from parameters
	BillingKey = pBillingKey
	UnlockManager = UnlockMgr
	
	#if B4A
	' Initialize billing
	billing.Initialize("billing")
	
	' Initialize transaction tracking (not used on Android, but initialize for consistency)
	mProcessedTransactions.Initialize
	
	#Else If B4i
	' Initialize transaction tracking
	mProcessedTransactions.Initialize
	
	iStore.Initialize("iStore")
	
	If iStore.CanMakePayments = False Then
		LogColor("🛡  Device cannot make payments", UnlockManager.LOG_COLOR_LIB_WARNING)
	End If
	
	#End If
	
	mIsInitialized = True
End Sub

' Create WebView on first use (deferred from Initialize for correct sizing)
Private Sub EnsureWebView
	If mWebViewInitialized Then Return
	mWebViewInitialized = True
	
	wvPurchase.Initialize("wvPurchase")
	ParentPanel.AddView(wvPurchase, 0, 0, ParentPanel.Width, ParentPanel.Height)
	wvPurchase.Visible = False
	
	#if B4A
	wvPurchase.JavaScriptEnabled = True
	wvPurchase.ZoomEnabled = False
	wvPurchase.Color = Colors.Black
	#Else If B4i
	wvPurchase.As(B4XView).Color = xui.Color_Transparent
	#End If
End Sub

' Check if subscription system is initialized
Public Sub IsInitialized As Boolean
	Return mIsInitialized
End Sub

' Get current subscription status (cached)
Public Sub IsSubscriptionActive As Boolean
	Return mSubscriptionActive
End Sub

' Get active subscription ID
Public Sub GetActiveSubscriptionId As String
	Return mActiveSubscriptionId
End Sub

' Show processing overlay (for direct subscriptions without subscription screen)
Public Sub ShowProcessingOverlay(message As String)
	EnsureWebView
	' Apply theme colors
	Dim themeColors As Map = HTMLBuilder.ApplyDefaultThemeWithDarkMode(ColorPrimary, ColorSecondary, ColorAccent, ColorBackground1, ColorBackground2, DarkMode)
	Dim primary As String = themeColors.Get("primary")
	Dim bg1 As String = themeColors.Get("bg1")
	Dim adaptiveColors As Map = HTMLBuilder.GetAdaptiveColors(HTMLBuilder.IsBackgroundDark(bg1))
	Dim textColor As String = adaptiveColors.Get("textColor")
	Dim overlayBg As String = adaptiveColors.Get("overlayBg")
	
	' Create minimal HTML with just the processing overlay
	Dim html As String = $"<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<style>
body {
    margin: 0;
    padding: 0;
    background: ${overlayBg};
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}
.processing-content {
    text-align: center;
    animation: fadeInUp 0.5s ease-out;
}
.processing-spinner {
    width: 3rem;
    height: 3rem;
    border: 4px solid ${HTMLBuilder.HexToRGBA(textColor, 0.3)};
    border-top-color: ${primary};
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin: 0 auto 1.5rem;
}
.processing-text {
    font-size: 1.1rem;
    color: ${textColor};
    margin-top: 1rem;
}
@keyframes spin {
    to { transform: rotate(360deg); }
}
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>
</head>
<body>
    <div class="processing-content">
        <div class="processing-spinner"></div>
        <div class="processing-text">${message}</div>
    </div>
</body>
</html>"$
	
	wvPurchase.LoadHtml(html)
	wvPurchase.As(B4XView).SetLayoutAnimated(0, 0, 0, ParentPanel.Width, ParentPanel.Height)
	wvPurchase.As(B4XView).BringToFront
	wvPurchase.Visible = True
End Sub

' Hide processing overlay
Public Sub HideProcessingOverlay
	wvPurchase.Visible = False
End Sub

' Force backend validation (for ValidateNow - bypasses restore flow)
' This gets the current receipt and validates with backend regardless of restore state
Public Sub ForceValidate As ResumableSub
	#if B4A
	' For Android, just use restore flow (it always validates with backend)
	Wait For (RestoreSubscriptions) Complete (Success As Boolean)
	Return Success
	#Else If B4i
	
	' Get the App Store receipt
	Dim no As NativeObject = Me
	Dim receiptData As String = no.RunMethod("getReceipt", Null).AsString
	
	If receiptData = "" Then
		LogColor("🛡  No receipt available from App Store", UnlockManager.LOG_COLOR_LIB_WARNING)
		Return False
	End If
	
	Wait For (UnlockManager.ConfirmIOSSubscription(receiptData)) Complete (subResult As Map)
	
	Dim subscribed As Boolean = False
	If subResult.ContainsKey("is_subscribed") Then
		subscribed = subResult.Get("is_subscribed")
		mSubscriptionActive = subscribed
		If subscribed And subResult.ContainsKey("product_id") Then
			mActiveSubscriptionId = subResult.Get("product_id")
		End If
	End If
	
	Return subscribed
	#End If
End Sub

' Restore subscriptions (check for existing subscriptions)
Public Sub RestoreSubscriptions As ResumableSub
	#if B4A
	
	Wait For (billing.ConnectIfNeeded) Billing_Connected (Result As BillingResult)
	If Result.IsSuccess Then
		Wait For (billing.QueryPurchases("subs")) Billing_PurchasesQueryCompleted (Result As BillingResult, Purchases As List)
		
		If Result.IsSuccess Then
			If Purchases.Size = 0 Then
				LogColor("🛡  No active subscriptions found", UnlockManager.LOG_COLOR_LIB)
				mSubscriptionActive = False
				mActiveSubscriptionId = ""
				UnlockManager.ResetSubscriptionStatus
				Return False
			End If
			
			For Each p As Purchase In Purchases
				Wait For (HandleSubscription(p)) Complete (Success As Boolean)
				If Success Then
					Return True
				End If
			Next
			Return False
		Else
			LogColor("🛡  Query subscriptions failed: " & Result.DebugMessage, UnlockManager.LOG_COLOR_LIB_WARNING)
			Return False
		End If
	Else
		LogColor("🛡  Billing connection failed for restore: " & Result.DebugMessage, UnlockManager.LOG_COLOR_LIB_WARNING)
		Return False
	End If
	#Else If B4i
		
		' Set restore flag so events get processed
		mRestoreInProgress = True
		
		' Reset subscription state before restore
		mSubscriptionActive = False
		mActiveSubscriptionId = ""
		
		' Start restore flow
		iStore.RestoreTransactions
		
		' Wait for restore to complete
		Wait For iStore_TransactionsRestored (Success As Boolean)
		
		mRestoreInProgress = False
		
		If Success Then
			LogColor("🛡  Restore completed successfully", UnlockManager.LOG_COLOR_LIB)
			' Check if we actually found an active subscription
			Dim hasActiveSubscription As Boolean = UnlockManager.IsSubscriptionActive
			If hasActiveSubscription = False Then
				LogColor("🛡  No active subscriptions found", UnlockManager.LOG_COLOR_LIB)
				UnlockManager.ResetSubscriptionStatus
			End If
			Return hasActiveSubscription
		Else
			LogColor("🛡  No subscriptions found to restore", UnlockManager.LOG_COLOR_LIB)
			UnlockManager.ResetSubscriptionStatus
			Return False
		End If
	#Else
	Return False
	#End If
End Sub

' Start subscription purchase flow
Public Sub StartSubscriptionFlow(pProductId As String, pBasePlanId As String) As ResumableSub
	#if B4A
	mPurchaseInProgress = True
	
	Dim result As Map
	result.Initialize
	
	' Connect to billing service
	Wait For (billing.ConnectIfNeeded) Billing_Connected (BillingResult As BillingResult)
	If BillingResult.IsSuccess Then
		
		' Query subscription details
		Dim sf As Object = billing.QuerySkuDetails("subs", Array As String(pProductId))
		Wait For (sf) Billing_SkuQueryCompleted (BillingResult As BillingResult, SkuDetails As List)
		
		If BillingResult.IsSuccess And SkuDetails.Size > 0 Then
			
			' Get offer token for the base plan
			Dim sku As JavaObject = SkuDetails.Get(0)
			Dim offers As List = sku.RunMethod("getSubscriptionOfferDetails", Null)
			
			If offers.Size > 0 Then
				' Find the matching base plan
				Dim offerToken As String = ""
				For Each offer As JavaObject In offers
					Dim basePlanId As String = offer.RunMethod("getBasePlanId", Null)
					If basePlanId = pBasePlanId Then
						offerToken = offer.RunMethod("getOfferToken", Null)
						Exit
					End If
				Next
				
				If offerToken <> "" Then
					
					' Launch billing flow with offer token
					BillingResult = LaunchBillingFlow(billing, sku, offerToken)
					
					If BillingResult.IsSuccess Then
						
						' Wait for purchase to complete
						Wait For CompletePurchaseFlow
						
						mPurchaseInProgress = False
						
						result.Put("success", mPurchaseSuccess)
						If mPurchaseSuccess = False Then
							result.Put("error", mPurchaseError)
						End If
						Return result
					Else
						LogColor("🛡  Failed to launch billing flow: " & BillingResult.DebugMessage, UnlockManager.LOG_COLOR_LIB_WARNING)
						mPurchaseInProgress = False
						result.Put("success", False)
						result.Put("error", "Failed to start subscription")
						Return result
					End If
				Else
					LogColor("🛡  Base plan not found: " & pBasePlanId, UnlockManager.LOG_COLOR_LIB_WARNING)
					mPurchaseInProgress = False
					result.Put("success", False)
					result.Put("error", "Base plan not available")
					Return result
				End If
			Else
				LogColor("🛡  No offers found for subscription", UnlockManager.LOG_COLOR_LIB_WARNING)
				mPurchaseInProgress = False
				result.Put("success", False)
				result.Put("error", "No subscription offers available")
				Return result
			End If
		Else
			LogColor("🛡  Subscription not found or query failed", UnlockManager.LOG_COLOR_LIB_WARNING)
			mPurchaseInProgress = False
			result.Put("success", False)
			result.Put("error", "Subscription not available")
			Return result
		End If
	Else
		LogColor("🛡  Billing connection failed: " & BillingResult.DebugMessage, UnlockManager.LOG_COLOR_LIB_WARNING)
		mPurchaseInProgress = False
		result.Put("success", False)
		result.Put("error", "Connection failed")
		Return result
	End If
	#Else If B4i
	
	Dim result As Map
	result.Initialize
	
	' Use App Store
		
		mPurchaseInProgress = True
		
		' Request payment (iOS doesn't use base plan ID - it's Android-only)
		iStore.RequestPayment(pProductId)
		
		' Wait for the library event (this is the correct B4X pattern)
		Wait For iStore_PurchaseCompleted (Success As Boolean, Product As Purchase)
		
		mPurchaseInProgress = False
		
		' Process the subscription result HERE (not in event handler)
		If Success And Product.IsInitialized Then
			' Check if this is one of our subscriptions
			Dim matchesSubscription As Boolean = False
			For Each subscriptionMap As Map In Subscriptions
				If Product.ProductIdentifier = subscriptionMap.Get("product_id") Then
					matchesSubscription = True
					Exit
				End If
			Next
			
			If matchesSubscription Then
				' Validate subscription with backend
				Wait For (HandleIOSSubscription(Product)) Complete (active As Boolean)
				
				If active Then
					LogColor("🛡  Validation successful - subscription confirmed", UnlockManager.LOG_COLOR_LIB)
					result.Put("success", True)
				Else
					LogColor("🛡  Validation failed", UnlockManager.LOG_COLOR_LIB_WARNING)
					result.Put("success", False)
					result.Put("error", "Validation failed")
				End If
			Else
				result.Put("success", False)
				result.Put("error", "Unknown subscription")
			End If
		Else
			result.Put("success", False)
			If Success = False Then
				result.Put("error", "Subscription cancelled")
			Else
				result.Put("error", "Subscription failed")
			End If
		End If
		
		Return result
	#Else
	Dim result As Map
	result.Initialize
	result.Put("success", False)
	result.Put("error", "Unsupported platform")
	Return result
	#End If
End Sub

#if B4A
' Launch billing flow with offer token (for subscriptions)
Private Sub LaunchBillingFlow(Client As BillingClient, Sku As JavaObject, OfferToken As String) As BillingResult
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	
	' Build ProductDetailsParams with offer token
	Dim ProductDetailsParamsBuilder As JavaObject
	ProductDetailsParamsBuilder = ProductDetailsParamsBuilder.InitializeStatic("com.android.billingclient.api.BillingFlowParams.ProductDetailsParams").RunMethod("newBuilder", Null)
	ProductDetailsParamsBuilder.RunMethod("setProductDetails", Array As Object(Sku))
	ProductDetailsParamsBuilder.RunMethod("setOfferToken", Array As Object(OfferToken))
	Dim ProductDetails As List
	ProductDetails.Initialize
	ProductDetails.Add(ProductDetailsParamsBuilder.RunMethod("build", Null))
	
	' Build BillingFlowParams
	Dim BillingFlowParamsBuilder As JavaObject
	BillingFlowParamsBuilder = BillingFlowParamsBuilder.InitializeStatic("com.android.billingclient.api.BillingFlowParams").RunMethod("newBuilder", Null)
	BillingFlowParamsBuilder.RunMethod("setProductDetailsParamsList", Array As Object(ProductDetails))
	
	' Launch billing flow
	Return Client.As(JavaObject).GetFieldJO("client").RunMethod("launchBillingFlow", Array As Object(ctxt, BillingFlowParamsBuilder.RunMethod("build", Null)))
End Sub

' Handle subscription updates from Google Play
Sub billing_PurchasesUpdated (Result As BillingResult, Purchases As List)
	If Result.IsSuccess Then
		For Each p As Purchase In Purchases
			' Only process if we're in a purchase flow
			If mPurchaseInProgress Then
				Wait For (HandleSubscription(p)) Complete (Success As Boolean)
				
				' Store result for StartSubscriptionFlow
				mPurchaseSuccess = Success
				If Success = False Then
					mPurchaseError = "Validation failed"
				Else
					mPurchaseError = ""
				End If
				
				' Signal completion
				CallSubDelayed(Me, "CompletePurchaseFlow")
			End If
			Return
		Next
	Else
		LogColor("🛡  Subscription update failed: " & Result.DebugMessage, UnlockManager.LOG_COLOR_LIB_WARNING)
		If mPurchaseInProgress Then
			mPurchaseSuccess = False
			mPurchaseError = Result.DebugMessage
			CallSubDelayed(Me, "CompletePurchaseFlow")
		End If
	End If
End Sub

' Internal sub to complete purchase flow
Private Sub CompletePurchaseFlow
	' Resume the Wait For in StartSubscriptionFlow
End Sub

' Handle a single subscription
Private Sub HandleSubscription (p As Purchase) As ResumableSub
	' Check purchase state
	If p.PurchaseState <> p.STATE_PURCHASED Then
		Return False
	End If
	
	' Send purchase token to backend for validation
	Wait For (UnlockManager.ConfirmAndroidSubscription(p.Sku, p.PurchaseToken)) Complete (unlockResult As Map)
	
	Dim active As Boolean = False
	If unlockResult.ContainsKey("is_subscribed") Then
		active = unlockResult.Get("is_subscribed")
	End If
	
	' Check if this was a credit limit fallback (keep existing status)
	If unlockResult.ContainsKey("reason_code") Then
		Dim reasonCode As String = unlockResult.Get("reason_code")
		If reasonCode = "credit_limit_exceeded" Then
			LogColor("🛡  Using cached subscription status due to credit limit", UnlockManager.LOG_COLOR_LIB)
			Return mSubscriptionActive
		End If
	End If
	
	If active Then
		
		' Acknowledge the subscription if not already acknowledged
		If p.IsAcknowledged = False Then
			Wait For (billing.AcknowledgePurchase(p.PurchaseToken, "")) Billing_AcknowledgeCompleted (Result As BillingResult)
		End If
		
		' Update local state
		mSubscriptionActive = True
		mActiveSubscriptionId = p.Sku
		Return True
	Else
		LogColor("🛡  Subscription not active per server validation", UnlockManager.LOG_COLOR_LIB)
		Return False
	End If
End Sub
#End If

' Show subscription screen and handle subscription flow
Public Sub ShowSubscriptionPurchase As ResumableSub
	EnsureWebView
	wvPurchase.As(B4XView).SetLayoutAnimated(0,0,0,ParentPanel.Width,ParentPanel.Height)
	
	' Load and inject subscription HTML
	Dim html As String = mTemplates.PurchaseSubscription
	
	' Determine app name
	Dim strAppName As String = DisplayAppName
	If strAppName = "" Then
		#if B4A
		strAppName = Application.LabelName
		#Else If B4i
		strAppName = AppName
		#End If
	End If
	
	' Inject app name and tagline
	html = html.Replace("[APP_NAME]", strAppName)
	html = html.Replace("[APP_TAGLINE]", DisplayTagline)
	
	' Inject color scheme
	Dim themeColors As Map = HTMLBuilder.ApplyDefaultThemeWithDarkMode(ColorPrimary, ColorSecondary, ColorAccent, ColorBackground1, ColorBackground2, DarkMode)
	Dim primary As String = themeColors.Get("primary")
	Dim secondary As String = themeColors.Get("secondary")
	Dim accent As String = themeColors.Get("accent")
	Dim bg1 As String = themeColors.Get("bg1")
	Dim bg2 As String = themeColors.Get("bg2")
	
	' Determine if background is dark or light for text color
	Dim adaptiveColors As Map = HTMLBuilder.GetAdaptiveColors(HTMLBuilder.IsBackgroundDark(bg1))
	Dim textColor As String = adaptiveColors.Get("textColor")
	Dim textColorAlpha As String = adaptiveColors.Get("textColorAlpha")
	Dim featureBg As String = adaptiveColors.Get("featureBg")
	Dim featureBorder As String = adaptiveColors.Get("featureBorder")
	Dim featureHoverBg As String = adaptiveColors.Get("featureHoverBg")
	Dim dividerColor As String = adaptiveColors.Get("dividerColor")
	Dim overlayBg As String = adaptiveColors.Get("overlayBg")
	Dim buttonTextColor As String = adaptiveColors.Get("buttonTextColor")
	
	html = html.Replace("[COLOR_PRIMARY]", primary)
	html = html.Replace("[COLOR_SECONDARY]", secondary)
	html = html.Replace("[COLOR_ACCENT]", accent)
	html = html.Replace("[COLOR_BG1]", bg1)
	html = html.Replace("[COLOR_BG2]", bg2)
	html = html.Replace("[COLOR_PRIMARY_ALPHA]", HTMLBuilder.HexToRGBA(primary, 0.2))
	html = html.Replace("[COLOR_SECONDARY_ALPHA]", HTMLBuilder.HexToRGBA(secondary, 0.2))
	html = html.Replace("[TEXT_COLOR]", textColor)
	html = html.Replace("[TEXT_COLOR_ALPHA]", textColorAlpha)
	html = html.Replace("[FEATURE_BG]", featureBg)
	html = html.Replace("[FEATURE_BORDER]", featureBorder)
	html = html.Replace("[FEATURE_HOVER_BG]", featureHoverBg)
	html = html.Replace("[DIVIDER_COLOR]", dividerColor)
	html = html.Replace("[OVERLAY_BG]", overlayBg)
	html = html.Replace("[BUTTON_TEXT_COLOR]", buttonTextColor)
	
	' Inject features - build HTML for all features in list
	Dim featuresHTML As StringBuilder
	featuresHTML.Initialize
	If Features.IsInitialized And Features.Size > 0 Then
		For i = 0 To Features.Size - 1
			Dim feature As feature_info = Features.Get(i)
			featuresHTML.Append(HTMLBuilder.BuildFeatureHTML(feature.Emoji, feature.Title, feature.Description))
		Next
	End If
	html = html.Replace("[FEATURES]", featuresHTML.ToString)
	
	' Inject subscriptions
	html = html.Replace("[PRODUCTS]", BuildSubscriptionsHTML)
	
	' Inject working footer CSS (same approach as policy docs)
	html = AddStickySubscriptionFooter(html)
	
	' Load the injected HTML
	wvPurchase.LoadHtml(html)
	
	' Show subscription screen with animation
	wvPurchase.As(B4XView).BringToFront
	wvPurchase.As(B4XView).SetVisibleAnimated(300, True)
	
	' Fetch prices for all subscriptions (wait for completion)
	Wait For (FetchAllSubscriptionPrices) Complete (Success As Boolean)
	
	' Wait for user action
	mSubscriptionScreenActive = True
	Do While mSubscriptionScreenActive
		Sleep(100)
	Loop
	
	Return mSubscriptionScreenResult
End Sub

' Build HTML for all subscription cards
Private Sub BuildSubscriptionsHTML As String
	If Subscriptions.IsInitialized = False Or Subscriptions.Size = 0 Then
		Return ""
	End If
	
	Return HTMLBuilder.BuildSubscriptionsHTML(Subscriptions)
End Sub

' Fetch prices for all subscriptions from store
Private Sub FetchAllSubscriptionPrices As ResumableSub
	If Subscriptions.IsInitialized = False Or Subscriptions.Size = 0 Then
		Return False
	End If
	
	#if B4A
	' Build array of product IDs
	Dim productIds(Subscriptions.Size) As String
	Dim i As Int = 0
	For Each subscription As Map In Subscriptions
		productIds(i) = subscription.Get("product_id")
		i = i + 1
	Next
	
	' Query all subscriptions at once
	Wait For (billing.ConnectIfNeeded) Billing_Connected (BillingResult As BillingResult)
	If BillingResult.IsSuccess Then
		Dim sf As Object = billing.QuerySkuDetails("subs", productIds)
		Wait For (sf) Billing_SkuQueryCompleted (BillingResult As BillingResult, SkuDetails As List)
		
		If BillingResult.IsSuccess And SkuDetails.Size > 0 Then
			
			' Update each subscription price
			For Each sku As JavaObject In SkuDetails
				Try
					Dim prodId As String = sku.RunMethod("getProductId", Null)
					
					' Get subscription offer details
					Dim offers As List = sku.RunMethod("getSubscriptionOfferDetails", Null)
					If offers.Size > 0 Then
						Dim offer As JavaObject = offers.Get(0)
						Dim pricingPhases As JavaObject = offer.RunMethod("getPricingPhases", Null)
						Dim phaseList As List = pricingPhases.RunMethod("getPricingPhaseList", Null)
						
						If phaseList.Size > 0 Then
							Dim phase As JavaObject = phaseList.Get(0)
							Dim price As String = phase.RunMethod("getFormattedPrice", Null)
							
							' Skip free trial phase if present
							If price.ToLowerCase = "free" And phaseList.Size > 1 Then
								phase = phaseList.Get(1)
								price = phase.RunMethod("getFormattedPrice", Null)
							End If
							
							UpdateSubscriptionPriceInWebView(prodId, price)
						End If
					End If
				Catch
				End Try'ignore
			Next
		Else
		End If
	End If
	#Else If B4i
	' Build list of product IDs
	Dim productIds As List
	productIds.Initialize
	For Each subscription As Map In Subscriptions
		productIds.Add(subscription.Get("product_id"))
	Next
	
	' Request product information from App Store
	iStore.RequestProductsInformation(productIds)
	
	' Wait for product info to be received
	Wait For iStore_SubscriptionInformationAvailable_Complete
	#End If
	
	Return True
End Sub

#if B4i
' iOS Store: Product information received
Sub iStore_InformationAvailable (Success As Boolean, ProductsList As List)
	If Success Then
		For Each p As ProductInformation In ProductsList
			UpdateSubscriptionPriceInWebView(p.ProductIdentifier, p.LocalizedPrice)
		Next
	End If
	
	' Signal completion for Wait For pattern
	CallSubDelayed(Me, "iStore_SubscriptionInformationAvailable_Complete")
End Sub

' Internal sub for Wait For pattern
Private Sub iStore_SubscriptionInformationAvailable_Complete As ResumableSub
	Return True
End Sub
#End If

' Update a specific subscription price in the WebView
Private Sub UpdateSubscriptionPriceInWebView(pProductId As String, price As String)
	If wvPurchase.Visible Then
		Sleep(100)
		
		#if B4A
		Dim js As String = "updateProductPrice('" & pProductId & "', '" & price & "');"
		wvPurchase.As(JavaObject).RunMethod("evaluateJavascript", Array As Object(js, Null))
		#Else If B4i
		Dim js As String = "updateProductPrice('" & pProductId & "', '" & price & "');"
		wvPurchase.EvaluateJavaScript(js)
		#End If
	End If
End Sub

' Handle WebView URL overrides
Sub wvPurchase_OverrideUrl(Url As String) As Boolean
	If Url.StartsWith("b4x://") = False Then
		Return False
	End If
	
	' Parse action
	Dim action As String = Url.SubString(6)
	If action.Contains("?") Then
		action = action.SubString2(0, action.IndexOf("?"))
	End If
	
	Select action
		Case "purchase"
			' Extract product ID and base plan ID from URL
			Dim productId As String = ""
			Dim basePlanId As String = ""
			If Url.Contains("?product=") Then
				Dim params As String = Url.SubString2(Url.IndexOf("?") + 1, Url.Length)
				Dim parts() As String = Regex.Split("&", params)
				For Each part As String In parts
					If part.StartsWith("product=") Then
						productId = part.SubString(8)
						productId = DecodeUrl(productId)
					Else If part.StartsWith("plan=") Then
						basePlanId = part.SubString(5)
						basePlanId = DecodeUrl(basePlanId)
					End If
				Next
			End If
			
			If productId <> "" And basePlanId <> "" Then
				HandleSubscriptionAction(productId, basePlanId)
			End If
			
		Case "restore"
			HandleRestoreAction
			
		Case "terms"
			' Open Terms of Service
			HandleTermsAction
			
		Case "privacy"
			' Open Privacy Policy
			HandlePrivacyAction
			
		Case "accept"
			' Accept privacy/terms - reload subscription screen
			CallSubDelayed(Me, "ReloadSubscriptionScreen")
			
		Case "close"
			mSubscriptionScreenResult = False
			HideSubscriptionScreen
	End Select
	
	Return True
End Sub

' Reload subscription screen after accepting privacy/terms
Private Sub ReloadSubscriptionScreen
	Wait For (ShowSubscriptionPurchase) Complete (Success As Boolean)
End Sub

' URL decode helper
Private Sub DecodeUrl(encoded As String) As String
	encoded = encoded.Replace("%20", " ")
	encoded = encoded.Replace("%2B", "+")
	encoded = encoded.Replace("%2F", "/")
	encoded = encoded.Replace("%3D", "=")
	encoded = encoded.Replace("%26", "&")
	Return encoded
End Sub

' Handle subscription button tap
Private Sub HandleSubscriptionAction(pProductId As String, pBasePlanId As String)
	Wait For (StartSubscriptionFlow(pProductId, pBasePlanId)) Complete (result As Map)
	
	ResetSubscriptionScreenButtons
	
	Dim success As Boolean = result.Get("success")
	If success Then
		LogColor("🛡  Subscription completed and validated successfully", UnlockManager.LOG_COLOR_LIB)
		mSubscriptionScreenResult = True
		HideSubscriptionScreen
	Else
		Dim errorMsg As String = result.GetDefault("error", "Unknown error")
		LogColor("🛡  Subscription failed: " & errorMsg, UnlockManager.LOG_COLOR_LIB_WARNING)
	End If
End Sub

' Handle restore button tap
Private Sub HandleRestoreAction
	#if B4A
	' Android: Clear cache to force fresh backend validation
	UnlockManager.ResetSubscriptionStatus
	#End If
	
	Wait For (RestoreSubscriptions) Complete (Success As Boolean)
	
	ResetSubscriptionScreenButtons
	
	' Always reload cached status after restore (whether success or failure)
	UnlockManager.LoadCachedStatus
	
	If Success Then
		mSubscriptionScreenResult = True
		HideSubscriptionScreen
	Else
		' Don't close screen - let user try purchasing instead
	End If
End Sub

' Handle Terms of Service link
Private Sub HandleTermsAction
	ShowPrivacyInPurchaseWebView("Terms of Service", "app-terms-of-service.html")
End Sub

' Handle Privacy Policy link
Private Sub HandlePrivacyAction
	ShowPrivacyInPurchaseWebView("Privacy Policy", "app-privacy-policy-subscription.html")
End Sub

' Show privacy/terms in purchase WebView with sticky Accept button
Private Sub ShowPrivacyInPurchaseWebView(Title As String, HtmlFile As String)
	EnsureWebView
	Dim contentHtml As String
	Dim isURL As Boolean = False
	
	' Check if custom content is provided based on file type
	If HtmlFile.Contains("privacy-policy-subscription") And CustomPrivacyPolicySubscription <> "" Then
		If CustomPrivacyPolicySubscription.StartsWith("http://") Or CustomPrivacyPolicySubscription.StartsWith("https://") Then
			isURL = True
			contentHtml = CustomPrivacyPolicySubscription
		Else
			contentHtml = CustomPrivacyPolicySubscription
		End If
	Else If HtmlFile.Contains("terms-of-service") And CustomTermsOfService <> "" Then
		If CustomTermsOfService.StartsWith("http://") Or CustomTermsOfService.StartsWith("https://") Then
			isURL = True
			contentHtml = CustomTermsOfService
		Else
			contentHtml = CustomTermsOfService
		End If
	Else
		' Use built-in template - generate based on file type
		If HtmlFile.Contains("terms-of-service") Then
			contentHtml = GenerateTermsOfServiceHTML
		Else If HtmlFile.Contains("privacy-policy-subscription") Then
			contentHtml = GeneratePrivacyPolicySubscriptionHTML
		Else If HtmlFile.Contains("privacy-policy-inapp") Then
			contentHtml = GeneratePrivacyPolicyInappHTML
		Else
			' Default to subscription privacy policy
			contentHtml = GeneratePrivacyPolicySubscriptionHTML
		End If
	End If
	
	' If it's a URL, we need to wrap it in an iframe with sticky button
	If isURL Then
		' Create wrapper HTML with iframe and sticky button
		Dim themeColors As Map = HTMLBuilder.ApplyDefaultThemeWithDarkMode(ColorPrimary, ColorSecondary, ColorAccent, ColorBackground1, ColorBackground2, DarkMode)
		Dim primary As String = themeColors.Get("primary")
		Dim bg1 As String = themeColors.Get("bg1")
		Dim adaptiveColors As Map = HTMLBuilder.GetAdaptiveColors(HTMLBuilder.IsBackgroundDark(bg1))
		Dim buttonTextColor As String = adaptiveColors.Get("buttonTextColor")
		
		Dim wrapperHtml As String = $"<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
html, body { height: 100%; overflow: hidden; }
body { display: flex; flex-direction: column; background: ${bg1}; }
.iframe-wrapper { flex: 1; overflow: hidden; }
iframe { width: 100%; height: 100%; border: none; }
.sticky-footer { flex-shrink: 0; padding: 1rem; background: ${bg1}; border-top: 1px solid rgba(255,255,255,0.1); }
.btn-accept { width: 100%; padding: 0.9rem; font-size: 1rem; font-weight: 600; color: ${buttonTextColor}; background: linear-gradient(135deg, ${primary}, ${primary}); border: none; border-radius: 0.7rem; cursor: pointer; }
</style>
</head>
<body>
<div class="iframe-wrapper"><iframe src="${contentHtml}"></iframe></div>
<div class="sticky-footer"><button class="btn-accept" onclick="window.location='b4x://accept'">Accept</button></div>
</body>
</html>"$
		
		wvPurchase.LoadHtml(wrapperHtml)
	Else
		' Add sticky button to existing HTML content
		contentHtml = AddStickyAcceptButton(contentHtml)
		wvPurchase.LoadHtml(contentHtml)
	End If
	
	' Show purchase WebView (already visible, just reload content)
	LogColor("🛡  " & Title & " displayed in purchase WebView", UnlockManager.LOG_COLOR_LIB)
End Sub

' Add sticky Accept button to HTML content
Private Sub AddStickyAcceptButton(html As String) As String
	' Apply theme colors
	Dim themeColors As Map = HTMLBuilder.ApplyDefaultThemeWithDarkMode(ColorPrimary, ColorSecondary, ColorAccent, ColorBackground1, ColorBackground2, DarkMode)
	Dim primary As String = themeColors.Get("primary")
	Dim bg1 As String = themeColors.Get("bg1")
	Dim adaptiveColors As Map = HTMLBuilder.GetAdaptiveColors(HTMLBuilder.IsBackgroundDark(bg1))
	Dim buttonTextColor As String = adaptiveColors.Get("buttonTextColor")
	
	' Add flexbox layout and sticky footer styles
	Dim stickyStyles As String = $"
<style>
html, body { height: 100%; overflow: hidden; margin: 0; }
body { display: flex !important; flex-direction: column !important; }
.content-wrapper { flex: 1; overflow-y: auto; -webkit-overflow-scrolling: touch; padding: 1rem; padding-bottom: 5rem; }
.sticky-footer { position: fixed; bottom: 0; left: 0; right: 0; padding: 1rem; background: rgba(0,0,0,0.3); backdrop-filter: blur(10px); -webkit-backdrop-filter: blur(10px); border-top: 1px solid rgba(255,255,255,0.1); z-index: 1000; }
.btn-accept { width: 100%; padding: 0.9rem; font-size: 1rem; font-weight: 600; color: ${buttonTextColor}; background: linear-gradient(135deg, ${primary}, ${primary}); border: none; border-radius: 0.7rem; cursor: pointer; transition: all 0.3s ease; }
.btn-accept:active { transform: scale(0.98); }
</style>"$
	
	' Wrap existing body content in scrollable wrapper and add sticky footer
	html = html.Replace("</head>", stickyStyles & "</head>")
	html = html.Replace("<body>", "<body><div class='content-wrapper'>")
	
	' Build the footer HTML separately to avoid quote issues
	Dim footerHtml As String = "</div><div class='sticky-footer'><button class='btn-accept' onclick=" & Chr(34) & "window.location='b4x://accept'" & Chr(34) & ">Accept</button></div></body>"
	html = html.Replace("</body>", footerHtml)
	
	Return html
End Sub

' Inject working footer CSS into subscription screen (same approach as policy docs)
Private Sub AddStickySubscriptionFooter(html As String) As String
	' Apply theme colors
	Dim themeColors As Map = HTMLBuilder.ApplyDefaultThemeWithDarkMode(ColorPrimary, ColorSecondary, ColorAccent, ColorBackground1, ColorBackground2, DarkMode)
	Dim bg1 As String = themeColors.Get("bg1")
	
	' Inject working footer CSS that matches policy docs approach
	Dim footerFix As String = $"
<style>
/* Override body and footer - simplified approach */
html, body {
    height: 100% !important;
    margin: 0 !important;
    padding: 0 !important;
    overflow-y: auto !important;
    -webkit-overflow-scrolling: touch !important;
    background: ${bg1} !important;
}
.container {
    padding-bottom: 5rem !important;
}
.legal-footer {
    position: fixed !important;
    bottom: 0 !important;
    left: 0 !important;
    right: 0 !important;
    background: rgba(0,0,0,0.3) !important;
    backdrop-filter: blur(10px) !important;
    -webkit-backdrop-filter: blur(10px) !important;
    border-top: 1px solid rgba(255,255,255,0.1) !important;
    z-index: 1000 !important;
}
</style>
</head>"$
	
	html = html.Replace("</head>", footerFix)
	
	Return html
End Sub

' Reset subscription screen buttons
Public Sub ResetSubscriptionScreenButtons
	If wvPurchase.Visible Then
		#if B4A
		wvPurchase.As(JavaObject).RunMethod("evaluateJavascript", Array As Object("resetButtons();", Null))
		#Else If B4i
		wvPurchase.EvaluateJavaScript("resetButtons();")
		#End If
	End If
End Sub

' Check if subscription screen is active
Public Sub IsActive As Boolean
	If mWebViewInitialized = False Then Return False
	Return wvPurchase.Visible
End Sub

' Hide subscription screen
Public Sub HideSubscriptionScreen
	mSubscriptionScreenActive = False
	If mWebViewInitialized Then wvPurchase.Visible = False
End Sub







#if B4i
' iOS Store: Purchase completed (also called for restored subscriptions)
Sub iStore_PurchaseCompleted (Success As Boolean, Product As Purchase)
	' Ignore automatic startup notifications unless we're in an active purchase/restore flow
	If mPurchaseInProgress = False And mRestoreInProgress = False Then
		' Silently ignore - iOS sends these at startup
		Return
	End If
	
	If Success And Product.IsInitialized Then
		' DEDUPLICATION: Check if we've already processed this transaction
		If mProcessedTransactions.IndexOf(Product.TransactionIdentifier) >= 0 Then
			' Silently skip duplicates - iOS sends many during restore
			Return
		End If
		
		' Mark transaction as processed
		mProcessedTransactions.Add(Product.TransactionIdentifier)
		
		' Only log during actual purchase, not during restore
		If mPurchaseInProgress Then
		End If
		
		' Check if this is one of our subscriptions
		Dim matchesSubscription As Boolean = False
		For Each subscriptionMap As Map In Subscriptions
			If Product.ProductIdentifier = subscriptionMap.Get("product_id") Then
				matchesSubscription = True
				Exit
			End If
		Next
		
		If matchesSubscription Then
			' Only validate during purchase flow, not during restore
			If mRestoreInProgress Then
				mSubscriptionActive = True
				mActiveSubscriptionId = Product.ProductIdentifier
			Else
				' Validate subscription with backend during purchase
				Wait For (HandleIOSSubscription(Product)) Complete (active As Boolean)
				
				If active Then
					LogColor("🛡  Validation successful - subscription confirmed", UnlockManager.LOG_COLOR_LIB)
				Else
					LogColor("🛡  Validation failed", UnlockManager.LOG_COLOR_LIB_WARNING)
				End If
			End If
		Else
			' Not our subscription - ignore silently (probably handled by clsInapp)
			Return
		End If
	Else
		' No need to signal - Wait For will resume automatically when this event handler completes
	End If
End Sub

' iOS Store: Restore transactions completed
Sub iStore_TransactionsRestored (Success As Boolean)
	LogColor("🛡  Transactions restored: " & Success, UnlockManager.LOG_COLOR_LIB)
	
	If Success Then
		LogColor("🛡  Restore completed successfully", UnlockManager.LOG_COLOR_LIB)
		' Note: iStore_PurchaseCompleted was already called for each restored subscription
		' Clear processed transactions list after restore completes
		mProcessedTransactions.Clear
	Else
		LogColor("🛡  Restore failed", UnlockManager.LOG_COLOR_LIB_WARNING)
	End If
End Sub

' Handle iOS subscription validation
Private Sub HandleIOSSubscription (Product As Purchase) As ResumableSub
	' Get the App Store receipt
	Dim no As NativeObject = Me
	Dim receiptData As String = no.RunMethod("getReceipt", Null).AsString
	
	If receiptData = "" Then
		Return False
	End If
	
	' Send receipt to backend for validation
	Wait For (UnlockManager.ConfirmIOSSubscription(receiptData)) Complete (unlockResult As Map)
	
	Dim active As Boolean = False
	If unlockResult.ContainsKey("is_subscribed") Then
		active = unlockResult.Get("is_subscribed")
	End If
	
	' Check if this was a credit limit fallback (keep existing status)
	If unlockResult.ContainsKey("reason_code") Then
		Dim reasonCode As String = unlockResult.Get("reason_code")
		If reasonCode = "credit_limit_exceeded" Then
			LogColor("🛡  Using cached subscription status due to credit limit", UnlockManager.LOG_COLOR_LIB)
			Return mSubscriptionActive
		End If
	End If
	
	If active Then
		mSubscriptionActive = True
		mActiveSubscriptionId = Product.ProductIdentifier
		Return True
	Else
		LogColor("🛡  Subscription not active per server validation", UnlockManager.LOG_COLOR_LIB)
		Return False
	End If
End Sub

#if OBJC
- (NSString *)getReceipt {
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    if (receiptData == nil) {
        return @"";
    }
    NSString *receiptString = [receiptData base64EncodedStringWithOptions:0];
    return receiptString;
}
#End If
#End If


#if B4i
' iOS helper to get app name
Sub AppName As String
	Dim no As NativeObject
	no = no.Initialize("NSBundle").RunMethod("mainBundle", Null)
	Dim name As Object = no.RunMethod("objectForInfoDictionaryKey:", Array As Object("CFBundleDisplayName"))
	Return name
End Sub
#End If

' ========================================
' Testing Helper Methods
' ========================================

' Reset subscription for testing
' Reset subscription for testing
' Android: Consumes the subscription token (allows re-subscribing)
' iOS: Clears local cache and forces validation (does NOT remove subscription from App Store)
'
' IMPORTANT FOR iOS TESTING:
' This method cannot remove subscriptions from App Store Sandbox.
' To fully reset iOS subscriptions for testing:
' 1. On iOS device: Settings → App Store → Sandbox Account
' 2. Tap "Clear Purchase History"
' 3. This removes ALL sandbox purchases/subscriptions for that account
' OR use multiple Sandbox test accounts (each can subscribe once)
'
' pProductId: Optional - if empty, resets first subscription in list
Public Sub ResetSubscriptionForTesting(pProductId As String) As ResumableSub
	#if B4A
	
	' If no product ID specified, use first subscription in list
	If pProductId = "" And Subscriptions.IsInitialized And Subscriptions.Size > 0 Then
		Dim firstSub As Map = Subscriptions.Get(0)
		pProductId = firstSub.Get("product_id")
	End If
	
	If pProductId = "" Then
		LogColor("🛡  No product ID specified and no subscriptions in list", UnlockManager.LOG_COLOR_LIB_WARNING)
		Return False
	End If
	
	Wait For (billing.ConnectIfNeeded) Billing_Connected (Result As BillingResult)
	If Result.IsSuccess Then
		Wait For (billing.QueryPurchases("subs")) Billing_PurchasesQueryCompleted (Result As BillingResult, Purchases As List)
		
		If Result.IsSuccess Then
			For Each p As Purchase In Purchases
				If p.Sku = pProductId Then
					Wait For (billing.Consume(p.PurchaseToken, "")) Billing_ConsumeCompleted (Result As BillingResult)
					
					If Result.IsSuccess Then
						' Clear cache in UnlockManager
						UnlockManager.ResetSubscriptionStatus
						Return True
					Else
						Return False
					End If
				End If
			Next
		End If
		
		Return False
	Else
		LogColor("🛡  Billing connection failed: " & Result.DebugMessage, UnlockManager.LOG_COLOR_LIB_WARNING)
		Return False
	End If
	#Else
	' iOS: Cannot consume subscriptions like Android
	' Subscriptions expire quickly in Sandbox anyway (5-30 minutes)
	' To reset iOS subscriptions for testing:
	' Settings → App Store → Sandbox Account → Clear Purchase History
	' OR use multiple Sandbox test accounts
	Return False
	#End If
End Sub

' ========================================
' Export Helper Methods (Internal)
' ========================================

' Generate fully-rendered Privacy Policy HTML for in-app purchases (for export)
' Returns the complete HTML with all placeholders filled
Public Sub GeneratePrivacyPolicyInappHTML As String
	Return GeneratePrivacyHTML(mTemplates.PolicyInapp)
End Sub

' Generate fully-rendered Privacy Policy HTML for subscriptions (for export)
' Returns the complete HTML with all placeholders filled
Public Sub GeneratePrivacyPolicySubscriptionHTML As String
	Return GeneratePrivacyHTML(mTemplates.PolicySubscription)
End Sub

' Generate fully-rendered Terms of Service HTML (for export)
' Returns the complete HTML with all placeholders filled
Public Sub GenerateTermsOfServiceHTML As String
	Return GeneratePrivacyHTML(mTemplates.PolicyToS)
End Sub

' Internal helper to generate privacy/terms HTML
Private Sub GeneratePrivacyHTML(html As String) As String

	' Determine app name
	Dim strAppName As String = DisplayAppName
	If strAppName = "" Then
		#if B4A
		strAppName = Application.LabelName
		#End If
	End If
	
	' Generate effective date
	Dim exportDate As String
	If PolicyEffectiveDate <> "" Then
		exportDate = PolicyEffectiveDate
	Else
		exportDate = UnlockManager.DEFAULT_EFFECTIVE_DATE
	End If
	
	' Replace placeholders
	html = html.Replace("[APP_NAME]", strAppName)
	html = html.Replace("[COMPANY_NAME]", IIf(PolicyCompanyName = "", "This company", PolicyCompanyName))
	If PolicyEmailAddress <> "" Then
		html = html.Replace("[CONTACT_EMAIL]", PolicyEmailAddress)
	Else
		html = html.Replace("contact:" & CRLF & Chr(9) & "<a href=""mailto:[CONTACT_EMAIL]"">[CONTACT_EMAIL]</a>.", "contact us.")
		html = html.Replace("contact:" & CRLF & "<a href=""mailto:[CONTACT_EMAIL]"">[CONTACT_EMAIL]</a>.", "contact us.")
	End If
	html = html.Replace("[EFFECTIVE_DATE]", exportDate)
	
	' Apply theme colors
	Dim themeColors As Map = HTMLBuilder.ApplyDefaultThemeWithDarkMode(ColorPrimary, ColorSecondary, ColorAccent, ColorBackground1, ColorBackground2, DarkMode)
	Dim bg1 As String = themeColors.Get("bg1")
	Dim adaptiveColors As Map = HTMLBuilder.GetAdaptiveColors(HTMLBuilder.IsBackgroundDark(bg1))
	Dim textColor As String = adaptiveColors.Get("textColor")
	Dim linkColor As String = themeColors.Get("primary")
	
	' Inject theme colors into HTML
	html = html.Replace("background-color: #1a1a1f;", "background-color: " & bg1 & ";")
	html = html.Replace("color: #e4e4e8;", "color: " & textColor & ";")
	html = html.Replace("color: #ffffff;", "color: " & textColor & ";")
	html = html.Replace("color: #b48cff;", "color: " & linkColor & ";")
	
	Return html
End Sub


