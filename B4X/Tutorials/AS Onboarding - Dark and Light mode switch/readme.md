###  AS Onboarding - Dark and Light mode switch by Alexander Stolte
### 07/15/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/162093/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-onboarding-payware.162065/>  
  
In this example I show how you can easily change the theme e.g. from a dark theme to a light one and how to do other cosmetic things.  
  
[MEDIA=youtube]HaUjPOgb0Oo[/MEDIA]  
  
It's easy:  

```B4X
AS_Onboarding1.Theme = AS_Onboarding1.Theme_Light
```

  

```B4X
AS_Onboarding1.Theme = AS_Onboarding1.Theme_Dark
```

  
  
There is a "ThemeChanging" event, this event is triggered after the theme is changed, but where it is not yet displayed to the user, so an event that triggers in the middle.  
In this event you can still change colors independently.  
  
In the following example we change the background color of the image view:  

```B4X
Private Sub AS_Onboarding1_ThemeChanging  
    For Each Page As AS_OnboardingPage In AS_Onboarding1.Pages 'Each page  
        For Each Item As AS_Onboarding_Item In Page.ItemList 'Each Item  
            If Item.ItemType = AS_Onboarding1.ItemType_Image Then 'If it is a B4XImageView  
                Dim OnboardingImage As B4XImageView = Item.View  
                If isDarkMode Then  
                    OnboardingImage.mBackgroundColor = xui.Color_ARGB(255,32, 33, 37) 'Dark mode color  
                Else  
                    OnboardingImage.mBackgroundColor = xui.Color_ARGB(255,233, 233, 233) 'Light mode color  
                End If  
                OnboardingImage.Update 'Update the B4XImageView  
            End If  
        Next  
    Next  
End Sub
```

  
  
A full exmaple project is in the attachment, **if you have questions, please make a new thread.**