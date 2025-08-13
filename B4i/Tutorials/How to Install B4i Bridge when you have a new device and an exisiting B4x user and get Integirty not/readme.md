### How to Install B4i Bridge when you have a new device and an exisiting B4x user and get Integirty not verified. by llama
### 05/10/2023
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/147901/)

I wanted to   
If you are an existing B4i user only I would like to add B4i Bridge and have a new phone like I did, and you have already been using B4i , This was how I did this  
  
**NOTE - If you do not find Developer Mode on your new handset** (Privacy & Security - scroll down - Developer Mode) **like me and do not have a MAC or Xcode installed -**  
  
Then do the following  
  
  
1. First - add the new device UDID to the list of devices on your Apple account, create a new provision profile and download it.  
2. Then replace that with your old mobile provision you had.  
3. Create a new project and then add your package name in Project-> Build Configurations.  
4. Then go to tools and Build Server -> Build B4i -Bridge App.  
5. ***Note in Erels troubleshooting mode at this point I downloaded and installed*** b4i certificate and trusted it from ([www.b4x.com/ca.pem](http://www.b4x.com/ca.pem))  
  
You will now see it load onto your homescreen and without the integrity issue but you then can go into settings.  
6- Enable developer mode: Settings - Privacy & Security - scroll down - Developer Mode enable it back to homescreen and ilaunch B4i Bridge  
  
Hope this helps