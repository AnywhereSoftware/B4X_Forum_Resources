### iTopNotifications - Sliding notifications by Erel
### 01/13/2020
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/75923/)

**This library is deprecated. It is trivial to show an animated panel and it doesn't justify the complexity that is added when referencing swift frameworks.**  
Better alternative: <https://www.b4x.com/android/forum/threads/itopnotification-cutted-out-library.111986/post-698423>  
  
  
This is a wrapper for LNRSimpleNotifications: <https://github.com/LISNR/LNRSimpleNotifications>  
  
It implements nice sliding notifications that slide from the top or bottom.  
The user can click on the notification to dismiss it or wait for the set duration.  
  
![](https://www.b4x.com/android/forum/attachments/52623)  
  
It wraps a swift library so you need to set #MinVersion to 8 and it requires B4i v3.6+.  
  
Usage example:  

```B4X
Sub Process_Globals  
   Public App As Application  
   Public NavControl As NavigationController  
   Private Page1 As Page  
   Private tn As TopNotificationsManager  
End Sub  
  
Private Sub Application_Start (Nav As NavigationController)  
   NavControl = Nav  
   Page1.Initialize("Page1")  
   Page1.Title = "Page 1"  
   Page1.RootPanel.LoadLayout("1")  
   NavControl.ShowPage(Page1)  
   tn.Initialize("tn")  
End Sub  
  
Sub Page1_Click  
   tn.ShowNotification("This is the title", $"This is the body.  
And this is the second line."$, 3000)  
End Sub
```

  
There are various properties that you can change to change notification appearance.  
Note that there is no simulator binary included.  
  
Xcode 9 Swift framework is attached.  
Xcode 10: [www.b4x.com/b4i/files/Xcode10SwiftFrameworks.zip](https://www.b4x.com/b4i/files/Xcode10SwiftFrameworks.zip)