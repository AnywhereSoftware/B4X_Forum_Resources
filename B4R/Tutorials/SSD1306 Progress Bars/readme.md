### SSD1306 Progress Bars by Mostez
### 03/02/2021
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/128186/)

Based on [SSD1306 module](https://www.b4x.com/android/forum/threads/ssd1306-module.127874/#post-803971), we can implement horizontal and vertical progress bars. These bars could be drawn at X1-Y1 to X2-Y2 like drawing rectangles, also we need to pass the full scale value(max value) and the recent value. this code example draws horizontal progress bar at 0-15 to 100-22 with full scale value of 100, and displays value of 78. The vertical progress bar works the same as horizontal one, but it displays the values vertically. HBAR and VBAR modules included in SSD1306 update link above.  
  

```B4X
HBAR.Draw(0,15,100,22,100,78)
```

  
  
![](https://www.b4x.com/android/forum/attachments/108934) ![](https://www.b4x.com/android/forum/attachments/108935)