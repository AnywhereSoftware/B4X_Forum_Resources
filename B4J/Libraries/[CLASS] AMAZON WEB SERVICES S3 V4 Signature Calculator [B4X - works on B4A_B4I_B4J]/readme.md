### [CLASS] AMAZON WEB SERVICES S3 V4 Signature Calculator [B4X - works on B4A/B4I/B4J] by JackKirk
### 04/10/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/81272/)

Here is a port of AWS\_S3\_1\_1.zip of:  
  
<https://www.b4x.com/android/forum/threads/amazon-web-services-s3-v4-signature-calculator.81006/>  
  
The attached zip contains a code module that calculates V4 signatures for Amazon Web Services (AWS) Simple Storage Service (S3) REST API requests, enabling creation of AWS S3 PUT/GET/DELETE requests.  
  
You basically just plug in the properties necessary for a signature calculation and call Signature.  
  
The accompanying example code has 4 worked examples that actually generate the signatures the AWS documentation says they should.  
  
There is extensive in-line documentation.  
  
I could never get:  
  
<https://www.b4x.com/android/forum/threads/amazon-s3-library.38699/#post-335436>  
  
working but am indebted to it for some hints in a couple of areas.  
  
NOTE: THIS VERSION OF THE CODE MODULE IS TRI CROSS PLATFORM (B4A, B4J and B4I).  
  
**NOTE: To use under B4J you need to copy the B4A Encryption and ByteConverter Additional Libraries to B4J.**  
[Enjoy...](https://www.b4x.com/android/forum/threads/porting-of-b4a-amazon-web-services-v4-signature-calculator.81036/#post-513785)  
  
Refer to subsequent posts #2, #3, #4 and #5 of:  
  
<https://www.b4x.com/android/forum/threads/amazon-web-services-s3-v4-signature-calculator.81006/>  
  
for practical ways to use the module with AWS S3 buckets - I will leave it to you to do the porting…  
  
**UPGRADE 1.7**  
  
Attached is version 1.7 which utilizes the new [GMTFormatter.B4Xlib](https://www.b4x.com/android/forum/threads/b4x-format-dates-in-gmt-time-zone-without-changing-the-apps-time-zone.129502/#content) to handle extraction of GMT without having to change time zones. The significance of this is that it means any B4A/i/J apps using it can run over day light saving change events and still have all DateTime.Date and DateTime.Time calls work correctly.  
  
TO RUN THE TESTS CORRECTLY YOU MUST PAY CLOSE ATTENTION TO THE INTERNAL COMMENTS RE "FIDDLES"