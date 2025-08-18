### AppUpdating 2.0 - update non-market apps by udg
### 02/18/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/98419/)

Time goes by, things change and old tools need to be updated.  
  
**AppUpdating 2.0** is a partial rewrite of [AppUpdating](https://www.b4x.com/android/forum/threads/appupdating-automate-apps-updating-from-a-webserver.37783/#content), a lib written back in 2014 to allow the remote update of non-market applications hosted on a webserver.  
  
Why AU 2.0? Main reason is Google's introduction of Android 8 and the profound changes on a few key points coming with it. But it was time to leverage B4x's new features too. And, finally, a bit of clean up is always due.. :)  
  
On next two posts I'll describe the steps needed to make the lib work with your code.  
**Edit**: see [post#43](https://www.b4x.com/android/forum/threads/appupdating-2-0-update-non-market-apps.98419/page-3#post-800608) below for installing instructions related to version 2.05 and higher.  
  
What the lib does is simply to check whether the version number reported by reading an info text file on your webserver is greater than the one showed in the running copy of your app. If it finds indication of a newer version, it downloads it, then it asks the user to install it.  
Since we can't know if the user agrees to update the app, we simply go on with our app, knowing that a service burned in the lib will fire when the OS will signal that the user accepted to install the newly downloaded copy of the app. In this latter case, the same service will reload the app when ready.  
  
Files attacched:  
**AppUpdating.b4xlib** - version 2.05 packed following the new b4xlib standard  
AU200\_src - source code for the lib  
AU200\_demo - example program using the lib  
AU200\_lib - lib file compiled with B4A 8.30  
  
Versions changelog  
2.05 - made it compatible with simultaneous use of NB6  
2.00 - initial release of AppUpdating 2.0