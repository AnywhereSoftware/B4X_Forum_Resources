### Base64 en-/decode via inline C by KMatle
### 01/31/2022
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/138079/)

In Globals:  
  

```B4X
Public b64encoded (255) As Byte  
Public b64encoded_len As ULong  
      
Public b64decoded (255) As Byte  
Public b64decoded_len As ULong
```

  
  
Add to your code and call the Base64 sub  
  

```B4X
Sub Base64  
    Dim s As String="Just a text xxxxxwgwioegjw49w9gjwjogjwpogjwjgwjgwjvknvvnpggh9ag9hghaoajxx"  
    bc.ArrayCopy2(s,0,b64decoded,0,s.Length)  
    b64decoded_len=s.Length  
    Log("Cleartext: ", b64decoded)  
    RunNative("Base64Encode", Null)  
    Log("Base64: ",b64encoded)  
    Log("Lenght: ",b64encoded_len)  
      
    For i = 0 To b64decoded.Length-1  
        b64decoded(i)=0  
    Next  
    b64decoded_len=0  
    RunNative("Base64Decode", Null)  
    Log("Base64: ",b64decoded)  
    Log("Lenght: ",b64decoded_len)  
  
      
      
End Sub  
  
#if c  
#include "mbedtls/base64.h"  
void Base64Encode (B4R::Object* o) {  
  
mbedtls_base64_encode(  
    (unsigned char *)b4r_main::_b64encoded->data,  
    b4r_main::_b64encoded->length,  
    &b4r_main::_b64encoded_len,  
    (unsigned char *)b4r_main::_b64decoded->data,  
    b4r_main::_b64decoded_len  
    );  
  
}  
#End If  
  
#if c  
#include "mbedtls/base64.h"  
void Base64Decode (B4R::Object* o) {  
  
    mbedtls_base64_decode(  
  
    (unsigned char *)b4r_main::_b64decoded->data,  
    b4r_main::_b64decoded->length,  
    &b4r_main::_b64decoded_len,  
    (unsigned char *)b4r_main::_b64encoded->data,  
    b4r_main::_b64encoded_len  
    );  
}  
#End If
```