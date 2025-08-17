### SolarSystem by Johan Schoeman
### 04/07/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/147297/)

It is a B4J "kick-start" project for the JAR of [**this Github project**](https://github.com/gkolli/solarSystem). How to use it:  
1. Copy the attached B4J project - the B4J code is very simple:  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
#AdditionalJar: SolarSystemRunnable  
  
Sub Process_Globals  
    Private fx As JFX  
'    Private MainForm As Form  
  
    Private ssr As JavaObject  
  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
'    MainForm = Form1  
'    MainForm.RootPane.LoadLayout("Layout1")  
'    MainForm.Show  
      
    ssr.InitializeNewInstance("SolarSystemMain", Null)  
    Dim aa() As String = Array As String(" ")  
    ssr.RunMethod("main", Array(aa))  
  
End Sub
```

  
  
2. Copy attached Jar to your additional library folder (SolarSystemRunnable.jar)  
3. Go here and download the planet images ([**this Github project**](https://github.com/gkolli/solarSystem)). Too big a zip to upload (download the jpg files from the root of the Github project)  
4. Run the B4J project once so that it will create the /Objects folder of the B4J project - it will in all probability log an error in the B4J Ide  
5. Copy the JPG files (see 3 above) into the newly created /Objects folder of the B4J project (the /Objects folder will be created after the first compile of the B4J project)  
6. Run the B4J project again - you should see a "live" UI that looks like this:  
  
![](https://www.b4x.com/android/forum/attachments/141057)  
  
Note the following when using it:  
  
**Keyboard Shortcuts:**  

- **SPACEBAR -> Pause/Play**
- **MOUSE-CLICK -> View/Toggle Specific Planet/Sun Info *-> If you have trouble clicking on a planet/Sun, pause the model (SPACEBAR) and then click.* *Unpause (SPACEBAR) to view planets orbiting again.***
- **PLUS KEY -> Zoom In**
- **MINUS KEY -> Zoom Out**
- **ESC -> Quit**