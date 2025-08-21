### [tool] ScenicView by Erel
### 08/11/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/121093/)

ScenicView is a JavaFX tool that allows you to see the UI structure of other JavaFX apps. It can be useful when debugging issues with complex layouts.  
  
Download from:  
<https://github.com/JonathanGiles/scenic-view>  
  
![](https://www.b4x.com/android/forum/attachments/98353)  
  
Find the batch file and run it.  
  
It just helped me solve a complex issue with B4X-Pleroma client where a view didn't respond to touch events. Using this tool I discovered that the underlying view became disabled (B4XDialog disables the views when it closes and re-enables them when the dialog appears).