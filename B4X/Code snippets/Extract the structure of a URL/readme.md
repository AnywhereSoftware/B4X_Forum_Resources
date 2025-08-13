###  Extract the structure of a URL by TILogistic
### 04/05/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/160323/)

I share a simple routine that allows you to extract the structure of a URL.  
**Note:**  
In the "path" section it allows you to extract the parameters of the pretty URL and "parameters" those of a normal URL.  
  
See the examples  
  
**URL tests**  

```B4X
    Dim URL As String = "https://www.example.com:80/page?param1=value1&param2=value2"  
    Dim URL As String = "https://www.b4x.com/android/forum/whats-new/posts/3584726/"  
    Dim URL As String = "https://translate.google.com/?hl=es&sl=en&tl=es&text=Extract%20the%20structure%20of%20a%20URL&op=translate"  
    
    Dim m As Map = ExtractURLStruct(URL)  
    
    For Each Key As String In m.Keys  
        Log(Key & " : " & m.Get(Key))  
    Next  
    
    Log(" —– Path —– ")  
  
    For Each Value As String In Regex.Split("/", m.Get("path"))  
        If Value.Length = 0 Then Continue  
        Log(Value)  
    Next  
    
    Log(" —– Parameters —– ")  
  
    For Each Parameters As String In Regex.Split("&", m.Get("parameters"))  
        Dim Pair() As String = Regex.Split("=", Parameters)  
        If Pair.Length = 2 Then  
            Log(Pair(0) & " : " & Pair(1))  
        End If  
    Next
```

  
  
**Routine**  

```B4X
Public Sub ExtractURLStruct(URL As String) As Map  
    Dim Pattern As String = $"^([^:\/?#]+):\/\/([^\/:]+)(?::(\d+))?(\/[^?#]*)?(?:\?([^#]*))?(?:#(.*))?"$  
    Dim Matcher As Matcher = Regex.Matcher(Pattern, URL)  
    Dim Result As Map : Result.Initialize  
    If Matcher.Find Then  
        Result.Put("url",       Matcher.Group(0))  
        Result.Put("scheme",    Matcher.Group(1))  
        Result.Put("domain",     Matcher.Group(2))  
        Result.Put("port",         Matcher.Group(3))  
        Result.Put("path",         Matcher.Group(4))  
        Result.Put("parameters",Matcher.Group(5))  
        Result.Put("anchor",    Matcher.Group(6))  
    End If  
    Return Result  
End Sub
```

  
  
Output: Url Normal  
![](https://www.b4x.com/android/forum/attachments/152480)  
  
Url Pretty  
![](https://www.b4x.com/android/forum/attachments/152481)  
  
Ref:  
<https://developer.mozilla.org/en-US/docs/Learn/Common_questions/Web_mechanics/What_is_a_URL#parameters>  
  
**Your comments are welcome.  
Regards**