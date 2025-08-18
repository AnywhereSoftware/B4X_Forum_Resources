### [BANano] Authentication to a B4J server (REST API) by alwaysbusy
### 02/16/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/100269/)

Here is an example on how to connect with a Jetty B4J server. The example shows how you could use the B4J server to login/logoff and run a basic REST API call.  
  
The project zip file is in post #3  
  
Together, they make a very powerful solution!  
  
> **Note:** because it needs a Cookie, you must run it on a server. You can quickly set one up with the "Web Browser For Chrome' plugin. Tutorial: <https://www.b4x.com/android/forum/threads/banano-tip-running-a-test-server.100180>

  
The example lets you login with a username (**UserName**) and password (**Password**). When correct (case sensitive), it returns an **encrypted token** that is then saved as a cookie on the browser side. For all the rest of the calls, this token is then used.  
  
The relevant server code:  

```B4X
'Filter class  
Sub Class_Globals  
   Dim NumberOfDays As Int = 90  
End Sub  
  
Public Sub Initialize  
  
End Sub  
  
'Return True to allow the request to proceed.  
Public Sub Filter(req As ServletRequest, resp As ServletResponse) As Boolean  
   Dim auths As List = req.GetHeaders("Authorization")  
   Dim success As Boolean = False  
   resp.SetHeader("Access-Control-Allow-Origin","*")  
   resp.SetHeader("Access-Control-Allow-Methods" ,"GET, POST, OPTIONS")  
   resp.SetHeader("Access-Control-Allow-Headers", "Access-Control-Allow-Headers, Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers, Authorization")  
   If auths.Size > 0 Then  
       Dim auth As String = auths.Get(0)  
       If auth.StartsWith("BANBasic") = True Then  
           Dim b64 As String = auth.SubString("BANBasic ".Length)  
           Dim su As StringUtils  
           Dim b() As Byte = su.DecodeBase64(b64)  
           Dim raw As String = BytesToString(b, 0, b.Length, "utf8")  
           Dim UsernameAndPassword() As String = Regex.Split(":", raw)  
           If CheckUsernameAndPassword(UsernameAndPassword) Then  
               resp.Write($"{"BANanoStatus": 801, "BANToken": "${EncryptText(UsernameAndPassword(0) & ":" & UsernameAndPassword(1), "MyTopSecretPassword")}", "BANExpires": ${NumberOfDays}}"$)  
               Return False             
           End If  
       End If  
       If auth.StartsWith("BANBearer") = True Then  
           Dim b64 As String = auth.SubString("BANBearer ".Length)  
           Dim dec As String = DecryptText(b64, "MyTopSecretPassword")  
           Dim UsernameAndPassword() As String = Regex.Split(":", dec)  
           success = CheckUsernameAndPassword(UsernameAndPassword)     
       End If  
   End If  
   If success = False Then  
       ' we need to login  
       resp.Write($"{"BANanoStatus": 800}"$)     
   End If  
   Return success  
End Sub  
  
Sub CheckUsernameAndPassword(UsernameAndPassword() As String) As Boolean  
   If UsernameAndPassword.Length = 2 Then  
       'up to you to decide which credentials are allowed <—————————  
       If UsernameAndPassword(0) = "UserName" And UsernameAndPassword(1) = "Password" Then  
           Return True  
       End If  
   End If  
   Return False  
End Sub  
  
' some helper functions  
Sub EncryptText(text As String, password As String) As String  
   Try  
       Dim Su As StringUtils  
       Dim c As B4XCipher  
       Dim Crypt() As Byte = c.Encrypt(text.GetBytes("utf8"), password)  
       Return Su.EncodeBase64(Crypt)  
   Catch  
       Return ""  
   End Try  
End Sub  
  
Sub DecryptText(text As String, password As String) As String  
   Try  
       Dim Su As StringUtils  
       Dim c As B4XCipher  
       Dim BtCrypt() As Byte  = Su.DecodeBase64(text)  
       Dim b() As Byte = c.Decrypt(BtCrypt, password)  
       Return BytesToString(b, 0, b.Length, "utf8")  
   Catch  
       Return ""  
   End Try  
End Sub
```

  
  
The relevant Client code, which is transpiled to Javascript:  

```B4X
public Sub BANano_Ready()  
   Dim rows As List = MiniCSS.AddRows("r", 3, "row")  
   MiniCSS.AddColumns("c",rows.get(0),2, "col-sm-6")  
   MiniCSS.AddColumns("c",rows.get(1),1, "col-sm-12")  
   MiniCSS.AddColumns("c",rows.get(2),1, "col-sm-12")  
   MiniCSS.BuildGrid("body", rows)  
  
   ' show a login or logoff button, depends if we have the Cookie  
   Dim Token As String = BANano.GetCookie("BANanoDemoCookie")  
   If Token = "" Then  
       MiniCSS.Button("r1c1", "login", "Login", "primary", Me, False)  
   Else  
       MiniCSS.Button("r1c1", "login", "Log off", "primary", Me, False)  
   End If  
   MiniCSS.LoginForm("r1c1", "loginForm", Me)  
  
   ' button to test our REST Api  
   MiniCSS.Button("r2c1", "info", "Get Info", "", Me, False)  
End Sub  
  
public Sub Login_Clicked(event As BANanoEvent)  
   Dim Token As String = BANano.GetCookie("BANanoDemoCookie")  
   If Token = "" Then  
       If BANano.CheckInternetConnectionWait Then  
           ' open the popup  
           BANano.GetElement("#loginform").SetChecked(True)  
       Else  
           ' no use to try to login  
           MiniCSS.Content("r3c1", "contajax", "You are not connected to the internet!")  
       End If  
   Else  
       BANano.RemoveCookie("BANanoDemoCookie", "")  
       ' set to a log on button  
       MiniCSS.Button("r1c1", "login", "Login", "primary", Me, True)  
       MiniCSS.Content("r3c1", "contajax", "You are now logged off from the server!")  
   End If  
End Sub  
  
public Sub Info_Clicked(event As BANanoEvent)  
   If BANano.CheckInternetConnectionWait Then  
       Dim Token As String = BANano.GetCookie("BANanoDemoCookie")  
       If Token = "" Then  
           ' we will have to login  
           MiniCSS.Content("r3c1", "contajax", "You are not logged in on the server!")  
           Return  
       End If  
       ' we are logged in, so lets get some REST api running  
       Dim headers As Map  
       headers.Initialize  
       headers.put("Content-Type", "application/json")  
       headers.Put("Authorization", $"BANBearer ${Token}"$)  
       Dim res As String = BANano.CallAjaxWait("http://localhost:51042/getinfo","POST","json", "", False, headers)  
       MiniCSS.Content("r3c1", "contajax", res)  
   Else  
       MiniCSS.Content("r3c1", "contajax", "You are not connected to the internet!")  
   End If  
End Sub  
  
public Sub LoginformBtnLogin_Clicked(event As BANanoEvent)  
   ' get the username and password  
   Dim User As String = BANano.GetElement("#loginformusername").GetValue  
   Dim Password As String = BANano.GetElement("#loginformpassword").GetValue  
  
   ' close the popup  
   BANano.GetElement("#loginform").SetChecked(False)  
  
   ' try to logon to our server  
   Dim headers As Map  
   headers.Initialize  
   headers.put("Content-Type", "application/json")  
   headers.Put("Authorization", "BANBasic " & BANano.ToBase64(User & ":" & Password))  
   Dim res As String = BANano.CallAjaxWait("http://localhost:51042/","POST","json", $""$, False, headers)  
   Dim json As BANanoJSONParser  
   json.Initialize(res)  
   Dim m As Map = json.NextObject  
   Dim CheckStatus As Int = m.GetDefault("BANanoStatus",0)  
   Select Case CheckStatus  
       Case 801 ' login is ok  
           MiniCSS.Content("r3c1", "contajax", "You are logged in on the server!")  
           Dim expires As Int = m.GetDefault("BANExpires", 0)  
           BANano.SetCookie("BANanoDemoCookie", m.GetDefault("BANToken", ""), $"{"expires": ${expires}}"$)  
           ' set to a logoff button  
           MiniCSS.Button("r1c1", "login", "Log off", "primary", Me, True)  
       Case Else ' login is not ok  
           MiniCSS.Content("r3c1", "contajax", "You are not logged in on the server (wrong password?)!")  
   End Select  
End Sub
```

  
  
**The communication to your jServer is done by doing Ajax calls** e.g:  

```B4X
Dim res As String = BANano.CallAjaxWait("http://localhost:51042/getinfo","POST","json", "", False, headers)  
MiniCSS.Content("r3c1", "contajax", res)
```

  
  
**What is ExternalTestConnectionServer?**  
> *By default the connection to the internet is tested by checking if donotdelete.gif can be retrieved   
> from the assets folder where the app is hosted.  
>   
> However, if you do not put it on a host (e.g. just by opening the .html file from disk),   
> You can upload the donotdelete.gif to some host on the internet to test for an internet connection.*

  
So in my case the gif is uploaded to <http://gorgeousapps.com> j(ust to test if the user has an internet connection). **For production apps**, you must put the gif to your own server, as I can not guarantee <http://gorgeousapps.com> will keep running forever.  
  
**A couple of interesting new commands in BANano to make this work:**  

```B4X
BANano.ToBase64 ' to send the username and password  
.GetValue/.SetValue ' Umbrella had no methods for this, so I build them in  
.GetChecked/.SetChecked ' Umbrella had no methods for this, so I build them in  
BANano.Msgbox ' shows an alert
```

  
  
**Steps to test the demo:**  
1. Run the Client code to generate the app  
2. Start the Chrome Webserver plugin and point to the folder where client.html is  
3. Start the B4J server  
4. Browse to the Chrome Webserver (e.g. <http://127.0.0.1:8887/client.html>)  
5. Click on Get Info -> note that you are not logged in  
6. Click on Login, enter wrong username/password -> note that it is wrong  
7. Click on Login, enter correct username/password: UserName/Password  
8. Click on Get Info -> you get a hallo JSON  
9. Click on logout  
10. Click on Get Info -> note that you are not logged in  
  
You can see the cookie in Application - Cookies.  
  
Alain