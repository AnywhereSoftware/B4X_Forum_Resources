### A more elegant way to detect platform by William Lancee
### 02/16/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/127718/)

I have been using #if B4A for several years. Then yesterday I looked at the source code for B4XPageManager, and there [USER=1]@Erel[/USER] sometimes uses xui.isB4A.  
I wanted to allow for the slower speed of Android device so I used xui.isB4A for the first time. I like it. Thank you [USER=1]@Erel[/USER].   
  

```B4X
     If xui.IsB4A Then Sleep(5500) Else Sleep(4500)
```

  
  
Note there is also xui.isB4J and xui.isB4i.