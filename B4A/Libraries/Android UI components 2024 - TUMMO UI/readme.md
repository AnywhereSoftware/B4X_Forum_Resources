### Android UI components 2024 - TUMMO UI by tummosoft
### 03/12/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/159029/)

This is a collection of specialized tools for Android that programmers often use in the deployment of Android projects. While not a cross-platform tool, it will make B4A proficient members more convenient in creating professional and easily maintainable apps, saving a lot of time.  
Below, I will provide a summary of the main functions of the **TummoHelper toolkit - Release 1.62:  
  
(1) ViewHelper:** This tool serves as a bridge between resources and views, receiving resource IDs from the ResourceHelper class and connecting to views.  
**(2) ResourcesHelper:** This class manages resources in a very easy way. Programmers can easily load any resources into views.  
**(3) RadialGradientHelper:** A gradient color utility for Android. Besides helping to quickly and easily create gradient colors, the tool also integrates some available color templates for programmers to choose from.  
**(4) LayoutHelper:** The LayoutHelper tool helps you load layouts into view groups like Panel, Activity, in a very convenient way.  
**(5) ColorsHelper:** A tool that helps manage and convert various color types.  
**(6) AnimationHelper:** Helps quickly create easy animations, which can be applied to almost any type of view.  
———————————–  
Source code: <https://github.com/tummosoft/TummoUI>  
  
**1. Example: Animation loading…**  
  

```B4X
Dim radius As Float  
    Dim centerX As Float  
    Dim centerY As Float  
    Private xImageView1 As xImageView  
   
    Dim anim As AnimationHelper  
    anim.initialize("anim")  
  
********  
Sub SetAnimal(ball As Label)  
    radius = 100dip  
    centerX = (100dip + ball.Width) / 2.0  
    centerY = (100dip + ball.Height) / 2.0  
End Sub  
  
Private Sub Button1_Click  
    Dim target As Float = 0  
    Dim theend As Float = 360  
    SetAnimal(ball1)  
    anim.startAccelerateDecelerateInterpolator(ball1,"anim", 1000, "rotation", target, theend)  
   
End Sub  
  
Sub anim_onAnimationUpdate(angle As Float)  
    Log("rolate:" & angle)  
    If ((angle > 160) And (angle < 180)) Then  
        Dim target As Float = 0  
        Dim theend As Float = 360  
        SetAnimal(ball2)  
        anim.startAccelerateDecelerateInterpolator(ball2,"anim2", 1000, "rotation", target, theend)  
    End If  
End Sub  
  
Sub anim2_onAnimationUpdate(angle As Float)  
   
    If ((angle > 160) And (angle < 180)) Then  
        Dim target As Float = 0  
        Dim theend As Float = 360  
        SetAnimal(ball3)  
        anim.startAccelerateDecelerateInterpolator(ball3,"anim3", 1000, "rotation", target, theend)  
    End If  
End Sub  
  
Sub anim3_onAnimationUpdate(angle As Float)  
   
    If ((angle > 160) And (angle < 180)) Then  
        Dim target As Float = 0  
        Dim theend As Float = 360  
        SetAnimal(ball1)  
        anim.startAccelerateDecelerateInterpolator(ball1,"anim", 1000, "rotation", target, theend)  
    End If  
   
End Sub
```

  
  
  
![](https://www.b4x.com/android/forum/attachments/151619)