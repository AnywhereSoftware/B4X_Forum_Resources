### [RESOLVED] Issue building bridge app with provisioning profile and notification Firebase by voxel
### 08/21/2026
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/171865/)

Hello,  
I am having trouble compiling the bridge app using my provisioning profile. I created a provisioning profile for notifications using my App ID `fr.lyzo` (this works fine when compiling my app in debug mode).  
I then tried to compile using the bridge app for a different test iPhone and encountered this issue:  
  
*/Users/ereluziel/Documents/UploadedProjects/<user id>/B4iProject.xcodeproj: error: Provisioning profile "notificationProvisingLyzoFr" has app ID "fr.lyzo", which does not match the bundle ID "fr.lyzo.bridge". (in target 'B4iProject' from project 'B4iProject')  
warning: Skipping duplicate build file in Copy Bundle Resources build phase: /Users/ereluziel/Documents/UploadedProjects/<user id>/fr.lproj/InfoPlist.strings (in target 'B4iProject' from project 'B4iProject')*  
  
I tried using the provisioning profile without notifications enabled, but I got a different error:  
  
*/Users/ereluziel/Documents/UploadedProjects/<user id>/B4iProject.xcodeproj: error: Provisioning profile "provision" doesn't support the Push Notifications capability. (in target 'B4iProject' from project 'B4iProject')  
/Users/ereluziel/Documents/UploadedProjects/<user id>/B4iProject.xcodeproj: error: Provisioning profile "provision" doesn't include the aps-environment entitlement. (in target 'B4iProject' from project 'B4iProject')  
warning: Skipping duplicate build file in Copy Bundle Resources build phase: /Users/ereluziel/Documents/UploadedProjects/<user id>/fr.lproj/InfoPlist.strings (in target 'B4iProject' from project 'B4iProject')*  
  
  
How do I handle a Bridge provisioning file for code that uses notifications?  
  
Thanks for your help.