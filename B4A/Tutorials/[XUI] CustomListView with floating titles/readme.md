### [XUI] CustomListView with floating titles by Erel
### 04/21/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/87935/)

![](https://www.b4x.com/basic4android/images/clv_floatingtitle.gif)  
  
Title items are added to the list.  
A Panel is set above the list. The panel shows the current title when the top visible item is not a title item.  
  
It works by checking for the top item type. If it is a title item then the panel is hidden, otherwise the panel is shown with the current title.  
  
The title layout should be anchored to the bottom. This allows the same layout to be loaded to the panel and to the cell items.  
The panel is slightly taller to compensate for the two dividers.  
It is recommended to remove the call to AutoScaleAll. Otherwise the switch between the cell title and the panel title will not be accurate (as the variants sizes are different).  
  
It should be simple to implement the same solution in B4J and B4i.