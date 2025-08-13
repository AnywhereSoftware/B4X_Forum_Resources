### InputList by Star-Dust
### 06/02/2023
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/148273/)

For my application I needed the **InputList** command, like in B4A. In B4J I managed to build it.  
In B4I there is an **ActionSheet** which achieves almost the same result. I say almost because it doesn't return the position but only the selected text. I needed exactly like in B4A, i.e. that I get the position, so I created a class where I rebuilt the ActionSheet by changing the data it returns to me.  
  
ActionSheet  

```B4X
Dim inputlist As ActionSheet  
inputlist.Initialize("inputlist", "Machine", "", "", Array As String("1","2","3"))  
inputlist.Show(Root)  
Wait For inputlist_Click (machine As String)  
Log(machine)
```

  
  
Use my Class  

```B4X
Dim InputList As ActionSheet2  
InputList.Initialize(Me,"inputlist",Array As String("1","2","3"))  
InputList.Show(Root,"Macchine",False)  
Wait For inputlist_Result (Index As Int)  
Log(Index)
```

  
  

```B4X
#Event: Result(Success As Boolean, Text As String)  
  
'Class module  
Sub Class_Globals  
    Private CallBack As Object  
    Private mEventName As String  
    Private items As List  
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize(Module As Object, EventName As String, Voices As List)  
    CallBack = Module  
    mEventName = EventName  
    items=Voices  
End Sub  
  
Public Sub Show(Pane As Panel,Title As String, Cancel As Boolean)  
    Dim no As NativeObject = Me  
    no.RunMethod("ShowInputList:::::", Array(Pane,"event_event", Title,items,Cancel))  
End Sub  
  
Private Sub InputList_Result(Index As Int)  
    If SubExists(CallBack, mEventName & "_Result", 1) Then CallSub2(CallBack, mEventName & "_Result", Index)  
End Sub  
  
#If OBJC  
- (void)ShowInputList:(UIView *)view:(NSString*)Event :(NSString*)Title :(NSArray*)array: (bool)canc  
{  
   // NSArray *array = @[@"1st Button",@"2nd Button",@"3rd Button",@"4th Button"];  
  
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:Title  
                                                             delegate:self  
                                                    cancelButtonTitle:nil  
                                               destructiveButtonTitle:nil  
                                                    otherButtonTitles:nil];  
    // ObjC Fast Enumeration  
    for (NSString *title in array) {  
        [actionSheet addButtonWithTitle:title];  
    }  
    if (canc) { actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];}  
  
    [actionSheet showInView:view];  
}  
  
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {  
    NSLog(@"%i", buttonIndex);  
    [self.bi raiseEvent:nil event:@"inputlist_result:" params:@[@(buttonIndex)]];  
}  
  
#End If
```