### [tool] OTA Deployer - Easily distribute your app to beta testers by Erel
### 06/11/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/61672/)

This is a tool for developers who use the hosted builder. With this tool your beta testers can install your app over the air by clicking on a link.  
  
In order to distribute your app you need to follow these steps:  
  
1. Add the beta tester device UDID to the provision file and download the updated file.  
2. Compile your app in release mode, using the development certificate.  
3. Download the archive with Tools - Build Server - Download Last Built.  
4. Open archive.zip and extract the ipa file.  
5. Run OTA Deployer (double click on the jar file), fill the fields and upload the ipa file to the server.  
  
![](https://www.b4x.com/basic4android/images/SS-2015-12-24_16.45.59.png)  
  
The server will return a long link starting with itms-services. Send this link to the beta testers (by email or any other way).  
  
**Notes**  
  
- The maximum allowed IPA size is 60mb.  
- A single IPA file (the last one) is stored per account.  
- IPA files will be deleted from the server after 30 days.  
  
Download link: <https://www.b4x.com/b4i/files/ota.zip>