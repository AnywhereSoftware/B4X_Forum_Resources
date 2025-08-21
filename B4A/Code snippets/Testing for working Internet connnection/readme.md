### Testing for working Internet connnection by Derek Johnson
### 10/06/2019
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/110233/)

Some time ago I published a code snippet for testing for a working Internet connection. A user (<https://www.b4x.com/android/forum/members/sam_madinah.115755/>) recently pointed an error case that I had not encountered and I'd like to republish the resulting updated code snippet.  
  

```B4X
Sub IsOnline As Boolean  
    'Requires Phone Library  
    Dim p As Phone  
    Dim Response, Error As StringBuilder  
    Response.Initialize  
    Error.Initialize  
    Try  
        'Ping Google DNS - if you can't reach this you are in serious trouble (or in China)!  
        p.Shell("ping -q -c 1 -W 2 8.8.8.8",Null,Response,Error)  
          
        If Error.ToString="" Then  
            If Response.ToString.Contains("100% packet loss") Then  
                Log("Ping ran but no response " &  Response.ToString)  
                Return False  
            End If  
            Return True  
        Else  
            Return False  
        End If  
    Catch  
        Log("Error pinging Google DNS: "  & Error.ToString)  
        Return False  
    End Try  
  
End Sub
```

  
  
The missing use case was where the ping started but it returned no packets. (Usually you get an error string)