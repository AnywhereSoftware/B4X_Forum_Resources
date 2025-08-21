### Tip: CSBuilder usage by ShepSoft
### 07/07/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/119922/)

A small point about CSBuilder.   
You cannot mix CSBuilder objects with 'standard' text because the formatting will be lost.  
This works as expected:  

```B4X
    cs.Initialize.Append("Hello ")  
    cs.Color(Colors.Blue).Append("world!").Pop  
    lbl.Text = cs
```

  
but this removes all formatting:  

```B4X
    cs.Initialize.Append("Hello ")  
    cs.Color(Colors.Blue).Append("world!").Pop  
    lbl.Text = cs & " "
```