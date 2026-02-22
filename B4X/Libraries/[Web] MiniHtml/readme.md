### [Web] MiniHtml by aeric
### 02/20/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/158846/)

[TABLE]  
[TR]  
[TH]

Updates

[/TH]  
[/TR]  
[TR]  
[TD]

Version [2.00](https://www.b4x.com/android/forum/threads/b4x-web-minihtml-v2.170180/) is now available

[/TD]  
[/TR]  
[/TABLE]  
  
Version: 0.90  
  
Generate Html with B4X code.  
Added HTMX attributes such as hx-get and hx-trigger.  
  
Example 1:  

```B4X
H1.text("Hello, World!")
```

  
  
Output:  
[SIZE=7]Hello, World![/SIZE]  

```B4X
<h1>Hello, World!</h1>
```

  
  
Example 2:  

```B4X
Dim p1 As Tag = Paragraph.text("This is a ")  
p1.add(Span.cls("text-danger").text("red text"))  
p1.text(" in  a ").add(Bold.text("paragraph"))
```

  
  
Output:  
This is a red text in a **paragraph**  

```B4X
<p>This is a <span class="text-danger">red text</span> in  a <b>paragraph</b></p>
```

  
  
Example using HTMX: <https://www.b4x.com/android/forum/threads/htmx-bootstrap5-minihtml-webapiutils-server.165263/>  
  
GitHub: <https://github.com/pyhoon/MiniHtml-B4X>