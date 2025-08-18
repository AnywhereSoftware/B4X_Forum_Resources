###  [B4XPages] CustomListView + Keyboard handling by Erel
### 05/26/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/131078/)

![](https://www.b4x.com/android/forum/attachments/113999)  
This is a B4A + B4i project that shows a possible method for handling the keyboard visibility changes.  
Resizing the CLV will cause the list to lose the scroll position. Instead of resizing the list, we add a stub item as the last item, with the same size of the keyboard. This way the user can still reach the last real item.  
A small downside for this solution, is that the scrollbar indicator becomes less useful when the keyboard appears.   
You also need to be aware that the last item in the CLV can be a stub item. See the code. It is quite simple.  
  
Note that handling the keyboard in B4A requires some configuration: <https://www.b4x.com/android/forum/threads/b4x-b4xpages-cross-platform-and-simple-framework-for-managing-multiple-pages.118901/post-745090> (already implemented in this example).