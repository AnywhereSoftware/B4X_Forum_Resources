### Full Screen Form by androh
### 08/20/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/130511/)

For my project I've needed to fullscreen form on Raspian (bellsoft-jdk11.0.11)  
I founded a solution here.  
<https://stackoverflow.com/questions/53536042/how-to-hide-taskbar-in-fullscreen-mode-javafx>  
Then converted to B4J  

```B4X
    MainForm.Resizable=False    
    Dim jform As JavaObject = MainForm  
    Dim jStage As JavaObject=jform.GetFieldJO("stage")  
    jStage.RunMethod("setMaximized", Array(True))  
    jStage.RunMethod("setFullScreen", Array(True))  
    jStage.RunMethod("setFullScreenExitKeyCombination", Array(jform.InitializeStatic("javafx.scene.input.KeyCombination").GetField("NO_MATCH")))  
    MainForm.AlwaysOnTop=True
```

  
  
Thats all :)