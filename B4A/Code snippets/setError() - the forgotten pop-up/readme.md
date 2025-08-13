### setError() - the forgotten pop-up by drgottjr
### 03/27/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/166339/)

i stumbled across setError() the other day. i don't know that i've ever seen it in the wild, perhaps with reason as its interface is a little 1990's webpage styling. but here it is.  
  
per google documentation:  
…Sets the right-hand compound drawable of the TextView (google-ese for our label view) to the "error" icon and sets an error message that will be displayed in a popup when the TextView has focus. The icon and error message will be reset to null when any key events cause changes to the TextView's text. If the error is null, the error message and icon will be cleared. our edittext is a child of android's textview, so it inherits the setError() method. you display the text you want. you can also put up your own icon. when you start to correct your error, the pop-up is cleared.  
  

```B4X
Sub button1_click  
    If Not(edittext1.Text.ToUpperCase.CompareTo("B4X") = 0) Then  
        Dim editerror As JavaObject = edittext1  
        editerror.RunMethod("setError",Array("Bad platform! Erel has been notified."))  
    End If  
End Sub
```