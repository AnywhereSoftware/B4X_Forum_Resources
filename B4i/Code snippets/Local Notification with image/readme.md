### Local Notification with image by Biswajit
### 05/11/2020
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/117627/)

```B4X
Public Sub CreateNotificationWithContent(Title As String, subTitle As String, Body As String, ImageURL As String, Identifier As String, Category As String, MillisecondsFromNow As Long)  
    Dim ln As NativeObject  
    ln = ln.Initialize("UNMutableNotificationContent").RunMethod("new", Null)  
    ln.SetField("title", Title)  
    If subTitle <> "" Then ln.SetField("subtitle", subTitle)  
  
  
    If ImageURL <> "" Then  
        Dim imageNSURL As NativeObject  
        imageNSURL = imageNSURL.Initialize("NSURL").RunMethod("fileURLWithPath:",Array(ImageURL))  
        Dim attachment As NativeObject = Me  
        ln.SetField("attachments", attachment.RunMethod("createAttachment:",Array(imageNSURL)))  
    End If  
  
  
    ln.SetField("body", Body)  
    Dim n As NativeObject  
    ln.SetField("sound", n.Initialize("UNNotificationSound").RunMethod("defaultSound", Null))  
    If Category <> "" Then ln.SetField("categoryIdentifier", Category)  
    Dim trigger As NativeObject  
    trigger = trigger.Initialize("UNTimeIntervalNotificationTrigger").RunMethod("triggerWithTimeInterval:repeats:", Array(MillisecondsFromNow / 1000, False))  
    Dim request As NativeObject  
    request = request.Initialize("UNNotificationRequest").RunMethod("requestWithIdentifier:content:trigger:", _  
       Array(Identifier, ln, trigger))  
    Dim NotificationCenter As NativeObject  
    NotificationCenter = NotificationCenter.Initialize("UNUserNotificationCenter").RunMethod("currentNotificationCenter", Null)  
    NotificationCenter.RunMethod("addNotificationRequest:", Array(request))  
End Sub  
  
#if OBJC  
-(NSArray *) createAttachment: (NSURL *)imgurl{  
    NSError *error = nil;  
    UNNotificationAttachment *attachment;  
    attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageID"  
                                                          URL:imgurl  
                                                      options:nil  
                                                        error:&error];  
    NSArray *arr = @[attachment];  
    return arr;  
}  
  
#import <UserNotifications/UserNotifications.h>  
@end  
@interface b4i_main (notification) <UNUserNotificationCenterDelegate>  
@end  
@implementation b4i_main (notification)  
- (void)userNotificationCenter:(UNUserNotificationCenter *)center  
       willPresentNotification:(UNNotification *)notification  
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {  
        completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound );  
   }  
    
  
#End If
```

  
  
Usage:  

```B4X
CreateNotificationWithContent("title","sub title","body text",File.Combine(File.DirLibrary,"imgname.jpg"),"id1","cat1",1000)
```

  
  
**NOTE:** The system validates the content of attached files before scheduling the corresponding notification request. If an attached file is corrupted, invalid, or of an unsupported file type, the notification request is not scheduled for delivery. Once validated, attached files are moved into the attachment data store so that they can be accessed by the appropriate processes. Attachments located inside an app’s bundle are copied instead of moved.