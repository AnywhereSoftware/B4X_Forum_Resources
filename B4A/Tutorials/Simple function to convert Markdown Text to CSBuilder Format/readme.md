### Simple function to convert Markdown Text to CSBuilder Format by fredo
### 07/24/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/162246/)

This simple function converts Markdown-formatted text so that it can be used as CSBuilder.  
  
This is particularly useful if, for example, you have created a text in MS Word with **bold** and *italic* formatting to present it in an app in formatted form.  
  
You can then convert des MS Word file to Markdown using an online converter (e.g., <https://word2md.com/>) and use the result as simple txt in the application.   
  
The text is converted using the "Sub ProcessMarkdownToCSBuilder(…)" function.   
[SPOILER="The code"]  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
      
    Dim markdownText As String = $"This is a **bold** Text,   
    an *italic* Text   
    and a [Link1](http://example1.com)   
    and a [Link2](http://example2.com)."$  
      
    Dim cs As CSBuilder = ProcessMarkdownToCSBuilder(markdownText)  
    Label1.Text = cs  
    cs.EnableClickEvents(Label1)  
      
End Sub  
  
Sub ProcessMarkdownToCSBuilder(markdown As String) As CSBuilder  
    Dim cs As CSBuilder  
    cs.Initialize  
    Dim boldPattern As String = "\*\*(.*?)\*\*" ' Regex for **Text**  
    Dim italicPattern As String = "\*(.*?)\*" ' Regex for *Text*  
    Dim urlPattern As String = "\[(.*?)\]\((.*?)\)" ' Regex for [Text](URL)  
    Dim combinedPattern As String = boldPattern & "|" & italicPattern & "|" & urlPattern  
    Dim matcher As Matcher = Regex.Matcher(combinedPattern, markdown)  
    Dim lastEnd As Int = 0  
    Do While matcher.Find  
        cs.Append(markdown.SubString2(lastEnd, matcher.GetStart(0)))  
        If matcher.Group(1) <> Null Then  
            cs.Typeface(Typeface.DEFAULT_BOLD).Append(matcher.Group(1)).PopAll  
        Else If matcher.Group(2) <> Null Then  
            cs.Typeface(Typeface.CreateNew(Typeface.DEFAULT,Typeface.STYLE_ITALIC)).Append(matcher.Group(2)).PopAll  
        Else If matcher.Group(3) <> Null And matcher.Group(4) <> Null Then  
            cs.Color(Colors.Blue).Clickable("cs", matcher.Group(4)).Append(matcher.Group(3)).PopAll  
        End If  
        lastEnd = matcher.GetEnd(0)  
    Loop  
    cs.Append(markdown.SubString(lastEnd))  
    Return cs  
End Sub  
  
Sub cs_Click(cstag As Object)  
    Log($"Clicked on: ${cstag}"$)  
    Label2.Text = Label2.Text  & CRLF & cstag  
End Sub
```

  
[/SPOILER]  
  
The example project also demonstrates the use of clickable URLs.  
![](https://www.b4x.com/android/forum/attachments/155640)  
  
The three shown Markdown patterns are just examples. In principle, you can implement any pattern that is common to both CSBuilder and Markdown.  
  
*[SIZE=3]I know there are existing libraries for this, but this example also demonstrates how to use regex for such tasks.[/SIZE]*