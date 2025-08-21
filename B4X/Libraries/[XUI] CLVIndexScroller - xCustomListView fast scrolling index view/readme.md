### [XUI] CLVIndexScroller - xCustomListView fast scrolling index view by Biswajit
### 05/12/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/117636/)

It's a class that adds a fast scrolling index view to xCustomListView. It has a dark and a light mode. You can show either alphabetic or numeric index and can change the index order.  
  
![](https://www.b4x.com/android/forum/attachments/93834) ![](https://www.b4x.com/android/forum/attachments/93835)  
  
**Dependencies**:  

1. xCustomListView
2. XUI / jXUI

**Note**:  

1. CLV items must be in sorted order.
2. CLV items should have a label.
3. CLVIndexScroller will scroll CLV depending upon the first label view of the CLVItem.
4. After adding/removing CLV items remember to call CLVIndexScroller Refresh function.

**Usage**:  

```B4X
Dim clv As CustomListView  
Dim clvIS As CLVIndexScroller  
  
For i=0 To 25  
    For j=0 To 7  
        clv.AddTextItem(Chr(i+65) & "-Lorem Ipsum" ,"")  
    Next  
Next  
''Initialize (clv As CustomListView, IndexTypeNumeric As Boolean, DarkTheme As Boolean, AscendingOrder As Boolean)  
clvIS.Initialize(clv,False,True,True)  
  
''Change active item color  
clvIS.SetActiveColor(Colors.Green)  
  
''Set active index theme  
clvIS.SetActiveIndexTheme(clvIS.ACTIVE_INDEX_THEME_AUTOPOS)  
  
''Call update to refresh the active index while manual scrolling  
Sub clv_ScrollChanged (Offset As Int)  
    clvIS.Update  
End Sub
```

  
  
**It's compatible with B4A, B4I and B4J.  
  
Update 1.01:** Fixed crash issue when adding a panel instead of a text item.  
**Update 1.10:** Added two active index theme fixed and auto position (check image).clvIS.SetActiveIndexTheme(clvIS.ACTIVE\_INDEX\_THEME\_AUTOPOS)