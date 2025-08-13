### [EasyHTML - Simplified HTML Element Creation] 🚀 by leozera
### 02/15/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/165626/)

**What is EasyHTML?** 🏗️ EasyHTML is a lightweight and intuitive library designed to simplify the creation of HTML elements using an object-oriented approach. With support for attributes, classes, styles, and even HTMX integration, EasyHTML makes it effortless to generate dynamic HTML structures programmatically.  
  
  
[HEADING=2]🌟 Features:[/HEADING]  
✅ Chainable methods for easy and readable syntax  
✅ Support for inline styles, classes, and attributes  
✅ HTMX integration for enhanced interactivity  
✅ Page builder functionality with PageBuilderHTML class  
✅ Generates clean and valid HTML output  
  
  
[HEADING=2]🔧 **Classes and Functions**[/HEADING]  
[HEADING=3]🏗️ EasyHTML (Main Class)[/HEADING]  

- Initialize(Element As String): Initializes an HTML element
- AddElement(Item As String): Adds an internal element
- AddClass(Class As String): Adds a CSS class
- AddId(Identificador As String): Sets an ID for the element
- AddAttribute(Key As String, Value As String): Adds a custom attribute
- AddStyle(Property As String, Value As String): Adds an inline CSS style
- HX\_GET(Path As String): HTMX GET request
- HX\_POST(Path As String): HTMX POST request
- HX\_PUT(Path As String): HTMX PUT request
- HX\_DELETE(Path As String): HTMX DELETE request
- HX\_Target(Selector As String): Defines the HTMX target
- HX\_Trigger(Event As String): Sets the HTMX trigger
- HX\_Swap(Strategy As String): Defines the HTMX swap strategy
- Mount() As String: Generates the final HTML string

[HEADING=3]📄 PageBuilderHTML (Page Builder Class)[/HEADING]  

- Initialize(): Initializes the page builder
- SetTitle(Name As String): Sets the page title
- AddElement(Item As String): Adds an element to the page body
- AddStyle(Href As String): Adds an external CSS file
- AddInlineStyle(CSS As String): Adds inline CSS
- AddScript(Src As String): Adds an external JavaScript file
- AddInlineScript(JS As String): Adds inline JavaScript
- AddMetaTag(Name As String, Content As String): Adds a meta tag
- SetFavicon(IconPath As String): Sets the page favicon
- Mount() As String: Generates the final HTML structure

  
  
[HEADING=2]📌 **Example Usage:**[/HEADING]  

```B4X
Dim H1 As EasyHTML  
H1.Initialize("h1").AddElement("To-Do App").Mount  
  
Log(H1.ToString)
```

  
  
  
[HEADING=2]📥 **Download & Installation**[/HEADING]  
**Library and example of use pinned to topic**