### [BANanoFireStoreDB] Creating a Chat application by Mashiane
### 10/28/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/122048/)

Ola  
  
[Download](https://github.com/Mashiane/BANanoVuetify/tree/master/4.%20Examples/25.%20Friendly%20Chat)  
  
We are attempting to create a chat application using BANanoFireStoreDB and BANanoVueMaterial.  
  
What you will need:  
  
1. [BANanoFireStoreDB](https://github.com/Mashiane/BANanoFireStoreDB)  
2. [BANanoVueMaterial](https://github.com/Mashiane/BANanoVuetify)  
  
**What will you learn?**  
  
1. Using BANanoPromise  
2. Using Firebase FireStore (CRUD & Filtering records)  
3. Using Firebase FireStore (Saving files and getting downloadURLs)  
4. Firebase Realtime  
5. Firebase Authentication - sign up / sign in.  
  
**First you need to set up firebase: Here is a very simplified process**  
  

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

  
**Part 1 - Reproduction**   
  
1. Create a collection on your firestore called **messages**. It will have these field names, (a) name, (b) text, © profilepicurl and (d) timestamp.  
2. Get your firestore connection settings which will be used when connecting to your firestore.  
3. A navbar is created with an avatar, a title and a sign in/sign out buttons. These two buttons show depending on the signed in state.  
4. If the user is signed out, the message list is cleared and when signed in, all messages are displayed that exist in the database.  
5. As we are using components and routers, we are using .SetDataGlobal & .GetDataGlobal, these ensure that our state is shared all over our applications.  
6. We use .SetMethod to register our subs and .CallMethod / .RunMethod to call them to execute.  
7. We use a filter to select the first 10 records from our collection ordered by the timestamp DESC.  
  
[MEDIA=youtube]osO7PHQA0RI[/MEDIA]