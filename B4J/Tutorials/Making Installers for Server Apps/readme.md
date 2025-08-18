### Making Installers for Server Apps by tchart
### 12/21/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/125756/)

**Part 1**  
  
I have been on the lookout for a simple way to create an installer for my server apps - Ive looked at Inno Setup etc before but I wanted something simple.  
  
My apps are currently bundled as zip files which are then given to customers. Although this works its a not as desirable as a proper installer as the user may not unzip it correctly.  
  
As I was already distributing as a zip file I got to thinking about self-extracting archive. It turns out that 7-zip can already support this through the UI  
  
![](https://www.b4x.com/android/forum/attachments/104722)  
  
My release packing is scripted so I wanted to script the self-extracting archive as well.  
  
Here is the documentation for the command line to create a self-extracting archive (SFX)  
  
<https://sevenzip.osdn.jp/chm/cmdline/switches/sfx.htm>  
  
To script a SFX we need to create config file like this;  
  

```B4X
;!@Install@!UTF-8!  
Title="7-Zip 4.00"  
BeginPrompt="Do you want to install the 7-Zip 4.00?"  
RunProgram="setup.exe"  
;!@InstallEnd@!
```

  
  
And then use command line to merge the SFX and your zip file like this (I place the sfx and confil files in the same directory as my zipped project);  
  

```B4X
copy /b 7zSD.sfx + config.txt + myB4Jproject.7z MyInstaller.exe
```

  
  
This will create an executable called MyInstaller.exe that the user can run and be prompted for a location to unzip to.