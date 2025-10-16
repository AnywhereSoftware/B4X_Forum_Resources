### GooglePlayBilling - In App Purchases by Erel
### 10/12/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/109945/)

GooglePlayBilling is based on the new in app purchases service: <https://developer.android.com/google/play/billing/billing_library_overview>  
  
Usage instructions:  
1. Add to the manifest editor:  

```B4X
CreateResourceFromFile(Macro, GooglePlayBilling.GooglePlayBilling)
```

  
  
2. Create a BillingClient object in the starter service and initialize it.  
The PurchasesUpdated is the only event that needs to be handled in its own sub and that sub must be in the same module where BillingClient was initialized.  
The other events should be handled with Wait For.  
  
3. You shouldn't assume that the connection to the store service is always valid. You should instead call Billing.ConnectIfNeeded before making other requests:  

```B4X
Wait For (billing.ConnectIfNeeded) Billing_Connected (Result As BillingResult)  
If Result.IsSuccess Then
```

  
  
4. Call QueryPurchases to get the currently owned purchases. Note that it might include incomplete (pending) purchases. You should check the purchase state.  
  
5. Making an order is done in several steps:  
a. Get the SKU details with QuerySkuDetails.  
b. Call LaunchBillingFlow to start the order process. This is the only method that must be called from an Activity or a class initialized with an activity context (such as B4XPages pages)  
c. The PurchasesUpdated event will be raised with the result, unless there was an error which prevented the order from starting. You should also check the returned BillingResult object.  
d. Verify the order signature. This can be done locally or remotely. It is safer to do it with with a remote server.  
Verifying it locally is done by calling VerifyPurchase with the base64 key you got from Google Play Console.  
  
6. All orders must be acknowledged or consumed in three days. Consuming a purchase removes it from the "owned" products.  
  
Acknowledging:  

```B4X
If p.IsAcknowledged = False Then  
   Wait For (billing.AcknowledgePurchase(p.PurchaseToken, "")) Billing_AcknowledgeCompleted (Result As BillingResult)  
   Log("Acknowledged: " & Result.IsSuccess)  
End If
```

  
  
Consuming:  

```B4X
Wait For (billing.Consume(p.PurchaseToken, "")) Billing_ConsumeCompleted (Result As BillingResult)
```

  
  
Tips:  
  
- Calling BillingResult.IsSuccess will log the error message in debug mode when there is an error.  
- Subscriptions require a different method to start the billing flow: <https://www.b4x.com/android/forum/threads/problem-with-googlebilling-library-3-in-new-app-due-to-google-restriction.142524/post-903185>  
  
**Updates**  
  
- v7.01 - Fixed outdated manifest macro.  
- v7.00 - Based on Google Play Billing v7.00. **Note that the android.test.purchased id no longer works. This partially breaks the example.**  
- v5.21 - Based on Google Play Billing v5.21.  
- v5.00 - Based on Google Play Billing v5.0.0  
- v1.11 - Fixed the issue with Google Play warning about AIDL.  
- v1.10 - Based on Google Play Billing v3.0.1 - developer payload is no longer supported. The payload parameter (renamed to unused) doesn't do anything.  
  
**This is an internal library.**