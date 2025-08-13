###  AS TextFieldAdvanced - ComboBox by Alexander Stolte
### 03/13/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/159854/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-textfieldadvanced-title-information-counter-password-button-prefix-suffix-icons-multiline.141337/#content>  
  
In this example I will show you how to quickly and easily turn the TextField into a ComboBox.  
  
![](https://www.b4x.com/android/forum/attachments/151724) ![](https://www.b4x.com/android/forum/attachments/151722) ![](https://www.b4x.com/android/forum/attachments/151723)  
  
1. Set the Mode to "ComboBox" in the designer  
![](https://www.b4x.com/android/forum/attachments/151725)  
2. Add Items to it  

```B4X
    Dim lst_Items As List  
    lst_Items.Initialize  
    lst_Items.Add("Item #1")  
    lst_Items.Add("Item #2")  
    lst_Items.Add("Item #3")  
    lst_Items.Add("Item #4")  
    lst_Items.Add("Item #5")  
      
    AS_TextFieldAdvanced1.SetItems(lst_Items)
```

  
3. Done  
  
**SelectedIndex**  
To select a specific item, there is the SelectedIndex property.  

```B4X
AS_TextFieldAdvanced1.SelectedIndex = 2
```

  
  
**Events**  
if an item has changed, the ComboBoxSelectedIndexChanged event is triggered.  

```B4X
Private Sub AS_TextFieldAdvanced1_ComboBoxSelectedIndexChanged(Index As Int)  
    Log("Selected Item Text: " & AS_TextFieldAdvanced1.Text)  
End Sub
```