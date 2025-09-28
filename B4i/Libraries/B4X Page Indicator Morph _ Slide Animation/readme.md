### B4X Page Indicator Morph | Slide Animation by aliakrami
### 09/26/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/168801/)

[HEADING=2][B4X] PillDotsIndicator — Page Indicator with MORPH & SLIDE styles (B4A/B4i/B4J)[/HEADING]  
  
**PillDotsIndicator** is a lightweight, cross-platform **B4X custom view** for showing page indicators.  
It comes with **two animation styles**:  
  
  

- **MORPH**: The active dot morphs into a pill shape with smooth width and color transition.
- **SLIDE**: A circular cursor smoothly slides between dots.

  
It’s perfect for onboarding screens, ViewPager indicators, or any kind of paginated content.  
  
[HEADING=1]Features[/HEADING]  
  

- 100% **B4X** code (works in **B4A / B4i / B4J**)
- Two animation styles: **MORPH** and **SLIDE**
- Designer Properties support
- Event: **PageChanged (Index As Int)**
- Easy methods: SetProgress, NextPage, PrevPage, etc.
- Runtime color customization

  
[HEADING=1]Designer Properties[/HEADING]  
  

- PageCount (Int) — number of pages (default: 4)
- DotSize (dip) — size of dots (default: 12dip)
- ActiveWidth (dip) — active pill width in MORPH style (default: 32dip)
- Spacing (dip) — spacing between dots (default: 10dip)
- ActiveColor (Color) — active dot color (default: 0xFF3A82F7)
- InactiveColor (Color) — inactive dot color (default: 0xFF3A82F7)
- BgColor (Color) — background color of the view (default: transparent)
- Duration (ms) — animation duration (default: 220ms)
- StartIndex (Int) — start index (default: 0)
- Style (String) — MORPH or SLIDE (default: MORPH)

  
**[SIZE=7]Event[/SIZE]**  
  

```B4X
#Event: PageChanged (Index As Int)
```

  
  
  
  
**[SIZE=6]Public Methods[/SIZE]**  
  

```B4X
Public Sub setPageCount(n As Int)  
Public Sub getPageCount As Int  
Public Sub getCurrentIndex As Int  
Public Sub SetCurrentIndex(i As Int)        ' animated  
Public Sub SetProgress(index As Int)        ' same as SetCurrentIndex  
Public Sub NextPage  
Public Sub PrevPage  
Public Sub SetColors(Active As Int, Inactive As Int)
```

  
  
[HEADING=1]Quick Start[/HEADING]  
  
[HEADING=2]1) Add it in Designer[/HEADING]  
  

1. Add PillDotsIndicator.bas class to your project.
2. In Designer, drop a **CustomView** and set its type to PillDotsIndicator.
3. Configure properties (PageCount, Style, etc).
4. Give it a name (e.g. ind).

  
Works in **B4A, B4i, and B4J**.  
  
  
[HEADING=1]Sample — B4XPages + B4XViewPager[/HEADING]  
  
[HEADING=2]Globals[/HEADING]  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
  
    Private vp As B4XViewPager  
    Private ind As PillDotsIndicator   ' CustomView from Designer  
End Sub
```

  
  
**[SIZE=6]B4XPage\_Created[/SIZE]**  
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")   ' contains vp and ind  
  
    vp.Initialize  
    For i = 0 To 4  
        Dim p As B4XView = xui.CreatePanel("")  
        p.Color = 0xFFEFEFEF  
        vp.AddPage(p, "Page " & i)  
    Next  
  
    ind.setPageCount(vp.PageCount)  
End Sub
```

  
  
**[SIZE=7]Sync ViewPager → Indicator[/SIZE]**  
  

```B4X
Private Sub vp_PageChanged (Position As Int)  
    ind.SetProgress(Position)  
End Sub
```

  
  
**[SIZE=6]Sync Indicator → ViewPager[/SIZE]**  
  

```B4X
Private Sub btnNext_Click  
    ind.NextPage  
    vp.GotoPage(ind.getCurrentIndex, True)  
End Sub  
  
Private Sub btnPrev_Click  
    ind.PrevPage  
    vp.GotoPage(ind.getCurrentIndex, True)  
End Sub
```

  
  
  
**[SIZE=6]Simple Example (no ViewPager)[/SIZE]**  
  

```B4X
Private Sub B4XPage_Appear  
    StartTimer  
End Sub  
  
Private Sub StartTimer  
    Dim t As Timer  
    t.Initialize("t", 1500)  
    t.Enabled = True  
End Sub  
  
Private Sub t_Tick  
    If ind.getCurrentIndex < ind.getPageCount - 1 Then  
        ind.NextPage  
    Else  
        ind.SetCurrentIndex(0)  
    End If  
End Sub
```

  
  
  
**[SIZE=6]Change Colors at Runtime[/SIZE]**  
  

```B4X
ind.SetColors(0xFF000000, 0xFFBDBDBD) ' Active=Black, Inactive=Gray
```

  
  
  
[HEADING=1]Tips[/HEADING]  
  

- For **MORPH**, set ActiveWidth larger than DotSize (e.g. DotSize=12, ActiveWidth=36) for a nicer morph effect.
- Increase Duration (e.g. 260–300ms) if the animation feels too fast.
- The class auto-centers the dots inside its base view. Just anchor/center the CustomView in your layout.

  

---

  
  
[HEADING=1]Version History[/HEADING]  
  

- **v1.0.0**: Initial release with MORPH + SLIDE styles, designer properties, PageChanged event, and core methods.

  
[HEADING=1]License[/HEADING]  
ELCID  
Credit/link back to this thread is appreciated 🙏  
  
  

---

  
  
[HEADING=1]Files[/HEADING]  
  

- PillDotsIndicator.bas (the custom view)
- **Sample Project** (B4XPages + B4XViewPager example)

  
  
**[SIZE=6][/SIZE]**  
![](https://www.b4x.com/android/forum/attachments/167314)