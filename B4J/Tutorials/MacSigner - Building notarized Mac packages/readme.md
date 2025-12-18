### MacSigner - Building notarized Mac packages by Erel
### 12/16/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/130890/)

![](https://www.b4x.com/android/forum/attachments/113694)  
  
It is mostly impossible to run non-notarized and unsigned apps on new versions of Mac.  
MacSigner tool will help you with the various steps required to convert the app jar to a notarized and signed app package.  
  
**Requirements**  

1. Mac computer.
2. Apple developer account ($99 per year).

**Java**  
  
The java SDK is made of three components: Java JDK, JavaFX libs and JavaFX jmods.  
Java JDK 19.0.1 for Mac ARM: <https://download.java.net/java/GA/jdk19.0.1/afdd2e245b014143b62ccb916125e3ce/10/GPL/openjdk-19.0.1_macos-aarch64_bin.tar.gz>  
JavaFX libs: <https://download2.gluonhq.com/openjfx/17.0.17/openjfx-17.0.17_osx-aarch64_bin-sdk.zip>  
JavaFX jmods: <https://download2.gluonhq.com/openjfx/17.0.17/openjfx-17.0.17_osx-aarch64_bin-jmods.zip>  
  
You need to download the three components to a folder (versions differ):  
  
![](https://www.b4x.com/android/forum/attachments/113739)  
And unpack the files:  
  
![](https://www.b4x.com/android/forum/attachments/113740)  
Don't rename the folders.  
  
  
**Mac signer**  
  
Download and unzip MacSigner to your Mac: [www.b4x.com/b4j/MacSigner.zip](https://www.b4x.com/b4j/MacSigner.zip)  
  
**Signing key**  
  
In most cases you should use a single signing key for all your app. Steps to create the signing key:  

1. Run MacSigner. Set the path to Java bin folder: [jdk-19.01.jdk/Contents/Home/bin](http://jdk-19.01.jdk/Contents/Home/bin)
2. Set the path to the keys folder.
3. Click on Create Key. You can leave the default values.
4. It will create various files in the keys folder, including a file named certSigningRequest.csr.
5. It is a good time to save the MacSigner settings (File - Save).
6. Go to: <https://developer.apple.com/account/resources/certificates/list>
Create a new certificate. Set its type to **Developer ID Application**. Don't confuse it with other similar types.
Set its signature compatibility to "Previous Sub-CA":
![](https://www.b4x.com/android/forum/attachments/168873)
Upload certSigningRequest.csr when requested to upload a certificate signing request file.7. Download developerID\_application.cer and put it in the keys folder:
![](https://www.b4x.com/android/forum/attachments/113695)
All these files go together. A certificate created with a different csr file will not work.
**Steps from a jar to an app package  
  
Link** - the good old B4JPackager11 which is embedded inside MacSigner. Links the app jar with a Java runtime. Creates a standalone package.  
**Package** - Uses Java jPackage tool to convert the standalone package to a Mac app package with a native launcher. The files in the package are signed during this step. It also creates a zip file of the package.  
**Notarize** - Uploads the zip file to Apple server for automatic tests. This step can take several minutes to complete. This step ends when the file was uploaded to Apple. It can take another several minutes for Apple to process the file. An email will be sent after the file was processed.  
**Request Info** (optional) - Checks the status of a submitted app.  
**Log Info** (optional) - Provides more information on failed uploads.  
**Staple** - After the app was notarized successfully, the staple step marks the app package as notarized.  
  
**More details  
  
Link**  
  
Copy the compiled jar to the Mac. If you have used #PackagerProperty (or it was added by a b4xlib) then you should also copy packager.json, which is generated when you choose Project - Build standalone package:  
  
![](https://www.b4x.com/android/forum/attachments/113702)  
  
No need to copy the json file if not using #PackagerProperty.  
If completed successfully, you will see a line similar to:  
> You can check the linked package: /Users/ereluziel/Downloads/tempjars/temp/build/run.command

Worth running run.command to see that the package works as expected.  
  
**Package**  
  
Set the app name. You can also put an icon file at the same folder as the jar file. The icon extension should be icns. You can use this tool to create the icon: <https://cloudconvert.com/png-to-icns>  
As before, the output path will be logged. Worth double clicking on the app file. It should work.  
  
**Notarize**  
  
Set your Apple's username and password **and provider id** (click on List Providers to find it). The password must be an app specific password: <https://appleid.apple.com/account/manage> - Security - App Specific Passwords  
After the zip file is uploaded, you will see something like:  
> No errors uploading '/Users/ereluziel/Downloads/tempjars/package/MacSigner.zip'.  
> RequestUUID = 5d17a894-0389-4737-a898-cec4a90f0d50

  
You can check the request status using the request uuid. You will also receive an email when the check completes.  
  
**Staple**  
  
If the app was notarized properly then you should click on Staple to mark the app package. It will also delete the previous zip file and create a new one.  
  
You can now distribute it ?  
  
**Tips**  

- Use B4J-Bridge v1.50+ to test your app on the Mac: <https://www.b4x.com/android/forum/threads/remote-debugging-with-b4j-bridge.38804/>
- You can use B4J-Bridge FTP feature to copy files between the PC and the Mac:
![](https://www.b4x.com/android/forum/attachments/113707)- Worth testing the packed app before the notarization step.

  
**Updates**  
  

- 2.01 - Adds support for PyBridge with embedded Python: <https://www.b4x.com/android/forum/threads/pybridge-mac-notarized-standalone-package-with-embedded-python.169760/#post-1039652>
- 2.00 - Updated for compatibility with macOS 26, arm64 and newer versions of Java. Instructions regarding the key and java downloads were updated.
- 1.02 - Switched from altool to notarytool as required by Apple. Note that you must fill the provider field.
- 1.01 - Adds an option to set the provider. It is relevant when there are several teams related to the Apple account.
There is a new List Providers button. Click on it. Find the provider short name and put it in the field. If there is a single provider then you can leave it empty.- 0.95 - fixes issue with Java.