### SD: DragBoard by Star-Dust
### 05/11/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/81367/)

**![](https://www.b4x.com/android/forum/attachments/67015)  
  
(No WRAP, No Java Only B4A)**   
  
I had to change my color, **updating** and changing different parts.  
I also called it differently. So if you have previous projects you will need to update the declaration of the variables.  
  
  
This library contains three classes.  
  
The **first** "[SIZE=5]DragBoard[/SIZE]" allows you to move single-label (containing only one string) from one column to another, to activate the shift by clicking a longer touch. Delete or edit each item by clicking a shortcut (if enabled by customView). It supports the addition of a single item for each column (CustomView enabled) and the alphabetical sorting of entries within a column (enabled by CustoView). It also lets you move whole columns of labels  
  
The **second** "[SIZE=5]DragPanel[/SIZE]" allows you to move Panels from one column to another (each panel can hold any view object you want, the panel should not be changed in dimension, and the background in Color should not be changed). To activate the move, click on a longer touch. To erase or edit each item by clicking a shortcut (if enabled by customView). And will raise an event that invokes a sub in your app you manage to edit. It supports the event by adding a single item for each column (CustomView enabled) and the event sorting by alphabetic (CustoView enabled). These events are handled by you in the sub which is raised. It also lets you move whole columns of panel  
  
The **third** "[SIZE=5]DragListView[/SIZE]" is a listview that allows you to move individual entries from one line to another by dragging, it can contain one or two lines of text and a Swicht button (You can also access the panel to add more objects but the Events will not be managed by the library). To activate the move, click on a longer touch. Capture or edit every single element by clicking a short touch (if activated by customView). And will raise an event that invokes a sub in your app you manage to edit. It supports the event by adding a single item for each column (CustomView enabled) and the event sorting by alphabetic (CustoView enabled). These events are handled by you in the sub which is raised.  
  
the **fourth** "**[SIZE=4]DragDrop[/SIZE]**" class is a class (not a CustomView type) that is used to handle dragging the view. The moving views will be passed as a parameter to the class and so will the objects that will serve as a place or the coordinates that will serve as a place of arrival. The rest will do the class, every time you drag and drop an event.  
  
**The first three** also have a title bar. The bar can contain the Confirm button (if enabled) and delete (if enabled).m On the left also contains the menu button, which raises an event. If enabled by customView, the **Menu** button in addition to lifting an event opens a panel to the left. The **panel** can hold what you want. A listView, a menu etc …