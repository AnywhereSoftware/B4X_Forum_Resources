### [Web] EndsMeet Server (Getting Started) by aeric
### 07/07/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/167670/)

You can download the project template from:  
<https://www.b4x.com/android/forum/threads/project-template-endsmeet-server-v1-00.158071/>  
  
Steps:  

1. Just drop the template into B4J additional libraries folder.
2. Open B4J IDE and create a new project.
3. Recommended: Use [LibDownloader](https://www.b4x.com/android/forum/threads/tool-additional-libraries-downloader.166880/) to download the dependencies.
4. The starter template is now ready to use.

  
[SIZE=6]**Enable home or index page**[/SIZE]  

1. The following code add a GET route to load the index page.

```B4X
app.Get("", "Index")
```


[SIZE=6]**Enable POST method or route**[/SIZE]  

1. The following code add a POST route

```B4X
app.Post("/modal", "Index")
```

2. Take note that in Index.bas (GenerateIndex sub), we use **HTMX** *hx-post* instead of *hx-get*

```B4X
Button.attribute2(CreateMap("hx-post": "/modal", _  
"hx-target": "#modals-here", _  
"hx-trigger": "click", _  
"data-bs-toggle": "modal", _  
"data-bs-target": "#modals-here", _  
"class": "btn btn-primary text-uppercase")) _  
.Text("Open Modal").up(div2).uniline
```

3. You will see a "405 Method Not Allowed" page if you try to browse the page (GET method)

Happy developing your web application!