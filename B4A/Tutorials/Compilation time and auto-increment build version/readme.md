### Compilation time and auto-increment build version by Erel
### 12/06/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/64183/)

This tutorial demonstrates how the custom build action feature can be used to add a file during compilation with the compilation time and an automatic version number that is incremented with every compilation.  
  
Using it is simple:  
  
1. Download the attached jar file and save it.  
2. Add this line to your project:  

```B4X
#CustomBuildAction: folders ready, %JAVABIN%\java.exe, -jar C:\Users\H\Downloads\compiletime.jar
```

  
Change the path to the downloaded jar.  
  
During compilation a file named compiletime.txt will be created in the Files folder.  
You can read its data with:  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
   If FirstTime Then  
     Dim compiledata As Map = File.ReadMap(File.DirAssets, "compiletime.txt")  
     Log($"autoversion: ${compiledata.Get("autoversion")}"$)  
     Log($"compilation time: $DateTime{compiledata.Get("time")}"$)  
   End If  
End Sub
```

  
  
Run your app once and then go to the Files tab and click on Sync button (this will remove the file warning).  
  
The small utility code (B4J) is:  

```B4X
Sub AppStart (Args() As String)  
   Dim m As Map  
   Dim path As String = "../Files/compiletime.txt"  
   If File.Exists(path, "") Then  
     m = File.ReadMap(path, "")  
   Else  
     m.Initialize  
   End If  
   m.Put("autoversion", m.GetDefault("autoversion", 0) + 1)  
   m.Put("time", DateTime.Now)  
   File.WriteMap(path, "", m)  
End Sub
```

  
  
If you only want to increment the version for Release builds:  

```B4X
#If RELEASE  
#CustomBuildAction: 2, …  
#End If
```

  
  
Edit: example of code that extracts the project attributes: <https://www.b4x.com/android/forum/threads/write-attribute-to-textfile.88549/#post-560535>