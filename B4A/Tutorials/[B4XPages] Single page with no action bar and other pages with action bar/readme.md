### [B4XPages] Single page with no action bar and other pages with action bar by Erel
### 12/30/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/164875/)

This is an example of how to make one of the pages show without the action bar while the others do show it.  
  
Note that usage of IME in the main activity, to find the action bar height.  
  
In each of the pages, other than the one that shows without the action bar, we need to add:  

```B4X
Private Sub B4XPage_Appear  
    Dim jo As JavaObject = B4XPages.GetManager.ActionBar  
    jo.RunMethod("show", Null)  
    Root.Parent.Height = 100%y  
End Sub
```