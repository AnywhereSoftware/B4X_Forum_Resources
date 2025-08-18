###  Set CSBuilder or Text to a Label by Erel
### 10/20/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/102118/)

**Edit: This sub is included in XUI Views library: XUIViewsUtils.SetTextOrCSBuilderToLabel**  
  
This sub accepts a string or CSBuilder and sets it as the Label's text. It is useful for cross platform solutions.  
Note that the Text parameter type is Object.  

```B4X
Public Sub SetTextOrCSBuilderToLabel(xlbl As B4XView, Text As Object)  
   #if B4A or B4J  
   xlbl.Text = Text  
   #else if B4i  
   If Text Is CSBuilder And xlbl Is Label Then  
       Dim lbl As Label = xlbl  
       lbl.AttributedText = Text  
   Else  
       If GetType(Text) = "__NSCFNumber" Then Text = "" & Chr(Text)  
       xlbl.Text = Text  
   End If  
   #end if  
End Sub
```

  
  
In order to support FontAwesome or Material Icons characters (in B4i), the code needs to check whether the value is a number and if so it treats it as a unicode point value.  
  
If you want to pass a number then convert it to a string first:  

```B4X
SetTextOrCSBuilderToLabel(lbl, "" & 123)
```