### Paytm payment gateway Integration library by maddy
### 09/16/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/109572/)

Here is demo creation of paytm library which is very easy to integrate and will help you to get money by all the payment methods by debit card ,credit card ,net banking. We can provide you help with integrating it and provide full support of taking it to the prod environment.  
here is the demo video of the paytm integration in b4a  
[MEDIA=youtube]s7ydblDiO7M[/MEDIA]  
  

```B4X
'#Region  Project Attributes  
    #ApplicationLabel: Paytm Best  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
    #BridgeLogger:True  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    Private pMap As Map  
End Sub  
  
Sub Globals  
    Private pservice As Paytm  
    Private cha As String = "WAP"  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout1")  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
   
  
Sub PaytmEvent_someuierroroccurred(inErrorMessage As String)  
    Log("B4A: paytm_someuierroroccurred")  
End Sub  
Sub PaytmEvent_ontransactionresponse(inResponse As Map)  
    LogColor("B4A: paytm_ontransactionresponse BEGIN",Colors.Blue)  
    For Each key In inResponse.Keys  
        Log(key&"="&inResponse.Get(key))  
    Next  
    
    LogColor("B4A: paytm_ontransactionresponse END",Colors.Blue)  
End Sub  
Sub PaytmEvent_networknotavailable  
    Log("B4A: paytm_networknotavailable")  
End Sub  
Sub PaytmEvent_clientauthenticationfailed( inErrorMessage As String)  
    Log("B4A: paytm_clientauthenticationfailed")  
End Sub  
Sub PaytmEvent_onerrorloadingwebpage(iniErrorCode As Int ,  inErrorMessage As String,  inFailingUrl As String)  
    Log("B4A: paytm_onerrorloadingwebpage")  
End Sub  
Sub PaytmEvent_onbackpressedcanceltransaction  
    Log("B4A: paytm_onbackpressedcanceltransaction")  
End Sub  
Sub PaytmEvent_ontransactioncancel( inErrorMessage As String,inResponse As  Map )  
    Log("B4A: paytm_ontransactioncancel")  
End Sub  
  
Sub paynow_Click  
      
    'checksum_generation_logic——————————–  
    'return checksum  
      
    pservice.Initialize("PaytmEvent",True,Null)  
    pMap.Initialize  
    pMap.put( "MID" , "xxxxxxxxxxxxxxxxx")  
    pMap.put( "ORDER_ID" , "342")  
    pMap.put( "CUST_ID" , "cust1234")  
    'pMap.put( "MOBILE_NO" , "7777777777")  
    'pMap.put( "EMAIL" , "username@emailprovider.com")  
    pMap.put( "CHANNEL_ID" , cha)  
    pMap.put( "TXN_AMOUNT" , "100")  
    pMap.put( "WEBSITE" , "WEBSTAGING")  
    '    // This Is the staging value. Production value Is available in your dashboard  
    pMap.put( "INDUSTRY_TYPE_ID" , "Retail")  
    '    // This Is the staging value. Production value Is available in your dashboard  
    pMap.put( "CALLBACK_URL", "https://pguat.paytm.com/paytmchecksum/paytmCallback.jsp")  
    pMap.put( "CHECKSUMHASH" , "CHECKSUMHASH")  
    Dim porder As Paytmorder  
    porder.Initialize(pMap)  
    pservice.InitiatePayment(porder,Null)  
End Sub
```

  
  
We will provide you full code with library in just $20. It is the simple amount you can pay to get this amazing payment gateway. Hope You Will Like It…  
  
we are open for comments and help you need so ping us at - [EMAIL]madhav.agr95@gmail.com[/EMAIL]