### CSBuilder - AttributedStrings builder by Erel
### 01/16/2026
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/79153/)

AttributedStrings are strings with additional styling information.  
CSBuilder is a new type added in B4i v4.00 which helps with creating such strings. It is an alternative to iRichString class: <https://www.b4x.com/android/forum/threads/48573/#content>  
  
Note that unlike in B4A, where CharSequence type can be a string or a CharSequence created with CSBuilder, in B4i a String cannot be used as an AttributedString (and vice versa).  
  
Examples of objects that support attributed strings:  
- Label / TextField / TextView.AttributedText  
- TableCell.Text / DetailText  
- Picker items  
  

```B4X
Dim cs As CSBuilder  
Label1.AttributedText = cs.Initialize.Color(Colors.Red).Append("Hello World!").PopAll
```

  
![](https://www.b4x.com/basic4android/images/SS-2017-05-04_17.03.21.png)  
  
Almost all methods of CSBuilder return the object itself. This allows us to chain the method calls.  
Text is always appended with the Append method.  
There are various attributes that can be set. Setting an attribute marks the beginning of a style span.  
Calling Pop ends the last span that was added (and not ended yet).  
Calling PopAll ends all open spans. It is convenient to always call PopAll at the end to ensure that all spans are closed.  
  

```B4X
'example of explicitly popping an attribute:  
Label1.AttributedText = cs.Initialize.Color(Colors.Red).Append("Hello ").Pop.Append("World!").PopAll
```

  
  
![](https://www.b4x.com/basic4android/images/SS-2017-05-04_17.04.13.png)  
  

```B4X
'It doesn't matter whether the methods are chained or split into several lines:  
Dim cs As CSBuilder  
cs.Initialize.Color(Colors.Red).Append("Hello ")  
cs.Font(Font.DEFAULT_BOLD).Color(Colors.Blue).Append("Colorful ").Pop.Pop 'two pops: the first removes the green color and the second removes the bold style  
cs.Append("World!").PopAll  
Label1.AttributedText = cs
```

  
  
![](https://www.b4x.com/basic4android/images/SS-2017-05-04_17.06.20.png)  
  
**Fonts**  
  
By default all layouts call AutoScaleAll in the designer script. This causes the view's Font to be reset when the parent is resized. This will override the font styling set with CSBuilder.  
If you want to change the font with CSBuilder then you have two options:  
- Remove the AutoScaleAll call from the designer script.  
- Or set the AttributedText property in the parent's Resize event.  
  
**FontAwesome / Material Icons**  
  

```B4X
Dim cs As CSBuilder  
cs.Initialize.Alignment("ALIGN_CENTER")  
cs.Append("Apple: ").Font(Font.CreateFontAwesome(20)).Color(0xFF777777).Append(Chr(0xF179)).Pop.Pop.Append(CRLF)  
cs.Append("Android: ").Font(Font.CreateFontAwesome(20)).Color(0xFF057916).Append(Chr(0xF17B)).Pop.Pop  
cs.PopAll  
Label1.AttributedText = cs
```

  
  
![](https://www.b4x.com/basic4android/images/SS-2017-05-04_17.15.18.png)  
  
**Page.TitleView**  
  

```B4X
Dim cs As CSBuilder  
Dim lbl As Label  
lbl.Initialize("")  
lbl.SetLayoutAnimated(0, 1, 0, 0, 100, 50)  
cs.Initialize.Alignment("ALIGN_CENTER").Color(Colors.Red).Append("Title ").VerticalAlign(5).Font(Font.CreateMaterialIcons(25))  
cs.Append(Chr(0xE859)).PopAll  
lbl.AttributedText = cs  
Page1.TitleView = lbl
```

  
  
![](https://www.b4x.com/basic4android/images/SS-2017-05-04_17.18.49.png)  
  
**TableView**  
  

```B4X
Dim cs As CSBuilder  
For i = 1 To 100  
   Dim tc As TableCell = TableView1.AddSingleLine("")  
   tc.Text = cs.Initialize.Color(Rnd(0xFF000000, -1)).Alignment("ALIGN_CENTER").Append($"Item #${i}"$).PopAll  
Next
```

  
![](https://www.b4x.com/basic4android/images/SS-2017-05-04_17.21.13.png)  
  
**Clickable links**  
  
You can create clickable links with TextView. TextView.Editable must be set to False.  

```B4X
Dim cs As CSBuilder  
TextView1.Editable = False  
cs.Initialize.Font(Font.CreateNew(25)).Append("Some ").Link("somevalue").Append("words").Pop  
cs.Append(" are ").Link("anothervalue").Append("clickable").PopAll  
TextView1.AttributedText = cs  
  
Sub TextView1_LinkClick (URL As String)  
   Log(URL)  
End Sub
```

  
  
![](https://www.b4x.com/basic4android/images/SS-2017-05-04_17.27.32.png)  
  
Note that you should use StringUtils.EncodeUrl to escape the link value if it contains a space or any other value not allowed by URLs.  
  
**Buttons**  
  
You can use attributed strings in buttons with the ButtonSetAttributedText sub.  

```B4X
'example  
Dim cs As CSBuilder  
ButtonSetAttributedText(Button1, _  
   cs.Initialize.Color(Colors.Red).Append("Click ").Font(Font.CreateNewBold(30)).Append("Me!!!").PopAll, _  
   cs.Initialize.Color(Colors.Gray).Append("Click ").Font(Font.CreateNewBold(30)).Append("Me!!!").PopAll, _  
   cs.Initialize.Append("disabled"))  
  
Sub ButtonSetAttributedText(btn As Button, NormalText As AttributedString, HighlightedText As AttributedString, _  
     DisabledText As AttributedString)  
   Dim no As NativeObject = btn  
   no.RunMethod("setAttributedTitle:forState:", Array(NormalText, 0))  
   no.RunMethod("setAttributedTitle:forState:", Array(HighlightedText, 1))  
   no.RunMethod("setAttributedTitle:forState:", Array(DisabledText, 2))  
End Sub
```

  
  
![](https://www.b4x.com/basic4android/images/SS-2017-05-04_17.51.21.png)