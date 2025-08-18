### Draw text with outline by kimstudio
### 06/10/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/141134/)

Use javafx canvas to draw text with outline. Better to use CanvasExt lib from [USER=904]@klaus[/USER] but the working principle is the same. To make fancy text you can also use Graphiclib by [USER=9800]@stevel05[/USER]. Some libs released several years ago are gems.  
  

```B4X
    Dim jcv As JavaObject = Cv 'canvas  
    Dim jgd As JavaObject = jcv.RunMethod("getGraphicsContext2D", Null)  
    Dim jco As JavaObject  
    Cv.ClearRect(0,0,Cv.Width, Cv.Height)  
    txx = Cv.Width * 0.5  
    tyy = Cv.Height * 0.5  
    jco.InitializeNewInstance("javafx.scene.paint.Color", Array As Object(1.0, 0.0, 0.0, 1.0))  
    Dim f As Font = fx.CreateFont("Arial", 80, False, False)  
    jgd.RunMethod("setFont", Array As Object(f))  
    jgd.RunMethod("setStroke", Array As Object(jco))  
    jgd.RunMethod("setLineWidth", Array As Object(4.0))  
    jgd.RunMethod("strokeText", Array As Object("kimstudio", txx, tyy))  
    jco.InitializeNewInstance("javafx.scene.paint.Color", Array As Object(0.0, 0.0, 1.0, 1.0))  
    jgd.RunMethod("setFill", Array As Object(jco))  
    jgd.RunMethod("fillText", Array As Object("kimstudio", txx, tyy))
```

  
  
![](https://www.b4x.com/android/forum/attachments/130259)