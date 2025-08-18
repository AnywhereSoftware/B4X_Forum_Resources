### Show an image in remote/push notification by Biswajit
### 08/22/2020
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/121424/)

**Mac, Local Build Server, and Xcode are needed.**  
  
Now you can show an image in push notification just like android.  
  
Usually in ios, the system handles the push notification. But there is an app extension called **Notification Service Extention** which allows you to modify the notification content. By default, this cannot be done from B4i itself. Check the following tutorial to show an image notification.  
  
**NOTE:** In this tutorial, NSE means Notification Service Extension  
  
**[SIZE=5]Requirements:[/SIZE]**  
> 1. Mac OS
> 2. Local Build Server
> 3. Xcode (latest preferred)
> 4. Access to Apple Developer Account
> 5. A real device for testing (optional)
> 6. Patience!

  
**[SIZE=5]Limitations:[/SIZE]**  
> 1. Device must be on iOS 10+
> 2. Images in iOS 12 Rich Push Notifications will only display in two ratios, 1:1 and 3:2. If the width:height ratio of an image doesn't fit these guidelines, the image will be trimmed from the center to match one of the accepted ratios.
> 3. If your extension takes too long to perform its work, it will be notified and immediately terminated. And the default notification will be displayed to the user. **So try to use a compressed image.**

  
**[SIZE=5]Create App ID and Provisioning Profile: [/SIZE]**  
> NSE (Notification Service Extension) has its own bundle id, it must be set up with its own App ID and provisioning profile.  
>
> 1. Login to apple developer account
> 2. [Create an App ID](https://developer.apple.com/account/resources/identifiers/list)for NSE
>
> 1. Select: **App IDs**
> 2. Select type: **App**
> 3. Enter description
> 4. Enter bundle id (Must be Explicit. Not Wildcard)
> **If your app bundle id is com.example.app then the NSE bundle id must be com.example.app.xNotification**5. Scroll down and select **Push Notification** from Capabilities (No need to configure)
> 6. Register
>
> 3. [Create a provisioning profile](https://developer.apple.com/account/resources/profiles/list)for NSE
>
> 1. Select: **Ad Hoc** (for testing)
> Select: **App Store** (for uploading)2. Select the NSE App ID (**com.example.app.xNotification**) from the dropdown list.
> 3. Generate and Download

**[SIZE=5]Setup B4i Project for NSE:[/SIZE]**  
> If you haven't setup the firebase push notification yet then [follow this tutorial](https://www.b4x.com/android/forum/threads/firebasenotifications-push-messages-server-not-required.68645/)  
> After integrating firebase push notification,  
>
> ```B4X
> App.RegisterUserNotifications(True, True, True) '<- After this  
>    
> Dim NotificationCenter As NativeObject  
> NotificationCenter = NotificationCenter.Initialize("UNUserNotificationCenter").RunMethod("currentNotificationCenter", Null)  
> NotificationCenter.SetField("delegate", Me)  
>   
> App.RegisterForRemoteNotifications '<- Before this
> ```
>
>   
>   
>
> ```B4X
> #if OBJC  
> #import <UserNotifications/UserNotifications.h>  
> @end  
> @interface b4i_main (notification) <UNUserNotificationCenterDelegate>  
> @end  
> @implementation b4i_main (notification)  
> - (void)userNotificationCenter:(UNUserNotificationCenter *)center  
>        willPresentNotification:(UNNotification *)notification  
>          withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {  
>         completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound );  
>    }  
> #End If
> ```

**[SIZE=5]Add NSE to your B4i Project:[/SIZE]**  
> 1. Build the **release app** from B4i. (For a real device not for the simulator)
> 2. Go to **Local Build Server Folder** > **UploadedProjects** > **your\_username**
> 3. Open **b4iproject.xcodeproj**
> 4. Change **Build Settings** > **Architecture** > **Standard Architecture**
> 5. Select app provisioning profile from **Signing & Capabilities**
>
> 1. If Signing Certificate shows **none** after selecting provisioning profile
> 2. Click on automatic manage signing
> 3. Click Enable automatic
> 4. Untick automatic manage signing
> 5. Now choose provisioning profile
>
> 6. From top navigation click on, File > New > Target > **Notification Service Extension**
>
> 1. Enter name: **xNotification** (Or something you want. Must match the NSE App ID)
> 2. Team: **none**
> 3. Organization: **blank**/as you want
> 4. Click on Finish > Activate
>
> 7. Turn off automatic manage signing
> 8. Choose NSE provisioning profile from **Signing & Capabilities**
>
> 1. If not listed choose import > then select the downloaded provisioning profile
>
> 9. Change **Build Settings** > **Architecture** > **Standard Architecture**
> 10. Change **General > Deployment info > Target : iOS 10**
> 11. Above the deployment info, set the **Version & Build** number the same as your project. (**Important**)
> 12. Now check the left sidebar of xcode.
> 13. Expand **xNotification** folder.
> 14. Open **NotificationService.m** file.
> 15. Copy the whole content of the attached **NotificationService.txt** file
> 16. For testing
>
> 1. Connect your real device
> 2. Click on the **xNotification**(E icon) from the top left corner and select **B4iProject**
> 3. Beside that select your device
> 4. Click on **Play** button at the top left corner
> ![](https://www.b4x.com/android/forum/attachments/98836)
> 17. For uploading
>
> 1. Click on the **xNotification**(E icon) from the top left corner and select **B4iProject**
> 2. Beside that select Generic iOS device
> ![](https://www.b4x.com/android/forum/attachments/98837)3. From top navigation click on, Product > **Archive**
> 4. After completion, a new window will popup
>
> 1. Select the latest build from the list
> 2. Now on the right side click on **Validate** > follow the steps
> 3. After completion click on **Distribute** button > Don't change any options just follow the steps

**[SIZE=5]Notification Payload Structure:[/SIZE]**  
> ```B4X
> [  
>     'priority'=>'high',  
>     "content_available"=> true, //required  
>     "mutable_content"=> true, //required  
>     'to' => '/topics/<your_topic_name>',  
>     "notification" => [  
>         'subText' => "Sub title",  
>         'title' => "Title",  
>         'body' => "Body text"  
>         'sound' => 'default',  
>         'badge' => '0'  
>     ],  
>     'data' => [  
>         'type' => 'text/image',  
>         'attachment-url' => "https://example.com/secure-image-url", //must be a secure url (https)  
>     ]  
> ];
> ```
>
>   
>
> ```B4X
> $fcmUrl = 'https://fcm.googleapis.com/fcm/send';  
> $apikey = 'xxx';  
>   
> $fcmNotification = [  
>     'priority'=>'high',  
>     "content_available"=> true,  
>     "mutable_content"=> true,  
>     'to' => '/topics/<your_topic_name>',  
>     "notification" => [  
>         'subText' => "Sub title",  
>         'title' => "Title",  
>         'body' => "Body text"  
>         'sound' => 'default',  
>         'badge' => '0'  
>     ],  
>     'data' => [  
>         'type' => 'text/image',  
>         'attachment-url' => "https://example.com/secure-image-url", //must be a secure url (https)  
>     ]  
> ];  
>   
> $headers = ['Authorization: key=' . $apikey, 'Content-Type: application/json'];  
>   
> $ch = curl_init();  
> curl_setopt($ch, CURLOPT_URL,$fcmUrl);  
> curl_setopt($ch, CURLOPT_POST, true);  
> curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);  
> curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);  
> curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);  
> curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fcmNotification));  
> $result = curl_exec($ch);  
> curl_close($ch);
> ```

  
**Remember:** On new release build B4i will clear the project folder. So you have to add the NSE to your B4i project for each and every release build.