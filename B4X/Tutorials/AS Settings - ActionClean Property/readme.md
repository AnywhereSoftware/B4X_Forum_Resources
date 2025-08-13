###  AS Settings - ActionClean Property by Alexander Stolte
### 02/14/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/159264/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/>  
  
This property is like the [action property](https://www.b4x.com/android/forum/threads/b4x-as-settings-action-property.159263/), only in a cleaner version. Here there is only an icon and the display text of the property.  
  
![](https://www.b4x.com/android/forum/attachments/150846)  
**Example**  

```B4X
AS_Settings1.MainPage.AddProperty_ActionClean("Basic","PropertyName_8","Delete Account","",AS_Settings1.FontToBitmap(Chr(0xE92B),True,34,xui.Color_White))
```

  
  
**Events**  
This property has its own event to react when the user has clicked on this property, e.g. to open another page or to open a link in the browser  

```B4X
Private Sub AS_Settings1_ActionClicked(Property As AS_Settings_Property)  
    Log("ActionClicked: " & Property.PropertyName)  
     
    Select Property.PropertyName  
        Case "PropertyName_4"  
            'Do something  
        Case "PropertyName_5"  
            'Do something  
        Case "PropertyName_6"  
            'Do something  
    End Select  
  
End Sub
```

  
**CustomDrawProperty Event**  
In a custom draw event you can change the complete appearance of a property and also add new views or remove existing views.  

```B4X
Private Sub AS_Settings1_CustomDrawProperty(CustomDrawProperty As AS_Settings_CustomDrawProperty)  
     
    Select CustomDrawProperty.Property.PropertyName  
        Case "PropertyName_8"  
            CustomDrawProperty.PropertyViews.NameLabel.TextColor = xui.Color_ARGB(255,221, 95, 96) 'Display name in red  
            CustomDrawProperty.PropertyViews.IconImageView.SetBitmap(AS_Settings1.FontToBitmap(Chr(0xE92B),True,34,xui.Color_ARGB(255,221, 95, 96))) 'sets a new icon in red  
    End Select  
     
End Sub
```