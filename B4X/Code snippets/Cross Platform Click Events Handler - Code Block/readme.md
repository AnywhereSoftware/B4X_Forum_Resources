###  Cross Platform Click Events Handler - Code Block by William Lancee
### 08/16/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/149627/)

I do a lot of x-platform coding. All my development work is on B4J and then I adjust the code for B4A.  
As part of that adjustment I have to write different code for B4J and B4A and B4i (if I used that).  
  
Since I use short and long/right click and since many of my 'buttons' are 'labels', click event handling requires a bit of repetitive work.  
  
The Designer Script Extensions presents a method that can do this once and for all with the following short code snippet.  
It will work with B4A, B4i, and B4J for Buttons, Labels, ImageViiews and Panels/Panes.  
  
Requirements:   
1. In designer add DDD.CollectViewsData to Script  
2. Check DesignerUtils in Libraries Manager  
3. Name the event of the affected views "X\_C" - do not use designer tool to Generate Members (it will add conflicting event handlers)  
4. In Initialize Sub of B4XMainPage initialize an instance of DDD and register it  
5. If you want to include a view that is created by code at runtime, use dd.AddRuntimeView(…) to register it  
  

```B4X
#Region Xplatform Click Handling - Normal and Extra (LongClick or RightClick for B4J)  
'Any Button, Label, ImageView, Panel/Panes with "X_C" as its event name will be handled by subs below  
'Note: don't use this method for other types of views - it will be inconsistent across platforms  
'The target event will be: ViewName_NormalClick and ViewName_ExtraClick   
#if B4J  
Private Sub X_C_MouseClicked(eV As MouseEvent)  
    Dim vdata As DDDViewData = dd.GetViewData(Sender)        'really fast: tested 4 msec per 100000 calls on B4J  
    If eV.SecondaryButtonPressed Then CallSub(Me, vdata.name & "_ExtraClick") Else CallSub(Me, vdata.name & "_NormalClick")  
End Sub  
#Else If B4A Or B4i  
Private Sub X_C_Click  
    Dim vdata As DDDViewData = dd.GetViewData(Sender)  
    CallSub(Me, vdata.Name & "_NormalClick")  
End Sub  
Private Sub X_C_LongClick  
    Dim vdata As DDDViewData = dd.GetViewData(Sender)  
    CallSub(Me, vdata.Name & "_ExtraClick")  
End Sub  
#End If  
#End Region
```

  
  
To use, add target event handlers named after the view name (not the event name)  
  

```B4X
Private Sub Button1_NormalClick  
    xui.MsgboxAsync("Hello World - Normal Click", "B4X")  
End Sub  
  
Private Sub Button1_ExtraClick        'Long (>300msec) or Right (B4J)  
    xui.MsgboxAsync("Hello World - Extra Click", "B4X")  
End Sub
```

  
  
Suggestions and comments are welcome, as are alternative approaches that you find useful.