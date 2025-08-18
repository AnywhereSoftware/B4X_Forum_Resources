### FCM messages checklist (prevent issues) by KMatle
### 04/21/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/129962/)

With newer Android versions came more options for power saving and permissions we have to deal with. There are a lot of threads about FCM messages not arriving or beeing delayed. Here's a small "checklist" which may help. Feel free to add the list.  
  
**Before installing your app**  
  
- send data messages (see examples in the forum or Google docs) only as those message types are delivered in the background  
- set the priority to "high"  
- use NB6 to create your notifications and set the priority to "high", too  
- did you (more precise: your phone) restrict any network traffic, apps running in background, etc.?  
  
**After installing your app / first run**  
  
Go to app settings (shortcut is to long click on the app's icon) and check the following:  
  
- Autostart -> ON   
- Restrict data usage -> OFF (otherwise the network connection is cut off when your phone sleeps)  
- Notifications -> all ON (there are "profiles" containing the settings like vibrate, sound, light, where to show, too. These come from the NB6 settings)  
- Run in background (mostly "energy saving plan" or similar) -> YES (or not restricted)  
**-** Compare your app's setting with e.g. the one of WhatsAPP  
  
My old Huawei P10 had a whitelist with apps allowed to run in the background. WhatsApp wasn't initially in that list which - guess what - caused it to be stopped when the phone went to sleep. As a result no notifications were showed. I had to change the settings manually. Later Huawei did an update and added WhatsApp to the whitelist.  
  
  
**Still having issues?**  
  
- send a timestamp with the FCM message  
- when receiving the message add the actual timestamp to the notification text to compare  
- mostly the message IS received but the notification isn't thrown. Here check the app settings again (see above).  
- if a notification isn't thrown when the phone sleeps, check the permissions/powersettings again (message arives but due to the settings it only shows when you wake up the phone)  
- Is your internet connection stable? On Wifi: Does your router disconnect when there is "no" traffic?  
  
Note:   
  
Even today WhatsApp (or Android/Google?) is having issues sometimes. From time to time I have new messages without a notification or without sound/vibration. Google is handling billions of messages every day.