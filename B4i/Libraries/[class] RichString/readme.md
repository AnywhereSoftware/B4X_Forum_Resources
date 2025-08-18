### [class] RichString by Erel
### 10/22/2020
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/48573/)

**Edit: don't use this class. Better to use CSBuilder or BCTextEngine.**  
  
![](http://www.b4x.com/basic4android/images/SS-2014-12-24_16.08.56.png)  
  
The RichString class uses NativeObject to create attributed strings. Similar to B4A RichString library.  
  
For example the text above is created with the following code:  

```B4X
Private Sub Page1_Resize(Width As Int, Height As Int)  
   Dim rs As RichString  
   rs.Initialize(Label1.Text)  
   rs.Color(Colors.Red, 0, 4).Color(Colors.Blue, 4, 8).SetFont(Font.CreateNewBold(30), 1, 5)  
   rs.Strikethrough(True, 5, 10)  
   rs.Underline(True, Colors.Blue, 0, 10)  
   rs.SetFont(Font.CreateNewItalic(20), 0, rs.Text.Length-5)  
   rs.SetFont(Font.CreateNewBold(30), 4, 7)  
   rs.BackgroundColor(0xFFC0C000, 5, 20)  
   rs.SetToLabel(Label1)  
End Sub
```

  
  
The range of each attribute is made of two parameters: start index (inclusive) and end index (exclusive).  
  
Note that if the label was added with the designer then the font size will be reset whenever AutoScaleAll is applied. In that case you need to set it again in Page\_Resize event.