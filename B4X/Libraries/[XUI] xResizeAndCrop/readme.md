###  [XUI] xResizeAndCrop by klaus
### 01/14/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/100109/)

The xResizeAndCrop Class is a B4X libary.  
Current version 1.8  
  
It works on all three platforms: B4A, B4i and B4J.  
The xResizeAndCrop.b4xlib and the xResizeAndCrop.xml files are attached.  
You need to copy the xResizeAndCrop.b4xlib file to the AdditionlLibraries\B4X folder!  
  
**Don’t copy the xResizeAndCrop.xml file to the AdditionalLibraries folder**, copy it in another folder for all b4xlib xml files.  
Example: AdditionlLibraries\B4XlibXMLFiles  
The xResizeAndCrop.xml file is for help purposes and is useful with the B4X [Help Viewer](https://www.b4x.com/android/forum/threads/b4x-help-viewer.46969/) or the [B4XObjectBrowser](https://www.b4x.com/android/forum/threads/b4a-b4i-b4j-and-b4r-api-documentation-b4x-object-browser.25682/#content).  
The xResizeAndCrop.xml was generated with this tool: [b4xlib - XML generation](https://www.b4x.com/android/forum/threads/b4x-xml2map-simple-way-to-parse-xml-documents.74848/)  
  
It is an evolution of the B4A project: [Resize and crop image](https://www.b4x.com/android/forum/threads/resize-and-crop-image.95001/#content).  
To make a B4X CustomView was inspired by this thread: [[B4X] [XUI] CropView.](https://www.b4x.com/android/forum/threads/b4x-xui-cropview.94952/#content)  
  
The demo program is a B4XPages project for all three platforms.  
Tested on PC, Android Samsung S6, iPhone 6.  
  
EDIT: 2023.03.28 Version 1.8  
Added the code to load an image for B4i.  
  
EDIT: 2023.03.28 Version 1.7  
Set the crop window to the entire image when the width / height ratio is NONE  
Only the xResizeAndCrop.b4xlib and the xResizeAndCrop.xml files have been replaced.  
  
EDIT: 2022.06.26 Version 1.6  
Added Circle and round corner crop  
Added RoundCorner and CornerRadius properties.  
The libary needs the BitmapCreator library.  
  
EDIT: 2020.07.15 Version 1.5  
Added the HandleDotWidth property  
  
EDIT: 2020.07.15 Version 1.4  
Amended error with CroppedImage without a CroppedView.  
  
EDIT: 2020.06.25 Version 1.3  
Updated the Tag property according to Erels recommendation:  
<https://www.b4x.com/android/forum/threads/b4x-how-to-get-custom-view-here-from-clv-or-any-other-container.117992/#post-738358>  
  
EDIT: 2019.03.12 Version 1.2  
Added WidthHeightRatio and WidthHeightRatioValue properties  
defining fixed or custom Width / Height ratios for the cropped image  
Added RotateImage method, original image rotation.  
  
EDIT: 2019.01.30 Version 1.1  
Added a Square property.  
When Square = True then the resized image is always square.  
  
![](https://www.b4x.com/android/forum/attachments/140675)  
  
**xResizeAndCrop  
  
Author:** Klaus CHRISTL (klaus)  
**Version: 1.8**  

- **xResizeAndCrop**

- **Events:**

- **CropFinished**

- **Functions:**

- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **LoadImage** (Dir As String, FileName As String) As String
*loads the given image file to the xResizeAndCrop Customview*- **RotateImage**(Degrees As Int)

- **Properties:**

- **CornerRadius** *As* Int
*sets or gets the CornerRadius property  
 the radius is expressed in % of the smalles side, max value = 50, min value = 0*- **CroppedImage** As B4XBitmap [read only]
*gets the cropped image as a B4XBitmap, read only*- **CroppedView**
*sets the Panel / Pane view for the cropped image, write only  
 the Panel / Pane view must be added in the main code and transmitted to the custom view as this property.*- **HandleDotWidth** As Int
*sets or gets the HanldeDotWidth property  
 it must be a dip value, default value 13dip*- **HandleColor** As Int
*sets or gets the HandleColor property  
 value must a xui color  
 Example code: <code>xResizeAndCrop1.HandleColor = xui.Color\_RGB(255, 215, 0)</code>*- **Height** As Int
*sets or gets the Height property*- **Image** As B4XBitmap
*sets the image (B4XBitmap) to the Customview, write only*- **Left** As Int
*sets or gets the Left property*- **MinCroppedHeight** As Int
*sets or gets the MinHeight property  
 value in pixels, no dip value  
 if Square = True, the min cropped width is set equal to this height value*- **MinCroppedWidth** As Int
*sets or gets the MinWidth property  
 value in pixels, no dip value  
 if Square = True, the min cropped height is set equal to this width value*- **RoundCorners**As Boolean
*sets or gets the RoundCorners property  
 rounds the corners with a radius equal to the CornerRadius property*- **Top** As Int
*sets or gets the Top property*- **Visible** As Boolean
*sets or gets the Visible property*- **Width** As Int
*sets or gets the Width property*- **WidthHeightRatio** As String
*sets or gets the WidthHeightRatio property  
 possible values: None Square 3/2 2/3 4/3 3/4 16/9 9/16 Custom  
 None = any width and height  
 Square = True means that the resized image is always square  
 3/2 = ratio 1.5  
 2/3 = ratio 0.6667  
 4/3 = ratio 4/3  
 3/4 = ratio 3/4  
 16/9 = ratio 16/9  
 9/16 = ratio 9/16  
 Custom = user defined ratio set in the WidthHeightRatioValue property*- **WidthHeightRatio** As Double
*sets or gets the WidthHeightRatioValue property  
 only active if the WidthHeightRatio property is set to "Custom"*