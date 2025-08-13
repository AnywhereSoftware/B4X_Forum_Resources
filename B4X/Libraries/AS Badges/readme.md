###  AS Badges by Alexander Stolte
### 01/29/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/142053/)

I took the original [Badger](https://www.b4x.com/android/forum/threads/b4x-xui-badger-add-badges-to-views.81723/#content) code from [USER=1]@Erel[/USER] and modified it to create a new view.  
  
I spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/131896)![](https://www.b4x.com/android/forum/attachments/131897)  
![](https://www.b4x.com/android/forum/attachments/131898)![](https://www.b4x.com/android/forum/attachments/131899)  
[MEDIA=youtube]EV1yYr-kLrA[/MEDIA]  
  
**TextAnimation\_Slide**  
![](https://www.b4x.com/android/forum/attachments/131928)  
**TextAnimation\_Growth**  
![](https://www.b4x.com/android/forum/attachments/131929)  
**TextAnimation\_FadeIn**  
![](https://www.b4x.com/android/forum/attachments/131930)  

```B4X
Dim BadgeProperties As AS_Badges_BadgeProperties = AS_Badges1.BadgeProperties  
BadgeProperties.BackgroundColor = xui.Color_Red  
BadgeProperties.Orientation = AS_Badges1.Orientation_TopLeft  
AS_Badges1.SetBadge2(xlbl_Label,8,BadgeProperties)
```

  
**ASBadges  
Author: Alexander Stolte  
Version: 1.01**  

- **AS\_Badges**

- **Functions:**

- **Class\_Globals** As String
- **CreateAS\_Badges\_BadgeProperties** (BackgroundColor As Int, TextColor As Int, xFont As B4XFont, Orientation As String) As AS\_Badges\_BadgeProperties
- **GetBadgeCounter** (view As B4XView) As Int
*Gets the Count of the badge on this view*- **getBadgeProperties** As AS\_Badges\_BadgeProperties
- **getFadeInDuration** As Long
*Default: 250*- **getOrientation\_BottomLeft** As String
- **getOrientation\_BottomRight** As String
- **getOrientation\_TopLeft** As String
- **getOrientation\_TopRight** As String
- **getRadius** As Float
- **getTextAnimation** As String
- **getTextAnimation\_FadeIn** As String
- **getTextAnimation\_Growth** As String
- **getTextAnimation\_Slide** As String
- **getTextDuration** As Long
*Default: 250*- **Initialize** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SetBadge** (View As B4XView, Badge As Int) As String
- **SetBadge2** (View As B4XView, Badge As Int, Properties As AS\_Badges\_BadgeProperties) As String
- **setBadgeProperties** (Properties As AS\_Badges\_BadgeProperties) As String
- **setFadeInDuration** (Duration As Long) As String
- **setRadius** (Radius As Float) As String
- **setTextAnimation** (AnimationName As String) As String
- **setTextDuration** (Duration As Long) As String

- **Properties:**

- **BadgeProperties** As AS\_Badges\_BadgeProperties
- **FadeInDuration** As Long
*Default: 250*- **Orientation\_BottomLeft** As String [read only]
- **Orientation\_BottomRight** As String [read only]
- **Orientation\_TopLeft** As String [read only]
- **Orientation\_TopRight** As String [read only]
- **Radius** As Float
- **TextAnimation** As String
- **TextAnimation\_FadeIn** As String [read only]
- **TextAnimation\_Growth** As String [read only]
- **TextAnimation\_Slide** As String [read only]
- **TextDuration** As Long
*Default: 250*
- **AS\_Badges\_BadgeProperties**

- **Fields:**

- **BackgroundColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Orientation** As String
- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
**Changelog**  

- **1.00**

- Release

- **1.01 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-as-badges.142053/post-900290)**)**

- B4J BugFix - The text animation now no longer slips outside the badge
- Add get and set TextAnimation - Various text change animations

- Default: TextAnimation\_Slide
- TextAnimation\_Slide - The old text slides out to the right
- TextAnimation\_Growth - The font grows animated
- TextAnimation\_FadeIn - The alpha of the new text is increased animatedly

- **1.02 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-as-badges.142053/post-900741)**)**

- **Breaking Change** - Initialize needs now a CallBack and a EventName
- Add Event Click

- **1.03 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-as-badges.142053/post-960518)**)**

- BugFixes
- Add set AutoRemove - Removes the badge if the value is 0

- Default: True

- **1.04**

- Property descriptions added
- Add get and set xGap and yGap - This allows you to change the position of the badge. e.g. position it further to the left or higher up so that it matches the design.

- Default: 0

**Github:** [github.com/StolteX/AS\_Badges](https://github.com/StolteX/AS_Badges)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)