### My B4J Packager - an extended version by Starchild
### 10/02/2019
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/95500/)

This "My B4J Packager" started as the [B4Jpackager provided by Erel](https://www.b4x.com/android/forum/threads/ui-apps-packaging-self-contained-installers.56854/). I have added the text entry fields for the extra things like, Menu Group, JavaVM Options (to set memory requirements), System Property definition, and extended the Vendor text to set the Publisher/Company fields for the installed program in Windows.  
  
My B4J Packager also allows for multiple Projects. The settings for each project are stored individually. Changing the Project Name, (after 1 sec) the previously used settings for that project will be reloaded. Project settings are re-saved on a Build and program exit. Settings can be copied by simply entering a new project name.  
  
The Build button and Progress Bar have been stylised a little, just because I could.  
Also, added tool tips to help with text.  
  
Fixed the BROWSE button fault when a previously defined file path no longer points to a valid path (things were moved). This was causing a program crash.  
  
Hope people find it useful.  
And, thanks to the great support provided by Erel and other in sorting out the little issues I had extending the B4J packager.  
  
Don't Forget. You need to install Inno Setup. This is required by "javapackager" tool.  
 [I used version 5.5.9](http://www.jrsoftware.org/isdlold.php#5)  
<http://www.jrsoftware.org/isdlold.php#5>  
because I found that the current version of Inno Setup 6.02 did not work with javapackager 8\_192  
  
  
Updated to v2.01  
- now supports "Create a Desktop Shortcut" option.