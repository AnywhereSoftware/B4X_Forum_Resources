### AES Encrypt/Decrypt (Encryption/Decryption) B4A and B4J library by Peter Simpson
### 09/22/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/107486/)

**This library works with both B4A and B4J.**  
*Yes yes yes there are other ways to do this, this is how I do it. I have lots of small libraries that I use for myself, so I thought that I would share this one with the community.*  
  
Hello fellow B4X'ers,  
I've decided to release this simple to use AES library, I created it some time ago for AES Encryption and Decryption of strings. I've been using this library in multiple B4X projects for quite some time now and I've never come across any issues with it. I decided to removed some methods that you don't need, so here it is.  
  
**How to use this library:**  
Just download the attached zip file and unzip the 2 files into your additional libraries folder.  

```B4X
Sub Process_Globals  
    '**************************************************************************************  
    '* THIS IS AVAILABLE FOR B4A, B4J, VB.NET AND C# UNDER THE SAME LIBRARY AND DLL NAMES *  
    '**************************************************************************************  
  
    Private EncDec As AESEncryption  
End Sub  
  
Sub AppStart (Args() As String)  
    EncDec.InitializationVector = "Q.6qYq0_C+mGmymX" 'Must be 16 characters in length  
    EncDec.SecretKey = "3hba8fOumOPrMG0.G?-mkF-scGOkPwyW" 'Must be 16 or 32 characters in length  
  
    Dim EncryptDecryptString As String = "Peter"  
    Log($"Encrypted = ${EncDec.AESEncrypt(EncryptDecryptString)}"$)  
    Log($"Decrypted = ${EncDec.AESDecrypt(EncDec.AESEncrypt(EncryptDecryptString))}"$)  
    StartMessageLoop  
End Sub
```

  
  
[SPOILER="Logs results…"]  
Picked up \_JAVA\_OPTIONS: -Xmx1024m -Xms1024m -XX:-UseGCOverheadLimit  
Waiting for debugger to connect…  
Program started.  
Encrypted = DB35530CCAD0E190E8DAF728DF4D4F8D  
Decrypted = Peter  
[/SPOILER]  
  
**Released:** 09/07/2019: 1.00  
  
**SS\_AESEncryption  
  
Author:** Peter Simpson  
**Version:** 1  

- **AESEncryption**

- **Fields:**

- **InitializationVector** As String
- **SecretKey** As String

- **Functions:**

- **AESDecrypt** (DecryptData As String) As String
*Decrypt AES encoded data to plain string*- **AESEncrypt** (EncryptData As String) As String
*Encrypt plain string to AES encoded data*- **Initialize** As String
*Use Initialize for B4A, Initialize is NOT necessary for B4J*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
  
I use this library to encrypt data into and decrypt data out of my clients MySQL or MSSQL databases. For many years I've been developing bespoke Windows business software for clients using VB.Net and C#, I've always encrypted important data using AES encryption, after all some encryption is better than no encryption.  
  
**Enjoy…**