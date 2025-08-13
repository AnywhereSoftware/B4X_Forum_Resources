### Verify receipts for "Auto-renewable subscriptions" by fredo
### 01/03/2025
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/132432/)

*For a current project, it was necessary to verify "Auto-renewable subscription" purchases in the Apple App Store.   
Since the available information on this was very extensive and often confusing, below is the variant that works for me.   
Maybe it saves others a time-consuming* odyssey *through endless documentation and well-intentioned help in the forum landscapes outside there…*  
  
**The use case**  
An app is offered as a subscription with automatic renewal. It has to be ensured that the proof of purchase is authentic.  
  
**The implementation**  
To verify the validity of an active subscription it is necessary to do this via an EXTERNAL server (this is the only way to exclude tampering on the local device). The function on the server (a PHP file) receives a proof of purchase from the app and makes a request to Apple with an additional secret word. Apple responds and returns detailed status information back to the app.  
  
**The process**  
When a user buys a subscription, he receives a proof of purchase, which is stored on the device (in the keychain).  
When the app is started, the saved purchase receipt is used to query the server about the status of the subscription. Depending on the result, the app can be continued or terminated.  
  
Sandbox or productive?  
The requests are created in such a way that the productive address is queried first and only if necessary is it automatically switched to sandbox.  
  
**The test project**  
consists of a B4XPages project and a PHP file.  
All subscription-relevant functions and the layout for the purchase are created in a separate class.  
The purchase relevant events are handled within the class and only the result is returned in a callback.  
During the initialization in B4XMainPage only your product descriptions and your server address need to be specified.  
With the project you can trigger a purchase or verify a purchase receipt and get the result in JSON format.  
  
[SPOILER="The code"]  
  
The PHP file  

```B4X
<?php  
$json['receipt-data'] = $_GET['receipt'];  
$json['password'] = "yyyyyyyyyyyyyyy-yoursecret-yyyyyyyyyyyy";  
$json['exclude-old-transactions'] = true;  
$testing = $_GET['calltype'];  
$url = "";  
if($testing == 'prod'){  
    $url = "https://buy.itunes.apple.com/verifyReceipt";  
}else if($testing == 'debug'){  
    $url = "https://sandbox.itunes.apple.com/verifyReceipt";  
}  
$post = json_encode($json);  
$ch = curl_init();  
curl_setopt($ch, CURLOPT_URL,$url);  
curl_setopt($ch, CURLOPT_POST,1);  
curl_setopt($ch, CURLOPT_POSTFIELDS, $post);  
$result=curl_exec ($ch);  
curl_close ($ch);  
print_r ($result, true);  
?>
```

  
  

```B4X
' ————————————  
' Handle ios subscriptions  
' fredo v1  
' ————————————  
'  
' Tutorial: Validate app and in-app purchase receipts with the App Store –> https://developer.apple.com/documentation/appstorereceipts  
'  
' Tutorial: How to get a receipt, by Jack Cole –> https://www.b4x.com/android/forum/threads/error-getting-receipt-for-in-app-subscription.107955/post-675071  
'  
' Tutorial: Validate a receipt, by apple dev –> https://developer.apple.com/documentation/storekit/in-app_purchase/validating_receipts_with_the_app_store#//apple_ref/doc/uid/TP40010573-CH104-SW1  
'  
' Tutorial: Receipt Verification, by Dan Burcaw –> https://www.namiml.com/blog/app-store-receipt-verification-tutorial  
'  
' Tool: Http Tester "Postman" –> https://www.postman.com/home  
'  
' Tool: PHP checker and beautifier –> https://beautifytools.com/php-beautifier.php  
'  
' Tool: Visualize JSON tree –> https://json.bloople.net/  
'  
Sub Class_Globals  
    Private xui As XUI  
    Private su As StringUtils  
  
    Private EventNametocall As String = ""  
    Private CallerObj As Object  
  
    Private urlvali As String = ""  
  
    Private keychain As Phone  
    Private istore As Store  
  
    Public ProdId_M As String  
    Public ProdId_Y As String  
    Public Price_M As String  
    Public Price_Y As String  
  
    Private ParentPanel As B4XView  
    Private MainPanelSubscription As B4XView  
    Private MainPanBackSub_BtnFrame As B4XView  
    Private MainPanBackSub_Button1 As B4XView  
    Private MainPanBackSub_Button2 As B4XView  
    Private MainPanBackSub_Label4 As B4XView  
    Private Subscr_Hourglass As B4XView  
  
    Private SubscLabelInfo As B4XView  
  
End Sub  
  
Public Sub Initialize(caller As Object, EventName As String, Parent As B4XView, ProductID_M As String, ProductID_Y As String, url_validation As String)  
    CallerObj = caller  
    EventNametocall = EventName  
    urlvali = url_validation  
    ParentPanel = Parent  
    ProdId_M = ProductID_M  
    ProdId_Y = ProductID_Y  
    If Not(MainPanelSubscription.IsInitialized) Then  
        ParentPanel.LoadLayout("subscriptionpanel")  
        Subscr_Hourglass.visible = False  
        Subscr_Hourglass.SetColorAndBorder(0x735F9EA0, 0, 0, Subscr_Hourglass.Width /2)  
    End If  
    Dim ProdIds As List  
    ProdIds.Initialize  
    ProdIds.Add(ProductID_M)  
    ProdIds.Add(ProductID_Y)  
    istore.Initialize("istore")  
    ShowInfoText("")  
    If istore.CanMakePayments  Then  
        Subscr_Hourglass.visible = True  
        istore.RequestProductsInformation(ProdIds)    ' Erel –> https://www.b4x.com/android/forum/threads/in-app-purchase-get-price-of-item.78489/post-497882  
    Else  
        ShowInfoText("Payments on this device not available")  
    End If  
End Sub  
private Sub istore_InformationAvailable (Success As Boolean, Products As List)  
    If Success Then  
        For Each p As ProductInformation In Products  
            Select Case True  
                Case p.ProductIdentifier = ProdId_M  
                    Price_M = p.LocalizedPrice  
                Case p.ProductIdentifier = ProdId_Y  
                    Price_Y = p.LocalizedPrice  
            End Select  
        Next  
    End If  
    MainPanBackSub_Button1.Text = Price_M & " / Month"  
    MainPanBackSub_Button2.Text = Price_Y & " / Year"  
    Subscr_Hourglass.visible = False  
End Sub  
  
Private Sub MainPanBackSub_Button_Click As ResumableSub  
    Dim bx As B4XView = Sender  
    Select Case bx.Tag  
        Case "b0" ' Close panel  
            DialogHide  
        Case "btnM" ' Buy Monthly  
            ViewWibbl(Sender)  
            iStoreBuy(ProdId_M)  
        Case "btnY" ' Buy Yearly  
            ViewWibbl(Sender)  
            iStoreBuy(ProdId_Y)  
        Case "btnR" ' Restore  
            ViewWibbl(Sender)  
            wait for (RestoreSubscription) complete(ProdPurch As Purchase)  
            Dim AppMap As Map  
            AppMap.Initialize  
            AppMap.Put("productrestored", ProdPurch.ProductIdentifier)  
            AppMap.Put("sender", "RestoreSubscription")  
            CallSubDelayed2(CallerObj, EventNametocall & "_ActionCompleted", AppMap)  
    End Select  
    Return Null  
End Sub  
  
Public Sub DialogShow  
    MainPanelSubscription.Visible = True  
End Sub  
Public Sub DialogHide  
    Subscr_Hourglass.visible = False  
    MainPanelSubscription.Visible = False  
End Sub  
  
private Sub ViewWibbl(viewx As B4XView)  
    Dim du As Int = 50  
    Dim bxl As Int = viewx.Left  
    viewx.SetLayoutAnimated(du, bxl +4dip, viewx.Top, viewx.Width, viewx.Height)  
    Sleep(du)  
    viewx.SetLayoutAnimated(du, bxl -8dip, viewx.Top, viewx.Width, viewx.Height)  
    Sleep(du)  
    viewx.SetLayoutAnimated(du, bxl, viewx.Top, viewx.Width, viewx.Height)  
    Sleep(du)  
End Sub  
  
public Sub ResetProducts  
    keychain.KeyChainRemove("receiptraw")  
End Sub  
  
public Sub iStoreBuy(ProductToBuy As String) As ResumableSub  
    If Not(istore.CanMakePayments) Then  
        xui.MsgboxAsync("In-App Purchases are not allowed on this device", "In-App Purchases")  
        Return Null  
    End If  
  
    ShowInfoText("Payment in progress")  
    Subscr_Hourglass.visible = True  
    Subscr_Hourglass.SetRotationAnimated(400, 180)  
    Sleep(400)  
  
    istore.RequestPayment(ProductToBuy)  
    wait for istore_PurchaseCompleted (Success As Boolean, Product As Purchase)  
  
    ShowInfoText("Purchase completed")  
    Subscr_Hourglass.SetRotationAnimated(400, -180)  
    Sleep(400)  
  
    If Success = True Then  
     
        ' — Get receipt for transaction —  
        Dim no As NativeObject = Product  
        Dim receiptobject As NativeObject = no.GetField("transactionReceipt")  
        If receiptobject.IsInitialized Then  
            Dim b() As Byte = receiptobject.NSDataToArray(receiptobject)  
            Dim receiptraw As String = BytesToString(b, 0, b.Length, "UTF-8")  
            keychain.KeyChainPut("receiptraw", receiptraw)  
            '  receipt data: {  
            '        "signature" = "AyqFJPQJf2nL8gw…8cTqA==";  
            '        "purchase-info" = "ewoJIm9yaWdpb…LARGESEQUENCE…OCBFdGMvR01UIjsKfQ==";  
            '        "environment" = "Sandbox";  
            '        "pod" = "100";  
            '        "signing-status" = "0";  
            '    }  
        Else  
            ShowInfoText("")  
            xui.MsgboxAsync("No receipt!", "In-App Purchases")  
            Return Null  
        End If  
        '  
        ' — Verify the Transaction Receipt —  
        wait for (ValidateAppStoreReceipt( keychain.KeyChainGet("receiptraw") )) complete(AppMap As Map)  
  
        Subscr_Hourglass.SetRotationAnimated(400, 180)  
        Sleep(400)  
     
        ' — And finish in caller sub    
        AppMap.Put("producttobuy", ProductToBuy)  
        AppMap.Put("sender", "iStoreBuy")  
        CallSubDelayed2(CallerObj, EventNametocall & "_ActionCompleted", AppMap)  
    Else  
        ShowInfoText("Transaction ended")  
        Sleep(800)  
    End If  
  
    ShowInfoText("")  
    DialogHide  
    Subscr_Hourglass.visible = False  
    Sleep(400)  
  
    Return Null  
End Sub  
  
public Sub GetActiveProductAppStore As ResumableSub  
    If keychain.KeyChainGet("receiptraw").Length = 0 Then  
        Return CreateMap("success":False)  
    End If  
    wait for (ValidateAppStoreReceipt( keychain.KeyChainGet("receiptraw") )) complete(AppMap As Map)  
    Return AppMap  
End Sub  
  
public Sub ValidateAppStoreReceipt(receiptraw As String)  As ResumableSub  
    ' App Store Receipts –> https://developer.apple.com/documentation/appstorereceipts  
  
    ' – Prepare a result map  
    Public ActiveProductMap As Map  
    ActiveProductMap.Initialize  
    ActiveProductMap.Put("canmakepayments", istore.CanMakePayments)  
     
    ' – Try production mode first. If it fails, a second try in sandbox mode will follow.  
    ActiveProductMap.Put("environment", "production")  
    Dim validateProd As HttpJob  
    validateProd.Initialize("validateProd", Me)  
    validateProd.PostString($"${urlvali}?receipt=${su.EncodeBase64(receiptraw.GetBytes("UTF8"))}&calltype=prod"$, "")  
    validateProd.GetRequest.SetHeader("Content-Type", "application/json")  
    validateProd.GetRequest.SetContentEncoding("UTF8")  
    Wait For (validateProd) JobDone(j1 As HttpJob)  
    If Not(j1.Success) Then  
        ActiveProductMap.Put("result", "error: " & j1.ErrorMessage.Replace(CRLF, (CRLF & "    ")) )  
        Return ActiveProductMap  
    End If  
  
    Dim responseBody As String = j1.GetString  
  
#region — Returned data in j.GetString:  
    '  
    ' The Receipt decoded, Element-by-Element: https://www.namiml.com/blog/app-store-verify-receipt-definitive-guide  
    '  
    ' You get either:  
    '        {"status":21007}  
    '  
    ' or:  
    '            {"expiration_intent":"1",  
    '             "auto_renew_product_id":"MONTHLY_XYZ01",  
    '             "is_in_billing_retry_period":"0",  
    '  
    '              "latest_expired_receipt_info":  
    '                  {"original_purchase_date_pst":"2021-05-13 23:20:48 America/Los_Angeles",  
    '                 "quantity":"1",  
    '                 "unique_vendor_identifier":"FB46F756-567F-4D56-4FB4-FC2F21ABCDE",  
    '                 "bvrs":"1.4.54",  
    '                 "expires_date_formatted":"2021-07-08 15:09:53 Etc/GMT",  
    '                 "is_in_intro_offer_period":"false",  
    '                 "purchase_date_ms":"1625756693000",  
    '                 "expires_date_formatted_pst":"2021-07-08 08:09:53 America/Los_Angeles",  
    '                 "is_trial_period":"false",  
    '                 "item_id":"1568860737",  
    '                 "unique_identifier":"fddd233c4479d036f3c44e79298e128683779f60",  
    '                 "original_transaction_id":"1000000812433902",  
    '                 "subscription_group_identifier":"20281358",  
    '                 "transaction_id":"1000000833461406",  
    '                 "in_app_ownership_type":"PURCHASED",  
    '                 "web_order_line_item_id":"1000000063945483",  
    '                 "purchase_date":"2021-07-08 15:04:53 Etc/GMT",  
    '                 "product_id":"MONTHLY_XYZ01",  
    '                 "expires_date":"1625756993000",  
    '                 "original_purchase_date":"2021-05-14 06:20:48 Etc/GMT",  
    '                 "purchase_date_pst":"2021-07-08 08:04:53 America/Los_Angeles",  
    '                 "bid":"b4i.mypackage",  
    '                 "original_purchase_date_ms":"1620973248000"},  
    '              
    '             "receipt":  
    '                 {"original_purchase_date_pst":"2021-05-13 23:20:48 America/Los_Angeles",  
    '                 "quantity":"1",  
    '                 "unique_vendor_identifier":"FB46F756-567F-4D56-4FB4-FC2F21ABCDE",  
    '                 "bvrs":"1.4.54",  
    '                 "expires_date_formatted":"2021-05-23 19:50:13 Etc/GMT",  
    '                 "is_in_intro_offer_period":"false",  
    '                 "purchase_date_ms":"1621795813000",  
    '                 "expires_date_formatted_pst":"2021-05-23 12:50:13 America/Los_Angeles",  
    '                 "is_trial_period":"false",  
    '                 "item_id":"1568860951",  
    '                 "unique_identifier":"fddd233c4479d036f3caaaaa298e154383779f6a",  
    '                 "original_transaction_id":"1000000812433402",  
    '                 "subscription_group_identifier":"20781258",  
    '                 "transaction_id":"1000000839457082",  
    '                 "in_app_ownership_type":"PURCHASED",  
    '                 "web_order_line_item_id":"1000000062723775",  
    '                 "purchase_date":"2021-05-23 18:50:13 Etc/GMT",  
    '                 "product_id":"YEARLY_XYZ01",  
    '                 "expires_date":"1621799413000",  
    '                 "original_purchase_date":"2021-05-14 06:20:48 Etc/GMT",  
    '                 "purchase_date_pst":"2021-05-23 11:50:13 America/Los_Angeles",  
    '                 "bid":"b4i.mypackage",  
    '                 "original_purchase_date_ms":"1620973148000"},  
    '              
    '             "auto_renew_status":0,  
    '             "status":21006}  
    '  
#end region  
         
    Dim jp As JSONParser  
    Dim response21 As Int = 0  
    If responseBody.StartsWith($"{"status":"$) Then  
        jp.Initialize(responseBody)  
        Dim statemap1 As Map = jp.NextObject  
        response21 = statemap1.GetDefault("status", 0)  
#region – Response codes:  
        ' Apple receipt status –> https://developer.apple.com/documentation/appstorereceipts/status  
        '    21000 The request to the App Store was not made using the HTTP POST request method.  
        '    21001 This status code is no longer sent by the App Store.  
        '    21002 The data in the receipt-data property was malformed or the service experienced a temporary issue. Try again.  
        '    21003 The receipt could not be authenticated.  
        '    21004 The shared secret you provided does not match the shared secret on file for your account.  
        '    21005 The receipt server was temporarily unable to provide the receipt. Try again.  
        '    21006 This receipt is valid but the subscription has expired. When this status code is returned to your server, the receipt data is also decoded and returned as part of the response. Only returned for iOS 6-style transaction receipts for auto-renewable subscriptions.  
        '    21007 This receipt is from the test environment, but it was sent to the production environment for verification.  
        '    21008 This receipt is from the production environment, but it was sent to the test environment for verification.  
        '    21009 Internal data access error. Try again later.  
        '    21010 The user account cannot be found or has been deleted.  
#end region  
    End If  
  
    ' – Secondary try with sandbox, if prod failed  
    If response21 = 21007 Then  
        ActiveProductMap.Put("environment", "sandbox")  
        Dim validateSandbox As HttpJob  
        validateSandbox.Initialize("validateSandbox", Me)  
        validateSandbox.PostString($"${urlvali}?receipt=${su.EncodeBase64(receiptraw.GetBytes("UTF8"))}&calltype=debug"$, "")  
        validateSandbox.GetRequest.SetHeader("Content-Type", "application/json")  
        validateSandbox.GetRequest.SetContentEncoding("UTF8")  
        Wait For (validateSandbox) JobDone(j2 As HttpJob)  
        responseBody = j2.GetString  
        If responseBody.StartsWith($"{"status":"$) Then  
            jp.Initialize(responseBody)  
            Dim statemap2 As Map = jp.NextObject  
            response21 = statemap2.GetDefault("status", 0)  
        End If  
    End If  
    ActiveProductMap.Put("firstresponse21", response21)  
  
    jp.Initialize(responseBody)  
    Dim responsebodymap As Map = jp.NextObject ' App Store Receipt Data Types –> https://developer.apple.com/documentation/appstorereceipts/app_store_receipt_data_types  
    responsebodymap.Remove("latest_receipt") ' "latest_receipt" is a LARGE string that is normally not needed  
    '    Log("#-")  
    '    For Each k As String In responsebodymap.Keys  
    '        Log("#-  x345, k: " & k & " –> " & responsebodymap.Get(k))  
    '    Next  
    '    Log("#-")  
  
  
    ' — Here you pick your relevant data from the extensive responsebody  
    ActiveProductMap.Put("expiration_intent", responsebodymap.GetDefault("expiration_intent", "?")) ' –> https://developer.apple.com/documentation/appstorereceipts/expiration_intent/  
    ActiveProductMap.Put("status", responsebodymap.GetDefault("status", "?")) ' –> https://developer.apple.com/documentation/appstorereceipts/status  
    ActiveProductMap.Put("auto_renew_status", responsebodymap.GetDefault("auto_renew_status", "?")) ' –> https://developer.apple.com/documentation/appstorereceipts/auto_renew_status  
    ActiveProductMap.Put("auto_renew_product_id", responsebodymap.GetDefault("auto_renew_product_id", "?")) ' –> https://developer.apple.com/documentation/appstoreserverapi/autorenewproductid/  
    ActiveProductMap.Put("is_in_billing_retry_period", responsebodymap.GetDefault("is_in_billing_retry_period", "?")) ' –> https://developer.apple.com/documentation/appstorereceipts/is_in_billing_retry_period/  
    If responsebodymap.ContainsKey("receipt") Then  
        Dim receiptmap As Map = responsebodymap.Get("receipt")  
        ActiveProductMap.Put("receipt_product_id", receiptmap.GetDefault("product_id", "?"))  
        ActiveProductMap.Put("receipt_expires_date", receiptmap.GetDefault("expires_date", "?"))  
        ActiveProductMap.Put("receipt_expires_date2", $"$DateTime{receiptmap.GetDefault("expires_date", 0)}"$)  
    End If  
  
  
    ' – Auto renewable subscription still active?  
    If response21 = 21006 Then  
        ' The receipt is valid but the subscription has expired.  
        ' Only returned for iOS 6-style transaction receipts for auto-renewable subscriptions.  
        ActiveProductMap.Put("subscriptionexpired", True)  
        Dim sf As Object = xui.MsgboxAsync("Your Subscription has expired", "Subscription")  
        Wait For (sf) Msgbox_Result (Result As Int)  
    Else  
        ActiveProductMap.Put("subscriptionexpired", False)  
    End If  
  
    Return ActiveProductMap  
End Sub  
  
public Sub RestoreSubscription As ResumableSub  
    Subscr_Hourglass.Visible = True  
    Subscr_Hourglass.SetRotationAnimated(400, 180)  
    ShowInfoText("Restore Subscription" & CRLF & "in progress")  
    Sleep(400)  
  
    istore.RestoreTransactions  
    wait for istore_PurchaseCompleted (Success As Boolean, Product As Purchase)  
    If Success = True Then  
        Subscr_Hourglass.SetRotationAnimated(400, -180)  
        Sleep(400)  
    End If  
  
    Subscr_Hourglass.SetRotationAnimated(400, 180)  
    Subscr_Hourglass.Visible = False  
    ShowInfoText("Subscription restored")  
    Sleep(600)  
    ShowInfoText("")  
  
    Return Product  
End Sub  
  
  
  
private Sub ShowInfoText(Text As String)  
    If Text="" Then  
        SubscLabelInfo.Visible = False  
    Else  
        SubscLabelInfo.Text = Text  
        SubscLabelInfo.Visible = True  
    End If  
End Sub  
Private Sub SubscLabelInfo_Click  
    ' Nothing. Just consume the click  
End Sub
```

  
  
Your own customizations in Main:  

```B4X
  #PlistExtra: <key>yyyyour.owwwwnserveradress.com</key><dict><key>NSIncludesSubdomains….  
  #CertificateFile: yourfile  
  #ProvisionFile: yourfile
```

  
  
Your own customizations in B4XMainPage:  

```B4X
    ' The names of your products and the sharedsecret are found (replace 000 with your appid) here:   https://appstoreconnect.apple.com/apps/000/appstore/addons?m=  
    bisu.Initialize(Me, "bisu", Root, _  
        "MONTHLY_XYZ01", _  
        "YEARLY_XYZ01", _  
        "http://yyyyour.owwwwnserveradress.com/recvali.php")  '
```

  
  
Your own customizations in the PHP-file:  

```B4X
   $json['password'] = "yyyyyyyyyyyyyyy-yoursecret-yyyyyyyyyyyy";
```

  
  
  
[/SPOILER]  
  
[SPOILER="Credits"]  
The results are based on the preliminary work of  
[USER=13521]@walterf25[/USER] –> <https://www.b4x.com/android/forum/threads/in-app-purchase-receipt-validation.112505/>  
[USER=92578]@Yvon Steinthal[/USER] –> <https://www.b4x.com/android/forum/threads/in-app-subscription-question.101278/post-636275>  
tufanv –> <https://www.b4x.com/android/forum/threads/problem-with-in-app-purchase.94742/post-636429>  
 <https://www.b4x.com/android/forum/threads/enhanced-receipts-for-subscriptions-purchase.81887/post-519124>  
[/SPOILER]  
  
  
***Please ask questions [in the QUESTION section](https://www.b4x.com/android/forum/forums/ios-questions.62/post-thread)!***   
*Not here.* 