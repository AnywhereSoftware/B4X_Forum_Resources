###  Cross platform example by Erel
### 04/12/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/114125/)

![](https://www.b4x.com/basic4android/images/i_view64_27Givs3HpE.png)  
  
This is a simple example that demonstrates a recommended method of sharing code and files between B4A, B4i and B4J.  
It is based on these tips: <https://www.b4x.com/android/forum/threads/xui2d-cross-platform-tips.96815/#content>  
  
The main idea is to implement everything that is possible in one or more classes and share these classes.  
The project structure looks like this:  
![](https://www.b4x.com/basic4android/images/dopus_HyKeOAvka1.png)  
The shared classes are in the root folder and the shared classes are added as references from the parent folder:  
![](https://www.b4x.com/basic4android/images/lliExMdUps.png)  
  
There is a "shared files" folder where we put all the resource files that will be copied to the assets folders.  
This is done with this line (it is in the shared class):  

```B4X
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
```

  
Robocopy will only copy modified files so it will not slow down compilation.  
  
In this example the logo image file is the only shared file.  
Note that the layouts were created using the relatively new feature: [[B4X] Sharing layouts between platforms](https://www.b4x.com/android/forum/threads/109296/#content)  
  
Example depends on:  
  
- BCToast: <https://www.b4x.com/android/forum/threads/111046/#content>  
- BCTextEngine: <https://www.b4x.com/android/forum/threads/106207/#content>  
These are cross platform b4xlibs and they should be put in the B4X folder: <https://www.b4x.com/android/forum/threads/b4x-additional-libraries-folder.103165/#content>  
  
A more complex example: <https://www.b4x.com/android/forum/threads/b4x-corona-cases-cross-platform-example.115107/#content>  
  
![](https://www.b4x.com/basic4android/images/B4i_lHVZTb71N9.png)