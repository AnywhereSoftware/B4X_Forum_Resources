###  Check is URL by Alexander Stolte
### 05/19/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/117952/)

Is not perfect, but most URLs should match it.  
<https://stackoverflow.com/a/17773849>  

```B4X
Private Sub isURL(url As String) As Boolean  
    Return Regex.IsMatch("(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})$",url)  
End Sub
```

  
  

```B4X
    If isURL("https://stackoverflow.com/a/17773849") = True Then  
        Log("valid URL")  
        Else  
            Log("is not a URL")  
    End If
```