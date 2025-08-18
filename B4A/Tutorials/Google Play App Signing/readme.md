### Google Play App Signing by Erel
### 03/07/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/91703/)

Google Play App Signing service allows developers to let Google store the app signing key for them.  
Developers need to use a different key, the upload key, to sign the app before release.  
The advantage of this service is that with the help of Google support you can generate a new upload key in case the previous one was lost.  
Without this service it is not possible to update an app if you lost its signing key.  
  
Once you enroll in this service it is not possible to opt out.  
I think that for now it is better not to enroll in this service as it requires a few extra steps, however it means that you should backup your key properly.  
  
Steps to enroll in this service:  
  
Go to Release Management - App signing.  
  
**Upload original key to Google:**  
You should download pepk.jar from Google app signing instructions page.  
The encryption key should be replaced with the key from the instructions page.  
1.  

```B4X
java -jar pepk.jar –keystore=foo.keystore –alias=b4a –output=encrypted_private_key_path –encryptionkey=aaaaaaaaaaaaaaaaaaaa1e6c09ffe3056a104a3bbe4ac5a955f4ba4fe93fc8cef27558a3eb9d2a529a20bbbbbbbbbbbbbbbbbbb
```

  
2. upload the output file  
  
**Create the upload key:**  
3.

```B4X
keytool -genkey -v -keystore my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias b4a
```

  
  
![](https://www.b4x.com/basic4android/images/SS-2018-04-10_09.20.51.png)  
  
4. Extract the certificate from the key and upload it to Google Play:  

```B4X
keytool -export -rfc -keystore my-release-key.jks -alias b4a -file upload_certificate.pem
```

  
  
![](https://www.b4x.com/basic4android/images/SS-2018-04-10_09.22.40.png)  
  
**Manually build and sign the app before uploading it to Google Play**  
  
1.  

```B4X
"c:\Program Files (x86)\Anywhere Software\Basic4android\B4ABuilder.exe" -task=Build -NoSign=True
```

  
  
![](https://www.b4x.com/basic4android/images/SS-2018-04-10_09.30.54.png)  
  
2. zip align the temp file:  

```B4X
del aligned.apk  
<android sdk>\build-tools\27.0.1\zipalign.exe -v -p 4 Objects\bin\temp.ap_ aligned.apk
```

  
  
![](https://www.b4x.com/basic4android/images/SS-2018-04-10_09.32.16.png)  
  
3. sign the aligned apk (change the path to the upload key):  

```B4X
<android sdk>\build-tools\27.0.1\apksigner.bat sign –ks "c:\users\h\Downloads\my-release-key.jks" –out signed.apk aligned.apk
```

  
  
![](https://www.b4x.com/basic4android/images/SS-2018-04-10_09.33.23.png)  
  
4. Upload signed.apk to Google Play  
  
You can make a batch file to automate the building and signing.  
Tip: You should use Call in the batch file to call ApkSigner.bat:  

```B4X
<B4A Path>\B4ABuilder.exe" -task=Build -NoSign=True  
del aligned.apk  
<Android SDK>\build-tools\27.0.1\zipalign.exe -v -p 4 Objects\bin\temp.ap_ aligned.apk  
call <Android SDK>\build-tools\27.0.1\apksigner.bat sign –ks-pass pass:<password>–ks my-release-key.jks –out signed.apk aligned.apk  
pause
```