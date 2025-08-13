### Color Blend Effect by jkhazraji
### 11/19/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/164208/)

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
    Private jStage As JavaObject  
    Private root As JavaObject  
    Private Circle As JavaObject  
    Private blend As JavaObject  
    Private topInput As JavaObject  
    Dim blenMode As JavaObject  
     
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    jStage=MainForm.As(JavaObject).GetFieldJO("stage")  
  
    Circle.InitializeNewInstance("javafx.scene.shape.Circle",Null)  
  
    Circle.RunMethod("setCenterX",Array(75.0))        
    Circle.RunMethod("setCenterY",Array(75.0))  
  
    Circle.RunMethod("setRadius",Array(100.0))  
    Circle.RunMethod("setFill",Array(fx.Colors.green)) 'RGB(161,22,22)))  
     
    blend.InitializeNewInstance("javafx.scene.effect.Blend",Null)  
    topInput.InitializeNewInstance("javafx.scene.effect.ColorInput",Null)  
    topInput.RunMethod("setHeight",Array(155.0))  
    topInput.RunMethod("setWidth",Array(150.0))  
    topInput.RunMethod("setX",Array(-40.0))  
    topInput.RunMethod("setY",Array(30.0))  
    topInput.RunMethod("setPaint",Array(fx.Colors.Red)) '.RGB(130, 15, 190)))  
'    //setting the top input To the blend object  
    blend.RunMethod("setTopInput",Array(topInput))      
'    //setting the blend mode  
    blenMode.InitializeStatic("javafx.scene.effect.BlendMode")  
    blend.RunMethod("setMode",Array(blenMode.GetField("DIFFERENCE")))  
    
'    //Applying the blend effect To Circle  
    Circle.RunMethod("setEffect", Array(blend))  
    root.InitializeNewInstance("javafx.scene.Group",Null)  
    root.RunMethodJO("getChildren",Null).RunMethod("add",Array(Circle))  
     
    MainForm.RootPane.AddNode(root,200dip,200dip,0,0)  
       
     
End Sub
```

  
![](https://www.b4x.com/android/forum/attachments/158782)