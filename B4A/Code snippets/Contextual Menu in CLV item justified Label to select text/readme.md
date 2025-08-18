### Contextual Menu in CLV item justified Label to select text by endbyte
### 12/03/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/136543/)

based 100% on this contribution from erel: <https://www.b4x.com/android/forum/threads/custom-context-menu-for-text-selection.81596/>  
  
Greetings to all, I want to publish this to help others who, like me, are newbies to b4a, since a few days ago I was having the need to select text in a LABEL with justified text that I use within a CLV to show certain large strings and I could not find something that will help me to do it until I found this example of erel to customize the context menu, using java code, and it has been my basis for the solution to this need, I must clarify that I hardly know anything about java programming, but I managed to do these modifications and adapt it to be able to select the text of my LABEL in the CLV items and later color those portions of text, I hope it is understood and it helps others as well as it served greatly for me and please, if there are errors, let them know in public So that we all learn more, I am not an expert but maybe one day I will be ?, greetings.  
  
  
![](https://www.b4x.com/android/forum/attachments/122613)  
  

```B4X
    Dim jo As JavaObject = lbl  
    jo.RunMethod("setTextIsSelectable", Array As Object(True))
```

  
  
  
  

```B4X
Sub ContextMenu_Create(ActionMode As JavaObject, FocusedView As View)  
    Dim menu As JavaObject = ActionMode.RunMethod("getMenu", Null)  
    menu.RunMethod("clear", Null)  
    Dim event As Object = menu.CreateEvent("android.view.MenuItem.OnMenuItemClickListener", "ContextMenuClick", True)   
    For Each s As String In Array("Colorear Seleccion") 'menu items here  
        menu.RunMethodJO("add", Array(s)).RunMethod("setOnMenuItemClickListener", Array(event))  
    Next  
    Wait For ContextMenuClick_Event (MethodName As String, Args() As Object)  
    Dim MenuItem As JavaObject = Args(0)  
    Dim title As String = MenuItem.RunMethod("getTitle", Null)  
    Log(title & " was clicked!") '<—- do what ever you like with the click!!!  
  
    If FocusedView Is Label Then  ' I use a LABEL with justified text strings in my CLV items  
        Dim et As Label = FocusedView  
        '*** the getseleccionini method returns the initial position of my selection within the string  
        Dim jo As JavaObject = Me  
        Dim selectioninicial As Int = jo.RunMethod("getSelectionIni", Array(et))  
        Log("Inicia en "&selectioninicial) 'selection starting position  
  
        '*** the getseleccionfin method returns the final position of my selection within the string  
        Dim jo As JavaObject = Me  
        Dim selectionFinal As Int = jo.RunMethod("getSelectionFin", Array(et))  
        Log("Finaliza en "&selectionFinal) 'final position of the selection  
        
        Select title  
            Case "Colorear Seleccion"  
                'when I get the two coordinates I only color my selection  
        End Select       
    End If  
    
    ActionMode.RunMethod("finish", Null)  
End Sub  
  
#if Java  
   
 import android.view.*;  
 import anywheresoftware.b4a.AbsObjectWrapper;  
 import android.text.Selection;  
 import android.widget.TextView;  
    @Override  
    public void onActionModeStarted(ActionMode mode) {  
        processBA.raiseEvent(this, "contextmenu_create", AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), mode),  
            AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.ConcreteViewWrapper(), getCurrentFocus()));  
        super.onActionModeStarted(mode);  
    }  
    @Override  
    public void onActionModeFinished(ActionMode mode) {  
        super.onActionModeFinished(mode);  
    }  
    public static int getSelectionFin(TextView et) {  
        return Selection.getSelectionEnd(et.getText());  
    }   
    public static int getSelectionIni(TextView et) {  
        return Selection.getSelectionStart(et.getText());  
    }  
#End If
```