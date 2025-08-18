### [BANanoCanvas] A HTML5 Canvas Library by Mashiane
### 09/27/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/122822/)

Ola  
  
[Download](https://github.com/Mashiane/BANanoCanvas)  
  
Using the BANanoElement & BANanoObject, one is able to script the HTML canvas to draw images etc. Here we follow the same methodology used to create canvas structures. To be able to do this, one uses the BANanoElement to create the <CANVAS> tab, then from that gets the 2d context to draw on the canvas.  
  
The library uses the BANanoObject from the BANAnoElement and runs a series of .GetField, .SetField and .RunMethods internally. How the [BANanoObject](https://www.b4x.com/android/forum/threads/banano-bananoobject-talks-with-javascript.100385/#content) works was discussed on this thread.  
  
![](https://www.b4x.com/android/forum/attachments/100606)  
  
We want to change the page title and create some helper classes, so, we avail these.  
  

```B4X
'change the title of the page  
Sub SetTitle(tt As String)  
    BANano.Window.GetField("document").SetField("title", tt)  
End Sub
```

  
  
The skeleton sub will help with most creation of the canvas code we need to get the 2d context from.  
  

```B4X
'create skeleton  
Sub Skeleton(title As String, cid As String) As MashCanvas  
    'add a paragraph to the body  
    Dim p As BANanoElement = body.Append($"<p id="p${cid}">${title}</p>"$).Get($"#p${cid}"$)  
    p.Append("<br/>")  
    'add a canvas to the paragraph  
    Dim c As BANanoElement = p.Append($"<canvas id="${cid}">Your browser does Not support the HTML5 canvas tag</canvas>"$).Get($"#${cid}"$)  
    c.SetAttr("width", 300)  
    c.SetAttr("height", 150)  
    c.SetStyle(BANano.ToJson(CreateMap("border": "1px solid #d3d3d3")))  
    p.Append("<div></div>")  
    'create the context  
    Dim ctx As MashCanvas  
    ctx.Initialize(c, "2d")  
    Return ctx  
End Sub
```

  
  
As an example, the code for the canvas above, is written like this..  
  

```B4X
' r1c0  
    Dim ctx1 As MashCanvas = Skeleton("fillStyle", "ctx1")  
    ctx1.fillStyle = "#ff0000"  
    ctx1.fillRect1(20, 20, 150, 100)  
     
    'r1c1  
    Dim ctx2 As MashCanvas = Skeleton("fillStyle", "ctx2")  
    Dim my_gradient As MashCanvas = ctx2.createLinearGradient1(0, 0, 0, 170)  
    my_gradient.addColorStop1(0, "black")  
    my_gradient.addColorStop1(1, "white")  
    ctx2.fillStyle = my_gradient.Context  
    ctx2.fillRect1(20, 20, 150, 100)  
     
    'r1c2  
    Dim ctx3 As MashCanvas = Skeleton("fillStyle", "ctx3")  
    Dim my_gradient1 As MashCanvas = ctx3.createLinearGradient1(0, 0, 170, 0)  
    my_gradient1.addColorStop1(0, "black")  
    my_gradient1.addColorStop1(1, "white")  
    ctx3.fillStyle = my_gradient1.Context  
    ctx3.fillRect1(20, 20, 150, 100)  
     
    'r1c3  
    Dim ctx4 As MashCanvas = Skeleton("fillStyle", "ctx4")  
    Dim my_gradient3 As MashCanvas = ctx4.createLinearGradient1(0, 0, 170, 0)  
    my_gradient3.addColorStop1(0, "black")  
    my_gradient3.addColorStop1(0.5, "red")  
    my_gradient3.addColorStop1(1, "white")  
    ctx4.fillStyle = my_gradient3.Context  
    ctx4.fillRect1(20, 20, 150, 100)  
     
    'r1c4  
    Dim img As BANanoElement = body.Append($"<img id="lamp"></img>"$).Get("#lamp")  
    img.SetAttr("src", "./assets/img_lamp.jpg")  
    img.SetAttr("width", 32)  
    img.SetAttr("height",  32)  
    '  
    Canvas("createPattern1", "ctx5")  
    '  
    Dim b1 As BANanoElement = body.Append($"<button id="b1">Repeat</button>"$).Get("#b1")  
    b1.On("click", Me, "brepeat")
```

  
  
And the rest of the code…  
  

```B4X
Sub brepeat(e As BANanoEvent)  
    draw("repeat")  
End Sub  
  
Sub draw(direction As String)  
    Dim c As BANanoElement  
    c.Initialize("#ctx5")  
    Dim ctx As MashCanvas  
    ctx.Initialize(c, "2d")  
    Dim cwidth As Int = c.GetAttr("width")  
    Dim cheight As Int = c.GetAttr("height")  
    ctx.clearRect1(0, 0, cwidth, cheight)  
    Dim img As BANanoElement  
    img.Initialize("#lamp")  
    Dim pat As BANanoObject = ctx.createPattern1(img.ToObject, direction)  
    ctx.rect1(0, 0, 150, 100)  
    ctx.fillStyle = pat  
    ctx.fill1  
End Sub
```

  
  
Below is what we will create with this library…