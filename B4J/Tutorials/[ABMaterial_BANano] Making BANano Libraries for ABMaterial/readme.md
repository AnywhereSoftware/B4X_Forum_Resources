### [ABMaterial/BANano] Making BANano Libraries for ABMaterial by alwaysbusy
### 05/26/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/126828/)

**PREFACE:**  
As some may know, ABM has some basic JavaScript functionality build-in called [B4JS](https://www.b4x.com/android/forum/threads/abmaterial-b4js-00-introduction.90249/#content). It was the predecessor of BANano. However, because of the design of ABM, B4JS could never reach its full potential. But from that came the idea to write a full blown ***true B4J to JavaScript Transpiler*** was born: [**BANano**!](https://www.b4x.com/android/forum/threads/banano-website-app-pwa-library-with-abstract-designer-support.99740/) (Thinking in retrospect, B4JS in ABM may have been a poor choice of words, as BANano covers much more that term ;) )  
  
In my day job, we still use ABM in most of our client projects. But sometimes we just miss that extra BANano can do on the Browser side. For new projects, we now mostly use a BANanoServer instead of an ABMServer, but we still have many ABM apps running and continue to write extra functionalities to those apps. What if we could use BANano generated code IN ABMaterial?  
  
Hence this new idea came up: If BANano could generate .b4xlib libraries, writing the *'glue'* between ABM and BANano, that would be a great asset to add features to ABM!  
  
**An Example of an ABMButton hover extension:**  
  
1. One writes BANano code that when one hovers over an ABMButton, it changes color  
  
In pure ABM, it is kind of a hassle, but in BANano this is pretty simple:  
  
*The ABMHover Class*  

```B4X
#Event: Hover(ID As String, IsOver As Boolean)  
  
Sub Class_Globals  
    Private BANano As BANano 'ignore  
    Private mEventName As String  
End Sub  
  
'Initializes the object, setting the event  
Public Sub Initialize(eventName As String)  
    mEventName = eventName  
End Sub  
  
' Adds hover functionality to an ABM Component  
public Sub AddHover(ID As String)  
    ' get the element with the ID  
    Dim mElement As BANanoElement  
    mElement.Initialize("#" & ID)  
  
    ' add the Mouse Enter and Leave events to the element  
    Dim event As Object  
    mElement.AddEventListener("mouseenter", BANano.CallBackExtra(Me, "HandleMouseEnter", event, Array(mElement)),True)  
    mElement.AddEventListener("mouseleave", BANano.CallBackExtra(Me, "HandleMouseLeave", event, Array(mElement)),True)  
End Sub  
  
' the Callback for the Mouse Enter event  
private Sub HandleMouseEnter(event As BANanoEvent, Element As BANanoElement) 'ignore  
    ' make the button red  
    Element.RemoveClass("light-blue").AddClass("red")  
    ' optionaly raise an event back to ABM  
    BANano.RaiseEventToABM(mEventName & "_Hover", Array("ID","IsOver"), Array(Element.Name, True), "")  
End Sub  
  
' the Callback for the Mouse Leave event  
private Sub HandleMouseLeave(event As BANanoEvent, Element As BANanoElement) 'ignore  
    ' make the button blue again  
    Element.RemoveClass("red").AddClass("light-blue")  
    ' optionaly raise an event back to ABM  
    BANano.RaiseEventToABM(mEventName & "_Hover", Array("ID","IsOver"), Array(Element.Name, False), "")  
End Sub
```

  
  
**NOTES:**  
a. You can use BANano.RaiseEventToABM() to make a call back to the ABM server. This could be just an notice that it is done, or even a result.  
But it is also possible to get something returned by the BANano methods immediately:  

```B4X
public Sub TestReturningSomething(someParam As String) As Boolean  
    Return True  
End Sub
```

  
  
You can define your Event for ABM with:  

```B4X
#Event: Hover(ID As String, IsOver As Boolean)
```

  
  
b: Comments you add before the Method declaration will be visible in the final ABMBANano lib.  
  
2. Making a ABM BANano b4xlib  
  
In our main, you make one call (similar to the BANano.BuildAsB4XLib() for normal BANano Libraries):  

```B4X
Sub Process_Globals  
    Private BANano As BANano 'ignore  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    ' you can change some output params here  
    BANano.Initialize("BANano", "Hover",7) '<——————— the name of our lib  
    BANano.JAVASCRIPT_NAME = "hover.js" '<——————- the name of the generated JavaScript file  
  
    ' start the build  
    #if release  
        BANano.BuildAsB4XlibForABM("K:\_ONETWO210203\Work2020\Objects\www", "1.0") '<———————–  
        ExitApplication  
    #else  
        BANano.Build(File.DirApp)  
    #end if  
End Sub  
  
' HERE STARTS YOUR APP  
Sub BANano_Ready()  
  
End Sub
```

  
  
The Result is this:  

```B4X
Reading B4J INI in C:\Users\pi\AppData\Roaming\Anywhere Software\B4J to find Additional Libraries folder…  
Found Additional Libraries folder: K:\B4J\AddLibraries  
Starting to transpile…  
Building K:\BANano6.11\ABMJavaScript\Objects\Hover\scripts\hover.js  
Copying CSS files to WebApp assets…  
Copying Javascript files to WebApp assets…  
Starting to build the ABMBANanoHover.b4xlib…  
==========================================================================  
The following files have been created in your Additional Libraries folder K:\B4J\AddLibraries  
-> ABMBANanoHover.b4xlib  
-> ABMBANanoHover.Assets.zip  
-> ABMBANanoHover.txt  
————————————————————————–  
Read the instructions in ABMBANanoHover.txt on how to deploy and use this library!  
==========================================================================
```

  
  
As you can see, three files are generated:  
- The .b4xlib itself  
- a .zip file containing the assets (this is the CSS/JS BANano generated) **MUST BE NEXT TO THE .b4xlib!**  
- a .txt file with some usage info:  
  
Here for example the .txt content looks like this:  

```B4X
========== Using the ABMBANanoHover Library in ABM: CHECKLIST ===============  
  
———- 1. Add the ABMBANanoHover library to your project —————  
  
———- 2. Add these lines in BuildPage() —————  
page.AddExtraJavaScriptFile("bananocore.js")  
page.AddExtraJavaScriptFile("Hover/hover.js")  
' unless you use a specific other place where your Static Files are, this will always be "www"  
Hover.UnzipAssets("www")  
  
———- You can now use your BANano Classes in ABM like a normal B4J class  
EXAMPLE:  
Dim myFirstBANanoClass As FirstBANanoClass  
myFirstBANanoClass.Initialize(ws, "myFirstBANanoClass")  
myFirstBANanoClass.MyFirstMethod(ws, "Hello World!")
```

  
  
It is a short checklist of what you have to do to use this library in ABM.  
  
3. So we follow these few simple instructions:  
  
3.1. In our ABM project, First we pick the newly generated library:  
  
![](https://www.b4x.com/android/forum/attachments/106714)  
  
3.2 In BuildPage(), we add the assets:  
  
![](https://www.b4x.com/android/forum/attachments/106716)  
  
And now we can just start using our BANano Hover code in ABM! ?  
  

```B4X
public Sub ConnectPage()  
   Dim button as ABMButton  
   button.Initialize(page, "button", "", "", "Say Hello", "")  
   page.Cell(2,1).AddComponent(button)  
  
   ' refresh the page  
   page.Refresh  
   ' Tell the browser we finished loading  
   page.FinishLoading  
   ' restore the navigation bar position  
   page.RestoreNavigationBarPosition  
  
   Dim MyJS as ABMHover  
   myJS.Initialize(ws, "myJS") ' <<<<<<<<<<<<<<<<<<<< New in 6.59 the first parameter ws has to be passed  
   myJS.AddHover(ws, "button")  ' <<<<<<<<<<<<<<<<<<<< New in 6.59 the first parameter ws has to be passed  
End Sub  
  
' our Hover event (the BANano.RaiseEventToABM we did)  
Sub myJS_Hover(ID As String, IsOver as Boolean)  
   Log("Hover on " & ID & " -> Is Over: " & IsOver)  
End Sub
```

  
  
And this is the result (Notice the color of the button changing and in the B4J log also the Events back):  
  
[MEDIA=youtube]UxKOygCy\_34[/MEDIA]  
  
  
**HOW IT WORKS (For those interested in the mechanics behind it)**  
  
The .b4xlib created is a 'glue' lib with all the **Public methods** in it, making calls to their BANano counterparts:  
  
For example this snippet from the ABMBANanoHover.b4xlib):  

```B4X
public Sub AddHover(ws as WebSocket, ID As String)  
    ws.Eval("BANhover['" & UniqueBANID & "'].addhover(arguments[0])", Array (id))  
    ws.Flush  
End Sub
```

  
  
When calling AddHover in ABM, we forward it to the method in the BANano library.  
  
Alwaysbusy