### [Web] MiniHtml quick tutorial by aeric
### 02/10/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/169429/)

[HEADING=1]A New Paradigm Shift[/HEADING]  
[MiniHtml](https://www.b4x.com/android/forum/threads/b4x-web-minihtml.158846/) is a B4X library to create html markup. Instead of writing html using opening and closing tags, we declare tag object and chaining it's methods to generate the attributes and finally output the object as String.  
  
Below is what ChatGPT understandings of this library:  
[HEADING=1]Pros and When to Use It[/HEADING]  

- **Advantages**:

- Type-safe or more structured way to build HTML compared to raw strings.
- Easier to maintain and refactor web-generation code in B4X.
- Integrates well with Bootstrap / CSS frameworks since you can set classes, styles, etc.
- HTMX support means you can build interactive front-ends without a heavy front-end framework.

- **Ideal Scenarios**:

- Building server-side web apps using **B4J**.
- Generating email HTML templates.
- Prototyping simple web UIs via B4X code.
- Using when you already use B4X for your project and want to stay within its ecosystem.

For me, it means you can:  

1. Use B4J as a single IDE for both backend and frontend logic
2. Use B4J server as live development server
3. Avoid B4J IDE auto-capitalize some keywords inside String Literals which will break JavaScripts
4. Easily use B4X to temporary comment out certain part of code
5. Focus on writing in B4X mindset
6. Direct access and mix the tag objects with B4X code

[HEADING=1]How to Use[/HEADING]  

1. Reference the library in Libraries Manager.
2. Declare a variable as Tag object.
3. Call the methods such as Div.text("This is an inner text")

[HEADING=1]Create a new Tag[/HEADING]  
There are 2 ways to create a html tag  
Method 1: Html module and create method  

```B4X
Html.create("main") ' create <main></main>
```

  
Method 2: Use named module  

```B4X
Form.init ' create <form></form>
```

  
If the module to create a tag is not available, then use Method 1.  
[HEADING=1]Add a Child tag to a Parent tag[/HEADING]  
There are 2 ways to add a child tag  
Let say we have a parent tag div1 and we want to add div2 as it's child.  

```B4X
<div class="p-1">  
  <div class="mb-2">  
  </div>  
</div>
```

  
Method 1: add() method  

```B4X
Div.cls("p-1").add(Div.cls("mb-2"))
```

  
Method 2: addTo() or up()  

```B4X
Dim div1 As Tag = Div.cls("p-1")  
Div.cls("mb-2").up(div1)  
Div.cls("mb-2 text-primary").up(div1)
```

  
If we are not going to add more attributes or children tags, we can write as one-liner using Method 1. If the line becomes longer, it can be confusing sometimes.  
If we are going to use a tag multiple times, it is better to declare the parent as a tag then it's children can use the up() method to add to it. This is the recommended way.  
[HEADING=1]Chaining multiple methods[/HEADING]  

1. You can chained or nested multiple methods.
2. However, I suggest to avoid writing a long nested line by declaring a new tag.
3. Example:

```B4X
Div.up(col1).hxGet("/hx/pages/list").hxTrigger("load").text("Loading…")
```

It is better to write as:

```B4X
Dim container1 As Tag = Div.up(col1)  
container1.hxGet("/hx/pages/list")  
container1.hxTrigger("load")  
container1.text("Loading…")
```


[HEADING=1]Debugging[/HEADING]  

1. We can use the following methods:
- PrintMe
- PrintChildren
to print the output to the Logs.2. We can also use Log

```B4X
Log(div1.Build)
```


[HEADING=1]Return the Document[/HEADING]  

1. We can use the Document class to generate a valid html document.

```B4X
Dim doc As Document  
doc.Initialize  
doc.AppendDocType  
doc.Append(page1.Build)  
App.WriteHtml(Response, doc.ToString)
```

2. We use Append() to add raw text into the document.
3. EndsMeet can write the text as server reponse using WriteHtml() method.

[HEADING=1]Raw html to tag[/HEADING]  

1. We can use Parse() method to convert html string into tag object.

```B4X
Dim s As String = $"<form action="forgot-password" method="post">  
    <label for="email">Email:</label>  
    <input type="email" id="email" required>  
    <input type="submit" value="Submit">  
</form>"$  
Dim form1 As Tag = Html.Parse(s)  
form1.up(body1)
```


[HEADING=1]Commonly Used Methods[/HEADING]  

1. up()
Add a tag to a parent tag

```B4X
Div.up(body1)
```

2. cls() - short for addClass
Add inline css class to the tag

```B4X
Div.cls("row mt-3")
```

3. sty() - short for addStyle
Add inline style to the tag

```B4X
Td.sty("text-align: right")
```

4. script()
Add a source of Javascript file

```B4X
body1.script("$SERVER_URL$/assets/js/app.js")
```

5. attr(key, value)
Add an attribute to the list of attributes of a tag. Use this when a method is not available.

```B4X
toast1.attr("role", "alert")
```

6. id()
Add an unique id to a tag usually useful as a css selector.7. name()
Add a name to a tag usually for a form input.8. text()
Add inner text to a tag9. hxGet()
Add a hx-get attribute to make a Get request using HTMX.10. Build
Convert the tag object to String.
  
Current version of MiniHtml integrated well with Bootstrap 5 and HTMX so you need to concern less on the responsive CSS styling and JavaScript ajax calls.  
[HEADING=2]Bootstrap[/HEADING]  

```B4X
Button.cls("btn btn-primary w-100 py-2")
```

  
The code generates a html markup that gives a styled blue color button with full width and 2 units of vertical padding.  
[HEADING=2]HTMX[/HEADING]  

```B4X
Dim form1 As Tag = Form.init  
form1.hxPut($"/hx/topics"$)  
form1.hxTarget("#modal-messages")  
form1.hxSwap("innerHTML")
```

  
The code generates a html markup for a form that sends a PUT request to the server using hx-put, targetting an html with id "modal-messages" using hx-target attribute and swap the form child tags when the response returned from the backend server.