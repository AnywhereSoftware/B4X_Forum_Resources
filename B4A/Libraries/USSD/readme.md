### USSD by somed3v3loper
### 10/16/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/110039/)

Hello all,  
  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Dim myussd As USSDCallBack  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
   
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
    myussd.Initialize("ussd")  
   
  
    Starter.rp.CheckAndRequest(Starter.rp.PERMISSION_CALL_PHONE )  
    Wait For Activity_PermissionResult(perm As String,res As Boolean)  
    If perm=Starter.rp.PERMISSION_CALL_PHONE And res=True Then  
        Dim id As InputDialog  
        id.InputType=id.INPUT_TYPE_PHONE  
        Dim sf As Object = id.ShowAsync("", "Enter USSD", "Ok", "", "Cancel", Null, False)  
        Wait For (sf) Dialog_Result(Result As Int)  
        If Result = DialogResponse.POSITIVE Then  
            Log(id.Input)  
        End If  
        myussd.sendUssdRequest(id.Input)  
    Else  
        ToastMessageShow("Permission not granted",False)  
    End If  
   
End Sub  
  
Sub ussd_onreceiveussdresponse(request As String,response As String)  
    Log(response)  
    Msgbox(response,request)  
End Sub  
Sub ussd_onreceiveussdresponsefailed(request As String,failcode As Int)  
    Log(failcode)  
End Sub
```

  
0.10 has separate events like \_onreceiveussdresponsesub(request As String,response As String,subId as int) and \_onreceiveussdresponsefailedsub(request As String,failcode As Int,subId as int) for sendUssdRequestForSubscription method .