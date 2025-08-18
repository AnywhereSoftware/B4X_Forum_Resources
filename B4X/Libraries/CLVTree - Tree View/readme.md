###  CLVTree - Tree View by Erel
### 07/13/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/132472/)

CLVTree extends xCustomListView and turns it into a tree view:  
  
![](https://www.b4x.com/android/forum/attachments/116228)  
  
Usage:  
1. Add a CustomListView with the designer.  
2. Initialize CLVTree and add items:  

```B4X
    Tree.Initialize(CustomListView1)  
    For i = 1 To 10  
        Dim item As CLVTreeItem = Tree.AddItem(Tree.Root, $"Item #${i}"$, Null, "")  
    Next
```

  
  
More information in the attached cross platform example.  
  
**Notes**  
  
- The UI is lazy loaded, this means that the views are only created for the visible items and they are later reused.  
- The items text can be a regular string or CSBuilder.  
- To allow making multiple changes efficiently, the UI isn't updated immediately. You should call Tree.Refresh to update it.  
- As the code uses the new IIf and As keywords, it requires B4i 7.5+, B4J 9.1+ or B4A 11+.  
- There are currently no animations. Might be added in the future.  
  
**Updates**  
  
v1.01 - Tree.Clear method. Removes all items.