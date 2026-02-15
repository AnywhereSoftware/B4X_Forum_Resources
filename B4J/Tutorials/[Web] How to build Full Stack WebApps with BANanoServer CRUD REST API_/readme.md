### [Web] How to build Full Stack WebApps with BANanoServer CRUD REST API? by Mashiane
### 02/10/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/170275/)

Hi Fam  
  
[Download Source Code](https://github.com/Mashiane/SithasoDaisy5-BANanoServer-CRUD-REST-API)  
  
Step 1: In the files folder there is an address book sql file. Upload this to your MySQL db. You can [install MySQL](https://www.mysql.com/downloads/) for that. If you have phpMyAdmin, you can use that to import the file. If you want a hustle free setup, use [laragon](https://laragon.org/) (you dont need PHP for this and you dont need Apache either)  
Step 2: Update the config.properties file with your MySQL connection parameters.  
Step 3: This app has been built with [SithasoDaisy5](https://github.com/Mashiane/SithasoDaisy5) and [BANano](https://www.b4x.com/android/forum/threads/web-banano-website-app-pwa-library-with-abstract-designer-support.99740/#content), ensure you get these setup.  
Step 4: Ensure you are running  
  
![](https://www.b4x.com/android/forum/attachments/169844)  
  
Step 5: Ensure these libraries are ticked.  
  
![](https://www.b4x.com/android/forum/attachments/169845)  
  
Step 6: If all goes well, you should see this on your b4j ide console.  
  

```B4X
…..  
—————————————————-  
BANano v9.11: conversion finished!  
—————————————————-  
http://localhost:8080/addressbook/index.html  
2026-02-10 04:25:53.444:INFO :eek:ejs.Server:main: jetty-11.0.9; built: 2022-03-30T17:44:47.085Z; git: 243a48a658a183130a8c8de353178d154ca04f04; jvm 19.0.2+7-44  
2026-02-10 04:25:53.554:INFO :eek:ejss.DefaultSessionIdManager:main: Session workerName=node0  
2026-02-10 04:25:53.628:INFO :eek:ejsh.ContextHandler:main: Started o.e.j.s.ServletContextHandler@7586beff{/,file:///C:/b4j/workspace/SithasoDaisy5ServerRestApi/Objects/www/,AVAILABLE}  
2026-02-10 04:25:53.635:INFO :eek:ejs.RequestLogWriter:main: Opened C:\b4j\workspace\SithasoDaisy5ServerRestApi\Objects\logs\b4j-2026_02_10.request.log  
2026-02-10 04:25:53.795:INFO :eek:ejs.AbstractConnector:main: Started ServerConnector@4bb4de6a{HTTP/1.1, (http/1.1)}{0.0.0.0:8080}  
Checking database…  
DbHost: localhost  
DbName: addressbook  
DbPort: 3306  
User: root  
Password: root123!  
Checking database…  
DbHost: localhost  
DbName: addressbook  
DbPort: 3306  
User: root  
Password: root123!  
MYSQL database found!
```

  
  
#SharingTheGoodness  
  
  
[MEDIA=youtube]VbVPNC5rgdc[/MEDIA]