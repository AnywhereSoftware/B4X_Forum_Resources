### A vertical and horizontal scrollable Panel/Layout by Guenter Becker
### 11/13/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/157375/)

Version 1.1 / 2023 - UPDATED  
  
Sometimes the layout size is bigger than your App window this rises the need to attach scrolling/swiping to the layout.  
  
This CustomView solves this problem.  

- Show Layouts bigger than App Window by adding vertical and horizontal scrolling.
- Automatic detect needed Layout width and hight by child views of the Layout.
- Published HScrollview and VScrollview Object
- Published Events of the Scrollviews

**Custom Designer Properties:**  
*Layout File*, the filename of the layout that hosts the views.  
*Oversize*, Value is in 1/10%. Adds extra space at width and height to insure that all views are visible.  
  
**Custom Properties:**  
*LayoutFile*, set/load the layout file  
*HScrollview*, public Horizontal Scrollview Object (Inner Panel is hosting the layout)  
*VScrollview*, public Vertical Scrollview  
  
The attached Example Project includes the CustomView as readable class for examinating the code.  
  
**Installation**:  
Copy *TD\_SwipePanel.b4xlib* to your additional libraries folder.  
Activate Library *Scrollview2D* ( get it here: <https://www.b4x.com/android/forum/threads/lib-scrollview2d.19268/#content>)  
  
**Usage****:**  

1. Activate *TD\_swipePanel* in the libraries window.
2. Drag CustomView in the Designer onto the windowpage and resize it.
3. Fill in the Filename in the Designer Custom Property *Layout Filename* or from code call Custom Property *LayoutFile* to load the Layout like *TD\_SwipePanel1.LayoutFile = "ABC.bal"*.
4. Grab TD\_SwipePanel Events in the parent page as *TD\_SwipePanel1\_HScrollChanged(Position as Int) / TD\_SwipePanel1\_VScrollChanged(Position as Int)*