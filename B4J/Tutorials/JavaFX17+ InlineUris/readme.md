### JavaFX17+ InlineUris by stevel05
### 08/10/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168176/)

JavaFX17 added the possibility to use inlineURIs. One use for this is to add small CSS Stylesheets from code:  
  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
   
    MainForm.Stylesheets.Add(GetDataURI(StyleSheet))  
  
End Sub  
  
Private Sub StyleSheet As String  
    Return $"  
.button{  
    -fx-background-color:green;  
}"$  
End Sub  
  
Private Sub GetDataURI(Data As String) As String  
    Dim SU As StringUtils  
    Return "data:text/css;base64," & SU.EncodeBase64(Data.GetBytes("UTF-8"))  
End Sub
```

  
  

![](https://www.b4x.com/android/forum/attachments/165942)

  
Simple to use and very useful for libraries where you would otherwise need to add a stylesheet to the Files directory.  
  
**DependsOn** :   

- JavaFX 17+
- jStringUtils (Internal library)