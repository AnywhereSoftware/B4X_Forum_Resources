###  GradientMaker - cross platform gradient background by Erel
### 02/13/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/165597/)

![](https://www.b4x.com/android/forum/attachments/161692) ![](https://www.b4x.com/android/forum/attachments/161693) ![](https://www.b4x.com/android/forum/attachments/161694)  
  
  
Usage example:  

```B4X
Dim gd As GradientMaker  
gd.Initialize  
gd.SetGradient(View, "TOP_BOTTOM", Array(XUI.Colors_Red, 0xFF00FF00)) 'same orientations as GradientDrawable. Supports any number of colors.
```

  
  
See the attached example.  
  
BTW, the example uses the nice DDDGrid class: <https://www.b4x.com/android/forum/threads/b4x-dse-dddgrid-designer-script-grid.142402/#content>