### Edge Case use for B4XPages: Changing Orientation for Many Pages by Jack Cole
### 11/03/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/123906/)

This is for **advanced users only**. Please see [Erel's important cautions](https://www.b4x.com/android/forum/threads/b4xpages-allow-orientation-change.123906/post-774114) about using this approach below.  
  
This post and examples demonstrate how to extend B4XPages to allow orientation changes. It should be considered a beta version, since you may encounter some problem that I haven't yet discovered.  
  
**Background:** B4X continues to improve its cross-platform support. With the advent of B4XPages, you can share almost all of your code across platforms and/or develop single platform apps with a simpler lifecycle. As a design feature of B4XPages, there is a limitation that requires you to be locked to one orientation. There are some good rationales for this such as keeping the app lifecycle simple and trying to keep with some Android platform recommendations. This is probably a best practice for most people.  
  
As for me, my apps support both / changing orientation. My philosophy is that it is better to enable features that a signification percentage of users desire or will be frustrated by the lack of the feature. In my experience, this condition exists for many users of my apps (they want to be able to change orientations). I try to reduce friction for my users where I can.  
  
I have also written a [custom class](https://www.b4x.com/android/forum/threads/activityclass-a-cross-platform-development-class-and-strategy-for-b4i-b4a.109253/#content) that is used more for porting B4A apps to B4i. It replicates many of the same features of the Android Activity on iOS. It may be easier in some cases to use the [ActivityClass](https://www.b4x.com/android/forum/threads/activityclass-a-cross-platform-development-class-and-strategy-for-b4i-b4a.109253/#content) if you have a large existing Android app that you need to have the ability to change orientations. If you are developing a new app or have an existing iOS app, it may be easier to use the procedures I outline below. Note: if you are OK with being tied to one orientation, you should not use this technique. It is a little more complicated to manage the code than it is for a standard B4XPages project.  
  
**How To Use:  
  
1. Required Libraries**  
  
Your Android project must include the IME and JavaObject libraries. These libraries are used for catching the HeightChanged event. There is also a manifest line that prevents the activity from being destroyed when the orientation changes.  
  
**2. You must set #FullScreen: False**  
  
This is in the main module on Android. This is because the IME library [does not work correctly otherwise](https://www.b4x.com/android/forum/threads/b4xpages-ime_heightchanged-it-does-not-work.123786/post-773351).  
  
**3. Adding a new page.**   
  
You can add a new page just like you normally would. Remove the Initialize and B4XPage\_Created subs. These will be replaced in the code below. Paste the following code into the new page after removing those two subs.  
  

```B4X
#Region PageEvents  
'-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*  
'It is recommended that you not modify the code  
'below under most circumstances.  
'-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*  
Public Sub Initialize  
    Return Me  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
#if not(b4j)  
    LogColor($"B4XPage_Created"$, Colors.Green)  
#end if  
    FirstTime=True  
    Root = Root1  
#if b4a  
    LastOrientationPortrait=(Main.ActivityHeight > Main.ActivityWidth)  
    B4XPage_Resize(Main.ActivityWidth, Main.ActivityHeight)  
#end if  
End Sub  
  
  
Private Sub B4XPage_Resize(Width As Int, Height As Int)  
#if not(b4j)  
    LogColor($"B4XPage_Resize(Width=${Width}, Height=${Height})"$, Colors.Green)  
#end if  
    Dim AlreadyRestored As Boolean  
    If LastOrientationPortrait=(Width>Height) Or Root.Width<>Width Or Root.Height<>Height Or FirstTime Then  
        If Not(FirstTime) Then UI_Save_State  
        UI_Create(Width, Height)  
        If Not(FirstTime) Then  
            UI_Restore_State  
            AlreadyRestored=True  
        End If  
    End If  
    If Not(FirstTime) And Not(AlreadyRestored) Then  
        'save state  
        UI_Save_State  
        'restore state  
        UI_Restore_State  
    End If  
    LastOrientationPortrait=(Height>Width)  
    FirstTime = False  
End Sub  
  
Sub B4XPage_Disappear  
#if not(b4j)  
    LogColor($"B4XPage_Disappear"$, Colors.Green)  
#end if  
    'save state  
    UI_Save_State  
End Sub  
  
#if b4a  
Sub B4XPage_Appear  
    LogColor($"B4XPage_Appear"$, Colors.Yellow)  
    If LastOrientationPortrait=(Main.ActivityWidth > Main.ActivityHeight) Then B4XPage_Resize(Main.ActivityWidth, Main.ActivityHeight)  
End Sub  
#end if  
  
'-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*  
'Feel free to edit the code below.  
'-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*  
#End Region  
  
  
Sub UI_Create(Width As Int, Height As Int)  
#if not(b4j)  
    LogColor($"UI_Create Width=${Width}, Height=${Height}"$, Colors.Magenta)  
#end if  
    Root.Width=Width  
    Root.Height=Height  
    Root.RemoveAllViews  
'You will generally want to keep the 3 lines above and edit below.  
    Root.LoadLayout("Page2")  
End Sub  
  
Sub UI_Save_State  
#if not(b4j)  
    LogColor($"Saving State"$, Colors.Magenta)  
#end if  
    ToSave_Text=B4XFloatTextField1.Text  
End Sub  
  
Sub UI_Restore_State  
#if not(b4j)  
    LogColor($"Restoring State"$, Colors.Magenta)  
#end if  
    B4XFloatTextField1.Text=ToSave_Text  
End Sub
```

  
  
The region PageEvents contains the code that manages changes to orientation and calling the three important subs at the end. You will generally not want to change that region.  
  
Add the following to Class\_Globals. This is used for tracking whether the page is being created for the first time. It also contains LastOrientationPortrait, which is self-explanatory.  
  

```B4X
Private FirstTime As Boolean = True  
Private LastOrientationPortrait As Boolean
```

  
  
**4. UI Events**  
  
The three subs at the end are where you will be working to start. Below that, you can add any other code as you normally would.  
  
UI\_Create - This is where you create your UI. It is best to use this sub for creating your UI, because it will have accurate dimensions on iOS. This sub is called when the page is first created and when you change orientation (or any circumstance where the size is changed – like resizing the window in B4J).  
  
UI\_Save\_State - This is where you will want to save the state of your UI (for example any UI changes that have happened after it was first created). Save these values to global variables.  
  
UI\_Restore\_State - This is where you restore changes to your UI. In the example above, it restores the text to a B4XFloatTextField. That way if the app changes orientation, it can restore any changes that the user has made.  
  
That's it! I have tried to keep it pretty simple, and I think it is simpler than the typical Activity lifecycle on Android. Please let me know if you encounter any issues or have recommendations. I hope you find it useful.