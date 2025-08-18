### CalcRelativeKeyboardHeight Example by Erel
### 05/26/2021
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/64054/)

**Better implementation: <https://www.b4x.com/android/forum/threads/b4x-b4xpages-customlistview-keyboard-handling.131078/>**  
  
A new method was added to all views named CalcRelativeKeyboardHeight. With this method you can calculate the keyboard's top line relatively to the current view.  
  
This is useful with long views that shouldn't be hidden by the keyboard.  
  
For example in this project there is a TableView and a CustomListView. When the keyboard appears they should be both adjusted so the user can still see all of the items.  
  
![](https://www.b4x.com/android/forum/attachments/41977)  
  
With the keyboard (the keyboard is not included in the screenshot, but it is there):  
  
![](https://www.b4x.com/android/forum/attachments/41978)  
  
This is the relevant code:  

```B4X
Private Sub Page1_KeyboardStateChanged (Height As Float)  
   Dim TableViewMaxHeight As Int = TableView1.BaseView.CalcRelativeKeyboardHeight(Height)  
   Dim TableViewMaxHeightWithNoKeyboard As Int = Page1.RootPanel.Height - 10dip - TableView1.BaseView.Top  
   'If the keyboard is visible then the TableView ends at the keyboard's top line.  
   'Otherwise the TableView will end a few pixels from the full page size.  
   TableView1.BaseView.Height = Min(TableViewMaxHeight, TableViewMaxHeightWithNoKeyboard)  
   'We are doing the same thing for the CLV.  
   CustomListView1.GetBase.Height = Min(CustomListView1.GetBase.CalcRelativeKeyboardHeight(Height), _  
      Page1.RootPanel.Height - 10dip - CustomListView1.GetBase.Top)  
End Sub
```