###  B4XDialog with adjustable button widths by Erel
### 11/04/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/169198/)

![](https://www.b4x.com/android/forum/attachments/168092)  
  
Cross platform code to adjust the button widths based on their text.  
  

```B4X
'Canvas1 is a global B4XCanvas used for measuring the text (see attached example).  
Private Sub ArrangeButtons(Dialog1 As B4XDialog, Canvas1 As B4XCanvas)  
    Dim offset As Int = Dialog1.Base.Width - 2dip  
    Dim gap As Int = 4dip  
    For Each BtnType As Int In Array(xui.DialogResponse_Cancel, xui.DialogResponse_Negative, xui.DialogResponse_Positive)  
        For Each btn As B4XView In Dialog1.Base.GetAllViewsRecursive  
            If Initialized(btn.Tag) And btn.Tag = BtnType Then 'ignore  
                Dim r As B4XRect = Canvas1.MeasureText(btn.Text, btn.Font)  
                Dim width As Float = r.Width + 30dip 'change padding as needed  
                btn.SetLayoutAnimated(0, offset - width - gap, btn.Top, width, btn.Height)  
                offset = offset - width - gap  
            End If  
        Next  
    Next  
End Sub
```

  
  
Usage:  

```B4X
Private Sub Button1_Click  
    Dim rs As Object = Dialog.Show("Testing", "abcde abc", "fg gf", "hk")  
    ArrangeButtons(Dialog, cvs) 'cvs is a global B4XCanvas  
    Wait For (rs) Complete (Result As Int)  
End Sub
```

  
  
Example is attached.