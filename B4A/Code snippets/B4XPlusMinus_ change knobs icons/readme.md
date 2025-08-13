### B4XPlusMinus: change knobs icons by Serge Bertet
### 10/13/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/143497/)

Spent one hour looking in the forum for a way to change B4XPlusMinus knob symbols.  
  
You can directly change the text but characters will not be aligned correctly (at least for an horizontal B4XPlusMinus)  

```B4X
B4XPlusMinus1.lblMinus.Text = "-"  
B4XPlusMinus1.lblPlus.Text = "+"
```

  
  
Here is what finally worked for me:  

```B4X
    B4XPlusMinus1.lblMinus.Font = xui.CreateFontAwesome(24)  
    B4XPlusMinus1.lblMinus.Text = Chr(0xF068) ' fontawesome - sign  
    B4XPlusMinus1.lblPlus.Font = xui.CreateFontAwesome(24)  
    B4XPlusMinus1.lblPlus.Text = Chr(0xF067) ' fontawesome + sign
```

  
  
Hope that helps, Serge.