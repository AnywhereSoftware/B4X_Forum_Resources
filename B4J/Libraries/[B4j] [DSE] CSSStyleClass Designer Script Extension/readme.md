### [B4j] [DSE] CSSStyleClass Designer Script Extension by stevel05
### 10/13/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/143060/)

With the new Designer Script Extensions, Erel has given us Class Names for views similar to the B4j CSS class names.  
  
For those wanting to use the actual CSS classes and styling in B4j, it is just as easy to add CSS class names to Nodes directly in the designer using the Designer Script Extensions.  
  
This is a method to do just that. You can download the b4xlib and add that to your B4x additional libs folder, or just copy the method to any class.  
  
Usage in the Designer Script:  
  

```B4X
DSE_CSSStyleClass.AddStyleClass("button-sl",Button1)
```

  
  
You can also add more styleclasses and/or views in one go if you wish:  
  

```B4X
DSE_CSSStyleClass.AddStyleClass("button-sl, class-2",Button1,Button2,Button3)
```

  
  
  
  

```B4X
'Parameters: ClassNames As String (Comma delimited), 1 or more Views comma delimited  
'Designer Script : DSE_CSSStyleClass.AddStyleClass("button-sl",Button1,Button2,Button3)  
Public Sub AddStyleClass(DesignerArgs As DesignerArgs)  
#If B4j  
    If DesignerArgs.FirstRun Then  
        Dim ClassNames() As String = Regex.Split(",",DesignerArgs.Arguments.Get(0))  
        For i = 1 To DesignerArgs.Arguments.Size - 1  
            Dim V As Node = DesignerArgs.GetViewFromArgs(i)  
            For Each ClassName As String In ClassNames  
                ClassName = ClassName.Trim  
                If V.StyleClasses.IndexOf(ClassName) = -1 Then  
                    V.StyleClasses.Add(ClassName)  
                End If  
            Next  
        Next  
    End If  
#End If  
End Sub
```