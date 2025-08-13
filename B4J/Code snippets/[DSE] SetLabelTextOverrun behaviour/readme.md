### [DSE] SetLabelTextOverrun behaviour. by stevel05
### 04/20/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143082/)

It seems more appropriate to post small Designer Script Extensions here so here's another one.  
  
Set the TextOverrun behavior for a Label.  
  
Usage:  
  

```B4X
{Class}.SetLabelTextOverrun("CENTER_WORD_ELLIPSIS",Label2,Label3)
```

  
{Class} is whichever class you put the method in.  
  
You can set the same behaviour on multiple labels at once.  
  

```B4X
'Parameters: Type As String, 1 or more Labels (Comma delimited)  
'Type : One Of - CENTER_ELLIPSIS, CENTER_WORD_ELLIPSIS, CLIP, ELLIPSIS, LEADING_ELLIPSIS, LEADING_WORD_ELLIPSIS, WORD_ELLIPSIS  
'Designer Script : {Class}.SetLabelTextOverrun("CENTER_ELLIPSIS",Label2)  
Public Sub SetLabelTextOverrun(DesignerArgs As DesignerArgs)  
    If DesignerArgs.FirstRun Then  
        Dim TType As String = DesignerArgs.Arguments.Get(0)  
        For i = 1 To DesignerArgs.Arguments.Size - 1  
            Dim JO As JavaObject = DesignerArgs.GetViewFromArgs(i)  
            JO.Runmethod("setTextOverrun",Array(TType))  
        Next  
    End If  
End Sub
```

  
  
Find out more about the behaviour options [here](https://docs.oracle.com/javase/8/javafx/api/javafx/scene/control/OverrunStyle.html)