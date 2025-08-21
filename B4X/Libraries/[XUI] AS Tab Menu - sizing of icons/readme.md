###  [XUI] AS Tab Menu - sizing of icons by Alessandro71
### 07/27/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/120620/)

in the following example code from the main thread, where does the 30 (size of rendered font bitmap) comes from?  

```B4X
ASTabMenu_horizontal.AddTab(xui.Color_ARGB(255,39, 174, 97),"",ASTabMenu_horizontal.FontToBitmap(Chr(0xF015),False,30,xui.Color_White),"")
```

  
height in the layout are expressed in dip, while for fonts are not  
how do you make sure your icon is at the correct size, on different density displays?