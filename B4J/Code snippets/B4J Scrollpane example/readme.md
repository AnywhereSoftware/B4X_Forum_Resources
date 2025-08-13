### B4J Scrollpane example by PaulMeuris
### 12/18/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/164675/)

In this thread: [AutoShowScrollbar in CustomListView](https://www.b4x.com/android/forum/threads/solved-autoshowscrollbar-in-customlistview.164612/#post-1009470) a CustomListView is used to present a row of buttons or labels.  
As the CLV uses an internal Scrollpane you can also present the row of buttons using a Scrollpane and a buttons Pane.  
Here's how it could look like:  
![](https://www.b4x.com/android/forum/attachments/159607)  
The horizontal scrolling is performed by dragging a button left or right.  
![](https://www.b4x.com/android/forum/attachments/159608)  
After the dragging you can click on a button if you move the mouse cursor a few pixels (to deactivate the dragging).  
The Scrollpane, buttons Pane and button Labels are created in code.  
You can find the source code in the attachment.