### Firebase Integration by Erel
### 06/26/2023
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/68623/)

B4i v2.80 adds support for Firebase backend: <https://firebase.google.com>  
  
The libraries are mostly the same as the B4A Firebase libraries.  
  
**Configuration**  
  
1. Create an iOS application in Firebase console. Make sure that the bundle id is the same as your app package name.  
2. Download GoogleService-info.plist from the console and copy it to Files\Special.  
3. Declare a process global FirebaseAnalytics object and initialize it in Application\_Start. FirebaseAnalytics is the base of all Firebase services. The analytics object should be initialized before any other Firebase object (even if you don't need the analytics service).  
  
The following services are currently supported:  
  
FirebaseAnalytics, FirebaseAuth (Google + Facebook), FirebaseStorage and FirebaseNotifications (push messages).  
  
Latest version: <https://www.b4x.com/android/forum/threads/firebase-admob-v3-00.144798/#content>  
  
Firebase requires iOS 10+.