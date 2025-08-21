### Choicebox set items by stevel05
### 12/05/2019
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/111949/)

**SubName**: ChoiceBox\_MousePressed  
  
**Description**:  
[INDENT][INDENT][INDENT][INDENT]If you need to set the items in a choice box based on data or processes in your app it can be problematic to maintain the list when multiple changes occur, this can simplified by setting the items just before the choices are presented where you only have to create the items list once.  
  
To do this we can use the standard MousePressed callback which fires before the choices are shown.  
  
If you have more than one Choicebox, you can set the event names the same and handle them all in one sub, or do them separately if you prefer.[/INDENT][/INDENT][/INDENT][/INDENT]  
  
**Code**:  

```B4X
Private Sub ChoiceBox_MousePressed (EventData As MouseEvent)        'ChoiceBox is the eventname set for your Choicebox(es)  
    If Sender = cbNewRecordTag Then                                    'Create data for this Choicebox if you have multiple choice boxes, set the eventnames the same and select the currently clicked one here  
        Dim JO As JavaObject = Sender  
        If JO.RunMethod("isShowing",Null) = False Then                'Only populate new data if the Choicebox is opening  
            cbNewRecordTag.Items.Clear                                'Clear existing entries  
            For Each Item As String In MineXML1.NonDataMap.Keys        'Populate the choices  
                cbNewRecordTag.Items.Add(Item)  
            Next  
        End If  
    End If  
End Sub
```

  
  
  
**Dependencies**: None  
  
Tags: Choicebox set items