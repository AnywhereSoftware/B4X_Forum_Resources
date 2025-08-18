###  [B4XPages] FirebasePush + FirebaseAuth by Star-Dust
### 09/18/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/122477/)

Today for the first time, I started messing with B4XPages and Firebase. Even though I had already watched B4XPages, I hadn't fumbled to understand better.  
The hardest thing was Firebase, configuration and settings, especially with iOS. (Traumatic , certificates, profiles, keys ….)  
  
***I noticed that a B4XPages example for firebaseAuth is missing and it is not easy to adapt.***  
  
I thought of adapting FirebaseMessager instead of sending a message to users from the developer (as an advertisement or notification) I wanted to create an app that the user could send a message and all other users would receive it. A kind of chat .  
This also required the ability to authenticate to identify who is sending the message … here is the result.  
  
**I hope it will be useful to someone**  
  
**NB**. In order to send messages you must insert the **Server\_Key** that you get in the Firebase site.  
For ios: the specific ProvisionFile must be created. For authentication you need to get the #UrlScheme. Copy the GoogleService-Info.plist file to the special folder  
For Andoird: Copy the google-services.JSON file to the project folder.  
  
**PS.** I based the code on the following sources, If you have any questions, check all the links indicated where everything is described in detail step by step. *Don't ask me questions, I know as much as you do and maybe a little less about Firebase or B4XPAGES*  
<https://www.b4x.com/android/forum/threads/firebaseauth-authenticate-your-users.67875/>  
<https://www.b4x.com/android/forum/threads/firebaseauth-authenticate-your-users-google-facebook.68625/>  
<https://www.b4x.com/android/forum/threads/b4x-b4xpages-firebase-push-example.120523/>  
  
![](https://www.b4x.com/android/forum/attachments/100204) ![](https://www.b4x.com/android/forum/attachments/100207) ![](https://www.b4x.com/android/forum/attachments/100208)