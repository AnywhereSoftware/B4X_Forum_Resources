### Hiding a HorizontalScrollView's scrollbar by walt61
### 09/29/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/172170/)

Requires the JavaObject library:  

```B4X
Dim HSV As HorizontalScrollView  
Dim jo As JavaObject = HSV  
jo.RunMethod("setHorizontalScrollBarEnabled", Array(False))
```