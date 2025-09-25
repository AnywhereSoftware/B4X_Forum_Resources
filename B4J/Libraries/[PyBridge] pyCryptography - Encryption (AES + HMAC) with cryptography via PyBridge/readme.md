### [PyBridge] pyCryptography - Encryption (AES + HMAC) with cryptography via PyBridge by zed
### 09/20/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168722/)

This library offers a simple, secure, and powerful solution for encrypting and decrypting sensitive data (emails, addresses, phone numbers, etc.)  
directly from a B4J application, leveraging the robustness of the Python cryptography library.  
  
The Lib exposes three main methods:  
 GetKey: Generates a secure Fernet key (AES 128 + HMAC)  
 Encrypt: Encrypts a text string with this key  
 Decrypt: Decrypts a previously encrypted string  
  
  
Python-side installation  
 pip install cryptography  
  
Example of use:  

```B4X
Dim EncryptString As String = "user@example.com"  
Crypto.Initialize  
  
' Key generation  
Wait For (Crypto.GetKey) Complete (newkey As String)  
Key = newkey  
Log("key = " & Key)  
  
' Encryption  
Wait For (Crypto.Encrypt(EncryptString, Key)) Complete (EncryptedData As String)  
Log("Encrypted : " & EncryptedData)  
  
' Decryption  
Wait For (Crypto.Decrypt(EncryptedData, Key)) Complete (value As String)  
Log("Decrypted : " & value)
```

  
  
Benefits:  
 Strong security thanks to Fernet (AES + HMAC)  
 Easy integration into any B4J app  
 No complex Java dependencies: everything is managed via Python  
 Reversibility: Data can be decrypted at any time  
 Modularity: Can be combined with KeyValueStore or an SQLite database  
  
Ideal for:  
 Securely storing sensitive data in databases  
 Protecting personal information in files or logs  
 Creating custom encryption systems in B4X apps