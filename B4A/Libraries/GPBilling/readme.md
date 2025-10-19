###  GPBilling by Jerryk
### 10/16/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/163010/)

This library wraps the GooglePlayBilling base library. It returns the results in structures as they are built in the Google accounting system.  
The library does not display any messages; it only returns results: BillingResult, ProductResult, or PurchasedResult. It also generates the events described below.  
When a ProductResult is returned, first read the ResponseCode value. If equal to CODE\_OK, load the data from the list; otherwise, handle an error.  
The principle of using the library is in the example application.  
  
**GPBilling\_JE  
Author: Jerryk   
Version: 1.0  
  
Add to the manifest editor:**  
[INDENT=2] CreateResourceFromFile(Macro GooglePlayBilling.GooglePlayBilling)[/INDENT]  
  
**[SIZE=4]Types:[/SIZE]**  
*to store in-app product*   
Type **InAppProduct** (  
[INDENT=2] ProductId As String \_[/INDENT]  
[INDENT=2] ProductType As String \_[/INDENT]  
[INDENT=2] Title As String \_[/INDENT]  
[INDENT=2] Name As String \_[/INDENT]  
[INDENT=2] Description As String \_[/INDENT]  
[INDENT=2] PriceAmountMicros As String \_[/INDENT]  
[INDENT=2] PriceCurrencyCode As String \_[/INDENT]  
[INDENT=2] FormattedPrice As String )[/INDENT]  
  
*to store subscription product*  
Type **SubsProduct** (  
[INDENT=2] ProductId As String \_[/INDENT]  
[INDENT=2] ProductType As String \_[/INDENT]  
[INDENT=2] Title As String \_[/INDENT]  
[INDENT=2] Name As String \_[/INDENT]  
[INDENT=2] Description As String \_[/INDENT]  
[INDENT=2] SubscriptionOfferDetails As List )[/INDENT]  
  
*to store SubscriptionOfferDetails*  
Type **SubsOffer** (  
[INDENT=2] BasePlanId As String \_[/INDENT]  
[INDENT=2] OfferId As String \_[/INDENT]  
[INDENT=2] OfferToken As String \_[/INDENT]  
[INDENT=2] OfferTags As List \_[/INDENT]  
[INDENT=2] PricingPhaseList As List )[/INDENT]  
  
*to store PricingPhases*  
Type **PricingPhase** (  
[INDENT=2] BillingCycleCount As String \_[/INDENT]  
[INDENT=2] BillingPeriod As String \_[/INDENT]  
[INDENT=2] FormattedPrice As String \_[/INDENT]  
[INDENT=2] PriceAmountMicros As String \_[/INDENT]  
[INDENT=2] PriceCurrencyCode As String \_[/INDENT]  
[INDENT=2] RecurrenceMode As String )[/INDENT]  
  
*to store returned result*  
Type **ProductResult** (  
[INDENT=2] ResponseCode As Int \_[/INDENT]  
[INDENT=2] ProductsList As List)[/INDENT]  
  
*to store purchased items*  
Type **PurchasedResult** (  
[INDENT=2] ItemPurchased As Boolean \_[/INDENT]  
[INDENT=2] ProductPurchased As Purchase)[/INDENT]  
  
**Events:**  

- **PurchaseCompleted (p As Purchase)**

[INDENT]The event will be raised when the **PurchaseInAppProducts** or **PurchaseSubsProducts** function is called with a result of IsSuccess = True for each SKU separately. The passed parameter is p As Purchase.[/INDENT]  

- **PurchaseError** (Result As BillingResult)

[INDENT]The event will be raised when the **PurchaseInAppProducts** or **PurchaseSubsProducts** function is called with a result of IsSuccess = False. The parameter passed is Result As BillingResult.[/INDENT]  
  
**Functions:**  

- **Initialize** (Callback As Object, EventName As String, AppPublicKey As String)

[INDENT]AppPublicKey = Licensing Public Key from Google Play Console[/INDENT]  

- **GetInAppProducts** (lSKUs As List) As ResumableSub

[INDENT]return ProductResult[/INDENT]  
[INDENT]*getss all available INAPP products (including disabled!!!!)*[/INDENT]  

- **GetSubscriptions** (lSKUs As List) As ResumableSub

[INDENT]return ProductResult[/INDENT]  
[INDENT]*getss all available SUBS products*[/INDENT]  

- **PurchaseInAppProducts** (lSKUs As List) As ResumableSub

[INDENT]return BillingResult[/INDENT]  
[INDENT]*purchase INAPP product*[/INDENT]  

- **PurchaseSubsProducts** (lSKUs As List, offertoken As String) As ResumableSub

[INDENT]return BillingResult[/INDENT]  
[INDENT]*purchase SUBS product*[/INDENT]  

- **IsPurchased** (skuType As String, sku As String) As ResumableSub

[INDENT]return PurchasedResult[/INDENT]  
[INDENT]**if PurchasedResult.ItemPurchased is* True Sku is purchased*[/INDENT]  

- **GetPurchasedProducts** As ResumableSub

[INDENT]return ProductResult[/INDENT]  
[INDENT]*gets list of all purchased products*[/INDENT]  

- **ConsumeProducts** (skuType As String, sku As String) As ResumableSub

[INDENT]return BillingResult[/INDENT]  
[INDENT]*consume product*[/INDENT]  

- **AcknowledgeProducts** (p As Purchase) As ResumableSub

[INDENT]return BillingResult[/INDENT]  
[INDENT]*acknowledge product VerifyPurchase is called before acknowledging*[/INDENT]  

- **ReturnResponseMessage** (Result As Int) As String

[INDENT]return error string responded to error code defined in BillingResult[/INDENT]  
[INDENT]Added two codes:[/INDENT]  
[INDENT]CODE\_NO\_INAPP - return if no in-app SKU in Google Play Console[/INDENT]  
[INDENT]CODE\_NO\_SUBSCRIPTION - return if no subs SKU in Google Play Console[/INDENT]  
  
**Properties:**  

- **message\_xxxx** (Message As String)

[INDENT]It is possible to localize a text message for each error.[/INDENT]  
[INDENT][/INDENT]  
[INDENT][/INDENT]  
How to test the example on your Google Play Console?  

- Change in >Build Configurations>Package to match your application.
- In the example, enter your ID for LICENSE\_KEY and SKUs

```B4X
    LICENSE_KEY = "MIIBIjAN…………………."  
    lSKU_INAPP.Add("pro.gpbtest2")  
    lSKU_INAPP.Add("pro.gpbtest3")  
    lSKU_SUBS.Add("silver.gpbtest")  
    lSKU_SUBS.Add("gold.gpbtest")  
  
    gpb.Initialize(Me, "gpb", LICENSE_KEY)
```