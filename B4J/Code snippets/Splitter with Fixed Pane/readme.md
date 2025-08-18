### Splitter with Fixed Pane by Heuristx
### 02/07/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/138246/)

The Java splitter has the nasty tendency of resizing both panels when the form or splitter parent is resized.  
I think it is a better behaviour when we have one fixed panel and one flexible panel, so when you resize the form, one panel keeps its size and only the other one changes.  
Fighting this behaviour by resetting the percentages of the split panel sizes produces some spectacular flicker on the screen while resizing.  
  
It is never a good idea to reinvent the wheel, but after some consideration I decided to simply build a splitter class from standard B4X panes. There are some reasons for it.  
  
- It is simple! B4X makes everything simple.  
- It eliminates the flicker without going into validating/invalidating window regions and all that mess. Resizing becomes smooth.  
- It gives us full control over the appearance of every part of the splitter.  
  
So, here it is. Just four panels with anchors set in the visual designer.  
We can change the splitter orientation and resize response by having a left, top, right or bottom style, meaning that those panels are fixed when the whole form is resized, they keep their size.  
  
This can be switched at runtime, so we can allow the user to pin the size of the panes wherever they want to.  
  
The example class also saves its splitter position in a KeyValueStore and reloads it at initialization time, if its Key string is found in the store.  
  
The "engine" of the whole thing is the resizing process, I found the solution in Erel's CLV drag/drop example. It shows the power of resumable subs, how they make everything easy:  
  

```B4X
Private Sub Sizer_MousePressed (EventData As MouseEvent)  
    If EventData.ClickCount > 1 Then Return  
    Sizing = True  
    Dim StartX As Double = EventData.X  
    Dim StartY As Double = EventData.Y  
    Do While Sizing  
        Wait For(Sizer) Sizer_MouseDragged(EventData As MouseEvent)  
        SetSizer(EventData.X - StartX, EventData.Y - StartY)  
    Loop  
End Sub  
  
Private Sub SetSizer(X As Int, Y As Int)  
    Select FSplitterType  
        Case splLeft  
            Sizer.Left = Max(Min(Sizer.Left + X, panBase.Width - FMinFlexSize), FMinFixedSize)  
            FlexPanel.Left = Sizer.Left + Sizer.Width  
            FlexPanel.Width = Max(FlexPanel.Parent.Width - FlexPanel.Left, FMinFlexSize)  
            FixedPanel.Width = Max(Sizer.Left - FixedPanel.Left, FMinFixedSize)  
        Case splRight  
            Sizer.Left = Max(Min(Sizer.Left + X, panBase.Width - FMinFlexSize), FMinFixedSize)  
            FlexPanel.Left = Sizer.Left + Sizer.Width  
            FlexPanel.Width = FlexPanel.Parent.Width - FlexPanel.Left  
            FixedPanel.Width = Sizer.Left - FixedPanel.Left  
        Case splTop  
            Sizer.Top = Max(Min(Sizer.Top + Y, panBase.Height - FMinFlexSize), FMinFixedSize)  
            FlexPanel.Top = Sizer.Top + Sizer.Height  
            FlexPanel.Height = FlexPanel.Parent.Height - FlexPanel.Top  
            FixedPanel.Height = Sizer.Top - FixedPanel.Top  
        Case Else  
            Sizer.Top = Max(Min(Sizer.Top + Y, panBase.Height - FMinFlexSize), FMinFixedSize)  
            FlexPanel.Top = Sizer.Top + Sizer.Height  
            FlexPanel.Height = FlexPanel.Parent.Height - FlexPanel.Height  
            FixedPanel.Height = Sizer.Top - FixedPanel.Top  
    End Select  
End Sub  
  
Private Sub Sizer_MouseReleased (EventData As MouseEvent)  
    Sizing = False  
    B4XPages.MainPage.KVS.Put($"${OptKey}Pos"$, IIf(Horizontal, Sizer.Left, Sizer.Top))  
End Sub
```

  
  
Seeing how easy LoadLayout and other tools make it to control the UI, it is tempting to build my own Tab control, or a CLV-tree combobox and so on. This little project was so simple, now I split my sides laughing.