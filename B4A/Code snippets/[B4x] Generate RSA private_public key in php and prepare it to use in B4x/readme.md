### [B4x] Generate RSA private/public key in php and prepare it to use in B4x by KMatle
### 04/27/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/130167/)

Sometimes it makes sense to generate pricat/public key pairs for clients on the server side by code. Here's an example how to do this in php (OpenSSL must be installed as it usually is):  
  

```B4X
    $keys = openssl_pkey_new(array("private_key_bits" => $4096,"private_key_type" => OPENSSL_KEYTYPE_RSA));  
    $public_key_pem = openssl_pkey_get_details($keys)['key'];  
    openssl_pkey_export($keys, $private_key_pem);  
      
//write keys to files #1  
    file_put_contents("PublicKey.pem", $public_key_pem);  
    file_put_contents("PrivateKey.pem", $private_key_pem);  
  
//Remove header, footer and line feeds to get a simple Base64 encoded string #2  
    $public_key_pem_raw= str_replace (array("—–BEGIN PUBLIC KEY—–","—–END PUBLIC KEY—–","\r\n", "\n", "\r"), '', $public_key_pem);  
    $private_key_pem_raw= str_replace (array("—–BEGIN PRIVATE KEY—–","—–END PRIVATE KEY—–","\r\n", "\n", "\r"), '', $private_key_pem);  
  
    file_put_contents("PublicKey4B4x.raw", $public_key_pem_raw);  
    file_put_contents("PrivateKey4B4x.raw", $private_key_pem_raw);
```

  
  
  
In #1 you get something like this:  
  

```B4X
—–BEGIN PUBLIC KEY—–  
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAueeuNTLAuq26AIDMsHxL  
DtgZXEHgICs7ZVPw0g10Du8SYF2QCZTh4vSm7Hg1miqG9+3HqM/fW53wbvpHPvy0  
mlDW61eVuxqP0EKFYwTwiG8mhzg+2PkZPC6JB1xUNbxkisUano7UUM4JMGfdnBiR  
ghMPKY21sqSjuwjs4yyaxSn1SIZZHdgUoLxIYt7rQrX8bo08AqU5+ykWw97OChap  
u2mcFrMjqjqkCl2vLwEnhfXr3hTx5kAtjmTwR9BzO7QIC4JwDtkIjgKkri1MOp95  
mGVTy6PIxxNLctpndLJS0kQ/4JHJWouiqnHuFtPysORBxtGoVoTHQzfJbPIOe9m+  
lh78M0PUEaezsR6HDEnfYXz0EYU20UECAmO94jgwdehaLl6XdKCDnsPMWWpJDfmF  
yUZieI0CUh/6TMZClYu3zq5qzeTO173Zf6LmJzUyW2rCxe9viTppMtBjjVanA+lZ  
WsRS1lbDhodog4twyAy8vsM9elPDdCsVu2oigWw3UFeb8KGUxYZY1stCnGGCrM21  
XuG6Hizo3UB0ke5xSNkxIPXZIkVRStn26zDFf5QLLlAY56dH3fiWB64S9Y8zh5Mq  
lfukJA/ran/QnctmkImb0uBR1jQQujU+Qydnl9VsTE0jPE14bPn6oD7t8pA45J2S  
OqPKkPe7hZr8QRbq8XWe/YMCAwEAAQ==  
—–END PUBLIC KEY—–
```

  
  
After removing header, footer and line feeds (#2) you get  
  

```B4X
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAueeuNTLAuq26AIDMsHxLDtgZXEHgICs7ZVPw0g10Du8SYF2QCZTh4vSm7Hg1miqG9+3HqM/fW53wbvpHPvy0mlDW61eVuxqP0EKFYwTwiG8mhzg+2PkZPC6JB1xUNbxkisUano7U…..
```

  
  
Same with the private key.  
  
The keys can be transfered for example via OkHttpUtils request (mail or any other will do, too depending on your app)   
  
  
In B4x (encryption lib) you load it with   
  

```B4X
' e.g. in globals   
Dim KPG As KeyPairGenerator  
Dim EC As Cipher  
  
…  
  
EC.Initialize("RSA/ECB/PKCS1Padding")  
KPG.Initialize("RSA", 4096)  
  
Dim PrivateKeyAsBytes() As Byte=SU.DecodeBase64(PrivateKeyAsB64String) 'decode base64  
KPG.PrivateKeyFromBytes(PrivateKeyAsBytes) ' load key as bytes
```

  
  
Same for the public key  
  
Vice versa in B4x you would create the key pair, get the bytes, convert it to a Base64 string add header, footer to it and add a linefeed after 64 chars of the Base64 string to get a "human readable" format. This so called "pem" file can be used in OpenSSL (and other) directly.  
  
On Windows you can do it (OpenSSL must be installed) via \*.bat file, too:  
  

```B4X
cd C:\xampp\apache\bin 'where OpenSSL lives  
openssl genrsa  -out PrivateKey.pem 4096  
openssl pkcs8 -topk8 -inform pem -in PrivateKey.pem -outform pem -nocrypt -out C:/rsa/PrivateKey.pem  
openssl rsa -pubout -in PrivateKey.pem -out C:/rsa/PublicKey.pem
```