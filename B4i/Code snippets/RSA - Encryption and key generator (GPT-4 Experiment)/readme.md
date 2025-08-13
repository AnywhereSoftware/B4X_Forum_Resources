### RSA - Encryption and key generator (GPT-4 Experiment) by jtare
### 05/15/2023
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/147977/)

**Disclaimer: This post was written entirely with GPT-4 model  
Version: 0.1**  
  
  
Greetings,  
  
The absence of an RSA library in B4i, particularly for generating RSA key pairs and adjusting encryption key size, has been a personal challenge for me. Despite not being well-versed in Objective C, I was committed to discovering a viable solution.  
  
With the assistance of GPT-4, inline Objective C and native objects were utilized to interact with iOS's native cryptography functions. It was a challenging process that involved not only feeding GPT-4 with Apple's developer documentation but also providing it with relevant StackOverflow answers. Numerous iterations were required, but we eventually achieved success.  
  
Bear in mind, I'm not a cryptography expert. This solution functions, but I encourage those more knowledgeable in cryptography to review and provide feedback.  
  
Multiple encryption types have been added. The available algorithms include:  

- kSecKeyAlgorithmRSAEncryptionPKCS1
- kSecKeyAlgorithmRSAEncryptionRaw
- kSecKeyAlgorithmRSAEncryptionOAEPSHA1
- kSecKeyAlgorithmRSAEncryptionOAEPSHA256
- kSecKeyAlgorithmRSAEncryptionOAEPSHA512
- kSecKeyAlgorithmRSAEncryptionOAEPSHA1AESGCM
- kSecKeyAlgorithmRSAEncryptionOAEPSHA256AESGCM
- kSecKeyAlgorithmRSAEncryptionOAEPSHA512AESGCM

These algorithms provide a range of options to suit various needs and preferences when working with RSA encryption in B4i.  
  
Here's the inline Objective C code:  
  

```B4X
#If OBJC  
  
#import <Security/Security.h>  
#import <CommonCrypto/CommonCrypto.h>  
  
- (NSDictionary *)generateRSAKeyPairWithSize:(int)keySize {  
    NSData* tag = [@"com.example.keys.mykey" dataUsingEncoding:NSUTF8StringEncoding];  
    NSDictionary* attributes =  
        @{ (id)kSecAttrKeyType:               (id)kSecAttrKeyTypeRSA,  
           (id)kSecAttrKeySizeInBits:         @(keySize),  
           (id)kSecPrivateKeyAttrs:  
               @{ (id)kSecAttrIsPermanent:    @YES,  
                  (id)kSecAttrApplicationTag: tag,  
                  },  
         };  
           
    CFErrorRef error = NULL;  
    SecKeyRef privateKey = SecKeyCreateRandomKey((__bridge CFDictionaryRef)attributes, &error);  
    if (!privateKey) {  
        NSError *err = CFBridgingRelease(error);  // ARC takes ownership  
        // Handle the error. . .  
    }  
      
    SecKeyRef publicKey = SecKeyCopyPublicKey(privateKey);  
      
      
    NSData *publicKeyData = (__bridge_transfer NSData*)SecKeyCopyExternalRepresentation(publicKey, &error);  
    NSData *privateKeyData = (__bridge_transfer NSData*)SecKeyCopyExternalRepresentation(privateKey, &error);  
      
    if (!publicKeyData || !privateKeyData) {  
        // Handle the error  
    }  
      
    NSDictionary *result = @{@"publicKey": publicKeyData, @"privateKey": privateKeyData};  
      
    if (publicKey)  { CFRelease(publicKey);  }  
    if (privateKey) { CFRelease(privateKey); }  
      
    return result;  
}  
  
- (NSData *)encryptData:(NSData *)data withPublicKey:(NSData *)publicKeyData keySize:(int)keySize algorithmStr:(NSString *)algorithmStr {  
    CFErrorRef error = NULL;  
    SecKeyRef publicKey = SecKeyCreateWithData((__bridge CFDataRef)publicKeyData,  
                                               (__bridge CFDictionaryRef)@{(id)kSecAttrKeyType: (id)kSecAttrKeyTypeRSA,  
                                                                           (id)kSecAttrKeyClass: (id)kSecAttrKeyClassPublic,  
                                                                           (id)kSecAttrKeySizeInBits: @(keySize)}, &error);  
    SecKeyAlgorithm algorithm ;  
    if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionOAEPSHA512"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionOAEPSHA512;  
    } else if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionRaw"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionRaw;  
    } else if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionOAEPSHA256"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionOAEPSHA256;  
    } else if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionOAEPSHA1"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionOAEPSHA1;  
    } else if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionOAEPSHA512AESGCM"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionOAEPSHA512AESGCM;  
    } else if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionOAEPSHA256AESGCM"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionOAEPSHA256AESGCM;  
    } else if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionOAEPSHA1AESGCM"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionOAEPSHA1AESGCM;  
    } else {  
        // Default to kSecKeyAlgorithmRSAEncryptionPKCS1  
        algorithm  = kSecKeyAlgorithmRSAEncryptionPKCS1;  
    }  
  
    BOOL canEncrypt = SecKeyIsAlgorithmSupported(publicKey, kSecKeyOperationTypeEncrypt, algorithm);  
    canEncrypt &= ([data length] < (SecKeyGetBlockSize(publicKey) - 130));  
      
    NSData* encryptedData = nil;  
    if (canEncrypt) {  
        encryptedData = (NSData*)CFBridgingRelease(SecKeyCreateEncryptedData(publicKey, algorithm, (__bridge CFDataRef)data, &error));  
        if (!encryptedData) {  
            NSError *err = CFBridgingRelease(error);   
            // Handle the error. . .  
        }  
    }  
    return encryptedData;  
}  
  
- (NSData *)decryptData:(NSData *)data withPrivateKey:(NSData *)privateKeyData keySize:(int)keySize algorithmStr:(NSString *)algorithmStr {  
    CFErrorRef error = NULL;  
    SecKeyRef privateKey = SecKeyCreateWithData((__bridge CFDataRef)privateKeyData,  
                                                (__bridge CFDictionaryRef)@{(id)kSecAttrKeyType: (id)kSecAttrKeyTypeRSA,  
                                                                            (id)kSecAttrKeyClass: (id)kSecAttrKeyClassPrivate,  
                                                                            (id)kSecAttrKeySizeInBits: @(keySize)}, &error);  
    SecKeyAlgorithm algorithm ;  
    if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionOAEPSHA512"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionOAEPSHA512;  
    } else if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionRaw"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionRaw;  
    } else if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionOAEPSHA256"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionOAEPSHA256;  
    } else if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionOAEPSHA1"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionOAEPSHA1;  
    } else if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionOAEPSHA512AESGCM"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionOAEPSHA512AESGCM;  
    } else if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionOAEPSHA256AESGCM"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionOAEPSHA256AESGCM;  
    } else if ([algorithmStr isEqualToString:@"kSecKeyAlgorithmRSAEncryptionOAEPSHA1AESGCM"]) {  
        algorithm  = kSecKeyAlgorithmRSAEncryptionOAEPSHA1AESGCM;  
    } else {  
        // Default to kSecKeyAlgorithmRSAEncryptionPKCS1  
        algorithm  = kSecKeyAlgorithmRSAEncryptionPKCS1;  
    }  
      
      
      
    BOOL canDecrypt = SecKeyIsAlgorithmSupported(privateKey, kSecKeyOperationTypeDecrypt, algorithm);  
    canDecrypt &= ([data length] == SecKeyGetBlockSize(privateKey));  
      
    NSData* decryptedData = nil;  
    if (canDecrypt) {  
        decryptedData = (NSData*)CFBridgingRelease(SecKeyCreateDecryptedData(privateKey, algorithm, (__bridge CFDataRef)data, &error));  
        if (!decryptedData) {  
            NSError *err = CFBridgingRelease(error);   
            // Handle the error. . .  
        }  
    }  
    return decryptedData;  
}  
  
  
- (NSData *)convertToX509:(NSData *)publicKeyData keySize:(int)keySize {  
    CFErrorRef error = NULL;  
    SecKeyRef publicKey = SecKeyCreateWithData((__bridge CFDataRef)publicKeyData,  
                                               (__bridge CFDictionaryRef)@{(id)kSecAttrKeyType: (id)kSecAttrKeyTypeRSA,  
                                                                           (id)kSecAttrKeyClass: (id)kSecAttrKeyClassPublic,  
                                                                           (id)kSecAttrKeySizeInBits: @(keySize)}, &error);  
    if (!publicKey || error) {  
        return nil;  
    }  
      
    // Get the public key data  
    CFDataRef keyData = SecKeyCopyExternalRepresentation(publicKey, NULL);  
    if (!keyData) {  
        CFRelease(publicKey);  
        return nil;  
    }  
      
    // Create the ASN.1 header for an RSA public key in X.509 format  
    static uint8_t const header[] = {  
        0x30, 0x82, 0x01, 0x22, 0x30, 0x0D, 0x06, 0x09, 0x2A, 0x86, 0x48, 0x86, 0xF7, 0x0D, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0F, 0x00  
    };  
      
    // Add the header to the public key data  
    NSMutableData *result = [NSMutableData dataWithBytes:header length:sizeof(header)];  
    [result appendData:(__bridge NSData *)keyData];  
      
    CFRelease(keyData);  
    CFRelease(publicKey);  
    return result;  
}  
  
  
#End If
```

  
  
  
Then, to generate key pairs, encrypt, and decrypt text, use the following B4i code. Modifying it to encrypt and decrypt bytes should be straightforward:  
  

```B4X
Private Sub Application_Start (Nav As NavigationController)  
'…  
    Private keySize As Int = 2048  
    ' Generate RSA key pair  
    Dim keyPair As Map = GenerateRSAKeyPair(keySize)  
    Log(keyPair)  
    Dim publicKey As String = keyPair.Get("publicKey")  
    Dim privateKey As String = keyPair.Get("privateKey")  
      
    ' Encrypt data  
    Dim data As String = "Hello, World!"  
      
'    Available algorithms:  
'    kSecKeyAlgorithmRSAEncryptionPKCS1  
'    kSecKeyAlgorithmRSAEncryptionRaw  
'    kSecKeyAlgorithmRSAEncryptionOAEPSHA1  
'    kSecKeyAlgorithmRSAEncryptionOAEPSHA256  
'    kSecKeyAlgorithmRSAEncryptionOAEPSHA512  
'    kSecKeyAlgorithmRSAEncryptionOAEPSHA1AESGCM  
'    kSecKeyAlgorithmRSAEncryptionOAEPSHA256AESGCM  
'    kSecKeyAlgorithmRSAEncryptionOAEPSHA512AESGCM  
      
    Dim encryptedData As String = EncryptData(data, publicKey, keySize, "kSecKeyAlgorithmRSAEncryptionPKCS1")  
    Log("Encrypted data: " & encryptedData)  
  
    ' Decrypt data  
    Dim decryptedData As String = DecryptData(encryptedData, privateKey, keySize, "kSecKeyAlgorithmRSAEncryptionPKCS1")  
    Log("Decrypted data: " & decryptedData)  
      
    Dim x509PublicKey As String = ConvertToX509(publicKey, keySize) 'Share this key with B4j and B4A  
    Log(x509PublicKey)  
End Sub  
  
Sub GenerateRSAKeyPair(keySize As Int) As Map  
    Dim no As NativeObject = Me  
    Dim keyPair As NativeObject = no.RunMethod("generateRSAKeyPairWithSize:", Array(keySize))  
    Dim publicKey As Object = keyPair.GetField("publicKey")  
    Dim privateKey As Object = keyPair.GetField("privateKey")  
      
    ' Convert NSData to byte arrays  
    Dim publicKeyBytes() As Byte = no.NSDataToArray(publicKey)  
    Dim privateKeyBytes() As Byte = no.NSDataToArray(privateKey)  
      
'    Dim bc As ByteConverter  
    Dim su As StringUtils  
    ' Convert byte arrays to base64 strings  
    Dim publicKeyB64 As String = su.EncodeBase64(publicKeyBytes)  
    Dim privateKeyB64 As String = su.EncodeBase64(privateKeyBytes)  
      
    Dim result As Map = CreateMap("publicKey": publicKeyB64, "privateKey": privateKeyB64)  
    Return result  
End Sub  
  
  
Sub EncryptData(data As String, publicKeyBase64 As String, keySize As Int, algorithm As String) As String  
    Dim no As NativeObject = Me  
    Dim bc As ByteConverter  
    Dim su As StringUtils  
      
    ' Convert the public key from Base64 string to byte array  
    Dim publicKeyBytes() As Byte = su.DecodeBase64(publicKeyBase64)  
    ' Convert the byte array to NSData object  
    Dim publicKey As Object = no.ArrayToNSData(publicKeyBytes)  
      
    Dim dataBytes() As Byte = bc.StringToBytes(data, "UTF8")  
    Dim dataBytesNSdata As Object = no.ArrayToNSData(dataBytes)  
      
    Dim encryptedString As String = ""  
    Try  
        Dim encryptedData As Object = no.RunMethod("encryptData:withPublicKey:keySize:algorithmStr:", Array As Object(dataBytesNSdata, publicKey, keySize, algorithm))  
        encryptedString = su.EncodeBase64(no.NSDataToArray(encryptedData))  
    Catch  
        Log(LastException)  
    End Try  
    Return encryptedString  
End Sub  
  
Sub DecryptData(encryptedData As String, privateKey As String, keySize As Int, algorithm As String) As String  
    Dim no As NativeObject = Me  
    Dim bc As ByteConverter  
    Dim su As StringUtils  
      
    Dim encryptedBytes() As Byte = su.DecodeBase64(encryptedData)  
    Dim encryptedBytesNSdata As Object = no.ArrayToNSData(encryptedBytes)  
    ' Convert the private key from Base64 string to byte array  
    Dim privateKeyBytes() As Byte = su.DecodeBase64(privateKey)  
    ' Convert the byte array to NSData object  
    Dim privateKeyData As Object = no.ArrayToNSData(privateKeyBytes)  
      
    Dim decryptedString As String = ""  
    Try  
        Dim decryptedData As Object = no.RunMethod("decryptData:withPrivateKey:keySize:algorithmStr:", Array(encryptedBytesNSdata, privateKeyData, keySize, algorithm))  
        Dim decryptedBytes() As Byte = no.NSDataToArray(decryptedData)  
        decryptedString = bc.StringFromBytes(decryptedBytes, "UTF8")  
    Catch  
        Log(LastException)  
    End Try  
      
    Return decryptedString  
End Sub  
  
  
  
Sub ConvertToX509(publicKey As String, keySize As Int) As String  
    Dim no As NativeObject = Me  
    Dim su As StringUtils  
    Dim privateKeyBytes() As Byte = su.DecodeBase64(publicKey)  
    Dim data As Object = no.ArrayToNSData(privateKeyBytes)  
    Dim result As Object = no.RunMethod("convertToX509:keySize:", Array(data, keySize))  
    Dim publicKeyBytes() As Byte = no.NSDataToArray(result)  
    Dim publicKeyB64 As String = su.EncodeBase64(publicKeyBytes)  
    Return publicKeyB64  
End Sub
```

  
  
It's also important to highlight: my familiarity with key formats is somewhat limited. Apple's public key isn't in X509 and needs conversion by adding a specific header to the key. I've included a function to handle this, and the converted key should be accepted in B4j and B4A. If anyone can provide more insight on this matter, it would be greatly appreciated.  
  
Looking forward to your feedback and implementations!  
  
Happy coding!