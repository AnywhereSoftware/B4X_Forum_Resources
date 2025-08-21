### Using StartActivityForResult with JavaObject by Erel
### 06/18/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/40374/)

SubName: StartActivityForResult  
  
Description: This code demonstrates how JavaObject can be used to call external APIs that should be called with Context.startActivityForResult.  
Same implementation in a class: <https://www.b4x.com/android/forum/threads/b4xpages-and-startactivityforresult.119176/post-745271>  
  
This code should be added to an Activity. You should also declare a process global variable named ion:  

```B4X
Sub Process_Globals  
   Private ion As Object  
End Sub
```

  
  

```B4X
Sub ion_Event (MethodName As String, Args() As Object) As Object  
'Args(0) = resultCode  
'Args(1) = intent  
Return Null  
End Sub  
  
Sub StartActivityForResult(i As Intent)  
   Dim jo As JavaObject = GetBA  
   ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)  
   jo.RunMethod("startActivityForResult", Array As Object(ion, i))  
End Sub  
  
Sub GetBA As Object  
   Dim jo As JavaObject  
   Dim cls As String = Me  
   cls = cls.SubString("class ".Length)  
   jo.InitializeStatic(cls)  
   Return jo.GetField("processBA")  
End Sub
```

  
  
For example we can show the Ringtone picker with this code:  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
   If FirstTime Then  
     ShowPicker  
   End If    
End Sub  
  
Sub ShowPicker  
   Dim i As Intent  
   i.Initialize("android.intent.action.RINGTONE_PICKER", "")  
   i.PutExtra("android.intent.extra.ringtone.TYPE", 1)  
   StartActivityForResult(i)  
End Sub  
  
  
Sub ion_Event (MethodName As String, Args() As Object) As Object  
   If Args(0) = -1 Then 'resultCode = RESULT_OK  
     Dim i As Intent = args(1)  
     Dim jo As JavaObject = i  
     Dim uri As String = jo.RunMethod("getParcelableExtra", _  
       Array As Object("android.intent.extra.ringtone.PICKED_URI"))  
     Log(uri)  
   End If  
   Return Null  
End Sub
```

  
  
Dependencies: JavaObject v1.20+  
  
Tags: StartActivityForResult, OnActivityResult