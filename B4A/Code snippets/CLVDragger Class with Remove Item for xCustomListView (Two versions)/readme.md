### CLVDragger Class with Remove Item for xCustomListView (Two versions) by GeoT
### 02/26/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/145945/)

wes58's class called [[B4X][class] CLVDragger - drag to reorder elements](https://www.b4x.com/android/forum/threads/b4x-class-clvdragger-drag-to-reorder-items.120437/#content) allows B4a's xCustomListView class to be able to change the order of its items by dragging them across a Label, as well as add items.  
It's a class that can be mentioned perhaps in [[B4X] [XUI] xCustomListView - cross-platform CustomListView](https://www.b4x.com/android/forum/threads/b4x-xui-xcustomlistview-cross-platform-customlistview.84501)  
  
I have extended it by adding the function to remove the items one by one when dragging horizontally to the left from a Label  
(Now the item is either removed or dragged to a new position)  
  
Maybe it can be improved by putting it in a B4XPage and using views from the XUI Views library, for example.  
  
But you could also:  
  
- edit the multiline text of the Label of each item with a B4XDialog and with a LongClick on the Item, for example  
  
- remember the changes: the order of the items by controlling the order of the texts and the checked states of the CheckBoxes through various lists. For when the device is rotated  
  
- save all data changes to two files from the lists, although it could be saved to a single file using JSON, for example  
  
But I'll post that if anyone is interested.  
  
  
**Please, read the entire thread.**  
  
- CLVDragger\_RemoveItems and corrections -> Post 1 to 3, and 8  
- CLVDragger\_Remove\_Edit\_Swipe and corrections -> Post 4 to7  
  
  
Dependencies: Reflection, xCustomListView and XUI Views libraries.  
  
[MEDIA=youtube]LkjMoexGK9k[/MEDIA]  
  
I attach the example.  
  
Greetings