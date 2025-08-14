### JavaFX 17+ CAPS / NUM_LOCK detection by stevel05
### 08/12/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168196/)

JavaFX 17 introduced the method [ICODE]isKeyLocked(KeyCode keyCode)[/ICODE] to the Platform Class.  
  
We can access this with the sub:  
  

```B4X
'Returns a flag indicating whether the key corresponding To keyCode Is in the locked (Or "on") state.  
'keyCode must be one of: "CAPS" Or "NUM_LOCK".  
'If the underlying system Is Not able To determine the state of the specified keyCode, False Is returned.  
'If the keyboard attached To the system doesn't have the specified key, False is returned.  
'This method must be called on the JavaFX Application thread.  
'Java 17+  
Public Sub IsKeyLocked(KeyCode As String) As Boolean  
    Dim Platform As JavaObject  
    Platform.InitializeStatic("javafx.application.Platform")  
    Dim Optional As JavaObject = Platform.RunMethod("isKeyLocked",Array(KeyCode))  
    Return Optional.RunMethod("isPresent",Null) And Optional.RunMethod("get",Null)  
End Sub
```

  
  
[JavaDoc](https://openjfx.io/javadoc/21/javafx.graphics/javafx/application/Platform.html#isKeyLocked(javafx.scene.input.KeyCode))  
Depends on: JavaFX 17+