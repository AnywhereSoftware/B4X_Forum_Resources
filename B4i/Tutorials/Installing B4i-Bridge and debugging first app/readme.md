### Installing B4i-Bridge and debugging first app by Erel
### 09/18/2022
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/45871/)

B4i-Bridge is an application that you install on the device.  
It has three purposes:  
1. Launch the installation process when needed. **This step is done with Apple Configurator 2 if using a local builder (<https://www.b4x.com/android/forum/threads/installing-apps-with-apple-configurator-2.128397/>).**  
2. Run the installed app (when installation is not needed).  
3. The bridge is also the WYSIWYG visual designer.  
4. Starting from iOS 16 you need to enable developer mode under: Settings - Privacy & Security -> Developer Mode  
  
You need to install B4i-Bridge once. It is done from the device browser.  
  
  
This video tutorial shows the steps required in order to install B4i-Bridge.  
  
The important steps are:  
- Set the package name based on the provision app id.  
- Build B4i-Bridge: Tools -> Build Server -> Build B4i-Bridge  
- Open mobile Safari and navigate to the link displayed in the compilation window.  
- Install B4i-Bridge and run it.  
  
  
[MEDIA=vimeo]250613345[/MEDIA]  
  
Transcript:  
1. Create a new project and save it.  
2. Set the package name based on the provision app id (Project - Build Configurations).  
3. Tools - Build Server - Build B4i-Bridge app.  
4. The compilation dialog will show the link that you need to enter in the device browser.  
5. Click on the Install button and confirm the installation.  
6. Press on the Home key. B4i-Bridge app should be installed.  
7. Start B4i-Bridge. A message with the ip address will be displayed.  
8. Set this address in the IDE under Tools - Device IP Address.  
9. Run the program. Approve the installation on the device and click on the new installed app.  
  
  
Note that this is a real device. Not an emulator.  
  
Tips:  
  
- B4i-Bridge must be in the foreground for it to be able to start an installation or to run the application. In most cases it will be in the foreground automatically. If it is not in the foreground then you need to click on it to bring it to the foreground.  
  
**Troubleshooting:**  
  
Device errors:  
  
  
1. Make sure that the mobile provisioning file includes the device UDID and that the UDID doesn't start with ffffff (this is a fake id).  
2. Select 64 bit under Tools - Build Server - Server Settings.  
  
Compilation errors:  
1. First follow the steps in this tutorial: <http://www.b4x.com/android/forum/threads/creating-a-certificate-and-provisioning-profile.45880/>  
2. Make sure that the App Id ends with a wildcard.