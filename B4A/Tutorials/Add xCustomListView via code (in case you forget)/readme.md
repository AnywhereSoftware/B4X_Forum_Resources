### Add xCustomListView via code (in case you forget) by Mashiane
### 06/17/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/171288/)

Hi Fam  
  
> In B4X, **Custom Views (like xCustomListView) are designed to be added via the Visual Designer**. Calling clv.Initialize(Me, "clv") in code does not automatically initialize the component's internal base view. Consequently, when you immediately call clv.AsView, it returns an uninitialized B4XView object, which triggers the java.lang.RuntimeException: Object should first be initialized (B4XView) when passed into mBase.AddView.

  
Whilst adopting my B4XDaisyList to use the xCustomListView internally I ran into a snag where   
  

```B4X
java.lang.RuntimeException: Object should first be initialized (B4XView)
```

  
  
Kept on being fired and I did not know the root cause. Thanks to NotebookLLM for pointing the actual root cause as xCustomListView.  
  
This below is my code…  
  

```B4X
Private Sub SetupCustomListView  
    clv.Initialize(Me, "clv")  
    clv.AnimationDuration = 0  
    Dim pad As Int = miPadding  
    Dim viewW As Int = Max(1dip, mBase.Width - (pad * 2))  
    Dim viewH As Int = Max(1dip, mBase.Height - (pad * 2))  
    miListWidth = viewW  
    mBase.AddView(clv.AsView, pad, pad, viewW, viewH)  
    #If B4A  
    ApplyScrollFix  
    #End If  
End Sub
```

  
  
This is the corrected code to make the xCustomView to work without a layout…  
  

```B4X
Private Sub SetupCustomListView  
    Dim pad As Int = miPadding  
    Dim viewW As Int = Max(1dip, mBase.Width - (pad * 2))  
    Dim viewH As Int = Max(1dip, mBase.Height - (pad * 2))  
    miListWidth = viewW  
  
    ' 1. Initialize the class  
    clv.Initialize(Me, "clv")  
  
    ' 2. Create the base panel that will house the CustomListView  
    Dim pnlBase As B4XView = xui.CreatePanel("")  
    pnlBase.SetLayoutAnimated(0, 0, 0, viewW, viewH)  
    pnlBase.Color = xui.Color_Transparent  
  
    ' 3. Create a dummy label so CLV can extract default text styling  
    Dim dummyLbl As Label  
    dummyLbl.Initialize("")  
    Dim xDummy As B4XView = dummyLbl  
    xDummy.TextColor = xui.Color_Black  
    xDummy.TextSize = 14  
  
    ' 4. Construct the properties Map expected by DesignerCreateView  
    Dim props As Map  
    props.Initialize  
    props.Put("ListOrientation", "Vertical")  
    props.Put("DividerColor", xui.Color_Transparent) ' DaisyList handles its own dividers  
    props.Put("DividerHeight", 0)  
    props.Put("PressedColor", xui.Color_LightGray)  
    props.Put("InsertAnimationDuration", 0)  
    props.Put("ShowScrollBar", False)  
  
    ' 5. Force the internal view creation  
    clv.DesignerCreateView(pnlBase, dummyLbl, props)  
  
    ' Disable internal animations  
    clv.AnimationDuration = 0  
  
    ' 6. Add the now-initialized base panel to your host view instead of clv.AsView  
    mBase.AddView(pnlBase, pad, pad, viewW, viewH)  
  
    #If B4A  
    ApplyScrollFix  
    #End If  
End Sub
```