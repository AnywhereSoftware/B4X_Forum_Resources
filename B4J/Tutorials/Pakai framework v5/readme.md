### Pakai framework v5 by aeric
### 08/27/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/167796/)

**[SIZE=5]Part #1: Get Started  
  
Introduction[/SIZE]**  
This tutorial is based on [**[Project Template] Pakai Server v5**](https://www.b4x.com/android/forum/threads/project-template-pakai-server-v5.167788/).  
  
**[SIZE=5]Installation[/SIZE]  
  
[SIZE=4]Option 1:[/SIZE]**  

1. Download and put the following files to Additional Libraries folder (don't put inside new subfolder)
B4J:
**-** [**Pakai Server (5.00).b4xtemplate**](https://www.b4x.com/android/forum/threads/project-template-pakai-server-v5.167788/)
- [**EndsMeet.b4xlib**](https://www.b4x.com/android/forum/threads/web-server-endsmeet-v1-10.167395/) (v1.10)
**-** [**WebApiUtils.b4xlib**](https://www.b4x.com/android/forum/threads/web-webapiutils-v4.167012/) (v4.70)
- [**mysql-connector-java-8.0.30.jar**](https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar) (for MySQL)
B4X:
**-** [**MiniORMUtils.b4xlib**](https://www.b4x.com/android/forum/threads/b4x-miniormutils.166030/) (v3.30)
**[SIZE=4]Option 2:[/SIZE]**  

1. Download and put Pakai Server (5.00).b4xtemplate to B4J Additional Libraries folder.
2. Use [**LibDownloader**](https://www.b4x.com/android/forum/threads/tool-additional-libraries-downloader.166880/) to download the additional b4xlibs after you have created a new project.
3. If you want to use MySQL database, you also need the mysql connector library.

**[SIZE=5]Create a Project[/SIZE]**  

1. Start B4J IDE
2. Select New from File menu and click on Pakai Server (5.xx)
[SPOILER="Select the project template"]![](https://www.b4x.com/android/forum/attachments/165337)[/SPOILER]3. Confirm the Project Folder
4. Enter the Project Name as you desired then click OK button.
[SPOILER="New Project"]![](https://www.b4x.com/android/forum/attachments/165338)[/SPOILER]5. A project is created and ready to run under the default settings.

**[SIZE=5]Running the Project[/SIZE]**  

1. Click Compile & Run (F5) from the Project menu or click the play button on the toolbar.
2. When the project has finished to compile, hover you mouse pointer to the AppStart sub.
3. Click on the highlighted link to open the app on your web browser.
[SPOILER="Open in browser"]![](https://www.b4x.com/android/forum/attachments/165341)[/SPOILER]4. The index page will be loaded.
It shows a web application with CRUD functionality to:
- add a new product (Create),
- search for a product (Read),
- edit an existing product (Update) and
- delete a product (Delete).5. The API endpoints are generated based on RESTful API principal.
6. To see the list of APIs, click the API link with a gear icon on top navigation bar.
[SPOILER="Click the API link"]![](https://www.b4x.com/android/forum/attachments/165342)[/SPOILER]7. The API documentation or help page displays the endpoints for GET, POST, PUT and DELETE represented in different colours.
[SPOILER="Click to expand the section"]![](https://www.b4x.com/android/forum/attachments/165343)[/SPOILER]8. You can click on any item to expand the section.

**[SIZE=5]Performing Tests[/SIZE]**  
  
GET  

1. Click on the first endpoint name [GET] Read all Categories.
2. Click on the green Submit button and wait for the response.
3. The response should return a JSON response with Code 200.
[SPOILER="JSON Response Success"]![](https://www.b4x.com/android/forum/attachments/165344)[/SPOILER]
POST  

1. To test a POST endpoint, click the third item which labeled [POST] Add new Category.
2. Edit the content inside the Body text area
3. Click on the purple Submit button and wait for the response.
4. The response should return a JSON response with Code 201.
[SPOILER="JSON Response Created"]![](https://www.b4x.com/android/forum/attachments/165345)[/SPOILER]