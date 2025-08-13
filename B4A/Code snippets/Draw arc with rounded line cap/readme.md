### Draw arc with rounded line cap by kimstudio
### 09/21/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/143063/)

Using ABExtDrawing lib by [USER=974]@alwaysbusy[/USER] to draw arc with rounded cap. Android and this lib provides sweep gradient. However the sweep starts from 3:00 direction so may need rotation for certain angles.  
Erel has [one](https://www.b4x.com/android/forum/threads/round-circular-progress-bar.143040/) based on BitmapCreator which is nice as it is B4X, this one is B4A only ([B4J version here](https://www.b4x.com/android/forum/threads/draw-arc-line-with-round-cap.143061/#post-906527)). Hope it is still useful for someone to make progress bar or knob control view.  
  

```B4X
Sub Globals  
    Dim Aed As ABExtDrawing  
    Dim Cv As Canvas  
    Dim Arc As ABRectF  
    Dim Apt As ABPath  
    Dim Apa As ABPaint  
    Private Panel1 As Panel  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    Cv.Initialize(Panel1)  
    Arc.Initialize(100,100,Panel1.Width-100, Panel1.Width-100)  
    Apt.Initialize  
    Apt.arcTo(Arc, 30, 260)  
    Apa.Initialize  
    Apa.SetAntiAlias(True)  
    Apa.SetStrokeWidth(80)  
    Dim c(2) As Int  
    c(0) = Colors.Yellow  
    c(1) = Colors.Red  
    Apa.SetSweepGradient(1, Panel1.Width/2.0, Panel1.Width/2.0, c, Null)  
    Apa.DoShaderSingle(1)  
    Apa.SetStrokeCap(Apa.Cap_ROUND)  
    Apa.SetStyle(Apa.Style_STROKE)  
    Aed.drawPath(Cv, Apt, Apa)  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/133890)