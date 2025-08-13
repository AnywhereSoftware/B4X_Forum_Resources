### [B4XTurtle]Herd of Turtles by William Lancee
### 02/07/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/159116/)

I needed multiple turtles on a screen, moving independently.  
  
[Off like a Herd of Turtles](https://idioms.thefreedictionary.com/off+like+a+herd+of+turtles)  
  
  
![](https://www.b4x.com/android/forum/attachments/150504)  
  

```B4X
Sub Globals  
    Private xui As XUI  
    Private Turtle As B4XTurtle  
  
    Private trackLoading As Int  
    Private nTurtles As Int = 3  
  
    Private frames(nTurtles) As B4XView  
    Private Turtles(nTurtles) As B4XTurtle  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Dim w As Int = Activity.Width  
    Dim h As Int = Activity.Height  
    Dim xOffset As Int = 0  
    For i = 0 To nTurtles - 1  
        frames(i) = xui.CreatePanel("")  
        Activity.AddView(frames(i), xOffset, 0, w, h)  
        frames(i).LoadLayout("Main")  
        Turtles(i) = Turtle  
    Next  
End Sub  
  
Sub Turtle_Start  
    If trackLoading = nTurtles - 1 Then        'only do this when loading is finished  
        Sleep(2000)  
        Dim vertical As Int = 200  
        For i = 0 To nTurtles - 1  
            Dim thisTurtle As B4XTurtle = Turtles(i)  
            thisTurtle.MoveTo(200, vertical)  
            vertical = vertical + 100  
        Next  
    End If  
    trackLoading = trackLoading + 1  
End Sub
```