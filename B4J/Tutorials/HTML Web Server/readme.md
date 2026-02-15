### HTML Web Server by aeric
### 02/13/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/170306/)

[HEADING=1]Chapter 1: Introduction[/HEADING]  
The minimum code that we need to create a server is as following:  

```B4X
Sub Process_Globals  
    Public srvr As Server  
End Sub  
  
Sub AppStart (Args() As String)  
    srvr.Initialize("")  
    srvr.Start  
    StartMessageLoop  
End Sub
```

  
  
The default server port is 8080 if we don't specify it explicitly.  
To change the port, use the following code:  

```B4X
srvr.Port = 80
```

  
  
Use HttpsFilter to redirect the server to SSL port.  
We need to add the following code"  

```B4X
srvr.AddFilter("/*", "HttpsFilter", False)
```

  
  
[HEADING=1]Chapter 2: Serving Static Files[/HEADING]  
By default, jServer will read any files inside www folder even you didn't specify the directory.  
The server will treat this directory as the assets directory for your static or dynamic website.  
  
Inside www folder, you can put your:  

- HTML files (e.g index.html)
- Stylesheets, JavaScripts, Images files (e.g styles.css, app.js and icon.png)

Putting html file inside www directory allows client side access it using the full file extension.  
For example, if you put an about.html inside www directory, you can access it using http://<domain root>/about.html  
Accessing index.html is same as accessing the root path http://<domain root>/  
Unless you set the server handler to manage this default behavior.  
You can organize your files with sub folders inside www directory and the files with be served following the files system structure.  
  
Example:  
Physical files path: /home/myusername/myserverapp/www/images/icon.png (Linux) or C:\MyB4JProjects\MyServerApp\www\images\icon.png (Windows)  
Public server path: http://<domain root>/images/icon.png  
  
[HEADING=1]Chapter 3: Distribute to Production[/HEADING]  
Once we have compiled our project in released mode, upload the **www directory** together with the **server.jar** from **Objects** folder to the remote server.  
  
![](https://www.b4x.com/android/forum/attachments/169903)  
To run the server on a Linux VPS, we can use nohup command e.g:  

```B4X
nohup /usr/bin/java -jar server.jar > debug.txt &
```

  
  
[HEADING=1]Chapter 4: Serving Dynamic Contents[/HEADING]  
If we want to build a server that serve dynamic contents, we can use ServletResponse.Write to output the contents.  
The contents type can be html, json, xml, or other media files.  
  
We can use a server handler to serve a page to the client at the public path: e.g: http://<domain root>/products  
We need to add the following code in AppStart:  

```B4X
srvr.AddHandler("/products", "ProductsHandler", False)
```

  
  
Put our html files inside our project's "Files" folder during development.  
These html files will be treated as our templates.  
Read the contents using Files.ReadString.  

```B4X
Dim Contents As String = File.ReadString(File.DirAssets, "products.html")
```

  
Remember that files put inside "Files" folder will be compiled into the jar file.  
  
Let say we have the following line in our products.html file.  

```B4X
<h3 class="success">I bought some $PRODUCT$!</h3>
```

  
The placeholder string can be replaced or serve from database queries.  

```B4X
Sub Class_Globals  
    Private Response As ServletResponse  
End Sub  
  
Public Sub Initialize  
   
End Sub  
  
Sub Handle (req As ServletRequest, resp As ServletResponse)  
    Response = resp  
    Response.ContentType = "text/html"  
   
    RenderProductsPage  
End Sub  
  
Sub RenderProductsPage  
    Dim Contents As String = File.ReadString(File.DirAssets, "products.html")  
    Contents = Contents.Replace("$PRODUCT$", "oranges")  
   
    Response.Write(Contents)  
End Sub
```

  
  
I attached a minimum test server project here to demonstrate some different implementation of a "static" and "dynamic" contents.  
  
References:  
<https://www.b4x.com/android/forum/threads/server-building-web-servers-with-b4j.37172/>  
<https://www.b4x.com/android/forum/threads/server-run-a-server-on-a-vps.60378/>  
  
If you are already familiar building web servers using B4J, consider to use the libraries and framework developed by me.  
I hope they can simplify your development work.  

- [Pakai Server](https://www.b4x.com/android/forum/threads/web-project-template-pakai-server-v6.169224/)
- [EndsMeet](https://www.b4x.com/android/forum/threads/web-server-endsmeet-v1-80.167395/)
- [MiniHTML](https://www.b4x.com/android/forum/threads/b4x-web-minihtml2.170180/)
- [MiniCSS](https://www.b4x.com/android/forum/threads/b4x-web-minicss.170299/)
- [MiniJS](https://www.b4x.com/android/forum/threads/b4x-web-minijs.169204/)
- [MiniORMUtils](https://www.b4x.com/android/forum/threads/b4x-miniormutils.166030/)