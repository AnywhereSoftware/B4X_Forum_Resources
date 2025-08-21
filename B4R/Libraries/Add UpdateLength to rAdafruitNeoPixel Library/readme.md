### Add UpdateLength to rAdafruitNeoPixel Library by Robert Valentino
### 03/12/2020
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/114889/)

I added the UpdateLength to rAdadruitNeoPixel library. The AdafruitNeoPixel Library supports changing the length of the string on the fly.  
  
Using a MC14512B to switch what strings I want to control.  
  
I have a 5 pointed star that uses 100 LEDs 85 for the star itself and 15 for the center (pentagon area) somethings I want a different routine running on the Pentagon the what is running on the Star. Having two references (using two different pins)  

```B4X
        Public     LEDStar                                             As AdafruitNeoPixel  
        Public     LEDCenter                                             As AdafruitNeoPixel        
  
           LEDStar.Initialize(100, 5, LEDPixels.NEO_RGB)    ' Use all 100 pixels and MC14512B is switch to this pin  
           LEDStar.SetBrightness(128)                        
           LEDStar.Clear            
  
            LEDCenter.Initialize(15, 4, LEDPixels.NEO_RGB)   '  NOTE will only work if MC14512B is switch to this Pin  
            LEDCenter.SetBrightness(128)                
            LEDCenter.Clear                                            
  
  
          '———————————————————————  
          '  Change star to only use 85  
          '———————————————————————  
          LEDStar.UpdateLength(85)                   '
```

  
  
Because the LEDs can only be driven by one pin at a time I am using a MC14512B to control who is controlling the last 15 leds. Truly if it is set to be used by the center routine no matter what the star does if it tries to write to leds 85 to 100 nothing will happen. Maybe doing the updatelength is not needed.  
  
Enjoy