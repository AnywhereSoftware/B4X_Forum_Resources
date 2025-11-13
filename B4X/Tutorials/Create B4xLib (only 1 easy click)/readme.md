###  Create B4xLib (only 1 easy click) by aeric
### 11/10/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/169014/)

**[SIZE=5]Creating a b4xlib is easy.[/SIZE]**  
You only need a B4X code (class or code module) with **.bas** file extension compressed into a file with the file extension **.b4xlib**.  
You can add a manifest.txt to show the library version in the IDE.  
  
[SIZE=5]**Now, it is even faster and easier with the following steps, just inside the IDE, without any external tools.**[/SIZE]  
  
**Step 1: Prepare the project folder**  

1. Create a new project (non B4XPages)
*Optional:* Create a GitHub repo. You can run the GitHub Desktop macro.2. Move the project files into "source" folder
The project files include .b4j or .b4a file and .meta3. Create a new "release" folder

**Step 2: Add the macros**  

1. Add the following macros

```B4X
#Region Macros  
'#Macro: Title, Export as zip, ide://run?file=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip  
#Macro: Title, Update Version, ide://run?file=%JAVABIN%\java.exe&Args=-jar&Args=%ADDITIONAL%\..\B4X\manifest-writer.jar&Args=%PROJECT%&Args=%PROJECT%&Args=Version&Args=1.00  
#Macro: Title, Create B4xLib, ide://run?file=%JAVABIN%\jar.exe&WorkingDirectory=..&args=-cMf&args=..\release\%PROJECT_NAME%.b4xlib&args=*.bas  
#Macro: Title, Release folder, ide://run?file=%WINDIR%\SysWOW64\explorer.exe&Args=%PROJECT%\..\release  
#Macro: Title, Copy to AddLibs, ide://run?file=%COMSPEC%&args=/c&args=copy&args=%PROJECT%\..\release\*.b4xlib&args=%ADDITIONAL%\..\B4X  
#End Region
```

Note: To run the "Update Version" macro, you need to use: [**Manifest Writer Tool**](https://www.b4x.com/android/forum/threads/tool-manifest-txt-writer-for-b4xlib.168723/)
**Step 3: Update your code**  

1. Add a new class or code module into your project
2. *Optional:* Add a manifest.txt file
3. *Optional:* Add a class template with .b4x\_excluded extension
4. *Optional:* Add some code snippets txt files into the "Snippets" folder

**Step 4: Run the macros**  

1. *Optional:* Click the shortcut at the title bar to run the macro for "**Update Version**".
Edit the macro if you want to change or update the version number.
If this file is not exist, it will be created.2. Click the shortcut at the title bar to run the macro for "**Create B4xLib**".
**This is the only required click.**
Edit the macro to include additional files or folders. e.g Snippets, \*.b4x\_excluded, manifest.txt or LICENSE

```B4X
#Macro: Title, Create B4xLib, ide://run?file=%JAVABIN%\jar.exe&WorkingDirectory=..&args=-cMf&args=..\release\%PROJECT_NAME%.b4xlib&args=*.bas&args=*.b4x_excluded&args=Snippets&args=manifest.txt&args=LICENSE
```

The library will be saved inside the "release" folder.
*Optional:* You can verify if the file exist by running the macro "**Release folder**".3. *Optional:* Click the shortcut at the title bar to run the macro for "**Copy to AddLibs**"
The library will be copied to Additional Libraries\B4X folder.
If it is a platform specific library, edit the macro to:

```B4X
#Macro: Title, Copy to AddLibs, ide://run?file=%COMSPEC%&args=/c&args=copy&args=%PROJECT%\..\release\*.b4xlib&args=%ADDITIONAL%
```


**Step 5: Rinse and repeat (3 easy clicks)**  
From now on, every time you have modified your code and want to update your library immediately, just follow the following steps:  

1. Follow Step 4, #1
2. Follow Step 4, #2
3. Follow Step 4, #3

Remember to right click the Libraries Manager tab to refresh the library.  
  
That's all.  
  
![](https://www.b4x.com/android/forum/attachments/167793)  
  
![](https://www.b4x.com/android/forum/attachments/167817)  
e.g Single class library  

```B4X
#Macro: Title, Create B4xLib, ide://run?file=%JAVABIN%\jar.exe&WorkingDirectory=..&args=-cMf&args=..\release\%PROJECT_NAME%.b4xlib&args=EndsMeet.bas&args=manifest.txt&args=LICENSE
```