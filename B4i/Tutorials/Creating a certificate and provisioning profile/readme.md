### Creating a certificate and provisioning profile by Erel
### 04/25/2025
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/45880/)

Don't panic!  
  
While this process can be a bit annoying it is not too complicated and you can always delete the keys and start from scratch (which is not always the case in Android).  
  
Note that you must first register with Apple as an iOS developer (costs $99 per year).  
The whole process is done on a Windows computer.  
  
In order to install an app on an iOS device you need to create a certificate and a provisioning profile.  
  
The certificate is used to sign the application. The provisioning profile, which is tied to a specific certificate, includes a list of devices that this app can be installed on.  
**Edit:** pay attention to the certificate and provision profile options selection in the following screenshots (the options in the video are a bit different):  
  
![](https://www.b4x.com/android/forum/attachments/124489)  
![](https://www.b4x.com/android/forum/attachments/124490)  
  
  
[MEDIA=vimeo]354886143[/MEDIA]  
  
Steps required:  
  
**IDE**  

- Tools - Configure Paths. Set javac to OpenJDK 14.0.1: <https://www.b4x.com/b4j/files/java/jdk-14.0.1.zip>
- Tools - Build Server - Server Settings
- Tools - Private Sign Key - fill password and click on Create New Key

**UDID**  

- Find the device udid. You can find it with iTunes or with an online service such as: <https://showmyudid.com/>

**Apple developer account - developer.apple.com**  

- Devices - Add device
- App Id - Create wildcard app id
- Certificate - Create distribution certificate (ad hoc + store)
- Provision Profile - Create distribution profile (ad hoc)

  
Next tutorial: <https://www.b4x.com/android/forum/threads/installing-b4i-bridge-and-debugging-first-app.45871/>