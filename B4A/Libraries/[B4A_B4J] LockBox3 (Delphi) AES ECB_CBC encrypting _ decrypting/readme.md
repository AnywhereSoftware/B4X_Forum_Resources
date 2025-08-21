### [B4A/B4J] LockBox3 (Delphi) AES ECB/CBC encrypting / decrypting by OliverA
### 08/26/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/97962/)

This class can be used decrypt data created with LockBox3 and encrypt data that will be properly handled by LockBox3. LockBox3 is an encryption/decryption library for Delphi.  
  
There are actually three classes, LB3AES, LB3AESECB and LB3AESCBC. The only class that is used to instantiate an object is LB3AES. There are only 3 methods:  
1) Initialize(keySize As Int, password As String, mode As String)  
keySize is one of 128, 192, or 256.  
password is the password to be used for encrypting/decrypting.  
mode is the block chain mode used. Currently supports "ECB" and "CBC"  
2) DecryptString(cipherText As String) As String  
This method will decrypt a given cipher text produced by ToolBox3  
3) EncryptString(plainText As String) As String  
This method will encrypt a given plain text that will be understood by ToolBox3  
  
Please note: Both ToolBox3 and this class will have to use the same keySize, password, and mode for a given ciphertext/plaintext to be properly handled. Delphi must use UTF8 for all encodings (password and text to be encrypted/decrypted).  
  
For a write up on how I derived at this implementation, see <https://www.b4x.com/android/forum/threads/lockbox3-delphi-aes-encryption-exchange-with-b4a-b4j.97959/>.  
  
2019/08/26: CBC Mode update:  
[INDENT]The CBC mode encryption/decryption did not work properly for plaintext/ciphertext messages that were longer than 16 bytes and whose length were not evenly divisible by 16. I'll update my write up for the solution to this issue.[/INDENT]  
  
[INDENT]As to the #MergedLibraries option, it looks like any JDK's based on OpenJDK (be it version 8 or 11) do not seem to have an issue with this option being set to True. The only JDK that seems to have issues with this is Oracle's implementation. See <https://www.b4x.com/android/forum/threads/cannot-merge-external-library.109003>[/INDENT]  
  
2018/10/25: B4J Specific update:  
[INDENT]If you want greater than 128bit encryption:  
[INDENT]For JRE/JDK before 1.8.0\_151, see <https://stackoverflow.com/a/6481658>  
For JRE/JDK starting with 1.8.0\_151 and 9, see <https://www.petefreitag.com/item/844.cfm>  
For JRE/JDK after 9, you should be good to go.[/INDENT]  
Please note that this does depend on your region not being restricted from using strong cryptography.  
  
The Bouncy Castle .jar file that is required (as of this writing bcprov-jdk15on-160.jar, located here <https://www.bouncycastle.org/latest_releases.html>) is signed. In order for this library to work in Release mode (as it pertains to using these classes), the #MergeLibraries option must be set to False (see <https://www.b4x.com/android/forum/threads/sshj-ssh-scp-sftp-for-java.88615/page-3#post-589290>). This will have an implication on your application for distribution, since one needs to now include any library .jar files with the application. OpenJDK (at least version 11.0.1) does not seem to care how that option is set.  
  
The only change done to the previous upload is to set #MergeLibraries to False in the B4J project  
  
Thanks to [USER=110208]@Diceman[/USER] for bringing these issues to light.[/INDENT]