### Misc routines for themes, density and forms by JakeBullet70
### 06/23/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171355/)

Hi all.  
Thought I would post this before I move on to other stuff. This is the end result of my learning with VSCode - Claude AI. There ended up being some pretty cool stuff in here. Anyway.  
Full running test program.  
  
So…  
formHelpers.bas is a class with form related methods, just pass your form in.  
![](https://www.b4x.com/android/forum/attachments/171987)  
  
Then there is Theme stuff. (Try the density buttons)  
' AtlantaFX (theme CSS source): <https://github.com/mkpaz/atlantafx>  
' Gruvbox palette: <https://github.com/morhetz/gruvbox>  
' Solarized palette: <https://github.com/altercation/solarized>  
  
there is also a ThemeChangedListener event so anything subscribed to it will be notified when the theme changes. (see - AddThemeListener)  
  
ColorThemes.bas, TitleBarHelper.bas  
  
Custom window - title bar.  
Inspiration: <https://github.com/Oshan96/CustomStage> , <https://github.com/goxr3plus/FX-BorderlessScene>  
  
![](https://www.b4x.com/android/forum/attachments/171988)  
  
About 6 total hours of work on and off for a Sunday.  
Note: Claude AI wrote this, I did drive it and test - debug and goodness knows it got a few things wrong.  
  
Have fun!  
<https://github.com/jakebullet70/B4J-LighDarkThemes>