###  QRGenerator - Cross platform QR code generator by Erel
### 04/26/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/93092/)

QRGenerator is a class that generates QR codes.  
It is written in B4X and it is compatible with B4A, B4i and B4J.  
  
iPhone default camera app recognizing the QR code displayed in a B4A app:  
  
![](https://www.b4x.com/basic4android/images/SS-2018-05-16_18.56.16.jpg)  
  
Can create codes made of up to 2953 bytes.  
  
It depends on XUI library and B4XCollections v1.50+.  
It uses the very useful B4XBytesBuilder class.  
  
Very good resource about the format: <https://www.thonky.com/qr-code-tutorial/introduction>  
The Reed-Solomon error correction calculation is based on [zxing open source project](https://github.com/zxing/zxing).  
  
A B4J example is attached with QRGenerator class.  
  
**Versions**  
  
V1.60 - Added support for 1-L (max size is 17 bytes).  
V1.50 - Added support for 40-L, 40-H and 23-H formats. Refactored code to make it easier to add more formats. BytesBuilder was replaced with B4XBytesBuilder from B4XCollections library.  
V1.20 - Adds support for 9-L codes. Also renamed the local Block variable as it is a reserved word in B4i.  
v1.11 - Fixes an issue with messages 35 or 36 bytes long.  
  
Extended version that supports more QR versions: <https://www.b4x.com/android/forum/threads/b4x-qrgenerator-cross-platform-qr-code-generator-amended-to-accommodate-more-qr-code-versions.116891/>