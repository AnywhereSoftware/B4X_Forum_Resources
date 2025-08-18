### CustomListView multiselections for desktop by Chris2
### 09/23/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/133812/)

This is an amended and simplified class based on [USER=1]@Erel[/USER]'s CLVSelections class - <https://www.b4x.com/android/forum/threads/b4x-clvselections-extended-selection-modes-for-xcustomlistview.114364/>.  
  
It is for desktop use only and is intended to operate in a similar way to how multiselections are handled in Windows File Explorer using Ctrl & Shift keys.  
Note that it is slightly different in that with this class you do not need to hold both Ctrl & Shift to keep previous selections when adding a range of items.  
  
It uses [USER=448]@agraham[/USER]'s jReflection library - <https://www.b4x.com/android/forum/threads/jreflection-library.35448/>.  
Also depends on B4XCollections, xCustomListView and XUI libraries.  
  
Usage is similar to the CLVSelections class:  
Initialise the object:  

```B4X
clvSelect.Initialize(clv1, True)
```

  
And remember to add the item click event:  

```B4X
Sub clv1_ItemClick (Index As Int, Value As Object)  
    clvSelect.ItemClicked(Index)  
End Sub
```

  
  
Note also that I've removed everything that I wasn't using from the CLVSelections class, including the VisibleRangeChanged sub, so it may not work with lazy loading  
  
I'll gladly accept any comments, improvement suggestions, or criticism!  
  
2021-09-23 - Class amended to remove '&' from the comments and prevent the IDE error "An error occurred while parsing EntityName. Line 1, position 214."