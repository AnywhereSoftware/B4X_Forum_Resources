B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#ModuleVisibility: B4XLib
' clsInapp - Android In-App Purchase Handler
' Manages one-time unlock purchases via Google Play Billing Library 3
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
	
	' Product list for multiple products
	Public Products As List  ' List of product_info types
	
	' Purchase screen customization
	Public DisplayAppName As String = ""  ' Leave empty to use Application.LabelName
	Public DisplayTagline As String = "Unlock the Full Experience"  ' Subtitle text
	Public DisplayPrice As String = ""  ' Deprecated - prices fetched per product
	
	' Privacy Policy customization (optional for in-app purchases)
	Public PolicyCompanyName As String = ""  ' Your company name
	Public PolicyEmailAddress As String = ""  ' Support email address
	Public PolicyEffectiveDate As String = ""  ' Effective date (e.g., "January 1, 2025")
	Public CustomPrivacyPolicyInapp As String = ""
	Public CustomPrivacyPolicySubscription As String = ""
	Public CustomTermsOfService As String = ""
	
	' Color scheme customization
	Public ColorPrimary As String = ""  ' Leave empty for default theme
	Public ColorSecondary As String = ""  ' Leave empty to match primary (no gradient)
	Public ColorAccent As String = ""  ' Leave empty to match primary
	Public ColorBackground1 As String = ""  ' Leave empty for default theme
	Public ColorBackground2 As String = ""  ' Leave empty to match bg1 (solid color)
	
	' Dark mode toggle
	Public DarkMode As Boolean = False  ' Set to True for dark theme (overrides color properties)
	
	' Feature customization (dynamic list)
	Public Features As List
	
	' State
	Private mIsInitialized As Boolean = False
	Private mUnlockedState As Boolean = False
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
	Private mPurchaseScreenResult As Boolean
	Private mPurchaseScreenActive As Boolean
	
	' Views
	Private wvPurchase As WebView
	Private mWebViewInitialized As Boolean = False
End Sub

' Product info type
Public Sub CreateProductInfo(pProductId As String, pTitle As String, pDescription As String, pIsConsumable As Boolean, pQuantity As Int) As Map
	Dim product As Map
	product.Initialize
	product.Put("product_id", pProductId)
	product.Put("title", pTitle)
	product.Put("description", pDescription)
	product.Put("price", "...")  ' Will be fetched from store
	product.Put("is_consumable", pIsConsumable)
	product.Put("quantity", pQuantity)
	Return product
End Sub

' Add a product to the purchase screen
Public Sub AddProduct(pProductId As String, pTitle As String, pDescription As String)
	AddProductWithType(pProductId, pTitle, pDescription, False, 0)  ' Default: non-consumable
End Sub

' Add a consumable product to the purchase screen
' pQuantity: Number of consumables to award per purchase (e.g., 10 for a "10 Credits" pack)
Public Sub AddConsumableProduct(pProductId As String, pTitle As String, pDescription As String, pQuantity As Int)
	AddProductWithType(pProductId, pTitle, pDescription, True, pQuantity)
End Sub

' Internal: Add product with type
Private Sub AddProductWithType(pProductId As String, pTitle As String, pDescription As String, pIsConsumable As Boolean, pQuantity As Int)
	If Products.IsInitialized = False Then
		Products.Initialize
	End If
	Products.Add(CreateProductInfo(pProductId, pTitle, pDescription, pIsConsumable, pQuantity))
End Sub

' Clear all products
Public Sub ClearProducts
	If Products.IsInitialized Then
		Products.Clear
	Else
		Products.Initialize
	End If
End Sub

' Initialize billing system
' Parent: The parent panel where the purchase screen will be displayed
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
	
	#Else
	LogColor("🛡  clsInapp: Unsupported platform", UnlockManager.LOG_COLOR_LIB_WARNING)
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
	wvPurchase.Color = Colors.Black
	#End If
End Sub

' Check if billing is initialized
Public Sub IsInitialized As Boolean
	Return mIsInitialized
End Sub

' Get current unlock status (cached)
Public Sub IsUnlocked As Boolean
	Return mUnlockedState
End Sub

' Force backend validation (for ValidateNow - bypasses restore flow)
' This gets the current receipt and validates with backend regardless of restore state
Public Sub ForceValidate As ResumableSub
	#if B4A
	' For Android, just use restore flow (it always validates with backend)
	Wait For (RestorePurchases) Complete (Success As Boolean)
	Return Success
	#Else If B4i
	
	' Get the App Store receipt
	Dim no As NativeObject = Me
	Dim receiptData As String = no.RunMethod("getReceipt", Null).AsString
	If receiptData = "" Then
		LogColor("🛡  No receipt available from App Store", UnlockManager.LOG_COLOR_LIB_WARNING)
		Return False
	End If
	
	Wait For (UnlockManager.ConfirmIOSUnlock(receiptData)) Complete (unlockResult As Map)
	
	Dim unlocked As Boolean = False
	If unlockResult.ContainsKey("is_unlocked") Then
		unlocked = unlockResult.Get("is_unlocked")
		mUnlockedState = unlocked
	End If
	
	Return unlocked
	#End If
End Sub

' Restore purchases (check for existing purchases)
' Call this on app launch to restore previous purchases
Public Sub RestorePurchases As ResumableSub
	#if B4A
	
	Wait For (billing.ConnectIfNeeded) Billing_Connected (Result As BillingResult)
	If Result.IsSuccess Then
		
		Dim foundAnything As Boolean = False
		
		' Query both inapp and subs (we don't know which type the products are)
		Wait For (billing.QueryPurchases("inapp")) Billing_PurchasesQueryCompleted (Result As BillingResult, Purchases As List)
		
		If Result.IsSuccess And Purchases.Size > 0 Then
			' Check if any purchase matches our products
			For Each p As Purchase In Purchases
				For Each product As Map In Products
					If p.Sku = product.Get("product_id") Then
						' Skip consumables during restore — they are handled in the purchase flow
						Dim isConsumable As Boolean = product.GetDefault("is_consumable", False)
						If isConsumable Then Continue
						
						Wait For (HandlePurchase(p)) Complete (Success As Boolean)
						If Success Then
							foundAnything = True
						End If
					End If
				Next
			Next
		End If
		
		' Also try subscriptions
		Wait For (billing.QueryPurchases("subs")) Billing_PurchasesQueryCompleted (Result As BillingResult, Purchases As List)
		
		If Result.IsSuccess And Purchases.Size > 0 Then
			For Each p As Purchase In Purchases
				For Each product As Map In Products
					If p.Sku = product.Get("product_id") Then
						' Skip consumables during restore
						Dim isConsumable As Boolean = product.GetDefault("is_consumable", False)
						If isConsumable Then Continue
						
						Wait For (HandlePurchase(p)) Complete (Success As Boolean)
						If Success Then
							foundAnything = True
						End If
					End If
				Next
			Next
		End If
		
		If foundAnything Then
			Return True
		Else
			Return False
		End If
	Else
		LogColor("🛡  Billing connection failed for restore: " & Result.DebugMessage, UnlockManager.LOG_COLOR_LIB_WARNING)
		Return False
	End If
	
	#Else If B4i
	
	' Use App Store
		
		' Set restore flag so events get processed
		mRestoreInProgress = True
		
		' Reset unlock state before restore
		mUnlockedState = False
		
		' Start restore flow
		iStore.RestoreTransactions
		
		' Wait for restore to complete
		Wait For iStore_TransactionsRestored (Success As Boolean)
		
		mRestoreInProgress = False
		
		If Success Then
			LogColor("🛡  Restore completed successfully", UnlockManager.LOG_COLOR_LIB)
			' Check if we actually found anything (unlock OR subscription)
			Dim hasUnlock As Boolean = UnlockManager.IsUnlocked
			Dim hasSubscription As Boolean = UnlockManager.IsSubscriptionActive
			
			If hasUnlock Then
				LogColor("🛡  Found non-consumable purchase", UnlockManager.LOG_COLOR_LIB)
			End If
			If hasSubscription Then
				LogColor("🛡  Found active subscription", UnlockManager.LOG_COLOR_LIB)
			End If
			
			Dim hasAnything As Boolean = hasUnlock Or hasSubscription
			If hasAnything = False Then
				LogColor("🛡  No active purchases or subscriptions found", UnlockManager.LOG_COLOR_LIB)
			End If
			
			Return hasAnything
		Else
			LogColor("🛡  No purchases found to restore", UnlockManager.LOG_COLOR_LIB)
			Return False
		End If
	#Else
	Return False
	#End If
End Sub

' Show processing overlay (for direct purchases without purchase screen)
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

' Start purchase flow
' Call this when user taps "Purchase" button
' pProductId: The product ID to purchase
' Returns Map with: success (Boolean), error (String if failed)
Public Sub StartPurchaseFlow(pProductId As String) As ResumableSub
	#if B4A
	mPurchaseInProgress = True
	
	Dim result As Map
	result.Initialize
	
	' Connect to billing service
	Wait For (billing.ConnectIfNeeded) Billing_Connected (BillingResult As BillingResult)
	If BillingResult.IsSuccess Then
		
		' Try inapp first
		Dim sf As Object = billing.QuerySkuDetails("inapp", Array As String(pProductId))
		Wait For (sf) Billing_SkuQueryCompleted (BillingResult As BillingResult, SkuDetails As List)
		
		' If not found in inapp, try subs
		If BillingResult.IsSuccess = False Or SkuDetails.Size = 0 Then
			sf = billing.QuerySkuDetails("subs", Array As String(pProductId))
			Wait For (sf) Billing_SkuQueryCompleted (BillingResult As BillingResult, SkuDetails As List)
		End If
		
		If BillingResult.IsSuccess And SkuDetails.Size > 0 Then
			
			' Launch billing flow (works for both inapp and subs)
			BillingResult = billing.LaunchBillingFlow(SkuDetails.Get(0))
			
			If BillingResult.IsSuccess Then
				
				' Wait for purchase to complete (triggered by billing_PurchasesUpdated)
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
				result.Put("error", "Failed to start purchase")
				Return result
			End If
		Else
			LogColor("🛡  Product not found or query failed", UnlockManager.LOG_COLOR_LIB_WARNING)
			mPurchaseInProgress = False
			result.Put("success", False)
			result.Put("error", "Product not available")
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
		
		' Request payment
		iStore.RequestPayment(pProductId)
		
		' Wait for the library event (this is the correct B4X pattern)
		Wait For iStore_PurchaseCompleted (Success As Boolean, Product As Purchase)
		
		mPurchaseInProgress = False
		
		' Process the purchase result HERE (not in event handler)
		If Success And Product.IsInitialized Then
			' Check if this is one of our products
			Dim matchesProduct As Boolean = False
			Dim isConsumable As Boolean = False
			For Each productMap As Map In Products
				If Product.ProductIdentifier = productMap.Get("product_id") Then
					matchesProduct = True
					isConsumable = productMap.GetDefault("is_consumable", False)
					Exit
				End If
			Next
			
			If matchesProduct Then
				If isConsumable Then
					' Consumable: Add to count
					Dim previousCount As Int = UnlockManager.GetConsumableCount
					UnlockManager.AddConsumables(1)
					Dim newCount As Int = UnlockManager.GetConsumableCount
					
					If newCount > previousCount Then
						LogColor("🛡  Consumable added successfully (count: " & previousCount & " → " & newCount & ")", UnlockManager.LOG_COLOR_LIB)
						result.Put("success", True)
					Else
						LogColor("🛡  Failed to add consumable (count unchanged: " & previousCount & ")", UnlockManager.LOG_COLOR_LIB_WARNING)
						result.Put("success", False)
						result.Put("error", "Failed to add consumable")
					End If
				Else
					' Non-consumable: Validate with backend
					Wait For (HandleIOSPurchase) Complete (unlocked As Boolean)
					
					If unlocked Then
						LogColor("🛡  Validation successful", UnlockManager.LOG_COLOR_LIB)
						result.Put("success", True)
					Else
						LogColor("🛡  Validation failed", UnlockManager.LOG_COLOR_LIB_WARNING)
						result.Put("success", False)
						result.Put("error", "Validation failed")
					End If
				End If
			Else
				result.Put("success", False)
				result.Put("error", "Unknown product")
			End If
		Else
			result.Put("success", False)
			If Success = False Then
				result.Put("error", "Purchase cancelled")
			Else
				result.Put("error", "Purchase failed")
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
' Handle purchase updates from Google Play
' This is called automatically by BillingLibrary3
Sub billing_PurchasesUpdated (Result As BillingResult, Purchases As List)
	
	If Result.IsSuccess Then
		For Each p As Purchase In Purchases
			' Check if this purchase matches any of our products
			Dim matchesProduct As Boolean = False
			For Each product As Map In Products
				If p.Sku = product.Get("product_id") Then
					matchesProduct = True
					Exit
				End If
			Next
			
			If matchesProduct Then
				' Only process if we're in a purchase flow
				If mPurchaseInProgress Then
					Wait For (HandlePurchase(p)) Complete (Success As Boolean)
					
					' Store result for StartPurchaseFlow
					mPurchaseSuccess = Success
					If Success = False Then
						mPurchaseError = "Validation failed"
					Else
						mPurchaseError = ""
					End If
					
					' Signal completion to StartPurchaseFlow
					CallSubDelayed(Me, "CompletePurchaseFlow")
				End If
				Return
			End If
		Next
	Else
		LogColor("🛡  Purchase update failed: " & Result.DebugMessage, UnlockManager.LOG_COLOR_LIB_WARNING)
		If mPurchaseInProgress Then
			mPurchaseSuccess = False
			mPurchaseError = Result.DebugMessage
			CallSubDelayed(Me, "CompletePurchaseFlow")
		End If
	End If
End Sub

' Internal sub to complete purchase flow
Private Sub CompletePurchaseFlow
	' Resume the Wait For in StartPurchaseFlow
End Sub

' Handle a single purchase
' Returns True if purchase was successfully validated and unlocked
Private Sub HandlePurchase (p As Purchase) As ResumableSub
	
	' Check purchase state
	If p.PurchaseState <> p.STATE_PURCHASED Then
		Return False
	End If
	
	' Verify purchase signature (skip for test products)
	If p.Sku.StartsWith("android.test") = False And billing.VerifyPurchase(p, BillingKey) = False Then
		Return False
	End If
	
	' Check if this is a consumable
	Dim isConsumable As Boolean = False
	Dim quantity As Int = 1
	For Each productMap As Map In Products
		If p.Sku = productMap.Get("product_id") Then
			isConsumable = productMap.GetDefault("is_consumable", False)
			quantity = productMap.GetDefault("quantity", 1)
			Exit
		End If
	Next
	
	If isConsumable Then
		' Consumable: Add to count and consume (no backend validation needed)
		Dim previousCount As Int = UnlockManager.GetConsumableCount
		UnlockManager.AddConsumables(quantity)
		Dim newCount As Int = UnlockManager.GetConsumableCount
		LogColor("🛡  Consumable added x" & quantity & " (count: " & previousCount & " → " & newCount & ")", UnlockManager.LOG_COLOR_LIB)
		
		' Consume the purchase so it can be purchased again
		Wait For (billing.Consume(p.PurchaseToken, "")) Billing_ConsumeCompleted (Result As BillingResult)
		
		If Result.IsSuccess Then
			LogColor("🛡  Purchase consumed successfully", UnlockManager.LOG_COLOR_LIB)
			Return True
		Else
			Return False
		End If
	Else
		' Non-consumable: Validate with backend
		
		' Send purchase token to backend for validation
		Wait For (UnlockManager.ConfirmAndroidUnlock(p.Sku, p.PurchaseToken)) Complete (unlockResult As Map)
		
		Dim unlocked As Boolean = False
		If unlockResult.ContainsKey("is_unlocked") Then
			unlocked = unlockResult.Get("is_unlocked")
		End If
		
		' Check if this was a credit limit fallback (keep existing status)
		If unlockResult.ContainsKey("reason_code") Then
			Dim reasonCode As String = unlockResult.Get("reason_code")
			If reasonCode = "credit_limit_exceeded" Then
				LogColor("🛡  Using cached unlock status due to credit limit", UnlockManager.LOG_COLOR_LIB)
				' Keep current local state unchanged
				Return mUnlockedState
			End If
		End If
		
		If unlocked Then
			
			' Acknowledge the purchase if not already acknowledged
			If p.IsAcknowledged = False Then
				Wait For (billing.AcknowledgePurchase(p.PurchaseToken, "")) Billing_AcknowledgeCompleted (Result As BillingResult)
			End If
			
			' Update local state
			mUnlockedState = True
			Return True
		Else
			LogColor("🛡  Unlock not active per server validation", UnlockManager.LOG_COLOR_LIB)
			Return False
		End If
	End If
End Sub
#End If

' FOR TESTING ONLY: Reset purchase (consume it)
' This allows you to test the purchase flow multiple times
' Only works with test products or in debug builds
' Reset purchase for testing
' Android: Consumes the purchase token (allows re-purchasing)
' iOS: Clears local cache and forces validation (does NOT remove purchase from App Store)
'
' IMPORTANT FOR iOS TESTING:
' This method cannot remove purchases from App Store Sandbox.
' To fully reset iOS purchases for testing:
' 1. On iOS device: Settings → App Store → Sandbox Account
' 2. Tap "Clear Purchase History"
' 3. This removes ALL sandbox purchases for that account
' OR use multiple Sandbox test accounts (each can purchase once)
'
' pProductId: Optional - if empty, resets all products in Products list
Public Sub ResetPurchaseForTesting(pProductId As String) As ResumableSub
	#if B4A
	
	' If no product ID specified, use first product in list
	If pProductId = "" And Products.IsInitialized And Products.Size > 0 Then
		Dim firstProduct As Map = Products.Get(0)
		pProductId = firstProduct.Get("product_id")
	End If
	
	If pProductId = "" Then
		LogColor("🛡  No product ID specified and no products in list", UnlockManager.LOG_COLOR_LIB_WARNING)
		Return False
	End If
	
	Wait For (billing.ConnectIfNeeded) Billing_Connected (Result As BillingResult)
	If Result.IsSuccess Then
		' Try inapp first
		Wait For (billing.QueryPurchases("inapp")) Billing_PurchasesQueryCompleted (Result As BillingResult, Purchases As List)
		
		If Result.IsSuccess Then
			For Each p As Purchase In Purchases
				If p.Sku = pProductId Then
					Wait For (billing.Consume(p.PurchaseToken, "")) Billing_ConsumeCompleted (Result As BillingResult)
					
					If Result.IsSuccess Then
						LogColor("🛡  Purchase consumed successfully", UnlockManager.LOG_COLOR_LIB)
						mUnlockedState = False
						' Clear cache in UnlockManager
						UnlockManager.ResetUnlockStatus
						Return True
					Else
						LogColor("🛡  Failed to consume purchase: " & Result.DebugMessage, UnlockManager.LOG_COLOR_LIB_WARNING)
						Return False
					End If
				End If
			Next
		End If
		
		' Try subs
		Wait For (billing.QueryPurchases("subs")) Billing_PurchasesQueryCompleted (Result As BillingResult, Purchases As List)
		
		If Result.IsSuccess Then
			For Each p As Purchase In Purchases
				If p.Sku = pProductId Then
					Wait For (billing.Consume(p.PurchaseToken, "")) Billing_ConsumeCompleted (Result As BillingResult)
					
					If Result.IsSuccess Then
						LogColor("🛡  Subscription consumed successfully", UnlockManager.LOG_COLOR_LIB)
						mUnlockedState = False
						' Clear cache in UnlockManager
						UnlockManager.ResetSubscriptionStatus
						Return True
					Else
						LogColor("🛡  Failed to consume subscription: " & Result.DebugMessage, UnlockManager.LOG_COLOR_LIB_WARNING)
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
	' iOS: Cannot consume purchases like Android
	' To reset iOS purchases for testing:
	' Settings → App Store → Sandbox Account → Clear Purchase History
	' OR use multiple Sandbox test accounts
	Return False
	#End If
End Sub

' DIAGNOSTIC: Query product details to debug issues
Public Sub QueryProductDetails(pProductId As String) As ResumableSub
	#if B4A
	
	Dim result As Map
	result.Initialize
	
	' Log package name FIRST (before connecting)
	Dim packageName As String = Application.PackageName
'
	
	Wait For (billing.ConnectIfNeeded) Billing_Connected (BillingResult As BillingResult)
	
	If BillingResult.IsSuccess Then
		
		' Try inapp first
		Dim sf As Object = billing.QuerySkuDetails("inapp", Array As String(pProductId))
		Wait For (sf) Billing_SkuQueryCompleted (BillingResult As BillingResult, SkuDetails As List)
		
		' If not found, try subs
		If BillingResult.IsSuccess = False Or SkuDetails.Size = 0 Then
			sf = billing.QuerySkuDetails("subs", Array As String(pProductId))
			Wait For (sf) Billing_SkuQueryCompleted (BillingResult As BillingResult, SkuDetails As List)
		End If
		
		result.Put("success", BillingResult.IsSuccess)
		result.Put("response_code", BillingResult.ResponseCode)
		result.Put("message", BillingResult.DebugMessage)
		result.Put("products_found", SkuDetails.Size)
		result.Put("package_name", packageName)
		
		If SkuDetails.Size > 0 Then
			result.Put("product_available", True)
		Else
			result.Put("product_available", False)
		End If
		
		Return result
	Else
		LogColor("🛡  Billing connection failed: " & BillingResult.DebugMessage, UnlockManager.LOG_COLOR_LIB_WARNING)
		result.Put("success", False)
		result.Put("error", "Connection failed: " & BillingResult.DebugMessage)
		Return result
	End If
	#Else
	Dim result As Map
	result.Initialize
	result.Put("success", False)
	result.Put("error", "Not supported on this platform")
	Return result
	#End If
End Sub
' Show purchase screen and handle purchase flow
' Returns True if purchase was successful, False if cancelled or failed
Public Sub ShowInAppPurchase As ResumableSub
	EnsureWebView
	wvPurchase.As(B4XView).SetLayoutAnimated(0,0,0,ParentPanel.Width,ParentPanel.Height)

	' Load and inject purchase HTML
	Dim html As String = mTemplates.PurchaseInapp
	
	' Determine app name
	Dim appName As String = DisplayAppName
	If appName = "" Then
		#if B4A
		appName = Application.LabelName
		#Else If B4i
		appName = GetIosAppName
		#End If
	End If
	
	' Inject app name and tagline
	html = html.Replace("[APP_NAME]", appName)
	html = html.Replace("[APP_TAGLINE]", DisplayTagline)
	
	' Inject color scheme
	' Apply default theme if colors not set, then handle fallbacks
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
	
	' Build product cards HTML (works for any number of products)
	html = html.Replace("[PRODUCTS]", HTMLBuilder.BuildProductsHTML(Products))
	
	' Load the injected HTML
	wvPurchase.LoadHtml(html)
	
	' Show purchase screen with animation
	wvPurchase.As(B4XView).BringToFront
	wvPurchase.As(B4XView).SetVisibleAnimated(300, True)
	
	' Fetch prices for all products (wait for it to complete)
	Wait For (FetchAllProductPrices) Complete (Success As Boolean)
	
	' Wait for user action (purchase, restore, or close)
	mPurchaseScreenActive = True
	Do While mPurchaseScreenActive
		Sleep(100)
	Loop
	
	Return mPurchaseScreenResult
End Sub

' Update a specific product price in the WebView
Private Sub UpdateProductPriceInWebView(pProductId As String, price As String)
	If wvPurchase.Visible Then
		' Add small delay to ensure HTML is loaded
		Sleep(100)
		
		#if B4A
		' Always use product card price update (works for any number of products)
		Dim js As String = "updateProductPrice('" & pProductId & "', '" & price & "');"
		wvPurchase.As(JavaObject).RunMethod("evaluateJavascript", Array As Object(js, Null))
		#Else If B4i
		' Always use product card price update (works for any number of products)
		Dim js As String = "updateProductPrice('" & pProductId & "', '" & price & "');"
		wvPurchase.EvaluateJavaScript(js)
		#End If
	End If
End Sub

' Fetch prices for all products from store
Private Sub FetchAllProductPrices As ResumableSub
	If Products.IsInitialized = False Or Products.Size = 0 Then
		Return False
	End If
	
	#if B4A
	' Build array of product IDs
	Dim productIds(Products.Size) As String
	Dim i As Int = 0
	For Each product As Map In Products
		productIds(i) = product.Get("product_id")
		i = i + 1
	Next
	
	' Query all products at once (try inapp first, then subs)
	Wait For (billing.ConnectIfNeeded) Billing_Connected (BillingResult As BillingResult)
	If BillingResult.IsSuccess Then
		Dim sf As Object = billing.QuerySkuDetails("inapp", productIds)
		Wait For (sf) Billing_SkuQueryCompleted (BillingResult As BillingResult, SkuDetails As List)
		
		' If no inapp products found, try subs
		If BillingResult.IsSuccess = False Or SkuDetails.Size = 0 Then
			sf = billing.QuerySkuDetails("subs", productIds)
			Wait For (sf) Billing_SkuQueryCompleted (BillingResult As BillingResult, SkuDetails As List)
		End If
		
		If BillingResult.IsSuccess And SkuDetails.Size > 0 Then
			
			' Update each product price
			For Each sku As JavaObject In SkuDetails
				Try
					Dim prodId As String = sku.RunMethod("getProductId", Null)
					Dim offerDetails As JavaObject = sku.RunMethod("getOneTimePurchaseOfferDetails", Null)
					If offerDetails.IsInitialized Then
						Dim price As String = offerDetails.RunMethod("getFormattedPrice", Null)
						UpdateProductPriceInWebView(prodId, price)
					End If
				Catch
				End Try'ignore
			Next
		End If
	End If
	#Else If B4i
	' Build list of product IDs
	Dim productIds As List
	productIds.Initialize
	For Each product As Map In Products
		productIds.Add(product.Get("product_id"))
	Next
	
	' Request product information from App Store
	iStore.RequestProductsInformation(productIds)
	
	' Wait for product info to be received
	Wait For iStore_InformationAvailable_Complete
	#End If
	
	Return True
End Sub

#if B4i
' iOS Store: Product information received
Sub iStore_InformationAvailable (Success As Boolean, ProductsList As List)
	
	If Success Then
		
		For Each p As ProductInformation In ProductsList
			UpdateProductPriceInWebView(p.ProductIdentifier, p.LocalizedPrice)
		Next
	End If
	
	' Signal completion for Wait For pattern
	CallSubDelayed(Me, "iStore_InformationAvailable_Complete")
End Sub

' Internal sub for Wait For pattern
Private Sub iStore_InformationAvailable_Complete As ResumableSub
	Return True
End Sub
#End If

' Check if purchase screen is active
Public Sub IsActive As Boolean
	If mWebViewInitialized = False Then Return False
	Return wvPurchase.Visible
End Sub

' Hide purchase screen
Public Sub HidePurchaseScreen
	mPurchaseScreenActive = False
	If mWebViewInitialized Then wvPurchase.Visible = False
End Sub

' Handle WebView URL overrides (call this from wvPurchase_OverrideUrl event)
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
			' Extract product ID from URL
			Dim ProductId As String = ""
			If Url.Contains("?product=") Then
				Dim params As String = Url.SubString2(Url.IndexOf("?") + 1, Url.Length)
				Dim parts() As String = Regex.Split("&", params)
				For Each part As String In parts
					If part.StartsWith("product=") Then
						ProductId = part.SubString(8)
						ProductId = DecodeUrl(ProductId)
						Exit
					End If
				Next
			End If
			
			If ProductId <> "" Then
				HandlePurchaseAction(ProductId)
			End If
			
		Case "restore"
			' Restore purchases
			HandleRestoreAction
			
		Case "close"
			' Close purchase screen - cancelled
			mPurchaseScreenResult = False
			HidePurchaseScreen
			
		Case "accept"
			' Accept privacy/terms - just close the WebView
			LogColor("🛡  Privacy/Terms accepted", UnlockManager.LOG_COLOR_LIB)
			wvPurchase.Visible = False
	End Select
	
	Return True
End Sub

' URL decode helper
Private Sub DecodeUrl(encoded As String) As String
	' Simple URL decode for common cases
	encoded = encoded.Replace("%20", " ")
	encoded = encoded.Replace("%2B", "+")
	encoded = encoded.Replace("%2F", "/")
	encoded = encoded.Replace("%3D", "=")
	encoded = encoded.Replace("%26", "&")
	Return encoded
End Sub

' Handle purchase button tap
Private Sub HandlePurchaseAction(pProductId As String)
	
	Wait For (StartPurchaseFlow(pProductId)) Complete (result As Map)
	
	ResetPurchaseScreenButtons
	
	Dim success As Boolean = result.Get("success")
	If success Then
		LogColor("🛡  Purchase completed and validated successfully", UnlockManager.LOG_COLOR_LIB)
		mPurchaseScreenResult = True
		HidePurchaseScreen
	Else
		Dim errorMsg As String = result.GetDefault("error", "Unknown error")
		LogColor("🛡  Purchase failed: " & errorMsg, UnlockManager.LOG_COLOR_LIB_WARNING)
		
		' Don't close screen on error - let user try again
	End If
End Sub

' Handle restore button tap
Private Sub HandleRestoreAction
	#if B4A
	' Android: Clear ONLY purchase cache (not subscription cache)
	UnlockManager.ResetUnlockStatus
	#End If
	
	Wait For (RestorePurchases) Complete (Success As Boolean)
	
	ResetPurchaseScreenButtons
	
	' Always reload cached status after restore (whether success or failure)
	UnlockManager.LoadCachedStatus
	
	If Success Then
		mPurchaseScreenResult = True
		HidePurchaseScreen
	Else
		' Don't close screen - let user try purchasing instead
	End If
End Sub

' Reset purchase screen buttons (call after purchase/restore completes)
Public Sub ResetPurchaseScreenButtons
	If wvPurchase.Visible Then
		#if B4A
		wvPurchase.As(JavaObject).RunMethod("evaluateJavascript", Array As Object("resetButtons();", Null))
		#Else If B4i
		wvPurchase.EvaluateJavaScript("resetButtons();")
		#End If
	End If
End Sub

#if B4i
' iOS Store: Purchase completed (also called for restored purchases)
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
		
		' Check if this is one of our products
		Dim matchesProduct As Boolean = False
		Dim isConsumable As Boolean = False
		Dim quantity As Int = 1
		For Each productMap As Map In Products
			If Product.ProductIdentifier = productMap.Get("product_id") Then
				matchesProduct = True
				isConsumable = productMap.GetDefault("is_consumable", False)
				quantity = productMap.GetDefault("quantity", 1)
				Exit
			End If
		Next
		
		If matchesProduct Then
			If isConsumable Then
				' Consumable: Add to count, don't unlock (synchronous - no backend validation)
				Dim previousCount As Int = UnlockManager.GetConsumableCount
				UnlockManager.AddConsumables(quantity)
				Dim newCount As Int = UnlockManager.GetConsumableCount
				
				' Only log during actual purchase, not during restore
				If mPurchaseInProgress Then
					If newCount > previousCount Then
						LogColor("🛡  Consumable added x" & quantity & " (count: " & previousCount & " → " & newCount & ")", UnlockManager.LOG_COLOR_LIB)
					Else
						LogColor("🛡  Failed to add consumable (count unchanged: " & previousCount & ")", UnlockManager.LOG_COLOR_LIB_WARNING)
					End If
				End If
			Else
				' Non-consumable: Start async validation (don't wait here)
				' Only validate during purchase flow, not during restore
				If mRestoreInProgress Then
					mUnlockedState = True
				Else
					HandleIOSPurchaseAsync
				End If
			End If
		Else
			' Not our product - ignore silently (probably handled by clsSubscriptions)
			Return
		End If
	Else
		
		' Signal completion
		CompleteIOSPurchaseFlow
	End If
End Sub

' Internal sub to complete iOS purchase flow
Private Sub CompleteIOSPurchaseFlow
	' Resume the Wait For in StartPurchaseFlow
End Sub

' iOS Store: Restore transactions completed
Sub iStore_TransactionsRestored (Success As Boolean)
	LogColor("🛡  Transactions restored: " & Success, UnlockManager.LOG_COLOR_LIB)
	
	If Success Then
		LogColor("🛡  Restore completed successfully", UnlockManager.LOG_COLOR_LIB)
		' Note: iStore_PurchaseCompleted was already called for each restored purchase
		' Clear processed transactions list after restore completes
		mProcessedTransactions.Clear
	Else
		LogColor("🛡  Restore failed", UnlockManager.LOG_COLOR_LIB_WARNING)
	End If
End Sub

' Handle iOS purchase validation
Private Sub HandleIOSPurchase As ResumableSub
	
	' Get the App Store receipt
	Dim no As NativeObject = Me
	Dim receiptData As String = no.RunMethod("getReceipt", Null).AsString
	
	If receiptData = "" Then
		LogColor("🛡  Failed to get receipt from App Store", UnlockManager.LOG_COLOR_LIB_WARNING)
		Return False
	End If
	
	' Send receipt to backend for validation
	Wait For (UnlockManager.ConfirmIOSUnlock(receiptData)) Complete (unlockResult As Map)
	
	Dim unlocked As Boolean = False
	If unlockResult.ContainsKey("is_unlocked") Then
		unlocked = unlockResult.Get("is_unlocked")
	End If
	
	' Check if this was a credit limit fallback (keep existing status)
	If unlockResult.ContainsKey("reason_code") Then
		Dim reasonCode As String = unlockResult.Get("reason_code")
		If reasonCode = "credit_limit_exceeded" Then
			LogColor("🛡  Using cached unlock status due to credit limit", UnlockManager.LOG_COLOR_LIB)
			Return mUnlockedState
		End If
	End If
	
	If unlocked Then
		mUnlockedState = True
		Return True
	Else
		LogColor("🛡  Unlock not active per server validation", UnlockManager.LOG_COLOR_LIB)
		Return False
	End If
End Sub

' Handle iOS purchase async (called from event handler to avoid making it a ResumableSub)
Private Sub HandleIOSPurchaseAsync
	Wait For (HandleIOSPurchase) Complete (unlocked As Boolean)
	
	' No need to signal - Wait For will resume automatically when this ResumableSub completes
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

' ========================================
' Privacy Policy & Terms of Service
' ========================================
' Public methods to show Privacy/Terms from app menu (optional for in-app purchases)

' Show Privacy Policy overlay
Public Sub ShowPrivacyPolicy
	ShowPrivacyInPurchaseWebView("Privacy Policy", "app-privacy-policy-inapp.html")
End Sub

' Show Terms of Service overlay
Public Sub ShowTermsOfService
	ShowPrivacyInPurchaseWebView("Terms of Service", "app-terms-of-service.html")
End Sub

' Show privacy/terms in purchase WebView with sticky Accept button
Private Sub ShowPrivacyInPurchaseWebView(Title As String, HtmlFile As String)
	EnsureWebView
	
	Dim contentHtml As String
	Dim isURL As Boolean = False
	
	' Check if custom content is provided based on file type
	If HtmlFile.Contains("privacy-policy-inapp") And CustomPrivacyPolicyInapp <> "" Then
		If CustomPrivacyPolicyInapp.StartsWith("http://") Or CustomPrivacyPolicyInapp.StartsWith("https://") Then
			isURL = True
			contentHtml = CustomPrivacyPolicyInapp
		Else
			contentHtml = CustomPrivacyPolicyInapp
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
		Else If HtmlFile.Contains("privacy-policy-inapp") Then
			contentHtml = GeneratePrivacyPolicyInappHTML
		Else
			' Default to in-app privacy policy
			contentHtml = GeneratePrivacyPolicyInappHTML
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
	
	' Show purchase WebView
	wvPurchase.As(B4XView).SetLayoutAnimated(0, 0, 0, ParentPanel.Width, ParentPanel.Height)
	wvPurchase.As(B4XView).BringToFront
	wvPurchase.Visible = True
	
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

#if B4i
Sub GetIosAppName As String
	Dim no As NativeObject
	no = no.Initialize("NSBundle").RunMethod("mainBundle", Null)
	Dim name As Object = no.RunMethod("objectForInfoDictionaryKey:", Array As Object("CFBundleDisplayName"))
	If name = Null Then
		name = no.RunMethod("objectForInfoDictionaryKey:", Array As Object("CFBundleName"))
	End If
	Return name
End Sub
#End If

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
		#Else If B4i
		strAppName = GetIosAppName
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



