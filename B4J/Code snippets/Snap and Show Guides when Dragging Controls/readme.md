### Snap and Show Guides when Dragging Controls by xulihang
### 08/31/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/162850/)

GitHub repo and demo video: <https://github.com/xulihang/misc/tree/master/b4x/b4j/snapAndShowGuides>  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As Button  
    Private Button2 As Button  
    Type PositionData (PressedX As Double, PressedY As Double,linesShown As Boolean)  
    Type Line (X0 As Double, Y0 As Double, X1 As Double, Y1 As Double)  
    Private ImageView1 As ImageView  
    Private Pane1 As Pane  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    ImageView1.PickOnBounds = False  
End Sub  
  
Private Sub Button2_MouseDragged (EventData As MouseEvent)  
    HandleButtonDragged(Sender,EventData)  
End Sub  
  
Private Sub Button2_MousePressed (EventData As MouseEvent)  
    HandleButtonPressed(Sender,EventData)  
End Sub  
  
  
Private Sub Button1_MouseDragged (EventData As MouseEvent)  
    HandleButtonDragged(Sender,EventData)  
End Sub  
  
Private Sub Button1_MousePressed (EventData As MouseEvent)  
    HandleButtonPressed(Sender,EventData)  
End Sub  
  
Private Sub HandleButtonPressed(btn As Button,EventData As MouseEvent)  
    Dim btn As Button = Sender  
    Dim pd As PositionData  
  
    Dim event As JavaObject = EventData  
    pd.PressedX = event.RunMethod("getSceneX",Null)  
    pd.PressedY = event.RunMethod("getSceneY",Null)  
    pd.linesShown = False  
    btn.Tag = pd  
End Sub  
  
Private Sub HandleButtonDragged(btn As Button,EventData As MouseEvent)  
    Dim btn As Button = Sender  
    Dim event As JavaObject = EventData  
    Dim pd As PositionData = btn.Tag  
    Dim XDiff As Double= event.RunMethod("getSceneX",Null) - pd.pressedX  
    Dim YDiff As Double= event.RunMethod("getSceneY",Null) - pd.pressedY  
    btn.Left = XDiff+btn.Left  
    btn.Top = YDiff+btn.Top  
    If pd.linesShown = True Then  
        If XDiff < 0 Then  
            XDiff = XDiff - 2  
        Else  
            XDiff = XDiff + 2  
        End If  
        If YDiff < 0 Then  
            YDiff = YDiff - 2  
        Else  
            YDiff = YDiff + 2  
        End If  
        pd.linesShown = False  
    End If  
    pd.PressedX = event.RunMethod("getSceneX",Null)  
    pd.PressedY = event.RunMethod("getSceneY",Null)  
    Dim snapped As Boolean = SnapAndShowGuideLines(btn,XDiff,YDiff)  
    If snapped Then  
        pd.linesShown = True  
    End If  
End Sub  
  
Private Sub SnapAndShowGuideLines(n As Node,XDiff As Double,YDiff As Double) As Boolean  
    Dim snapped As Boolean  
    Dim bc As BitmapCreator  
    bc.Initialize(Pane1.Width,Pane1.Height)  
    Dim left As Double = n.Left  
    Dim top As Double = n.Top  
    Dim right As Double = n.Left + n.PrefWidth  
    Dim bottom As Double = n.top + n.PrefHeight  
    Dim centerX As Double = n.Left + n.PrefWidth/2  
    Dim centerX As Double = n.Left + n.PrefWidth/2  
    Dim centerY As Double = n.top + n.PrefHeight/2  
    Dim shapes As List = GetShapes(n)  
    Dim linesToDraw As List  
    linesToDraw.Initialize  
  
    For Each shape As B4XRect In shapes  
        If Abs(shape.Left - left) < 3 And Abs(XDiff) < 2 Then 'left  
            If shape.Left <> left Then  
                n.Left = shape.Left 'snap  
                snapped = True  
            End If  
            Dim l As Line  
            l.Initialize  
            l.X0 = shape.Left  
            l.Y0 = Min(n.Top,shape.Top)  
            l.X1 = shape.Left  
            l.Y1 = Max(n.Top+n.PrefHeight,shape.Bottom)  
            linesToDraw.Add(l)  
        End If  
      
        If Abs(shape.Right - right) < 3 And Abs(XDiff) < 2 Then ' right  
            If shape.Right <> right Then  
                n.Left = shape.Right - n.PrefWidth 'snap  
                snapped = True  
            End If  
            Dim l As Line  
            l.Initialize  
            l.X0 = shape.Right  
            l.Y0 = Min(n.Top,shape.Top)  
            l.X1 = shape.Right  
            l.Y1 = Max(n.Top+n.PrefHeight,shape.Bottom)  
            linesToDraw.Add(l)  
        End If  
          
        If Abs(shape.Right - left) < 3 And Abs(XDiff) < 2 Then ' left and right  
            If shape.Right <> left Then  
                n.Left = shape.Right 'snap  
                snapped = True  
            End If  
            Dim l As Line  
            l.Initialize  
            l.X0 = shape.Right  
            l.Y0 = Min(n.Top,shape.Top)  
            l.X1 = shape.Right  
            l.Y1 = Max(n.Top+n.PrefHeight,shape.Bottom)  
            linesToDraw.Add(l)  
        End If  
          
        If Abs(shape.Left - right) < 3 And Abs(XDiff) < 2 Then ' right and left  
            If shape.Left <> right Then  
                n.Left = shape.Left - n.PrefWidth 'snap  
                snapped = True  
            End If  
            Dim l As Line  
            l.Initialize  
            l.X0 = shape.Left  
            l.Y0 = Min(n.Top,shape.Top)  
            l.X1 = shape.Left  
            l.Y1 = Max(n.Top+n.PrefHeight,shape.Bottom)  
            linesToDraw.Add(l)  
        End If  
  
        If Abs(shape.CenterX - centerX) < 3 And Abs(XDiff) < 2 Then 'centerx  
            If shape.CenterX <> centerX Then  
                n.Left = shape.CenterX - n.PrefWidth/2 'snap  
                snapped = True  
            End If  
            Dim l As Line  
            l.Initialize  
            l.X0 = shape.centerX  
            l.Y0 = Min(n.Top,shape.Top)  
            l.X1 = shape.centerX  
            l.Y1 = Max(n.Top+n.PrefHeight,shape.Bottom)  
            linesToDraw.Add(l)  
        End If  
      
        If Abs(shape.Top - top) < 3 And Abs(YDiff) < 2 Then 'top  
            If shape.Top <> top Then  
                n.Top = shape.Top 'snap  
                snapped = True  
            End If  
            Dim l As Line  
            l.Initialize  
            l.X0 = Min(n.Left,shape.Left)  
            l.Y0 = shape.Top  
            l.X1 = Max(n.Left+n.PrefWidth,shape.Right)  
            l.Y1 = shape.Top  
            linesToDraw.Add(l)  
        End If  
      
        If Abs(shape.Bottom - bottom) < 3 And Abs(YDiff) < 2 Then 'bottom  
            If shape.Bottom <> bottom Then  
                n.Top = shape.Bottom - n.PrefHeight 'snap  
                snapped = True  
            End If  
            Dim l As Line  
            l.Initialize  
            l.X0 = Min(n.Left,shape.Left)  
            l.Y0 = shape.Bottom  
            l.X1 = Max(n.Left+n.PrefWidth,shape.Right)  
            l.Y1 = shape.Bottom  
            linesToDraw.Add(l)  
        End If  
          
        If Abs(shape.Top - bottom) < 3 And Abs(YDiff) < 2 Then 'top and bottom  
            If shape.Top <> bottom Then  
                n.Top = shape.Top - n.PrefHeight 'snap  
                snapped = True  
            End If  
            Dim l As Line  
            l.Initialize  
            l.X0 = Min(n.Left,shape.Left)  
            l.Y0 = shape.Top  
            l.X1 = Max(n.Left+n.PrefWidth,shape.Right)  
            l.Y1 = shape.Top  
            linesToDraw.Add(l)  
        End If  
          
        If Abs(shape.Bottom - top) < 3 And Abs(YDiff) < 2 Then 'bottom and top  
            If shape.Bottom <> top Then  
                n.Top = shape.Bottom 'snap  
                snapped = True  
            End If  
            Dim l As Line  
            l.Initialize  
            l.X0 = Min(n.Left,shape.Left)  
            l.Y0 = shape.Bottom  
            l.X1 = Max(n.Left+n.PrefWidth,shape.Right)  
            l.Y1 = shape.Bottom  
            linesToDraw.Add(l)  
        End If  
      
        If Abs(shape.CenterY - centerY) < 3 And Abs(YDiff) < 2 Then 'centery  
            If shape.CenterY <> centerY Then  
                n.Top = shape.centerY - n.PrefHeight/2 'snap  
                snapped = True  
            End If  
            Dim l As Line  
            l.Initialize  
            l.X0 = Min(n.Left,shape.Left)  
            l.Y0 = shape.centerY  
            l.X1 = Max(n.Left+n.PrefWidth,shape.Right)  
            l.Y1 = shape.centerY  
            linesToDraw.Add(l)  
        End If  
  
    Next  
  
      
    If linesToDraw.Size>0 Then  
        For Each l As Line In linesToDraw  
            bc.DrawLine(l.X0,l.Y0,l.X1,l.Y1,xui.Color_Red,1)  
        Next  
    End If  
    ImageView1.SetImage(bc.Bitmap)  
    Return snapped  
End Sub  
  
Private Sub GetShapes(n As Node) As List  
    Dim shapes As List  
    shapes.Initialize  
    Dim paneRect As B4XRect  
    paneRect.Initialize(0,0,Pane1.Width,Pane1.Height)  
    shapes.Add(paneRect)  
    For Each nodeForComparing As Node In Array(Button1,Button2)  
        If n <> nodeForComparing Then  
            Dim r As B4XRect  
            r.Initialize(nodeForComparing.Left,nodeForComparing.Top, _  
            nodeForComparing.Left+nodeForComparing.PrefWidth, _  
            nodeForComparing.Top+nodeForComparing.PrefHeight)  
            shapes.Add(r)  
        End If  
    Next  
    Return shapes  
End Sub
```