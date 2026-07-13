B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#ModuleVisibility: B4XLib
' UnlockManager - Handles purchase/subscription validation via B4X Purchase Manager
' Manages caching, device IDs, and server communication
' All validation is server-side → no store SDK secrets in app

Sub Class_Globals
	Private xui As XUI
	Private mBaseUrl As String
	Private mDeviceUserId As String
	Private mAppId As String
	Private mPackageName As String
	Private mApiKey As String  ' API key for validation tracking
	
	' Cache settings
	Private mCachedUnlockStatus As Boolean = False
	Private mCachedSubscriptionActive As Boolean = False
	Private mCachedSubscriptionId As String = ""
	Private mCachedSubscriptionExpiryDate As Long = 0  ' Expiry date in ticks
	Private mCachedConsumableCount As Int = 0  ' Track consumables locally
	Private mCacheTimestampInapp As Long = 0  ' Independent cache timestamp for in-app
	Private mCacheTimestampSubscription As Long = 0  ' Independent cache timestamp for subscriptions
	Private mPurchaseTimestampInapp As Long = 0  ' When in-app purchase was first validated (0 = never purchased)
	Private mPurchaseTimestampSubscription As Long = 0  ' When subscription was first validated (0 = never subscribed)
	
	' Dormant state — stops background validation when no longer needed
	Private mInappDormant As Boolean = False  ' True = in-app refunded, stop validating
	Private mSubscriptionDormant As Boolean = False  ' True = subscription expired past grace period
	Private mSubscriptionExpiredAt As Long = 0  ' When subscription expiry was first detected (0 = not expired)
	
	' Cache TTL constants (production)
	Private Const CACHE_TTL_UNLOCKED_NEW As Long = 24 * 60 * 60 * 1000  ' 24 hours (first 14 days - refund window)
	Private Const CACHE_TTL_UNLOCKED_OLD As Long = 14 * 24 * 60 * 60 * 1000  ' 14 days (after refund window)
	Private Const CACHE_TTL_SUBSCRIPTION As Long = 24 * 60 * 60 * 1000  ' 24 hours (active subscriptions + grace period)
	
	' Cache TTL constants (debug validation - in minutes for easy testing)
	Private Const CACHE_TTL_UNLOCKED_NEW_DEBUG As Long = 2 * 60 * 1000  ' 2 minutes
	Private Const CACHE_TTL_UNLOCKED_OLD_DEBUG As Long = 5 * 60 * 1000  ' 5 minutes
	Private Const CACHE_TTL_SUBSCRIPTION_DEBUG As Long = 2 * 60 * 1000  ' 2 minutes
	
	Private Const REFUND_WINDOW_DAYS As Int = 14  ' Apple's refund window
	Private Const SUBSCRIPTION_GRACE_PERIOD As Long = 7 * 24 * 60 * 60 * 1000  ' 7 days grace after expiry
	Private Const SUBSCRIPTION_GRACE_PERIOD_DEBUG As Long = 3 * 60 * 1000  ' 3 minutes (debug)
	
	' Test mode (simulates server without backend)
	Private mTestMode As Boolean = False
	Private mTestUnlockStatus As Boolean = False
	
	Public Const LOG_COLOR_LIB As Int = 0xFF555555  ' Dark grey for library background logs
	Public Const LOG_COLOR_LIB_WARNING As Int = 0x8CFF0000  ' Translucent Red for library background logs
	Public Const LOG_COLOR_LIB_PURPLE As Int =0xC87C3AED  ' BPM Purple for library background logs
	
	' Default effective date for privacy/terms when not set by developer. Update on each library release.
	Public Const DEFAULT_EFFECTIVE_DATE As String = "June 27, 2026"
	
	' When True, uses shorter cache intervals (minutes instead of hours/days) for faster revalidation during development.
	' Uses LIVE server validation — API credits will be consumed.
	' Default is False (production intervals: 24 hours / 14 days).
	Public DebugValidation As Boolean = False
	
	' Validation state tracking
	Private mValidationInProgress As Boolean = False
	
	Private sDir As String
End Sub

' Initialize UnlockManager (called internally by B4XPurchaseManager)
' BaseUrl: Backend endpoint (hardcoded in B4XPurchaseManager as https://api.b4xpurchasemanager.com)
' AppId: Your app identifier (e.g., "bxtest", "vibryo")
' PackageName: Your Android package name - auto-detected if empty
' ApiKey: Your API key for validation tracking
Public Sub Initialize(BaseUrl As String, AppId As String, PackageName As String, ApiKey As String)
	mBaseUrl = BaseUrl
	mAppId = AppId
	mApiKey = ApiKey
	
	'DEBUG ---------------------------------------------
'#If B4A
'    Dim rp As RuntimePermissions
'    sDir = rp.GetSafeDirDefaultExternal("")   ' Accessible folder (Android)
'#Else If B4I
'    sDir = File.DirDocuments                  ' iOS documents folder
'#Else If B4J
'	sDir = File.DirApp                        ' App folder (desktop)
'#End If
	'---------------------------------------------------
	'---------------------------------------------------
	#if b4a
		sDir=File.DirInternal
	#Else If B4i
		sDir=File.DirLibrary
	#Else If B4J
	    sDir = File.DirData("")
	#end if	
	'---------------------------------------------------
	
	' Auto-detect package name if not provided
	#if B4A
	If PackageName = "" Then
		mPackageName = Application.PackageName
	Else
		mPackageName = PackageName
	End If
	#Else
	mPackageName = PackageName
	#End If
	
	mDeviceUserId = GetOrCreateDeviceUserId
	
	' Enable test mode if BaseUrl is "TEST_MODE"
	If BaseUrl = "TEST_MODE" Then
		mTestMode = True
		LogColor("🛡  UnlockManager initialized in TEST MODE", LOG_COLOR_LIB)
	Else
		mTestMode = False
	End If
End Sub

' Get or create stable device user ID (GUID)
' Stored in KeyValueStore for persistence across app launches
Private Sub GetOrCreateDeviceUserId As String
	Dim kvs As KeyValueStore
	kvs.Initialize(sDir, "unlock_data.db")
	
	If kvs.ContainsKey("device_user_id") Then
		Dim deviceId As String = kvs.Get("device_user_id")
		kvs.Close
		Return deviceId
	Else
		' Generate new GUID
		Dim deviceId As String = CreateGUID
		kvs.Put("device_user_id", deviceId)
		kvs.Close
		Return deviceId
	End If
End Sub

' Create GUID for device identification
Private Sub CreateGUID As String
	Dim sb As StringBuilder
	sb.Initialize
	
	' Simple GUID format: xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
	For i = 0 To 35
		If i = 8 Or i = 13 Or i = 18 Or i = 23 Then
			sb.Append("-")
		Else If i = 14 Then
			sb.Append("4")  ' Version 4
		Else If i = 19 Then
			Dim n As Int = Rnd(0, 4)
			sb.Append("89ab".CharAt(n))  ' Variant bits
		Else
			sb.Append("0123456789abcdef".CharAt(Rnd(0, 16)))
		End If
	Next
	
	Return sb.ToString
End Sub

' Check unlock status (with optional force refresh)
' Returns Map with: is_unlocked (Boolean), server_time_utc (Long), source (String)
Public Sub CheckUnlockStatus(ForceRefresh As Boolean) As ResumableSub
	' Check cache first (unless force refresh)
	If ForceRefresh = False And IsCacheValid Then
		Dim result As Map
		result.Initialize
		result.Put("is_unlocked", mCachedUnlockStatus)
		result.Put("server_time_utc", mCacheTimestampInapp)
		result.Put("source", "cache")
		Return result
	End If
	
	' TEST MODE: Simulate server response
	If mTestMode Then
		Sleep(500)  ' Simulate network delay
		Dim serverTime As Long = DateTime.Now
		UpdateCache(mTestUnlockStatus, serverTime)
		
		Dim result As Map
		result.Initialize
		result.Put("is_unlocked", mTestUnlockStatus)
		result.Put("server_time_utc", serverTime)
		result.Put("source", "test_mode")
		Return result
	End If
	
	' For local testing: Skip server status check (validator doesn't have /unlock/status endpoint)
	' Just return cached status - purchases will update it via /purchase/validate
	
	Dim result As Map
	result.Initialize
	result.Put("is_unlocked", mCachedUnlockStatus)
	result.Put("server_time_utc", mCacheTimestampInapp)
	result.Put("source", "cache_only")
	Return result
	
	' TODO: For production, implement /unlock/status endpoint in validator
	' Or remove this check entirely and rely on purchase validation only
End Sub

' Confirm iOS purchase (after successful purchase or restore)
' ReceiptBase64: Base64-encoded App Store receipt
Public Sub ConfirmIOSUnlock(ReceiptBase64 As String) As ResumableSub
	' TEST MODE: Simulate successful unlock
	If mTestMode Then
		Sleep(800)  ' Simulate network delay
		mTestUnlockStatus = True
		Dim serverTime As Long = DateTime.Now
		UpdateCache(True, serverTime)
		
		Dim result As Map
		result.Initialize
		result.Put("is_unlocked", True)
		result.Put("server_time_utc", serverTime)
		result.Put("source", "test_mode")
		Return result
	End If
	
	Try
		' Build request for validator
		' Note: Use string "true" to ensure boolean in JSON (B4X converts True to 1)
		Dim requestMap As Map
		requestMap.Initialize
		requestMap.Put("app_id", mAppId)
		requestMap.Put("platform", "ios")
		requestMap.Put("device_user_id", mDeviceUserId)
		requestMap.Put("receipt_base64", ReceiptBase64)
		requestMap.Put("include_debug", True)
		requestMap.Put("api_key", mApiKey)
		'If mApiKey <> "" Then requestMap.Put("api_key", mApiKey)
		
		Dim json As JSONGenerator
		json.Initialize(requestMap)
		
		' Fix boolean conversion: Replace "include_debug":1 with "include_debug":true
		Dim jsonString As String = json.ToString
		jsonString = jsonString.Replace($""include_debug":1"$, $""include_debug":true"$)
		jsonString = jsonString.Replace($""include_debug":0"$, $""include_debug":false"$)
		
		LogColor("🛡  Validating iOS in-app purchase for " & mAppId & "...", LOG_COLOR_LIB_PURPLE)
		
		Dim job As xHttpJob
		job.Initialize("", Me)
		job.PostString(mBaseUrl & "/purchase/validate", jsonString)
		job.GetRequest.SetContentType("application/json")
		
		Wait For (job) JobDone(job As xHttpJob)
		
		If job.Success Then
			Dim parser As JSONParser
			parser.Initialize(job.GetString)
			Dim response As Map = parser.NextObject
			
			' Parse validator response
			Dim ok As Boolean = response.Get("ok")
			Dim entitlementActive As Boolean = response.Get("entitlement_active")
			
			' Log server response summary
			Dim rcLog As String = IIf(response.ContainsKey("reason_code") And response.Get("reason_code") <> Null, response.Get("reason_code"), "ok")
			Dim msgLog As String = IIf(response.ContainsKey("message") And response.Get("message") <> Null, response.Get("message"), "")
			If rcLog = "active" Then
				LogColor("🛡  In-app: " & rcLog, LOG_COLOR_LIB)
			Else If msgLog <> "" Then
				LogColor("🛡  Response: " & rcLog & " — " & msgLog, LOG_COLOR_LIB)
			Else
				LogColor("🛡  Response: " & rcLog, LOG_COLOR_LIB)
			End If
			
			' CREDIT LIMIT CHECK: If dev's credits are exhausted, don't punish the end user
			' Keep last known good status instead of overwriting with false
			If response.ContainsKey("reason_code") Then
				Dim reasonCode As String = response.Get("reason_code")
				If reasonCode = "credit_limit_exceeded" Then
					LogColor("🛡  Credit limit exceeded — keeping last known unlock status", LOG_COLOR_LIB_WARNING)
					LogColor("🛡  Status may be stale — cannot verify until credits are restored", LOG_COLOR_LIB_WARNING)
					LogColor("🛡  Upgrade your plan at https://app.b4xpurchasemanager.com/dashboard/billing", LOG_COLOR_LIB_WARNING)
					mCacheTimestampInapp = DateTime.Now  ' Update timestamp so cache stays valid and prevents duplicate calls
					Dim result As Map
					result.Initialize
					result.Put("is_unlocked", mCachedUnlockStatus)
					result.Put("server_time_utc", DateTime.Now)
					result.Put("source", "cache_fallback")
					result.Put("reason_code", reasonCode)
					job.Release
					Return result
				End If
			End If
			
			' iOS QUIRK: For non-consumables, backend returns entitlement_active=false
			' but transaction_count > 0 indicates a valid purchase
			Dim actuallyUnlocked As Boolean = entitlementActive
			Dim transactionCount As Int = 0
			
			' Extract debug info if available
			If response.ContainsKey("debug") Then
				Try
					Dim debugInfo As Object = response.Get("debug")
					If debugInfo Is Map Then
						Dim debugMap As Map = debugInfo
						
						' Check transaction_count for non-consumables
						If debugMap.ContainsKey("transaction_count") Then
							transactionCount = debugMap.Get("transaction_count")
							
							' If entitlement_active is false but transaction_count > 0,
							' this is a valid non-consumable purchase
							If entitlementActive = False And transactionCount > 0 Then
								actuallyUnlocked = True
							End If
						End If
					End If
				Catch
				End Try'ignore
			End If
			
			' Update cache with actual unlock status
			Dim serverTime As Long = DateTime.Now
			UpdateCache(actuallyUnlocked, serverTime)
			
			Dim result As Map
			result.Initialize
			result.Put("is_unlocked", actuallyUnlocked)
			result.Put("server_time_utc", serverTime)
			result.Put("source", "server")
			result.Put("validation_ok", ok)
			result.Put("transaction_count", transactionCount)
			
			job.Release
			Return result
		Else
			LogColor("🛡  Server error: " & job.ErrorMessage, LOG_COLOR_LIB_WARNING)
			
			Dim result As Map
			result.Initialize
			result.Put("is_unlocked", False)
			result.Put("error", job.ErrorMessage)
			
			job.Release
			Return result
		End If
	Catch
		LogColor("🛡  Exception confirming iOS unlock: " & LastException, LOG_COLOR_LIB_WARNING)
		
		Dim result As Map
		result.Initialize
		result.Put("is_unlocked", False)
		result.Put("error", LastException)
		Return result
	End Try
End Sub

' Confirm iOS subscription (after successful subscription or restore)
' ReceiptBase64: Base64-encoded App Store receipt
Public Sub ConfirmIOSSubscription(ReceiptBase64 As String) As ResumableSub
	' TEST MODE: Simulate successful subscription
	If mTestMode Then
		Sleep(800)  ' Simulate network delay
		mTestUnlockStatus = True
		Dim serverTime As Long = DateTime.Now
		UpdateCacheWithSubscription(True, "test_subscription", serverTime)
		
		Dim result As Map
		result.Initialize
		result.Put("is_subscribed", True)
		result.Put("server_time_utc", serverTime)
		result.Put("source", "test_mode")
		Return result
	End If
	
	' Use the same validation endpoint as purchases (iOS receipts contain all purchase info)
	' The difference is we update the subscription cache instead of purchase cache
	Try
		' Build request for validator
		Dim requestMap As Map
		requestMap.Initialize
		requestMap.Put("app_id", mAppId)
		requestMap.Put("platform", "ios")
		requestMap.Put("device_user_id", mDeviceUserId)
		requestMap.Put("receipt_base64", ReceiptBase64)
		requestMap.Put("include_debug", True)
		requestMap.Put("api_key", mApiKey)
		'If mApiKey <> "" Then requestMap.Put("api_key", mApiKey)
		
		Dim json As JSONGenerator
		json.Initialize(requestMap)
		
		' Fix boolean conversion
		Dim jsonString As String = json.ToString
		jsonString = jsonString.Replace($""include_debug":1"$, $""include_debug":true"$)
		jsonString = jsonString.Replace($""include_debug":0"$, $""include_debug":false"$)
		
		LogColor("🛡  Validating iOS subscription for " & mAppId & "...", LOG_COLOR_LIB_PURPLE)
		
		Dim job As xHttpJob
		job.Initialize("", Me)
		job.PostString(mBaseUrl & "/purchase/validate", jsonString)
		job.GetRequest.SetContentType("application/json")
		
		Wait For (job) JobDone(job As xHttpJob)
		
		If job.Success Then
			Dim parser As JSONParser
			parser.Initialize(job.GetString)
			Dim response As Map = parser.NextObject
			
			' Parse validator response
			Dim ok As Boolean = response.Get("ok")
			Dim entitlementActive As Boolean = response.Get("entitlement_active")
			
			' Log server response summary
			Dim rcLog As String = IIf(response.ContainsKey("reason_code") And response.Get("reason_code") <> Null, response.Get("reason_code"), "ok")
			Dim msgLog As String = IIf(response.ContainsKey("message") And response.Get("message") <> Null, response.Get("message"), "")
			If rcLog = "active" Then
				LogColor("🛡  Subscription: " & rcLog, LOG_COLOR_LIB)
			Else If msgLog <> "" Then
				LogColor("🛡  Response: " & rcLog & " — " & msgLog, LOG_COLOR_LIB)
			Else
				LogColor("🛡  Response: " & rcLog, LOG_COLOR_LIB)
			End If
			
			' CREDIT LIMIT CHECK: If dev's credits are exhausted, don't punish the end user
			If response.ContainsKey("reason_code") Then
				Dim reasonCode As String = response.Get("reason_code")
				If reasonCode = "credit_limit_exceeded" Then
					LogColor("🛡  Credit limit exceeded — keeping last known subscription status", LOG_COLOR_LIB_WARNING)
					LogColor("🛡  Status may be stale — cannot verify until credits are restored", LOG_COLOR_LIB_WARNING)
					LogColor("🛡  Upgrade your plan at https://app.b4xpurchasemanager.com/dashboard/billing", LOG_COLOR_LIB_WARNING)
					mCacheTimestampSubscription = DateTime.Now  ' Update timestamp so cache stays valid and prevents duplicate calls
					Dim result As Map
					result.Initialize
					result.Put("is_subscribed", mCachedSubscriptionActive)
					result.Put("server_time_utc", DateTime.Now)
					result.Put("source", "cache_fallback")
					result.Put("reason_code", reasonCode)
					job.Release
					Return result
				End If
			End If
			
			' Extract subscription details from debug info
			Dim productId As String = ""
			Dim expiryDate As Long = 0
			If response.ContainsKey("debug") Then
				Try
					Dim debugInfo As Object = response.Get("debug")
					If debugInfo Is Map Then
						Dim debugMap As Map = debugInfo
						If debugMap.ContainsKey("product_id") Then
							productId = debugMap.Get("product_id")
						End If
						' Try to extract expiry date (may be in different formats)
						If debugMap.ContainsKey("expires_date_ms") Then
							expiryDate = debugMap.Get("expires_date_ms")
						Else If debugMap.ContainsKey("expires_date") Then
							' expires_date is in milliseconds as string
							Dim expiryStr As String = debugMap.Get("expires_date")
							If IsNumber(expiryStr) Then
								expiryDate = expiryStr
							End If
						End If
					End If
				Catch
				End Try'ignore
			End If
			
			' Store expiry date before updating cache
			If expiryDate > 0 Then
				mCachedSubscriptionExpiryDate = expiryDate
			End If
			
			' Update subscription cache (not purchase cache!)
			Dim serverTime As Long = DateTime.Now
			UpdateCacheWithSubscription(entitlementActive, productId, serverTime)
			
			Dim result As Map
			result.Initialize
			result.Put("is_subscribed", entitlementActive)
			result.Put("server_time_utc", serverTime)
			result.Put("source", "server")
			result.Put("validation_ok", ok)
			result.Put("product_id", productId)
			
			job.Release
			Return result
		Else
			LogColor("🛡  Server error: " & job.ErrorMessage, LOG_COLOR_LIB_WARNING)
			
			Dim result As Map
			result.Initialize
			result.Put("is_subscribed", False)
			result.Put("error", job.ErrorMessage)
			
			job.Release
			Return result
		End If
	Catch
		LogColor("🛡  Exception confirming iOS subscription: " & LastException, LOG_COLOR_LIB_WARNING)
		
		Dim result As Map
		result.Initialize
		result.Put("is_subscribed", False)
		result.Put("error", LastException)
		Return result
	End Try
End Sub

' Confirm Android purchase (after successful purchase or restore)
' ProductId: e.g., "vibryo-lifetime-unlock"
' PurchaseToken: Google Play purchase token
Public Sub ConfirmAndroidUnlock(ProductId As String, PurchaseToken As String) As ResumableSub
	' TEST MODE: Simulate successful unlock
	If mTestMode Then
		Sleep(800)  ' Simulate network delay
		mTestUnlockStatus = True
		Dim serverTime As Long = DateTime.Now
		UpdateCache(True, serverTime)
		
		Dim result As Map
		result.Initialize
		result.Put("is_unlocked", True)
		result.Put("server_time_utc", serverTime)
		result.Put("source", "test_mode")
		Return result
	End If
	
	Try
		' Determine product type based on product ID
		Dim productType As String = "inapp"  ' Default to in-app purchase
		If ProductId.Contains("subscription") Or ProductId.Contains("monthly") Or ProductId.Contains("yearly") Then
			productType = "subscription"
		End If
		
		' Build request for validator
		Dim requestMap As Map
		requestMap.Initialize
		requestMap.Put("app_id", mAppId)
		requestMap.Put("platform", "android")
		requestMap.Put("device_user_id", mDeviceUserId)
		requestMap.Put("package_name", mPackageName)
		requestMap.Put("product_id", ProductId)
		requestMap.Put("purchase_token", PurchaseToken)
		requestMap.Put("product_type", productType)
		requestMap.Put("include_debug", True)
		requestMap.Put("api_key", mApiKey)
		'If mApiKey <> "" Then requestMap.Put("api_key", mApiKey)
		
		Dim json As JSONGenerator
		json.Initialize(requestMap)
		
		LogColor("🛡  Validating Android in-app purchase for " & mAppId & "...", LOG_COLOR_LIB_PURPLE)
		
		Dim job As xHttpJob
		job.Initialize("", Me)
		job.PostString(mBaseUrl & "/purchase/validate", json.ToString)
		job.GetRequest.SetContentType("application/json")
		
		Wait For (job) JobDone(job As xHttpJob)
		
		If job.Success Then
			Dim parser As JSONParser
			parser.Initialize(job.GetString)
			Dim response As Map = parser.NextObject
			
			' Parse validator response
			Dim ok As Boolean = response.Get("ok")
			Dim entitlementActive As Boolean = response.Get("entitlement_active")
			
			' Log server response summary
			Dim rcLog As String = IIf(response.ContainsKey("reason_code") And response.Get("reason_code") <> Null, response.Get("reason_code"), "ok")
			Dim msgLog As String = IIf(response.ContainsKey("message") And response.Get("message") <> Null, response.Get("message"), "")
			If rcLog = "active" Then
				LogColor("🛡  In-app: " & rcLog, LOG_COLOR_LIB)
			Else If msgLog <> "" Then
				LogColor("🛡  Response: " & rcLog & " — " & msgLog, LOG_COLOR_LIB)
			Else
				LogColor("🛡  Response: " & rcLog, LOG_COLOR_LIB)
			End If
			
			' CREDIT LIMIT CHECK: If dev's credits are exhausted, don't punish the end user
			If response.ContainsKey("reason_code") Then
				Dim reasonCode As String = response.Get("reason_code")
				If reasonCode = "credit_limit_exceeded" Then
					LogColor("🛡  Credit limit exceeded — keeping last known unlock status", LOG_COLOR_LIB_WARNING)
					LogColor("🛡  Status may be stale — cannot verify until credits are restored", LOG_COLOR_LIB_WARNING)
					LogColor("🛡  Upgrade your plan at https://app.b4xpurchasemanager.com/dashboard/billing", LOG_COLOR_LIB_WARNING)
					mCacheTimestampInapp = DateTime.Now  ' Update timestamp so cache stays valid and prevents duplicate calls
					Dim result As Map
					result.Initialize
					result.Put("is_unlocked", mCachedUnlockStatus)
					result.Put("server_time_utc", DateTime.Now)
					result.Put("source", "cache_fallback")
					result.Put("reason_code", reasonCode)
					job.Release
					Return result
				End If
			End If
			
			' Extract debug info if available
			If response.ContainsKey("debug") Then
				Try
					Dim debugInfo As Object = response.Get("debug")
					If debugInfo Is Map Then
						' Debug data extracted (logic preserved, logging removed)
					End If
				Catch
				End Try'ignore
			End If
			
			' Update cache
			Dim serverTime As Long = DateTime.Now
			UpdateCache(entitlementActive, serverTime)
			
			Dim result As Map
			result.Initialize
			result.Put("is_unlocked", entitlementActive)
			result.Put("server_time_utc", serverTime)
			result.Put("source", "server")
			result.Put("validation_ok", ok)
			
			job.Release
			Return result
		Else
			LogColor("🛡  Server error: " & job.ErrorMessage, LOG_COLOR_LIB_WARNING)
			
			Dim result As Map
			result.Initialize
			result.Put("is_unlocked", False)
			result.Put("error", job.ErrorMessage)
			
			job.Release
			Return result
		End If
	Catch
		LogColor("🛡  Exception confirming Android unlock: " & LastException, LOG_COLOR_LIB_WARNING)
		
		Dim result As Map
		result.Initialize
		result.Put("is_unlocked", False)
		result.Put("error", LastException)
		Return result
	End Try
End Sub

' Check if in-app purchase cache is still valid (independent of subscription)
Public Sub IsCacheValidInapp As Boolean
	' Never purchased in-app — no need to revalidate, zero API calls
	If mPurchaseTimestampInapp = 0 Then Return True
	' Dormant (refunded) — stop validating until re-purchase
	If mInappDormant Then Return True
	
	Dim now As Long = DateTime.Now
	Dim age As Long = now - mCacheTimestampInapp
	
	If DebugValidation Then
		If mCachedUnlockStatus Then
			Dim daysSincePurchase As Long = (now - mPurchaseTimestampInapp) / (24 * 60 * 60 * 1000)
			If daysSincePurchase < REFUND_WINDOW_DAYS Then
				Return age < CACHE_TTL_UNLOCKED_NEW_DEBUG
			Else
				Return age < CACHE_TTL_UNLOCKED_OLD_DEBUG
			End If
		Else
			' Was previously unlocked but now locked (refund) — go dormant immediately
			mInappDormant = True
			PersistDormantState
			Return True
		End If
	Else
		If mCachedUnlockStatus Then
			Dim daysSincePurchase As Long = (now - mPurchaseTimestampInapp) / (24 * 60 * 60 * 1000)
			If daysSincePurchase < REFUND_WINDOW_DAYS Then
				Return age < CACHE_TTL_UNLOCKED_NEW
			Else
				Return age < CACHE_TTL_UNLOCKED_OLD
			End If
		Else
			' Was previously unlocked but now locked (refund) — go dormant immediately
			mInappDormant = True
			PersistDormantState
			Return True
		End If
	End If
End Sub

' Check if subscription cache is still valid (independent of in-app)
Public Sub IsCacheValidSubscription As Boolean
	' Never subscribed — no need to revalidate, zero API calls
	If mPurchaseTimestampSubscription = 0 Then Return True
	' Dormant (expired past grace period) — stop validating until re-subscribe
	If mSubscriptionDormant Then Return True
	
	Dim now As Long = DateTime.Now
	Dim age As Long = now - mCacheTimestampSubscription
	
	Dim gracePeriod As Long = SUBSCRIPTION_GRACE_PERIOD
	If DebugValidation Then gracePeriod = SUBSCRIPTION_GRACE_PERIOD_DEBUG
	
	If mCachedSubscriptionActive Then
		' Active subscription: 24-hour TTL
		If DebugValidation Then
			Return age < CACHE_TTL_SUBSCRIPTION_DEBUG
		Else
			Return age < CACHE_TTL_SUBSCRIPTION
		End If
	Else
		' Expired — check grace period
		If mSubscriptionExpiredAt > 0 Then
			Dim timeSinceExpiry As Long = now - mSubscriptionExpiredAt
			If timeSinceExpiry > gracePeriod Then
				' Grace period over — go dormant
				mSubscriptionDormant = True
				PersistDormantState
				LogColor("🛡  Subscription grace period ended — validation paused until re-subscribe", LOG_COLOR_LIB)
				Return True
			End If
		End If
		' Still in grace period — keep checking every 24h
		If DebugValidation Then
			Return age < CACHE_TTL_SUBSCRIPTION_DEBUG
		Else
			Return age < CACHE_TTL_SUBSCRIPTION
		End If
	End If
End Sub

' Legacy compatibility — returns True only if BOTH caches are valid
' Used by CheckStatus/timer to determine if any validation is needed
Public Sub IsCacheValid As Boolean
	Return IsCacheValidInapp And IsCacheValidSubscription
End Sub

' Update local cache with new in-app unlock status
Private Sub UpdateCache(Unlocked As Boolean, ServerTime As Long)
	mCachedUnlockStatus = Unlocked
	mCacheTimestampInapp = ServerTime
	
	' If this is a new unlock, record purchase timestamp and wake from dormant
	If Unlocked And mPurchaseTimestampInapp = 0 Then
		mPurchaseTimestampInapp = ServerTime
	End If
	
	' If unlocked, ensure not dormant
	If Unlocked Then
		mInappDormant = False
	End If
	
	' Persist to KeyValueStore
	Dim kvs As KeyValueStore
	kvs.Initialize(sDir, "unlock_data.db")
	kvs.Put("cached_unlock_status", Unlocked)
	kvs.Put("cache_timestamp_inapp", ServerTime)
	kvs.Put("purchase_timestamp_inapp", mPurchaseTimestampInapp)
	kvs.Put("inapp_dormant", mInappDormant)
	kvs.Close
End Sub

' Update cache with subscription info
Private Sub UpdateCacheWithSubscription(SubscriptionActive As Boolean, SubscriptionId As String, ServerTime As Long)
	' DON'T set mCachedUnlockStatus - subscriptions are tracked separately!
	mCachedSubscriptionActive = SubscriptionActive
	mCachedSubscriptionId = SubscriptionId
	mCacheTimestampSubscription = ServerTime
	
	' If this is a new subscription, record timestamp and wake from dormant
	If SubscriptionActive Then
		If mPurchaseTimestampSubscription = 0 Then
			mPurchaseTimestampSubscription = ServerTime
		End If
		mSubscriptionDormant = False
		mSubscriptionExpiredAt = 0  ' Reset expiry tracking
	Else
		' Subscription not active — record when expiry was first detected
		If mSubscriptionExpiredAt = 0 And mPurchaseTimestampSubscription > 0 Then
			mSubscriptionExpiredAt = ServerTime
			LogColor("🛡  Subscription expired — grace period started (7 days)", LOG_COLOR_LIB)
		End If
	End If
	
	' Persist to KeyValueStore
	Dim kvs As KeyValueStore
	kvs.Initialize(sDir, "unlock_data.db")
	' DON'T update cached_unlock_status - only update subscription fields
	kvs.Put("cached_subscription_active", SubscriptionActive)
	kvs.Put("cached_subscription_id", SubscriptionId)
	kvs.Put("cached_subscription_expiry", mCachedSubscriptionExpiryDate)
	kvs.Put("cache_timestamp_subscription", ServerTime)
	kvs.Put("purchase_timestamp_subscription", mPurchaseTimestampSubscription)
	kvs.Put("subscription_expired_at", mSubscriptionExpiredAt)
	kvs.Put("subscription_dormant", mSubscriptionDormant)
	kvs.Close
End Sub

' Load cached unlock status from storage (call on app start)
Public Sub LoadCachedStatus
	Try
		Dim kvs As KeyValueStore
		kvs.Initialize(sDir, "unlock_data.db")
		
		If kvs.ContainsKey("cached_unlock_status") Then
			mCachedUnlockStatus = kvs.Get("cached_unlock_status")
		End If
		
		' Load in-app cache timestamps
		If kvs.ContainsKey("cache_timestamp_inapp") Then
			mCacheTimestampInapp = kvs.Get("cache_timestamp_inapp")
			mPurchaseTimestampInapp = kvs.GetDefault("purchase_timestamp_inapp", 0)
			mInappDormant = kvs.GetDefault("inapp_dormant", False)
		End If
		
		' Load subscription info if available
		If kvs.ContainsKey("cached_subscription_active") Then
			mCachedSubscriptionActive = kvs.Get("cached_subscription_active")
			mCachedSubscriptionId = kvs.GetDefault("cached_subscription_id", "")
			mCachedSubscriptionExpiryDate = kvs.GetDefault("cached_subscription_expiry", 0)
		End If
		
		' Load subscription cache timestamps
		If kvs.ContainsKey("cache_timestamp_subscription") Then
			mCacheTimestampSubscription = kvs.Get("cache_timestamp_subscription")
			mPurchaseTimestampSubscription = kvs.GetDefault("purchase_timestamp_subscription", 0)
			mSubscriptionExpiredAt = kvs.GetDefault("subscription_expired_at", 0)
			mSubscriptionDormant = kvs.GetDefault("subscription_dormant", False)
		End If
		
		' Load consumable count
		If kvs.ContainsKey("consumable_count") Then
			mCachedConsumableCount = kvs.Get("consumable_count")
		End If
		
		kvs.Close
	Catch
	End Try'ignore
End Sub

' Force immediate validation check (bypasses cache)
' Useful for testing or when you need to verify status immediately
' Note: This requires passing in the billing/subscription handlers
' Returns True if validation was successful (regardless of unlock status)
' ForceRefresh: When True, bypasses cache checks (for explicit developer calls)
'              When False, respects independent cache validity (for timer/background calls)
Public Sub ValidateNow(InappHandler As Object, SubscriptionHandler As Object, ForceRefresh As Boolean) As ResumableSub
	' Set validation flag
	mValidationInProgress = True
	
	Try
		' Note: Do NOT reset caches here → the credit_limit_exceeded fallback
		' needs the last known good status. ForceValidate already bypasses cache.
		
		Dim inappObj As clsInapp = InappHandler
		Dim subsObj As clsSubscriptions = SubscriptionHandler
		
		' Only validate in-app purchases if products are configured
		If inappObj.Products.IsInitialized And inappObj.Products.Size > 0 Then
			If ForceRefresh Or IsCacheValidInapp = False Then
				Wait For (inappObj.ForceValidate) Complete (purchaseSuccess As Boolean)
			End If
		End If
		
		' Only validate subscriptions if subscriptions are configured
		If subsObj.Subscriptions.IsInitialized And subsObj.Subscriptions.Size > 0 Then
			If ForceRefresh Or IsCacheValidSubscription = False Then
				Wait For (subsObj.ForceValidate) Complete (subSuccess As Boolean)
			End If
		End If
		
		' Reload cached status
		LoadCachedStatus
		
		mValidationInProgress = False
		Return True
	Catch
		LogColor("🛡  ValidateNow failed: " & LastException, LOG_COLOR_LIB_WARNING)
		mValidationInProgress = False
		Return False
	End Try
End Sub

#if B4i
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

' Get current cached unlock status (synchronous)
' Use this to gate features in UI
Public Sub IsUnlocked As Boolean
	Return mCachedUnlockStatus
End Sub

' Get current cached subscription status (synchronous)
Public Sub IsSubscriptionActive As Boolean
	Return mCachedSubscriptionActive
End Sub

' Check if live validation is currently in progress
Public Sub ValidationInProgress As Boolean
	Return mValidationInProgress
End Sub

' Check if in-app purchases have ever been validated (0 = never)
Public Sub HasInappHistory As Boolean
	Return mPurchaseTimestampInapp > 0
End Sub

' Check if subscriptions have ever been validated (0 = never)
Public Sub HasSubscriptionHistory As Boolean
	Return mPurchaseTimestampSubscription > 0
End Sub

' Get active subscription ID
Public Sub GetActiveSubscriptionId As String
	Return mCachedSubscriptionId
End Sub

' Get subscription expiry date (returns 0 if not available)
Public Sub GetSubscriptionExpiryDate As Long
	Return mCachedSubscriptionExpiryDate
End Sub

' Get consumable count (locally tracked)
Public Sub GetConsumableCount As Int
	Return mCachedConsumableCount
End Sub

' Add consumables (call after successful consumable purchase)
Public Sub AddConsumables(Count As Int)
	mCachedConsumableCount = mCachedConsumableCount + Count
	
	' Persist to KeyValueStore
	Dim kvs As KeyValueStore
	kvs.Initialize(sDir, "unlock_data.db")
	kvs.Put("consumable_count", mCachedConsumableCount)
	kvs.Close
	
	LogColor("🛡  Added " & Count & " consumable(s), total: " & mCachedConsumableCount, LOG_COLOR_LIB)
End Sub

' Set consumable count directly (for syncing with an external server)
Public Sub SetConsumableCount(Count As Int)
	mCachedConsumableCount = Count
	
	' Persist to KeyValueStore
	Dim kvs As KeyValueStore
	kvs.Initialize(sDir, "unlock_data.db")
	kvs.Put("consumable_count", mCachedConsumableCount)
	kvs.Close
	
	LogColor("🛡  Consumable count set to: " & mCachedConsumableCount, LOG_COLOR_LIB)
End Sub

' Use consumables (call when user consumes an item)
Public Sub UseConsumables(Count As Int) As Boolean
	If mCachedConsumableCount >= Count Then
		mCachedConsumableCount = mCachedConsumableCount - Count
		
		' Persist to KeyValueStore
		Dim kvs As KeyValueStore
		kvs.Initialize(sDir, "unlock_data.db")
		kvs.Put("consumable_count", mCachedConsumableCount)
		kvs.Close
		
		LogColor("🛡  Used " & Count & " consumable(s), remaining: " & mCachedConsumableCount, LOG_COLOR_LIB)
		Return True
	Else
		LogColor("🛡  Not enough consumables (have: " & mCachedConsumableCount & ", need: " & Count & ")", LOG_COLOR_LIB_WARNING)
		Return False
	End If
End Sub

' Get device user ID (for debugging/support)
Public Sub GetDeviceUserId As String
	Return mDeviceUserId
End Sub

' TEST MODE ONLY: Manually set unlock status for testing
' Call this to simulate unlocking/locking without a purchase
Public Sub SetTestUnlockStatus(Unlocked As Boolean)
	If mTestMode Then
		mTestUnlockStatus = Unlocked
		Dim serverTime As Long = DateTime.Now
		UpdateCache(Unlocked, serverTime)
		LogColor("🛡  TEST MODE: Unlock status set to: " & Unlocked, LOG_COLOR_LIB)
	Else
		LogColor("🛡  SetTestUnlockStatus only works in TEST MODE", LOG_COLOR_LIB_WARNING)
	End If
End Sub

' Reset unlock status (for testing/debugging)
' Clears cache and forces locked state
Public Sub ResetUnlockStatus
	UpdateCache(False, DateTime.Now)
End Sub

' Reset subscription status (for testing expired subscriptions)
Public Sub ResetSubscriptionStatus
	mCachedSubscriptionActive = False
	mCachedSubscriptionId = ""
	mCachedSubscriptionExpiryDate = 0
	mCachedUnlockStatus = False
	mSubscriptionExpiredAt = 0
	mSubscriptionDormant = False
	
	' Persist to KeyValueStore
	Dim kvs As KeyValueStore
	kvs.Initialize(sDir, "unlock_data.db")
	kvs.Put("cached_subscription_active", False)
	kvs.Put("cached_subscription_id", "")
	kvs.Put("cached_unlock_status", False)
	kvs.Put("subscription_expired_at", 0)
	kvs.Put("subscription_dormant", False)
	kvs.Close
End Sub

' Persist dormant state to KeyValueStore (called from IsCacheValid checks)
Private Sub PersistDormantState
	Dim kvs As KeyValueStore
	kvs.Initialize(sDir, "unlock_data.db")
	kvs.Put("inapp_dormant", mInappDormant)
	kvs.Put("subscription_dormant", mSubscriptionDormant)
	kvs.Put("subscription_expired_at", mSubscriptionExpiredAt)
	kvs.Close
End Sub

' Confirm Android subscription (after successful subscription or restore)
' ProductId: e.g., "b4x_test_premium_monthly"
' PurchaseToken: Google Play purchase token
' Returns Map with: is_subscribed (Boolean), server_time_utc (Long), source (String)
Public Sub ConfirmAndroidSubscription(ProductId As String, PurchaseToken As String) As ResumableSub
	' TEST MODE: Simulate successful subscription
	If mTestMode Then
		Sleep(800)  ' Simulate network delay
		mTestUnlockStatus = True
		Dim serverTime As Long = DateTime.Now
		UpdateCacheWithSubscription(True, ProductId, serverTime)
		
		Dim result As Map
		result.Initialize
		result.Put("is_subscribed", True)
		result.Put("server_time_utc", serverTime)
		result.Put("source", "test_mode")
		Return result
	End If
	
	Try
		' Build request for validator
		Dim requestMap As Map
		requestMap.Initialize
		requestMap.Put("app_id", mAppId)
		requestMap.Put("platform", "android")
		requestMap.Put("device_user_id", mDeviceUserId)
		requestMap.Put("package_name", mPackageName)
		requestMap.Put("product_id", ProductId)
		requestMap.Put("purchase_token", PurchaseToken)
		requestMap.Put("product_type", "subscription")
		requestMap.Put("include_debug", True)
		requestMap.Put("api_key", mApiKey)
		'If mApiKey <> "" Then requestMap.Put("api_key", mApiKey)
		
		Dim json As JSONGenerator
		json.Initialize(requestMap)
		
		LogColor("🛡  Validating Android subscription for " & mAppId & "...", LOG_COLOR_LIB_PURPLE)
		
		Dim job As xHttpJob
		job.Initialize("", Me)
		job.PostString(mBaseUrl & "/purchase/validate", json.ToString)
		job.GetRequest.SetContentType("application/json")
		
		Wait For (job) JobDone(job As xHttpJob)
		
		If job.Success Then
			Dim parser As JSONParser
			parser.Initialize(job.GetString)
			Dim response As Map = parser.NextObject
			
			' Parse validator response
			Dim ok As Boolean = response.Get("ok")
			Dim entitlementActive As Boolean = response.Get("entitlement_active")
			
			' Log server response summary
			Dim rcLog As String = IIf(response.ContainsKey("reason_code") And response.Get("reason_code") <> Null, response.Get("reason_code"), "ok")
			Dim msgLog As String = IIf(response.ContainsKey("message") And response.Get("message") <> Null, response.Get("message"), "")
			If rcLog = "active" Then
				LogColor("🛡  Subscription: " & rcLog, LOG_COLOR_LIB)
			Else If msgLog <> "" Then
				LogColor("🛡  Response: " & rcLog & " — " & msgLog, LOG_COLOR_LIB)
			Else
				LogColor("🛡  Response: " & rcLog, LOG_COLOR_LIB)
			End If
			
			' CREDIT LIMIT CHECK: If dev's credits are exhausted, don't punish the end user
			If response.ContainsKey("reason_code") Then
				Dim reasonCode As String = response.Get("reason_code")
				If reasonCode = "credit_limit_exceeded" Then
					LogColor("🛡  Credit limit exceeded — keeping last known subscription status", LOG_COLOR_LIB_WARNING)
					LogColor("🛡  Status may be stale — cannot verify until credits are restored", LOG_COLOR_LIB_WARNING)
					LogColor("🛡  Upgrade your plan at https://app.b4xpurchasemanager.com/dashboard/billing", LOG_COLOR_LIB_WARNING)
					mCacheTimestampSubscription = DateTime.Now  ' Update timestamp so cache stays valid and prevents duplicate calls
					Dim result As Map
					result.Initialize
					result.Put("is_subscribed", mCachedSubscriptionActive)
					result.Put("server_time_utc", DateTime.Now)
					result.Put("source", "cache_fallback")
					result.Put("reason_code", reasonCode)
					job.Release
					Return result
				End If
			End If
			
			' Extract expiry date from debug info
			Dim expiryDate As Long = 0
			If response.ContainsKey("debug") Then
				Try
					Dim debugInfo As Object = response.Get("debug")
					If debugInfo Is Map Then
						Dim debugMap As Map = debugInfo
						
						' Try to extract expiry date (Android uses expiry_time_ms)
						If debugMap.ContainsKey("expiry_time_ms") Then
							Dim expiryStr As String = debugMap.Get("expiry_time_ms")
							If IsNumber(expiryStr) Then
								expiryDate = expiryStr
							End If
						End If
					End If
				Catch
				End Try'ignore
			End If
			
			' Store expiry date before updating cache
			If expiryDate > 0 Then
				mCachedSubscriptionExpiryDate = expiryDate
			End If
			
			' Update cache
			Dim serverTime As Long = DateTime.Now
			UpdateCacheWithSubscription(entitlementActive, ProductId, serverTime)
			
			Dim result As Map
			result.Initialize
			result.Put("is_subscribed", entitlementActive)
			result.Put("server_time_utc", serverTime)
			result.Put("source", "server")
			result.Put("validation_ok", ok)
			
			job.Release
			Return result
		Else
			LogColor("🛡  Server error: " & job.ErrorMessage, LOG_COLOR_LIB_WARNING)
			
			Dim result As Map
			result.Initialize
			result.Put("is_subscribed", False)
			result.Put("error", job.ErrorMessage)
			
			job.Release
			Return result
		End If
	Catch
		LogColor("🛡  Exception confirming Android subscription: " & LastException, LOG_COLOR_LIB_WARNING)
		
		Dim result As Map
		result.Initialize
		result.Put("is_subscribed", False)
		result.Put("error", LastException)
		Return result
	End Try
End Sub
