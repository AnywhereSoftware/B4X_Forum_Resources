### Set default button by LucaMs
### 12/02/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/144548/)

**Author: [USER=9800]@stevel05[/USER]**  
  
Allows you to set the button whose Click event will be executed when the Enter key is pressed.  
  
This is especially useful in dialog forms. It can be used, for example, to set the default button of a B4XDialog (see [this post](https://www.b4x.com/android/forum/threads/solved-b4xdialog-default-button.144500/post-916281)).  
  

```B4X
Button1.As(JavaObject).RunMethod("setDefaultButton", Array(True))
```

  
  
*Button1 can be declared as either a Button or a B4XView.*