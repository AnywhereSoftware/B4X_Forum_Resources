### "Stick Header" CLV Demo by Mark Stuart
### 11/01/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/169193/)

A demonstration of using a "Stick Header" (Floating Title)…  
  
With Erel's help [HERE](https://www.b4x.com/android/forum/threads/xui-customlistview-with-floating-titles.87935/), I was able to create my version of a "floating title", as Erel has coined it.  
  
If you use ChatGPT, it names it as a "sticky header". Either naming convention, it pretty much works the same.  
Except I've trimmed it down to a simpler version with less Views, making it easier to implement into your project.  
  
Screen shots of the CustomListView with the Sticky Header are attached.  
  
It involves just one extra Label view that is placed on top of the CLV, at the very top of it.  
The only code that triggers the Sticky Header label to get its next value is this:  
  

```B4X
Sub clv_ScrollChanged(Offset As Int)  
    Dim TopIndex As Int = CLV.FindIndexFromOffset(Offset)  
    LabelFloater.Text = CLV.GetValue(TopIndex)  
End Sub
```

  
And of course what the CLV receives as its **Value As Object** when creating each type of CLV row.  
That's defined in the loading of the CLV. See the attached app to see where that is set…  

```B4X
CLV.Add(p,title)
```

  

```B4X
CLV.AddTextItem(name,title)
```

  
Notice the title is being added as the Object. This is retrieved when scrolling the CLV.  
And with the scrolling, there is no delay at all, even on an older Samsung tablet, model SM-T380.  
  
I'm working on another version of the Sticky Header, where there will be 2 headers.  
In this case, a header for the Year and a header for the Month, where the Year is above the month.  
Will update the Forum in a later date for that one.  
  
Enjoy,  
Mark Stuart