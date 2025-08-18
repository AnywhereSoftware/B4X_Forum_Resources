### The result of swiping an app from the recent apps list by Erel
### 12/21/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/27605/)

One of the new features of Android 4 is the more powerful recent apps list. The user can remove tasks or applications from the list with a swipe gesture.  
  
The result of this action is not fully documented. So I ran some tests and these are the findings:  
  
As expected the activities are destroyed. What happens with the running services is a bit more complicated:  
  
- Any "standard" services are destroyed. Note that Service\_Destroy is not called.  
  
- [Sticky services](http://www.b4x.com/forum/basic4android-getting-started-tutorials/27065-creating-sticky-service-long-running-background-tasks.html#post156710) are destroyed and are recreated after 5 seconds.  
  
- Scheduled services (with StartServiceAt) are still scheduled. This is a different, and usually better, behavior than with some of the third party task killers.  
  
- Foreground services (Service.StartForegroud) are not affected. This is also the only case where the process is not killed.  
  
Edit: Sticky services should no longer be used as the OS doesn't restart those services.