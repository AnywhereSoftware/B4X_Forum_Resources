### RevenueCat by Alexander Stolte
### 03/10/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/162348/)

RevenueCat is a platform that simplifies in-app subscriptions and purchases for mobile apps. It provides tools for managing subscription billing, analytics, and user retention across iOS, Android, and web, without needing to build a backend. Usage is free for apps with less than $2,500 in monthly tracked revenue (MTR).  
  
<https://www.revenuecat.com>  
  
I use the library in [CleanTasks](https://www.b4x.com/android/forum/threads/cleantasks-a-minimalist-to-do-list.159660/) and [Lognote](https://www.b4x.com/android/forum/threads/lognote-quickly-and-easily-create-notes-with-timestamps.135639/), I have only tested the whole thing in B4I.  
  
The RevenueCatPurchaseHelper class now makes it even easier to integrate revenuecat into your apps.  
  
Complete video guide for setting up and implementing:  
<https://www.b4x.com/android/forum/threads/in-app-subscriptions-with-revenuecat-and-as_premiumsummary-videos.165841/>  
  
**Setup**  
Add this code to the "Main" module of your b4i project under [ICODE]Process\_Globals[/ICODE]  

```B4X
Public HasPremium As Boolean = False
```

  
  
**Example**  

```B4X
Sub Class_Globals  
    Private PurchaseHelper As RevenueCatPurchaseHelper  
End Sub
```

  

```B4X
    PurchaseHelper.Initialize(Me,"PurchaseHelper","YourRevenueCatApiKey") 'Add your RevenueCat API key  
    PurchaseHelper.ProductIndentififer = Array As String("all_access_1_month_lognote","all_access_1_year_lognote") 'The Product identifyer
```

  

```B4X
    Wait For (PurchaseHelper.CheckPurchases) complete (Success As Boolean) 'Must be called at app start, as we check here whether the user has the Premium version  
    Log("Do I have a premium version? " & Success)  
   
    Wait For (PurchaseHelper.GetProductsInformation(PurchaseHelper.ProductIndentififer)) complete (lstPurchases As List)  
   
    For Each ProductInfo As ProductInformation In lstPurchases  
        'Log(ProductInfo.Tag)  
        'Log(ProductInfo.Description)  
        CustomListView1.AddTextItem(ProductInfo.Title & " - " & ProductInfo.LocalizedPrice,ProductInfo.ProductIdentifier)  
    Next
```

  

```B4X
Wait For (PurchaseHelper.RequestPayment(Value)) Complete (Success As Boolean)
```

  
**Message Boxes**  
The texts in the message boxes are predefined, but in case you want to customize them, you can do so:  

```B4X
    PurchaseHelper.RestoreErrorTitle = "Restore failed"  
    PurchaseHelper.RestoreErrorDescription = "No purchases found To restore."  
    PurchaseHelper.RestoreSuccessTitle = "Recovery successful"  
    PurchaseHelper.RestoreSuccessDescription = "Your purchases have been successfully restored"  
    PurchaseHelper.ProVersionExpired = "The Pro version has been canceled Or Not renewed, you are now using the basic version."  
    PurchaseHelper.ProVersionExpiredTitle = "Pro Version expired"  
    PurchaseHelper.PurchaseErrorTitle = "Purchase Failed"  
    PurchaseHelper.PurchaseErrorDescription = "Purchase was cancelled."  
    PurchaseHelper.PurchaseSuccessTitle = "You are now ready to go"  
    PurchaseHelper.PurchaseSuccessDescription = "Your purchase was successful."
```

  
  
**RevenueCat  
Author: Alexander Stolte  
Version: 1.01**  

- **RevenueCat**

- **Functions:**

- **CreatePurchase** (ProductId As String, Product As Object) As ResumableSub
*Records a purchase for a Customer from iOS, Android, or Stripe and will create a Customer if they don't already exist.  
<https://www.revenuecat.com/docs/api-v1#tag/transactions/operation/receipts>  
 Product - In B4I the ProductInformation Object in B4A the Receipt Token*- **GetCustomer** As ResumableSub
*Gets the latest Customer Info for the customer with the given App User ID, or creates a new customer if it doesn't exist.  
<https://www.revenuecat.com/docs/api-v1#tag/customers/operation/subscribers>*- **Initialize** (API\_KEY As String, AppUserId As String, lst\_ProductIdentifier As List)
*Initializes the object. You can add parameters to this method if needed.  
 <code>RevCat.Initialize("RevenueCatAPIKey",RevCatUserId,Array As String("all\_access\_1\_year","all\_access\_1\_month"))</code>*
- **RevenueCatPurchaseHelper**

- **Functions:**

- **CheckPurchases** As ResumableSub
- **GetProductsInformation** (ProductIndentififer As String) As ResumableSub
*Returns a list of ProductInformation*- **GUID** As String
- **Initialize** (Callback As Object, EventName As String, RevenueCatAPIKey As String)
*Initializes the object. You can add parameters to this method if needed.*- **RequestPayment** (ProductIdentifier As String) As ResumableSub
- **RestorePurchases** As ResumableSub

- **Properties:**

- **isExpired** As Boolean [read only]
- **ProductIndentififer** As String()
- **ProVersionExpired** As String
- **ProVersionExpiredTitle** As String
- **PurchaseErrorDescription** As String
- **PurchaseErrorTitle** As String
- **PurchaseSuccessDescription** As String
- **PurchaseSuccessTitle** As String
- **RestoreErrorDescription** As String
- **RestoreErrorTitle** As String
- **RestoreSuccessDescription** As String
- **RestoreSuccessTitle** As String

  
**Changelog**  

- **1.00**

- Release

- **1.01**

- Improvements
- Remove is\_restore from CreatePurchase

- The parameter is Deprecated

- Add class RevenueCatPurchaseHelper - Takes care of almost everything

- Saving and restoring user tokens
- Checking Purchasing status
- Restore
- Messageboxes

- **1.02**

- BugFixes

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)  
**If you have errors or questions, then please create a new thread**