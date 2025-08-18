### A note on RSAKeyConverter by nwhitfield
### 09/26/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/122794/)

In my app, I'm using Kmatle's very handy RSA Key Converter to help handle some public key stuff: <https://www.b4x.com/android/forum/threads/rsa-convert-openssl-public-key-to-from-b4x.64905/>  
  
Essentially, while talking to the server via its API, the app has a unique session key; I want to use that to allow the app to launch website pages without requiring the user to log in. Passing the session key as a URL parameter would be a security risk, so instead, the app creates a token by encrypting the session key and other data with the server's public key.  
  
This worked just fine on my test device (Android 8), launching users to a page on the site with a properly logged in session, but on and Android 6 device, there was a crash when loading the Public Key, which is built into the app:  
  

```B4X
    Private serverPublicKey As String = $"—–BEGIN PUBLIC KEY—–  
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0bBCb3yBZC4UP8gA08mM  
MQIDAQAB  
—–END PUBLIC KEY—–"$
```

  
  
It appears the OpenSSL2B4x function was not behaving consistently. I hope this is down to Android level, and not some other function of the firmware on the two devices (they're both from the same manufacturer, which gives me a little hope. So, for the moment, I'm checking based on that, but it would be easy to try based on the exception generated.  
  
Essentially, on the Android 8 device, I can pass OpenSSL2B4x the public key string as-is, but on Android 6, I have to base64 encode it (and on 8, if I do encode it, I get an error). So the code ends up looking like this:  
  

```B4X
    Dim apikey As KeyPairGenerator  
    Dim pkbytes(0), keybytes(0), ct(0) As Byte  
    Dim su As StringUtils  
    Dim bc As ByteConverter  
    Dim r As RSAKeyConverter  
'     
    c.Initialize("RSA/ECB/PKCS1Padding")  
    apikey.Initialize("RSA",2048)  
      
    If Main.AndroidVersion >=26 Then  
        pkbytes = r.OpenSSL2B4x(serverPublicKey)  
    Else  
        pkbytes = r.OpenSSL2B4x(su.EncodeBase64(bc.StringToBytes(serverPublicKey,"UTF8")))         
    End If  
      
    apikey.PublicKeyFromBytes(pkbytes)
```