###  UrlEncodeMap by OliverA
### 06/04/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/118626/)

```B4X
' UrlEncodeMap(input As Map) As String  
' Converts a Map's keys/values to a URL encoded parameter string  
' Following library is used  
' B4J - jStringUtils  
' B4A - StringUtils  
' B4i - iStringUtils  
Sub UrlEncodeMap(input As Map) As String  
    Dim sb As StringBuilder  
    Dim su As StringUtils  
    sb.Initialize  
    Dim first As Boolean = True  
    For Each key In input.Keys  
        If Not(first) Then  
            sb.Append("&")  
        Else  
            first = False  
        End If  
        sb.Append($"${su.EncodeUrl(key, "UTF8")}=${su.EncodeUrl(input.Get(key), "UTF8")}"$)  
    Next  
    Return sb.ToString  
End Sub
```

  
  
Example:  

```B4X
    Dim table As String = "&some table+Ihavehere"  
    Dim username As String = "\my /name&is_John"  
    Dim nullString As String = Null  
    Dim aMap As Map = CreateMap("table" : table, "username" : username, "null String" : nullString)  
    Log(UrlEncodeMap(aMap))
```

  
  
Output:  
> table=%26some+table%2BIhavehere&username=%5Cmy+%2Fname%26is\_John&null+String=null