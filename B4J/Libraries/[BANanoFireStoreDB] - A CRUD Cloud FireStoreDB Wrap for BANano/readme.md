### [BANanoFireStoreDB] - A CRUD Cloud FireStoreDB Wrap for BANano by Mashiane
### 10/28/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/120739/)

Ola  
  
[Download](https://github.com/Mashiane/BANanoFireStoreDB)  
  
Yesterday I started playing around Google FireStore. This is things I learned. So, you need to log to the console and do the initial setup.  
  
There is a Realtime Database (FireBase) and there is a **Cloud FireStore.** This is about the latter.  
  
> Cloud Firestore is a flexible, scalable database for mobile, web, and server development from Firebase and Google Cloud Platform. Like Firebase Realtime Database, it keeps your data in sync across client apps through realtime listeners and offers offline support for mobile and web so you can build responsive apps that work regardless of network latency or Internet connectivity. Cloud Firestore also offers seamless integration with other Firebase and Google Cloud Platform products, including Cloud Functions.

  
**Here is a very simplified method of setting up firebase storage**  
  

- Go to firebase console
- click add project
- specify project name > Continue
- enable / disable google analytics > Continue / create project
- Your project Is ready > Continue
- Side Menu > Develop > Authentication
- Set up sign-in method
- Sign in method > Email/Password (click edit icon) > Enable > Save
- Side Menu > Develop > Cloud Firestore
- Create database
- Start in test mode > Next
- Select location > enable
- Side Menu > Project Overview > Project Settings
- Your apps > web
- Enter App NickName > Register App
- Add Firebase SDK = Connection settings (copy)
- Continue To console

  
  
**Step 1.**  
<https://firebase.google.com/docs/web/setup>  
  
[MEDIA=youtube]UFLvSp4Mh9k[/MEDIA]  
  
**Step 2.**   
Create your database. Ensure that you update your permissions as they are set to False (cannot read, cannot write). <https://firebase.google.com/docs/firestore/security/get-started#auth-required>  
  
More details: <https://firebase.google.com/docs/firestore/quickstart>  
  
**Step 3**  
Get your connection configuration data. This you will use on the attached library / class  
  
**Step 4**  
Create a collection. I have created a collection called **users** for my tests. This will be used for CRUDing around.  
  
**What has been done**  
  
1. CRUD  
1.1 Adding records to a collection.  
1.2. Updating an existing record in a collection  
1.3. Reading an existing record from a collection  
1.4. Reading all records from an existing collection  
1.5. Deleting a record from a collection.  
1.6. Work Offline with enablePerist…  
1.7. Real-time change detection (changes made by other users to the collection)  
  
**How was the Learning Curve?**  
  
Once you get around *BANano.RunMethod, BANano.GetField* and how these can be used with the JavaScript FireBase, all is well.  
  

- BANano.RunMethod is used to execute a function.
- BANano.GetField is like **map.get(?)**

  
Thing is FireBase uses a lot of dots (.) so its challenging to determine what is a field / function at times. It has been a trial and error exercise. For example…  
  

```B4X
'  
'get/read a record  
Sub CollectionGet(collection As String, colID As String) As BANanoPromise  
    'get the collection to add to  
    Dim promGet As BANanoPromise = firestore.RunMethod("collection", Array(collection)).RunMethod("doc", Array(colID)).RunMethod("get", Null)  
    Return promGet  
End Sub
```

  
  
#WatchThisSpace  
  
PS: I have attached the first tests here, this is WIP (work in progress) and more is being done to wrap an easy db functionality for CRUD.