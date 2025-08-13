### [DSE] PaneLayout by stevel05
### 04/28/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/147621/)

I've been working a lot in MySQL lately and got fed up creating layouts that were very similar to show audit reports.  
  
I came up with this which is a designer script extension that loads however many labels you specify into a pane. You can define the widths, left margin and EventNames for the labels so they can respond to being clicked.  
  

![](https://www.b4x.com/android/forum/attachments/141561)

  
  
Set up is:  
  
Define the pane to be filled in the designer script. [ICODE]DSE\_Layout.Create(pnTitle)[/ICODE]  
  

```B4X
    Dim DSE As DSE_PaneLayout  
    DSE.Initialize  
    XUI.RegisterDesignerClass(DSE)  
    DSE.Count = 4  
    DSE.Widths = Array As Double(150,150,150,350)  
    DSE.LeftMargin = 5  
    DSE.EventNames = Array As String("","","","Web")
```

  
  
The class needs to be registered as a designer class so that it does not get loaded with the layout  
The parent layout should have HandleResizeEvent disabled, which means resizing is handled in the report class and needs to be delegated from the main module (or b4xPage).  
  
The class is in the project, you could amend it to add different views if you wanted to.  
  
The project includes a small SQLite database so you need one of the sqlite-jdbc jar versions in your library and change the #AdditionaJar directive to match.  
  
You should be able to use it in B4a, and maybe B4i, if you change the event handling code to suit.  
  
Data was taken from <https://www.briandunning.com/sample-data/>  
  
I hope you find it useful.  
  
**Update V1.1**  
Removed the need to manage resize.  
  
**Update V1.2**  
Added Checkbox, Combobox, Textfield, Spacing between views and Reset so that the same class can be reused.  
  
See report 2, Only Textfield actually does anything in the demo, Combobox and Checkbox just log the fact that they have been changed.  
The Reset method resets all options to default so that the class can be easily reused.