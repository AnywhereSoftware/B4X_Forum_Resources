### jEasyCaptcha - Setup your own Captcha Server by tummosoft
### 07/24/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/162242/)

jEasyCaptcha is a simple method can help setup your own captcha server.  
  
![](https://www.b4x.com/android/forum/attachments/155633)![](https://www.b4x.com/android/forum/attachments/155634)  
  

```B4X
Sub Class_Globals  
    Dim captcha As jEasyCaptcha  
End Sub  
  
Public Sub Initialize  
    captcha.Initialize(320,90, 5)  
End Sub  
  
Sub Handle(req As ServletRequest, resp As ServletResponse)  
    resp.ContentType = "image/gif"  
    resp.setHeader("Pragma", "No-cache")  
    resp.setHeader("Cache-Control", "no-cache")  
      
    req.GetSession.SetAttribute("captcha",captcha.toString)  
    captcha.setFont("Arial", 12)  
    captcha.WriteOut(resp.OutputStream)  
      
End Sub
```

  
  

```B4X
Sub Class_Globals  
      
End Sub  
  
Public Sub Initialize  
      
End Sub  
  
Sub Handle(req As ServletRequest, resp As ServletResponse)  
      
    Dim verCode As String = req.GetParameter("code")  
    Dim sessionCode As String = req.getSession().getAttribute("captcha")  
      
    Log("sessionCode=" & sessionCode)  
      
    Dim json As String  
      
    If (verCode = Null) Or (sessionCode.Contains(verCode) = False) Then  
        json = $"{"result":"false"}"$         
    Else  
        json = $"{"result":"true"}"$  
    End If  
      
    Log(json)  
End Sub
```