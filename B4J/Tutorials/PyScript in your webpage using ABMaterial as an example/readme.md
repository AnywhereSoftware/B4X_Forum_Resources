### PyScript in your webpage using ABMaterial as an example by MichalK73
### 06/15/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/141228/)

Hello.  
  
Today I would like to present how to combine PyScript with B4X. I have taken ABMaterial as an example.  
First, let's start what PyScript is. In the simplest way, it is the execution of non javascript (JS) programming language code in a client-side browser. Pyscript allows us to run Python code. The solution is very young (few months) in 'alpha' version but it has already got the developer community very, very interested. You can already find many solutions and future applications on the web. Some say that it could be the successor of JS.  
A great advantage of pyscript is the use of one of the most powerful Python libraries and solutions. The second one is that the page code, libraries, custom modules are downloaded on the client side and run there. No server-side or client-side Python environment is needed. That's it in a nutshell.  
  
Where to start. First you need to add in the <head> section the JS script responsible for downloading the data you need. I used in ABMaterial in the function 'public Sub BuildPage()' . And this  

```B4X
page.AddExtraJavaScriptFile("https://pyscript.net/alpha/pyscript.js")
```

  
is enough to make the page ready for pyscript.  
  
So my simple example for one web BuildPage looks like this:  

```B4X
public Sub BuildPage()  
    ' initialize the theme  
    BuildTheme  
    
    ' initialize this page using our theme  
    page.InitializeWithTheme(Name, "/ws/" & ABMShared.AppName & "/" & Name, False, ABMShared.SessionMaxInactiveIntervalSeconds, theme)  
    page.ShowLoader=True  
    page.PageHTMLName = "index.html"  
    page.PageTitle = "PyScript in ABMaterial"  
    page.PageDescription = "PyScript"  
    page.PageKeywords = ""  
    page.PageSiteMapPriority = ""  
    page.PageSiteMapFrequency = ABM.SITEMAP_FREQ_YEARLY  
        
    page.ShowConnectedIndicator = True  
    page.AddExtraJavaScriptFile("https://pyscript.net/alpha/pyscript.js")  
'    page.AddExtraCSSFile("https://pyscript.net/alpha/pyscript.css")  
            
    ' create the page grid  
    page.AddRowsM(4,True,20,0, "").AddCells12MP(1,0,0,0,0,"")   
    
    page.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components       
End Sub
```

  
  
As you can see, the line is off:  

```B4X
page.AddExtraCSSFile("https://pyscript.net/alpha/pyscript.css")
```

  
  
It is CSS for pyscript but when you enable it, the whole ABMaterial CSS falls apart. I think the author of ABMaterial will find a solution for this.  
Here I used a little trick to include the pyscript code. I plugged the code into ABMlabel like TextAsRAWHTML.  
It looks like this:  

```B4X
    Dim pyscript As ABMLabel  
    pyscript.Initialize(page, "pyscript", "",ABM.SIZE_A,False,"")  
    pyscript.TextAsRAWHTML = $" code pyscript and python "$  
    page.Cell(1,1).AddComponent(pyscript)
```

  
  
This code will not be displayed on the page and will be processed by the pyscript declared in BuildPage. Further the code is usual for ABMaterial. I have shown in the example 4 elements of the use of pyscript.  
- The first is a counter that will count down from 1 to 15. Reset the counter and count up again every second.  
- The second under the ABMButton 'PY1' will display consecutive button presses.  
- The third takes 2 numbers from the ABMInput page adds them up in python and displays them on the screen  
- The fourth is to use your python module located on the server. The module is downloaded to the browser and run there.  
  
Some code explanations.  
To add your own module you need to use 'py-env' block. In this block we declare external modules to be included. You can add libraries from <https://pypi.org> e.g.  

```B4X
<py-env>  
 - numpy  
 - pandas  
</py-env>
```

  
  
This declaration causes the client-side browser to download the library locally and use it.  
As you can see I use my own library with 2 functions which is one used on the page.  

```B4X
<py-env>  
  - paths:  
    - ../../pyscript/example.py  
</py-env>
```

  
  
../../ is a jump 2 levels higher in the structure on the file server.  
In the www directory I created a new folder 'pyscript' and there I put all the modules I want to use on the website. Here is pure python, where we build our own code. The advantage of this is that the code change will work immediately after reloading the page in the browser and you do not need to restart the server ABMaterial.  
  
In the next block <py-script> my code python </py-script> we put the code to handle what we want. At the beginning there is a declaration of library import. As you can see my library example.py is imported, which is placed on the server. Described above.  
All code pyscript  

```B4X
import example  
import js  
from js import document  
from pyodide import create_proxy  
from random import randint  
   
count = 0  
   
def button_click(event):  
    global count  
    count += 1  
    document.getElementById("label2").innerHTML = 'Button Clicked ' + str(count)  
    
  
  
def button2_click(event):  
    n1 = 0  
    n2 = 0  
    n1 = document.getElementById("number1").value  
    n2 = document.getElementById("number2").value  
    suma = int(n1) + int(n2)  
    #console.log(suma)  
    #pyscript.write("result", suma)  
    document.getElementById("result").innerHTML = str(suma)  
  
def button3_click(event):  
    number = example.add_two_numbers(randint(1,10), randint(20,50))  
    console.log(number)  
    document.getElementById("res1").innerHTML = str(number)  
  
def btn1():  
    # The page is ready, clear the "page loading"  
    document.getElementById("label2").innerHTML = ''  
   
    # Create a JsProxy for the callback function  
    click_proxy = create_proxy(button_click)  
   
    # Set the listener to the callback  
    e = document.getElementById("btn")  
    e.addEventListener("click", click_proxy)  
  
def btn2():  
    # The page is ready, clear the "page loading"  
    document.getElementById("result").innerHTML = ''  
   
    # Create a JsProxy for the callback function  
    click_proxy = create_proxy(button2_click)  
   
    # Set the listener to the callback  
    e = document.getElementById("btn2")  
    e.addEventListener("click", click_proxy)  
    
def btn3():  
    # The page is ready, clear the "page loading"  
    document.getElementById("res1").innerHTML = ''  
   
    # Create a JsProxy for the callback function  
    click_proxy = create_proxy(button3_click)  
   
    # Set the listener to the callback  
    e = document.getElementById("btn3")  
    e.addEventListener("click", click_proxy)  
  
  
#function for counter  
counter = 0  
def myFunc(param):  
    global counter  
    counter += 1  
    document.getElementById("counter").innerHTML = "Counter = " + str(counter)  
  
    # Stop the Interval timer at 15  
    if counter == 15:  
            counter = 0  
   
# Create a proxy for the callback  
proxy = create_proxy(myFunc)  
   
# Start an Interval timer for every 1,000 ms  
interval_id = js.setInterval(proxy, 1000, "a parameter");  
   
#execute button  
btn1()  
btn2()  
btn3()  
   
</py-script>
```

  
  
Button event handling. First through the JsProxy we create a callback function in the function and set up a listener for the button event. If it is pressed the given python function will be executed.  
Downloading data from the page is the button PY2. After pressing it the function is executed:  
first we set n1, n2 to 0. Then we retrieve the entered number from the page with ABMInput 'number1' is the id of ABMInput  

```B4X
    Dim n1 As ABMInput  
    n1.Initialize(page,"number1", ABM.INPUT_NUMBER, "Number 1",False, "")  
    n1.Text=2
```

  
  
we sum as integer and we write the ID in the right place on the page. Here I have given 2 possibilities to send the result to the page and each is good.  
  

```B4X
#pyscript.write("result", sum)  
document.getElementById("result").innerHTML = str(sum)
```

  
  
The rest of the code for the brave and curious I think will be understandable. Attention !!! If the indentation in python is TAB then use Space in the <py-script> block. In your own add-on modules the python indentation rules apply.  
  
This is how briefly I wanted to present a new solution which may develop programming in the future. Performance. This is a very young project which gives great possibilities at the very beginning, however it has its problems. At the first launch, where the cache does not have the necessary libraries loading time may be several, a click a second to compile on the client side. If it is already in the cache the time is seconds. The same applies to the used 'heavy' libraries that must be downloaded and compiled on the client machine. However, from the assurances of developers on the web, that performance will increase significantly with the transition of pyscript to the next stable versions.  
More material can be found on the web and I provide some links ready for you.  
  
Change the example.txt attachment to example.py and place it in the pyscript directory in the project's web folder.  
  
Homepage  
<https://pyscript.net/>  
Demo  
<https://pyscript.net/examples/>  
Youtube  
<https://www.youtube.com/results?search_query=pyscript+example>  
  
YT Example ABMaterial+PyScript  
[MEDIA=youtube]I0Y4Voyt9EU[/MEDIA]