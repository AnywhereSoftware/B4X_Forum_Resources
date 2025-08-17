###  [XUI] xRotaryKnob class by klaus
### 01/14/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/96045/)

The xRotaryKnob Class is a B4X libary.  
NEW The demo project is a B4XPages project.  
The zip file contains the B4XPages project.  
It works on all three platforms: B4A, B4i and B4J.  
The xRotaryKnob.b4xlib and the xRotaryKnob.xml files are attached.  
You need to copy the xRotaryKnob.b4xlib file to the AdditionlLibraries\B4X folder!  
Don’t copy the xRotaryKnob.xml file to the AdditionalLibraries folder, copy it in another folder for all b4xlib xml files.  
Example: AdditionlLibraries\B4XlibXMLFiles  
The xRotaryKnob.xml file is for help purposes only and is useful with the B4X [Help Viewer](https://www.b4x.com/android/forum/threads/b4x-help-viewer.46969/) or the [B4XObjectBrowser](https://www.b4x.com/android/forum/threads/b4a-b4i-b4j-and-b4r-api-documentation-b4x-object-browser.25682/#content).  
The xRotaryKnob.xml was generated with this tool: [b4xlib - XML generation](https://www.b4x.com/android/forum/threads/b4x-xml2map-simple-way-to-parse-xml-documents.74848/)  
  
After a request from [HERE](https://www.b4x.com/android/forum/threads/rotary-knob-post.95626/#content), I made it as a XUI challenge.  
You can turn the button, and it snaps onto the nearest value.  
A click in the middle selects the next value, a LonkClick in the middle selects the prevous value.  
There are three snap modes:  
AFTERMOVE snaps when the knob is released, upper left knob.  
ALLWAYS snaps allways during moving, the lower green knob.  
NEVER doesn't snap at all, displays the current value.  
  
**Custom button images**:  
There are two conditions for these images:  
- if the button is not a circle, the background must be a color and not transparent  
- the reference point must be at the right or the arrow must point to the right, geometric angle ZERO or 3 o'clock.  
  
EDIT: 2024.01.04 Version 1.8  
Added ValueChanged event when the Value is set by code  
  
EDIT: 2023.08.10 Version 1.7  
Added ValueChanged event for all SnapModes  
Attention: Changed the Value variable type in the ValueChanged event from Int To Double  
If you use the ValueChanged event you need to change it in your projects !  
Amended problem of highlighted scale value  
The demo project is now a B4XPages project !  
  
EDIT: 2021.04.02 Version 1.6  
Added HandleLineColor property  
Amended error with mAngle0 and B4i  
  
EDIT: 2020.06.23 Version 1.5  
Added following properties:  
SnapToZero when True snaps to ZERO after releasing the knob.  
If there is no ZERO position in the scale, it snaps to the position nearest to ZERO.  
The duration of the snap can be set with the SnapToZeroDuration property  
SnapToZeroDuration in milliseconds.  
Updated the Tag property according to Erels recommendation:  
<https://www.b4x.com/android/forum/threads/b4x-how-to-get-custom-view-here-from-clv-or-any-other-container.117992/#post-738358>  
  
EDIT: 2019.04.09 Version 1.4  
Amended CustomKnobFileName property variable type.  
  
EDIT: 2019.04.09 Version 1.3  
Added Visible property.  
  
EDIT: 2019.04.08 Version 1.2  
Added Value property, allowing to preset the knob.  
  
EDIT: 2019.01.27 Version 1.1  
Added CustomKnob and CustomKnobFileName properties.  
Allows to use a bitmap for the knob image.  
  
![](https://www.b4x.com/android/forum/attachments/76798)  
  
[SIZE=4]**xRotaryKnob Version: 1.8**[/SIZE]  

- [SIZE=4]**xRotaryKnob**[/SIZE]


- [SIZE=4]**Events:**[/SIZE]

- **ValueChanged** (Value As Int)

- [SIZE=4]**Functions:**[/SIZE]

- **AddToParent** (Parent As B4XView, Left As Double, Top As Double, Width As Double, Height As Double) As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- [SIZE=4]**Properties:**[/SIZE]

- **BackgroundColor** As Int
*gets or sets the BackgroundColor property*- **CustomKnob** As Boolean
gets or sets the CustomKnob property
CustomKnob with a Bitmap.
The file must be in File.DirAsset- **CustomKnobFileName** As String
gets or sets the CustomKnobFileName property
CustomKnob Bitmap file name
Valid only with CustomKnob = True
The file must be in File.DirAsset- **HighlightTextColor** As Int
*gets or sets the HighlightTextColor property*- **KnobBorderColor** As Int
*gets or sets the KnobBorderColor property*- **KnobColor** As Int
*gets or sets the KnobColor property*- **Left** As Double
*gets or sets the Left property*- **LineColor** As Int
*gets or sets the LineColor property*- **OffsetAngle** As Int
*gets or sets the OffsetAngle property*- **ScaleMaxValue** As Int
*gets or sets the ScaleMaxValue property*- **ScaleMinValue** As Int
*gets or sets the ScaleMinValue property*- **ScaleNbValues** As Int
*gets or sets the ScaleNbValues property*- **SnapMode** As String
*gets or sets the SnapMode property  
 possible values:  
 AFTERMOVE the knob snaps only when the knob is released, default value.  
 ALLWAYS the knob snaps during moving.  
 NEVER the knob doesn't snap at all, it displays the current position.*- **SnapToZero** As Boolean
*sets or gets the SnapToZero property of the knob  
 When True snaps to the ZERO position after releasing the knob  
 If there is no ZERO position in the scale, it snaps to the position nearest to ZERO  
 The duration of the snap can be set with the SnapToZeroDuration property*- **SnapToZeroDuration** As Int
*sets or gets the SnapToZeroDuration property of the knob*- **TextColor** As Int
*gets or sets the TextColor property*- **Top** As Double
*gets or sets the Top property*- **Value** As Int
gets or sets the Value property, allows to preset the knob to a given value- **Visible** As Boolean
gets or sets the Visible property- **Width** As Double
*gets or sets the Width property  
 there is no Height property because the object is square*
- [SIZE=4]**Author: Klaus CHRISTL (klaus)**[/SIZE]