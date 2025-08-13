###  AS TextFieldAdvanced + AS BottomPhoneNumberFlagPicker - Simply let your users enter their phone number by Alexander Stolte
### 12/04/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/157805/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-textfieldadvanced-title-information-counter-password-button-prefix-suffix-icons-multiline.141337/>  
+  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-bottomphonenumberflagpicker.157781/>  
=  
![](https://www.b4x.com/android/forum/attachments/148356)![](https://www.b4x.com/android/forum/attachments/148357)  
[MEDIA=youtube]L1ZNHiqvvgo[/MEDIA]  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private xtf_PhoneNumber As AS_TextFieldAdvanced  
    Private BottomPhoneNumberFlagPicker As AS_BottomPhoneNumberFlagPicker  
  
    Private xlbl_ThemeSwitch As B4XView  
End Sub
```

  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("frm_main")  
     
    BottomPhoneNumberFlagPicker.Initialize(Me,"BottomPhoneNumberFlagPicker",Root)  
    CustomizePhoneNumerTextField(xtf_PhoneNumber,True)  
End Sub
```

  

```B4X
Private Sub CustomizePhoneNumerTextField(xtf As AS_TextFieldAdvanced,isDark As Boolean)  
     
    xtf.Refresh 'is required in advance  
     
    Dim LeadingWidth As Float = 60dip  
    Dim xpnl_LeadingIconBackground As B4XView = xtf.LeadingIcon.View.xpnl_Background  
    Dim xlbl_LeadingPhoneNumberArrow As B4XView  
    Dim xpnl_Seperator As B4XView  
     
    If xtf.LeadingWidth = 0 Then  
        xtf.LeadingIcon.View.xiv_Icon.RemoveViewFromParent 'We dont need the default image view  
        xtf.Prefix.Text = BottomPhoneNumberFlagPicker.GetItem(GetCountry).DialCode  
         
        Dim xlbl_LeadingPhoneNumberFlag As B4XView = CreateLabel  
        xlbl_LeadingPhoneNumberFlag.Text = BottomPhoneNumberFlagPicker.GetItem(GetCountry).FlagEmoji  
        xlbl_LeadingPhoneNumberFlag.Font = xui.CreateDefaultFont(IIf(xui.IsB4i,25,20))  
        xlbl_LeadingPhoneNumberFlag.SetTextAlignment("CENTER","CENTER")  
        xpnl_LeadingIconBackground.AddView(xlbl_LeadingPhoneNumberFlag,5dip,0,LeadingWidth/2,xpnl_LeadingIconBackground.Height)  
     
        xlbl_LeadingPhoneNumberArrow = CreateLabel  
        xlbl_LeadingPhoneNumberArrow.Text = Chr(0xE5C5)  
        xlbl_LeadingPhoneNumberArrow.Font = xui.CreateMaterialIcons(20)  
        xlbl_LeadingPhoneNumberArrow.SetTextAlignment("CENTER","CENTER")  
        xpnl_LeadingIconBackground.AddView(xlbl_LeadingPhoneNumberArrow,LeadingWidth/2 + 5dip,0,LeadingWidth/2 - 5dip*2,xpnl_LeadingIconBackground.Height)  
     
        xpnl_Seperator = xui.CreatePanel("")  
        xpnl_Seperator.Color = IIf(isDark,xui.Color_ARGB(50,255,255,255),xui.Color_ARGB(50,0,0,0))  
        xpnl_LeadingIconBackground.AddView(xpnl_Seperator,LeadingWidth- 2dip,0,2dip,xpnl_LeadingIconBackground.Height)  
        Else  
        xlbl_LeadingPhoneNumberArrow = xtf_PhoneNumber.LeadingIcon.View.xpnl_Background.GetView(1)  
        xpnl_Seperator = xtf_PhoneNumber.LeadingIcon.View.xpnl_Background.GetView(2)  
    End If  
     
    'Theming  
    xlbl_LeadingPhoneNumberArrow.TextColor = IIf(isDark,xui.Color_White,xui.Color_Black)  
    xpnl_Seperator.Color = IIf(isDark,xui.Color_ARGB(50,255,255,255),xui.Color_ARGB(50,0,0,0))  
    xtf.BackgroundColor = IIf(isDark,xui.Color_ARGB(255,60, 64, 67),xui.Color_White)  
    xtf.TextColor = IIf(isDark,xui.Color_White,xui.Color_Black)  
    xtf.Prefix.TextColor = IIf(isDark,xui.Color_ARGB(100,255,255,255),xui.Color_ARGB(100,0,0,0))  
     
    'TextField Props  
    xtf.LeadingWidth = LeadingWidth  
    xtf.Prefix.xFont = xtf.TextField.Font  
    xtf.LeftGap = 0  
    xtf.MaskText = "XXX XXXXXXXX" 'Set in the designer the Mask property to "Left"  
    xtf.Refresh  
     
End Sub
```

  

```B4X
Private Sub xtf_PhoneNumber_LeadingIconClick  
     
    #If B4I  
    B4XPages.GetNativeParent(Me).ResignFocus  
    #End If  
     
    BottomPhoneNumberFlagPicker.Initialize(Me,"BottomPhoneNumberFlagPicker",Root)  
   
    BottomPhoneNumberFlagPicker.Color = xui.Color_ARGB(255,32, 33, 37)  
    BottomPhoneNumberFlagPicker.TextColor = xui.Color_White  
   
    'Selects an item with the dial code  
    BottomPhoneNumberFlagPicker.SelectItem2(xtf_PhoneNumber.Prefix.Text)  
   
    BottomPhoneNumberFlagPicker.ShowPicker  
     
    Wait For BottomPhoneNumberFlagPicker_ConfirmButtonClicked (Item As AS_BottomPhoneNumberFlagPicker_Item)  
     
    Dim xlbl_LeadingPhoneNumberFlag As B4XView = xtf_PhoneNumber.LeadingIcon.View.xpnl_Background.GetView(0)  
    xlbl_LeadingPhoneNumberFlag.Text = Item.FlagEmoji  
    xtf_PhoneNumber.Prefix.Text = Item.DialCode  
    xtf_PhoneNumber.Refresh  
     
End Sub
```

  

```B4X
#If B4I  
Private Sub GetCountry As String  
    Dim no As NativeObject  
    Dim s As String  = no.Initialize("NSLocale") _  
        .RunMethod("currentLocale", Null).RunMethod("objectForKey:", Array("kCFLocaleCountryCodeKey")).AsString  
    Return s  
End Sub  
#Else If B4A  
Private Sub GetCountry As String  
    Dim r As Reflector  
    r.Target = r.RunStaticMethod("java.util.Locale", "getDefault", Null, Null)  
    Return r.RunMethod("getCountry")  
End Sub  
#End If  
  
Private Sub xlbl_ThemeSwitch_Click  
    If xlbl_ThemeSwitch.Text = Chr(0xE430) Then  
        xlbl_ThemeSwitch.Font = xui.CreateFontAwesome(25)  
        xlbl_ThemeSwitch.Text = Chr(0xF186)  
        CustomizePhoneNumerTextField(xtf_PhoneNumber,False)  
        Else  
        xlbl_ThemeSwitch.Font = xui.CreateMaterialIcons(25)  
        xlbl_ThemeSwitch.Text = Chr(0xE430)  
        CustomizePhoneNumerTextField(xtf_PhoneNumber,True)  
    End If  
End Sub
```

  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.me/stoltex)