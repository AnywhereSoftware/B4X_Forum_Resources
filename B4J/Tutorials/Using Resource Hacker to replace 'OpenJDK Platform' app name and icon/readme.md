### Using Resource Hacker to replace 'OpenJDK Platform' app name and icon by Chris2
### 12/13/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/136771/)

There are a few question threads about using Resource Hacker to make sure that your app name and icon appear everywhere you might want it to such as in the taskbar/Task Manager/File Properties, but I don't think anyone's done a tutorial on using it, or what can be accomplished with it. So I thought this might be useful (My apologies if someone's already done this & I've missed it).  
  
Using the [Integrated B4JPackager11](https://www.b4x.com/android/forum/threads/integrated-b4jpackager11-the-simple-way-to-distribute-standalone-ui-apps.117880/) with the #PackagerProperty settings mentioned in step 1 below, the chosen app name and icon will be used for shortcuts & the app executable file itself. But the name 'OpenJDK Platform…' may still appear in some other places along with the [Duke, the Java Mascot](https://www.oracle.com/java/duke.html) icon.  
E.g.  
  
![](https://www.b4x.com/android/forum/attachments/122884) ![](https://www.b4x.com/android/forum/attachments/122885) ![](https://www.b4x.com/android/forum/attachments/122886) ![](https://www.b4x.com/android/forum/attachments/122887)  
  
This can be changed as follows using a freely available app named Resource Hacker - <http://www.angusj.com/resourcehacker/>.  
  
1. Use the [Integrated Packager](https://www.b4x.com/android/forum/threads/integrated-b4jpackager11-the-simple-way-to-distribute-standalone-ui-apps.117880/) to build you app, remembering to first add the Packager Properties ;  
#PackagerProperty: IconFile = ..\icon.ico  
#PackagerProperty: ExeName = MyApp  
  
2. From within Resource Hacker open your app's executable file. This is the exe file in the …\Objects\temp\build\bin\ folder:  
![](https://www.b4x.com/android/forum/attachments/122888)  
  
**Change the file icon…**  
3. Once you've opened the app file in Resource Hacker, if you expand the 'Icon Group' folder (double-click) in the TreeView, and select it's child (named '2000 : 0' for me), you'll see that the Java mascot, Duke, icon is currently in use…  
![](https://www.b4x.com/android/forum/attachments/122889)  
  
4. Select 'Replace Icon' from the 'Action' menu.  
5. Click the 'Open file with new icon' button and select your preferred icon (.ico) file…  
![](https://www.b4x.com/android/forum/attachments/122890),  
6. Then click the 'Replace' button…  
![](https://www.b4x.com/android/forum/attachments/122892)  
  
**Replace the file name, description, version etc…**  
7. Open the 'Version Info' folder (double-click) in the TreeView and select its child (named '1 : 0' for me)…  
![](https://www.b4x.com/android/forum/attachments/122893)  
8. Change the text in here to suit your needs…  
![](https://www.b4x.com/android/forum/attachments/122894)  
9. **Important:** Click the 'Compile Script' button (the green 'play' button) to implement the text changes.  
  
(I'm not sure that this bit alters anything)…  
10. Open the 'Manifest' folder (double-click) in the TreeView, and select its child (named '1 : 1033' for me).  
11. Locate the entry '*name="javaw.exe"* ', and alter the javaw.exe to your own app exe.  
12. Click the 'Compile Script' button (the green 'play' button) again to implement the text changes.  
  
13. Finally, click the Save button and close Resource Hacker.  
  
You should then be able to check the changes you've made, although some don't seem to be implemented until after a PC restart, or after you've created an installation file with Inno Setup and installed your app…  
![](https://www.b4x.com/android/forum/attachments/122895) ![](https://www.b4x.com/android/forum/attachments/122896) ![](https://www.b4x.com/android/forum/attachments/122897) ![](https://www.b4x.com/android/forum/attachments/122898) ![](https://www.b4x.com/android/forum/attachments/122899)  
  
  
Notes/Tips:  
1. The TreeView needs a double-click to open the folders.  
2. After making text changes, you must click the 'Compile Script' button (the green 'play' button) to implement the change.  
3. Once all changes have been made, the Save button must also be clicked.  
3. These changes should be done before buidling an installation file with Inno Setup.  
4. There are parameters that can be set within the Inno Setup script to make similar adjustrments to the installation/uninstall files, see:  
<https://www.b4x.com/android/forum/threads/integrated-b4jpackager11-the-simple-way-to-distribute-standalone-ui-apps.117880/>  
<https://www.b4x.com/android/forum/threads/b4jpacker11-add-3-lines-and-change-1-line-in-the-inno-setup-file-by-default-maybe.114539/#content>  
<https://jrsoftware.org/ishelp/.>  
  
I hope this helps someone!