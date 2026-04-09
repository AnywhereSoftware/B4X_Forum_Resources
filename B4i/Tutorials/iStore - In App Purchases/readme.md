### iStore - In App Purchases by Erel
### 04/05/2026
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/49301/)

The iStore library allows you to use the store In-App Purchases features inside your app.  
You can let the user purchase digital products from inside your app.  
  
(Unsurprisingly) the configuration required is a bit tedious.  
  
In order to test this feature (and later release it) you need to create an app in iTunes Connect and create one or more in-app products. You don't need to actually upload the app binary file however you do need to fill all the fields and prepare the app. Later you can change them as needed.  
  
After you've created an app placeholder in iTunes you need to carefully follow these instructions:  
<https://developer.apple.com/library/ios/technotes/tn2259/_index.html>  
  
The main steps:  

1. iOS Paid Applications contract should appear under "contracts in effect".
2. You need to create an explicit App Id (without wildcards) and download a new provision file.
You can use #ProvisionFile to tell the IDE which provision file should be used.3. Create a test account as explained in the tech note. Later you will sign out of the store from the Settings app. **Note that you should not sign in to the store with the test account from the Settings app.** The test account should only be used inside your app.
4. Create one or more in-app products and make sure **not** to upload a screenshot during development.

iStore library supports two types of products: consumable and non-consumable products.  
Consumable - The user can purchase these products multiple times. For example in a game a user can purchase extra health or coins.  
Non-consumable - The user can purchase such products once. For example the user can use such product to permanently remove ads from the app. If you are selling such products then you need to allow the user to restore such products if the user switches to a different device (with a "restore transactions" button).  
  
**Code**  
  
The code is quite simple.  
First you initialize a Store object and check whether the device supports this feature:  

```B4X
Dim MyStore As Store 'declare it in Process Globals / Class_Globals  
…  
MyStore.Initialize("MyStore")  
If MyStore.CanMakePayments = False Then …
```

  
  
Later you can request a payment and then handle the PurchaseCompleted event:  

```B4X
MyStore.RequestPayment("product.id")  
  
Sub MyStore_PurchaseCompleted (Success As Boolean, Product As Purchase)  
   Log("Purchase completed")  
   If Product.IsInitialized Then  
     Log("Product: " & Product.ProductIdentifier & ", date=" & DateTime.Time(Product.TransactionDate) & _  
       ", Transaction identifier=" & Product.TransactionIdentifier)  
   End If  
   Log("Success = " & Success)  
End Sub
```

  
  
The user will be asked to log in to his store account (use the test account here) and approve the purchase.  
  
**Restoring non-consumable purchases**  
  
As noted above, if you are selling such products then you are expected to provide a way for the user to restore completed transaction.  
Once the user requests to restore transactions you need to call MyStore.RestoreTransactions. The PurchaseCompleted event will be raised for each previous purchase of non-consumable products.  
The TransactionsRestored event will be raised at the end.  
  
Note that the user might be asked to log in to his account, therefore you shouldn't call this method when the apps starts to find existing purchases (unlike the Android library).