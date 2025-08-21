###  CLVSelections - extended selection modes for xCustomListView by Erel
### 02/26/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/114364/)

This class extends xCustomListView library and adds more selection modes:  
  
MODE\_SINGLE\_ITEM\_TEMP - The same as the default behavior.  
MODE\_SINGLE\_ITEM\_PERMANENT - Single item is selected and the selection remains.  
MODE\_MULTIPLE\_ITEMS- Multiple items can be selected.  
  
There is also a helper method that selects an item and makes it visible.  
  
Usage:  
  
Initialize a CLVSelections object and set the selection mode:  

```B4X
CSelections.Initialize(CustomListView1)  
CSelections.Mode = CSelections.MODE_MULTIPLE_ITEMS
```

  
  
Implement the ItemClick event:  

```B4X
Sub CustomListView1_ItemClick (Index As Int, Value As Object)  
    CSelections.ItemClicked(Index)  
End Sub
```

  
  
If using lazy loading then also call from VisibleRangeChanged (at the end):  

```B4X
CSelections.VisibleRangeChanged(FirstIndex, LastIndex)
```

  
  
Depends on B4XCollections, xCustomListView and XUI libraries.  
  
B4J example is attached. The class is included inside.