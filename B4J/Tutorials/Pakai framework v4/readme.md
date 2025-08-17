### Pakai framework v4 by aeric
### 07/15/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/167773/)

**[SIZE=5]Part #1: Get Started  
  
Introduction[/SIZE]**  
This tutorial is based on [**[Project Template] Pakai Server v4**](https://www.b4x.com/android/forum/threads/project-template-pakai-server-v4.167080/).  
  
**[SIZE=5]Installation[/SIZE]**  

1. Download and put the following files to Additional Libraries folder
B4J:
**- Pakai Server (4.00).b4xtemplate  
- WebApiUtils.b4xlib** (v4.70)
B4X:
**- MiniORMUtils.b4xlib** (v3.30)2. If you want to use MySQL database, ensure you also have MySQL jdbc driver inside your B4J Additional Libraries folder.
e.g mysql-connector-java-5.1.49
**[SIZE=5]Create Project[/SIZE]**  

1. Once all the required libraries and template are in place, you can start B4J IDE.
2. Select from File menu, New, Pakai Server (4.xx)
[SPOILER="Select the project template"]![](https://www.b4x.com/android/forum/attachments/165337)[/SPOILER]3. Enter the name of your project as you like. Then click OK.
[SPOILER="New Project"]![](https://www.b4x.com/android/forum/attachments/165338)[/SPOILER]4. Now the project is ready to run as it is.

**[SIZE=5]Running the Project[/SIZE]**  

1. Click menu Project, Compile & Run (F5) or the play button on the toolbar.
2. Hover you mouse pointer to the AppStart sub and click on the highlighted link to open the app on your web browser.
[SPOILER="Open in browser"]![](https://www.b4x.com/android/forum/attachments/165341)[/SPOILER]3. The browser will open and load the index page.
It is a CRUD web application where you can add a new product (Create), search for a product (Read), edit an existing product (Update) and delete a product (Delete).4. It has already generated some common APIs following the RESTful API principal.
To see the list of APIs, click the API link with a gear icon on top navigation bar.
[SPOILER="Click the API link"]![](https://www.b4x.com/android/forum/attachments/165342)[/SPOILER]5. You will be redirected to the API documentation page.
You will see there are endpoints such as GET, POST, PUT and DELETE which are represented in different colours.
[SPOILER="Click to expand the section"]![](https://www.b4x.com/android/forum/attachments/165343)[/SPOILER]6. You can click on any item to expand the section.

**[SIZE=5]Perform Tests[/SIZE]**  
  
GET  

1. Click on the first end point name GET Read all Categories
2. Click on the green Submit button.
3. The form will send an AJAX request to the API server and return a JSON response (Code 200 for Success).
[SPOILER="JSON Response Success"]![](https://www.b4x.com/android/forum/attachments/165344)[/SPOILER]
POST  

1. To test a POST end point, click the third item with labeled POST /api/categories.
2. Edit the content inside the Body text area, i.e value of the category\_name in the illustration and click the purple Submit button.
[SPOILER="JSON Response Created"]![](https://www.b4x.com/android/forum/attachments/165345)[/SPOILER]