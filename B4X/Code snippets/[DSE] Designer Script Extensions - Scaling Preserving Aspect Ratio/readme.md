### [DSE] Designer Script Extensions - Scaling Preserving Aspect Ratio by William Lancee
### 01/29/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/145783/)

I have been experimenting with DSE.  
  
Just a small change in [USER=1]@Erel[/USER] 's Numpad example can preserve aspect ratio.  
  
<https://www.b4x.com/android/forum/threads/b4x-dse-designer-script-extensions.141312/post-895879>  
  
(I also put lower and upper limits on text scaling)  
  
  
![](https://www.b4x.com/android/forum/attachments/138657)![](https://www.b4x.com/android/forum/attachments/138658)![](https://www.b4x.com/android/forum/attachments/138659)  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private PresetValues As Map  
    Private dd As DDD  
     
    Private fillProp As Float  
End Sub  
  
Public Sub Initialize  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    xui.RegisterDesignerClass(Me)  
    dd.Initialize  
    xui.RegisterDesignerClass(dd)  
  
    fillProp = .5  
    PresetValues.Initialize  
    Root.LoadLayout("Numpad")  
End Sub  
  
Private Sub ScaleNumpad(DesignerArgs As DesignerArgs)  
    If DesignerArgs.FirstRun Then  
        For Each view As B4XView In DesignerArgs.Views  
            PresetValues.Put(view, Array As Int(view.Left, view.Top, view.Width, view.Height, IIf(view Is Button, view.TextSize, 0)))  
        Next  
    End If  
    Dim MainParent As B4XView = dd.GetViewByName(DesignerArgs.Parent, "Pane1")  
    Dim MainPreset() As Int = PresetValues.Get(MainParent)  
    If DesignerArgs.ParentWidth < 5 Or DesignerArgs.ParentHeight < 5 Then Return  
    Dim ScaleX As Float = DesignerArgs.ParentWidth / MainPreset(2)  
    Dim ScaleY As Float = DesignerArgs.ParentHeight / MainPreset(3)  
    Dim Scale As Float = Min(ScaleX, ScaleY) * fillProp  
    'If Scale > 1.5 Then Scale = 1.5         'Can also set upper limit on upscaling - really big buttons look ugly  
    Dim w As Float = MainPreset(2) * Scale  
    Dim h As Float = MainPreset(3) * Scale  
     
    MainParent.SetLayoutAnimated(0, Root.Width / 2 - w /2, Root.Height / 2 - h / 2, w, h)  
    For i = 0 To MainParent.NumberOfViews - 1  
        Dim btn As B4XView = MainParent.GetView(i)  
        Dim preset() As Int = PresetValues.Get(btn)  
        btn.SetLayoutAnimated(0, preset(0) * Scale, preset(1) * Scale, preset(2) * Scale, preset(3) * Scale)  
        btn.TextSize = Max(12, Min(30, preset(4) * Scale))        'prevent text from getting too small or too big  
    Next  
  
End Sub
```