### standard tooltips for Android 8+ by Dave O
### 10/10/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/143440/)

For tooltips (press-and-hold on a view to show some explanatory text), in the past I used a hack in my apps to position a toast message near the view. This has stopped working on certain recent versions of Android (I'll cover that in a separate post), so I went looking for a better solution.  
  
It turns out that Android 8 added a proper way to define tooltips (with Android 8+ currently covering more than 90% of devices).  
  
As far as I know, we can't do this yet in B4A natively (**aView.tooltip = "bleem"**), so here's a sub that uses JavaObject to call that Java method:  
  

```B4X
'in each activity, I use a single sub to add all the tooltips on that screen  
Sub addAllTooltips  
    setTooltip(saveButton, "Save & done")  
    setTooltip(cancelButton, "Cancel")  
End Sub  
  
'on Android 8+, attaches a tooltip to the given view.  
'Ignored on earlier versions of Android  
Sub setTooltip(viewArg As View, textArg As String)  
    Dim p As Phone  
    If p.SdkVersion >= 26 Then  
        Dim viewJO As JavaObject = viewArg  
        viewJO.RunMethod("setOnLongClickListener", Array As Object(Null))   'remove any longClick listener  
        viewJO.RunMethod("setTooltip", Array As Object(textArg))  
    End If  
End Sub
```

  
  
Hope this helps!