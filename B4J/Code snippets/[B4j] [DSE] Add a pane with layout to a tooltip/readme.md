### [B4j] [DSE] Add a pane with layout to a tooltip. by stevel05
### 09/11/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/151203/)

A designer script extension to add a pane with a layout to a Nodes tooltip:  
  

![](https://www.b4x.com/android/forum/attachments/145745)

  
  

```B4X
'Parameters: Target As B4xView, LayoutName As String, AnchorLocation As String, PaneWidth As Double, PaneHeight as Double  
'DesignerScript: {Classname}.SetPaneOnTooltip(Button1,"layoutname","CONTENT_TOP_RIGHT",120,100 )  
'ContentDisplay Should be one of: CONTENT_BOTTOM_LEFT, CONTENT_BOTTOM_RIGHT, CONTENT_TOP_LEFT, CONTENT_TOP_RIGHT,  
'WINDOW_BOTTOM_LEFT, WINDOW_BOTTOM_RIGHT, WINDOW_TOP_LEFT, WINDOW_TOP_RIGHT or empty string for default  
Public Sub SetPaneOnTooltip(DesignerArgs As DesignerArgs)  
    If DesignerArgs.FirstRun Then  
        Dim Target As JavaObject = DesignerArgs.GetViewFromArgs(0)  
        Dim LayoutName As String = DesignerArgs.Arguments.Get(1)  
        Dim AnchorLocation As String = DesignerArgs.Arguments.Get(2)  
        Dim Width As Double = DesignerArgs.Arguments.Get(3)  
        Dim Height As Double = DesignerArgs.Arguments.Get(4)  
      
        Dim P As B4XView = XUI.CreatePanel("")  
        P.SetLayoutAnimated(0,0,0,Width,Height)  
        P.LoadLayout(LayoutName)  
        Dim TT As JavaObject  
        TT.InitializeNewInstance("javafx.scene.control.Tooltip",Null)  
        TT.RunMethod("setGraphic",Array(P))  
        If AnchorLocation <> "" Then TT.RunMethod("setAnchorLocation",Array(AnchorLocation.ToUpperCase))  
        Target.As(JavaObject).RunMethod("setTooltip",Array(TT))  
   
    End If  
End Sub
```

  
  
Where {ClassName} is whichever class you copy the code to.  
  
You can access the pane to set or change some of it's text or anything else after the layout is loaded, using something like this code:  

```B4X
Dim P1 As B4XView = {Target}.As(JavaObject).RunMethodJO("getTooltip",Null).RunMethod("getGraphic",Null)  
P1.GetView(0).Text = NewValue  
P1.GetView(1).Text = NewValue  
P1.GetView(2).Text = NewValue  
P1.GetView(3).Text = NewValue
```

  
  
Where {Target} is the Node you assigned the tooltip to.  
  
Hint: Do not set the tooltip text in the designer. If you want text as well, you can modify the code to Initialize the tooltip with text, and pass it in the designer method call.  
  
Enjoy