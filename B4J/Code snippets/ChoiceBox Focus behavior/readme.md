### ChoiceBox Focus behavior by jkhazraji
### 06/18/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/161689/)

At the present setting, the choiceBox does not open the choice list when it gets the focus by keyboard tab unless one would press the spacebar.  
This simple code snippet would change this behavior to open the choice list and hopefully spare an extra move :) .  

```B4X
    '  
    '  
    '  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    cb.Initialize("cbEvent")  
    Dim L As List  
    L.Initialize  
    L.AddAll(Array As String("value1", "value2","value3", "value4","value5", "value6"))  
    cb.Items.AddAll(L)  
     
   
    Dim e As Object = cb.As(JavaObject).CreateEvent("javafx.beans.value.ChangeListener", "cbFocusChange", False)  
    cb.As(JavaObject).RunMethodJO("focusedProperty",Null).RunMethod("addListener", Array(e))  
   
    cb.Visible=True  
    MainForm.RootPane.AddNode(cb,200,20,200,40)  
    MainForm.Show  
    '  
    '  
  
Private Sub CbFocusChange_Event(MethodName As String, Args() As Object)  
   
    If MethodName="changed" Then  
        Dim data As String= Args(0).As(String)  
        Dim focusStatus As Boolean=data.SubString2(data.IndexOf("value:") + 7,data.Length-1).Trim  
        If focusStatus=True Then  
            cb.RequestFocus  
            cb.As(JavaObject).RunMethod("show",Null)  
        Else  
            cb.HideChoices  
            cb.As(JavaObject).RunMethod("hide",Null)  
            
        End If  
        
    End If  
    
End Sub
```