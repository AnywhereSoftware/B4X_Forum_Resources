### Digitally sign XML Documents by jkhazraji
### 07/24/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/162245/)

This library serves to digitally sign an XML document. It has one function: ***signDoc*** that takes 10 parameters to be set first and the function is then called.  
For the time being it supports the "PKCS12" store type. Other types are not tested.  
  
**Paramaters and function:  
  
-XmlDocDir** : Directory of the xml document to be signed.  
**-XmlDocName** : Name of the xml document to be signed.  
**-keyStoreDir** : Directory of the keystore file.  
**-keyStoreName** : Name of the keystore file.  
**-SignedDocDir** : Direcory of the signed XML document generated.  
**-SignedDocName** : Name of the signed XML document generated.  
**-keyAlias** : Alias used in generating the keystore file.  
**-keyPassword** : the key passord used in generating the keystore file.  
**-StorePassword** : the key passord used in generating the keystore file.  
**-keystoreType :** the keystore type used in generating the keystore file, e.g., **PKCS12.**  
  
First the additional jar files are:  
[FONT=courier new]**jsr105-api-1.0.1.jar, xmlsec-1.3.0.jar, commons-io-2.16.1.jar, xml-apis-1.4.01.jar, commons-logging-1.2.jar  
Get them and add them to the additional libraries folder. (zip **size** is too large to upload here).**[/FONT]  
  
Before setting the paramaters and calling signDoc, check and request permission (PERMISSION\_WRITE\_EXTERNAL\_STORAGE)  
and add the following to the manifest file:  

```B4X
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>  
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>)
```

  
  
**An example code:**  
  

```B4X
    Dim rp As RuntimePermissions  
    If rp.Check(rp.PERMISSION_WRITE_EXTERNAL_STORAGE) = False Then  
        rp.CheckAndRequest(rp.PERMISSION_WRITE_EXTERNAL_STORAGE)  
        Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
        If Result = False Then  
            ToastMessageShow("Permission denied. The app cannot function without this permission.", True)  
            Activity.Finish  
            Return  
        End If  
    End If  
    Dim signXML1 As signXML  
    signXML1.keyAlias= "XXXXXXXXXXXXX"  
    signXML1.keyPassword="XXXXXXXXXXXXX"  
    signXML1.StorePassword="XXXXXXXXXXXXXX"  
    signXML1.keystoreType="XXXXXX"  
     
    File.Copy(File.DirAssets,"invoice.xml",File.DirInternal,"invoice.xml")  
    File.Copy(File.DirAssets,"keystore.p12",File.DirInternal,"keystore.p12")  
     
    signXML1.keyStoreDir=File.DirInternal  
    signXML1.keyStoreName="xxxxxx.p12"  
    signXML1.XmlDocDir= File.DirInternal  
    signXML1.XmlDocName="xxxxx.xml"  
    signXML1.SignedDocDir=File.DirInternal  
    signXML1.SignedDocName="signedxxxxxx.xml"  
     
    signXML1.SignDoc
```

  
The signed XML document should be found in the specified directory (DirInternal).  
It can work in b4j also but I did not test it