###  BBListItem - BCTextEngine inside CLV by Erel
### 05/27/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/131123/)

BBCodeView is a scrollable view by itself. Trying to put it inside a CLV will cause all kinds of problems.  
  
BBListItem is a modified version of BBCodeView, which is built for being contained in a CLV.  
Among other things, it only draws the currently visible text.  
It was written originally for the Pleroma client: <https://www.b4x.com/android/forum/threads/124214/#content>  
Its performance is very good if configured correctly.  
  
If you need to add many items then you will need to add and remove items as the user scrolls the list.  
  
The class is included inside the B4XPages project.  
  
![](https://www.b4x.com/android/forum/attachments/114097)  
  
Note that the "handle resize event" is unchecked in the layouts.