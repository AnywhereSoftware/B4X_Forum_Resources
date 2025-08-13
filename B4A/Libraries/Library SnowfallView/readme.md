### Library SnowfallView by PuzzleTak
### 12/28/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/158272/)

Hello dear friends,  
I've recently developed a graphical library that you can freely download from GitHub.  
  
  
use example  

```B4X
    Dim pta As PTX_SnowfallView  
    pta.Initialize("")  
    Activity.AddView(pta,0%x,0%x,100%x,100%y)  
    pta.Color = Colors.Black  
      
    pta.EnableAlphaFade = True  
    pta.EnableRandomCurving = True  
'    pta.WholeAnimateTiming = 10000  
    pta.AnimateDuration = 10000  
    pta.GenerateSnowTiming = 45  
    pta.ImageBitmap = LoadBitmap(File.DirAssets,"snow.png")  
    pta.setRandomSnowSizeRange(25,1)  
    pta.setCurvingRandom(180,90)  
    pta.init  
    pta.startSnowing
```

  
  
  
link download : <https://github.com/PuzzleTakX/SnowfallView>