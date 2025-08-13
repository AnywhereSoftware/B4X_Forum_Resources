### [DSE] Shapes - Shape Nodes by stevel05
### 09/26/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/143132/)

This class contains designer extension script methods based on the snippets I previously posted with some enhancements that make it too complex to post as snippets.  
  
You should now be able to shape and rotate any node, text alignment is currently handled for Button, Label, Radiobutton and Checkbox.  
  

![](https://www.b4x.com/android/forum/attachments/134050)

  
  
[SPOILER="Provided Methods"]  
  
  
**[SIZE=7]Class : [/SIZE]**DSE\_Shapes **[SIZE=7]ShortName : [/SIZE]** DSE\_Shapes  
  
[INDENT][SIZE=7]**Methods:**[/SIZE][/INDENT]  
  
[INDENT][/INDENT]  
[INDENT]**Initialize**[/INDENT]  
[INDENT]Initializes the object. You can add parameters to this method if needed.[/INDENT]  
  
  
[INDENT][/INDENT]  
[INDENT]**StarView**(DesignerArgs As DesignerArgs)[/INDENT]  
[INDENT]Parameters: Points as int, InnerRadius Factor, 1 or more views[/INDENT]  
[INDENT]Designer Script : DSE\_Shapes.StarView(5,"0.5",Button1)[/INDENT]  
  
  
[INDENT][/INDENT]  
[INDENT]**OvalView**(DesignerArgs As DesignerArgs)[/INDENT]  
[INDENT]Create an oval or round view[/INDENT]  
[INDENT]Parameters: 1 or more buttons[/INDENT]  
[INDENT]Designer Script : DSE\_Shapes.OvalView(Button1)[/INDENT]  
  
  
[INDENT][/INDENT]  
[INDENT]**VertexView**(DesignerArgs As DesignerArgs)[/INDENT]  
[INDENT]Create a Polygon view with any number of Vertices[/INDENT]  
[INDENT]Parameters: Vertices as Int, RotationInDegress As Double, 1 or more views[/INDENT]  
[INDENT]Designer Script : DSE\_Shapes.VertexView(5,0,Button1, Button2)[/INDENT]  
  
  
[INDENT][/INDENT]  
[INDENT]**VertexViewAll**(DesignerArgs As DesignerArgs)[/INDENT]  
[INDENT]Create a Polygon views with any number of Vertices from all views on a pane[/INDENT]  
[INDENT]Parameters: Vertices as Int, RotationInDegrees as Double, Pane as B4xView[/INDENT]  
[INDENT]Designer Script : DSE\_Shapes.VertexViewAll(5,90,Pane1)[/INDENT]  
  
  
[INDENT][/INDENT]  
[INDENT]**RotateView**(DesignerArgs As DesignerArgs)[/INDENT]  
[INDENT]Parameters: Rotation as Double, AndText As string, 1 Or More Views[/INDENT]  
[INDENT]Designer Script : DSE\_Shapes.RotateView(90, "False", Button1)[/INDENT]  
[INDENT]Avoid rotating Text input fields, or Panes that contain them. It gets messy very quickly.[/INDENT]  
  
  
[INDENT][/INDENT]  
[INDENT]**SetBackgroundColor**(DesignerArgs As DesignerArgs)[/INDENT]  
[INDENT]Parameters: CheckBox As B4xView, Color As String[/INDENT]  
[INDENT]Designer Script : DSE\_Shapes.SetBackgroundColor(CheckBox1, FFFF0000)[/INDENT]  
[INDENT]Useful to set the Background color for CheckBox and RadioButtons, where the designer sets the background for the mark and radio nodes respectively.[/INDENT]  
  
  
[INDENT][/INDENT]  
[INDENT]**LayoutHexagonsVertical**(DesignerArgs As DesignerArgs)[/INDENT]  
[INDENT]Parameters: Pane as B4xView, Columns As int, Margin As int, ScaleFont as String ("True"/"", "False"), Adjust As String ("True"/"", "False")[/INDENT]  
[INDENT]Designer Script : DSE\_Shapes.LayoutHexagonsHorizontal(Pane1,5,5,"True","True")[/INDENT]  
[INDENT]By default if there are not 2 full rows of views the layout will be adjusted to take the smallest space that fits the number of columns.[/INDENT]  
[INDENT]Set Adjust to False to override this behaviour.[/INDENT]  
[INDENT]Views modified with VertexViewAll(6,0,Pane1)[/INDENT]  
[INDENT]Vertical Hexagons are flat side up. Scale adjustment is driven by x axis only.[/INDENT]  
  
  
[INDENT][/INDENT]  
[INDENT]**LayoutHexagonsHorizontal**(DesignerArgs As DesignerArgs)[/INDENT]  
[INDENT]Parameters: Pane as B4xView, Columns As int, Margin As int, ScaleFont As string ("True"/"", "False")[/INDENT]  
[INDENT]Designer Script : DSE\_Shapes.LayoutHexagonsVertical(Pane1,5,5,"True")[/INDENT]  
[INDENT]Views modified with VertexViewAll(6,90,Pane1)[/INDENT]  
[INDENT]Horzontal Hexagons are Pointy side up. Scale adjustment is driven by x axis only.[/INDENT]  
  
  
  
  
  
  
[/SPOILER]  
  
The two layout methods are specifically for Hexagons. One each for Points up (Horizontal) and Flat up (Vertical).  
  

![](https://www.b4x.com/android/forum/attachments/134048)

  
  
The example project contains two layouts one for each hexagon orientation.  
  
**External Dependencies**  
[INDENT]None[/INDENT]  
[INDENT][/INDENT]  
[INDENT][/INDENT]  
I hope you find this class useful.  
[INDENT][/INDENT]