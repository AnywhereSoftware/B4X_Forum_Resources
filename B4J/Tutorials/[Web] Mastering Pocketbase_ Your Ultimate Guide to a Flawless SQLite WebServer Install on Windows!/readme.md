### [Web] Mastering Pocketbase: Your Ultimate Guide to a Flawless SQLite WebServer Install on Windows! by Mashiane
### 06/06/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/161538/)

Hi Fam  
  
[Download](https://github.com/Mashiane/PocketBaseInstall)  
  
[PocketBase](https://pocketbase.io/) is a SQLite Webserver with some powerful functionality. Whilst it provides functionality to be a database, it also has a nice UI to manage that database. You can host it locally and also run it on a VPS. It does not support shared hosting.  
  
1. Download and unzip this repo (15MB), this is what you will find.  
  
![](https://www.b4x.com/android/forum/attachments/154408)  
  
2. Double click the run\_server\_1001.bat file, this will start a command prompt.  
  
![](https://www.b4x.com/android/forum/attachments/154410)  
  
3. Leave this running. If there is an update of pocketbase, it will be updated before your app can start.  
4. sdbms is the sub-domain of our web site. We publish all our js & css and html files there. You can rename the file to be anything you want. This sub-domain is inside the **pb\_public**  
  
![](https://www.b4x.com/android/forum/attachments/154411)  
  
5. If you don't use a sub-domain, just publish your website on the root of the pb\_public folder. Ensure you also update the bat file to point to.  
  

```B4X
start http://127.0.0.1:1001/index.html
```

  
  
6. As there is no website published on this webserver, nothing will be shown in the browser, you will see. This means there is no database collections and no website.  
  
![](https://www.b4x.com/android/forum/attachments/154412)  
7. Now double click the "PocketBase Admin" browser link. You should see this.  
  
![](https://www.b4x.com/android/forum/attachments/154413)  
  
8. Create your administrator account. When done, you should see this.  
  
![](https://www.b4x.com/android/forum/attachments/154414)  
  
9. Now you need to update a few things, click Settings..  
  
![](https://www.b4x.com/android/forum/attachments/154415)  
  
10. Update the Application and Application url. Always ensure that the Application URL is correct and it reflects the port you are running from also. The Application name will be changed on the browser tab.  
  
![](https://www.b4x.com/android/forum/attachments/154416)  
  
![](https://www.b4x.com/android/forum/attachments/154417)  
  
11. You can also update the mail settings by using SMTP. This will help you send emails via PocketBase, reset your password and send password forgot resets in case. Its important to set this should you forget your password and other things.  
  
![](https://www.b4x.com/android/forum/attachments/154418)  
  
Follow [this guide](https://github.com/pocketbase/pocketbase/discussions/458#discussioncomment-3651995) to use a **GMail** account to send emails inside PocketBase.  
  
You can play around and visit the [documentation](https://pocketbase.io/docs/) for more details.  
  
**Using it with B4J?** Check this link, <https://www.b4x.com/android/forum/threads/pocketbase-crud-rest-api-sse-with-postman-and-then-httputils.144227/#content>  
  
***Using any other port besides 1001.***  
  
Let's say you want to use port 1002, this is the guide. Close any running instance of 1001.  
  
1. Rename run\_server\_1001.bat to run\_server\_1002.bat  
2. Edit run\_server\_1001.bat and update it to be  
  

```B4X
start http://127.0.0.1:1002/sdbms/index.html  
pocketbase update  
pocketbase serve –http="127.0.0.1:1002"  
pause
```

  
  
3. Save the file  
4. Right click on the "PocketBase Admin" file, then Properties,change the URL to be  
  
![](https://www.b4x.com/android/forum/attachments/154409)  
 5. Click Apply for the changes to take effect.  
  
Have fun!  
  
**Related Content (e.g how to use GMail for sending emails, reasons why you can use it as your backend)**  
  
<https://www.b4x.com/android/forum/threads/banano-using-pocketbase-firebase-alternative-for-your-apps.143589/#content>  
  
[Forum Search of PocketBase](https://www.b4x.com/android/forum/pages/results/?query=pocketbase)