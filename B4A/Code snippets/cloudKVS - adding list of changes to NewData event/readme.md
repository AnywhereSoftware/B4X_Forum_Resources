### cloudKVS - adding list of changes to NewData event by Dave O
### 09/19/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/152001/)

Hi all,  
  
When using [cloudKVS](https://www.b4x.com/android/forum/threads/b4x-cloudkvs-synchronized-key-value-store.63536/#content), its NewData event tells you when changes have been downloaded from the server, but there's no easy way to find out which data has changed. See [this thread](https://www.b4x.com/android/forum/threads/cloudkvs-how-to-identify-specific-changes-on-newdata-event.151201/) for details.  
  
[USER=1]@Erel[/USER] identified where this could be determined, so I've written and tested the following (straightforward) code changes to the clientKVS source file. The NewData event now returns a list of the changed items (identified by user/key), which you can use for further processing, showing recent activity to the user, etc.  
  
Here are the changes:  
  

```B4X
'#Event: NewData  
#Event: NewData(changeList as list)  
  
'when converting the downloaded data back into database items, create a list of what changed  
Private Sub ser_BytesToObject (Success As Boolean, NewObject As Object)  
   …  
      For Each itemInstance As item In items  
         InsertItemIntoData(itemInstance, True)  
         addItemUserKeyToChangeList(itemInstance)        'new in 1.1  
      Next  
   …  
End Sub  
  
'when raising the NewData event, return the change list as a new parameter  
Private Sub GetUser_NonQueryComplete (Success As Boolean)  
    If Not(Success) Then  
        Log("Error writing to database: " & LastException)  
    End If  
'    CallSub(mCallback, mEventName & "_newdata")  
    Dim tempList As List                'new in 1.1  
    tempList.Initialize                'new in 1.1  
    tempList.AddAll(changeList)    'new in 1.1  
    CallSub2(mCallback, mEventName & "_newdata", tempList)        'new in 1.1  
    changeList.Clear                    'new in 1.1  
End Sub  
  
'new in 1.1  
'track each change as just the user and key fields, not the whole data item  
Private Sub addItemUserKeyToChangeList(itemArg As item)  
    Dim changeItem As changeType  
    changeItem.Initialize  
    changeItem.UserField = itemArg.UserField  
    changeItem.KeyField = itemArg.KeyField  
    changeList.Add(changeItem)  
End Sub
```

  
  
Then we just change the NewData event handler to accept the change list that we've added to the event:  

```B4X
Sub ckvs_NewData(changeListArg As List)  
    …  
End Sub
```

  
  
In my case, I then loop through the changes, grab some data from the referenced data items (found using the user and key fields), and construct a "recent activity" listview so the user can see what's changed.  
  
I've attached the updated clientKVS file (which I've marked as 1.1 for myself, but it's an unofficial fork, really).  
  
Hope this helps!