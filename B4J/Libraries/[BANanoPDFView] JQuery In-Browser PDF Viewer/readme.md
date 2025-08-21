### [BANanoPDFView] JQuery In-Browser PDF Viewer by Mashiane
### 11/13/2019
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/111351/)

Ola  
  
Well, this basically does what it says. It uses the built-in PDF viewer to view your PDF files.  
  
Just pass it the URL of the pdf file and the width and height of the HTML element you want to render to and whalla!  
  
Ive tested it on Edge, Firefox, Opera, Chrome  
  
**FireFox**  
  
![](https://www.b4x.com/android/forum/attachments/85500)  
**Chrome**  
  
![](https://www.b4x.com/android/forum/attachments/85501)  
  
**Edge  
  
![](https://www.b4x.com/android/forum/attachments/85502)   
  
Opera  
  
![](https://www.b4x.com/android/forum/attachments/85503)   
  
Reproduction**  
0. Add the reference files in AppStart  
  

```B4X
'view  
   BANano.Header.AddJavascriptFile("jquery-3.4.1.min.js")  
   BANano.Header.AddJavascriptFile("jquery.media.js")  
   BANano.Header.AddJavascriptFile("jquery.metadata.js")
```

  
  
1. Add a HTML element that you want the PDF document to render to.  
  

```B4X
'get the body of the page  
    body = BANano.GetElement("#body")  
    'empty the element  
    body.Empty  
    'create a div to hold the pdf document  
    body.Append($"<div id="basic"></div>"$)
```

  
  
2. Run the PDFView  
  

```B4X
'initialize the viewer  
    Dim view As PDFView  
    'use the id of the iframe  
    view.Initialize("basic")  
    'set the path of the pdf file to view  
    view.SetHREF("./assets/themash.pdf")  
    'set the height  
    view.SetHeight(800)  
    'set the width  
    view.SetWidth(800)  
    'process the viewing action  
    view.View
```

  
  
   
Have Fun!