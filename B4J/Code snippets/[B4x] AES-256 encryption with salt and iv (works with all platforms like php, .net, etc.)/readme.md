### [B4x] AES-256 encryption with salt and iv (works with all platforms like php, .net, etc.) by KMatle
### 02/19/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/127811/)

This example is based on agrahams encryption library: [Encryption Lib](https://www.b4x.com/android/forum/threads/base64-and-encryption-library.6839/)  
  
1. Generate a 32 byte pw (just call the sub) and store it  
2. Encrypt the data by calling AES\_Encrypt. Return is a byte array or a base64 encoded string  
3. Salt is a random value which is added at the beginning of the encrypted string. It is a good practice to add some random bytes to a message. A hacker doesn't know how long this "salt" is. Could be 16 or 16K of bytes.   
4. IV is public and random, too and is used to scramble the order of the blocks (AES is a block cypher method). With this method you always get different byte orders with the same message (which is good as in encryption one does not want repetitive data sequences at it is seen a problematic). Like the Emigma device which was hacked in WW2 because almost all messages started with a standard weather report using the same sentences/words.  
5. Use RSA to exchange the key/pw (so you can exchange it like SSL does).  
  
  
  

```B4X
Public Sub AES_Encrypt(data() As Byte, passB() As Byte, ReturnB64String As Boolean) As Object  
      
    Dim SaltB() As Byte = GenerateSalt(32)  
    Dim IVb() As Byte = GenerateIV  
      
    Dim kg As KeyGenerator  
    Dim C As Cipher  
   
    kg.Initialize("AES")  
    kg.KeyFromBytes(passB)  
   
    C.Initialize("AES/CBC/PKCS5Padding")  
    C.InitialisationVector = IVb  
   
    Dim datas() As Byte = C.Encrypt(data, kg.Key, True)  
    Dim SaltIVMessage(SaltB.Length + datas.Length + IVb.Length) As Byte = AddSaltIVMessage(SaltB,IVb,datas)  
      
    If ReturnB64String Then  
        Return SU.EncodeBase64(SaltIVMessage)  
    Else  
        Return SaltIVMessage  
    End If     
End Sub  
  
'Input is a Base664 encoded string or a byte array, output a string or byte array  
'Salt (32) and IV(16) is added at the beginning  
Public Sub AES_Decrypt(data() As Byte,  passb() As Byte, ReturnString As Boolean) As Object  
  
      
    Dim m As Map = SplitSaltIVMessage(data)  
      
    Dim IVb() As Byte = m.Get("iv")  
    Dim MessageB() As Byte = m.Get("message")  
      
    Dim kg As KeyGenerator  
    Dim C As Cipher  
   
    kg.Initialize("AES")  
    kg.KeyFromBytes(passb)  
   
    C.Initialize("AES/CBC/PKCS5Padding")  
    C.InitialisationVector = IVb  
   
    Dim datas() As Byte = C.Decrypt(MessageB, kg.Key, True)  
   
     If ReturnString Then  
        Return BytesToString(datas, 0, datas.Length, "UTF8")  
    Else  
        Return datas  
    End If  
End Sub  
  
Public Sub GetMessageSaltIVFromEncryptedMessage(EncryptedMessageAsBytes() As Byte) As Map  
    Dim m As Map = SplitSaltIVMessage(EncryptedMessageAsBytes)  
      
    Return m  
End Sub  
  
Private Sub AddSaltIVMessage (Salt() As Byte,IV() As Byte, Message () As Byte) As Byte()  
      
    Dim SaltIVMessageBytes (Salt.Length+ IV.Length + Message.Length) As Byte  
    BC.ArrayCopy(Salt,0,SaltIVMessageBytes,0,32)  
    BC.ArrayCopy(IV,0,SaltIVMessageBytes,32,16)  
    BC.ArrayCopy(Message,0,SaltIVMessageBytes,48,Message.Length)  
      
    Return SaltIVMessageBytes  
End Sub  
  
Private Sub SplitSaltIVMessage (SaltIvMessage () As Byte) As Map  
      
    Dim Salt(32),IV (16), Message(SaltIvMessage.length-48) As Byte  
      
    BC.ArrayCopy(SaltIvMessage,0,Salt,0,32)  
    BC.ArrayCopy(SaltIvMessage,32,IV,0,16)  
    BC.ArrayCopy(SaltIvMessage,48,Message,0,Message.Length)  
      
    Dim m As Map=CreateMap("salt":Salt,"iv":IV,"message":Message)  
          
    Return m  
End Sub  
  
Private Sub GenerateSalt (l As Int) As Byte()  
    Dim SaltB(l) As Byte  
    For i=0 To l-1  
        SaltB(i)=Rnd(0,256)-127  
    Next  
    Return SaltB  
End Sub  
  
Public Sub GeneratePW32Bytes As Byte()  
    Dim pw(32) As Byte  
    For i=0 To 31  
        pw(i)=Rnd(0,256)-127  
    Next  
    Return pw  
End Sub  
  
Private Sub GenerateIV As Byte()  
      
    Dim IVB(16) As Byte  
    For i=0 To 15  
        IVB(i)=Rnd(0,256)-127  
    Next  
      
    Return IVB  
          
End Sub
```

  
  
PHP-Example:  
  

```B4X
function aes_encrypt($string, $pw)  
    {  
    $output = false;  
    $pw=hash('sha256',$pw,true);  
    $encrypt_method = "AES-256-CBC";  
    $IV=openssl_random_pseudo_bytes(16, $securityok);  
    $Salt=openssl_random_pseudo_bytes(32, $securityok);  
    $output = openssl_encrypt($string, $encrypt_method, $pw, 0,$IV);  
    $output=Base64_encode($Salt.$IV.Base64_decode($output));  
    //$output is base64 encoded automatically!  
    return $output;  
    }     
function aes_decrypt($string, $pw)  
    {  
    $pw=hash('sha256',$pw,true);  
    $output = false;  
    $encrypt_method = "AES-256-CBC";  
    $total=base64_decode($string);  
    $salt=substr($total, 0, 32);  
    $iv=substr($total, 32, 16);  
    $string=Base64_Encode(substr($total, 48, strlen($total)-48));  
    $output = openssl_decrypt($string, $encrypt_method, $pw, 0,$iv);  
    //$string must be base64 encoded!  
    return $output;  
    }
```