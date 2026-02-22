###  Modified AddLine with two color line and pinch zoom, out of xChart 10.0 from Klaus by Frank.G
### 02/19/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/170361/)

Hi there,  
  
after trying to implement features I needed I decided to modify the fantastic xChart 10.0 from klaus to meet me needs.  
I already talked back to klaus and he was so kind to encourage me to implement my own things.  
  

1. The line graph should be able to react on min/max limits, and if crossed it should change color
2. The touch info should be able to show the labels in colors that are free to choose. Not only the line color
3. I wanted the two finger pinch zoom using the class in B4A on Android.

  
I started with reviewing the xChart code and added small changes like implementing own touch info label color.  
Using Google AI Studio ( I know but I have ideas but not the knowledge after all) I changed small parts of the xchart.b4xlib for my own use.  
Then trying to implement pinch zoom I thought the library is to heavy weight and extracted the addline, addline2 part to implement my complete changes added as a class modul named LaborClass (name because of the app I code)  
  
The first things I added then was AddLine3 sub  

```B4X
Public Sub AddLine3(Name As String, LineColor As Int, StrokeWidth As Int, PointType As String, PointFilled As Boolean, PointColor As Int, RefUnter As Double, RefOber As Double, AlertColor As Int)  
    If Items.IsInitialized = False Then  
        Items.Initialize  
    End If  
    If LineColor = 0 Then LineColor = xui.Color_RGB(Rnd(0, 255), Rnd(0, 255), Rnd(0, 255))  
    Dim ID As ItemData  
    ID.Initialize  
    ID.Name = Name  
    ID.Color = LineColor  
    ID.LegendColor = LineColor  
    ID.StrokeWidth = StrokeWidth  
    ID.PointType = PointType  
    ID.PointFilled = PointFilled  
    ID.PointColor = PointColor  
    ID.RefUnter = RefUnter  
    ID.RefOber = RefOber  
    ID.AlertColor = AlertColor  
    Items.Add(ID)  
End Sub
```

  
  
With this I was able to create the following view  
![](https://www.b4x.com/android/forum/attachments/170048)  
  
  

- The color of the line changes according to the min/max value and the touch info now is able to show values in color I wish
- All the other parts remained so if you use the class it follows the same parameters klaus uses in his library.

the code to call  

```B4X
    chart_labor.AddLine3("Verlauf", MainColor, 1dip, "CIRCLE", True, MainColor, mCurrentRow.RefUnter, mCurrentRow.RefOber, AlertColor)
```

  
  
Then I got brave and started implementing pinch zoom. I be honest, I told the AI what I wanted and reported errors/faults in heavy vibe coding sessions. It took some quota limits in free tier to finally get it to work.  
I cannot recap all the changes but it was a constant forth and back, backups are the key !  
  
The end result worked at last and I attach the code at the bottom so maybe someone with more knowledge knows what is really going on.  
The pinch function is using java code to intercept and routes it through depending on singe pinch or two finger pinch.  
A lot of code adjustments where done to show and enable the zoom bar.  
All the code is in the LaborChart class no extra code needed  
  
In the end it works  
  
![](https://www.b4x.com/android/forum/attachments/170047)  
  
Still I want to share the result and hope someone is inspired by it.  
  
Version History:  

- Version 1.0 Initial
- Version 1.1 Added a helper sub ForceHideValues and modified Java code to prevent info panel to show when two finger pinch zoomed. Reset happens when all fingers are lifted.

  
Regards  
Frank