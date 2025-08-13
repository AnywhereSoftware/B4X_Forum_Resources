### ✅ B4A Uninstalling a kiosk app by Peter Simpson
### 11/27/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/155390/)

Hello all,  
I've noticed 2 or 3 posts about not being able to uninstall a kiosk app because android:testOnly is missing from the manifest file, it's not in Erel's example.  
  
If you just add the testOnly line to the manifest as you are supposed to for test packages then try to run/install that package on a device, you will see the following error message appears.  
![](https://www.b4x.com/android/forum/attachments/146945)  
The above message appears because you are not installing the package as a test package using adb but just as a normal package without the -t option. below is a quick tutorial on how to install the package as a test package, and more importantly how to uninstall the app afterwards.  
  
**Take note:**   
Once you have added the android:testOnly to your manifest, you can only install that app via the adb install -t command. Whilst developing your app you will need to comment out the android:testOnly line or you will keep seeing the failed to install error above. Develop your app as usual and only install as a kiosk app as a test package if you **need** to uninstall the app afterwards. You might want to uninstall a kiosk app if for example you are developing the app on your person phone or tablet and not on the end device that will not need it uninstalling.  
  
**Download Erel's kiosk app example linked below.**  
<https://www.b4x.com/android/forum/threads/device-owner-tasklock-kiosk-apps-2017.81765/#content>  
  
**Make 2 changes to Erel's kiosk app and follow my instructions very carefully.**  
  
1. At this point in time, **DO NOT** connect B4A to your Android device, **NOT** via B4A-Bridge, USB debugging or wirelessly.  
2. Change the package name to whatever you want to, lets say to com.test.yourapp  
3. Add the following line to the manifest file.  
> [SIZE=4]SetApplicationAttribute(android:testOnly,"true")[/SIZE]

  
3. Run the app but **NO NOT** install the app on your device, you are running B4A **JUST** to assemble and create the APK file.  
4. Connect your Android device via a USB cable to your B4A development machine.  
5. Go to the projects folder then go into the Objects folder and copy the file called Kiosk.apk.  
6 Find your Android\_SDK\platform-tools folder and paste the Kiosk.apk file into the platform-tools folder. **We will delete the file afterwards**.  
7. Open a command window in your Android\_SDK\platform-tools folder location. I personally find the platform-tools folder in a window, once there I personally overwrite the path with cmd and press enter as that will open a command windows in the Android\_SDK\platform-tools folder location.  
8. Install the kiosk app by typing the following line in the command windows, press enter. The **-t** option is the important part here so **DO NOT** forget to include it.  
> [SIZE=4]adb install -t Kiosk.apk[/SIZE]

The following should appear  
![](https://www.b4x.com/android/forum/attachments/146942)  
  
[SIZE=4]8. Type the following line into the command window, press enter.[/SIZE]  
> [SIZE=4]adb shell dpm set-device-owner com.test.yourapp/anywheresoftware.b4a.objects.AdminReceiver2[/SIZE]

![](https://www.b4x.com/android/forum/attachments/146943)  
I'm using a clients actual app, so I've blurred out its package name.  
  
That's it, your kiosk app is now installed on your device as a test package that you are now able to uninstall.  
  
**Lets uninstall your kiosk app which is installed as a test package.**  
Before you can uninstall the app, you fist have to remove the active admin linked to the test package. You remove the active admin by using the following line whilst the Android device is connected via the USB cable.  
> [SIZE=4]adb shell dpm remove-active-admin com.test.yourapp/anywheresoftware.b4a.objects.AdminReceiver2[/SIZE]

![](https://www.b4x.com/android/forum/attachments/146944)  
You can now uninstall the kiosk app from your Android device as usual with no error or warning messages saying that you can't remove a protected package.  
  
**DO NOT FORGET TO DELETE THE Kiosk.apk FILE FROM THE Android\_SDK\platform-tools folder.  
  
Please note:**  
You do not have to use a USB cable but it is the easiest and faster to connect to your Android device via a cable. In fact you can use the command 'adb connect' followed by your Android device ip address to connect wirelessly to your Android device as long as your Android device is connected to the same WiFi as your B4A development machine. So for example 'adb connect 192.068.0.123' or 'adb connect 192.068.1.123'.  
  
  
**Enjoy…**