### FirebaseStorage - Simple file storage backend by Erel
### 09/14/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/68350/)

FirebaseStorage service is similar to a FTP server. Clients can upload and download files.  
FirebaseStorage takes it a step further and adds an authorization layer.  
  
Google are offering a free package and a paid package: <https://firebase.google.com/pricing/>  
The free offer is quite generous.  
  
FirebaseStorage works together with FirebaseAuth for the access control.  
  
The rules are set in Firebase console. I recommend to start with these rules (make sure to update the service in the second line based on your app id):  

```B4X
service firebase.storage {  
  match /b/b4a-test1.appspot.com/o {  
  match /auth/{allPaths=**} {  
     allow read, write: if request.auth != null;  
   }  
  match /public/{allPaths=**} {  
  allow read;  
  }  
  match /user/{userId}/{allPaths=**} {  
  allow read, write: if request.auth.uid == userId;  
  }  
  
  }  
}
```

  
  
With these rules there are three accessible folders with the following access levels:  
*/public* - Anyone can read from this folder. You can upload files to this folder from the console. This is a good place for any general files (images, data sets). Note that these files can be accessed from outside your app.  
*/auth* - All authenticated users can read and write to this folder. Resources limited to the app users.  
*/user/{userId}* - Only the user can access this folder. User's private resources.  
Subfolders will have the same access control as their parent folders.  
  
**Setup instructions**  
  
Follow the Firebase integration instructions: <https://www.b4x.com/android/forum/threads/integrating-firebase-services.67692/#content>  
Add the Auth snippet as well as the base snippets.  
  
The code is simple. You need to initialize FirebaseStorage, preferably from the Starter service, with your bucket url. You can find it in Firebase console (gs://…):  
  
![](https://www.b4x.com/basic4android/images/SS-2016-06-26_14.56.07.png)  
  
You can now upload and download files and also get the available metadata.  
All the methods are asynchronous which means that an event is raised when the operation completes. The events will be raised in the same module that started the operation.  
  
Note that you can use FirebaseStorage without FirebaseAuth and then use it to download files from the public folder.