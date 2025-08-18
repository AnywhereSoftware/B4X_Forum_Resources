### ColourThief (Cross platform colour palette generating algorithm) by John Naylor
### 03/16/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/139197/)

This is a port to B4X of the original Color-Thief algorithm by Lokesh Dhakar as described [here](https://lokeshdhakar.com/projects/color-thief/).  
  
I've included the original site pictures in the demo for comparison.  
  
I'm English so I have used the correct spelling of the word in its class name ;-)  
  
[SPOILER="MIT License"]  
The MIT License (MIT)  
  
Copyright © 2015 Lokesh Dhakar  
  
Permission Is hereby granted, free of charge, To any person obtaining a copy  
of this software And associated documentation files (the "Software"), To deal  
in the Software without restriction, including without limitation the rights  
To use, copy, modify, merge, publish, distribute, sublicense, And/Or sell  
copies of the Software, And To permit persons To whom the Software Is  
furnished To Do so, subject To the following conditions:  
  
The above copyright notice And this permission notice shall be included in all  
copies Or substantial portions of the Software.  
  
THE SOFTWARE Is PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS Or  
IMPLIED, INCLUDING BUT Not LIMITED To THE WARRANTIES OF MERCHANTABILITY,  
FITNESS For A PARTICULAR PURPOSE And NONINFRINGEMENT. IN NO EVENT SHALL THE  
AUTHORS Or COPYRIGHT HOLDERS BE LIABLE For ANY CLAIM, DAMAGES Or OTHER  
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT Or OTHERWISE, ARISING FROM,  
OUT OF Or IN CONNECTION WITH THE SOFTWARE Or THE USE Or OTHER DEALINGS IN THE  
SOFTWARE.  
[/SPOILER]  
  
I needed a fully cross platform colour palette generator for an ongoing project and I initially converted a KMeans algorithm to B4X however I faced a couple of issues with it. Mainly the fact that random points are used as starting points so running the code multiple times gives different results. Also I simply couldn't get it to run particularly quickly on IOS.  
  
A bit of searching came up with this algorithm written in Java so here it is converted to B4X. Benefits with this - 1 - You will always get the same palette given the same image. 2 - Very fast on all platforms.  
  
Use:  
  
  

```B4X
    Dim CF As ColourThief  
    CF.Initialize
```

  
  
Then the functions you're interested in are  
  
  

```B4X
' Returns the single most dominant colour as an ARGBColor value  
' Req - sourceImage As B4XBitmap - Any size bitmap - it will be converted/optimised within the class  
  
Public Sub getDominantColor(sourceImage As B4XBitmap) As ARGBColor  
  
' More control here - quality (default is 10) is how many pixels to skip between samples  
' ignoreWhite (default True) simply skips any white pixels it detects.  
  
Public Sub getDominantColor2(sourceImage As BitmapCreator, quality As Int, ignoreWhite As Boolean)  As ARGBColor  
  
'Returns a map of ARGBColor values, set how many with colorCount  
'Ordered by most dominant to least dominant  
'colorCount should be 2 - 255  
  
Public Sub getPalette(sourceImage As B4XBitmap, colorCount As Int) As Map  
  
'As previous with more control  
  
Public Sub getPalette2(sourceImage As BitmapCreator, colorCount As Int, quality As Int, ignoreWhite As Boolean) As Map  
  
'And finally a CMap object is a list of VBox classes used to quantize each of the colours using Mediancuts.  
'There's more information in here about each colour selected such as count, average, histograms etc.  
'Probably of very little use.  
  
Public Sub getColorMap(sourceImage As B4XBitmap, colorCount As Int) As CMap  
  
Public Sub getColorMap2(sourceImage As BitmapCreator, colorCount As Int, quality As Int, ignoreWhite As Boolean) As CMap
```

  
  
Demo grab of an 8 colour palette.  
  
![](https://www.b4x.com/android/forum/attachments/126679)  
  
[Edit] I could optimise it further with a few tweaks but I doubt I will bother given it works near enough instantly on an iPhone 6 which means it's well fast enough for my needs. If anyone actually needs it tweaking for whatever reason please shout out. The only change I'm currently considering is to use B4XComparatorSort that Erel recently posted about [here](https://www.b4x.com/android/forum/threads/b4x-sophisticated-sorting-with-b4xcomparatorsort.139006/) - It was the only bit of the original Java that confused me converting to B4X and shortly after I'd come up with my own way of doing it he released his solution. I strongly suspect he's omnipotent and is preempting my every move.