### [BANanoAPI] - Scripting the DOM: The HTML5 Canvas Story (Advanced Users) by Mashiane
### 09/27/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/122802/)

Ola  
  
[Download](https://github.com/Mashiane/BANanoAPI)  
  
[BANanoCanvas](https://www.b4x.com/android/forum/threads/bananocanvas-a-html5-canvas-library.122822/#content) - Find the replica there for use in all BANano Projects  
  
**DISCLAIMER: This is purely for fun and learning purposes.**  
  
Another pleasure, BANanoAPI. Why the suffix API? Well, the functionality of the library used here is based on the BANanoObject. In December 2018, a thread was posted about [BANanoObject - talks with javascript.](https://www.b4x.com/android/forum/threads/banano-bananoobject-talks-with-javascript.100385/#content) and this enabled a lot of possibilities for us to maneuver our way around the javascript framework used for Web Development.  
  
*So what is this all about?*  
  
This is about DOM, BOM, CSSOM scripting using the BANanoObject.  
  
As you will find, the source code of the library has a lot of **.GetField, .SetField,** and **.RunMethod.** Thus the helper classes created are on top of the BANanoObject and in some instances the BANanoElement.  
  
*Wait, why are you having direct javascript in the B4X IDE?*  
  
Whilst you will notice some ***similarities*** within the code examples here with some javascript code, that was just done for simplicity and speed. I just wanted to copy and paste source code and run it and just wrapped a few things to achieve that for my purposes. Yes, its a personal project, but then again, why not share it.  
  
Remember, with BANano, we have **#if javascript** and **.CallJavaScriptMethod**, so we could have just used that syntax instead, but then again, I am adventurous, so don't be alarmed if most of the cases you don't see a lot of the BANano core code in the examples, underneath it is all its just the BANanoObject and some shortcuts.  
  
*Why re-invent the wheel?*  
  
Some things were done for fun, learn and explore what will happen.  
  
*Do you have to write code like I have done here mostly?*  
  
Absolutely NOT. For HTML elements, its rather and ALWAYS better and recommended to use the Abstract Designer. There is an independent custom view in the library that you can use outside of this API. To regress a little, on the issue of the custom view…  
  
I tested that with some **A**pplication **M**odelling **L**anguage that I was curious about. A pure **MVC** javascript framework. The image below was the eye candy for that experiment. [AML](https://www.w3schools.com/appml/default.asp) is used for prototyping apps, its old tech. It is when I was exploring that framework that this BANanoAPI was birthed.  
  
![](https://www.b4x.com/android/forum/attachments/100554)  
  
Anyway…  
  
Beginning the HTLM5 Canvas is no easy feat and yes there are libraries out there added on top of it that are better. The purpose though here is learning it and how it works. The best way to do that is to learn some javascript that is specific to the canvas. You get the javascript specific to the canvas, convert it to the BANano language and code your way to canvas based dev or rather use #if javascript with .CallJavaScript.  
  
My approach was rather simple, use the existing language but make it work with BANano. This helps me learn the underlying language and at the same time also learn how to manipulate it to suit my needs. So I created some helper classes for the purpose. The helper classes are based on the BANanoObject and will work around that object ONLY.   
  
To use the canvas, you need to create the canvas element for your page body. The example below, creates a canvas, gets the 2d context and then adds this to an existing table at RC position provided.  
  

```B4X
Sub Skeleton(doc As JSDocument, tb As JSTable, cid As String, rowPos As Int, cellPos As Int) As JSCanvas  
    'create the canvas  
    Dim mycanvas As JSElement = doc.createElement("CANVAS")  
    mycanvas.id = cid  
    mycanvas.width = 300  
    mycanvas.height = 150  
    mycanvas.style.border = "1px solid #d3d3d3"  
    mycanvas.innerHTML = "Your browser does Not support the HTML5 canvas tag"  
    'add canvas to table  
    tb.row(rowPos).cell(cellPos).empty  
    tb.row(rowPos).cell(cellPos).appendChild(mycanvas)  
    'creare the context  
    Dim ctx As JSCanvas  
    ctx.Initialize(mycanvas, "2d")  
    Return ctx  
End Sub
```

  
  
Like I said, we are using BANanoObject for this library, so we call the DOM API directly. Looking at .CreateElement, we will note that its defined like this.  
  

```B4X
'createElement  
Sub createElement(arguements As String) As JSElement  
    Dim bo As BANanoObject = d.RunMethod("createElement", Array(arguements))  
    Dim jse As JSElement = ToJSElement(bo)  
    Return jse  
End Sub
```

  
  
Writing this the BANano Core way would be.  
  

```B4X
Sub CreateElement(arguments as string) as BANanoObject  
      dim bo As BANanoElement  
       bo.Initialize(arguments)  
       return bo.ToObject  
End Sub
```

  
  
JSElement = BANanoObject (with a name)  
  
Whilst this thread is about DOM/BOM/CSSOM scripting  
  
1. Creating User Interfaces by scripting the DOM is not recommended - use the abstract designer where absolutely necessary.  
2. Creating Cascading Style Sheets by scripting the BOM/CSSOM is not recommended - use .css and inline styles  
  
Things to remember  
  

```B4X
JSWindow (BANanoObject) = BANAnoWindow  
JSDocument (BANanoObject) = BANano.Window.GetField("document") / BANanoWindow.GetField("document")  
body (BANanoObject) = BANano.Window.GetField("document").GetField("body")  
JSElement (BANAnoObject) = BANanoElement.Initialize(?).ToObject
```

  
  
One of the nice examples of this exercise is this pie chart.  
  
![](https://www.b4x.com/android/forum/attachments/100574)