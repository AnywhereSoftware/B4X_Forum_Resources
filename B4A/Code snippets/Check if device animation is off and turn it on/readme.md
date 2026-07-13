### Check if device animation is off and turn it on. by Mashiane
### 07/10/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171512/)

Hi Fam!  
  
So I spent some time wondering why my FAB Animation was not working, only to realize that my device system animation was turned off. To turn them on I had to access Developer Options and turn them on there. For my phone the animations are switched off.  
  

```B4X
public Sub AreSystemAnimationsEnabled As Boolean  
    #If B4A  
    Try  
        Dim jo As JavaObject  
        jo.InitializeStatic("android.animation.ValueAnimator")  
        Return jo.RunMethod("areAnimatorsEnabled", Null)  
    Catch  
        Return True ' pre-API 26 fallback: assume enabled  
    End Try  
    #Else  
    Return True  
    #End If  
End Sub  
  
public Sub ForceAnimatorDurationScale(Scale As Float) As Boolean  
    #If B4A  
    Try  
        Dim jo As JavaObject  
        jo.InitializeStatic("android.animation.ValueAnimator")  
        jo.RunMethod("setDurationScale", Array As Object(Scale))  
        Return True  
    Catch  
        Log("ForceAnimatorDurationScale failed: " & LastException.Message)  
        Return False  
    End Try  
    #Else  
    Return False  
    #End If  
End Sub
```

  
  
Usage  
  

```B4X
'just check if animations are enabled  
    Dim bHasAnimation As Boolean = B4XDaisyVariants.AreSystemAnimationsEnabled  
    Log($"Animation Enabled: ${bHasAnimation}"$)  
    If bHasAnimation = False Then  
        'ensure animation is turned on  
        B4XDaisyVariants.ForceAnimatorDurationScale(1)  
    End If
```

  
  
This is not a documented Android Feature..  
  
![](https://www.b4x.com/android/forum/attachments/172334) ![](https://www.b4x.com/android/forum/attachments/172335)