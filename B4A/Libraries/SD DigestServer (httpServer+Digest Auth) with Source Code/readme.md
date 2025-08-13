### SD DigestServer (httpServer+Digest Auth) with Source Code by Star-Dust
### 12/25/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/126779/)

The library has been updated to be cross-platform and you can find it in [**this THREAD**](https://www.b4x.com/android/forum/threads/b4x-xhttpserver-beta.129190/)  
  
I have extended the HttpServer Library functions by adding Digest authentication.  
This is a demonstration version, it allows normal http connections (such as httpserver) and activating the digest protocol on a specific folder will display (if you enter the correct credentials) a standard page.  
  
You can ask for the full version privately which allows you to send your http pages to requests for authenticated pages  
[**(Here b4i version)**](https://www.b4x.com/android/forum/threads/sd-ihttpserver-beta.126700/)  
  
**DigestServerDemo  
  
Author:** Star-Dust  
**Version:** 0.13  

- **SecurityServer**

- **Events:**

- **HandleDigestRequest** (Request As ServletRequest, Response As ServletResponse)
- **HandleRequest** (Request As ServletRequest, Response As ServletResponse)
- **LogIn** (UserName As String, Address As String)
- **RefusedNoCredential** (Address As String)
- **RefusedWrongCredential** (UserName As String, Address As String)
- **RefusedWrongNC** (UserName As String, Address As String)

- **Fields:**

- **DigestAuthentication** As Boolean
- **DigestPath** As String
- **HeaderParameter** As Map
- **IgnoreNC** As Boolean
- **LogActive** As Boolean
- **LogFirstRefuse** As Boolean
- **realm** As String

- **Functions:**

- **Class\_Globals** As String
- **Initialize** (CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **SetHeaderDigestSecurity** (Response As ServletResponse) As String
 *es. Response.SetHeader("WWW-Authenticate",Server.GetHeaderDigestString(ovaqueValue))*- **Start** (Port As Int) As String
- **Stop** As String

- **Properties:**

- **htdigestlist**

- **tUser**

- **Fields:**

- **Address** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LastRequest** As Long
- **nc** As Int
- **nonce** As String
- **opaque** As String
- **realm** As String

- **Functions:**

- **Initialize**
*Inizializza i campi al loro valore predefinito.*
  
*HTDigest file format is Text list:*  
User1:real: Password1  
User2:real: Password2