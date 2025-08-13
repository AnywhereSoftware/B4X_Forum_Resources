### {DSE] Button Shapes by stevel05
### 09/25/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143109/)

**These methods are now included in** [**DSE\_Shapes**](https://www.b4x.com/android/forum/threads/dse-shapes-shape-nodes.143132/) **class which provides more functionality.**  
  
Here are several Designer script extension methods that allow buttons to be shaped and rotated.  
  
It's a bit of a novelty, but may come in useful at some time.  
  
  

![](https://www.b4x.com/android/forum/attachments/133952)

  
  
Each shape method also attempts to apply centering for multi line text to the buttons labels in line with that set in the designer.  
  
The rotate method has an option not to rotate the text, it actually attempts to find the label attached to the view(s) and reverses the rotation.  
Avoid rotating text input fields / Areas, it gets messy very quickly.  
  
I did think about applying gradients to the buttons, but it destroys the hover and click effects and would need to be replaced with CSS, or code.  
  

```B4X
'Parameters: Points as int, InnerRadius Factor, 1 or more buttons  
'Designer Script : DSE_Nodes.StarButton(5,"0.5",Button1)  
Public Sub StarButton(DesignerArgs As DesignerArgs)  
    If DesignerArgs.FirstRun Then  
        Dim Points As Int = DesignerArgs.Arguments.Get(0)  
        Dim InnerRadiusFactor As Double = DesignerArgs.Arguments.Get(1)  
'        Dim AlignText As String = DesignerArgs.Arguments.Get(2)  
        For i = 2 To DesignerArgs.Arguments.Size - 1  
            Dim Btn As B4XView = DesignerArgs.GetViewFromArgs(i)  
            Dim W As Double = Btn.Width  
            Dim H As Double = Btn.Height  
            Dim OuterRadius As Double = Min(H,W) / 2  
            Dim InnerRadius As Double = OuterRadius * InnerRadiusFactor  
            Dim Path(Points * 4) As Double  
            Dim ThetaInc As Double = cPI / Points  
            Dim Theta As Double = IIf(Points Mod 2 = 0,ThetaInc , -cPI / 2)  
            Dim X,Y As Double  
            For j = 0 To Points * 2 - 1  
'                Dim AndgleRad As Double = j * DeltaAngleRad  
                If j Mod 2 <> 0 Then  
                    X =  W / 2 + InnerRadius * Cos(Theta)  
                    Y = H / 2 +  InnerRadius * Sin(Theta)  
                Else  
                    X = W / 2 + OuterRadius * Cos(Theta)  
                    Y = H / 2 + OuterRadius * Sin(Theta)  
                End If  
          
                Path(j * 2) = X  
                Path(j * 2 + 1) = Y  
                Theta = Theta + ThetaInc  
            Next  
      
            Dim Poly As JavaObject  
            Poly.InitializeNewInstance("javafx.scene.shape.Polygon",Array(Path))  
            Btn.As(JavaObject).RunMethod("setShape",Array(Poly))  
            Btn.As(JavaObject).RunMethod("setPickOnBounds",Array(False))  
            Dim TA As String = Btn.As(Button).Alignment  
            Btn.As(JavaObject).RunMethod("setAlignment",Array(TA))  
            Dim Pos As Int = TA.IndexOf("_")  
            If Pos > -1 Then TA = TA.SubString(Pos+1)  
            Btn.As(JavaObject).RunMethod("setTextAlignment",Array(TA))  
          
        Next  
    End If  
End Sub
```

  
  

```B4X
'Create an oval or round button  
'Parameters: 1 or more buttons  
'Designer Script : {Class}.OvalButton(Button1)  
Public Sub OvalButton(DesignerArgs As DesignerArgs)  
    If DesignerArgs.FirstRun Then  
        For i = 0 To DesignerArgs.Arguments.Size - 1  
            Dim Btn As B4XView = DesignerArgs.GetViewFromArgs(i)  
            Dim W As Double = Btn.Width  
            Dim H As Double = Btn.Height  
            Dim R As Double = Min(H,W) / 2  
            Dim Circle As JavaObject  
            Circle.InitializeNewInstance("javafx.scene.shape.Circle",Array(W / 2, H / 2, R))  
   
            Btn.As(JavaObject).RunMethod("setShape",Array(Circle))  
            Btn.As(JavaObject).RunMethod("setPickOnBounds",Array(False))  
            Dim TA As String = Btn.As(Button).Alignment  
            Btn.As(JavaObject).RunMethod("setAlignment",Array(TA))  
            Dim Pos As Int = TA.IndexOf("_")  
            If Pos > -1 Then TA = TA.SubString(Pos+1)  
            Btn.As(JavaObject).RunMethod("setTextAlignment",Array(TA))  
        Next  
    End If  
End Sub
```

  
  
  

```B4X
'Create a Polygon with any number of Vertices  
'Parameters: Vertices as Int, 1 or more buttons  
'Designer Script :{Class}.VertButton(5, Button1, Button2)  
Public Sub VerticeButton(DesignerArgs As DesignerArgs)  
    If DesignerArgs.FirstRun Then  
        Dim N As Int = DesignerArgs.Arguments.Get(0)  
        For i = 1 To DesignerArgs.Arguments.Size - 1  
            Dim Btn As B4XView = DesignerArgs.GetViewFromArgs(i)  
            Dim W As Double = Btn.Width  
            Dim H As Double = Btn.Height  
            Dim R As Double = Min(H,W) / 2  
            Dim Path(N * 2) As Double  
            Dim ThetaInc As Double = 2 * cPI / N  
            Dim Theta As Double = IIf(N Mod 2 = 0,ThetaInc , -cPI / 2)  
            Dim X,Y As Double  
            For j = 0 To N - 1  
                X =  W / 2 + R * Cos(Theta)  
                Y =  H / 2 + R * Sin(Theta)  
                Path(j * 2) = X  
                Path(j * 2 + 1) = Y  
                Theta = Theta + ThetaInc  
            Next  
   
            Dim Poly As JavaObject  
            Poly.InitializeNewInstance("javafx.scene.shape.Polygon",Array(Path))  
            Btn.As(JavaObject).RunMethod("setShape",Array(Poly))  
            Btn.As(JavaObject).RunMethod("setPickOnBounds",Array(False))  
            Dim TA As String = Btn.As(Button).Alignment  
            Btn.As(JavaObject).RunMethod("setAlignment",Array(TA))  
            Dim Pos As Int = TA.IndexOf("_")  
            If Pos > -1 Then TA = TA.SubString(Pos+1)  
            Btn.As(JavaObject).RunMethod("setTextAlignment",Array(TA))  
        Next  
    End If  
End Sub
```

  
  
  

```B4X
'Parameters: Rotation as Double, AndText As string, 1 Or More Views  
'Designer Script : {Class}.RotateView(90, "False", Button1)  
'Avoid rotating Text input fields, or Panes that contain them.  It gets messy very quickly.  
Public Sub RotateView(DesignerArgs As DesignerArgs)  
    If DesignerArgs.FirstRun Then  
        Dim Rotation As Double = DesignerArgs.Arguments.Get(0)  
        Dim AndText As Boolean = DesignerArgs.Arguments.Get(1).As(String).ToLowerCase = "true"  
        For i = 2 To DesignerArgs.Arguments.Size - 1  
            Dim V As B4XView = DesignerArgs.GetViewFromArgs(i)  
            V.Rotation = Rotation  
            If AndText = False Then  
                Sleep(0)  
                Dim Arr() As Object = V.As(JavaObject).RunMethodJO("lookupAll",Array(".text")).RunMethod("toArray",Null)  
                For Each Lbl As B4XView In Arr  
                    If Lbl.IsInitialized Then  
                        Lbl.Rotation = -Rotation  
                    End If  
                Next  
            End If  
        Next  
    End If  
End Sub
```

  
  
My designer script (my class is DSE\_Nodes)  

```B4X
DSE_Nodes.StarButton(5,"0.4",Button1)  
DSE_Nodes.StarButton(12,"0.75",Button2)  
DSE_Nodes.OvalButton(Button3,Button4)  
DSE_Nodes.VerticeButton(5,Button5)  
DSE_Nodes.VerticeButton(6,Button6)  
DSE_Nodes.VerticeButton(3,Button7)  
DSE_Nodes.VerticeButton(3,Button8)  
DSE_Nodes.VerticeButton(8,Button9)  
DSE_Nodes.RotateView(180,"False",Button8)
```

  
  
  
I'm finding this fascinating, however I really should get on with some work.  
  
Enjoy