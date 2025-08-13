### StartActivityForResult Lib by Ivica Golubovic
### 12/06/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/157837/)

This is an extremely small but perhaps useful library for some developers. As the name suggests, its purpose is to initiate an activity to collect results.  
  
This library contains 3 methods and one event. In addition to the standard **Initialization** method, it contains **Start** and **Start2** methods.  
  
It also contains the **OnActivityResult** event and **StartActivityForResult** module which only contains two constants.  
  
Examples:  

```B4X
Sub ShowPicker  
   Dim i As Intent  
   i.Initialize("android.intent.action.RINGTONE_PICKER", "")  
   i.PutExtra("android.intent.extra.ringtone.TYPE", 1)  
    
   Dim ActivityForResult As StartActivityForResult  
   ActivityForResult.Initialize("Ion")  
   ActivityForResult.Start(i,100)  
End Sub  
  
Private Sub Ion_OnActivityResult (RequestCode As Int, ResultCode As Int, Data As Intent, ExtraParams() As Object)  
   If ResultCode = StartActivityForResult.RESULT_OK And RequestCode = 100 Then  
     Dim jo As JavaObject = Data  
     Dim uri As String = jo.RunMethod("getParcelableExtra", _  
       Array As Object("android.intent.extra.ringtone.PICKED_URI"))  
     Log(uri)  
   End If  
End Sub
```

  
  

```B4X
Sub ShowPicker  
   Dim i As Intent  
   i.Initialize("android.intent.action.RINGTONE_PICKER", "")  
   i.PutExtra("android.intent.extra.ringtone.TYPE", 1)  
   
   Dim ActivityForResult As StartActivityForResult  
   ActivityForResult.Initialize("Ion")  
   ActivityForResult.Start(i,100)  
   Wait For Ion_OnActivityResult (RequestCode As Int, ResultCode As Int, Data As Intent, ExtraParams() As Object)  
   If ResultCode = StartActivityForResult.RESULT_OK And RequestCode = 100 Then  
     Dim jo As JavaObject = Data  
     Dim uri As String = jo.RunMethod("getParcelableExtra", _  
       Array As Object("android.intent.extra.ringtone.PICKED_URI"))  
     Log(uri)  
   End If  
End Sub
```

  
  
Both examples are based on examples from this link: <https://www.b4x.com/android/forum/threads/using-startactivityforresult-with-javaobject.40374/#content>  
  
If this libraries makes your work easier and saves time in creating your application, please make a donation.  
<https://www.paypal.com/donate?hosted_button_id=HX7GS8H4XS54Q>