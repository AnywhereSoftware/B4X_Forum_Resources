### Android In-App Billing v3 Tutorial by Erel
### 03/22/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/29997/)

**New version: [GooglePlayBilling - In App Purchases](https://www.b4x.com/android/forum/threads/109945)**   
  
[SPOILER="Old version. Not relevant"]This tutorial covers the new API for in-app billing provided by Google.  
  
The main differences between v3 and the [previous version](http://www.b4x.com/forum/basic4android-getting-started-tutorials/14608-android-app-billing-tutorial.html) are:  
- (v3) Is easier to implement.  
- Supports managed products and subscriptions. Unmanaged products are not supported.  
- Includes a method to retrieve all purchased items. This means that you do not need to manage the items yourself.  
- Allows you to "consume" managed products. For example if the user has bought a game add-on and then used it, the app consumes the product allowing the user to purchase the add-on again.  
  
The official documentation is available here: [In-app Billing Version 3 | Android Developers](http://developer.android.com/google/play/billing/api.html)  
  
**Implementing in-app billing in your application**  
  
The first step is to upload a draft APK to Google developer console. Note that you should use a private signing key to sign the app.  
  
Under Services & APIs you will find your license key. This key is also required for in-app billing:  
  
![](http://www.b4x.com/basic4android/images/SS-2013-06-06_17.21.31.png)  
  
You should also add at least one item to the "In-app Products" list. The item's type should be Managed Product or Subscription.  
  
**Basic4android code**  
  
The first step is to initialize a BillingManager3 object:  

```B4X
Sub Process_Globals  
   Dim manager As BillingManager3  
   Private key As String = "MIIBIjANBgkqhkiG9w0BAQEFAA…"  
End Sub  
  
Sub Globals  
  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   If FirstTime Then  
      manager.Initialize("manager", key)  
      manager.DebugLogging = True  
   End If  
   …  
End Sub  
  
Sub Manager_BillingSupported (Supported As Boolean, Message As String)  
   Log(Supported & ", " & Message)  
   Log("Subscriptions supported: " & manager.SubscriptionsSupported)  
End Sub
```

  
  
The BillingSupported event will be raised with the result. Note that all of the billing related actions happen in the background and raise events when the action is completed.  
  
Calling manager.GetOwnedProducts will raise the OwnedProducts event. The OwnedProducts event includes a Map that holds the user current purchases. The keys in the map are the products ids (or Skus) and the values are objects of type Purchase. These objects include more information about the purchase and are required for other actions, such as consuming a purchase.  
  

```B4X
Sub manager_OwnedProducts (Success As Boolean, purchases As Map)  
   Log(Success)  
   If Success Then  
      Log(purchases)  
      For Each p As Purchase In purchases.Values  
         Log(p.ProductId & ", Purchased? " & (p.PurchaseState = p.STATE_PURCHASED))  
      Next  
   End If  
End Sub
```

  
  
Purchasing a product is done by calling: manager.RequestPayment. The user will be asked to approve the payment. The PurchaseCompleted event will be raised when the operation completes.  
  
Note that managed products can only be purchased once. Only after you call ConsumeProduct will the user be able to purchase the same item again.  
  
Consuming purchased products is done by calling manager.ConsumeProduct.  
For example:  

```B4X
If ownedProducts.ContainsKey("test2") Then  
   manager.ConsumeProduct(ownedProducts.Get("test2"))  
End If
```

  
  
The ProductConsumed event will be raised.  
  
**Tips**  
- See this tutorial for more information about the possible testing options: [Testing In-app Billing | Android Developers](http://developer.android.com/google/play/billing/billing_testing.html)  
- If you get a "signature verification error" when trying to make a purchase then you should make sure that the licensing key is correct. If it is correct then try to upload a new APK.  
- It is recommended to use a process global variable to hold the key. This way it will be obfuscated when you compile in obfuscated mode.  
- Only one background request can run at a time.  
  
The library is available here:  
<http://www.b4x.com/forum/additional-libraries-classes-official-updates/29998-app-billing-v3-library.html#post174139>[/SPOILER]