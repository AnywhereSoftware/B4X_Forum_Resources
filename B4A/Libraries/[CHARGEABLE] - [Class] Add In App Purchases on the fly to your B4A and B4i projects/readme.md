### [CHARGEABLE] - [Class] Add In App Purchases on the fly to your B4A and B4i projects by hatzisn
### 05/04/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/122780/)

Now it is easy to add in app purchases to every application (B4A or B4i) you create on the fly. Simply add the class you will get and it is as easy to use as the following B4X Pages Code:  
  

```B4X
#Region Shared Files  
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"  
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True  
#End Region  
  
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip  
  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
  
    Public iap As InAppPurchases  'To be able to access it from other B4XPages  
    Dim sql As SQL  
End Sub  
  
Public Sub Initialize  
  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
  
    'Initialize SQL DB  
    #if b4a  
    sql.Initialize(File.DirInternal, "dbfilename.db", False)  
    #else if b4i  
    sql.Initialize(File.DirDocuments, "dbfilename.db", False)  
    #End If  
  
  
    'Initialize In-App Purchases class  
    iap.Initialize(Me, "CodeOfAppForIdentificationInYourBackEnd", "MIIB…….", 30, sql)  
  
    'Set the color of toastmessages  
    iap.SetToastMessageColors(0xFFC8EFFF, 0xFF103E00)  
  
    'Set IAP Messages - For Localization purposes - Some of them are just for google (under the empty line)  
    iap.MessageBillingNotSupported = "The billing is not supported"  
    iap.MessagePurchaseCompleted = "The purchase was completed"  
    iap.MessagePurchaseNotCompleted = "The purchase was not completed"  
    iap.MessageWaitToCheckInAppPurchase = "Please wait, checking in app purchase in our back end…" 'your implementation  
  
    iap.MessageBillingUnavailable = "The billing service is unavailable"  
    iap.MessageDeveloperError = "There is a developer error. Please check your code."  
    iap.MessageErrorGeneral = "An error occured."  
    iap.MessageFeatureNotSupported = "This feature is not supported"  
    iap.MessageItemAlreadyOwned = "The item you are trying to purchase is already owned."  
    iap.MessageItemUnavailable = "This item is unavailable"  
    iap.MessageServiceDisconnected = "The service is disconnected"  
    iap.MessageServiceTimeout = "The service has timed out"  
    iap.MessageOk = "The operation you performed was successful."  
  
  
    '********************************************************************************  
    'Just for you to use in the activation process in the back end you 'll create  
    '********************************************************************************  
    iap.ActivationCode = "……………"  
    iap.NumberOfActivations = 3  
End Sub  
  
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.  
  
  
'***************************************************************************  
' GET INVENTORY  
'***************************************************************************  
Sub Button1_Click  
    Dim lProds As List  
    lProds.Initialize  
    lProds.Add("com.product1")  
    lProds.Add("com.product2")  
    lProds.Add("com.product3")  
    lProds.Add("com.product4")  
    iap.GetInventory(lProds, iap.ProductTypeManaged) 'or iap.GetInventory(lProds, iap.ProductTypeSubscription)  
  
End Sub  
  
Sub GotInventory(Products As List)  
    #if b4a  
    For Each p As SkuDetails In Products  
        Log(p.Sku)  
        Log(p.Title)  
        Log(p.Description)  
        Log(p.Price)  
    Next  
    #else if b4i  
    For Each p As ProductInformation In Products  
        Log(p.ProductIdentifier)  
        Log(p.Title)  
        Log(p.Description)  
        Log(p.LocalizedPrice)  
        Log(p.Tag)  
    Next  
    #End If  
  
End Sub  
  
  
'***************************************************************************  
' GET PURCHASED GOODS  
'***************************************************************************  
Sub Button2_Click  
    iap.GetPurchasedGoods(False, iap.ProductTypeManaged) 'or iap.GetPurchasedGoods(False, iap.ProductTypeSubscription)  
End Sub  
  
Sub GotPurchasedGoods(Purchases As Map)  
    For Each s As String In Purchases.Keys  
        Dim p As Purchase = Purchases.Get(s)  
        #if b4a  
            Log(p.Sku)  
            Log(p.OrderId)  
            Log(p.PurchaseState)  
            Log(p.PurchaseTime)  
            Log(p.PurchaseToken)  
            Log(p.Signature)  
            Log(p.DeveloperPayload)  
            Log(p.IsAcknowledged)  
            Log(p.IsAutoRenewing)  
        #else if b4i  
            Log(p.ProductIdentifier)  
            Log(p.TransactionIdentifier)  
            Log(p.TransactionDate)  
            Log(p.Tag)  
            Log(p.RestoredPurchase.IsInitialized = True) 'True if it is a restored purchase  
            Log(p.Error)  
        #End If  
    Next  
End Sub  
  
  
  
'***************************************************************************  
' PURCHASE PRODUCT  
'***************************************************************************  
Sub Button3_Click  
    iap.Purchase("com.product4", iap.ProductTypeManaged, "SomeDeveloperPayloadForAndroidEmptyForIOS")  
   'or   iap.Purchase("com.product4", iap.ProductTypeSubscription, "SomeDeveloperPayloadForAndroidEmptyForIOS")  
End Sub  
  
Sub PurchaseCompleted(Purchases As Map)  
    For Each s As String In Purchases.Keys  
        Dim p As Purchase = Purchases.Get(s)  
        #if b4a  
            Log(p.Sku)  
            Log(p.OrderId)  
            Log(p.PurchaseState)  
            Log(p.PurchaseTime)  
            Log(p.PurchaseToken)  
            Log(p.Signature)  
            Log(p.DeveloperPayload)  
            Log(p.IsAcknowledged)  
            Log(p.IsAutoRenewing)  
        #else if b4i  
            Log(p.ProductIdentifier)  
            Log(p.TransactionIdentifier)  
            Log(p.TransactionDate)  
            Log(p.Tag)  
            Log(p.RestoredPurchase.IsInitialized = True) 'True if it is a restored purchase  
            Log(p.Error)  
        #End If  
    Next  
End Sub  
  
  
Sub Button4_Click  
    If iap.HaveGotPurchasedGoods Then  
        'mRegistered = Map with pruchased product SKUs/identifiers and true as value  
        For Each productcode As String In iap.mRegistered.Keys  
            Log(productcode)  
        Next  
    End If  
End Sub  
  
  
#If b4a  
'***************************************************************************  
' CONSUME PRODUCT  
'***************************************************************************  
Sub Button5_Click  
    iap.Consume("com.product3", iap.ProductTypeManaged)  
End Sub  
#End If
```

  
  
  
What you will get:  
- The class  
- A sample project  
- Lifetime support and updates to the new versions of the class  
  
Check [this tutorial](https://www.b4x.com/android/forum/threads/in-app-purchases-setting-tutorial-new-google-play-console-accurate-as-of-2020-09-26.122777/) for Google Play Console In App Purchases Setting in the New Google Play Console - Accurate as of 2020-09-26  
  
Price 29,99EUR - Click on the following link to acquire the class. Upon payment you will immediately receive by automated procedures an e-mail with a link to download the file. If you do not receive this e-mail within 5-6 minutes please do send me a private message in messenger ([click here](https://www.messenger.com/t/100002485165372)) with your name and e-mail to validate the purchase and send you the class immediately…  
  
  
Please use Google Chrome for your acquisition because it is more compatible with the following page:  
  
<link removed temporarily due to upgrade reasons - please contact me with PM>