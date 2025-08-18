### [BANanoVuetifyAD3] Encrypting & Decrypting Traffic between JavaScript (Encrypt) & PHP (Decrypt) by Mashiane
### 04/14/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/139771/)

Ola  
  
**DISCLAIMER: ALWAYS RUN YOUR PHP WEBSERVER ON TOP ON SSL**  
  
Download [Source code to REPRODUCE](https://github.com/Mashiane/BANanoVuetifyAD3/blob/main/FreeSources/js2php.zip) (Extracted from the BVAD3 Library)  
  
Whilst you might be secure when running PHP apps on top of SSL, the issue at times is internal and the risks it poses. Anyone who has access to your app can access it and be able to see what happens in the backend if you do PHP CRUD or any ajax/fetch call. Case in point this example.  
  
This example addresses how to encrypt and decrypt data between javascript & php. The example deals about dynamic SQL statements generated at client side and sent to the PHP Webserver. As my good friend puts it, I quote, "it is to stop novice users from peaking into the F12, and to discourage intermediate users from trying."  
  
To be able to see what is being sent by BANano.CallInlinePhpWait, open developer tools, select network, select payload, execute some crud functions.  
  
![](https://www.b4x.com/android/forum/attachments/127707)  
  
Whilst this is just an example of what one should not do client side (the client app must never know what happens in your backend), in most situations we are faced with building SQL queries client side and needing to be sent to the server for processing.  
  
What if there was a way to change this by encrypting and decrypting the traffic between JavaScript & PHP? Fortunately there is. I will depict the plan to achieve this below.  
  
![](https://www.b4x.com/android/forum/attachments/127708)  
  
  
Step 1  
  
A person would normally click a Save button, we want to get the form content and encrypt it before we can send to the PHP webserver for processing. Remember, even if we were sending only arguements to php they would be visible as demonstrated above. Below we just build a map, convert it to json and then encrypt it to demonstrate the first step.  
  

```B4X
Dim b As Map = CreateMap()  
    b.Put("command", "insert")  
    b.Put("query", "INSERT INTO users (firstname, lastname) VALUES (?, ?)")  
    Dim largs As List  
    largs.Initialize  
    largs.Add("Anele")  
    largs.Add("Mbanga")  
    b.Put("args", largs)  
    Dim ltypes As List  
    ltypes.Initialize  
    ltypes.Add("s")  
    ltypes.Add("s")  
    b.Put("types", ltypes)  
    Dim makeJSON As String = BANano.ToJson(b)  
    Dim xxx As String = Encrypt4Php(makeJSON, "password")
```