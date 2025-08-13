### iEventKit - Calendar events and reminders by Erel
### 01/17/2024
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/76357/)

iEventKit provides access to the device stored calendar events and reminders.  
  
![](https://www.b4x.com/android/forum/attachments/53009) ![](https://www.b4x.com/android/forum/attachments/53012)  
  
Events and reminders are both stored in the calendar database and are treated in very similar ways.  
  
Steps to access calendar information:  
1. Add usage description. Note that there are two required #PlistExtra declarations for each type.  
2. Check the current authorization status based on the required items type. If it is NOT\_DETERMINED then you need to call RequestAccessReminders or RequestAccessEvents. A permissions dialog will be displayed.  
If the user has denied access then the only way to revert it is by uninstalling the app and installing it again or by setting it from the Settings app.  
  
See the two attached examples.  
  
iEventKit - copy XML file to internal libraries folder and two other files to the Mac Libs folder, if using a local Mac.