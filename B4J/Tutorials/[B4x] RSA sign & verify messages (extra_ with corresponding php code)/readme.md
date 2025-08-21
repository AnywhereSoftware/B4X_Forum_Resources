### [B4x] RSA sign & verify messages (extra: with corresponding php code) by KMatle
### 09/08/2019
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/109391/)

This little tutorial is about signing and verifying data you send/receive between apps (= all "programs", even websites). You can use it in B4A without a change (I don't know how B4i works, but I assume there are similar libs).  
  
You should know how RSA works. If not, take a Google search and you will find tons of documentation and of course in this forum (examples, explanations, etc.).  
  
What is signing/verifying good for?  
  
When you exchange data between two instances - let's say an app and a server - you encrypt it. In RSA you encrypt with the public key (it is really public) and decrypt with the private key (kept very secret). With this only the owner of the private one can decrypt it. Nice one.  
  
Problem here is that anyone who has the PubKey can encrypt and send it. So how do you know who it was? Yes, you can force the sender to add some data like an api-key oder user & pw but there is always a safer way.   
  
Hint: Encryption has nothing to do with signing/verifying. I did not know that first which confused me at the beginning.  
  
As the public and private key depend on each other, you can use this keys to sign/verify a message which is sent (see the www to find out how this works).  
  
  
Workflow  
  
The sender signs the message he sends with his private key. With this he creates a "hash" value (the signature) which the can be verifyed by the receiver using the SENDER's public key. With this you can guarantee two things:  
  
1. The message comes from the owner of the private key (= exact ONE sender)  
2. The message hasn't be changed on it's way (only the owner of the private key can generate the "hash")  
  
As #1 says, you can only be sure that the message is from ONE unique sender (because the private key is unique), you need a central authority which this sender identifies hisself and leaves some information for the public. You know that from safe websites (click on the lock next to the URL of B4x). Here a central authority holds a SSL cerificate which contains the public key and signature(s).  
  
When you receive the message (remember: you know his public key) you can use RSA methods to check the message against the signature. Vice versa if you send a message back, you sign it with your private key and the receiver can check if it was from you.   
  
  
The example uses 3 KeyPairGenerators:  
  
1st: Your "own" public and private keys  
2nd: The "server" one just to simulate the other keys (of course it is done on the server's side)  
3rd: ONE helper KPGs (here I load the keys from each side: Own or Server to sign/verify)  
  
Hint #2:  
  
When you sign the data, sign the RAW and UNENCRYPTED data as any good encryption method never creates the same data when you encrypt data more than one time. AFTER the signing encrypt everything (not before!). Same with verifying: FIRST decrypt the data THEN verify it.   
  
  
Used libs: Encryption and ByteConverter  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
#End Region  
  
Sub Process_Globals  
    
    Public BC As ByteConverter  
      
    'RSA  
    Public RSAServerPubKeyString As String  
    Public RSAServerPubKeyBytes(0) As Byte  
    Public RSAServerPrivKeyBytes(0) As Byte  
    Public RSAServerPrivKeyString As String  
          
    Public RSAOwnPubKeyString As String  
    Public RSAOwnPubKeyBytes(0) As Byte  
    Public RSAOwnPrivKeyBytes(0) As Byte  
    Public RSAOwnPrivKeyString, RSAOwnPrivKey, RSAOwnPubKey64StringExport As String  
      
    Public RSAServerKPG As KeyPairGenerator  
    Public RSAOwnKPG As KeyPairGenerator  
    Public RSASignatureKPG As KeyPairGenerator  
      
    Public RSAOwnC, RSAServerC As Cipher  
      
    Private const RSAKeySize As Int = 4096  
End Sub  
  
Sub AppStart (Args() As String)  
      
    CreateRSAKeys  
      
    'First we sign our OWN message with our OWN private key  
    Log("Signing OWN message…")  
    Dim mess As String = "This is the message we want to sign and verify…"  
    Dim SignatureAsBytes() As Byte=SignMessage(mess.GetBytes("UTF8"),RSAOwnPrivKeyBytes)  
    Log ("OWN signature for '" & mess & "' is: " &BC.HexFromBytes(SignatureAsBytes))  
      
    'Now we verify if the signature for the message is ok.  
    ' This is be done with the public key. So everyone who has the public key can do this (which is meant to be so)  
    Log("Verifying OWN message…")  
    CheckSignature(mess.GetBytes("UTF8"),SignatureAsBytes,RSAOwnPubKeyBytes)  
      
      
    'Then the receiver (let's say "the server") of our message sends a reply which he has signed with his own private key  
    Log("Signing server message…")  
    Dim mess As String = "This is the reply of e.g. the server…"  
    Dim SignatureAsBytes() As Byte=SignMessage(mess.GetBytes("UTF8"),RSAServerPrivKeyBytes)  
    Log ("Server signature for '" & mess & "' is: " &BC.HexFromBytes(SignatureAsBytes))  
      
    'Now we verify if the signature for the message is ok.  
    ' This is be done with the public key. So everyone who has the public key can do this (which is meant to be so)  
    Log("Verifying SERVER message…")  
    CheckSignature(mess.GetBytes("UTF8"),SignatureAsBytes,RSAServerPubKeyBytes)  
      
      
      
      
End Sub  
  
Sub SignMessage (MessB() As Byte, PrivateKey() As Byte) As Byte()  
    Dim Sign As Signature  
    RSASignatureKPG.PrivateKeyFromBytes(PrivateKey)  
    Sign.Initialise("SHA256withRSA",Sign.SIGNATURE_SIGN,RSASignatureKPG.PrivateKey)  
    Sign.Update(MessB)  
    Return Sign.Sign  
End Sub  
  
Sub CheckSignature (MessB() As Byte, SigB() As Byte, PublicKey() As Byte) As Boolean  
    Dim SignVerify As Signature  
    Dim SignatureIsOK As Boolean  
    RSASignatureKPG.PublicKeyFromBytes(PublicKey)  
    SignVerify.Initialise("SHA256withRSA",SignVerify.SIGNATURE_VERIFY,RSASignatureKPG.PublicKey)  
    SignVerify.Update(MessB)  
    SignatureIsOK=SignVerify.Verify(SigB)  
    If SignatureIsOK Then  
        Log("Signature is OK")  
    Else  
        Log("Wrong Signature")  
    End If  
    Return SignatureIsOK  
End Sub  
  
Sub CreateRSAKeys  
      
    Log("Generating RSA keys. Please be patient as this takes some time…")  
      
    'Generate "own" keys  
    RSAOwnC.Initialize("RSA/ECB/PKCS1Padding")  
    RSAOwnKPG.Initialize("RSA", RSAKeySize)  
    RSAOwnKPG.GenerateKey  
    RSAOwnPrivKeyBytes=RSAOwnKPG.PrivateKeyToBytes  
    RSAOwnPubKeyBytes=RSAOwnKPG.PublicKeyToBytes  
      
    'Generate the keys the other partitiant uses  
    RSAServerC.Initialize("RSA/ECB/PKCS1Padding")  
    RSAServerKPG.Initialize("RSA", RSAKeySize)  
    RSAServerKPG.GenerateKey  
    RSAServerPrivKeyBytes=RSAOwnKPG.PrivateKeyToBytes  
    RSAServerPubKeyBytes=RSAOwnKPG.PublicKeyToBytes  
      
    RSASignatureKPG.Initialize("RSA", RSAKeySize)  
      
    Log("RSA keys generated…")  
      
End Sub  
  
'Return true to allow the default exceptions handler to handle the uncaught exception.  
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean  
    Return True  
End Sub
```

  
  
  
PHP Code:  
  
See here:  
  
<https://www.php.net/manual/de/function.openssl-sign.php>  
  
Important: Use the algorythms below to match the B4x code and see what the methods need (raw data or like pem string).  
  
Note: I only added the two calls for php as the usage needs a lot more like converting/creating/storing keys. See my examples here in the forum.  
  

```B4X
$signature=RAW_Signature;  
        $result = openssl_verify($clientpubkeyB64, $RAWsignature, $clientpubkeyASPEMFORMAT, OPENSSL_ALGO_SHA256);  
          
        openssl_sign($data, $signature, file_get_contents('inc/PrivateKey.pem'), "sha256WithRSAEncryption");
```