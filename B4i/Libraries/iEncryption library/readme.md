### iEncryption library by Erel
### 02/07/2021
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/46991/)

This library supports:  
- Generating cryptographically secure random values.  
- Hash calculations (message digest)  
- Encryption and decryption  
  
Cipher.Encrypt / Decrypt are simple methods that you should use to securely encrypt or decrypt data unless you need to work with other systems. Encrypt2 and Decrypt2 together with GenerateKey give you more options.  
  
Encrypt / Decrypt methods are compatible with B4A and B4J B4XEncryption methods: <https://www.b4x.com/android/forum/threads/b4xencryption.48177/#content>  
  
**Note that if your device has a 64 bit CPU (like most devices) then you need to compile your app in 64 bit mode for this library to work properly: Tools - Builder Server - Server Settings.**  
In release mode both 64 bit and 32 bit binaries are always included.