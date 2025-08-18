### ESP32: HMAC with SHA256 (other md's will do, too) via inline c by KMatle
### 02/01/2022
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/138094/)

Here's a short example how to generate a HMAC SHA256 hash (via passphrase). It's good to "sign" messages as a passphrase is used to hash a message,  
  
Taken from: <https://techtutorialsx.com/2018/01/25/esp32-arduino-applying-the-hmac-sha-256-mechanism/>  
  
Globals:  
  

```B4X
Public hmackey(255) As Byte  
Public hmackey_len As ULong  
Public hmacpayload(255) As Byte  
Public hmacpayload_len As ULong  
Public hmacbytes(32) As Byte
```

  
  
Payload ("the message") can be longer. I just have set it to 255.  
  
Code:  
  

```B4X
Sub Hmac  
  
    Dim s As String="secretKey"  
    bc.ArrayCopy2(s,0,hmackey,0,s.Length)  
    hmackey_len=s.Length  
      
    Dim s As String="Hello HMAC SHA 256!"  
    bc.ArrayCopy2(s,0,hmacpayload,0,s.Length)  
    hmacpayload_len=s.Length  
      
      
    RunNative("GenHmac", Null)  
    Log(bc.HexFromBytes(hmacbytes))  
      
End Sub  
  
#if c  
  
#include "mbedtls/md.h"  
  
void GenHmac (B4R::Object* o) {  
  mbedtls_md_context_t ctx;  
  mbedtls_md_type_t md_type = MBEDTLS_MD_SHA256;  
  
  mbedtls_md_init(&ctx);  
  mbedtls_md_setup(&ctx, mbedtls_md_info_from_type(md_type), 1);  
  mbedtls_md_hmac_starts(&ctx, (unsigned char *)b4r_main::_hmackey->data, b4r_main::_hmackey_len);  
  mbedtls_md_hmac_update(&ctx, (unsigned char *)b4r_main::_hmacpayload->data, b4r_main::_hmacpayload_len);  
  mbedtls_md_hmac_finish(&ctx, (unsigned char *)b4r_main::_hmacbytes->data);  
  mbedtls_md_free(&ctx);  
}  
#End If
```

  
  
Helper to check the hash: <https://www.freeformatter.com/hmac-generator.html#ad-output>  
  
Supported digest's:  
  
Change the constant or use another varaible in Globals to use it by parameter. Change the size of the hashcode variable, too (e.g. 64 bytes for sha512)  
  

```B4X
MBEDTLS_MD_NONE       
None.  
  
MBEDTLS_MD_MD2       
The MD2 message digest.  
  
MBEDTLS_MD_MD4       
The MD4 message digest.  
  
MBEDTLS_MD_MD5       
The MD5 message digest.  
  
MBEDTLS_MD_SHA1       
The SHA-1 message digest.  
  
MBEDTLS_MD_SHA224       
The SHA-224 message digest.  
  
MBEDTLS_MD_SHA256       
The SHA-256 message digest.  
  
MBEDTLS_MD_SHA384       
The SHA-384 message digest.  
  
MBEDTLS_MD_SHA512       
The SHA-512 message digest.  
  
MBEDTLS_MD_RIPEMD160       
The RIPEMD-160 message digest.
```