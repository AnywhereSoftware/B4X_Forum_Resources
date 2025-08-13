###  IsValidJSON (Conclusion) by TILogistic
### 07/28/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/149248/)

I am sharing a routine that I use to validate JSON.  
Test comments are welcome.  
  
thanks to [USER=74499]@aeric[/USER] for his contribution  

```B4X
Public Sub IsValidJSON(sJson As String) As Boolean  
    Try  
        sJson = sJson.Trim  
        If sJson.StartsWith("[") And sJson.EndsWith("]") Then Return sJson.As(JSON).ToList.IsInitialized  
        If sJson.StartsWith("{") And sJson.EndsWith("}") Then Return sJson.As(JSON).ToMap.IsInitialized  
        Return False  
    Catch  
        Log(LastException.Message) 'display json error  
        Return False  
    End Try  
End Sub
```

  

```B4X
    Dim sJson As String = $"[2,"C"]"$  
    Log(IsValidJSON(sJson))  
    Log("————————-")  
    Dim sJson As String = $"{car:"Toyota",model:"Prado",prices: [{year:2020,price:20000},{year:2019,price:17000},{year:2020,price:}]}"$ 'Error in price  
    Log(IsValidJSON(sJson))  
    Log("————————-")  
    Dim sJson As String = $"{car:"Toyota",model:"Prado",prices: [{year:2020,price:20000},{year:2019,price:17000},{year:2015,price:12000}]}"$  
    Log(IsValidJSON(sJson))  
    Log("————————-")  
    Dim sJson As String = $"{"menu":{"id":"file","value":"File","popup":{"menuitem":[{"value":"New","onclick":"CreateNewDoc()"},{"value":"Open","onclick":"OpenDoc()"},{"value":"Close","onclick":"Close()"}]}}}"$  
    Log(IsValidJSON(sJson))  
    Log("————————-")  
    Dim sJson As String = $"{"id":"chatcmpl-6t2JQdgU1ypn0ayhONAkE6bAEoGkz","object":"chat.completion","created":1678574948,"model":"gpt-3.5-turbo-0301","usage":{"prompt_tokens":25,"completion_tokens":110,"total_tokens":135},"choices":[{"message":{"role":"assistant","content":"Ahoy matey, ye be askin' a great question. The worst investment be ones that promise quick riches without flappin' yer sails too much, like the \"get rich quick\" schemes, ponzi schemes Or pyramid schemes. These scams be all about misuse of trust And deceivin' the inexperienced. They be luring investors with high promised returns, but in the end, they just take yer doubloons and disappear into the horizon. Stay away from such crooks and keep yer treasure safe, me hearty!"},"finish_reason":"stop","index":0}]}}"$  
    Log(IsValidJSON(sJson))
```

  
![](https://www.b4x.com/android/forum/attachments/144126)  
  
**Test 2**  

```B4X
Public Sub IsValidJSON(sJson As String) As Boolean  
    Dim obj As Object  
    Try  
        sJson = sJson.Trim  
        Select True  
            Case sJson.StartsWith("[") And sJson.EndsWith("]")  
                obj = sJson.As(JSON).ToList  
            Case sJson.StartsWith("{") And sJson.EndsWith("}")  
                obj = sJson.As(JSON).ToMap  
            Case Else  
                Return False  
        End Select  
        obj = obj.As(JSON).ToString  
        Log(obj.As(String)) 'display json text  
        Return True  
    Catch  
        Log(LastException.Message) 'display json error  
        Return False  
    End Try  
End Sub
```

  
Test:  

```B4X
    Dim sJson As String = $"[{"Monday": 2, "Thursday": 5, "Friday": 6, "Sunday": 1, "Wednesday": 4, "Tuesday": 3, "Saturday": 7 }"$  
    Log(IsValidJSON(sJson))  
    Dim sJson As String = $"[{"Monday": 2, "Thursday": 5, "Friday": 6, "Sunday": 1, "Wednesday": 4, "Tuesday": 3, "Saturday": 7 }]"$  
    Log(IsValidJSON(sJson))  
    Dim sJson As String = $"{"Monday": 2, "Thursday": 5, "Friday": 6, "Sunday": 1, "Wednesday": 4, "Tuesday": 3, "Saturday": 7 }"$  
    Log(IsValidJSON(sJson))  
    Dim sJson As String = $"{}"$  
    Log(IsValidJSON(sJson))  
    Dim sJson As String = $"[]"$  
    Log(IsValidJSON(sJson))  
    Dim sJson As String = $"[dsdsdsd:]"$  
    Log(IsValidJSON(sJson))  
    Dim sJson As String = $"{"dsdsdsd":}"$  
    Log(IsValidJSON(sJson))  
    Dim sJson As String = $" "$  
    Log(IsValidJSON(sJson))  
    Dim sJson As String = Null  
    Log(IsValidJSON(sJson))  
    Dim sJson As String = $"null"$  
    Log(IsValidJSON(sJson))
```

  
  
![](https://www.b4x.com/android/forum/attachments/144068)