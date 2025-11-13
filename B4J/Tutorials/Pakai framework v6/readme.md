### Pakai framework v6 by aeric
### 11/11/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/169286/)

**[SIZE=5]Part #1: Get Started  
  
Introduction[/SIZE]**  
This tutorial is based on [**[Project Template] Pakai Server v6**](https://www.b4x.com/android/forum/threads/web-project-template-pakai-server-v6-00.169224/).  
  
**[SIZE=5]Installation[/SIZE]**  

1. Download and put the following files to **Additional Libraries** folder
**B4J**
- [Pakai Server](https://www.b4x.com/android/forum/threads/web-project-template-pakai-server-v6-00.169224/) (6.00) **starter** [b4xtemplate](https://www.b4x.com/android/forum/attachments/pakai-server-6-00-starter-b4xtemplate.168245/)[SIZE=3] (28KB)[/SIZE]
- [EndsMeet](https://www.b4x.com/android/forum/threads/web-server-endsmeet-v1-70.167395/) (v1.70) [b4xlib](https://www.b4x.com/android/forum/attachments/endsmeet-b4xlib.168217/)[SIZE=3] (5KB)[/SIZE]
**B4X**
- [MiniHtml](https://www.b4x.com/android/forum/threads/b4x-web-minihtml.158846/) (v0.60) [b4xlib](https://www.b4x.com/android/forum/attachments/minihtml-b4xlib.168248/)[SIZE=3] (37KB)[/SIZE]
- [MiniJs](https://www.b4x.com/android/forum/threads/b4x-web-minijs.169204/) (v0.20) [b4xlib](https://www.b4x.com/android/forum/attachments/minijs-b4xlib.168159/)[SIZE=3] (3KB)[/SIZE]
- [MiniORMUtils](https://www.b4x.com/android/forum/threads/b4x-miniormutils.166030/) (v3.90) [b4xlib](https://www.b4x.com/android/forum/attachments/miniormutils-b4xlib.168111/)[SIZE=3] (14KB)[/SIZE]
**[SIZE=5]Create a Project[/SIZE]**  

1. Start B4J IDE
2. Select New from File menu and click on **Pakai Server (6.00) starter**
[SPOILER="Select the project template"]![](https://www.b4x.com/android/forum/attachments/168252)[/SPOILER]3. Confirm the Project Folder
4. Enter the Project Name as you desired then click OK button.
[SPOILER="New Project"]![](https://www.b4x.com/android/forum/attachments/168253)[/SPOILER]5. A project is created and ready to run under the default settings.

**[SIZE=5]Running the Project[/SIZE]**  

1. Click Compile & Run (F5) from the Project menu or click the play button on the toolbar.
2. When the project has finished to compile for the first time, you will see a message in the Logs saying "Database is created successfully!".
[SPOILER="Project compiled for the first time"]![](https://www.b4x.com/android/forum/attachments/168254)[/SPOILER]3. You can click on the AppStart macro on the IDE window title and hover you mouse pointer to the AppStart sub.
4. Click on the highlighted link to open the app on your web browser.
[SPOILER="Open in browser"]![](https://www.b4x.com/android/forum/attachments/168255)[/SPOILER]5. The index page will be loaded. It shows a web application with CRUD functionality.
[SPOILER="Index page"]![](https://www.b4x.com/android/forum/attachments/168257)[/SPOILER]6. You can add a new product (Create)
7. You can search for a product (Read)
8. You can edit an existing product (Update) and
[SPOILER="Edit Product modal dialog"]![](https://www.b4x.com/android/forum/attachments/168262)[/SPOILER]9. You can delete a product (Delete).
[SPOILER="Delete Product modal dialog"]![](https://www.b4x.com/android/forum/attachments/168260)[/SPOILER]10. You can navigate to the Categories page.
11. If your page width is small and you don't see the Categories menu, you can click the hamburger menu on top right corner to toggle the menu list.
[SPOILER="Navigate to Categories page"]![](https://www.b4x.com/android/forum/attachments/168258)[/SPOILER]12. A toast message will appear at the bottom right after you made changes to the database.[SPOILER="Toast message"]
![](https://www.b4x.com/android/forum/attachments/168261)[/SPOILER]13. If you try to delete a Category with associated Products, an error message will be showed.
[SPOILER="Error deleting a category with associated products"]![](https://www.b4x.com/android/forum/attachments/168263)[/SPOILER]14. If you try to add a Product without providing the required fields, a pop up dialog will showed indicated the fields are required.
[SPOILER="Bootstrap pop up required fields"]![](https://www.b4x.com/android/forum/attachments/168264)[/SPOILER]