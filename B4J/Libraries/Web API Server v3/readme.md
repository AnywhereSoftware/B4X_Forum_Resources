### Web API Server v3 by aeric
### 04/24/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/163824/)

Part #1: Get Started  
Part #2: Configure Settings  
Part #3: How Does the Project Work?  
Part #4: Server Handlers  
Part #5: Using Code Snippets  
Part #6: Add a New Field  
  
[SIZE=5]**Part #1: Get Started  
  
Introduction**[/SIZE]  
This tutorial is based on [**[Project Template] Web API Server v3**](https://www.b4x.com/android/forum/threads/project-template-web-api-server-v3.163725/).  
  
[SIZE=5]**Installation**[/SIZE]  

1. Download and put the following files to Additional Libraries folder
B4J: **Web API Server (3.40).b4xtemplate,** **WebApiUtils.b4xlib** (v3.05)
B4X: **MiniORMUtils.b4xlib** (v2.51)2. If you want to use MySQL database, ensure you also have MySQL jdbc driver inside your B4J Additional Libraries folder.
e.g mysql-connector-java-5.1.49
[SPOILER="B4J Additional Libraries"]![](https://www.b4x.com/android/forum/attachments/163588)[/SPOILER]
**[SIZE=5]Create Project[/SIZE]**  

1. Once all the required libraries and template are in place, you can start B4J IDE.
2. Select from File menu, New, Web API Server (3.x)
[SPOILER="Select the project template"]![](https://www.b4x.com/android/forum/attachments/163589)[/SPOILER]3. Enter the name of your project as you like. Then click OK.
[SPOILER="New Project"]![](https://www.b4x.com/android/forum/attachments/163590)[/SPOILER]4. Now the project is ready to run as it is.

**[SIZE=5]Running the Project[/SIZE]**  

1. Click menu Project, Compile & Run (F5) or the play button on the toolbar.
2. Hover you mouse pointer to the AppStart sub and click on the highlighted link to open the app on your web browser.
[SPOILER="Open in browser"]![](https://www.b4x.com/android/forum/attachments/163591)[/SPOILER]3. The browser will open and load the index page.
It is a CRUD web application where you can add a new product (C), search for a product (R), edit an existing product (U) and delete a product (D).4. It has already generated some common APIs following the RESTful API principal.
To see the list of APIs, click the API link with a gear icon on top navigation bar.
[SPOILER="Click the API link"]![](https://www.b4x.com/android/forum/attachments/163596)[/SPOILER]5. You will be redirected to the API documentation page.
You will see there are endpoints such as GET, POST, PUT and DELETE which are represented in different colours.
[SPOILER="Click to expand the section"]![](https://www.b4x.com/android/forum/attachments/163595)[/SPOILER]6. You can click on any item to expand the section.

**[SIZE=5]Perform Tests[/SIZE]**  
  
GET  

1. Let's try to perform our first GET request with an id parameter.
Click on the second end point labeled GET /api/categories/:id2. Edit the Path by replacing the :id parameter with 2 and click on the green Submit button.
3. The form will send an AJAX request to the API server and return a JSON response (Code 200 for Success).
[SPOILER="JSON Response Success"]![](https://www.b4x.com/android/forum/attachments/163598)[/SPOILER]
POST  

1. To test a POST end point, click the third item with labeled POST /api/categories.
Copy the sample format from the left and paste in the Body textarea.2. Edit the content, i.e value of the category name in the illustration and click the yellow Submit button.
[SPOILER="JSON Response Created"]![](https://www.b4x.com/android/forum/attachments/163599)[/SPOILER]3. You may follow the convention to return code 201 Created for new item added to the resource.
For this demo, it is set to return a simple response and it doesn't support text Created but display success as default text.
You need to set Simple Response to False in server configuration to return code 201 response for your client apps.
This is the end of tutorial for now. Thanks for taking your time to read it.  
  
GitHub: <https://github.com/pyhoon/web-api-server-tutorial>  
  

[SIZE=5]*Please post your question at [[Q&A] Web Api Server 3](https://www.b4x.com/android/forum/threads/q-a-web-api-server-3.163862/)*[/SIZE]