### ScrollingLabel_SideFade by Ivan Aldaz
### 08/19/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/126597/)

Hi  
  
This is a small mod of the ScrollingLabel view. Just adds the possibility to set side faders and its width in the Designer. They are two panels filled with gradient from transparent to the label color.  
  
![](https://www.b4x.com/android/forum/attachments/106312)  
  
I think it can be applied exactly the same way in the [BBScrollingLabel](https://www.b4x.com/android/forum/threads/b4x-bbscrollinglabel-rich-text-scrolling-label.114310/) view, by copying, pasting and arranging a bit the simple sub "AddFade" that I've added, and the first two lines in the class that hold DesignerProperties.  
  
Edit:  
  
There was a bug in the code. The transparent color was set as ARGB(0, 255, 255, 255), but this way the gradient always 'comes from' white to the label color. If the color is, for example, RGB(123, 21, 200), the initial transparent color in the gradient must be ARGB(0, 123, 21, 200). Adding this [Fredo's snippet](https://www.b4x.com/android/forum/threads/change-colors-alpha-value-to-a-given-color.72696/#content) to the class the issue is solved. The new class file is attached.