### SithasoDaisy: PocketHost vs PocketBase (What is the difference?) by Mashiane
### 06/10/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/148439/)

Ola  
  
I think its time I explain what this is. Perhaps let me clear out some qualifiers. Both these words start with Pocket, one ends with **Host** and the other ends with **Base**.  
  
Host = Hosting Company with many instances of PocketBase  
Base = A Database just like MySQL, FireBase , SupaBase etc.  
  
**PocketBase** is a **SQLite WebServer** that you can run on your VPS. You can publish your webapp inside it and also from the webapp access the back-end database. It works like FireBase and also has SSE (Server Side Events). You can see this [Chat](https://www.b4x.com/android/forum/threads/sithasodaisy-tailwindcss-pocketbase-chatroom-using-sse.144720/#content) example we did. ***It is awesome and fast!***  
  
![](https://www.b4x.com/android/forum/attachments/142837)  
  
You can use PocketBase with your B4J applications. I explained how to use HttpUtils with it on this thread below.  
  
<https://www.b4x.com/android/forum/threads/pocketbase-crud-rest-api-sse-with-postman-and-then-httputils.144227/#content>  
  
There is an attempt to run both a webapp (BANanoServe) i.e jetty webserver + PocketBase back-end on a VPS machine here. This does not need any PHP.  
  
<https://www.b4x.com/android/forum/threads/sithasodaisy-crud-webapp-on-java-jetty-webserver-with-pocketbase-back-end-hosted-on-pockethost-io.147680/#content.>  
  
**PocketHost** on the other hand is a SAAS company that hosts instances of PocketBase back-ends. For testing your PocketBase hosted apps online this is cool, however using this type of functionality is not recommended for production use. Its shared hosting, no paid plans as yet.  
  
**\*\*\*\* Best Approach \*\*\*\***  
  
Using this company (PocketHost) currently for production based apps is a no go area, thus my disclaimers. It is better just to have your own version of PocketBase running on your own VPS and you will never turn back.  
  
![](https://www.b4x.com/android/forum/attachments/142836)  
  
So, its 2 different things (…Host = Company and …Base = Database).  
  
Happy Coding!