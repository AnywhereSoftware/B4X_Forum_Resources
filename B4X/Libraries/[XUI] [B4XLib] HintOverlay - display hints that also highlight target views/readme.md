###  [XUI] [B4XLib] HintOverlay - display hints that also highlight target views by Segga
### 04/26/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/139955/)

**Highlight B4XViews and display your text captions with a connecting line.**  
  
For use in B4A, B4J, B4i.  
Copy b4xlib file to: *\B4X Additional Libraries\B4X*.  
  
Custom styling options:  

- **BackgroundAlpha** (transparency of the hint screen overlay)
- **CaptionColor** (base color of the caption box)
- **TextColor**
- **TextSize**
- **OutlineColor** (includes; caption outline, connecting line and target highlight color)
- **HighlightTargetView** (display or hide the target outline)
- **ClearTargetView** (cuts-out the target view through the overlay tint)
- **MaxDisplayTime** (maximum time in milliseconds that hints are displayed if user does not tap screen – Default value is 0 (disabled))

Version 1.20  
- Added MaxDisplayTime property, which automatically moves on to the next hint when the user has not tapped the screen within the set amount of time (milliseconds).  
  
Version 1.10  
- Added ClearTargetView property, which exposes the target view through the tint when set to True (many thanks to [USER=75340]@Blueforcer[/USER] for the great idea and coding modification)  
- The Show method now supports Wait For - very useful if you need to change styling properties between hints.  
  
Version 1.00  
- Release  
  
Hints are added to a queue using **Show**(myB4XView, "My text"), and the hint overlay is removed after all hints in the current queue have been viewed.  
  

```B4X
Sub Class_Globals  
    Private Hints As HintOverlay  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Hints.Initialize(Root)  
End Sub  
  
Private Sub B4XPage_Resize (Width As Int, Height As Int)  
    Hints.Base_Resize(Width,Height)  
End Sub  
  
Private Sub ShowHints  
'Set HintOverlay style (where required)  
    Hints.BackgroundAlpha=80  
    Hints.CaptionColor=xui.Color_ARGB(120,0,0,0)  
    Hints.TextColor=xui.Color_White  
    Hints.OutlineColor=xui.Color_Red  
  
'Call Hints.Show(myB4XView, "My text”)  
    Hints.Show(Label1,"This is a label”)  
    Hints.Show(Button1,"This is a button”)  
End Sub
```