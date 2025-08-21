### Update to library 4 new functions for rAdafruitNeoPixel by Robert Valentino
### 02/23/2020
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/114286/)

I modified the AdafruitNeoPixel library in this posting: <https://www.b4x.com/android/forum/threads/radafruitneopixel-based-on-neopixel-lib-v1-3-1.111313/#post-708734>  
Added 4 new functions:  
  
MovePixelColorDirect (To, From) - Move the pixel data from location to another directly  
SetPixelColorDirect3(Pixel, ULong) - Set pixel to value directly  
SetPixelColorDirect(Pixel, R, G, B) - Set pixel to value directly  
GetPixelColorDirect(Pixel) - Get the pixel value at location directly  
  
The above 4 routines will retrieve and write the pixel information directly to and from without regard for brightness  
  
The reason I added these 4 functions is that I a working with my led lights with brightness set to 32 because I am sitting right next to them while doing the coding.  
  
Using SetBrightness is AdafruitNeoPixel changes the value you are writing to a led based on the brightness (now that is fine and how things are suppose to work)  
  
The problem occurs if you are moving a pixel value along a strip (not saving them in memory, just getting the value and putting it somewhere else on the strip) the Getting a value does a shift to restore brightness and then putting it to the other location does another shift for brightness to write out. This consent shifting to restore and set brightness could and does lose some data. For most part is not a problem but if you start a value out on the first position by time you get that same value to position 150 (reading - writing to next spot) a lot of my pixels were just black.  
  
This also cause problems when I was doing the coding of a meteor shower routine I saw. The routine would write out particles then read them in again to decay them. The writing out cause a little lost. then reading them in again (caused some loss) then the decay routine would knock them down and write them out again cause some more loss. Meteor particles were decaying faster then they should.  
  
NOW, none of this is a problem if you are working at full brightness - but if NOT then these routines will get you better results.  
  
Enjoy  
  
BobVal