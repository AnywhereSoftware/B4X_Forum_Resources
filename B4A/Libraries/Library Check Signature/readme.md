### Library Check Signature by MarcoRome
### 01/13/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/58031/)

Hi all  
This is simple library to check signature APK.  
  
**CheckSignature  
Author:** Devil-App  
**Version:** 1  

- **CheckSignature**
Methods:

- **CertificateGetSerialNumber As String**
*Get CartificatGetSerialNumber example Serial Number: 15434885569865480918  
Example:<code>  
Dim check As CheckSignature  
 Log("Certificate Vendor: " & check.CertificateGetSerialNumber)</code>*- **CertificateIssuer As String**
*Get CartificatIssuer example OID.1.2.840.113549.1.9.1=#1616652E4564526F69642E6F734073616D73756E672E636F6D,   
CN=Samsung Cert, OU=DMC, O=Samsung Corporation, L=Suwon City, ST=South Korea, C=KR  
Example:<code>  
Dim check As CheckSignature  
 Log("Certificate Vendor: " & check.CertificateIssuer)</code>*- **CertificateName As String**
*Get CartificatName example ELM Agent  
Example:<code>  
Dim check As CheckSignature  
 Log("Certificate Name: " & check.CertificateName)</code>*- **CertificateSubject As String**
*Get CartificatSubject example OID.1.2.840.113549.1.9.1=#1616524E64895F69642E6F734073616D73756E672E636F6D  
CN=Samsung Cert, OU=DMC, O=Samsung Corporation, L=Suwon City, ST=South Korea, C=KR  
Example:<code>  
Dim check As CheckSignature  
 Log("Certificate Vendor: " & check.CertificateSubject)</code>*- **CertificateVendor As String**
*Get CartificatVendor example com.sec.esdk.elm  
Example:<code>  
Dim check As CheckSignature  
 Log("Certificate Vendor: " & check.CertificateVendor)</code>*- **KeyHash As String**
*Get Signature KeyHash example ggw+21Mf6Fedr0lwKTx36lquaYk=  
Example:<code>  
Dim check As CheckSignature  
 Log("Signature KeyHASH: " & check.KeyHash)</code>*- **getPackageName As String**
*GetPackageName example get com.devil.app.test  
Example:<code>  
Dim check As CheckSignature  
 Log("Name APK: " & check.getPackageName)</code>*- **getPackageVersionCode As Int**
*GetPackageVersionCode example get #VersionCode: 1  
Example:<code>  
Dim check As CheckSignature  
 Log("VersionCode APK: " & check.getPackageVersionCode)</code>*- **getPackageVersionName As String**
*GetPackageVersionName example get #VersionName: 1.0  
Example:<code>  
Dim check As CheckSignature  
 Log("VersionName APK: " & check.getPackageVersionName)</code>*- **md5 As String**
*Get Signature md5 fingerprint example ce916325b369d91049d9oo36323890a3  
Example:<code>  
Dim check As CheckSignature  
 Log("Signature md5 fingerprint: " & check.md5 )</code>*- **sha1 As String**
*Get Signature sha1 fingerprint example 826afdgb521ee8569daf4870293c77ea5aae6989  
Example:<code>  
Dim check As CheckSignature  
 Log("Signature sha1 fingerprint: " & check.sha1 )</code>*
  

```B4X
Log("Name APK: " & check.getPackageName)  
    Log("VersionName APK: " & check.getPackageVersionName)   
    Log("VersionCode APK: " & check.getPackageVersionCode)  
    Log("Signature md5 fingerprint: " & check.md5 )  
    Log("Signature KeyHASH: " & check.KeyHash)   
    Log("Signature sha1 fingerprint: " & check.sha1 )  
    Log("Certificate Name: " & check.CertificateName)  
    Log("Certificate Vendor: " & check.CertificateVendor)  
    Log("Certificate Subject: " & check.CertificateSubject)  
    Log("Certificate Issuer: " & check.CertificateIssuer)  
    Log("Certificate Serial Number: " & check.CertificateGetSerialNumber)
```

  
  
![](https://www.b4x.com/android/forum/attachments/87446)