### AES Encryption Example - Encrypt Plain Text and or files by Nokia
### 08/17/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168269/)

With this example, you can encrypt and decrypt plain text and files. The following options are available:  

- Text encoding options: Hex or Base64
- Selectable key sizes: AES-128, AES-192, or AES-256
- Option to embed a salt into the encrypted text and extract it for decryption
- Option to embed a salt or ID into an encrypted file and extract it before decryption
- File encryption using either chunked mode or non-chunked (in-memory) mode

Two libraries are required to run these examples: **JavaObject** and **jRandomAccessFile**.  
  
This solution uses the built-in cryptography features provided by Java.