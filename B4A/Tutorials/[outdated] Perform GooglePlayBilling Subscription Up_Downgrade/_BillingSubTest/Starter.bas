B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.5
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Type BillingSubProduct(ProductID As String, Title As String, Description As String, Price As String, BillingPeriod As String, FreeTrialPeriod As Int, OrderId As String, CostLevel As Int, DeveloperPayload As String)
	Public xui As XUI
	Public billing As BillingClient
	Public PurchSubsOk As Boolean
	Public const BILLING_KEY As String = "MIIBI..."  ' <-- YOUR "licence key for this application" in GooglePlaystore developer console/ thisapp/ Development tools/ Services & APIs
	Public const BILLINGPROD1 As String = "subsprod1"
	Public const BILLINGPROD2 As String = "subsprod2"
	Public BillingPurchState(3) As String
	Public BillingActiveSubsProductTitle As String = ""
	Public pi As PhoneIntents
End Sub

Sub Service_Create
	billing.Initialize("billing")
	BillingPurchState(0) = "STATE_UNSPECIFIED"
	BillingPurchState(1) = "STATE_PURCHASED"
	BillingPurchState(2) = "STATE_PENDING"
End Sub

' --- --- --- --- --- --- --- --- --- --- --- --- --- 
Sub billing_PurchasesUpdated (Result As BillingResult, Purchases As List)
	Log("#-Sub starter.Sub billing_PurchasesUpdated, Result.IsSuccess=" & Result.IsSuccess)
	'This event will be raised when the status of one or more of the purchases has changed.
	'It will usually happen as a result of calling LaunchBillingFlow however it can be called in other cases as well.
	If Result.IsSuccess Then
		For Each p As Purchase In Purchases
			Log("#-    x39, p.Sku = " & p.Sku)
			If p.Sku.StartsWith("subsprod") Then
				HandleSubscriptionPurchase(p)
			Else
				Log("#-    x43, Unexpected product...")
			End If
		Next
	End If
End Sub

Private Sub HandleSubscriptionPurchase (p As Purchase) As ResumableSub
	Log("#-Sub starter.Sub HandleSubscriptionPurchase, p.sku=" & p.Sku)
	If p.PurchaseState <> p.STATE_PURCHASED Then Return Null
	
	' --> https://developer.android.com/google/play/billing/billing_testing.html#testing-renewals
	
	'Verify the purchase signature.
	'This cannot be done with the test id.
	If Not(p.Sku.StartsWith("subsprod")) And billing.VerifyPurchase(p, BILLING_KEY.Replace("{+}","")) = False Then  ' "{+}" is a nano-obfuscator
		Log("#-  x55, Invalid purchase")
		Return Null
	End If
	If p.IsAcknowledged = False Then
		'we either acknowledge the product or consume it.
		Dim Intval As Int = 3 ' Testdays
		Select Case p.Sku
			Case "subsprod1" ' Weekly subscription
				Intval= 7
			Case "subsprod2" ' Monthly subscription
				Intval= 30
		End Select
		Dim SubsEndTime As Long = p.PurchaseTime + (DateTime.TicksPerDay *Intval)
		Dim mypayload As String = "mp~" & p.Sku & "~" & p.PurchaseTime & "~" & Intval & "~" & SubsEndTime
		Wait For (billing.AcknowledgePurchase(p.PurchaseToken, mypayload)) Billing_AcknowledgeCompleted (Result As BillingResult)
		Log("#-  x61, Acknowledged: " & Result.IsSuccess & ", p.OrderId=" & p.OrderId)
	End If
	PurchSubsOk = True
	Log("#-  x64, Purchase OK!")
	CallSub(Main, "BillingAskProductsAndFillClv")
	Return Null
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub
