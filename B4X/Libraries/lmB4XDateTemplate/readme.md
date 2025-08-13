###  lmB4XDateTemplate by LucaMs
### 11/24/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/164207/)

*[SIZE=5][It's crossplatform, like the original, of course][/SIZE]*  
  
  
**EDIT: Use the library, it's much more convenient:**  
<https://www.b4x.com/android/forum/threads/b4x-b4xlib-lmb4xmultidatedlg.164249/post-1007266>  
  
  
I needed a "date picker" that shows "full" days, days for which I have data in a DB.  
  
So I modified the official B4XDateTemplate.  
I'm still modifying it; when it will be "completed", I will publish it, also attaching an example with a very small test DB.  
  
Note that a DB is not necessary, you just have to pass a list of Int, the days to highlight for the month and year shown.  
  
I will calmly provide the possibility to switch between dark and light theme, although you can change all the colors you want.  
  
One thing that I consider "important", even if what I needed was the highlighting of some days, is that I removed the 3 labels for the year selection that I replaced with a B4XPlusMinus.  
It is very useful, because with the labels you need to do many clicks to change the year (I'm only thinking about it now: probably I could have implemented the long click on the two labels, + and -).  
For now I have the problem that I could not make the B4XPlusMinus look the same as the original B4XDateTemplate, that is, like the one for the month selection.  
  
You can choose whether to highlight the selected days with a circle or a rectangle.  
You can also choose whether all days will be clickable or only the highlighted ones.  
  
  
![](https://www.b4x.com/android/forum/attachments/158778)