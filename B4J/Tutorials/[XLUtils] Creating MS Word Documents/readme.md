### [XLUtils] Creating MS Word Documents by Erel
### 06/21/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/131732/)

![](https://www.b4x.com/android/forum/attachments/115104)  
  
[XLUtils v2.00](https://www.b4x.com/android/forum/threads/129969/#content) adds support for creating MS Word documents, and converting Word documents to PDF.  
It is done in a similar way to BCTextEngine, using custom BBCode. This works very nicely with B4X smart strings feature.  
  
Full example:  

```B4X
Dim wd As WordUtils  
wd.Initialize  
Dim doc As WordDocument = wd.CreateDocument  
doc.Append($"[p]Word document with two lines.  
This is the second line.[/p]"$)  
Dim f As String = doc.SaveAs(File.DirApp, "1.docx", True)  
Wait For (wd.OpenWord(f)) Complete (Success As Boolean)
```

  
  
wd.OpenWord and wd.PowerShellConvertToPdf are Windows only methods and depend on MS Word being installed. All other methods are based on jPOI (Apache POI) and do not depend on anything else.  
  
With a few exceptions, the document is made of paragraphs ([plain][p][/plain]) with rich text.  
Text outside of the paragraphs is ignored.  
The rich text tags (case insensitive):  
**b** - bold  
**u** - underline. It supports the following optional attributes: *color* and *pattern*. Pattern should be one of the following values: <https://poi.apache.org/apidocs/4.0/org/apache/poi/xwpf/usermodel/UnderlinePatterns.html>  
See the attached example.  
**embossed** - text becomes embossed.  
**shadow** - shadow is added to the text.  
**color** - text color. Can be one of the following color names (case insensitive): Black, Blue, Cyan, Green, Magenta, Red, Yellow, White, DarkBlue, DarkCyan, DarkGreen, DarkMagenta, DarkRed, DarkYellow, DarkGray and Gray.  
Or: a hex value - 0xff00ff00  

```B4X
$"text here"$
```

  
**font** - font name:  

```B4X
$"[font=Arial]text here[/font]"$
```

  
**textsize** - text size.  
**break** - adds a new line. This tag is used internally.  
**i** - italic.  
**strike** - strikethrough text  
**img** - adds an image. It expects the following attributes: *Dir*, *FileName*, *Width* and *Height*. png and jpg images are supported. This is a self-closed tag.  
Pass "assets" for assets files.  

```B4X
$"![]("$<br />)
```

  
**highlight** - text highlight color. One of the named colors listed above. Hex values are not supported.  

```B4X
$"[highlight=Yellow]text here[/highlight]"$
```

  
**bookmark** - Internal links can point to the bookmark:  

```B4X
$"[bookmark=anchor_name/]"$
```

  
**url** - An external or internal link: <https://www.b4x.com/android/forum/threads/xlutils-word-bookmarks-urls-and-page-breaks.131826/>  
  
The **p**aragraph tag supports the following attributes:  
*Alignment* - horizontal alignment. One of the values listed here: <https://poi.apache.org/apidocs/4.0/org/apache/poi/xwpf/usermodel/ParagraphAlignment.html>  

```B4X
$"[p Alignment=Center]text here[/p]"$
```

  
*IndentationLeft* - left indentation:  

```B4X
$"[p Alignment=Left IndentationLeft=30]text here[/p]"$
```

  
*PageBreak* - if true, the paragraph will start on a new page.  
  
The header and footer are set with the **header** or **footer** tags:  

```B4X
$"[header]  
[p]this text will go to the header[/p]  
[/header]"$
```

  
  
Tables:  
Tables are created with the **Table** tag.  
This tag expects two attributes: *rows* and *cols*, number of rows and columns. It also accepts the *Alignment* attribute with one of the following values: left, center or right.  
A table must hold **row**s and **cell**s:  

```B4X
doc.Append($"[table rows=2 cols=3]  
    [row]  
        [cell width=100][p]1, 1[/p][/cell]  
        [cell width=100][p]1, 2[/p][/cell]  
        [cell width=100][p]1, 3[/p][/cell]  
    [/row]  
    [row]  
        [cell][p]2, 1[/p][/cell]  
        [cell][p]2, 2[/p][/cell]  
        [cell][p]2, 3[/p][/cell]  
    [/row]  
[/table]  
    "$)
```

  
  
Don't forget to add one or more paragraphs in the cells.  
![](https://www.b4x.com/android/forum/attachments/115117)  
  
The **row** tag supports the following attributes: *height* and *RepeatHeader* - whether the header should repeat if the table spans multiple pages.  
The **cell** tag supports the following attributes: *color* - cell background color, *VerticalAlignment* - Top, Center, Both or Bottom, *width*, *RowSpan* and *ColSpan* (see post #7).