### [DSE] SetToggleGroup (RadioButton / ToggleButton) by stevel05
### 09/22/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143089/)

A designer script extension that allows control over the grouping of Toggles (RadioButton And ToggleButtons) so that only one from the group can be selected at a time.  
  
B4x automatically groups RadioButtons on the same Pane. You can use this to change that behaviour which may, or may not, make the layout simpler to implement, and additionally group ToggleButtons.  
  
If the chosen selected Index is out of range, then the selected Index of 0 will be used.  
  
Usage:  

```B4X
{Class}.SetToggleGroup(0,RadioButton1,Radiobutton2)
```

  
{Class} is whichever class you put the method in.  
  

```B4X
'Parameters: SelectedIndex as Int, 2 or more RadioButtons or ToggleButtons  
'DesignerScript: {Class}.SetToggleGroup(0,RadioButton1,Radiobutton2)  
Public Sub SetToggleGroup(DesignerArgs As DesignerArgs)  
   
    Dim SelectedIndex As Int = DesignerArgs.Arguments.Get(0)  
    Dim RBG As JavaObject  
    RBG.InitializeNewInstance("javafx.scene.control.ToggleGroup",Null)  
   
    For i = 1 To DesignerArgs.Arguments.Size - 1  
        Dim RB As JavaObject = DesignerArgs.GetViewFromArgs(i)  
        RB.RunMethod("setToggleGroup",Array(RBG))  
    Next  
   
    If SelectedIndex < 0 Or SelectedIndex > DesignerArgs.Arguments.Size - 2 Then  
        SelectedIndex = 0  
    End If  
    DesignerArgs.GetViewFromArgs(SelectedIndex + 1).As(JavaObject).RunMethod("setSelected",Array(True))  
   
End Sub
```