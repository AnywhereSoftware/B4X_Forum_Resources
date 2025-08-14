### Back to edge-to-edge with B4A Ver13.4 and SDK 35 by Matt S.
### 07/19/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/167838/)

Dear Erel has disabled the edge-to-edge feature in the new version he released (B4A 13.4 - resources 7.25). This will be a great help for developers who don't want their page layout to be cluttered. But for me, who loves edge-to-edge, there needs to be a way back. I found it from Erel's codes and I summarized it as following:  
  
**Important:** It is assumed that you are using SDK 35 or 36.  
  
To do this, simply remove this line from the manifest:  
  

```B4X
CreateResourceFromFile(Macro, Themes.LightTheme)
```

  
  
And instead, put a template from Google itself, something like this:  
  

```B4X
SetApplicationAttribute(android:theme, "@android:style/Theme.Material.Light")
```

  
  
It will be edge-to-edge, but the toolbar is still there. If you want the toolbar to move away, add this event to the main file:  
  

```B4X
Sub Activity_WindowFocusChanged(HasFocus As Boolean)  
    Log(HasFocus)  
    If HasFocus Then  
        Try  
            Dim jo As JavaObject = Activity  
            Sleep(1500)  
            jo.RunMethod("setSystemUiVisibility", Array As Object(5894))  
        Catch  
            Log("setSystemUiVisibility did NOT work!")  
        End Try  
    End If  
End Sub
```

  
  
and call it at the beginning of Sub Activity\_Create like this:  
  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
  
    Activity_WindowFocusChanged(True)  
    
    Dim pm As B4XPagesManager  
    pm.Initialize(Activity)  
  
End Sub
```

  
  
The line "Sleep(1500)" is for the toolbar to go away with a delay so that the user can see it go away and understand where to bring it back. The delay can be adjusted as desired.  
  
care