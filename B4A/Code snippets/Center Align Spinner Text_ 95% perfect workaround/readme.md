### Center Align Spinner Text: 95% perfect workaround by vascofire
### 01/02/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/126113/)

So far it's known that we can't center align a spinner text.  
What I'm sharing now is a workaround that doesn't a perfect alignment but at least minimises the problem.  
The trick is changing the spinner left padding based on the item(text) width.  
The text is measured using Canvas.  
X is the item text width.  
Left is the left padding. The number 10 in the formula was used to adjust a little more the padding.  
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    
    Spinner1.AddAll(Array As String("Item_1","Long Item_2","Very Long Item_3"))  
    Spinner1.Color = Colors.DarkGray  
    
    Measure_And_SetPadding(Spinner1.GetItem(0)) 'Align the first item (case it will always be the first to be shown)  
End Sub  
  
Sub Measure_And_SetPadding(SpinnerItem As String)  
    Dim C As Canvas  
    C.Initialize(Root) 'Instead of Root, use Activity if you're not using B4X Pages  
    Dim X As Int  
        X = C.MeasureStringWidth(SpinnerItem, Typeface.DEFAULT, 16)  
        Dim Left As Int = ((Spinner1.Width - X)/2)-10  
        Spinner1.Padding = Array As Int(Left,0,0,0)  
End Sub  
  
Sub Spinner1_ItemClick (Position As Int, Value As Object)  
    Measure_And_SetPadding(Spinner1.GetItem(Position)) 'Reset the padding whenever a new item is choosen.  
End Sub
```