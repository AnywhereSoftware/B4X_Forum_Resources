### Change single view's element style (CSS subclass) at runtime by Gandalf
### 10/11/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/163504/)

Here's how it can be done:  

```B4X
Sub StyleCSSsubclass (targetView As B4XView, subclass As String, style As String)  
    Dim subTarget As Node = targetView.As(JavaObject).RunMethodJO("lookup", Array(subclass))  
    If subTarget <> Null Then  
        Dim jo As JavaObject = subTarget  
        jo.RunMethod("setStyle", Array(style))  
    End If  
End Sub
```

  
  
For example, let's change color of small arrow on right side of ComboBox (declared as ComboBox):  

```B4X
StyleCSSsubclass(ComboBox1.As(B4XView), ".arrow-button .arrow", "-fx-background-color: #FF0000;")
```

  
  
If you don't know what subclass and style you need to use for certain view, ask ChatGPT. Better use tuned GPT - click on Explore GPTs button in ChatGPT interface and search for CSS keyword. I use HTML & CSS Expert one. Most answers are correct, or at least pointing to the right direction. This code snippet uses part of such answer.  
  
UPD: According to [Erel's advice](https://www.b4x.com/android/forum/threads/change-single-views-element-style-css-subclass-at-runtime.163504/post-1002919), it should look like this:  

```B4X
Sub StyleCSSsubclass (targetView As B4XView, subclass As String, property As String, value As String)  
    Dim subTarget As Node = targetView.As(JavaObject).RunMethodJO("lookup", Array(subclass))  
    If subTarget <> Null Then CSSUtils.SetStyleProperty(subTarget, property, value)  
End Sub
```

  
And usage example:  

```B4X
StyleCSSsubclass(ComboBox1.As(B4XView), ".arrow-button .arrow", "-fx-background-color", "#FF0000")
```

  
Depends on CSSUtils internal library.