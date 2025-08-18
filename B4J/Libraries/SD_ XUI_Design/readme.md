### SD: XUI_Design by Star-Dust
### 08/22/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/105704/)

Goodmorning everyone,  
  
 We have often discussed in this forum in different threads about the need to be able to insert XUI from design. We all know that the direction that is suggested by AnyWhere software is to create in the design the native views and then replace B4XView to the type declaration  
  

```B4X
Dim V As BXView 'Label
```

  
  
Clearly many would prefer to be able to do it as a design as understood from the threads, so about a year ago I created the SD\_XuiView library that does a sort of wrapping (in reality is not a wrapping but CustomView Class) of the various views (Label, Button, etc.) in respective CustomView for each view by adding some method and animation, like 3D rotations, dragging views, various animations. (**[See here](https://www.b4x.com/android/forum/threads/b4x-xui-sd-xuiview.96178/)**)  
  
But creating a CustomView for each view has produced a heavy library full of often repetitive classes.  
***So I thought of creating a single CustomView*** that allows you to insert a design B4XView allowing you to associate it with any view (*Button, CheckBox, ImageView, Label, Panel, ProgressBar, RadioButton, ScrollView, Switch, TextArea, TextField, ToggleButton*)  
  
  
**XUI\_Design  
  
Author:** Star-Dust  
**Version:** 0.02  

- **SDB4XView**

- **Functions:**

- **BringToFront**
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **Initialize** (Callback As Object, EventName As String)
- **SendToBack**
- **SetLayoutAnimated** (Duration As Int, Left As Int, Top As Int, Width As Int, Height As Int)

- **Properties:**

- **B4XView** As B4XView [write only]
*Get or Set View  
eg. SDB4XView1.B4XView=Label  
 eg. SDB4XView1.B4XView.Left=0*- **Height**
- **Left**
- **Top** As Int [write only]
- **ViewType** As String [write only]
*setViewType("Label","Label1")*- **Visible** As Boolean [write only]
- **Width** As Int [write only]

  
The views are created by Design as seen from the image. You can select the view you want from the design  
![](https://www.b4x.com/android/forum/attachments/80286)  
  
But if you want to change later, you can do it with the command: setViewType(TypeView as String,EventName as String)  

```B4X
SDB4XView1.setViewType("Label","Label1")
```

  
Or:  

```B4X
Dim Label1 As Label  
Label1.Initialize("Label1")  
SDB4XView1.B4XView=Label1
```

  
  
To reposition the view (or visible/BringToFront/SendToBack) it will be used  

```B4X
SDB4XView1.Left = 0  
SDB4XView1.Top= 0  
SDB4XView1.Width= 0  
SDB4XView1.Heigth= 0  
  
SDB4XView1.SetLayoutAnimated(Duration,Left,Top,Width,Height)  
  
SDB4XView1.Visible= True ' Or False  
SDB4XView1.BringToFront
```

  
  
For all other methods and properties **SDB4XView**.**B4XView**.etc etc  
![](https://www.b4x.com/android/forum/attachments/80303)  
  
**[SIZE=3]*I am sure that not everyone will agree to create a custom View just to save a correction pass in the declarations, others will not find it useful.  
I am convinced that it is right that everyone has their opinion and I do not feel offended that it is different from mine.*  
*This library is aimed at those few who like me think it's useful.*[/SIZE]**