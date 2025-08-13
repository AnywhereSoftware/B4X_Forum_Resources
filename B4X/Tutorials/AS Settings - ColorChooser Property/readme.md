###  AS Settings - ColorChooser Property by Alexander Stolte
### 11/01/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/163869/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/>  
  
This setting allows users to select a color. For example, to change the main app color, which is a premium feature in most apps.  
  
![](https://www.b4x.com/android/forum/attachments/158160) ![](https://www.b4x.com/android/forum/attachments/158161)  
  
**The size of the circles can be freely defined.**  
  
![](https://www.b4x.com/android/forum/attachments/158162)  
  
**Example**  

```B4X
    Dim lst_Colors As List  
    lst_Colors.Initialize  
    lst_Colors.Add(xui.Color_ARGB(255, 49, 208, 89))  
    lst_Colors.Add(xui.Color_ARGB(255, 25, 29, 31))  
    lst_Colors.Add(xui.Color_ARGB(255, 9, 131, 254))  
    lst_Colors.Add(xui.Color_ARGB(255, 255, 159, 10))  
    lst_Colors.Add(xui.Color_ARGB(255, 45, 136, 121))  
    lst_Colors.Add(AS_Settings1.CreateColorItem(xui.Color_ARGB(255, 73, 98, 164),False)) 'This item is deactivated and cannot be selected  
    lst_Colors.Add(AS_Settings1.CreateColorItem(xui.Color_ARGB(255, 221, 95, 96),False)) 'This item is deactivated and cannot be selected  
    lst_Colors.Add(AS_Settings1.CreateColorItem(xui.Color_ARGB(255, 141, 68, 173),False))'This item is deactivated and cannot be selected  
    lst_Colors.Add(xui.Color_Magenta)  
    lst_Colors.Add(xui.Color_Cyan)  
  
    'With Group  
    AS_Settings1.MainPage.AddProperty_ColorChooser("ColorChooser","AppColor",lst_Colors,xui.Color_Magenta,50dip,Null)
```

  
  
**Icons**  
You can add an icon which is displayed in the center right, e.g. to show that this is a premium feature and not available for free users.  
![](https://www.b4x.com/android/forum/attachments/158163)  
**Disable Items**  
You can deactivate items that are then not selectable for users. If the user clicks on such a disabled item, the [ICODE]DisabledItemClicked[/ICODE] event is triggered and the developer can react to it to signal to the user that this item is disabled.  
  
Just add a item to the list with the [ICODE]CreateColorItem[/ICODE] function and set the enabled property to [ICODE]False[/ICODE]  

```B4X
    Dim lst_Colors As List  
    lst_Colors.Initialize  
    lst_Colors.Add(xui.Color_Magenta) 'This item is selectable  
    lst_Colors.Add(AS_Settings1.CreateColorItem(xui.Color_ARGB(255, 73, 98, 164),False)) 'This item is deactivated and cannot be selected  
    lst_Colors.Add(AS_Settings1.CreateColorItem(xui.Color_ARGB(255, 221, 95, 96),False)) 'This item is deactivated and cannot be selected  
    AS_Settings1.MainPage.AddProperty_ColorChooser("ColorChooser","AppColor",lst_Colors,xui.Color_Magenta,50dip,Null)
```

  
  
**DisabledItemClicked Event**  
This event is triggered when the user clicks on a deactivated item.  
You can then react to this and, for example, inform the user that this is only selectable in the Premium version.  

```B4X
Private Sub AS_Settings1_DisabledItemClicked(Property As AS_Settings_Property, Value As Object)  
    LogColor("DisabledItemClicked",Value)  
End Sub
```

  
  
**ValueChanged Event**  
When the user selects an item, the ValueChanged event is triggered as normal and the value is the color defined for the item.  

```B4X
Private Sub AS_Settings1_ValueChanged(Property As AS_Settings_Property, Value As Object)  
    Select Property.PropertyName  
        Case "AppColor"  
            LogColor("ValueChanged AppColor",Value)  
    End Select  
End Sub
```

  
  
**Activate all deactivated items**  
The following situation: Changing colors is a premium feature, the user has now purchased the premium version, now we want to make the colors selectable and preferably hide the lock icon without having to rebuild the page.  

```B4X
Private Sub EnableAllItems(ColorChooserProperty As AS_Settings_Property_ColorChooser)  
    ColorChooserProperty.Property.Icon = Null 'Resets the icon e.g. the premium icon  
    For i = 0 To ColorChooserProperty.ColorList.Size -1  
        If ColorChooserProperty.ColorList.Get(i) Is AS_Settings_ColorItem Then  
            ColorChooserProperty.ColorList.Get(i).As(AS_Settings_ColorItem).Enabled = True 'Enables this item  
        End If  
    Next  
    SettingPage2.Refresh  
End Sub
```

  
You can get a property on the fly, with:  

```B4X
SettingPage2.GetProperty("AppColor").PropertyType  
'To call the function like:  
EnableAllItems(SettingPage2.GetProperty("AppColor").PropertyType)
```