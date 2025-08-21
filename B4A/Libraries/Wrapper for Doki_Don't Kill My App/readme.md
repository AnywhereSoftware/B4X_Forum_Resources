### Wrapper for Doki/Don't Kill My App by Inman
### 11/23/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/111626/)

If you have worked on an app that has a service that needs to be running all the time, you must have gone through the delightful experience of different phones killing your background service in different ways, despite taking all the corrective measures. I get negative reviews routinely on Play Store almost exclusively due to this. I used to reply to every review explaining how they should disable battery optimization and a bunch of other stuff that varies from device to device.  
  
Fortunately, a group of developers came together and created [dontkillmyapp.com](https://dontkillmyapp.com/) where they explain this situation, together with step by step device-specific guides on how to make sure an app doesn't get killed by the system. Now I usually email this link to my users and in some cases even link this website from within the app.  
  
But now there is a better way to show this info in-app. A library called Doki is available which will automatically detect the phone manufacturer and display the corresponding guide. It is available as an activity or a msgbox.  
  
<https://github.com/DoubleDotLabs/doki>  
  
They also have a demo app which can be downloaded from [here](https://github.com/doubledotlabs/doki/releases/download/0.0.1/doki.apk). Now, all we need is a wrapper so that we can display this within our B4A app.  
  
![](https://www.b4x.com/android/forum/attachments/85789) ![](https://www.b4x.com/android/forum/attachments/85790)