### Example Spinner to Bold, Italic or other typeface by AHilberink
### 05/30/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/161437/)

Based on the example found at: <https://www.b4x.com/android/forum/threads/spinner-font-typeface.27513/#post-159552>  
  
Here a short example to change the spinner after added the values:  

```B4X
Sub MakeSpinnerBold(Spinner1 As Spinner) As Spinner  
    Dim Spinner_List_Value As List  
      
    Spinner_List_Value.Initialize  
    For i=0 To Spinner1.Size-1  
        Dim rs As RichString  
        rs.Initialize(Spinner1.GetItem(i))  
        rs.Style(Typeface.STYLE_BOLD,0, rs.Length)  
        Spinner_List_Value.Add(rs)  
    Next  
    Spinner1.Clear  
    Spinner1.AddAll(Spinner_List_Value)  
      
    Return Spinner1  
End Sub
```

  
  
Have fun!!