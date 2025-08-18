###  B4XDrawer - sliding drawer by Erel
### 12/08/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/97828/)

**Edit: Cross platform example based on B4XPages** <https://www.b4x.com/android/forum/threads/b4x-b4xpages-b4xdrawer.120246/>  
  
![](https://www.b4x.com/basic4android/images/b4adrawer.gif)  
  
![](https://www.b4x.com/basic4android/images/SS-2018-10-03_17.51.11.png)  
  
A class that implements a sliding menu. Unlike the nice [jfeinstein SlidingMenu library](https://www.b4x.com/android/forum/threads/36482/#content) the drawer covers the activity instead of pushing it. It is similar to the various design support navigation drawer libraries.  
  
Instructions:  
1. Initialize the drawer object:  

```B4X
Drawer.Initialize(Me, "Drawer", Activity, 300dip) 'Page1.RootPanel in B4i
```

  
300dip = left menu width  
  
2. Load the "Activity layout" to the drawer:  

```B4X
Drawer.CenterPanel.LoadLayout("1")
```

  
3. Load the menu layout:  

```B4X
Drawer.LeftPanel.LoadLayout("Left")
```

  
4. Handle back key (B4A):  

```B4X
Sub Activity_KeyPress (KeyCode As Int) As Boolean  
   If KeyCode = KeyCodes.KEYCODE_BACK And Drawer.LeftOpen Then  
       Drawer.LeftOpen = False  
       Return True  
   End If  
   Return False  
End Sub
```

  
  
5. Handle resize (B4i):  

```B4X
Private Sub Page1_Resize(Width As Int, Height As Int)  
   Drawer.Resize(Width, Height)  
End Sub
```

  
  
The attached example is based on AppCompat. However you can use it in any project you like. You can also customize its behavior. The code is not too complicated.  
  
Updates:  
  
- 1.55 - New StateChanged (Open As Boolean) event.  
- 1.53 - Adds support for B4J (without gestures). No need to update if using with B4A or B4i.  
- 1.52 - Clicks on the drawer panel are not passed to the underlying panel.  
- 1.51 - GestureEnabled property.  
  
B4XDrawer is distributed as a b4xlib. **It is an internal library.**