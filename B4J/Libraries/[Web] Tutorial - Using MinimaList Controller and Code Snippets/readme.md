### [Web] Tutorial - Using MinimaList Controller and Code Snippets by aeric
### 04/24/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/148427/)

[HEADING=3]Introduction[/HEADING]  
This tutorial is based on [**MinimaList API Server**](https://www.b4x.com/android/forum/threads/project-template-web-minimalist-api-server.160679/) (version 2.05) on how to use **MinimaList Controller** library.  
  
For this tutorial, we will cover on using this library for creating API controller.  
  
Update: This tutorial is updated for library version 1.05.  
  
[HEADING=3]How to install[/HEADING]  
Download **MinimaListController.jar** and **MinimaListController.xml** from [here](https://www.b4x.com/android/forum/threads/web-minimalist-controller.152966/) and paste the files into B4J Additional folder.  
  
![](https://www.b4x.com/android/forum/attachments/152967)  
  
[HEADING=3]Adding a new Controller[/HEADING]  
You can open your existing project or start a new MinimaList API Server project.  
  
Right-click on the Controllers group under Modules tab, Add New Module -> Class Module and select MinimaList Controller.  
  
![](https://www.b4x.com/android/forum/attachments/152968)  
  
Enter a name for your Controller, eg. ProductController  
  
![](https://www.b4x.com/android/forum/attachments/142799)  
  
This will add a ProductController class to the project.  
  
![](https://www.b4x.com/android/forum/attachments/152970)  
  
After that we need to register the new controller in ApiHandler class, under Sub ProcessRequest, add the following highlighted code:  

```B4X
Select ControllerElement  
    Case "categories"  
        Dim Categories As CategoryController  
        Categories.Initialize(Request, Response)  
        Categories.RouteApi  
        Return  
    Case "product"  
        Dim Product As ProductController  
        Product.Initialize(Request, Response)  
        Product.Route  
        Return  
End Select
```

  
  
![](https://www.b4x.com/android/forum/attachments/152975)  
  
We need to declare this variable globally in Process\_Globals of Main module.  
  
![](https://www.b4x.com/android/forum/attachments/152971)  
  
Then we initialize it in ConfigureMinimaList sub.  
  
![](https://www.b4x.com/android/forum/attachments/152972)  
  
To load the persisted data from KeyValueStore, add the following code in Sub ConfigureKeyValueStore.  
  

```B4X
If ProductList.IsInitialized Then  
    ProductList.List = KVS.GetDefault("ProductList", ProductList.List)  
End If
```

  
  
![](https://www.b4x.com/android/forum/attachments/152973)  
  
To allow us to test the new API in API Documentation, we need to add the new controller in Sub ConfigureControllers.  
  
![](https://www.b4x.com/android/forum/attachments/152974)  
[HEADING=3]Creating API using Code Snippets[/HEADING]  
  
Type **codeget** or **get** to activate the Code Snippet.  
  
Use arrow key down and press Enter (or mouse click) to select the third snippet **Code\_WebApiUtils\_03 Route GET**.  
  
![](https://www.b4x.com/android/forum/attachments/152976)  
  
The Code Snippet is added.  
  
When the word Controller is on focus, type "Product" and press Enter to replace the Controller placeholder.  
  
![](https://www.b4x.com/android/forum/attachments/152978)  
  
Uncomment the FirstIndex and FirstElement variables.  
  
![](https://www.b4x.com/android/forum/attachments/152979)  
  
Type **get** and press Enter to add the first Code Snippet **Code\_MinimaListUtils\_01 Get All Resources**.  
  
![](https://www.b4x.com/android/forum/attachments/152980)  
  
When the Controller on focus, replace it with "Product". Do the same with MinimaList placeholder to replace with "ProductList" and press Enter.  
  
![](https://www.b4x.com/android/forum/attachments/152981)  
  
Add ReturnApiResponse sub if it is not yet added.  
  
![](https://www.b4x.com/android/forum/attachments/152982)  
  
Do the similar steps to add GetProduct() sub or skip it for now.  
  
We also use the same steps to create the RoutePost sub.  
  
Type **codepost** or **post** to activate the code snippet for **Code\_WebApiUtils\_04 Route POST** and press Enter.  
  
Type **post** again but this time we select the Code Snippet for **Code\_MinimaListUtils\_03 Post Resource** to add PostProduct sub.  
  
![](https://www.b4x.com/android/forum/attachments/152983)  
  
When the Controller on focus, replace it with "Product". Do the same with MinimaList placeholder to replace with "ProductList" and press Enter.  
  
![](https://www.b4x.com/android/forum/attachments/152984)  
  
Finally, uncomment the lines to call RouteGet and RoutePost.  
  
![](https://www.b4x.com/android/forum/attachments/152985)  
  
Now navigate to API Documentation / Help to test the new API.  
  
[HEADING=3]**Testing the API**[/HEADING]  
Let's make a *POST* call.  
  
You can copy the sample JSON body in the light blue box on the left and paste to the white box in the center.  
  
Click on Submit button and you should see the response.  
  
![](https://www.b4x.com/android/forum/attachments/142812)  
  
[HEADING=3]Checking data is persisted[/HEADING]  
Stop the debug.  
  
Run the Debug again and navigate to API Documentation page.  
  
Make a *GET* call using the first API by clicking on the green Submit button.  
  
If the Response box returns an object, meaning the data is successfully persisted in KeyValueStore.  
  
![](https://www.b4x.com/android/forum/attachments/142813)  
  
The data file is name kvs.dat inside Objects folder.  
  
Thanks for following this tutorial.  
  
Regards,  
Aeric