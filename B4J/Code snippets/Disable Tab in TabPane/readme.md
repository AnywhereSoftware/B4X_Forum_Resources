### Disable Tab in TabPane by Revisable5987
### 07/04/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/119800/)

Took a bit of hunting to find a method to disable a tab in the TabPane and the method I found wasn't quite what I've been looking for.  
  
<https://www.b4x.com/android/forum/threads/tabpane-example.36520/post-308665>  
> You can disable all tabs except of one tab:  
>   
>
> ```B4X
> Sub DisableAllTabsExceptOf(TabPane As TabPane, page As TabPage)  
> For Each tp As TabPage In TabPane.Tabs  
> Dim jo As JavaObject = tp  
> jo.RunMethod("setDisable", Array(tp <> page))  
> Next  
> End Sub
> ```
>
>   
> Use this sub to disable all tabs except of the one you want to show.

  
After looking into the setDisable method I've come up with the following which works well using the TabPane and the index of the tab.  

```B4X
Public Sub DisableTabPage(tPane As TabPane, Index As Int, Disable As Boolean)  
    Dim tabs As List = tPane.Tabs  
    Dim tPage As TabPage = tabs.Get(Index)  
    Dim jo As JavaObject = tPage  
    jo.RunMethod("setDisable", Array(Disable))  
End Sub
```

  
  
If you already have your TabPage declared you could also use:  

```B4X
Public Sub DisablePage(tPage As TabPage, Disable As Boolean)  
    Dim jo As JavaObject = tPage  
    jo.RunMethod("setDisable", Array(Disable))  
End Sub
```

  
  
I'm sure someone will now point me to where this has already been posted, but I couldn't find it ?