### EasyAR (Augmented Reality) Library UPDATED! by walterf25
### 10/27/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/110018/)

Hello everyone, I would like to introduce this Beta version of my B4AEasyAR Library, i have been trying to wrap an AR Library for some months now but have came across some issues while wrapping some of the functions.  
I read a post by someone about EasyAR, spent some time looking at the documentation and examples and decided to give it a try, i finally have something that works good and wanted to share it with everyone, please keep in mind that I am not a Java expert, however i am taking an advanced Java class in college along with Python and iOS.  
  
**Please note that the updated library requires google\_ar SDK, I have linked a copy of the [.aar here](https://drive.google.com/file/d/1Cov84fARMlb7aCtGqU8_Y3I-F3FC-XU2/view?usp=sharing) file but you can also download it from their website. Also check out the manifest file as there's an extra entry tag that needs to be added, the reason is that the new SDK will check if Google AR is installed on your device, it also checks the version and if it needs to be updated.**  

```B4X
AddApplicationText(<meta-data android:name="com.google.ar.core" android:value="required"/>  
        <meta-data android:name="com.google.ar.core.min_apk_version" android:value="181012000"/>)  
  
AddApplicationText(<activity  
            android:name="com.google.ar.core.InstallActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:excludeFromRecents="true"  
            android:exported="false"  
            android:launchMode="singleTop"  
            android:theme="@android:style/Theme.Material.Light.Dialog.Alert" />  
            <meta-data  
            android:name="com.google.ar.core.min_apk_version"  
            android:value="181012000" />)
```

  
  
Ok, in order to be able to use this library you will need to register for an account at [EasyAR website](https://www.easyar.com/) once you have signed up, you can login and you will need to create an SDK License key.  
![](https://www.b4x.com/android/forum/attachments/84282)  
Just click on the Add SDK License Key button, you will be prompted to choose what type of license key you need to generate, Select EasyAR SDK Basic option, next you will need to enter your App's name, then go ahead and Select Android for Supported Platform and lastly you need to enter the same package name you used when creating your application.  
![](https://www.b4x.com/android/forum/attachments/84283)  
Once the SDK key is generated you will be able to see it by clicking on the Name of the application created, copy and save your key as you will need it.  
  
I have attached a very simple example which is the very same example that comes with their SDK, what the app does is that it tracks two different images and renders a 3D cube on top of the image, as i mentioned this is a very simple example but just imagine the possibilities.  
  
I have also attached a small video i made showing the app in action, the bxRenderer class is where all the magic happens and it an be modified to your taste granted that you are familiar with OpenGL.  
  
I am using [USER=448]@agraham[/USER] OpenGL2.0 library, i was almost half way wrapping the OpenGL2.0 library when i realized that it had already been done for us in the forums by [USER=448]@agraham[/USER] so a big thanks to him for his hard work, it truly saved me lots of time, i added a few functions to his library that were needed with EasyAR library, i have sent him the updated OpenGL2.0 version 1.5 library for him to upload it to his original thread.  
  
B4AEasyAR library uses your device's camera to track certain images that you can upload either to your device or the cloud, currently i have not wrapped any of the functions to be able to recognize images uploaded to the cloud.  
  
I suggest you guys do some research on your own about the capabilities of this SDK, this will be an ongoing effort to maintain this library updated, I think it was definitely time that a library like this was needed in our forums.  
  
For now I will only upload the jar and xml file, you will need to download the SDK once you are signed up with EasyAR.com and copy the EasyAR.jar file that comes with the SDK and paste it into your additional library folder.  
  
Please test the attached APK file, and let me know what device and android version you guys test on, and of course post any problems or suggestions you come across.  
  
**Library and examples have been updated with latest EasyAR SDK 4.x Sense  
  
[SIZE=6]Please make sure to download the latest EasyAR SDK files, find the EasyAr.jar file copy it and paste it into your additional libraries folder.[/SIZE]**  
  

---

  
**Updated library files, jar and xml files version 2.15 can be downloaded** [from here](https://drive.google.com/file/d/1uqCDpCmhsCjZS-0NtY1esvG-yJgz6YXR/view?usp=sharing)  

---

  
  

---

  
  
**APK has been updated with a few more examples and can be downloaded** [from here.](https://drive.google.com/file/d/1uh1TTgWNZoLAzb1QDBCmqRkI5JW9H7ti/view?usp=sharing)  

---

  
  
  
The updated apk file contains a few more examples and has been updated with the latest EasyAR SDK library, note that a watermark is displayed on the screen if using a free license, in order to get rid of the watermark you must purchase a license.  
  
**UPDATE**  
I am releasing the Source code of the Examples I have already shown, plus two more examples, one using a custom camera class which uses the Android Camera class and Surface Tracker example.  
I am also attaching the documentation for the library, the library is also being updated as I have added a few more things to it.  
  
> **UPDATE 10/27/2024**  
> Source code for the new examples apk has also been updated, this updates contain two more examples, multi-tracker example and Object Tracker example. These Updates have been done with the latest EasyAR SDK library 4.6.x

  
**[SIZE=6]Library files have also been updated 10/27/2024[/SIZE]**  
  

---

  
  
**[SIZE=6]Updated Source Code 10/27/2024[/SIZE]**  
[**[SIZE=6]Example Source Code 1.2.5[/SIZE]**](https://drive.google.com/file/d/1l1OyrGcRTH6K2GrFlMW_RyLKvJbhFy_I/view?usp=sharing)  

---

  
  
  
  
You will need to either print out a copy of the two images being used in this example to test the app or just open them up on your laptop and point the camera to the image on your screen, either way will work fine.  
![](https://www.b4x.com/android/forum/attachments/84284) ![](https://www.b4x.com/android/forum/attachments/84285)![](https://www.b4x.com/android/forum/attachments/84302)  
  
and lastly here's the video I made to show the app in action.  
[MEDIA=youtube]ZJpixiGcpZU[/MEDIA]  
[MEDIA=youtube]IFY6hwGG7mA[/MEDIA]  
  
**Please Donate if you guys find this library useful, i have spent a lot of hours and I will keep this library updated as necessary, your donations will keep me motivated to continue maintaining this library.**  
  
Thanks all, can't wait to see what type of apps can be created with this new Library.