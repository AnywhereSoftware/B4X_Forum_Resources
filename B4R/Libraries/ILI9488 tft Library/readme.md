### ILI9488 tft Library by candide
### 04/07/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/142656/)

it is wrapper for ILI9488 tft from: <https://github.com/jaretburkett/ILI9488>  
  
original library is based on Adafruit\_GFX\_Library  
this library can work with external fonts or not . Fonts are added in B4R project, in inline C  
  
Fonts added must be in directory: Arduino/libraries/Adafruit\_GFX\_Library/Fonts  
  
example of Fonts declaration in inline C for 7 fonts:

```B4X
#if C  
  #include <Fonts/FreeMono9pt7b.h>  
  #include <Fonts/FreeSans9pt7b.h>  
  #include <Fonts/FreeSerif9pt7b.h>  
  #include <Fonts/FreeMonoBold9pt7b.h>  
  #include <Fonts/FreeMonoBoldOblique9pt7b.h>  
  #include <Fonts/FreeMonoOblique9pt7b.h>  
  #include <Fonts/FreeSansBold9pt7b.h>  
  
  const GFXfont * B4R::B4RILI9488::myfonts[7]= {  
      &FreeMono9pt7b,                 // => setfont(00)  
      &FreeSans9pt7b,                 // => setfont(01)  
      &FreeSerif9pt7b,                // => setfont(02)  
      &FreeMonoBold9pt7b,             // => setfont(03)  
      &FreeMonoBoldOblique9pt7b,      // => setfont(04)  
      &FreeMonoOblique9pt7b,          // => setfont(05)  
      &FreeSansBold9pt7b              // => setfont(06)  
  };  
#End If
```

  
after in B4R code, management of fonts is done by

```B4X
 setfont( fontNB)
```

  
  
new version taking in account esp32 in arduino library