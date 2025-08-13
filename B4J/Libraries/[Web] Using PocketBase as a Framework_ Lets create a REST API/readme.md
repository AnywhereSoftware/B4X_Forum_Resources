### [Web] Using PocketBase as a Framework: Lets create a REST API by Mashiane
### 11/07/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/157273/)

Ola.  
  
Its amazing with the latest version of PocketBase one can extend it with JavaScript / Go.  
  
So I tested creating some REST API handlers. You can unzip the attached file to your pocketbase folder. It should create a **pb\_hooks** folder. You can then call the handler via the browser after starting your server.  
  
![](https://www.b4x.com/android/forum/attachments/147582)  
  
It seems one can also do direct DB calls with this. A lot to be explored.  
  
This is the simple code on the created js file.  
  

```B4X
routerAdd("GET", "/api/hello/:name", © => {      
let name = c.pathParam("name")      
return c.json(200, { "message": "Hello " + name })  
 }
```

  
  
Enjoy!