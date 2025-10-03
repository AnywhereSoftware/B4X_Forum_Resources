### SwipeCard (B4X Class) — Smooth Drag with Filtered Rotation by aliakrami
### 09/29/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/168852/)

[HEADING=2]SwipeCard (B4X Class) — Smooth Drag with Filtered Rotation[/HEADING]  
  
**Email:** [EMAIL]Aliakrami13751@gmail.com[/EMAIL]  
  
  
**Platforms:** B4A / B4i / B4J (B4X)  
**Version:** 1.0.0  
  
  
A lightweight, cross-platform swipeable card stack with **buttery-smooth dragging** and **low-pass–filtered rotation**. Perfect for Tinder-like UIs, card pickers, or stacked previews. Uses pure B4XView APIs and works in the Designer with helpful properties.  
  
  
  
![](https://www.b4x.com/android/forum/attachments/167449)  
  
  
  
[HEADING=1]Features[/HEADING]  
  

- Smooth horizontal drag with throttled touch handling
- Low-pass filtering for position & rotation (natural feel)
- Configurable fling & snap durations
- Stack layout with per-card offsets (X/Y) and rounded corners
- Works with **Layouts** or existing **Panels**
- Simple event model: LeftSwipe, RightSwipe, CenterRelease
- Runtime setters for thresholds, durations, and stack size

  
[HEADING=1]Designer Properties[/HEADING]  
  
[TABLE]  
[TR]  
[TH]Property (Key)[/TH]  
[TH]Type[/TH]  
[TH]Default[/TH]  
[TH]Description[/TH]  
[/TR]  
[TR]  
[TD]ThresholdPct[/TD]  
[TD]Float[/TD]  
[TD]0.25[/TD]  
[TD]Horizontal fraction of width required to trigger a swipe (clamped 0.05–0.9).[/TD]  
[/TR]  
[TR]  
[TD]SnapDuration[/TD]  
[TD]Int[/TD]  
[TD]220[/TD]  
[TD]Milliseconds to animate back to center when not swiped.[/TD]  
[/TR]  
[TR]  
[TD]FlingDuration[/TD]  
[TD]Int[/TD]  
[TD]180[/TD]  
[TD]Milliseconds to animate off-screen when swiped.[/TD]  
[/TR]  
[TR]  
[TD]StackMax[/TD]  
[TD]Int[/TD]  
[TD]3[/TD]  
[TD]Max number of visible cards in the stack.[/TD]  
[/TR]  
[TR]  
[TD]StackOffsetX[/TD]  
[TD]Int (dip)[/TD]  
[TD]3[/TD]  
[TD]Horizontal offset between stacked cards.[/TD]  
[/TR]  
[TR]  
[TD]StackOffsetY[/TD]  
[TD]Int (dip)[/TD]  
[TD]6[/TD]  
[TD]Vertical offset between stacked cards.[/TD]  
[/TR]  
[TR]  
[TD]CardCorner[/TD]  
[TD]Int (dip)[/TD]  
[TD]10[/TD]  
[TD]Corner radius for each card panel.[/TD]  
[/TR]  
[TR]  
[TD]CardBG[/TD]  
[TD]Color[/TD]  
[TD]0xFFFFFFFF[/TD]  
[TD]Card background color.[/TD]  
[/TR]  
[/TABLE]  
  
  
  
  
[HEADING=1]Public API[/HEADING]  
  
[HEADING=2]Adding Items[/HEADING]  
  

```B4X
' Add a layout file as a card (the layout fills the card)  
SwipeCard1.AddLayout("CardProduct", "prod-123")  
  
' Wrap an existing Panel (will be moved into the card)  
SwipeCard1.AddPanel(SomePanel, "custom-01")
```

  
  
**[SIZE=6]Stack / Threshold / Durations[/SIZE]**  
  

```B4X
SwipeCard1.SetStack(3, 4dip, 8dip)      ' maxVisible, dx, dy  
SwipeCard1.SetThresholdPct(0.30)        ' 30% of width  
SwipeCard1.SetDurations(220, 180)       ' snapMs, flingMs
```

  
  
**[SIZE=6]Query / Remove / Clear[/SIZE]**  
  

```B4X
Log(SwipeCard1.Count)                   ' total items  
Log(SwipeCard1.CurrentItemId)           ' id of the top card (or "")  
Dim removed As Boolean = SwipeCard1.RemoveById("prod-123")  
SwipeCard1.Clear                         ' removes all cards
```

  
  
[HEADING=1]Events[/HEADING]  
  
The class raises up to three events (all with **one String parameter**: the card Id):  
  
  

- SwipeCard\_LeftSwipe (Id As String)
- SwipeCard\_RightSwipe (Id As String)
- SwipeCard\_CenterRelease (Id As String)

  
**Example:**  
  

```B4X
Private Sub SwipeCard1_LeftSwipe (Id As String)  
    Log($"Left → ${Id}"$)  
    ' TODO: Dislike, skip, etc.  
End Sub  
  
Private Sub SwipeCard1_RightSwipe (Id As String)  
    Log($"Right → ${Id}"$)  
    ' TODO: Like, approve, etc.  
End Sub  
  
Private Sub SwipeCard1_CenterRelease (Id As String)  
    Log($"Release (center) → ${Id}"$)  
    ' Optional: snap-back finished  
End Sub
```

  
  
  
[HEADING=1]Quick Start (B4XPages)[/HEADING]  
  

1. **Add the class file** SwipeCard.bas to your project.
2. In **B4XPages** Main Page (B4XMainPage):

  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private Swipe As SwipeCard  
End Sub  
  
Public Sub Initialize As Object  
    Return Me  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  ' Contains a Panel placeholder: pnlHost  
    ' Or build in code:  
    Swipe.Initialize(Me, "SwipeCard")  
    Root.AddView(Swipe.mBase, 0, 0, Root.Width, Root.Height)  
  
    ' Add cards  
    For i = 1 To 5  
        Swipe.AddLayout("CardItem", $"item-${i}"$)  
    Next  
  
    ' Optional tuning  
    Swipe.SetStack(3, 4dip, 8dip)  
    Swipe.SetThresholdPct(0.28)  
    Swipe.SetDurations(200, 170)  
End Sub  
  
Private Sub Root_Resize (Width As Double, Height As Double)  
    If Swipe.IsInitialized Then Swipe.mBase.SetLayoutAnimated(0, 0, 0, Width, Height)  
End Sub
```

  
  
**CardItem.bal tip:** Design to fill parent. The class ensures the child view stretches to card bounds.  
  
  

---

  
  
[HEADING=1]Usage Patterns[/HEADING]  
  
[HEADING=2]1) Dynamic Data (e.g., Products, Profiles)[/HEADING]  
  

```B4X
For Each rec As Map In DataList  
    ' Load same layout for each; bind labels/images inside that layout  
    Swipe.AddLayout("CardProfile", rec.Get("id"))  
Next
```

  
  
**[SIZE=6]After AddLayout, you can access the child view via:[/SIZE]**  
  

```B4X
' Inside the class, child is Panel.GetView(0). Outside, prefer to bind in layout load events.
```

  
  
**[SIZE=6]2) Removing / Skipping Specific Cards[/SIZE]**  
  
  
  

```B4X
If Swipe.RemoveById("custom-01") = False Then Log("Id not found!")
```

  
  
  
[HEADING=2]3) Programmatic “Like/Dislike”[/HEADING]  
  
This class focuses on **gesture-driven** swipes. If you want programmatic swipe, you can either:  
  
  

- Trigger the animation by manually setting Panel.Left and calling the internal release logic (extend the class to expose a SwipeLeft/SwipeRight method), **or**
- Simulate user flow by removing the top card and calling UpdateStack (simpler but no fling animation).

  
**Example extension (inside class):**  
  

```B4X
' Public method (optional): fling top programmatically to the right  
Public Sub FlingRight  
    If Items.Size = 0 Or CurrentIndex > Items.Size - 1 Or isAnimating Then Return  
    Dim top As TItem = Items.Get(CurrentIndex)  
    isAnimating = True  
    top.Panel.SetLayoutAnimated(FlingDuration, mBase.Width + 50dip, top.Panel.Top, top.Panel.Width, top.Panel.Height)  
    Sleep(FlingDuration)  
    isAnimating = False  
    RaiseEvent("RightSwipe", top.Id)  
    top.Panel.Visible = False  
    top.Panel.RemoveViewFromParent  
    Items.RemoveAt(CurrentIndex)  
    UpdateStack  
End Sub
```

  
  
[HEADING=1]Performance Notes[/HEADING]  
  

- **Images:** Prefer pre-scaled images sized close to card bounds (avoid huge bitmaps on mobile).
- **Animations:** Current defaults (FlingDuration=180, SnapDuration=220) feel snappy. Increase slightly on older devices.
- **Touch throttling:** throttleMs=8 reduces event flood while maintaining smoothness.
- **Rotation cap:** MaxRotation=12 degrees max; adjust if you want flatter/more dramatic tilt.
- **B4A Hardware Acceleration:** Usually on by default—keep it enabled for smoother animation.

  

---

  
  
[HEADING=1]Compatibility[/HEADING]  
  

- **B4A:** Android 5.0+ recommended
- **B4i:** iOS 12+ recommended
- **B4J:** Works in principle; touch handling depends on your setup (mouse drag maps fine)

  

---

  
  
[HEADING=1]Troubleshooting[/HEADING]  
  
**Card doesn’t fill the container**  
Ensure the SwipeCard’s mBase is sized to its parent (use Base\_Resize or set anchors in Designer). Your child layout should be “match parent”.  
  
  
**No events firing**  
Check that your subs match the event names:  
<EventName>\_LeftSwipe, <EventName>\_RightSwipe, <EventName>\_CenterRelease.  
  
  
**Laggy drag**  
  
  

- Avoid heavy work during Touch MOVE.
- Reduce image sizes or complex nested views in card layouts.
- Slightly increase throttleMs to ~10–12.

  
**I need vertical swipes**  
Current version supports **horizontal** swipes. For vertical, fork and adapt the drag axis (use Y instead of Left, and rotate around X/Z as desired).  
  
  

---

  
  
[HEADING=1]Public Methods (Summary)[/HEADING]  
  

- AddLayout(LayoutFile As String, ItemId As String)
- AddPanel(PanelToWrap As B4XView, ItemId As String)
- RemoveById(Id As String) As Boolean
- Clear
- Count As Int
- CurrentItemId As String
- SetThresholdPct(p As Float)
- SetDurations(snapMs As Int, flingMs As Int)
- SetStack(maxVisible As Int, dx As Int, dy As Int)

  
Events:  
<EventName>\_LeftSwipe (Id As String)  
<EventName>\_RightSwipe (Id As String)  
<EventName>\_CenterRelease (Id As String)  
  
  

---

  
  
[HEADING=1]Minimal Demo (Layout + Code)[/HEADING]  
  
**Designer:**  
  
  

- Page layout with a placeholder Panel pnlHost.
- Add the **SwipeCard** CustomView or add in code.

  
**Code:**  
  
  

```B4X
' In MainPage  
Private Swipe As SwipeCard  
  
Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Swipe.Initialize(Me, "SwipeCard")  
    Root.AddView(Swipe.mBase, 0, 0, Root.Width, Root.Height)  
  
    For i = 1 To 4  
        Swipe.AddLayout("CardSimple", $"id-${i}"$)  
    Next  
End Sub  
  
Sub SwipeCard_RightSwipe (Id As String)  
    Log($"✅ Liked: ${Id}"$)  
End Sub  
  
Sub SwipeCard_LeftSwipe (Id As String)  
    Log($"❌ Disliked: ${Id}"$)  
End Sub  
  
Sub SwipeCard_CenterRelease (Id As String)  
    Log($"↩️ Returned: ${Id}"$)  
End Sub
```

  
  
[HEADING=1]Changelog[/HEADING]  
  
**1.0.0**  
  
  

- Initial public release
- Smooth LPF drag/rotation
- Stack offsets + rounded cards
- Designer + runtime configuration

  
  
  
  
  

---

  
  
[HEADING=1]Support / Contact[/HEADING]  
  
Questions, issues, or feature requests:  
**Email:** [EMAIL]Aliakrami13751@gmail.com[/EMAIL]  
  
**💖 Donate:**  
  
TRX: TZ9TsAv8R5KVrX1eNYRKZrAMUEiWF15fAP  
BSC/ETH/POL: 0xF998991c13657aC9F6191b15aB8E56Bf531F8C2C  
BTC: bc1q04en95hd5yx8du4c5saaj80pw6rhye7dgy2v75  
SOL: 93uvax9FVNb12qz6Bt9zVGy6hq3A2U9WTvmTvqsHWbRX