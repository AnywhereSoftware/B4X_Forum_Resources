### Webview - Right click to save image by drgottjr
### 11/03/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/124054/)

Full-blown browsers enjoy a context menu, activated with a right click of the mouse. Among other tasks, you can select and download images appearing on the page.  
  
Attached below you will find Contextual (.jar and .xml), a library which allows you to download and save images from a webview. Unzip to your Addlibs folder.  
  
Use:  
1) Include Contextual in your project. Check Contextual in the libraries tab.  
2) Declare some variable as Contextual  
3) Declare and add your webview as usual  
4) Initialize your Contextual variable. You can use an empty string as the only parameter.  
5) Call Contextual's addContextMenu() method, passing your declared webview as the only parameter.  
6) At some point, you'll want to load a url in your webview. Nothing much happens in a blank webview.  
  
When you find an image of interest that you wish to download, tap and hold it (aka, long click or long press). The context menu should appear, offering you 3 choices: Save to the pictures gallery, Save to SafeDirDefaultExternal, Cancel.  
  
If you choose to save the image, the system sends you a notification indicating success or failure. In my tests, it appeared at the top of the device like any other notification, almost immediately.  
  
Webview uses the system's download manager. In theory, it wants to use the download folder, but it can use the pictures folder (or gallery), and it seems happy to store images in your app's so-called SafeDirDefaultExternal folder. What it doesn't do, apparently, is store to your File.DirInternal folder.  
  
Some servers go out of their way to obfuscate image url's. I have no control over that. Webview is trained to recognize if you've long-pressed an image. That image's url may not be accessible using normal methods.  
  
I've tested the library on devices running os 8.1, 9 and 11. I don't know what happened to 10. A device running it presumably got upgraded. I've tested with apps compiled with SDK targets 28 and 29 with B4A 10.2.  
  
Runtime Permissions:  
Unless you're running Android 11 and SDK 29, you'll need external write permission in your manifest to save to the pictures folder. To save to SafeDirDefaultExternal, you need a runtime permission, but there is no request/check needed. In other words, when I test the app on an 8.1 or 9 device, I need request/check permission for the pictures folder. When I run an app on my Pixel3a, I don't seem to need any permissions. It just works somehow… If you're running on an older device, I have no idea what will happen. There was a time when you could store stuff where you wanted on your device. No more.  
  
If you're running on a recent vintage device and you plug in the library, and the context menu appears, but nothing is downloaded, I'd say it was due to runtime permissions.  
  
**edit**: I've updated the library (now V.92). It adds the external write permission to the manifest, and it warns you if permission to use it has been granted (should that be necessary). It also catches a crash relating to that permission. Downloading to SafeDirDefaultExternal doesn't require granting permission. If there is a problem downloading to the pictures folder, try saving the image to SafeDirDefaultExternal.  
  
**edit 2**: I have another update (V.93), which I've not uploaded. In addition to downloading to the abovementioned folders, V .93 will save to File.DirInternal. While this may seem to conform with what we're supposed to do, it strikes me as the least useful of the choices (depending on what your app does). Images in the pictures and SafeDirDefaultExternal folders can be seen outside of your app. Certainly, images in the pictures folder are readily visible. But images saved to File.DirInternal cannot be seen outside of your app. You would have to devise a routine, eg, to put them into the pictures folder or to share them. In addition, yet another choice in the context menu, makes the menu itself fill the entire screen. And shrinking the menu makes accurate tapping problematic. For anyone wishing to have this additional option, the library is available.