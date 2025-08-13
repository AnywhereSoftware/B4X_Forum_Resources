### StatusBar, NagivationBar and Background color all the same! by Cableguy
### 11/01/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/157161/)

Hi Guys,  
  
I am using the below code to change the color of the StatusBar, the NavigationBar and also change the Statusbar visibility flag….  
I rekoned I could also change the Navigation bar visibility flag… so after almost 1h of searching, I found what value that flag is!!!  
  

```B4X
Sub SetStatusNavigationBarColor(clr As Int)  
Dim p As Phone  
If p.SdkVersion >= 21 Then  
Dim jo As JavaObject  
        jo.InitializeContext  
Dim window As JavaObject = jo.RunMethodJO("getWindow", Null)  
window.RunMethod("addFlags", Array (0x80000000))  
window.RunMethod("clearFlags", Array (0x04000000))  
window.RunMethod("setStatusBarColor", Array(clr))  
window.RunMethod("setNavigationBarColor", Array(clr))  
End If  
If p.SdkVersion >= 23 Then  
        jo = Root  
jo.RunMethod("setSystemUiVisibility", Array(8192+16)) 'SYSTEM_UI_FLAG_LIGHT_STATUS_BAR + SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR  
End If  
End Sub
```

  
  
This code allows for a continuous light color app background with dark text, icons and buttons.