### iAXMaterialProgress by User242424
### 10/21/2020
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/123699/)

***Hello World!*  
Another B4i Library: A material style progress wheel for iOS ?**  
  
[SIZE=5][See library in Github](https://github.com/Aghajari/iAXMaterialProgress)[/SIZE]  
  
This is how it looks in indeterminate mode (the spinSpeed here is 0.64 which is the default, look below how to change it):  
  
[![](https://github.com/Aghajari/iAXMaterialProgress/raw/main/spinningwheel.gif)](https://github.com/Aghajari/iAXMaterialProgress/blob/main/spinningwheel.gif)  
  
And in determinate mode (here the spinSpeed is set to 0.333):  
  
[![](https://github.com/Aghajari/iAXMaterialProgress/raw/main/spinningwheel_progress.gif)](https://github.com/Aghajari/iAXMaterialProgress/blob/main/spinningwheel_progress.gif)  

- **barColor:** sets the small bar's color (the spinning bar in the indeterminate wheel, or the progress bar)
- **barWidth:** the width of the spinning bar
- **rimColor:** the wheel's border color
- **rimWidth:** the wheel's width (not the bar)
- **spinSpeed:** the base speed for the bar in indeterminate mode, and the animation speed when setting a value on progress. The speed is in full turns per - - second, this means that if you set speed as 1.0, means that the bar will take one second to do a full turn.
- **circleRadius:** the radius of the progress wheel, it will be ignored if you set fillRadius to true
- **linearProgress:** set to true if you want a linear animation on the determinate progress (instead of the interpolated default one).

  

```B4X
Dim Progress As iAXMaterialProgress  
Progress.Initialize("Amir")  
Page1.RootPanel.AddView(Progress,50%x-28dip,30%y-28dip,56dip,56dip)  
Progress.SetProgressSize(56dip,56dip)  
Progress.Start  
  
'Change Bar Color  
Progress.SetBarColor(BarColor)
```

  
  
Lib+Sample attached :)