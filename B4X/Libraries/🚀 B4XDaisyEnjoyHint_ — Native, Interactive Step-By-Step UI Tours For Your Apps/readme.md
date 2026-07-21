###  🚀 B4XDaisyEnjoyHint: — Native, Interactive Step-By-Step UI Tours For Your Apps by Mashiane
### 07/15/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171566/)

Hi Fam!  
  
If you have ever struggled to build a clean, reliable onboarding tutorial for your users, **B4XDaisyEnjoyHint** is exactly what you need. Inspired by the popular xbsoftware EnjoyHint JavaScript library, this native B4X class allows you to create interactive, step-by-step app tours. It automatically darkens the screen, punches perfectly shaped holes (circles or rounded rectangles) to spotlight your target views, and draws beautiful kinetic arrows to guide your users. It even auto-scrolls ScrollViews to ensure your target is visible!  
  
![](https://www.b4x.com/android/forum/attachments/172414) ![](https://www.b4x.com/android/forum/attachments/172415) ![](https://www.b4x.com/android/forum/attachments/172416) ![](https://www.b4x.com/android/forum/attachments/172417) ![](https://www.b4x.com/android/forum/attachments/172419) ![](https://www.b4x.com/android/forum/attachments/172420)  
  
![](https://www.b4x.com/android/forum/attachments/172421) ![](https://www.b4x.com/android/forum/attachments/172422) ![](https://www.b4x.com/android/forum/attachments/172423) ![](https://www.b4x.com/android/forum/attachments/172424) ![](https://www.b4x.com/android/forum/attachments/172425)  
  
**Quick Start**  
  
Getting started is incredibly easy. Here is a basic implementation:  
  

```B4X
' Initialize the component  
Dim comp As B4XDaisyEnjoyHint  
comp.Initialize(Me, "comp", Root)  
  
' Customize core properties (Optional)  
comp.BtnNextText = "Next Step"  
comp.RectCornerRadius = 12dip  
  
' Add your steps  
' Syntax: TargetView, Message, Shape (circle/rect), Margin, TimeoutMs, ArrowPosition  
comp.AddStep(ProfilePicView, "This is your profile picture. Tap to change it.", "circle", 10dip, 0, "auto")  
comp.AddStep(EmailInputView, "Provide a valid email address.", "rect", 5dip, 0, "auto")  
comp.AddStep(VolumeSliderView, "Drag to adjust the volume level.", "rect", 5dip, 0, "auto")  
  
' Start the tour with state persistence  
comp.RunWithResume
```

  
  
**Key Events**  
  
You can easily trap events to trigger specific app logic as the user navigates the tour:  
  

```B4X
Sub comp_OnNextClick  
    Log("User clicked next!")  
End Sub  
  
Sub comp_OnSkipClick  
    Log("Tour was skipped.")  
End Sub  
  
Sub comp_OnFinished  
    Log("Tour completed successfully.")  
End Sub  
  
Sub comp_OnOverlayClick  
    Log("User tapped the dark background.")  
End Sub
```

  
  
Why Use It?  

- **Zero Math Layouts:** Forget calculating exact view coordinates or dealing with z-indexes. The component finds the view and cuts the overlay automatically via Canvas blending modes.
- **Smart Auto-Scrolling:** If a step targets a view hidden inside a ScrollView, the component automatically scrolls the view into position before showing the hint.
- **Persistent State:** Using RunWithResume saves the user's progress. If they exit your app on step 3, they will resume exactly at step 3 when they return.

  
[MEDIA=youtube]AgxOtt3X1k0[/MEDIA]