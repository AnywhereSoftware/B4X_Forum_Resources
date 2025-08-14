### DOHelp 1.3 - simple help system using webview and HTML pages by Dave O
### 06/19/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/167251/)

Hi all,  
  
I created a simple help system for my apps and have packaged it into a free class (DOHelp) and demo app.  
  
It lets you open a help dialog showing your content as standard HTML pages (local or hosted on a web server). The content is shown in a webview, with basic browser controls in its titlebar. The user can then browse your interlinked help pages.  
  
![](https://www.b4x.com/android/forum/attachments/164520)  
  
To use this class:  

1. Add the **DOHelp** class (DOHelp.bas) to your B4A project.
2. Add the **DOHelp.bal** layout file to your Files folder.
3. Tick these internal libraries in your project:
- **Archiver** (to expand your zip file of HTML/CSS/JS files to a folder on the device)
- **WebViewExtras2** (to set up the webview properly)
- **XUI** (to get a proper URI for the web pages)4. Prepare your help files in a folder and zip them up (without their parent folder), then put that zip file in your Files folder.
5. In your app, create a DOHelp instance and call its Show method.
- You can set the specific page to start on.
- You can also set a light or dark theme if you wish (handled by your CSS).
- It shows a dialog with basic browser controls and your specified help page.
Included in this demo are a few sample web pages (interlinked), basic CSS, and a JavaScript file that handles switching between light and dark themes.  
  
Feedback much appreciated. Thanks!  
  
Updated to version 1.3