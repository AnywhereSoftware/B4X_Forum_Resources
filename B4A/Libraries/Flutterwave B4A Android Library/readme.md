### Flutterwave B4A Android Library by Claude Obiri Amadu
### 02/23/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/138700/)

[HEADING=1]Flutterwave B4A Android Library[/HEADING]  
![](https://www.b4x.com/android/forum/attachments/125964)  
This is a library for easy integration of [Flutterwave](https://flutterwave.com/) with your Android application with [B4A](https://www.b4x.com/b4a.html). Use this library in your B4A project.  
  
[HEADING=1]Summarized flow[/HEADING]  

1. Collect user's details such as email & name
2. Initialize the transaction

- Call the [Initialize Transaction](https://developer.flutterwave.com/docs/collecting-payments) endpoint
- App will loads [WebView](https://b4x.com/android/help/views.html#webview) to initialize a transaction
- User enter details for transaction

3. Once successful, a prompt will be displayed.

[HEADING=1]Requirements[/HEADING]  

- Android SDKv16 (Android 4.1 "Jelly Bean") and above
- [JavaObject](https://b4x.com/android/help/javaobject.html)

[HEADING=1]Installation & Usage[/HEADING]  
[HEADING=2]B4A[/HEADING]  
[HEADING=3]Download Flutterwave.jar & Flutterwave.xml and place in your additional libraries folder[/HEADING]  
[HEADING=3]Enable the Flutterwave Library in your Libraries Tab[/HEADING]  
  

```B4X
Sub Globals  
    Dim Pay As Flutterwave  
End Sub
```

  
[HEADING=3][/HEADING]  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
Activity.LoadLayout("Layout")  
Pay.Initialize("Pay","FLWPUBK_TEST-SANDBOXDEMOKEY-X",Me,Activity,True)  
End Sub
```

  
  

```B4X
Sub Button1_Click  
    Pay.InitializeTransaction("obirixxxxxx@gmail.com","0558382XXX","Clxxxx Oxxxx", 1,"test-1234567890","Label","TEST",Pay.CURRENCY_GHS,"")  
End Sub
```

  
[HEADING=3][/HEADING]  
[HEADING=1]Demo[/HEADING]  
Download/Clone <https://github.com/claudeamadu/flutterwave-b4a/tree/master/Demo>  
![](https://www.b4x.com/android/forum/attachments/125965)![](https://www.b4x.com/android/forum/attachments/125966)![](https://www.b4x.com/android/forum/attachments/125967)![](https://www.b4x.com/android/forum/attachments/125968)![](https://www.b4x.com/android/forum/attachments/125969)  
  
[HEADING=1]Security[/HEADING]  
If you discover any issues, please email [EMAIL]obiriclaude@gmail.com[/EMAIL].  
  
[HEADING=1]Contact[/HEADING]  
For more enquiries and technical questions regarding the B4A Android PaystackSdk, please post on our issue tracker: <https://github.com/claudeamadu/flutterwave-b4a/issues>.  
  
[HEADING=1]Change log[/HEADING]  
Please see [CHANGELOG](https://github.com/claudeamadu/flutterwave-b4a/blob/master/CHANGELOG.md) for more information what has changed recently.