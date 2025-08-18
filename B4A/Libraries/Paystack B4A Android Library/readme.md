### Paystack B4A Android Library by Claude Obiri Amadu
### 11/08/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/134481/)

[HEADING=1]Paystack B4A Android Library[/HEADING]  
![](https://www.b4x.com/android/forum/attachments/119408)  
This is a library for easy integration of [Paystack](https://paystack.com/) with your Android application with [B4A](https://www.b4x.com/b4a.html). Use this library in your B4A project.  
  
[HEADING=1]Summarized flow[/HEADING]  

1. Collect user's details such as email & name
2. Initialize the transaction

- Call the [Initialize Transaction](https://paystack.com/docs/api/#transaction-initialize) endpoint
- App will loads [WebView](https://b4x.com/android/help/views.html#webview) to initialize a transaction
- User enter details for transaction

3. Once successful, a prompt will be displayed.

[HEADING=1]Requirements[/HEADING]  

- Android SDKv16 (Android 4.1 "Jelly Bean") and above
- [JavaObject](https://b4x.com/android/help/javaobject.html)

[HEADING=1]Installation & Usage[/HEADING]  
[HEADING=2]B4A[/HEADING]  
[HEADING=3]Download Paystack.jar & Paystack.xml and place in your additional libraries folder[/HEADING]  
[HEADING=3]Enable the Paystack Library in your Libraries Tab[/HEADING]  
  

```B4X
Sub Globals  
    Dim Pay As Paystack  
End Sub
```

  
[HEADING=3][/HEADING]  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    Pay.Initialize("Pay","pk_test_xxxxx",Me,Activity,False)  
End Sub
```

  
  

```B4X
AddApplicationText(  
<meta-data  
    android:name="co.paystack.android.PublicKey"  
    android:value="pk_test_xxx"/>)
```

  
  

```B4X
Sub Button1_Click  
    Pay.InitializeTransaction("oxxx@gmail.com", 1,"test-1234567890",Pay.CURRENCY_GHS)  
End Sub
```

  
[HEADING=3][/HEADING]  
[HEADING=3][/HEADING]  
[HEADING=1]Demo[/HEADING]  
Download/Clone <https://github.com/claudeamadu/paystack-b4a/tree/main/Demo>  
![](https://www.b4x.com/android/forum/attachments/119452)![](https://www.b4x.com/android/forum/attachments/119453)![](https://www.b4x.com/android/forum/attachments/119454)![](https://www.b4x.com/android/forum/attachments/121399)  
  
[HEADING=1]Security[/HEADING]  
If you discover any issues, please email [EMAIL]obiriclaude@gmail.com[/EMAIL].  
  
[HEADING=1]Contact[/HEADING]  
For more enquiries and technical questions regarding the B4A Android PaystackSdk, please post on our issue tracker: <https://github.com/claudeamadu/paystack-b4a/issues>.  
  
[HEADING=1]Change log[/HEADING]  
Please see [CHANGELOG](https://github.com/claudeamadu/paystack-b4a/blob/main/CHANGELOG.md) for more information what has changed recently.