### Smooth Custom BottomSheet with Zero-Jitter Absolute Y Dragging, Easing Filter, and Child Views Pass by GeoT
### 07/07/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171483/)

Hi everyone,  
  
I wanted to share a robust, custom BottomSheet architecture I've been refining in B4A.  
  
The goal was to build a highly interactive sliding panel that mimics top-tier native mobile behaviors: strict boundary locking, bounce-free snapping to predefined indexed positions, an easing filter for elastic smoothness, and—critically—the ability to drag the sheet directly from nested child views (like panels, labels, spinners, edittexts, simulated buttons, imageviews, or bottomsheets) without breaking touch detection or causing visual micro-stutters. The BottomSheet can also be dragged smoothly from its main background panel.  
  
![](https://www.b4x.com/android/forum/attachments/172280) ![](https://www.b4x.com/android/forum/attachments/172281) ![](https://www.b4x.com/android/forum/attachments/172282)  
  
**🚀 Key Features**  

- **Multi-Anchor Snapping System:** The sheet snaps magnetically to predefined vertical coordinate offsets stored in an array (`mPositionsY`), supporting multiple states like fully expanded, half-collapsed, or partially hidden.
- **The "Zero-Jitter" Absolute Y Solution:** Eliminates the classic Android dragging stutter when touching child elements by abandoning local delta variables in favor of a calculated screen-wide fixed absolute coordinate system.
- **40% Easing Filter (Signal Smoothing):** Implements a linear interpolation/easing algorithm ($0.40 \times \text{distance remaining}$) on every touch frame to act as a physical shock absorber against erratic finger input.
- **Smart Gesture Discrimination (Clean Clicks):** Transparently separates intentional drag actions (using a `15dip` threshold) from instant tapping events (`CleanClick`), avoiding accidental button triggers during a swipe up/down.
- **Child Input Pass-Through:** Eliminates the need to declare boilerplate click events on nested layout elements (like `ImageView` or `Label` inside a button wrapper). Gestures fall directly into a singular router method.
- **Simulated Button Integration:** Implemented custom simulated views because native Android buttons consume touch events and natively interfere with the BottomSheet's drag behavior.
- **UIUtils Code Module Integration:** Centralizes the pressed-state management and dynamically handles rounded corners on target `B4XView` elements across touch phases.
- The example and the class automatically hide the keyboard when needed
- **B4XPages Native Architecture:** Designed specifically around the modern B4XPages framework. This ensures that the BottomSheet's internal physical states, current index tracking, and event callbacks remain completely immune to Android's chaotic Activity lifecycle crashes and screen rotation resets.

  
**🛠️ The Architectural Mechanics**  
  
[INDENT]**1. Fixing the Touch Jitter (Absolute Y Method)**[/INDENT]  
[INDENT]Dragging a panel from an internal child view normally causes violent stuttering. This happens because local coordinates ($Y$) update relative to the parent container while it moves, creating an infinite calculation loop.[/INDENT]  
[INDENT][/INDENT]  
[INDENT]The fix? Calculate a fixed, screen-relative \*\*Absolute Y\*\* coordinate on every frame:[/INDENT]  
[INDENT][/INDENT]  
[INDENT]

```B4X
Dim AbsoluteY As Float = BottomSheet1.Top + viewTouched.Top + Y
```

[/INDENT]  
[INDENT][/INDENT]  
[INDENT]By routing this stable value to the processing class, the movement math becomes completely independent of the panel's instant velocity, resulting in buttery-smooth dragging.[/INDENT]  
  
[INDENT]**2. The Shared Touch-Processing Interface**[/INDENT]  
[INDENT]To enable any view within the layout to act as a valid anchor point for dragging, a single event name (ViewsSheet) is linked to specific interactive views in the UI Designer. When touched, these invoke the main engine:[/INDENT]  
[INDENT][/INDENT]  

```B4X
' Inside B4XMainPage - ViewsSheet_Touch  
Dim CleanClick As Boolean = BottomSheet1.ProcessSharedTouch(viewTouched, Action, AbsoluteY)  
  
If CleanClick Then  
    Select viewTouched.Tag  
        Case "pnlSimulatedButton":     Log("Button Action Triggered")  
        Case "pnlOverlapEdtAddress":   ExpandAndFocusKeyboard  
        ' … Rest of your clean click routing  
    End Select  
End If
```

  
  
[INDENT]**3. Smooth State Management & Easing**[/INDENT]  
[INDENT]On ACTION\_DOWN, the class locks the starting position (mInitialIndex = mCurrentIndex). During movement, instead of jumping instantly to the finger's position—which causes harsh movements—it dampens the velocity using a 40% Easing Filter combined with safe boundary clamping:[/INDENT]  
[INDENT][/INDENT]  

```B4X
' Inside the custom BottomSheet Class (ACTION_MOVE)  
Dim deltaY As Float = AbsoluteY - mLastY  
mLastY = AbsoluteY  
  
Dim targetTop As Int = mSheet.Top + deltaY  
  
' Boundary Clamping Guard  
If targetTop < expandedTop Then targetTop = expandedTop  
If targetTop > lowestVisibleTop Then targetTop = lowestVisibleTop  
  
' Easing Filter (Dampener)  
Dim smoothedTop As Int = mSheet.Top + 0.40 * (targetTop - mSheet.Top)  
mSheet.Top = smoothedTop
```

  
[INDENT][/INDENT]  
[INDENT]When the user releases their finger (ACTION\_UP), SnapToNearest evaluates the total travel distance and magnetically glides the sheet into its final anchor station.[/INDENT]  
  
**🎨 UI & State Interaction Showcase**  
[INDENT]- Some simulated buttons manipulate the alpha channel when emulating state changes within the touch processing flow. Others render borders and color fills natively and dynamically using B4XView.SetColorAndBorder.[/INDENT]  
[INDENT][/INDENT]  
[INDENT]- Some views have a transparent base panel, and others have a transparent overlay panel.[/INDENT]  
[INDENT][/INDENT]  
[INDENT]- For advanced views like the SwiftButton (from the XUI Views library), we use JavaObject to bypass the default click interceptors, allowing the button to reflect its pressed state visually while seamlessly participating in the BottomSheet's dragging physics:[/INDENT]  
[INDENT][/INDENT]  

```B4X
' Inside the ViewsSheet_Touch event in B4XMainPage  
Select Action  
    Case 0 ' ACTION_DOWN:  
        joBtn.SetField("_pressed", True) ' Activate the internal pressed state  
        joBtn.RunMethod("_draw", Null)   ' Request a native redraw  
              
    Case 2 ' ACTION_MOVE:  
        ' We evaluate the threshold using the absolute, unperturbed coordinate.  
        If IsDragging = False And Abs(AbsoluteY - StartY) > 15dip Then  
            joBtn.SetField("_pressed", False) ' We cancel the button state  
            joBtn.RunMethod("_draw", Null)    ' We restore the original appearance  
        End If  
          
    Case 1, 3 ' ACTION_UP or ACTION_CANCEL:  
        joBtn.SetField("_pressed", False) ' Clear the pressed state  
        joBtn.RunMethod("_draw", Null)    ' We restore the original appearance  
End Select
```

  
  
  
**⚠️ Notes & Compatibility**  
  
[INDENT]- **Native Buttons:**[/INDENT]  
[INDENT]This architecture does not work with standard native buttons because they intercept and consume touch gestures before they can reach the dragging system.[/INDENT]  
[INDENT][/INDENT]  
[INDENT]- **View Interoperability:**[/INDENT]  
[INDENT]Apart from the views shown in the example, I haven't tested any other native views or views from the XUI Views library —with the exception of SwiftButton— to determine whether it is possible to initiate a BottomSheet drag from them while simultaneously detecting a click or touch on that same view. After all, one action shouldn't interfere with the other.[/INDENT]  
[INDENT][/INDENT]  
[INDENT]- Most view events are logged rather than displayed on screen using toastmessages.[/INDENT]  
[INDENT][/INDENT]  
[INDENT]- Developed with AI assistance.[/INDENT]