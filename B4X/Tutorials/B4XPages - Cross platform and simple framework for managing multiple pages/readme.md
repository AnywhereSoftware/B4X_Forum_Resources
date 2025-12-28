###  B4XPages - Cross platform and simple framework for managing multiple pages by Erel
### 12/25/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/118901/)

[MEDIA=vimeo]440642051[/MEDIA]  
  
B4XPages is a library that serves two purposes:  
  
1. Make it simple to develop B4A apps by solving almost all of the challenges involved with Android complex activities life cycle.  
B4XPages makes B4A behave more similar to B4J and B4i where the new "B4XPage" element is a regular object that is never paused, never destroyed, can be accessed from anywhere and easy to work with.  
2. Provide a cross platform layer above the navigation related APIs.  
  
Before we start:  
  
1. You are not forced to use B4XPages. All the current features behave exactly as before.  
2. It does have some limitations. One notable limitation is that in B4A, the activity that holds all the pages should be locked to a single orientation.  
3. It is supported by the latest versions of B4J, B4i and B4A.  
  
 ![](https://www.b4x.com/basic4android/images/nVw98yQ97c.gif)  
(video from B4i)  
  
What exactly does it solve?  
  
Here: <https://www.b4x.com/android/forum/threads/b4x-b4xpages-what-exactly-does-it-solve.119078/>  
  
What is a B4XPage?  
  
It differs between the three platforms:  
B4J - Form  
B4i - Page in a single NavBarController  
B4A - Panel in a single activity.  
  
Lets start:  
  
1. File - New Project - B4XPages. This will create three projects with everything you need. Use it even if you are only interested in a single platform.  
  
2. Each page is implemented in its own class. The class template is very simple and looks like this:  

```B4X
Sub Class_Globals  
    Private Root As B4XView 'ignore  
    Private xui As XUI 'ignore  
End Sub  
  
Public Sub Initialize  
  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    'load the layout to Root  
  
End Sub
```

  
3. There must be one class named B4XMainPage. This page will usually be the first one to be displayed.  
4. B4XPage\_Created event is raised when a page is created, this will happen before it is displayed for the first time. Note that pages are never destroyed.  
This is the place to load the layout.  
5. The way to access the various B4XPages related features is with B4XPages, an internal code module.  
6. Each page is identified with a case insensitive string id. The main page id is "MainPage".  
7. Example of adding a page:  

```B4X
Dim Page2 As B4XPage2  
Page2.Initialize  
B4XPages.AddPage("Page 2", Page2)
```

  
8. Example of showing a page:  

```B4X
B4XPages.ShowPage("Page 3")
```

  
9. As the pages instances are regular objects there are many simple ways to access them. One simple way is with B4XPages.GetPage:  

```B4X
Page3 = B4XPages.GetPage("Page 3")  
Page3.Button1.Text = "abc"
```

  
10. Several methods expect a B4XPage object. In most cases, you will pass Me:  

```B4X
B4XPages.SetTitle(Me, "Draw Something")
```

  
11. You can see the list of events by writing: Sub + space + tab and choosing B4XPageManager. The event name is always B4XPage.  
12. The pages context will not be paused or destroyed, until the process itself is killed.  
13. There is a field named B4XPages.GlobalContext. The use case behind it is with a class instance that is initialized in Service\_Create of the starter service. This can be a good place to implement tasks that can also run in the background.  
  
  
B4XPages is an internal library.  
B4XPages related discussions: <https://www.b4x.com/android/forum/pages/results/?query=b4xpages>