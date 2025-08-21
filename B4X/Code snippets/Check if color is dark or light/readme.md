###  Check if color is dark or light by Alexander Stolte
### 10/13/2019
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/110463/)

This Code is a convert from [this Stackoverflow](https://stackoverflow.com/a/24261119) thread.  
  

```B4X
Private Sub isColorDark(color As Int) As Boolean  
      
    Dim darkness As Int = 1 - (0.299 * GetARGB(color)(1) + 0.587 * GetARGB(color)(2) + 0.114 * GetARGB(color)(3))/255  
      
    If darkness <= 0.5 Then  
        Return    False 'It's a light color  
    Else  
        Return    True 'It's a dark color  
    End If  
      
End Sub  
  
Sub GetARGB(Color As Int) As Int()  
    Dim res(4) As Int  
    res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)  
    res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)  
    res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)  
    res(3) = Bit.And(Color, 0xff)  
    Return res  
End Sub
```

  
  
[SPOILER="Java Code"]  

```B4X
public boolean isColorDark(int color){  
    double darkness = 1-(0.299*Color.red(color) + 0.587*Color.green(color) + 0.114*Color.blue(color))/255;  
    if(darkness<0.5){  
        return false; // It's a light color  
    }else{  
        return true; // It's a dark color  
    }  
}
```

  
[/SPOILER]