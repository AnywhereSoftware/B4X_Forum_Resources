### RSA Encryption: Create keys, en-/decrypt, hash, sign/verify signature (clean code) by KMatle
### 02/04/2023
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/145922/)

This example replaces my previous examples with cleaner inline C coding (I'm getting better :-))using almost all variables from Globals. You can define the keysizes (eg. 2048 or 4096). It's fully compatible with all plattforms (B4x, PHP, OpenSSL, etc.). The ESP's use mbdtls which is included. You can just use it by including the arduino libs.   
  
Note that the keys are strings. Therefore the length is one byte longer (zero terminated). The methods expect the length of the keys to be +1. See inline C.  
  
**Short explanation of RSA en/-decryption:**  
  
- like SSL in you browser two sides generate an public and a private key  
- the public keys are exchanged and are really public  
- you encrypt with the "foreign" public key and decryption is done with the private key of the recepient (which is kept secret)  
- vice versa the foreign side uses your public key to encrypt and you use you own private key to decrypt  
  
**Signing/Verifying**  
  
- as the public key is public, anyone could use it to send a message to you  
- here comes signing in place  
- you can sign the unencrypted message (hashed before) with you private key and get a signature which is sent with the encrypted message  
- the receiver can verify this signature after decryption with the public key of the sender  
- quite nice as you the know the message is really from the sender  
  
**How do we know that the public key is genuine ? (CA authorities) - very simple explanation**  
  
- this is done by an CA-authority  
- these are trusted companies which are accepted to sign via a certificate  
- it's like the signing above (your public key is signed and anyone can check if it's genuine)  
- they issue a certificate  
- here the \*b4x.com website's certificate issuers  
- one must be the first one to be allowed to sign/issue certificates but who signs their certificates?  
- answer: noone because you'll end in an endless loop. So the world decided to have "root" certificates -> everyone trusts in theses by definition  
- USERTrust in that case signed/issued a certificate for K Software and these guys were allowed to sign/issue a certificate for b4x.com  
- you see a chain here which is called certificate chain (simple: Are all these guys allowed to sign and is all valid?)   
  
![](https://www.b4x.com/android/forum/attachments/138898)   
  
- in an own system we trust our own keys so this is not an issue  
  
  
**Usage with other plattforms**  
  
- the keys are generated in PEM format  
- all platforms can load the ESP's public key, encrypt with it and therefore check your signature (if you use it)  
- in B4x (encryption lib) we use the raw key (remove all text like "—–BEGIN PUBLIC KEY—–"and crlf's and Base64 decode it to bytes. Then you can load it. See my other examples)  
- vice versa coming from B4x you need to Base64 encdode the key, add crlf's, header and footer to it and you're good to go.  
- generally use RSA only once for en-/decrypting  
- via RSA you exchange an AES key and go on with this (RSA is size limited to a few hundred bytes)  
- after exchange you use RSA only for signing/verifying  
  
> —–BEGIN PUBLIC KEY—–  
> MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA22gPA2eRJZjOxHGREuna  
> vvMxj5n2PeFNkUat1JVR1T3d1qS6T2kFEvPcfMwLOLEyTtPESA3lDAosii9tenBJ  
> OkYvBVto/t0X92rmmpo51MU4/DRIiXjnc4+L5ctgocXSRQW54SVb35EjQISttlVa  
> eeeYA2JJcjY7kO2UY2lW3TtRl3eQ9ASb2rAi9dsa9x7x57VTRH3uUFtsjmiQJond  
> bV25Dnk+VoT8hvRnIjentMJJMkxuUns3Uno4guy0585Azl9HrG5Qz+m1TD8h2EhR  
> niiSH7uV/NeCY+J715d8Qe93zUR1NHz0GMMpN9SbT4TG9l8jN4xMkH23i6HG7f4Y  
> lf+KhqUGBoAS/LaZbtyejNWijQjhMnywuenSpYgqMCU2ZTqvYfy2tQZJc0DHahnp  
> BpwqzdeKoLnbgqX+IfPgaEYXcbfiX6Fz4X7nOwbJFWyoGFISaC5ScZf21QTC/mkt  
> HrLxjfNhjboi9U+7lL86GqDB9GqOGjy/yPbQUSanH1cSBqyqzdWUybG9sJdDlN9p  
> Oh7RtnwXq5IEOJsuEthRXpGR2Wy8NlZy+Gqut1GdM73ACldVUL3EQrzCgG078oD5  
> y8w1wG2zy8dwzgdUOnt8FUImnb+0U1xuIhOKOqNFqKAoOise3+ggCJl0YJn1nTcq  
> wG9h8qUx6PbsWdZow/1ASosCAwEAAQ==  
> —–END PUBLIC KEY—–

  
In B4x:  
  

```B4X
Sub LoadESP32PubKey(PubKey As String)  
    'Log("Pubkey-Length: "& PubKey.Length)  
    PubKey=PubKey.Replace("—–BEGIN PUBLIC KEY—–","")  
    PubKey=PubKey.Replace("—–END PUBLIC KEY—–","")  
    PubKey=PubKey.Replace(CRLF,"")  
    ESP32PubkeyAsBytes=SU.DecodeBase64(PubKey)  
    ESP32EC.Initialize("RSA/ECB/PKCS1Padding")  
    ESP32KPG.Initialize("RSA", 2048)  
    ESP32KPG.PublicKeyFromBytes(ESP32PubkeyAsBytes)  
  
End Sub  
  
Sub PubKey2PEM (RawPubKey As String) As String  
    Dim l,co As Int  
    Dim PK As String  
    PK = "—–BEGIN PUBLIC KEY—–" & CRLF  
            
    'l=32  
    l=64  
    co=0  
       
    For i=0 To RawPubKey.Length-1  
        PK=PK & RawPubKey.CharAt(i)  
        co=co+1  
        If co=l Then  
            co=0  
            l=64  
            'Log (RSAOwnPubKeyString.Length)  
            PK=PK & CRLF  
        End If  
    Next  
    PK = PK &  CRLF & "—–END PUBLIC KEY—–"  
       
    PK=PK.Replace(CRLF&CRLF,CRLF)  
    File.WriteString(File.DirApp,"pubkey.pem",PK)  
    Return PK  
End Sub
```

  
  
Workflow:  
  
- create own keys  
- the recepient creates own keys  
- exchange keys  
- you ENcrypt with the recepients public key  
- you DEcrypt with your own private key  
  
Note: In this example I only use own keys and en-/decrypt. If you exchange data you need to load the recepients public key (not your own)