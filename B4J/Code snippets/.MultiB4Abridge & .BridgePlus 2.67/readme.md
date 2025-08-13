### .MultiB4Abridge & .BridgePlus 2.67 by T201016
### 05/15/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/167020/)

Hello everyone,  
I transfer this auxiliary project for possible testing.  
  
**MultiB4Abridge** - serves as a tool for installing the B4A application on the phone.  
It can be called with two parameters from the B4A project - B4XExampleCommentLinks.  
  
To make everything work, you need to have the B4A-bridge application and a portable portable hospot on your phone,  
on which you want to install the compiled B4A application. \*\*)  
  
![](https://www.b4x.com/android/forum/attachments/164100)  
  
An example of launching in the B4A project (using the command link\*):  
  
Ctrl + mouse click to activate.  
> 'run an external application: ide://run?File=**d:\app\MultiB4ABridge\MultiB4ABridge.exe**&Args=**127.0.0.1**&Args=**%PROJECT%\Objects\B4XExampleCommentLinks.apk**

  
Clicking the mouse on the above link will start the application (multib4abridge.exe) with two parameters,  
The content will be filled in the appropriate fields as soon as the form window is opened.  
  
\*) In your own project, of course, change the access path with the name of the called application,  
as well as IP Address in IDE.  
  
\*\*) Tested on Android 13 | SDK34.