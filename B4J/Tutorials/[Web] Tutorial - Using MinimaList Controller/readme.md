### [Web] Tutorial - Using MinimaList Controller by aeric
### 09/25/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/153303/)

Introduction  
  
This tutorial is based on [**[Project Template] [Web] API 2**](https://www.b4x.com/android/forum/threads/web-api-template-2.143310/) (currently in version [2.04 beta 4](https://www.b4x.com/android/forum/threads/project-template-web-api-2.143310/page-3#posts)) on how to use **MinimaList Controller** library.  
At the time of writing, the library is version 1.05.  
For this tutorial, we will cover on using this library for creating API Controller class. For Web controller, you can refer to IndexController.  
  
How to install  
  
Download MinimaListController from [here](https://www.b4x.com/android/forum/threads/web-minimalist-controller.152966/) and copy the files into B4J Additional folder.  
![](https://www.b4x.com/android/forum/attachments/146305)  
  
Add a new Controller  
  
Open existing or start a new project using Web API Server (2.04 beta4) template.  
Right-click on the Controllers group under Modules tab, Add New Module -> Class Module and select MinimaList Controller.  
![](https://www.b4x.com/android/forum/attachments/146306)  
  
Enter a name for our Controller, eg. DataController  
![](https://www.b4x.com/android/forum/attachments/146307)  
  
This will add a new controller class with sample code.  
Scroll to Route sub and you will see commented code for RouteGet under GET and RoutePost under POST method.  
![](https://www.b4x.com/android/forum/attachments/146308)  
  
We start to generate the RouteGet sub to handle the incoming request from GET method.  
Uncomment the line for RouteGet (on line #45).  
Type "get" and B4J will list out some code snippets.  
![](https://www.b4x.com/android/forum/attachments/146310)  
  
Select the first one and press Enter. The code generated as following.  
![](https://www.b4x.com/android/forum/attachments/146311)  
  
Replace the highlighted placeholder text "GetControllers" with "GetDatas" and press Enter.  
We want to rename the sub name GetDatas (on line #59) to a more meaningful name, GetAllData because this sub will retrieve all data from DataList.  
![](https://www.b4x.com/android/forum/attachments/146312)  
Scroll to top under Class\_Globals sub, uncomment the declaration for FirstIndex and FirstElement.  

```B4X
Private FirstIndex As Int  
'Private SecondIndex As Int  
Private FirstElement As String  
'Private SecondElement As String
```

  
  
Scroll to Route sub and uncomment the following lines:  

```B4X
If ElementLastIndex > ControllerIndex Then  
    FirstIndex = ControllerIndex + 1  
    FirstElement = Elements(FirstIndex)  
End If
```

  
  
Next, we want to generate the GetAllData sub.  
Type "get" again but this time we select the second code snippet. Press Enter.  
![](https://www.b4x.com/android/forum/attachments/146313)  
  
Replace GetControllers with "GetDatas" and press Enter.  
Here we want to rename the sub name GetDatas to GetAllData (on line #74) to match the sub name on line #59.  
![](https://www.b4x.com/android/forum/attachments/146314)  
  
  
On line #78, we will use DataList for the MinimaList for this controller.  
Now our code will look like this:  

```B4X
Private Sub GetAllData  
    ' #Plural = Data  
    ' #Version = v2  
    ' #Desc = Read all items  
    HRM.ResponseData = Main.DataList.List  
    HRM.ResponseCode = 200  
  
    If Main.SimpleResponse Then  
        WebApiUtils.ReturnSimpleHttpResponse(HRM, "List", Response)  
    Else  
        WebApiUtils.ReturnHttpResponse(HRM, Response)  
    End If  
End Sub
```

  
  
Next, we will generate another sub for getting a single resource from DataList by id.  
We type "get" again and this time we select the third code snippet "Get Single Resource". Press Enter.  
  
Rename the placeholder text and press Enter.  
We can set the #Plural equals to Data or just remove the line #89 since the controller is name Data.  
This will handle the endpoint for web/api/v2/**data**/:id. Otherwise, it will handle endpoint "web/api/v2/**datas**/:id" which is incorrect.  
![](https://www.b4x.com/android/forum/attachments/146316)  
  
Now, we have done both endpoints for /web/api/v2**/data** and /web/api/v2**/data/:id** to handle API to retrieve all resources from DataList and get a single resource from DataList by id respectively.  
  
Let's proceed with generating the API for POST method.  
Scroll up and uncomment line #47.  

```B4X
RoutePost
```

  
  
Scroll to bottom and type "post".  
Select first code snippet and press Enter.  
![](https://www.b4x.com/android/forum/attachments/146317)  
  
Replace the placeholder text "PostController" to "PostData" and press Enter.  
![](https://www.b4x.com/android/forum/attachments/146318)  
Scroll to bottom and type "post" again but select the second code snippet. Press Enter.  
![](https://www.b4x.com/android/forum/attachments/146319)  
  
Make necessary changes to the placeholder text and press Enter.  
![](https://www.b4x.com/android/forum/attachments/146321)  
  
If you see the error "Unknown member: datalist" it means DataList is not declared.  
Go to Main module, uncomment the line #41.  

```B4X
Public DataList As MinimaList
```

  
  
Find the InitializeMinimaList sub and uncomment line #359.  
![](https://www.b4x.com/android/forum/attachments/146322)  
  
Find ConfigureKeyValueStore sub and uncomment the code on line #384 to #386. This is to write and read the data of DataList using KeyValueStore library.  
![](https://www.b4x.com/android/forum/attachments/146324)  
  
If you see a warning, "RoutePost is not used" then uncomment the line #47.  
Take note that we can add RoutePut and RouteDelete at this Select-Case section inside Route sub.  
![](https://www.b4x.com/android/forum/attachments/146325)  
  
Don't forget to check whether the controller is "registered" in ApiHandler? This is important or else the endpoint cannot be reached (API showing Bad Request).  
Under ProcessRequest sub in ApiHandler, uncomment the code on line #72 to #76.  
If you are adding new API controllers, this is the place to add them.  
Take note: If the controller only route to API endpoint, we can use Route or RouteApi sub. If we want to display a web page, we can use RouteWeb sub.  
![](https://www.b4x.com/android/forum/attachments/146328)  
  
The last thing is to add our new controller to the Controllers list in Main module so we can test it by navigating to help endpoint (<http://127.0.0.1:19800/web/help>).  
In Main module under ConfigureControllers sub, uncomment line #223.  
![](https://www.b4x.com/android/forum/attachments/146331)  
  
Now, we can try to run the project in Debug mode.  
Go to the help page to test our new API endpoints.  
![](https://www.b4x.com/android/forum/attachments/146332)  
  
Now, we have created 3 APIs, 2 for GET and 1 for POST.  
  
We can also generate API endpoints for PUT and DELETE using snippets from the steps explained above.  
  
Thanks for following this tutorial.  
  
Regards,  
Aeric