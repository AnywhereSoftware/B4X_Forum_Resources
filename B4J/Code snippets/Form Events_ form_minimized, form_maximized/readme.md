### Form Events: form_minimized, form_maximized by jkhazraji
### 01/08/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/157724/)

I thought it would be handy if one could capture these events in b4j. Many people have posted in the forum about this but I considered it as a self-challenge  
to bring it by myself as a local b4j event, thanks to inline Java, JavaObject library and the resourceful b4x community that we enjoy as a special experience.  
Here is my code:  
enjoy!  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    Dim joform As JavaObject = MainForm  
    Dim joStage As JavaObject=joform.GetFieldJO("stage")  
    (Me).As(JavaObject).RunMethod("ifStageIsIconified",Array(joStage))  
    (Me).As(JavaObject).RunMethod("ifStageIsMaximized",Array(joStage))  
     
End Sub  
  
Private Sub form_minimized(isMinimized As Boolean)  
    Log($"Form minimized: ${isMinimized}"$)  
     
End Sub  
  
Private Sub form_maximized(isMaximized As Boolean)  
    Log($"Form maximized: ${isMaximized}"$)  
     
End Sub  
#if Java  
  
import javafx.collections.ObservableList;  
import javafx.beans.value.ChangeListener;  
import javafx.beans.value.ObservableValue;  
  
public static void ifStageIsIconified(Stage stage){  
  
    stage.iconifiedProperty().addListener(new ChangeListener<Boolean>() {  
  
    @Override  
    public void changed(ObservableValue<? extends Boolean> ov, Boolean t, Boolean t1) {  
        Boolean minimized = t1.booleanValue();  
        ba.raiseEvent(getObject(), "form_minimized", minimized);  
    }  
});  
  
}  
public static void ifStageIsMaximized(Stage stage){  
  
    stage.maximizedProperty().addListener(new ChangeListener<Boolean>() {  
  
        @Override  
        public void changed(ObservableValue<? extends Boolean> ov, Boolean t, Boolean t1) {  
            Boolean maximized = t1.booleanValue();  
            ba.raiseEvent(getObject(), "form_maximized", maximized);  
        }  
    });  
  
}  
#end if
```