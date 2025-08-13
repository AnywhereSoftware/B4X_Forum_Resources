### [Web] MiniHtml by aeric
### 04/02/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/158846/)

Version: 0.09  
  
Yet the potential or use cases of this library may be unknown as you can literally write plain HTML and save it as a file.  
  
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