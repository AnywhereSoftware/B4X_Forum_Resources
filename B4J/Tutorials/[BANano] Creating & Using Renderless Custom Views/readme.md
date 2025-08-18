### [BANano] Creating & Using Renderless Custom Views by Mashiane
### 05/29/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/131190/)

Ola  
  
Say what? A render-less custom view? What on earth is this guy on about?  
  
Well without overthinking what this is. A render-less custom view is basically a normal class, that is made into a custom view. Instead of you writing the code to initialize the class on the code area in your IDE, you drop it on your layout, set up properties for it and you can then use Setters and Getters for it at runtime where necessary. Well for my case, I want to set everything on the abstract designer.  
  
Below, the drwoptions custom view is renderless, it wont create any HTML element, but I need a quick way whilst inside the designer to define what I want it to do and I can use its output into the contents of my list.  
  
I have attached herein an example of such. To explain this further, this will use an object array. In each object, I am telling this render-less that, the key for the title for example is title. Thus on the object array I will use it expects  
  

```B4X
m.put("title", "BVAD3")  
m.put("subtitle1", "Create Awesome WebApps")
```

  
  
etc etc.  
  
So this uses a Type Object and I just assign the data entered on the property bag to the Type object and retrieve it.  
  
![](https://www.b4x.com/android/forum/attachments/114187)