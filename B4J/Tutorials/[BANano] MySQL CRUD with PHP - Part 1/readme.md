### [BANano] MySQL CRUD with PHP - Part 1 by Mashiane
### 05/19/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/104622/)

Ola  
  
**UPDATE 2020-05-19:** [**Please use this library instead**](https://www.b4x.com/android/forum/threads/bananoconnect-bananosql-sqlite-mysql-mssql-library.117956/)  
  
[[BANAno] MySQL CRUD with PHP - Part 2](https://www.b4x.com/android/forum/threads/banano-mysql-crud-with-php-part-2.104635/#post-655602)  
  
Well, the [Business College](https://www.b4x.com/android/forum/threads/websites-developing-my-banano-based-website-with-free-hosting.104448/#post-654533) website I'm creating has a portion of where the potential students need to register online. The data needs to be stored in a MySQL database. I intend to use various php files that should be sitting on a webserver so the inline php option in BANano for me is kinda out.  
  
[MEDIA=youtube]yhM0MdUsCCI[/MEDIA]  
  
A couple of weeks ago, I features a thread here about [mysql data to webview](https://www.b4x.com/android/forum/threads/mysql-data-to-webview-using-php.104274/). This was nothing more that showing how I perform crud functionality to mysql database directly from an android application. In it I showed how one can create the db, use a php file and httputils to call the php scripts and return these as json strings to an android app.  
  
This thread is a port of that android app, but specifically for BANano. I will not recap how to create the db here and all the setup that needs to be done, you can read from that thread. Here however we are not using BlueStacks, just xamp.  
  
For this to work, one needs to initialize their BANano project as "BANano" so that its BANano\_Ready, as of writing, anything else did not work with CallAjax. This might change in the future. #WishIKnew.  
  
The users.php file to be used for the execution should be added on your Files tab. You can create all your php files and then add them to the files tab. These will be saved to the assets folder of your project.  
  
My project name is **AJAX** and I will be calling the php scripts from the assets folder.  
  
So I define a global variable to store the path of my scripts.  
  

```B4X
Public PhpPath As String = $"http://127.0.0.1/AJAX/assets/"$
```

  
  
Im just adding a few controls to demo this, so basic html5 without the make-up will do.  
  

```B4X
Sub Init()  
    banano.GetElement("#body").Empty  
    banano.GetElement("#body").Append($"<input id="txtusername" type="text" placeholder="User Name"></input><br><br>"$)  
    banano.GetElement("#body").Append($"<input id="txtpassword" type="password" placeholder="Password"></input><br><br>"$)  
    banano.GetElement("#body").Append($"<button id="btnlogin">LOGIN</button><br><br>"$)  
    banano.GetElement("#body").Append($"<button id="btnloginw">LOGIN WAIT</button><br><br>"$)  
    banano.GetElement("#body").Append($"<button id="btnregister">REGISTER</button><br><br>"$)  
  
    banano.GetElement("#btnlogin").On("click", Me, "login")  
    banano.GetElement("#btnloginw").On("click", Me, "loginw")  
    banano.GetElement("#btnregister").On("click", Me, "register")  
End Sub
```