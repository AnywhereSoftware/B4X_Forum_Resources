### [tool]  Snippets For B4X - a B4J app by Mark Stuart
### 03/18/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/128018/)

Yes, another code snippet manager, but slightly different. It uses the TreeView and TreeViewExtended view and code.  
So you can search on the TreeView, using the TreeViewExtended search feature.  
  
Screen shot of the B4J desktop app:  
![](https://www.b4x.com/android/forum/attachments/108673)  
  
Current Features:  
- comes with the main Categories: B4A, B4J, B4i, JAVA, and WWW Links. Of course, you can add your own category, as many as you want.  
- Category - they have snippets. A snippet contains such things as Snippet Name, URL to a web site that you got the code snipppet from, the code snippet, Keywords, and Libraries.  
- Button Bar - the main functionalities of the app are defined in the buttons of the Button Bar. Each has a hint text. Some buttons work with a hot key: Ctrl-S for save, Ctrl-N for a new snippet  
- Status Bar - shows, for example, which is the currently selected Category, app version number, and the app resizer  
- Split Pane divider - allows the user to adjust the divider to see more or less of the treeview and the snippet code  
- SQLite database - all data is stored in a local database, in the app folder.  
- Context Menus for the TreeView - depending on which tree item you have selected, the context menu is associated to the treeview. So for the Category treeview selected item, the context menu has different menu selections compared to a selected Snippet treeview item.  
- URL Link - saving a URL with the snippet, allows the user to launch that URL into the default browser, with the Launch URL button.  
- App Settings - allows the user to expand all treeview items, or not, on app startup.  
- Save Form dimensions - this allows the user to set the app size and have the app save those dimensions on closing of the app. On app startup, the app reads those dimensions from the database and are applied to the form Window size properties, including the splitter position.  
  
Future Features:  
- Printing snippet code - clicking the Print Preview button will display the snippet content in an HTML format, in the default browser. From there, you can print the HTML content to a printer, such as saving it to a PDF file, if you have that PDF driver installed.  
- Export Snippet - this would allow the user to create a JSON formatted file with the content of the selected snippet.  
- Import Snippet - with an exported JSON formatted file, that was exported using the app, the user could import that file into the app. This would allow user-to-user transporting of code snippets.  
  
Comments:  
At this time, the app is only available as a .JAR file, as I would ask for testing, enhancement requests, and bug reporting.  
I'm not sure if that's OK with everyone, but I'd like to start out that way.  
That would allow me to fix issues and apply requested enhancements.  
Eventually, I would release the app project to the community with those fixes and enhancements.  
That way, everyone wins who would want the app.  
[Edit]: I contacted Erel about using "B4X" in the name of the app, and he said it was OK to use it.  
  
Download link to the app Version 1.35: [HERE](https://drive.google.com/file/d/1PPDO_xIlbetDpillWrCjCMzWrXBUTjYQ/view?usp=sharing)