### HUD Toast message multiple lines by Robert Valentino
### 04/23/2022
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/140072/)

I wanted multiple lines and found these posts <https://www.b4x.com/android/forum/threads/ihud-library-toast-messages-and-progress-dialogs.46103/page-2#post-475836>  
Then read these posts <https://stackoverflow.com/questions/15030428/mbprogresshud-to-show-label-text-in-more-than-one-line/15031656#15031656>  
  
And came up with this to give multiple lines in a toast message  
  

```B4X
hd.ToastMessageShow($"Have a nice day${CRLF} :) Line 2"$, True)  
Hud_AllowMultipleLines  
  
  
Sub Hud_AllowMultipleLines  
    Dim no1 As NativeObject = Main.App.KeyController  
      
    no1 = no1.GetField("view")  
      
    Dim no2 As NativeObject  
    Dim Hud As NativeObject = no2.Initialize("MMBProgressHUD").RunMethod("HUDForView:", Array(no1))  
      
    If     Hud.IsInitialized Then  
        Dim l As NativeObject = Hud.GetField("label")  
          
        If  l.IsInitialized Then  
            l.SetField("numberOfLines", 0)  
        End If  
    End If  
End Sub
```

  
  
Seems to work fine.