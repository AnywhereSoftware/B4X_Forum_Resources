### [B4XDaisyUIKit] A curious Native DeclarativeUI Experiment by Mashiane
### 10/08/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/172227/)

Hi gang  
  
[USER=154335]@Maxcfgos[/USER] post about [DeclarativeUI](https://www.b4x.com/android/forum/threads/b4a-declarativeui-library.171723/) really impressed something in me, less code with great impact and no worries about left, top, height, width, addview when placing components and designing your UI.  
  
And yes, this is code friendly and abstract designer unfriendly… he he he… for AI Engineering, and those who love writing code it becomes some kind of a soft spot. Anyway after some careful research, I discovered that there are some things that Android does very well, like calculating view dimensions and layouts automatically without one having to think imperatively  
  
![](https://www.b4x.com/android/forum/attachments/173976)  
  
***So how was this possible?*  
  
Columns & Rows**  
  
Internal to the definition, we have some interesting code and more…  
  

```B4X
#If B4A  
Private Sub EnsureNativeLayout  
    If joLayout.IsInitialized Then Return  
    Try  
        Dim joContext As JavaObject  
        joContext.InitializeContext  
        joLayout.InitializeNewInstance("android.widget.LinearLayout", Array(joContext))  
        joLayout.RunMethod("setOrientation", Array(1)) ' 1 = VERTICAL  
          
        Dim joParams As JavaObject  
        joParams.InitializeNewInstance("android.widget.FrameLayout$LayoutParams", Array(-1, -1))  
          
        If mBase.IsInitialized Then  
            Dim vwBase As View = mBase  
            Dim joBase As JavaObject = vwBase  
            joBase.RunMethod("addView", Array(joLayout, joParams))  
        End If  
          
        ApplyPadding  
        ApplyGravity  
        If miBackgroundColor <> 0 Then joLayout.RunMethod("setBackgroundColor", Array(miBackgroundColor))  
    Catch  
        If B4XDaisyApp.DebugLogs Then Log("B4XDaisyColumn.EnsureNativeLayout: " & LastException.Message)  
    End Try  
End Sub
```