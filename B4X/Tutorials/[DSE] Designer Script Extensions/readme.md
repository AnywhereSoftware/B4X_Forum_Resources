###  [DSE] Designer Script Extensions by Erel
### 07/19/2022
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/141312/)

The soon to be released versions of B4A, B4i and B4J include a new feature named: designer script extensions. The new feature allows calling B4X code from the visual designer scripts.  
Note that the B4X code is not executed at design time.  
I believe that over time this new feature, with a supportive framework, will change the way we manage complex layouts.  
  
Q: Which subs can be called from the designer script?  
  
1. Subs in classes.  
2. The subs signature must be a single DesignerArgs parameter. Example:  

```B4X
'Adds a class attribute to one or more views.  
'Parameters: ClassName, One or more views.  
Private Sub AddClass(DesignerArgs As DesignerArgs)
```

  
Calling this method from the script (class name is DDD):  

```B4X
DDD.AddClass("small button", Button1, Button3)
```

  
As you can see, the script call can include any number of parameters. The DesignerArgs object will hold all the parameters, as well as other useful information about the layout.  
  
Q: How is the class instance created?  
  
It depends. By default a new class instance will be created on the first time it is needed, and it will be cached. The Initialize sub of the class must not include any parameter.  
The other option is to use XUI.RegisterDesignerClass to assign a specific instance that will be used.  
You can get the cached class instance with XUI.GetRegisteredDesignerClass. It is probably a bit obscure for now, but these two methods are very useful.  
  
Lets start with a silly example.  
We want a DS extension that blinks views.  
  
Code in B4XMainPage:  

```B4X
'Parameters: Duration, View  
Private Sub BlinkView(DesignerArgs As DesignerArgs)  
    'In B4i and B4J the script will run multiple times. We want to run this code once.  
    If DesignerArgs.FirstRun Then  
        Dim duration As Int = DesignerArgs.Arguments.Get(0)  
        Dim v As B4XView = DesignerArgs.GetViewFromArgs(1)  
        Do While True  
            v.SetVisibleAnimated(duration, False)  
            Sleep(duration + 10)  
            v.SetVisibleAnimated(duration, True)  
            Sleep(duration + 10)  
        Loop  
    End If  
End Sub
```

  
It is important to document the parameters as there is no other hint for the expected parameters. The documentation will appear in the designer script.  
  
DS:  

```B4X
B4XMainPage.BlinkView(500, Button1)  
B4XMainPage.BlinkView(1000, Button2)
```

  
  
A new internal library is available named DesignerUtils. It includes a class named DDD with all kinds of useful method. I recommend developers to check it source code (inside the b4xlib = zip).  
  
Example of using DDD:  
  
![](https://www.b4x.com/basic4android/images/B4J_ZHyMc7OPeu.gif)  

```B4X
DDD.SpreadControlsHorizontally(Pane1, 100dip, 10dip)  
TextSize = 16  
DDD.SetTextAndSize(Button1, TextSize, "Sunday", "Sun", "1")  
DDD.SetTextAndSize(Button2, TextSize, "Monday", "Mon", "2")  
DDD.SetTextAndSize(Button3, TextSize, "Tuesday", "Tue", "3")  
DDD.SetTextAndSize(Button4, TextSize, "Wednesday", "Wed", "4")  
DDD.SetTextAndSize(Button5, TextSize, "Thursday", "Thu", "5")  
DDD.SetTextAndSize(Button6, TextSize, "Friday", "Fri", "6")  
DDD.SetTextAndSize(Button7, TextSize, "Saturday", "Sat", "7")  
DDD.SetTextAndSize(Button8, TextSize, "Click here", "Click")
```

  
  
Updates:  
v1.04 - Fixes a bug with the classes feature. New Color method.