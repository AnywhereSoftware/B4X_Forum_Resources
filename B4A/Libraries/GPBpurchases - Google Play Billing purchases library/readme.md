### GPBpurchases - Google Play Billing purchases library by Jerryk
### 10/16/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/163830/)

This library makes shopping on the Play Store very easy. It wraps the entire billing functionality. Just a few settings and the user can shop items. All necessary data is downloaded from the Google Play Console. Therefore, it is very important to choose the correct name and description of the purchased item in GPC. In-app items appear first, then subscriptions. Subscriptions are displayed including phases. Behavior can be set in the Designer, including colors.  
After a successful purchase, the PurchaseCompleted event is raised, where you can set the user's permissions.  
The principle of using the library is in the sample application.  
  
![](https://www.b4x.com/android/forum/attachments/158095)  
  
**GPBpurchases\_JE  
Author: Jerryk  
Version: 1.3  
  
Add to the manifest editor:**  
CreateResourceFromFile(Macro GooglePlayBilling.GooglePlayBilling)  
  
**Dependences:**  
Google Play Billing library - [GPBilling\_JE](https://www.b4x.com/android/forum/threads/b4a-gpbilling.163010/) . Download and add to Additional library folder.  
  
**Events:**  

- **PurchaseCompleted (**p As Purchase**)**

[INDENT]The event will be triggered by pressing the **Buy** or **Subscribe** button and Return.IsSuccess = True. The passed parameter is p As Purchase.[/INDENT]  

- **PurchaseError** (Result As BillingResult)

[INDENT]The event will be triggered by pressing the **Buy** or **Subscribe** button and Return.IsSuccess = False. The parameter passed is Result As BillingResult.[/INDENT]  

- **BillingError** (Result As BillingResult)

[INDENT]The event will be triggered by pressing the **Buy** or **Subscribe** button and event **PurchaseCompleted** not be raised. The parameter passed is Error As Int.[/INDENT]  
  
**Functions:**  

- **Init** (LICENSE\_KEY As String)

[INDENT]Set the Licensing Public Key from Google Play Console.[/INDENT]  

- **SetSku** (stype As String, linapp As List, lsubs As List)

[INDENT]Sets the SKUs to be displayed by the **ShowSku** function[/INDENT]  
[INDENT]stype: INAPP - show Inapp only, SUBS - show Subs only, ALL - show all SKUs [/INDENT]  
[INDENT]linapp - list of INAPP id's, lsubs - list of SUBS id's[/INDENT]  

- **ShowSku**

[INDENT]show SKUs in CustomListView[/INDENT]  

- **ErrorText** (error As Int) As String

[INDENT]convert error to string based on strings.xml[/INDENT]  

- **ConsumeProduct** (stype As String, sku As String)

[INDENT]consume product: stype - INAPP, SUBS, sku - SKU id[/INDENT]  

- **AcknowledgeProducts**(p As Purchase)

[INDENT]acknowledge products[/INDENT]  

- **GetPurchasedProducts**

gets list of all purchased products  
 return ProductResult  
  
  
**Properties:**  

- **HidePurchasedInapp** As Boolean

[INDENT]Sets or gets whether a purchased Inapp item should be displayed.[/INDENT]  

- **ShowTimeOfPurchase** As Boolean

[INDENT]Sets or gets whether to display the purchase time.[/INDENT]  

- **HideInappDescription** As Boolean

[INDENT]Sets or gets whether to display Inapp description.[/INDENT]  

- **ExpandedInappDescription** As Boolean

[INDENT]Sets or gets whether the Inapp description should be displayed expanded or collapsed.[/INDENT]  

- **HidePurchasedSubs** As Boolean

[INDENT]Sets or gets whether a purchased Subs item should be displayed.[/INDENT]  

- **ShowUnsubscribeButton** As Boolean

[INDENT]Sets or gets whether to display the Unsubscribe Button.[/INDENT]  

- **HideSubsDescription** As Boolean

[INDENT]Sets or gets whether to display Subs description.[/INDENT]  

- **ExpandedSubsDescription** As Boolean

[INDENT]Sets or gets whether the Subs description should be displayed expanded or collapsed.[/INDENT]  
  
**Localization:**  
You can localize the library. Copy the strings.xml file from the value folder to the appropriate language-specific value-xx folder. Mark as writable, translate, mark as read-only.  
  
**Versions:**  
1.2 added AcknowledgeProducts function  
1.3 added GetPurchasedProducts function  
  
**How to test the example on your Google Play Console?**  

- Change in >Build Configurations>Package to match your application.
- In the example, enter your IDs for LICENSE\_KEY and SKUs
- catch the PurchaseCompleted event and set the user's permissions
- enjoy !!!

```B4X
GPPurchases1.Init(LICENSE_KEY)  
…  
  
Private Sub B4XPage_Appear  
    Select Case skutype  
        Case "ALL"   'to show all skus to purchase  
            lSKU_inapp.Clear  
            lSKU_inapp.Add("pro.gpbtest2")   'add INAPP ID  
            lSKU_inapp.Add("pro.gpbtest3")  
            lSKU_subs.Clear  
            lSKU_subs.Add("silver.gpbtest")    'add SUBS ID  
            lSKU_subs.Add("gold.gpbtest")  
        Case "INAPP"   'to show only one inapp sku to purchase  
            lSKU_inapp.Clear  
            lSKU_inapp.Add(sku)  
        Case "SUBS"   'to show only one subs sku to purchase  
            lSKU_subs.Clear  
            lSKU_subs.Add(sku)  
    End Select  
  
    GPPurchases1.SetSku(skutype, lSKU_inapp, lSKU_subs)  
    GPPurchases1.ShowSku  
End Sub
```

  
Please donate something for the cafe, I spent a lot of time on this. :)