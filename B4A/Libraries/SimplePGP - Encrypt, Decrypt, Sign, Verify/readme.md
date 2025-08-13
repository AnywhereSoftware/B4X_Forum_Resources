### SimplePGP - Encrypt, Decrypt, Sign, Verify by DonManfred
### 09/25/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/89521/)

This is a wrap around this [Github-project](https://github.com/sniggle/simple-pgp).  
It wraps the Android Part of it using some additional jars from bouncycastle and spongycastle for the Encryption Provider  
  
A B4J Version is [available here](https://www.b4x.com/android/forum/threads/simplepgp-encrypt-decrypt-sign-verify.89523/).  
  
I just did it out of curiosity :)  
Based on the Size of the Additional jars you need to download them [[SIZE=6]here[/SIZE]](https://www.dropbox.com/s/ifh1mhwvg1tqjnr/SimplePGP.7z?dl=1).  
  
**SimplePGP  
Author: DonManfred (wrapper)  
Version:** 1.0  

- **PGPKeyPairGenerator**

- **Functions:**

- **generateKeyPair** (userId As String, password As String, publicKey As java.io\_OutputStream, secrectKey As java.io\_OutputStream) As Boolean
- **generateKeyPair2** (userId As String, password As String, keySize As Int, publicKey As java.io\_OutputStream, secrectKey As java.io\_OutputStream) As Boolean
 *userId: the user id for the PGP key pair  
 password: the password used to secure the secret (private) key  
 keySize: the custom key size  
 publicKey: the target stream for the public key  
 secrectKey: the target stream for the secret (private) key  
 Return type: @return:*- **Initialize** (EventName As String)

- **PGPMessageEncryptor**

- **Functions:**

- **decrypt** (passwordOfReceiversPrivateKey As String, privateKeyOfReceiver As java.io.InputStream, encryptedData As java.io.InputStream, target As java.io\_OutputStream) As Boolean
- **decrypt2** (passwordOfReceiversPrivateKey As String, privateKeyOfReceiver As java.io.InputStream, publicKeyOfSender As java.io.InputStream, encryptedData As java.io.InputStream, target As java.io\_OutputStream) As Boolean
- **encrypt** (publicKeyOfRecipient As java.io.InputStream, inputDataName As String, plainInputData As java.io.InputStream, target As java.io\_OutputStream) As Boolean
- **encrypt2** (publicKeyOfRecipient As java.io.InputStream, privateKeyOfSender As java.io.InputStream, userIdOfSender As String, passwordOfSendersPrivateKey As String, plainInputData As java.io.InputStream, inputDataName As String, target As java.io\_OutputStream) As Boolean
- **init** (arg0 As Boolean, params As org.spongycastle.crypto.CipherParameters)
- **Initialize** (EventName As String)
- **messageDecrypt** (arg0 As Byte()) As Byte()
- **messageEncrypt** (arg0 As Byte()) As Byte()

- **PGPMessageSigner**

- **Functions:**

- **Initialize** (EventName As String)
- **signMessage** (privateKeyOfSender As java.io.InputStream, userIdForPrivateKey As String, passwordOfPrivateKey As String, message As java.io.InputStream, signature As java.io\_OutputStream) As Boolean
- **verifyMessage** (publicKeyOfSender As java.io.InputStream, message As java.io.InputStream, signatureStream As java.io.InputStream) As Boolean

- **Properties:**

- **CompressionAlgorithm** As Int [write only]
- **UnlimitedEncryptionStrength** As Boolean [write only]

  
  
Please note the #AdditionalJar lines…  
  

```B4X
#AdditionalJar: bcpkix-jdk15on-1.58.0.0  
#AdditionalJar: bcprov-jdk15on-1.59  
#AdditionalJar: bctls-jdk15on-1.58.0.0  
#AdditionalJar: pg-1.54.0.0  
#AdditionalJar: sc-core-1.58.0.0  
#AdditionalJar: sc-prov-1.58.0.0  
#AdditionalJar: slf4j-api-1.7.25  
  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Dim pgpkeys As PGPKeyPairGenerator  
    Dim signer As PGPMessageSigner  
    Dim crypt As PGPMessageEncryptor  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
    Dim publicKey As OutputStream  
    publicKey = File.OpenOutput(File.DirRootExternal,"PublicKey.pem",False)  
   
    Dim secretKey As OutputStream  
    secretKey = File.OpenOutput(File.DirRootExternal,"SecretKey.pem",False)  
  
    pgpkeys.Initialize("")  
    Log(pgpkeys.generateKeyPair("userID","mysecretpassword",publicKey, secretKey))  
    'signer.  
    'crypt.encrypt(publickeyofreceipient, "Test",plaininputdata, destfile)  
End Sub
```