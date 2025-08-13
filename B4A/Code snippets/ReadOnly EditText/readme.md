### ReadOnly EditText by aeric
### 03/01/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/146495/)

Someone asked in Chinese WeChat group about EditText that is read only. Input Type = NONE.  
Here is my solution:  
  

```B4X
Dim jo As JavaObject = EditText1  
jo.RunMethod("setTextIsSelectable", Array(True))
```

  
  
This solution still allows Cut, Copy and Paste when you long press the text.  
  
If you want to disable Cut, Copy and Paste, I think it is better to use [Clipboard](https://www.b4x.com/android/forum/threads/clipboard-library.7382/) library.  
  

```B4X
Sub Class_Globals  
    Private xui As XUI  
    Private Root As B4XView  
    Private EditText2 As B4XView  
    Private CB As BClipboard  
End Sub  
  
Private Sub EditText2_LongClick  
    CB.setText(EditText2.Text)  
    xui.MsgboxAsync("Copied to Clipboard", "EditText2")  
End Sub
```