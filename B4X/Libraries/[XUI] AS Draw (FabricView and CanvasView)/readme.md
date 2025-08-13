###  [XUI] AS Draw (FabricView and CanvasView) by Alexander Stolte
### 04/28/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/115604/)

Hello,  
2 years ago i already had the idea of this view, but I failed in some places, but now I have taken up the challenge and the result is impressive.  
Inspired by [USER=47104]@Johan Schoeman[/USER] [FabricView](https://www.b4x.com/android/forum/threads/fabricview-make-your-own-drawings-writing-with-your-finger.66661/) and [CanvasView](https://www.b4x.com/android/forum/threads/canvasview.76588/).  
  
[SPOILER="Dependencies/Libraries you need for this view"]  
**B4J**: jXUI, JavaObject  
**B4A**: XUI  
**B4i**: iXUI  
[/SPOILER]  
**Features**  

- cross-platform compatible
- set a background image
- draw, erase or draw lines
- undo and redo
- clear all
- set color, thickness and background color
- enable or disable the drawing
- **import** and **export** the drawing for later use
- export the drawing as image or the complete view

![](https://www.b4x.com/android/forum/attachments/90896)  
Draw what you want  
![](https://www.b4x.com/android/forum/attachments/90899)  
use a eraser  
![](https://www.b4x.com/android/forum/attachments/90900)  
set a background image  
![](https://www.b4x.com/android/forum/attachments/91567)  
draw lines  
![](https://www.b4x.com/android/forum/attachments/91738)  
**Examples**  

```B4X
    Dim Out As OutputStream  
    Out = File.OpenOutput(File.DirApp, "Test.png", False)  
    ASDraw1.ImageComplete.WriteToStream(Out, 100, "PNG")  
    Out.Close
```

  
**AS Draw  
Author: Alexander Stolte  
Version: 1.08**  

- **ASDraw**

- **Events:**

- **Touch** (Action As Int, XY As Map)

- **Functions:**

- **BackgroundImage\_setImage** (image As B4XBitmap, KeepAspectRatio As Boolean) As String
*sets a background image*- **Class\_Globals** As String
- **Clear** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **DrawMode\_DRAW** As String
- **DrawMode\_ERASE** As String
- **DrawMode\_LINE** As String
- **ExportDrawing** As List
*export the drawing as list to import this later or to save it for later use, for example: the user make a break*- **getBackgroundColor** As Int
*gets or sets the View Background Color*- **getBackgroundImage** As B4XBitmap
*gets the background image*- **getDrawMode** As String
- **getEnable** As Boolean
*gets or sets the draw enable, if false then the touch event is ignored*- **getImage** As B4XBitmap
*gets the drawing as image*- **getImageComplete** As B4XBitmap
*gets the complete view as image*- **getStrokeColor** As Int
*gets or sets the color of the draw line*- **getStrokeWidth** As Float
*gets or sets the thickness of the draw line*- **ImportDrawing** (drawings As List, new As Boolean) As String
*import a exported list of drawings  
 new: if false then the items in the list are added to the existing ones  
 new: if true then the intern list is reset*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Redo** As String
- **setBackgroundColor** (color As Int) As String
- **setDrawMode** (mode As String) As String
- **setEnable** (enable As Boolean) As String
- **setStrokeColor** (color As Int) As String
- **setStrokeWidth** (width As Float) As String
- **Undo** As String

- **Properties:**

- **BackgroundColor** As Int
*gets or sets the View Background Color*- **BackgroundImage** As B4XBitmap [read only]
*gets the background image*- **DrawMode** As String
- **Enable** As Boolean
*gets or sets the draw enable, if false then the touch event is ignored*- **Image** As B4XBitmap [read only]
*gets the drawing as image*- **ImageComplete** As B4XBitmap [read only]
*gets the complete view as image*- **StrokeColor** As Int
*gets or sets the color of the draw line*- **StrokeWidth** As Float
*gets or sets the thickness of the draw line*
**ToDo's  
  
Changelog**  

- **1.0**

- Release

- **1.01**

- Fix B4J Draw Bug
- Fix Import
- Fix Resize

- **1.02**

- Add Property BackgroundImage\_setImage - sets a background image behind the drawing
- Add Property BackgroundImage - gets the background image
- Add Event Touch

- **1.03**

- Add new mode to DrawMode: Line
- ![](https://www.b4x.com/android/forum/attachments/91738)

- **1.04**

- Bug Fixes

- **1.05**

- Add CropImageOnExport - exports the image with its dimensions and from the painted

- **1.06**

- Add RotateImage - rotate the background image to the degree you want

- **1.08**

- BugFix better resize handling with background images
- Intern Function IIF renamed to iif2

- **1.09**

- BugFix - ExportDrawing
- Intern Function iif2 replaced with the core iif function

- **1.10**

- BugFixes

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)