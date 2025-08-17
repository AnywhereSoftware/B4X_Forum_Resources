### FXThemes by stevel05
### 02/28/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/165868/)

Now I have a windows 11 PC and thanks to a prod from one of [USER=4]@Cableguy[/USER] posts on another thread, I finally got round to looking at an alternative to my [Replacement Titlebar](https://www.b4x.com/android/forum/threads/replacement-titlebar.84586/) lib.  
  
This is a quick example of how to use this [FXThemes library on Github](https://github.com/dukke/FXThemes).  
  
It is not difficult to use, and probably not worth wrapping as a library. The example uses JavaObject. You can read the javaDoc to see what else is available.  
  
You need to download the fxthemes-1.6.0 jar from Maven Central, and the jna-5.13.0 and jna-platform-5.13.0 if you don't already have them. The library was compiled with Java 21, but it is working for my test on Java 19. Uncomment the #JavaCompilerPath assignment and point it to a suitable java compiler.  
  
After about 15 mins I got this:  
  

![](https://www.b4x.com/android/forum/attachments/162125)

  
  
Which is probably what we've all been after.  
  
This is the code:  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
#AdditionalJar:fxthemes-1.6.0  
#AdditionalJar: jna-5.13.0  
#AdditionalJar: jna-platform-5.13.0  
  
'#JavaCompilerPath: 19,C:\Java\jdk-19.0.2\bin\javac.exe ' Or wherever a suitable java version lives on your machine.  
  
#VirtualMachineArgs: –add-opens javafx.graphics/javafx.stage=ALL-UNNAMED –add-exports javafx.graphics/com.sun.javafx.tk.quantum=ALL-UNNAMED  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
   
   
    Dim MF As JavaObject = MainForm  
    Dim Stage As JavaObject = MF.GetField("stage")  
   
   
    Dim Manager As JavaObject  
    Dim Factory As JavaObject  
    Factory.InitializeStatic("com.pixelduke.window.ThemeWindowManagerFactory")  
    Manager = Factory.RunMethod("create",Null)  
    Manager.RunMethod("setWindowBackdrop",Array(Stage,"ACRYLIC"))  
    Manager.RunMethod("setWindowCornerPreference",Array(Stage,"ROUND"))  
    Manager.RunMethod("setWindowFrameColor",Array(Stage,fx.Colors.Black))  
   
End Sub
```

  
  
Have fun and let me know how you get on with it. As always, check the Licence if you are going to use it commercially.  
  
If you want to use it in a Packaged app, you will need to add the complimentary VMARGS: for the add-opens and –add-exports. As this requires at least Java 19, and possibly 21 the packager won't currently be available.