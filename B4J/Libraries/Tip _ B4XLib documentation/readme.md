### Tip : B4XLib documentation by walt61
### 01/26/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/165278/)

I recently spent half a day on a wild goose chase trying to find out what was going on with SQLCipher, while the issue turned out to be B4XTable.b4xlib containing an #AdditionalJar for sqlite-jdbc, while my Main module contained that as well, but a different version. I could only find that out by eventually determining that B4XTable was causing the problem, unzipping the B4XLib, and looking at its contents.  
  
To hopefully avoid spending a lot of time on tracking down what's going on when something comes up with my own B4XLibs, I added this to all of them:  

```B4X
' B4Xlib information:  
' - Dependencies: …  
' - Additional jars needed: …  
' - Contains Type definitions: …  
Public Sub B4XLibInfo  
    ' This method is only used to document dependencies, additional jars, etc  
End Sub
```

  
  
In the IDE, instantiating the B4XLib and then typing 'mylibinstance.B4XLibInfo' shows the relevant information. That info must of course be added manually to the lib's code and kept updated there.