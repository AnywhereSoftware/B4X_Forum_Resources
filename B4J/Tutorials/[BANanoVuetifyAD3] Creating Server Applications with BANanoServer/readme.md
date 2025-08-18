### [BANanoVuetifyAD3] Creating Server Applications with BANanoServer... by Mashiane
### 07/12/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/127104/)

Ola..  
  
**Update: 12 July 2021: Here is a working example with jRDC2 MySQL**  
<https://www.b4x.com/android/forum/threads/bananovuetifyad3-create-professional-looking-vuetify-websites-webapps-with-banano.124548/post-836444>  
  

**[SIZE=6]
> DO NOT USE THE APPROACH DISCUSSED HERE.

[/SIZE]**

  
  
**UPDATE 07 May 2021: Please note that this is currently experimental. Ran into some hurdles for now making this work well. Please DONT USE. I will keep you posted on developments.**  
  
[Join our Telegram Channel](https://t.me/bananovuematerial)  
  
An introduction…  
![](https://www.b4x.com/android/forum/attachments/107141)  
  
In a normal BANanoVuetifyAD3 app, we have BANano, on BANano\_Ready we can create our DB connections, create tables etc. We then initialize pgIndex which we use to build our app. Our app is built with one or more pages which are created via code modules which are then added as Routers i.e. pages / handlers via the AddRouter sub. After that we .Server our application.  
  
The back-end connections can be done directly from the pgIndex module and also via the other handlers we have and usually this is directl. Whether we use MSSQL, MySQL, BANanoSQL, SQLIte (the three via PHP), special classed for connectivity are built in within the framework which make seamless transition in terms of following the same methodology.  
  
On the other hand, BANanoServer i.e. jServer, works a differently.  
  
The recommended way to create BANanoVuetifyAD3 BANanoServer Apps, is the following:  
  
1. We have a BROWSERIndex module - this will act the same way as our pgIndex module however any database connections will be done via another code module.  
2. We have a SERVERIndex module - this will contain all B4J source code that we want to run on the server. All relevant B4J + Other libraries code is acceptable here.  
3. We have a SHARED??? module - this will contain both BANano + B4J code that we want to run wether on the BANano Front-end / BANanoServer backend.  
  
For the BANanoServer, the BROWSER?, SERVER? and SHARED? modules are mandatory for our implementation. You can read more from the BANanoServer documentation about this.  
  
BROWSER and SERVER are B4J "handlers". For BANanoVuetifyAD3, adding "handlers" i.e. routers, we will follow the same methodology we have been using. This is.  
  
1. The code we wrote on pgIndex, we now write on BROWSERIndex.  
2. We create routers i.e. handlers the same way we did before. We did this by creating a code module and then initialized this on the AddRouters sub in pgIndex. This sub will now be in BROWERIndex.  
3. Like before we .Server our app to run it.  
4. For our DB connections, we are not using PHP like before, but are using the SQL library, just like one would normally with an ABM application or any B4J app as conversations with the back-end are now directly via jServer.  
  
So what happens when one clicks a CRUD related button on the browser?  
  
PS: Please note the location of the BANanoServer library, copy it to your external libraries folder.  
  
![](https://www.b4x.com/android/forum/attachments/107185)