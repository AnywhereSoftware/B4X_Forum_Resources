### [Web] MiniHtml by aeric
### 11/05/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/158846/)

Version: 0.40  
  
Generate Html with B4X code.  
  
Example 1:  

```B4X
H1.Text("Hello, World!")
```

  
  
Output:  
[SIZE=7]Hello, World![/SIZE]  

```B4X
<h1>Hello, World!</h1>
```

  
  
Example 2:  

```B4X
Paragraph.up(main1) _  
.Text("This is a ") _  
.add(Span.Text("red text").addClass("text-danger")) _  
.Text(" in a ") _  
.add(Bold.text("paragraph"))
```

  
  
Output:  
This is a red text in a **paragraph**  

```B4X
<p>This is a  
    <span class="text-danger">red text</span> in a  
    <b>paragraph</b>  
</p>
```

  
  
Example using HTMX: <https://www.b4x.com/android/forum/threads/htmx-bootstrap5-minihtml-webapiutils-server.165263/>  
  
GitHub: <https://github.com/pyhoon/MiniHtml-B4X>