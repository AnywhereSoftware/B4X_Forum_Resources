###  CLVBackwards - xCLV extenstion for lists that grow backwards by Erel
### 01/12/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/126444/)

This class can be helpful in esoteric cases where the list grows up instead of down. Think of a chat app where you start with the most recent messages and when the user scrolls up, more older messages are added to the top.  
  
The challenge here is to add items without making the list jump back and forth.   
It is important to understand how it is implemented as it affects the usage.   
When CLVBackwards is initialized, it adds a very large "spacer" item as the first CLV item.  
Later when we add items with Backwards.AddItem, the item is inserted after the spacer, and the spacer becomes shorter. This way the list size never changes.  
  
The class also handles the case where you want to remove the spacer. This is relevant if you don't want to insert more items at the top (and obviously the user shouldn't scroll into the large spacer).   
  
Notes:  

1. Set the divider height to 0.
2. Remove the scroll bars.
3. See the example code and don't miss the call to IsReady.

  
The class is inside the cross platform example project.