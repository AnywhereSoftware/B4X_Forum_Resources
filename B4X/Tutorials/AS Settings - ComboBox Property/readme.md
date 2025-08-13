###  AS Settings - ComboBox Property by Alexander Stolte
### 08/04/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/159266/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/>  
  
With this property, the user can quickly select one of several options via a combobox. It use the native combo box for each platform.  
  
![](https://www.b4x.com/android/forum/attachments/150851)  
  
![](https://www.b4x.com/android/forum/attachments/150852)  
  
**Example**  

```B4X
'ComboBox  
AS_Settings1.MainPage.AddProperty_ComboBox("Advanced","PropertyName_12","ComboBox Example","",Null,"Option 2",Array("Option 1","Option 2","Option 3","Option 4"))
```

  
  
**ComboBox2**  
The problem with the normal ComboBox is that you can only set one value and this value is then displayed and saved in the list. But what if you have several languages and then change the language or the order of the list changes. Then the previously saved values are lost.  
  
Here you define a value and a DisplayText, so the text and the order can change without affecting the saved value.  

```B4X
Dim ComboBox2 As B4XOrderedMap = B4XCollections.CreateOrderedMap2(Array("Key1","Key2","Key3","Key4"),Array("DisplayText 1","DisplayText 2","DisplayText 3","DisplayText 4"))  
AS_Settings1.MainPage.AddProperty_ComboBox2("Advanced","PropertyName_13","ComboBox Example","",Null,"Key4",ComboBox2)
```

  
  
**Events**  
The ValueChanged event is triggered when the user has selected an item.  

```B4X
Private Sub AS_Settings1_ValueChanged(Property As AS_Settings_Property, Value As Object)  
    'Log("ValueChanged " & Property.PropertyName & ": " & Value)  
   
    Select Property.PropertyName  
        Case "PropertyName_12"  
            Log(Value)  
    End Select  
   
End Sub
```