### Automatically package b4xlib libraries by byz
### 03/13/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/166115/)

When I was writing the b4xlib library, I encountered complicated steps, and I needed to decompress and compress the b4xlib file (zip format) frequently.  
  
So I wrote this tool to automatically package b4xlib libraries. At the same time, a project template was made.  
  
Now I share it and give back to the community.  
![](https://www.b4x.com/android/forum/attachments/162525)  
![](https://www.b4x.com/android/forum/attachments/162524)  
**Usage:**   
1.Put Pack2b4xlib.bat in the project directory, that is, B4A, B4J and B4i directories at the same level  
2.Then add the following code to the IDE.  
If manifest.txt doesn't exist, you will be prompted whether to create it. The IDE shortcut code is as follows.  

```B4X
'Create b4xlib: ide://run?file=%PROJECT%\..\Pack2b4xlib.bat&Args=%ADDITIONAL%&Args=%PROJECT_NAME%.b4xlib  
'Edit manifest.txt: ide://run?file=%WINDIR%\System32\notepad.exe&Args=%PROJECT%\..\manifest.txt
```

  
I have already made a template based on Erel's default B4X template, downloaded it and put it into the extension library, so I can create a new one when I need to create a new library.  
![](https://www.b4x.com/android/forum/attachments/162527)  
**Note:** After repackaging, it is best to re-check the items that have referenced the b4xlib library in the library list to prevent the items from not loading the updated library.