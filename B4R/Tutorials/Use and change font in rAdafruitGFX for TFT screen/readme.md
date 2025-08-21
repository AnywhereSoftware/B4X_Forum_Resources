### Use and change font in rAdafruitGFX for TFT screen by derez
### 11/09/2019
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/111203/)

The library rAdafruitGFX is used to draw on TFT screens. It has a default font and does not give a way to change the font for drawing text.  
This is what I got when drawing very large characters:  
  
![](https://www.b4x.com/android/forum/attachments/85365)  
To get this size I had to use size **14** in the "configure text" method…  
  
Erel provided an inline C code to set another font:  

```B4X
#if C  
#include "FreeSans12pt7b.h"  
void SetFont(B4R::Object* o) {  
   b4r_main::_tft->GFX->gfx->setFont(&FreeSans12pt7b);  
}  
#End If
```

  
This code is for a font named "FreeSans12pt7b.h" . If you install the library Adafruit\_GFX with the Arduino IDE you get a lot of font files in a directory "Fonts" and you can copy what you want from there to rAdafruitGFX.  
Change the name of the file and in the function accordingly. Replace "tft" with the name of the object you use as the adafruitGFX object and add a line to your code :  

```B4X
RunNative("SetFont", Null)
```

  
I changed the font to FreeSans18pt7b.h and got a much better result with size 4:  
  
![](https://www.b4x.com/android/forum/attachments/85355)  
  
  
Next post - how to create your font.