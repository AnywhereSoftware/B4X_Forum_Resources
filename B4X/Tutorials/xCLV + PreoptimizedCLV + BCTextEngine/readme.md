###  xCLV + PreoptimizedCLV + BCTextEngine by Erel
### 05/27/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/118149/)

![](https://www.b4x.com/android/forum/attachments/94609)  
  
This example uses PreoptimizedCLV to create a list of BBCodeViews.  
In most cases it will be simpler to create a single BBCodeView, as BBCodeView is scrollable. However there might be some use cases where it makes sense to put the BBCodeViews in a list.  
  
**It depends on BCTextEngine v1.77+** (<https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/page-1>)  
And PreoptimizedCLV: <https://www.b4x.com/android/forum/threads/115289/#content>  
  
Notes  
  
- As the BBCodeViews are reused it will not be trivial to add inner views.  
- In B4J and B4i, the list width is expected to be kept constant.  
- The list is a bit jumpy in debug mode. Should be smooth in release mode.