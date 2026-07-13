B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
' B4XPurchaseManager - Unified Purchase & Subscription Wrapper
' Provides a single interface for both in-app purchases and subscriptions
' Automatically syncs properties to both internal handlers

Sub Class_Globals
	Private xui As XUI
	
	' Theme color configuration type (-1 = not set / use default)
	Type theme_color_info(Primary As Int, Secondary As Int, Accent As Int, Background1 As Int, Background2 As Int)
	
	' Feature configuration type
	Type feature_info(Emoji As String, Title As String, Description As String)
	
	' Internal handlers
	Private Billing As clsInapp
	Private Subscriptions As clsSubscriptions
	Private UnlockManager As clsUnlockManager  ' Internal - managed by this class
	
	'B4X Purchase Manager platform
	Private Const BACKEND_URL As String = "https://api.b4xpurchasemanager.com"

	
	' API key for validation tracking (set via Initialize)
	Private ApiKey As String = ""
	
	' Timer for automatic cache validation checks
	Private ValidationTimer As Timer
	Private Const VALIDATION_CHECK_INTERVAL As Long = 5 * 60 * 1000  ' 5 minutes (production)
	
	' Backing fields for display properties
	Private mDisplayAppName As String = ""
	Private mDisplayTagline As String = "Unlock the Full Experience"
	
	' Backing fields for privacy/terms properties
	Private mPolicyCompanyName As String = ""
	Private mPolicyEmailAddress As String = ""
	Private mPolicyEffectiveDate As String = ""
	
	' Default effective date used when PolicyEffectiveDate is not set by the developer.
	' Shared constant lives in UnlockManager.DEFAULT_EFFECTIVE_DATE
	
	' Backing fields for custom privacy/terms content
	Private mCustomPrivacyPolicyInapp As String = ""
	Private mCustomPrivacyPolicySubscription As String = ""
	Private mCustomTermsOfService As String = ""
	
	
	' Theme colors (use SetThemeColors to configure)
	Private mThemeColors As theme_color_info
	
	' Backing fields for toggle properties
	Private mDarkMode As Boolean = False
	Private mDebugValidation As Boolean = False
	
	' Features (use AddFeature to configure)
	Private mFeatures As List
	
	Private mIsInitialized As Boolean = False
	Private mBackgroundValidationPending As Boolean = False
	Private mHasWarnedMissingFields As Boolean = False
	Private mAutoRestoreTriggered As Boolean = False  ' One-time auto-restore on first launch with empty cache
End Sub

' Theme color configuration type
Private Sub CreateThemeColors(Primary As Int, Secondary As Int, Accent As Int, Background1 As Int, Background2 As Int) As theme_color_info
	Dim themeColors As theme_color_info
	themeColors.Initialize
	themeColors.Primary = Primary
	themeColors.Secondary = Secondary
	themeColors.Accent = Accent
	themeColors.Background1 = Background1
	themeColors.Background2 = Background2
	Return themeColors
End Sub

' Add a feature to display in purchase/subscription screens
' Emoji: Icon/emoji to display (e.g., "🎨", "🚀", "⭐")
' Title: Feature title (e.g., "Premium Themes")
' Description: Feature description (e.g., "Access all premium themes")
' You can add as many features as needed
' Browse emoji icons at https://app.b4xpurchasemanager.com/dashboard/docs/emoji-picker
Public Sub AddFeature(Emoji As String, Title As String, Description As String)
	If mFeatures.IsInitialized = False Then
		mFeatures.Initialize
	End If
	
	Dim feature As feature_info
	feature.Initialize
	feature.Emoji = Emoji
	feature.Title = Title
	feature.Description = Description
	mFeatures.Add(feature)
End Sub

' Remove all features added via AddFeature (useful for rebuilding the feature list dynamically)
Public Sub ClearFeatures
	If mFeatures.IsInitialized Then
		mFeatures.Clear
	End If
End Sub

' ========================================
' Display & Privacy Properties (getter/setter for tooltip visibility)
' ========================================

' App name displayed on purchase and subscription screens.
' App name set in Main module is used if not set.
Public Sub setDisplayAppName(Value As String)
	mDisplayAppName = Value
End Sub

Public Sub getDisplayAppName As String
	Return mDisplayAppName
End Sub

' Tagline shown below app name on purchase screens.
' Default: "Unlock the Full Experience"
Public Sub setDisplayTagline(Value As String)
	mDisplayTagline = Value
End Sub

Public Sub getDisplayTagline As String
	Return mDisplayTagline
End Sub

' Company name for privacy policy and terms of service (required for subscriptions)
Public Sub setPolicyCompanyName(Value As String)
	mPolicyCompanyName = Value
End Sub

Public Sub getPolicyCompanyName As String
	Return mPolicyCompanyName
End Sub

' Contact email for privacy policy and terms (e.g., "support@yourcompany.com")
Public Sub setPolicyEmailAddress(Value As String)
	mPolicyEmailAddress = Value
End Sub

Public Sub getPolicyEmailAddress As String
	Return mPolicyEmailAddress
End Sub

' Effective date for privacy policy and terms of service.
' e.g., "January 1, 2025". Uses default date if empty.
Public Sub setPolicyEffectiveDate(Value As String)
	mPolicyEffectiveDate = Value
End Sub

Public Sub getPolicyEffectiveDate As String
	Return mPolicyEffectiveDate
End Sub

' Custom in-app purchase privacy policy.
' Provide a URL (https://...) or raw HTML string. Empty = built-in template.
Public Sub setCustomPrivacyPolicyInapp(Value As String)
	mCustomPrivacyPolicyInapp = Value
End Sub

Public Sub getCustomPrivacyPolicyInapp As String
	Return mCustomPrivacyPolicyInapp
End Sub

' Custom subscription privacy policy.
' Provide a URL (https://...) or raw HTML string. Empty = built-in template.
Public Sub setCustomPrivacyPolicySubscription(Value As String)
	mCustomPrivacyPolicySubscription = Value
End Sub

Public Sub getCustomPrivacyPolicySubscription As String
	Return mCustomPrivacyPolicySubscription
End Sub

' Custom terms of service.
' Provide a URL (https://...) or raw HTML string. Empty = built-in template.
Public Sub setCustomTermsOfService(Value As String)
	mCustomTermsOfService = Value
End Sub

Public Sub getCustomTermsOfService As String
	Return mCustomTermsOfService
End Sub

' Dark theme toggle (overrides theme colors with dark palette)
Public Sub setDarkMode(Value As Boolean)
	mDarkMode = Value
End Sub

Public Sub getDarkMode As Boolean
	Return mDarkMode
End Sub

' Enable shorter cache intervals (seconds/minutes) for faster revalidation during development.
' Ignored in release builds. Default is False.
Public Sub setDebugValidation(Value As Boolean)
	mDebugValidation = Value
End Sub

Public Sub getDebugValidation As Boolean
	Return mDebugValidation
End Sub

' Set theme colors using standard B4X color values (e.g., xui.Color_Red, Colors.Blue, 0xFFA855F7)
' Primary: Main accent color (buttons, links)
' Secondary: Secondary accent (gradients)
' Accent: Additional accent color
' Background1: Main background color
' Background2: Secondary background (for gradients)
' Pass 0 for any color you don't want to customize (uses default)
Public Sub SetThemeColors(Primary As Int, Secondary As Int, Accent As Int, Background1 As Int, Background2 As Int)
	mThemeColors = CreateThemeColors(Primary, Secondary, Accent, Background1, Background2)
End Sub

' Convert a B4X Int color to a CSS hex string (#RRGGBB)
' Returns "" if color is 0 (not set)
Private Sub ColorToHex(color As Int) As String
	If color = 0 Then Return ""
	' Extract RGB components (ignore alpha for CSS hex)
	Dim r As Int = Bit.UnsignedShiftRight(Bit.And(color, 0xFF0000), 16)
	Dim g As Int = Bit.UnsignedShiftRight(Bit.And(color, 0x00FF00), 8)
	Dim b As Int = Bit.And(color, 0x0000FF)
	Return "#" & Hex2(r) & Hex2(g) & Hex2(b)
End Sub

' Convert 0-255 value to 2-digit hex string
Private Sub Hex2(value As Int) As String
	Dim hexChars As String = "0123456789ABCDEF"
	Return hexChars.CharAt(value / 16) & hexChars.CharAt(value Mod 16)
End Sub


' Initialize the purchase validator
' Parent: The parent panel where purchase/subscription screens will be displayed
' pBillingKey: Your Google Play license key (ignored on iOS)
' pAppId: Your app identifier registered in the BPM dashboard. Package name is auto-detected.
' pApiKey: Your API key from the BPM dashboard (starts with "bpm_")
Public Sub Initialize(Parent As B4XView, pBillingKey As String, pAppId As String, pApiKey As String)
	' Store API key
	ApiKey = pApiKey
	
	' Initialize unlock manager internally with hardcoded backend URL
	UnlockManager.Initialize(BACKEND_URL, pAppId, "", ApiKey)
	
	' Only allow DebugValidation in debug builds — ignored in release
	#If DEBUG
	UnlockManager.DebugValidation = mDebugValidation
	#End If
	
	' Initialize both handlers
	Billing.Initialize(Parent, pBillingKey, UnlockManager)
	Subscriptions.Initialize(Parent, pBillingKey, UnlockManager)
	
	' Initialize validation timer (shorter interval when DebugValidation is on)
	Dim timerInterval As Long = VALIDATION_CHECK_INTERVAL
	#If DEBUG
	If mDebugValidation Then timerInterval = 30 * 1000  ' 30 seconds
	#End If
	ValidationTimer.Initialize("ValidationTimer", timerInterval)
	ValidationTimer.Enabled = True
	
	mIsInitialized = True
	LogColor("🛡  B4XPurchaseManager initialized (" & pAppId & ")", UnlockManager.LOG_COLOR_LIB)
	
	' Check status and trigger validation if expired
	' Use CallSubDelayed to ensure it runs after initialization completes
	CallSubDelayed(Me, "CheckStatus")
End Sub

' Check if initialized
' Returns True if Initialize has been called successfully
Public Sub IsInitialized As Boolean
	Return mIsInitialized
End Sub

' Handle page resize - call this from B4XPage_Resize
' This ensures privacy/terms overlays resize properly when the page size changes
'Public Sub Base_Resize(Width As Double, Height As Double)
'	Billing.Base_Resize(Width, Height)
'	Subscriptions.Base_Resize(Width, Height)
'End Sub

' ========================================
' Product Management (delegates to clsInapp)
' ========================================

' Add a non-consumable product for in-app purchase
' pProductId: The product ID from Google Play Console / App Store Connect
' pTitle: Display title shown in purchase screen (e.g., "Lifetime Unlock")
' pDescription: Description shown in purchase screen (e.g., "One-time purchase, yours forever")
Public Sub AddProduct(pProductId As String, pTitle As String, pDescription As String)
	Billing.AddProduct(pProductId, pTitle, pDescription)
End Sub

' Add a consumable product for in-app purchase (can be purchased multiple times)
' pProductId: The product ID from Google Play Console / App Store Connect
' pTitle: Display title shown in purchase screen (e.g., "100 Coins")
' pDescription: Description shown in purchase screen (e.g., "Use coins to unlock features")
' pQuantity: Number of consumables to award per purchase (e.g., 10 for a "10 Credits" pack)
Public Sub AddConsumableProduct(pProductId As String, pTitle As String, pDescription As String, pQuantity As Int)
	If pQuantity < 1 Then pQuantity = 1
	Billing.AddConsumableProduct(pProductId, pTitle, pDescription, pQuantity)
End Sub

' Clear all products (useful for testing or dynamic product lists)
Public Sub ClearProducts
	Billing.ClearProducts
End Sub

' ========================================
' Subscription Management (delegates to clsSubscriptions)
' ========================================

' Add a subscription option to the subscription screen
' pProductId: The subscription product ID from Google Play Console / App Store Connect
' pBasePlanId: The base plan ID (e.g., "monthly-plan", "annual-plan") - ignored on iOS
' pTitle: Display title (e.g., "Monthly Premium")
' pDescription: Description (e.g., "Full access, billed monthly")
' pBillingPeriod: Display text for billing period (e.g., "per month", "per year")
Public Sub AddSubscription(pProductId As String, pBasePlanId As String, pTitle As String, pDescription As String, pBillingPeriod As String)
	Subscriptions.AddSubscription(pProductId, pBasePlanId, pTitle, pDescription, pBillingPeriod)
End Sub

' Clear all subscriptions (useful for testing or dynamic subscription lists)
Public Sub ClearSubscriptions
	Subscriptions.ClearSubscriptions
End Sub

' ========================================
' Purchase Flow (syncs properties then delegates)
' ========================================

' Show the in-app purchase screen with all configured products
' Returns True if purchase was successful, False if cancelled or failed
' The screen includes product cards, restore button, and legal links
Public Sub ShowInAppPurchase As ResumableSub
	If Billing.Products.IsInitialized = False Or Billing.Products.Size = 0 Then
		LogColor("🛡  No products added — call AddProduct before ShowInAppPurchase", UnlockManager.LOG_COLOR_LIB_WARNING)
		Return False
	End If
	SyncPropertiesToBilling
	Wait For (Billing.ShowInAppPurchase) Complete (Success As Boolean)
	Return Success
End Sub

' Purchase a specific product directly (without showing the purchase screen)
' Use this when you want to integrate purchases into your own custom UI
' pProductId: The product ID to purchase
' Returns True if purchase was successful, False if cancelled or failed
Public Sub PurchaseProduct(pProductId As String) As ResumableSub
	SyncPropertiesToBilling
	
	' Show processing overlay
	Billing.ShowProcessingOverlay("Processing purchase...")
	
	' Do the purchase
	Wait For (Billing.StartPurchaseFlow(pProductId)) Complete (result As Map)
	
	' Hide processing overlay
	Billing.HideProcessingOverlay
	
	Dim success As Boolean = result.Get("success")
	Return success
End Sub

' Purchase a specific subscription directly (without showing the subscription screen)
' Use this when you want to integrate subscriptions into your own custom UI
' pProductId: The subscription product ID
' pBasePlanId: The base plan ID (e.g., "monthly-plan", "annual-plan")
' Returns True if subscription was successful, False if cancelled or failed
Public Sub PurchaseSubscription(pProductId As String, pBasePlanId As String) As ResumableSub
	SyncPropertiesToSubscriptions
	
	' Show processing overlay
	Subscriptions.ShowProcessingOverlay("Processing subscription...")
	
	' Do the subscription
	Wait For (Subscriptions.StartSubscriptionFlow(pProductId, pBasePlanId)) Complete (result As Map)
	
	' Hide processing overlay
	Subscriptions.HideProcessingOverlay
	
	Dim success As Boolean = result.Get("success")
	Return success
End Sub

' Show the subscription screen with all configured subscription options
' Returns True if subscription was successful, False if cancelled or failed
' The screen includes subscription cards, features, restore button, and legal links
Public Sub ShowSubscriptionPurchase As ResumableSub
	If Subscriptions.Subscriptions.IsInitialized = False Or Subscriptions.Subscriptions.Size = 0 Then
		LogColor("🛡  No subscriptions added — call AddSubscription before ShowSubscriptionPurchase", UnlockManager.LOG_COLOR_LIB_WARNING)
		Return False
	End If
	SyncPropertiesToSubscriptions
	Wait For (Subscriptions.ShowSubscriptionPurchase) Complete (Success As Boolean)
	Return Success
End Sub

' Restore previous in-app purchases from the store
' Returns True if restore was successful (even if no purchases found), False if failed
' Use this to let users restore purchases on a new device or after reinstalling
Public Sub RestorePurchases As ResumableSub
	SyncPropertiesToBilling
	Wait For (Billing.RestorePurchases) Complete (Success As Boolean)
	Return Success
End Sub

' Restore previous subscriptions from the store
' Returns True if restore was successful (even if no subscriptions found), False if failed
' Use this to let users restore subscriptions on a new device or after reinstalling
Public Sub RestoreSubscriptions As ResumableSub
	SyncPropertiesToSubscriptions
	Wait For (Subscriptions.RestoreSubscriptions) Complete (Success As Boolean)
	Return Success
End Sub

' ========================================
' Status Queries
' ========================================

' Check if user has unlocked via in-app purchase (cached, instant)
' Returns True if user owns a non-consumable product, False otherwise
' This checks the local cache - call CheckStatus() to refresh from backend
Public Sub IsUnlocked As Boolean
	Return UnlockManager.IsUnlocked
End Sub

' Check if user has an active subscription (cached, instant)
' Returns True if user has a valid subscription, False otherwise
' This checks the local cache - call CheckStatus() to refresh from backend
Public Sub IsSubscriptionActive As Boolean
	Return UnlockManager.IsSubscriptionActive
End Sub

' Get the active subscription ID (cached, instant)
' Returns the subscription product ID (e.g., "premium_monthly") or empty string if none
Public Sub GetActiveSubscriptionId As String
	Return UnlockManager.GetActiveSubscriptionId
End Sub

' Get subscription expiry date in ticks (cached, instant)
' Returns the expiry date as DateTime ticks, or 0 if not available
' Use DateTime.Date() and DateTime.Time() to format for display
Public Sub GetSubscriptionExpiryDate As Long
	Return UnlockManager.GetSubscriptionExpiryDate
End Sub

' Get current consumable count (locally tracked, instant)
' Returns the number of consumables the user currently has
' Consumables are tracked locally on-device only — consider syncing with your own server
' for cross-device support or to prevent loss on reinstall
Public Sub GetConsumableCount As Int
	Return UnlockManager.GetConsumableCount
End Sub

' Add consumables after successful purchase
' Count: Number of consumables to add (e.g., 100 coins)
' Call this after a successful consumable purchase to update the local count
Public Sub AddConsumables(Count As Int)
	UnlockManager.AddConsumables(Count)
End Sub

' Set consumable count directly (for syncing with an external server)
' Count: The exact consumable count from your server
' Use this on app launch to sync local count with your server's authoritative count
Public Sub SetConsumableCount(Count As Int)
	UnlockManager.SetConsumableCount(Count)
End Sub

' Use consumables (deduct from local count)
' Count: Number of consumables to use (e.g., 10 coins)
' Returns True if successful (enough consumables), False if not enough
Public Sub UseConsumables(Count As Int) As Boolean
	Return UnlockManager.UseConsumables(Count)
End Sub

' Check if any purchase/subscription screen is currently showing
' Returns True if a purchase or subscription screen is visible, False otherwise
' Useful to prevent showing multiple screens or handling navigation
Public Sub IsActive As Boolean
	Return Billing.IsActive Or Subscriptions.IsActive
End Sub

' Check if live backend validation is currently in progress
' Returns True if ValidateNow is running, False otherwise
' Useful to show "Checking status..." message or prevent showing purchase screens during validation
Public Sub ValidationInProgress As Boolean
	Return UnlockManager.ValidationInProgress
End Sub

' Hide any active purchase/subscription screen
' Call this to programmatically close the purchase or subscription screen
' Useful for handling app lifecycle events (e.g., app going to background)
Public Sub HidePurchaseScreen
	If Billing.IsActive Then
		Billing.HidePurchaseScreen
	End If
	If Subscriptions.IsActive Then
		Subscriptions.HideSubscriptionScreen
	End If
End Sub

' Check and refresh purchase/subscription status from cache
' Call this on app resume, page appear, or after user actions that might affect status
' Automatically triggers background validation if cache is expired (no waiting)
' Automatically triggers a one-time restore if products are configured but no purchase history exists
' (handles new device, reinstall, or migration from another system)
' This is instant - it loads from cache and validates in background if needed
Public Sub CheckStatus
	UnlockManager.LoadCachedStatus
	
	' One-time warning for missing recommended fields
	If mHasWarnedMissingFields = False Then
		mHasWarnedMissingFields = True
		If mPolicyCompanyName = "" Then LogColor("🛡  PolicyCompanyName not set — recommended for privacy policy & terms", UnlockManager.LOG_COLOR_LIB_WARNING)
		If mPolicyEmailAddress = "" Then LogColor("🛡  PolicyEmailAddress not set — recommended for privacy policy & terms", UnlockManager.LOG_COLOR_LIB_WARNING)
		If mPolicyEffectiveDate = "" Then LogColor("🛡  PolicyEffectiveDate not set — will default to " & UnlockManager.DEFAULT_EFFECTIVE_DATE, UnlockManager.LOG_COLOR_LIB_WARNING)
	End If
	
	' Skip if a purchase/subscription screen is active (it handles its own validation)
	' Skip if background validation is already pending/running
	If Billing.IsActive Or Subscriptions.IsActive Then Return
	
	' Auto-restore: If products are configured but no purchase history exists,
	' trigger a one-time restore to catch existing purchases (new device, reinstall, migration)
	If mAutoRestoreTriggered = False Then
		Dim needsInappRestore As Boolean = Billing.Products.IsInitialized And Billing.Products.Size > 0 And UnlockManager.HasInappHistory = False
		Dim needsSubRestore As Boolean = Subscriptions.Subscriptions.IsInitialized And Subscriptions.Subscriptions.Size > 0 And UnlockManager.HasSubscriptionHistory = False
		If needsInappRestore Or needsSubRestore Then
			mAutoRestoreTriggered = True
			LogColor("🛡  First launch with no purchase history — checking store for existing purchases", UnlockManager.LOG_COLOR_LIB)
			CallSubDelayed(Me, "AutoRestoreInBackground")
			Return
		End If
	End If
	
	' Check if cache is expired and trigger background validation if needed
	If UnlockManager.IsCacheValid = False And mBackgroundValidationPending = False Then
		mBackgroundValidationPending = True
		' Start background validation (don't wait for it)
		CallSubDelayed(Me, "CheckAndRefreshInBackground")
	End If
End Sub

' Internal: One-time auto-restore for new device / reinstall / migration
Private Sub AutoRestoreInBackground
	If Billing.Products.IsInitialized And Billing.Products.Size > 0 And UnlockManager.HasInappHistory = False Then
		SyncPropertiesToBilling
		Wait For (Billing.RestorePurchases) Complete (InappSuccess As Boolean)
	End If
	If Subscriptions.Subscriptions.IsInitialized And Subscriptions.Subscriptions.Size > 0 And UnlockManager.HasSubscriptionHistory = False Then
		SyncPropertiesToSubscriptions
		Wait For (Subscriptions.RestoreSubscriptions) Complete (SubSuccess As Boolean)
	End If
End Sub

' Internal: Background validation when cache expires
Private Sub CheckAndRefreshInBackground
	' This runs asynchronously without blocking the caller
	Wait For (ValidateInBackground) Complete (Success As Boolean)
	mBackgroundValidationPending = False
End Sub

' Internal: Background validation respects independent cache validity
Private Sub ValidateInBackground As ResumableSub
	Wait For (UnlockManager.ValidateNow(Billing, Subscriptions, False)) Complete (Success As Boolean)
	Return Success
End Sub

' Force immediate validation check (bypasses cache)
' Useful for testing or when you need to verify status immediately
' Returns True if validation was successful (regardless of unlock/subscription status)
Public Sub ValidateNow As ResumableSub
	Wait For (UnlockManager.ValidateNow(Billing, Subscriptions, True)) Complete (Success As Boolean)
	' Reset the timer so it doesn't fire unnecessarily after a fresh validation
	ValidationTimer.Enabled = False
	ValidationTimer.Enabled = True
	Return Success
End Sub

' ========================================
' Privacy & Terms (unified interface)
' ========================================

' Show Privacy Policy in a full-screen overlay
' Uses custom content if set (CustomPrivacyPolicyInapp), otherwise uses built-in template
Public Sub ShowPrivacyPolicy
	' Can use either handler - they share the same layout
	SyncPropertiesToBilling
	Billing.ShowPrivacyPolicy
End Sub

' Show Terms of Service in a full-screen overlay
' Uses custom content if set (CustomTermsOfService), otherwise uses built-in template
Public Sub ShowTermsOfService
	' Can use either handler - they share the same layout
	SyncPropertiesToBilling
	Billing.ShowTermsOfService
End Sub

' ========================================
' Export Methods (Development Helper)
' ========================================

' Export fully-rendered privacy policy HTML for in-app purchases (debug mode only)
' Exports to accessible directory so dev can edit with their LLM
' Ignored in release builds. Returns: True if successful, False if failed
Public Sub ExportPrivacyPolicyInapp As Boolean
	#If RELEASE
	Return False
	#Else
	SyncPropertiesToBilling
	Return ExportHTML("bpm-privacy-policy-inapp.html", Billing.GeneratePrivacyPolicyInappHTML, "Privacy Policy (In-App)")
	#End If
End Sub

' Export fully-rendered privacy policy HTML for subscriptions (debug mode only)
' Exports to accessible directory so dev can edit with their LLM
' Ignored in release builds. Returns: True if successful, False if failed
Public Sub ExportPrivacyPolicySubscription As Boolean
	#If RELEASE
	Return False
	#Else
	SyncPropertiesToSubscriptions
	Return ExportHTML("bpm-privacy-policy-subscription.html", Subscriptions.GeneratePrivacyPolicySubscriptionHTML, "Privacy Policy (Subscription)")
	#End If
End Sub

' Export fully-rendered terms of service HTML for external editing (debug mode only)
' Exports to accessible directory so dev can edit with their LLM
' Ignored in release builds. Returns: True if successful, False if failed
Public Sub ExportTermsOfService As Boolean
	#If RELEASE
	Return False
	#Else
	SyncPropertiesToBilling
	Return ExportHTML("bpm-terms-of-service.html", Billing.GenerateTermsOfServiceHTML, "Terms of Service")
	#End If
End Sub

' Internal: Export HTML to accessible directory
Private Sub ExportHTML(fileName As String, html As String, label As String) As Boolean 'ignore
	Try
		' Use default effective date if not set
		Dim originalDate As String = mPolicyEffectiveDate
		If mPolicyEffectiveDate = "" Then mPolicyEffectiveDate = UnlockManager.DEFAULT_EFFECTIVE_DATE
		
		' Get accessible directory for exports
		Dim sDir As String
		#If B4A
		Dim rp As RuntimePermissions
		sDir = rp.GetSafeDirDefaultExternal("")
		#Else If B4I
		sDir = File.DirDocuments
		#Else If B4J
		sDir = File.DirApp
		#End If
		
		File.WriteString(sDir, fileName, html)
		mPolicyEffectiveDate = originalDate
		
		LogColor("🛡 ═══════════════════════════════════════════════════════════════", UnlockManager.LOG_COLOR_LIB_PURPLE)
		LogColor("🛡 " & label & " exported to: " & File.Combine(sDir, fileName), UnlockManager.LOG_COLOR_LIB_PURPLE)
		
		' Log full HTML on a single line so dev can right-click > 'Copy Line' from IDE log
		LogColor("🛡 Copy HTML below", UnlockManager.LOG_COLOR_LIB_PURPLE)
		Log(html.Replace(Chr(13), "").Replace(Chr(10), "").Replace(Chr(9), ""))
		LogColor("🛡 ═══════════════════════════════════════════════════════════════", UnlockManager.LOG_COLOR_LIB_PURPLE)
		
		Return True
	Catch
		mPolicyEffectiveDate = originalDate
		LogColor("🛡 Failed to export " & label & ": " & LastException, UnlockManager.LOG_COLOR_LIB_WARNING)
		Return False
	End Try
End Sub

' ========================================
' Testing & Diagnostics
' ========================================

' Reset purchase for testing
' Android: Consumes the purchase token (allows re-purchasing)
' iOS: Clears local cache and forces validation (does NOT remove purchase from App Store)
'
' IMPORTANT FOR iOS TESTING:
' This method cannot remove purchases from App Store Sandbox.
' To fully reset iOS purchases: Settings → App Store → Sandbox Account → Clear Purchase History
' OR use multiple Sandbox test accounts
Public Sub ResetPurchaseForTesting(pProductId As String) As ResumableSub
	Wait For (Billing.ResetPurchaseForTesting(pProductId)) Complete (Success As Boolean)
	Return Success
End Sub

' Reset subscription for testing
' Android: Consumes the subscription token (allows re-subscribing)
' iOS: Not supported (returns False with helpful log messages)
'
' IMPORTANT FOR iOS TESTING:
' This method cannot remove subscriptions from App Store Sandbox.
' To fully reset iOS subscriptions: Settings → App Store → Sandbox Account → Clear Purchase History
' OR use multiple Sandbox test accounts
' Note: Sandbox subscriptions expire quickly anyway (5-30 minutes)
Public Sub ResetSubscriptionForTesting(pProductId As String) As ResumableSub
	Wait For (Subscriptions.ResetSubscriptionForTesting(pProductId)) Complete (Success As Boolean)
	Return Success
End Sub

' ========================================
' Internal: Property Synchronization
' ========================================

' Sync all properties to clsInapp before showing purchase screen
Private Sub SyncPropertiesToBilling
	' Display
	Billing.DisplayAppName = mDisplayAppName
	Billing.DisplayTagline = mDisplayTagline
	
	' Privacy & Terms
	Billing.PolicyCompanyName = mPolicyCompanyName
	Billing.PolicyEmailAddress = mPolicyEmailAddress
	Billing.PolicyEffectiveDate = mPolicyEffectiveDate
	
	' Custom Privacy/Terms
	Billing.CustomPrivacyPolicyInapp = mCustomPrivacyPolicyInapp
	Billing.CustomPrivacyPolicySubscription = mCustomPrivacyPolicySubscription
	Billing.CustomTermsOfService = mCustomTermsOfService
	
	' Colors - use ThemeColors if set
	If mThemeColors.IsInitialized Then
		Billing.ColorPrimary = ColorToHex(mThemeColors.Primary)
		Billing.ColorSecondary = ColorToHex(mThemeColors.Secondary)
		Billing.ColorAccent = ColorToHex(mThemeColors.Accent)
		Billing.ColorBackground1 = ColorToHex(mThemeColors.Background1)
		Billing.ColorBackground2 = ColorToHex(mThemeColors.Background2)
	End If
	Billing.DarkMode = mDarkMode
	
	' Features - pass the entire list
	Billing.Features = mFeatures
End Sub

' Sync all properties to clsSubscriptions before showing subscription screen
Private Sub SyncPropertiesToSubscriptions
	' Display
	Subscriptions.DisplayAppName = mDisplayAppName
	Subscriptions.DisplayTagline = mDisplayTagline
	
	' Privacy & Terms
	Subscriptions.PolicyCompanyName = mPolicyCompanyName
	Subscriptions.PolicyEmailAddress = mPolicyEmailAddress
	Subscriptions.PolicyEffectiveDate = mPolicyEffectiveDate
	
	' Custom Privacy/Terms
	Subscriptions.CustomPrivacyPolicyInapp = mCustomPrivacyPolicyInapp
	Subscriptions.CustomPrivacyPolicySubscription = mCustomPrivacyPolicySubscription
	Subscriptions.CustomTermsOfService = mCustomTermsOfService
	
	' Colors - use ThemeColors if set
	If mThemeColors.IsInitialized Then
		Subscriptions.ColorPrimary = ColorToHex(mThemeColors.Primary)
		Subscriptions.ColorSecondary = ColorToHex(mThemeColors.Secondary)
		Subscriptions.ColorAccent = ColorToHex(mThemeColors.Accent)
		Subscriptions.ColorBackground1 = ColorToHex(mThemeColors.Background1)
		Subscriptions.ColorBackground2 = ColorToHex(mThemeColors.Background2)
	End If
	Subscriptions.DarkMode = mDarkMode
	
	' Features - pass the entire list
	Subscriptions.Features = mFeatures
End Sub


' ========================================
' Internal: Timer Events
' ========================================

' Timer tick - periodically check if cache needs validation
Private Sub ValidationTimer_Tick
	' Check if cache is expired and trigger validation if needed
	' Respect the pending flag to avoid duplicate calls
	If UnlockManager.IsCacheValid = False And mBackgroundValidationPending = False Then
		mBackgroundValidationPending = True
		CallSubDelayed(Me, "CheckAndRefreshInBackground")
	End If
End Sub
