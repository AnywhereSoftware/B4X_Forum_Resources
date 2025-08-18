### [BANanoCVC] Creating BANano Libraries in 7 Steps by Mashiane
### 10/04/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/120141/)

Ola  
  
[Download](https://github.com/Mashiane/BANano-Custom-View-Creator)  
  
A BANano library is a b4xlib that has custom views that one can use to create the websites and or webapps. As BANAno is front end platform independent, one can use any front-end platform they need. We will use the BANanoCVC i.e. BANano Custom View Creator to do this!  
  
For this exercise **we will just create a single custom view and a single layout** to demonstrate how one can create custom views for their library and then compile this into a library that they can use. To achieve this we will use the [BANAno Custom View Creator](https://www.b4x.com/android/forum/threads/banano-creating-banano-custom-views-with-the-banano-custom-view-creator-webapp.120086/).  
  
For this example, **we will assume that we want to wrap Bootstrap** for BANano as our choice of front end to use. For this we will need the [Bootstrap resources](https://getbootstrap.com/docs/4.5/getting-started/introduction/). These include the css and js files listed on their site.  
  
When you are done with this tutorial, you would have created these alerts without writing any HTML.  
  
![](https://www.b4x.com/android/forum/attachments/97084)  
  
So lets the Bootstrap resources listed below…  
  
![](https://www.b4x.com/android/forum/attachments/97072)  
  
**Step 1**  
  
We will create a B4J project and then add these resources. These resources can be added using the exact paths listed above, or one can download the resources and add them via the files tab of their b4j project and then refer them.  
  
In my case as a l wont be online all the time, I have downloaded these resources and added them to my project.  
  
**Step 2**  
  
So I update my AppStart to reflect these as indicated below.  
  

```B4X
Sub AppStart (Form1 As Form, Args() As String)   
    ' you can change some output params here  
    BANano.Initialize("BANano", LibName, Version)  
    BANano.Header.Title = LibTitle  
   
    'BANano.Header.AddCSSFile("fontawesome.min.css")  
    'BANano.Header.AddCSSFile("roboto.min.css")  
    BANano.Header.AddCSSFile("bootstrap.min.css")  
    '  
    'BANano.Header.AddJavascriptFile("fileSaver.min.js")  
    BANano.Header.AddJavascriptFile("jquery-3.5.1.slim.min.js")  
    BANano.Header.AddJavascriptFile("popper.min.js")  
    BANano.Header.AddJavascriptFile("bootstrap.min.js")  
               
    ' start the build  
    #if release  
        BANano.BuildAsB4Xlib(Version)  
    #else  
        BANano.Build(File.DirApp)  
    #end if  
   
    ExitApplication  
End Sub
```