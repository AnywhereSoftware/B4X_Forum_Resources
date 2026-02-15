###  Firebase Push Notifications 2023+ by Erel
### 02/11/2026
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/148715/)

Google has deprecated the previous method of sending push notifications. It will stop working on June 2024.  
If you have an already working solution then you only need to update the B4J side. Do make sure that you switched from the service to a receiver on B4A.  
The new API is (confusingly) named FCM API v1.  
  
**B4J**  
  
1. Make sure that the new API is enabled as shown in this screenshot:  
  
![](https://www.b4x.com/android/forum/attachments/143221)  
  
2. Project settings - Service accounts - Generate new private sign key. The browser will download a json file. This file includes a private key that gives access to your firebase account. Keep it secured.  
This file is used by the sending tool.  
3. Find the project id under the General tab.  
4. Download the dependencies and unpack in **B4J** additional libraries folder: <https://www.b4x.com/b4j/files/b4j-push-deps.zip>  
5. Download B4J-SendingTool.zip. Update ProjectId and ServiceAccountFilePath. It will not work properly unless you using the B4J tool to send the messages.  
  
**B4A**  
  
1. Follow the generic Firebase integration tutorial: <https://www.b4x.com/android/forum/threads/integrating-firebase-services.67692/>  
Download google-services.json and put it in the project folder.  
2. See the attached project.  
3. The notification is created in FirebaseMessaging receiver. Note that in debug mode, it will only work while the app is running.  
  
**B4i**  
  
1. Follow the configuration instructions: <https://www.b4x.com/android/forum/threads/firebasenotifications-push-messages-server-not-required.68645/#content> (ignore the code references).  
2. Download the attached project. Note the two subs added there (RemoteNotification and PushToken).  
  
**Notes**  
  
1. In iOS the notification popup only appears while the app is not in the foreground. You can UserNotificationCenter to change this behavior (search and you will find).  
2. FirebaseMessaging module isn't shared between the two projects. It is different in B4A and B4i.  
3. The message payload can be customized in many ways. API reference: <https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages>  
  
**Updates**  
  
- (PushClients) Topics subscription in B4i is done after the APN token is available. Note the updated code in Main.Application\_PushToken. It looks like a new requirement in the updated Firebase SDK.