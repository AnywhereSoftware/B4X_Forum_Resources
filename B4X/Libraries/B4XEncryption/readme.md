###  B4XEncryption by Erel
### 09/10/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/48177/)

This library allows you to encrypt or decrypt data using the AES encryption method.  
  
To prevent confusion, B4XEncryptino is not a b4xlib and is made of three platform specific libraries:  
B4XEncryption - B4A  
jB4XEncryption - B4J  
iEncryption - B4i (Encrypt and Decrypt methods)  
  
It is simple to use and is cross platform, which means that you can encrypt the data on one platform and decrypt it on a different platform.  
  
Usage example:  

```B4X
Sub EncryptText(text As String, password As String) As Byte()  
   Dim c As B4XCipher  
   Return c.Encrypt(text.GetBytes("utf8"), password)  
End Sub  
  
Sub DecryptText(EncryptedData() As Byte, password As String) As String  
   Dim c As B4XCipher  
   Dim b() As Byte = c.Decrypt(EncryptedData, password)  
   Return BytesToString(b, 0, b.Length, "utf8")  
End Sub  
  
Dim encryptedData() As Byte = EncryptText("confidential", "123456")  
Log(DecryptText(encryptedData, "123456"))
```

  
  
B4XPages example project is attached.