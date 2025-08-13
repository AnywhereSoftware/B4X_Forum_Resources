### [XUI] JNSeekBar with gradient by John Naylor
### 09/11/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/162991/)

JNSlider allows you to put an icon at the left or right of a slider bar, or top or bottom if the control is vertical. Clicking the icon will expand or contract the slider. The slider can start visible or hidden. The size of the icon is set by the size of the control (eg. height x height if the control is horizontal).  
  
The seek bar can be locked open or closed.  
  
The main bar can be made up of one or more colours in a gradient. For example the default colour scheme (if you do not set one yourself) is an RGB gradient and would be achieved as follows  
  

```B4X
    Dim clrMap1 As Map  
    clrMap1.Initialize  
    clrMap1.Put(0, xui.Color_Red)  
    clrMap1.Put(50, xui.Color_Green)  
    clrMap1.Put(100, xui.Color_Blue)  
    JNSeekBar1.SetColorMap (clrMap1)
```

  
  
There are more examples in the demo.  
  
There is a Width adjust property to change the thickness of the bars.  
  
Tested on B4A, B4J, B4I (Thanks @f0raster0[USER=59302])[/USER]  
  
![](https://www.b4x.com/android/forum/attachments/156740)  
Based on the XUI B4X Seekbar.