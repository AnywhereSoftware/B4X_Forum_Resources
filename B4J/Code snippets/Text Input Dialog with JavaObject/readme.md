###  Text Input Dialog with JavaObject by androh
### 05/28/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/131156/)

For use JavaFx TextInput Dialog  
<https://docs.oracle.com/javase/8/javafx/api/javafx/scene/control/TextInputDialog.html>  
  

```B4X
        Dim jo As JavaObject  
        jo.InitializeNewInstance("javafx.scene.control.TextInputDialog", Null)  
        jo.RunMethodJO("setTitle", Array As String("Sample Title"))  
        jo.RunMethod("setHeaderText", Array As String("Sample Text"))  
          
  
        If jo.RunMethodjo("showAndWait", Null).RunMethod("isPresent", Null)=True Then  
            'ok button pressed  
            Dim txt As String=jo.RunMethodJO("getEditor", Null).RunMethod("getText", Null)  
            Log(txt)  
        End If
```