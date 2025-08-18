### [BANano] (v7) New object BANanoRouter by alwaysbusy
### 09/24/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/134545/)

BANanoRouter is a full blown Router with paths that will be standard included in the next release of BANano. It allows you to better organize your code in a PWA/SPA WebApp. It is based on the Navigo project, tuned for B4J.  
  
**[FONT=arial]What is a Javascript Router?[/FONT]**  
A Javascript router is a key component in many frontend frameworks (e.g. Angular, Vue, …). It is the piece of software in charge to organize the states of the application, switching between different views. For example, the router will render the login screen initially, and when the login is successfull it will perform the transition to the user’s welcome screen.  
  
So 'logically', you web app could be something like:  
App  
— Page1  
— Page2  
— Page3  
  
Every page will have its own path, with its own variables and query parameters. The router is build so the URL in the navigation bar of the browser does not change. However, it one can still call a certain page with certain parameters by entering it in the navigation bar if one wants to.  
  
**HOW IT WORKS:**  
We can add a new 'page' from the menu:  
![](https://www.b4x.com/android/forum/attachments/119537)  
  
Result:  

```B4X
'This class is router page template class  
Sub Class_Globals  
    Private BANano As BANano 'ignore  
          
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize()  
      
End Sub  
  
' router path /testPage1  
Sub BANano_RouterHandle(url As String, data As Map, params As Map)  
    Log(url)  
    Log(data)  
    Log(params)  
      
    ' navigating to some other page  
    ' Main.router.Navigate("/testPage2/carine/?id=10&lastName=Bailleul")  
End Sub  
  
Sub BANano_RouterLeaving() As Boolean  
    Log("Do some checks…")  
      
    Return True ' (Or False If the navigation from this page Is Not allowed)  
End Sub
```

  
  
It contains two special methods:  

```B4X
BANano_RouterHandle(url As String, data As Map, params As Map)
```

  
  
In this method you can do all your nice BANano stuff (like loading a Layout, getting data from your database etc)  
  
The second method is:  

```B4X
BANano_RouterLeaving() As Boolean
```

  
  
This method is optional, and allows you to e.g. do some checks (is every field filled in?) before someone can leave the page and navigate to another one. If it returns True then it will go further, if False it will not.  
  
**Setting Up your routes:**  
Add a BANanoRouter to the Globals\_Class of your Main:  

```B4X
Public router As BANanoRouter
```

  
  
In BANano\_Ready():  
  
1. Initialize the router  
rootPath: the root path of your application. For example, if you are hosting the application at <https://site.com/my/project> you have to specify the following:  
matchAll: default false, meaning that when a match is found the router stops resolving other routes. If set true, it will continue searching for other matches  
 e.g. Router.AddRoute("/foo/:id/?", "FooClass") matches "/foo/20/save" and also "/foo/20"  

```B4X
router.Initialize("/",False)
```

  
  
2. Now we can add our routes, for example:  

```B4X
router.AddRoute("/testPage1", "Page1", Array("Something extra")) ' here our initalize method in our page requires an extra parameter  
router.AddRoute("/testPage2/:name", "Page2", Null) ' e.g. handle /testPage2/carine (carine will be in the Data map in BANano_RouterHandle of Page2)  
router.AddRoute("/testPage3/:name/test", "Page3", Null) ' e.g. handles /testPage2/alain/test,  /testPage2/jos/test (alain or jos will be in the Data map in BANano_RouterHandle of Page3)
```

  
  
Some more advanced examples of paths:  

```B4X
Router.AddRoute(":page", "FooClass")  
 - matches "/about-page"  
  
Router.AddRoute("/foo/*", "FooClass")  
 - matches "/foo/a/b/c"  
    
 Router.AddRoute("*", "FooClass")  
  - matches "/foo/bar/moo"  
   
Router.AddRoute("/foo/:id/?", "FooClass")  
 - matches "/foo/20/save" and also "/foo/20"
```

  
  
3. A special one can be added if there is no match found for the path:  

```B4X
router.NotFound("NotFound", Null)
```

  
  
4. And finally, we start our router, going to our first page:  

```B4X
router.Start("/testPage1")
```

  
  
**Navigating between pages:**  
1. by code  

```B4X
Main.router.Navigate("/testPage2/carine/?id=10&lastName=Bailleul") ' will go to the Page2 class, with the variable "name" set to carine and the parameters id=10 and lastName="Bailleul"  
Main.router.Navigate("/testPage3/jos/test") ' will go to the Page3 class with the variable "name" set to jos  
Main.router.Navigate("/testPage4") ' will e.g. go to the NotFound class because it does not exist
```

  
So, although you internally change to another url, the text in the Navigation Bar in the browser will still be <https://mydomain.com>  
  
2. by entering an url in the Browsers Navigation Bar  
  
The router does use a hash system (#), so by just entering your path with the prefix /#/, it will be handled by the router.  
  
Example will do exactly the same as the first example here above:  

```B4X
https://mydomain.com/#/testPage2/carine/?id=10&lastName=Bailleul"
```

  
  
**Removing a Route:**  
Just call RemoveRoute with the original path you used to add it.  

```B4X
Router.RemoveRoute("/testPage2/:name")
```

  
  
This concludes the BANanoRouter tutorial.  
  
Alwaysbusy