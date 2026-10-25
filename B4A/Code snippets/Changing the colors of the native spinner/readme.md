###  Changing the colors of the native spinner by GeoT
### 10/21/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/172337/)

To change the color of the native spinner and its dropdown.  
Can be used to change themes (for example, switching between dark mode and light mode) at runtime without losing the user's selection or dealing with visual glitches from the native Android adapter.  
  
Complements the color change of its arrow, mentioned in <https://www.b4x.com/android/forum/threads/how-to-change-color-of-combobox-or-spinner-drop-down-arrow.122959/#post-878186>  
  
The main control function:  

```B4X
Public Sub RefreshSpinnerDropdownColors(Spn As Spinner, ItemTextColor As Int, DropdownBgColor As Int)  
    
    ' Save the currently selected index  
    Dim CurrentIndex As Int = Spn.SelectedIndex  
    
    ' Extract the current texts from the Spinner  
    Dim ItemsList As List  
    ItemsList.Initialize  
    For i = 0 To Spn.Size - 1  
        ItemsList.Add(Spn.GetItem(i))  
    Next  
    
    SetSpinnerItemsWithTheme(Spn, ItemsList, ItemTextColor, DropdownBgColor)  
    
    ' Restore the previous selection  
    If CurrentIndex >= 0 And CurrentIndex < Spn.Size Then  
        Spn.SelectedIndex = CurrentIndex  
    End If  
End Sub
```

  
  
Application and refresh function:  

```B4X
Public Sub SetSpinnerItemsWithTheme(Spn As Spinner, Items As List, ItemTextColor As Int, DropdownBgColor As Int)  
    ' 1. Apply the colors natively  
    Spn.DropdownBackgroundColor = DropdownBgColor  
    Spn.DropdownTextColor = ItemTextColor  
    
    ' 2. Directly add the texts as pure Strings  
    Spn.Clear  
    For Each ItemText As String In Items  
        Spn.Add(ItemText)  
    Next  
    
    ' 3. Refresh the adapter using JavaObject to force the visual change  
    ' Request the current adapter directly from the native Android Spinner.  
    ' Reassigning it (setAdapter) forces the component to detach and re-attach,  
    ' forcing the views to re-inflate with the new theme colors.  
    Dim spinnerJO As JavaObject = Spn  
    Dim freshAdapter As JavaObject = spinnerJO.RunMethod("getAdapter", Null)  
  
    If freshAdapter.IsInitialized Then  
        spinnerJO.RunMethod("setAdapter", Array(freshAdapter)) ' Reinstalls the adapter to apply visual styles  
        freshAdapter.RunMethod("notifyDataSetChanged", Null)  ' Notifies the data change  
    End If  
End Sub
```

  
  
Note: Assisted by Gemini AI