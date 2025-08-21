### CarouselView - a Carousel for displaying images by Johan Schoeman
### 09/01/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/64865/)

A wrapper for [**this Github project**](https://github.com/sayyam/carouselview). posting the following:  
1. B4A library files - copy them to your additional library folder  
2. B4A project to demonstrate the library  
  
**You will need to have android-support-v4.jar in your additional library folder. You can download it from here:**  
<https://www.dropbox.com/s/qmggn0wm5a6bqa9/android-support-v4.jar?dl=0>  
  
It can used in Auto or Manual mode to display the images that were added to the carousel. It has a nice page indicator that can be customised (outline color, circle size, fill color, etc)  
  
![](https://www.b4x.com/android/forum/attachments/42573)  
  
![](https://www.b4x.com/android/forum/attachments/42574)  
  
Sample Code:  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: CarouselView  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#AdditionalRes: ..\Resources  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
    Private cv1 As CarouselView  
   
    Dim bm As Bitmap  
    Dim blist As List                               'images to be passed to the library via this list  
   
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
     Activity.LoadLayout("main")  
   
     blist.Initialize                                     'initialize an empty list  
   
     bm.Initialize(File.DirAssets, "image_1.jpg")  
     blist.Add(bm)                                        'add the image to the list  
     bm.Initialize(File.DirAssets, "image_2.jpg")  
     blist.Add(bm)  
     bm.Initialize(File.DirAssets, "image_3.jpg")  
     blist.Add(bm)  
     bm.Initialize(File.DirAssets, "image_4.jpg")  
     blist.Add(bm)  
     bm.Initialize(File.DirAssets, "image_5.jpg")  
     blist.Add(bm)                 
   
     cv1.ImageBitmaps = blist                              'pass the list with images to the library  
  
     cv1.Radius = 10                                       'the radius of the indicator circles  
     cv1.StrokeColor = Colors.Magenta                      'the outline color of the circles  
     cv1.StrokeWidth = 5                                   'the width of the outline circles  
     cv1.FillColor = Colors.White                          'the color to fill the circles with - active page/image  
     cv1.AutoPlay = True                                   'play automatically?  
     cv1.CurrentItem = 0                                   'set the indeks of where to initially start from: 0 to (number of image - 1)  
     cv1.DisableAutoPlayOnUserInteraction = True           'stop auto play if image is touched during autoplay  
     cv1.Orientation = cv1.ORIENTATION_HORIZONTAL          'can also be ORIENTATION_VERTICAL in which case it will be position to the left of the CarouselView  
     cv1.PageCount = blist.Size                            'the number of pages/images to display  
     cv1.PageColor = Colors.Transparent                       'the color in the centre of the indicator circles for "not active" pages  
     cv1.SlideInterval = 1000                              'the slide interval in milli seconds  
   
     cv1.playCarousel                                      'kickstart the carousel into action  
   
     ' there is also cv1.pauseCarousel that can be used to pause the carousel  
  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub
```

  
  
Library:  
  
**CarouselView  
Author:** Github: Sayyam Mehmood, Wrapped by: Johan Schoeman  
**Version:** 1  

- **CarouselView**
Fields:

- **ORIENTATION\_HORIZONTAL As Int**
- **ORIENTATION\_VERTICAL As Int**
- **ba As BA**

**Methods:**

- **BringToFront**
- **DesignerCreateView** (base As PanelWrapper, lw As LabelWrapper, props As Map)
- **Initialize** (EventName As String)
- **Invalidate**
- **Invalidate2** (arg0 As Rect)
- **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **IsInitialized As Boolean**
- **RemoveView**
- **RequestFocus As Boolean**
- **SendToBack**
- **SetBackgroundImage** (arg0 As Bitmap)
- **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
- **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
- **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)
- **pauseCarousel**
*Stops auto scrolling.*- **playCarousel**
*Starts auto scrolling if*
**Properties:**

- **AutoPlay As Boolean** *[write only]*
Set interval for one slide in milliseconds.- **Background As Drawable**
- **Color As Int** *[write only]*
- **CurrentItem As Int** *[write only]*
- **DisableAutoPlayOnUserInteraction As Boolean** *[write only]*
- **Enabled As Boolean**
- **FillColor As Int** *[write only]*
- **Height As Int**
- **ImageBitmaps As List** *[write only]*
- **Left As Int**
- **Orientation As Int** *[write only]*
- **PageColor As Int** *[write only]*
- **PageCount As Int** *[write only]*
- **Parent As Object** *[read only]*
- **Radius As Float** *[write only]*
- **SlideInterval As Int** *[write only]*
Set interval for one slide in milliseconds.- **Snap As Boolean** *[write only]*
- **StrokeColor As Int** *[write only]*
- **StrokeWidth As Float** *[write only]*
- **Tag As Object**
- **Top As Int**
- **Visible As Boolean**
- **Width As Int**