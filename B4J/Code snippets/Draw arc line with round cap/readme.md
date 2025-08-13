### Draw arc line with round cap by kimstudio
### 09/21/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143061/)

Using jCanvasExt lib by [USER=904]@klaus[/USER] to draw arc with rounded cap. To realize the sweep gradient, we use a conic gradient image as image pattern paint to draw, since javafx only provides linear or radial gradient.  
Erel has [one](https://www.b4x.com/android/forum/threads/round-circular-progress-bar.143040/) based on BitmapCreator which is nice as it is B4X, this one is based on javafx so B4J only. Hope it is still useful for someone to make progress bar or knob control view.  
  

```B4X
    Private Cvx As CanvasExt  
    Private Cv As Canvas  
    Dim ip As JavaObject  
    Dim im As Image = fx.LoadImage(File.DirAssets, "conic-gradient-full-example.png")  
    ip.InitializeNewInstance("javafx.scene.paint.ImagePattern", Array(im, 0.0, 0.0, 400.0, 400.0, False))  
    Cvx.Initialize(Cv)  
    Cvx.SetLineCap("ROUND")  
    Cvx.DrawArc2(200, 200, 160, 90, -225, "OPEN", ip, False, 40)
```

  
  
![](https://www.b4x.com/android/forum/attachments/133889)