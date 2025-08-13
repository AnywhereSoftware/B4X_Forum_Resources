###  AS Settings - Action Property by Alexander Stolte
### 02/14/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/159263/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/>  
  
This property is used, for example, to manage properties that are on another page. Or to open links, open a picker so that the user can select something, a date for example.  
  
![](https://www.b4x.com/android/forum/attachments/150844)  
**Example**  

```B4X
'Action Button  
AS_Settings1.MainPage.AddProperty_Action("Basic","PropertyName_4","Action Property","",Null,"English")  
AS_Settings1.MainPage.AddProperty_Action("Basic","PropertyName_5","Icon","",AS_Settings1.FontToBitmap(Chr(0xF179),False,30,xui.Color_White),"English, German, Italian, Spanish, Swedish")  
AS_Settings1.MainPage.AddProperty_Action("Basic","PropertyName_6","Pro Feature","",Null,"Pro")
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
        Case "PropertyName_6" 'Creates the green "Pro" chip  
            Dim ChipWidth As Float = 45dip  
            Dim ChipHeight As Float = 20dip  
          
            Dim xlbl_ProVersionChip As B4XView = CustomDrawProperty.PropertySettingViews.ActionValueLabel  
            Dim xlbl_ActionButtonArrowLabel As B4XView = CustomDrawProperty.PropertySettingViews.ActionButtonArrowLabel  
            xlbl_ProVersionChip.SetTextAlignment("CENTER","CENTER")  
            xlbl_ProVersionChip.Font = xui.CreateDefaultBoldFont(15)  
            xlbl_ProVersionChip.SetColorAndBorder(xui.Color_ARGB(255,81,190,97),0,0,ChipHeight/2)  
            'Resize the Chip Label  
            xlbl_ProVersionChip.SetLayoutAnimated(0,xlbl_ActionButtonArrowLabel.Left - ChipWidth - 5dip,CustomDrawProperty.PropertySettingViews.BackgroundPanel.Height/2 - ChipHeight/2,ChipWidth,ChipHeight)  
    End Select  
      
End Sub
```