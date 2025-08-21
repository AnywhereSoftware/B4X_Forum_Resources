### Check your app presence on Google Play by Almora
### 02/04/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/113622/)

Your app has been removed on Google Play.  
Sample code for those who have previously installed the application not to use it again.  
  

```B4X
Sub Globals  
    Dim job1 As HttpJob  
    Dim xui as XUI  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
    Dim appid as String  
    appid="xxxxxxx"  
    job1.Initialize("", Me)  
    job1.Download("https://play.google.com/store/apps/details?id="&appid)  
  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
  
Sub JobDone (job As HttpJob)  
             
            If job.Success Then  
        Log("there is application")  
            Else  
        Log("no application")  
        Wait For (xui.MsgboxAsync("This application is not used.", "info")) Msgbox_Result (result as int)  
        ExitApplication  
            End If  
  
End Sub
```