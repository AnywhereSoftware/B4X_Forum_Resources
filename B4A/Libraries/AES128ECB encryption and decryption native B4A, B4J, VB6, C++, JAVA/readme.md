### AES128ECB encryption and decryption native B4A, B4J, VB6, C++, JAVA by yancedywiler
### 12/15/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/125597/)

Hello! EREL I am attaching modules developed in various IDEs from: Advanced Encryption Standard (AES128ECB) native  
so that the community uses them and can be implemented communications by Winsock and Websocket. Lately Google is not allowing apps that do not have encrypted communication to update in the Google Play Store "APK TRANSMIT USER DATA UNSECURELY  
  
Your app must handle user data securely, including transmitting it using modern cryptography (for example, over HTTPS). "  
  
Library can be compiled for easy use in B4X,  
in aes128 the key is 16bytes and it could not be higher or lower, and the key must be the same to encrypt and decipher  
Example KeyPlano "0123456789ABCEF"  
  
AESEncryptionB4A ———-IDE B4A  
AESEncryptionB4J ———–IDE B4J  
AES Encryption C++———IDE Visual Studio 2019  
AESEncryptionVB6———–IDE Visual Basic 6.0  
AESEncryptionJAVA———-IDE Apache NetBeans IDE 12.1  
eclipse-workspace———–IDE Eclipse IDE for Java Developers - 2020-09  
  
Result of LogS B4A, B4J, VB6, JAVA, C ++.  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
Prueba 1:  
Encrypted menssage :  
EL MENSAJE PLANO ES :This is a message we will encrypt with AES!  
EL CLAVE ES : 0123456789ABCDEF  
  
Encrypted menssage :  
ž\_z°©oé'¢±ŠÆ¶ž6áç5%ã½ž¥$>Pv`Ó•ÖÖì!0º\*õo`  
  
Dencrypted menssage :  
This is a message we will encrypt with AES!  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
  
  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
Prueba 2:  
EL MENSAJE PLANO ES :This is a message we will encrypt with AES! \*  
EL CLAVE ES : 1 2 3 4 5 6 7 8 9 A B C D E F 10  
  
Encrypted menssage :  
B6 4B 27 BB 16 15 A6 F5 32 18 6C C5 FA 94 B5 5E  
5C 54 EA 1B DF 97 1E 3D E3 1B FC 2 75 22 76 52  
C6 96 E5 8B 36 86 BA 73 54 2F FC AE 6F B5 23 54  
  
Dencrypted menssage :  
This is a message we will encrypt with AES! \*  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
  
On this page you can validate the AES128ECB  
<http://aes.online-domain-tools.com/>  
  
Input text : This is a message we will encrypt with AES! \*  
Function: AES  
Mode: ECB(electonic codebook)  
Key Hex: 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10  
  
Encrypted text:   
  
[TABLE]  
[TR]  
[TD][TABLE]  
[TR]  
[TD]b6[/TD]  
[TD]4b[/TD]  
[TD]27[/TD]  
[TD]bb[/TD]  
[TD]16[/TD]  
[TD]15[/TD]  
[TD]a6[/TD]  
[TD]f5[/TD]  
[TD]32[/TD]  
[TD]18[/TD]  
[TD]6c[/TD]  
[TD]c5[/TD]  
[TD]fa[/TD]  
[TD]94[/TD]  
[TD]b5[/TD]  
[TD]5e[/TD]  
[/TR]  
[TR]  
[TD]5c[/TD]  
[TD]54[/TD]  
[TD]ea[/TD]  
[TD]1b[/TD]  
[TD]df[/TD]  
[TD]97[/TD]  
[TD]1e[/TD]  
[TD]3d[/TD]  
[TD]e3[/TD]  
[TD]1b[/TD]  
[TD]fc[/TD]  
[TD]02[/TD]  
[TD]75[/TD]  
[TD]22[/TD]  
[TD]76[/TD]  
[TD]52[/TD]  
[/TR]  
[TR]  
[TD]c6[/TD]  
[TD]96[/TD]  
[TD]e5[/TD]  
[TD]8b[/TD]  
[TD]36[/TD]  
[TD]86[/TD]  
[TD]ba[/TD]  
[TD]73[/TD]  
[TD]54[/TD]  
[TD]2f[/TD]  
[TD]fc[/TD]  
[TD]ae[/TD]  
[TD]6f[/TD]  
[TD]b5[/TD]  
[TD]23[/TD]  
[TD]54[/TD]  
[/TR]  
[/TABLE][/TD]  
[/TR]  
[/TABLE]  
  
<http://aes.online-domain-tools.com/>  
![](https://www.b4x.com/android/forum/attachments/104444)  
  
  
Download link drive google  
  
<https://drive.google.com/drive/folders/1hOVRRFhxnsGKDNF7mtzP7okFl3kDzS82>  
  
AESEncryptionB4A   
AESEncryptionB4J   
AES Encryption C ++   
AESEncryptionVB6   
AESEncryptionJAVA   
eclipse-workspace   
  
Mail:  
[email]yancedywiler@gmail.com[/email]