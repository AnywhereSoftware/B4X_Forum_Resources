### Share encrypted data with B4A by Erel
### 09/20/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/35482/)

**For new projects it is recommended to use [B4XEncryption](https://www.b4x.com/android/forum/threads/jb4xencryption.48178/#content) to create a cross platform solution.**  
  
RandomAccessFile library v1.10 includes the beloved ReadEncrypredObject / WriteEncryptedObject methods.  
  
These two methods are similar to ReadObject and WriteObject methods which are very powerful and useful and they allow you to easily write complex objects in a single line of code.  
  
ReadEncryptedObject and WriteEncryptedObject methods also encrypt the data. The B4A tutorial is available here: [Encrypting information with RandomAccessFile library](http://www.b4x.com/android/forum/threads/11565/#content)  
  
The encryption method used is the same in B4J and B4A so you can easily exchange secured data between your mobile app and desktop app.  
  
The algorithm name is: PBEWITHSHAAND256BITAES-CBC-BC  
  
Note that you can also write custom types and collections of custom types. The saved types can also be shared between B4J and B4A.  
  
These two methods depend on an encryption library named [Bouncy Castle](http://www.bouncycastle.org). Android includes this library as part of the OS.  
In B4J you need to download the jar file: <https://www.bouncycastle.org/download/bcprov-jdk15on-154.jar> and copy it to the additional libraries folder.  
  
**In your code you should add the following module attribute:  
#AdditionalJar: bcprov-jdk15on-154**