### Force Hide Keyboard by plager
### 02/16/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/170337/)

Been upset lately about soft keyboard not always hides itself when needed, especially on cover screen on Samsung Flip 7. Those callings didn't help and keyboard was still sticking out. Not sure, if it comes from cover screen controlability, or Samsung.  

```B4X
phone.HideKeyboard(Main) ' or any other view which had a focus with keyboard  
ime.HideKeyboard
```

  
  
For hiding keyboard I had to press 'back' key at the bottom of the screen. Not too comfy for me.  
Been creative with some chatBots. One of them suggested this procedure. It's working on A13, and A16. I believe it can work on other android versions as well. Tested on B4A version 13.40. Works flawlessly!  
  

```B4X
Sub ForceHideKeyboard  
    Dim jo As JavaObject  
    jo.InitializeContext  
  
    Dim imm As JavaObject = jo.RunMethod("getSystemService", Array("input_method"))  
    Dim decor As JavaObject = jo.RunMethodJO("getWindow", Null).RunMethodJO("getDecorView", Null)  
    imm.RunMethod("hideSoftInputFromWindow", Array(decor.RunMethod("getWindowToken", Null), 0))  
End Sub
```