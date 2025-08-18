###  [XUI] Cross platform & native UI library by Erel
### 03/01/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/84359/)

**Update: The designer was updated since the tutorial was written. It is now possible to declare views as B4XView from the designer and it is also possible to copy and paste views between the three platforms.**  
  
Video tutorial:  
  
[MEDIA=vimeo]255908723[/MEDIA]  
  
The purpose of XUI library is to make it easier to share code between B4A, B4J and B4i projects.  
It is an important new library and I expect that all B4X developers who target more than a single platform will use it at some point.  
  
Two main concepts:  
- XUI libraries API is the same between all three libraries.  
- It is very simple to switch between the XUI objects and the native objects when needed.  
  
The second point is important. XUI types provide a different "view" or a different wrapper above the same native objects. They do not replace the native types.  
There are some new features provided in the libraries which you can use even if you target a single platform.  
  
Example of CustomListView class that is supported by B4A, B4i and B4J:  
  
![](https://www.b4x.com/basic4android/images/SS-2017-09-27_11.15.59.png) ![](https://www.b4x.com/basic4android/images/SS-2017-09-27_11.16.26.png) ![](https://www.b4x.com/basic4android/images/SS-2017-09-27_11.16.50.png)  
  
The main type in XUI is [B4XView](https://www.b4x.com/android/help/xui.html#b4xview).  
Any view or node can be assigned to a B4XView variable.  
The B4XView type includes all the common methods, including methods that are not available in all types.  
See the methods documentation for more information.  

```B4X
Dim xlbl As B4XView = Button1  
xlbl.Text = "Click!"  
Dim b As Button = xlbl
```

  
  
**Steps to writing cross platform solutions:**  
  
1. Use the designer to build the interface. The designer hides many of the differences between the platforms. Make sure to use anchors and designer script to handle different screen sizes.  
  
2. Use B4XViews whenever possible and whenever it makes sense. You can change the types of views added with the designer to B4XView:  

```B4X
Sub Globals  
   Private clv1 As CustomListView  
   Private clv2 As CustomListView  
   Private Label1 As B4XView '<— manually change to B4XView or change with the designer.  
   Private CheckBox1 As B4XView  
End Sub
```

  
3. Switch to the native types when needed. You can use the built-in conditional compilation symbols for this:  

```B4X
#If B4A  
Dim nCheckBox1 As CheckBox = CheckBox1  
nCheckBox1.Ellipsize = "END" 'no such property in B4XView  
#Else If B4i  
Dim nCheckBox1 As Switch = CheckBox1  
nCheckBox1.TintColor = Colors.Red  
#End If  
CheckBox1.Checked = True  
'B4XView.Checked works with:  
'B4A: CheckBox, RadioButton, ToggleButton and Switch  
'B4i: Switch  
'B4J: CheckBox, RadioButton and ToggleButton
```

  
  
Other types available:  
  
- [B4XBitmap](https://www.b4x.com/android/help/xui.html#b4xbitmap) - Wrapper for Bitmap (B4A, B4i) and Image (B4J). Adds all the features available in B4A and B4i Bitmap type to B4J (Resize, Crop, Rotate and saving as Jpeg).  
- [XUI](https://www.b4x.com/android/help/xui.html#xui) - This type holds various methods to help writing cross platform code.  
For example SubExists in B4i expects another parameter (the number of arguments). XUI.SubExists adds this parameter. The parameter is not used in B4J and B4A.  
It includes a DefaultFolder property as well as other useful methods.  
  
**Notes & tips**  
  
- In almost all cases you can just change the variable type from the native view to B4XView. One place where you cannot is in views passed from events. In such cases you need to change the type to Object (if you want it to be cross platform compatible).  
This is the case with DesignerCreateView sub:  

```B4X
'B4A / B4i:  
Public Sub DesignerCreateView(base As Panel, lbl As Label, props As Map)  
'B4J:  
Public Sub DesignerCreateView(base As Pane, lbl As Label, props As Map) 'Pane instead of Panel  
'Cross platform:  
Public Sub DesignerCreateView(base As Object, lbl As Label, props As Map)  
Dim mbase As B4XView = base
```

  
  
- The B4J library uses [imgscalr](https://github.com/rkalla/imgscalr) open source code for the bitmap manipulation. It is superior to ImageView resize algorithm.  
- Some of the new features that are not available in the core libraries and can be used without relation to the cross platform features:  

- B4XView.Snapshot (new in B4A and B4i) - Captures the view appearance and returns a B4XBitmap.
- B4XView.SetVisibleAnimated (new in B4J and B4i).
- B4XView.Color (new in B4A and B4J) - Gets the color value if it available.
- B4XView.SetColorAnimated (new in B4J).
- B4XBitmap.Crop / Resize / Rotate / WriteToStream (new in B4J)

- Events are not modified. This means that the event subs will need to be different in many cases. You can see how it is handled in CustomListView class. The platform specific event subs call a shared sub.  
- There are some missing features like dialogs and canvas. They will be added.  
- The libraries require B4A v7.3+, B4i v4.3+ and B4J v5.9+.  
- XUI is compatible with Android 4+ (API level 14+).  
  
**Examples**  
  
xCustomListView: <https://www.b4x.com/android/forum/threads/84501>  
Calculator example: <https://www.b4x.com/android/forum/threads/b4x-xui-cross-platform-native-ui-library.84359/#post-534536>  
Badger class: <https://www.b4x.com/android/forum/threads/b4x-class-badger-add-badges-to-views.81723/>  
CircularProgressBar: <https://www.b4x.com/android/forum/threads/b4x-xui-custom-view-circularprogressbar.81604/>  
  
And more: <https://www.b4x.com/search?query=[xui]>  
  
**Change log:  
  
XUI libraries are now internal libraries. Use the one preinstalled with the IDE.**