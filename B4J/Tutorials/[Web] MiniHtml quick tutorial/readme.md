### [Web] MiniHtml Quick Tutorial by aeric
### 02/20/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/169429/)

[HEADING=1]A New Paradigm Shift[/HEADING]  
[MiniHtml](https://www.b4x.com/android/forum/threads/b4x-web-minihtml-v2.170180/) is a B4X library to create html markup. Instead of writing html using opening and closing tags, we declare MiniHtml object and chain it's methods to generate the attributes and finally output the object as String.  
  
**Advantages**  

- Type-safe or more structured way to build HTML compared to raw strings
- Easier to maintain and refactor web-generation code in B4X
- Integrates well with any CSS frameworks
- Integrates well with any JavaScript frameworks
- Works well with HTMX and AlpineJS to build interactive front-ends without a heavy front-end framework

**Ideal Scenarios when**  

- we want to stay within B4X ecosystem
- building server-side web apps using B4J
- generating email HTML templates
- prototyping simple web UIs via B4X code

In other words, we can:  

1. Use B4J as a single IDE for both backend and frontend logic
2. Use B4J server as live development server
3. Avoid B4J IDE auto-capitalize some keywords inside String Literals which will break JavaScripts
4. Easily use B4X to temporary comment out certain part of code
5. Focus on writing in B4X mindset
6. Direct access and mix the tag objects with B4X code

**Create MiniHtml object**  

1. Add this sub to our project.

```B4X
Sub CreateTag (Name As String) As MiniHtml  
    Dim tag1 As MiniHtml  
    tag1.Initialize(Name)  
    Return tag1  
End Sub
```

2. Now we can use it to create new tags.
3. To create a div tag, create a new sub as follow:

```B4X
Sub Div As MiniHtml  
    Return CreateTag("div")  
End Sub
```

4. Now we can create a div tag using Div sub.

```B4X
Dim div1 As MiniHtml = Div.up(body1)  
div1.cls("d-flex align-items-center")  
div1.sty("height: 100vh")
```

5. It is recommend to call .up() once we have created a new MiniHtml object.
6. Exceptional case for not calling .up() is when we are creating a reusable sub that return the object.
7. We can chain more methods but it is more cleaner to make new method calls on new line of code.

**Add to another MiniHtml object**  

1. We can call .up() method to add the current object to an existing MiniHtml object as it's child.

```B4X
Dim div1 As MiniHtml = Div.up(body1)
```

2. In this code, div1 will be added to the body1 children list.
3. The parent's tag will close itself.

**Return the object as String**  

1. Calling .build will generate and return the object as HTML text.

```B4X
body1.build
```

2. The output will look like this:

```B4X
<body>  
    <div class="d-flex align-items-center" style="height: 100vh">  
    </div>  
</body>
```


**Use in ServletResponse**  

1. We can also use .Write to add raw String to the object like using StringBuilder.

```B4X
Private Sub ShowIndexPage  
    Dim doc As MiniHtml  
    doc.Initialize("")  
    doc.Write("<!DOCTYPE html>")  
    doc.Write(body1.build)  
    Response.Write(doc.ToString)  
End Sub
```