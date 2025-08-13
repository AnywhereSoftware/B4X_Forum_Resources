### [B4j] [DSE] SetTooltipTextSize by stevel05
### 07/27/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/149044/)

Just a quick designer script extension to change the tooltip text size from the designer:  
  

```B4X
'Parameters: Size As Int, 1 or more Views (Comma delimited)  
'Designer Script : {Class}.SetTooltipTextSize(14,btn1,btn2)  
Public Sub SetTooltipTextSize(DesignerArgs As DesignerArgs)  
    If DesignerArgs.FirstRun Then  
        Dim Size As Double = DesignerArgs.Arguments.Get(0)  
        Dim F As B4XFont = XUI.CreateFont( DesignerArgs.GetViewFromArgs(1).As(B4XView).Font,Size)  
        
        For i = 1 To DesignerArgs.Arguments.Size - 1  
            Dim V As B4XView = DesignerArgs.GetViewFromArgs(i)  
            Dim TT As JavaObject = V.As(JavaObject).RunMethod("getTooltip",Null)  
            TT.Runmethod("setFont",Array(F))  
        Next  
    End If  
End Sub
```

  
  
{Class} is the B4j class that you put the code into. It can be any class. You can pass any node that supports tooltip.  
It uses the font as assigned to the target node, it would be simple to change if you wanted to.  
  
Tags: DSE tooltip text size