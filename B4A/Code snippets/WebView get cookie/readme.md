### WebView get cookie by peacemaker
### 04/19/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/160602/)

```B4X
'wv - WebView object  
  
Private Sub wv_PageFinished (Url As String) 'Works from API level 1 and above. WebViewClient required.   
    If wv.CookieManager.HasCookies Then  
        Dim cookies As String = wv.CookieManager.GetCookie(Url)  
        'XSRF-TOKEN=oiIn0%3D; project_session=eyJpd; logged=true  
        Dim logged As String = Parse_Cookie(cookies, "logged")  
        If logged = "true" Then  
            butSendCoords.Visible = True  
        Else  
            butSendCoords.Visible = False  
        End If  
        Log("logged=" & logged)  
    End If  
End Sub  
  
Sub Parse_Cookie(allcookies As String, GetKey As String) As String  
    Dim value_of_key As String  
    Dim cookies() As String = Regex.Split("; ", allcookies)  
    If cookies.Length > 0 Then  
        For Each cookie As String In cookies  
            If cookie.ToLowerCase.Contains(GetKey & "=") Then  
                value_of_key = cookie.Replace(GetKey & "=", "")  
                Exit  
            End If  
        Next  
        
    End If   
    Return value_of_key  
End Sub
```