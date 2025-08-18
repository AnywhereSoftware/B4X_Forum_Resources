### ScaleImageView - Pan and zoom large images by agraham
### 02/18/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/102190/)

My main reason to restart using B4A was to implement on a mobile device my mapping program which covers the entire UK at various scales and requires the ability to display large map images at a specified zoom level and centered on a specified coordinate and then allow the user to drag and zoom the map.  
  
For some strange reason if you set targetSdkVersion="xx" to more than 13 in the manifest it dramatically reduces the largest Bitmap that can be created from a file so most of my map images then no longer open in TouchImageView, jsTouchImageView and even ImageView. These all rely on opening a full resolution bitmap to display an image. It seems to be a Canvas size limitation. Also I failed to get TouchImageView to reliably pre-zoom and pre-position an image so I struggled on with jsTouchImageView and targetSdkVersion="13" and got an acceptable working version but pre-zooming and pre-positioning at an exact point was a bit problematic and not entirely accurate but usually close enough after a few heuristics. It also still used very large amounts of memory for the decoded bitmap.  
  
Having got the app working I then started looking to try to finally solve the image viewing problems and found some source code on GitHub that was written for just this purpose. Instead of loading the entire image at once it only fully decodes from the image file the areas needed for display. As a bonus the pre-zooming and centering is very accurate and works a treat. So after a bit of difficulty getting it to compile I wrapped it, slightly enhanced to draw a centered point indication and am now extremely happy with my mapping program that can now display huge images and target SDK version 26 and later without using a vast amount of memory.  
  
There is a ScaleImageView.htm file in the attached archive that documents the extremely simple API posted below. As always do what readme.txt says.  
  
I can't put a large image file in the archive as it becomes too big to upload here, so find your own large image and do as Readme.txt says.  
**ScaleImageView**  
*This is a custom image view designed for displaying huge images.  
It includes all the standard gestures for zooming and panning images  
and provides some extra useful features for animating the image position and scale.  
The aim of this library is to solve some of the common problems when displaying large images in Android.  
This view extends View and so inherits all the normal View methods.  
This view doesn't extend ImageView and isn't intended as a general purpose replacement for it.  
It is specialised for the display of photos and other large images, not the display of 9-patches,  
shapes and the other types of drawable that ImageView supports.   
Supported gestures are:  
One finger drag to pan, Two finger pinch to zoom and double tap to zoom in and out.  
Pan while zooming, seamless switch between pan and zoom and fling momentum after panning.  
Quick scale (one finger zoom - quick double tap then drag)   
Events Click and LongClick are provided whose co-ordinates may be accessed in the event code.  
ClickViewX, ClickViewY return the position of the Click or LongClick on the view.  
ClickImageX and ClickImageY return the position of the Click or LongClick on the source image.  
The OnDraw event provides a Canvas that can be used to draw on the view whenever it is redrawn.  
The view can draw a circle at a defined position on the original image.  
The circle can either have a fixed size that is a fraction of the screen width  
or a variable size that always covers the same area of the original size as it is zoomed.  
The associated file, ScaleImage.jar, must be located in the Additional Libraries folder.  
The line '#AdditionalJar: ScaleImage' must be added to the Main module.  
This library uses code from   
<https://github.com/davemorrissey/subsampling-scale-image-view>  
That code and this library are licensed under the Apache License 2.0  
Copyright [2015] [Dave Morrissey]  
Copyright [2018] [Andrew Graham]  
Licensed under the Apache License, Version 2.0 (the "License")  
you may not use this file except in compliance with the License.  
You may obtain a copy of the License at  
<http://www.apache.org/licenses/LICENSE-2.0>  
Unless required by applicable law or agreed to in writing, software  
distributed under the License is distributed on an "AS IS" BASIS,  
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
See the License for the specific language governing permissions and  
limitations under the License.*  
**Author:** Andrew Graham  
**Version:** 2.3  

- **ScaleImageView**

- **Events:**

- **Click** 'The user has tapped on the view. Use ClickImage or ClickView for the coordinates.
- **LongClick** 'The user has long pressed the view. Use ClickImage or ClickView for the coordinates.
- **OnDraw** (viewcanvas As Canvas) 'The view is being redrawn. Use viewcanvas to draw on it.

- **Functions:**

- **BringToFront**
- **DesignerCreateView** (base As Panel, lw As Label, props As Map)
- **Initialize** (arg1 As String)
- **Invalidate**
- **Invalidate2** (arg0 As android.graphics.Rect)
- **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **IsInitialized** As Boolean
- **Recycle**
*Releases all resources the view is using and resets the state, nulling any fields that use significant memory.  
After you have called this method, the view can be re-used by setting a new image.  
 Settings are remembered but state (scale and center) is forgotten.*- **RemoveView**
- **RequestFocus** As Boolean
- **ResetScaleAndCenter**
*Zooms the image out to minimum scale and centers it on the screen according to the view's settings.*- **SendToBack**
- **SetBackgroundImage** (arg0 As android.graphics.Bitmap) As BitmapDrawable
- **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
- **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
- **SetScaleAndCenter** (scale As Float, x As Float, y As Float, duration As Int)
*Set the zoom of the displayed image and center it on the point (x,y).  
x and y are width and height factor values of the full image size between 0 and 1.  
PanLimit should be set to PAN\_LIMIT\_CENTER if any point is to be centered.  
Duration sets the duration of the transition in milliseconds.  
 Returns False if the image is not ready and the transition was not made otherwise True.*- **SetScaleAndCenterPixels** (scale As Float, x As Int, y As Int, duration As Int) As Boolean
*Set the zoom of the displayed image and center it on the point (x,y).  
x and y are full image size x and y pixel values.  
PanLimit should be set to PAN\_LIMIT\_CENTER if any point is to be centered.  
Duration sets the duration of the transition in milliseconds.  
 Returns False if the image is not ready and the transition was not made otherwise True.*- **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)
- **SourceXYtoViewXY** (sourcex As Int, sourcey As Int) As Float()
*Returns a Float array containing the X and Y pixel position on the view of the specified point of the full size image.  
If the image coordinates are currently off screen, the view coordinates will also be outside the view  
 Index 0 of the array contains the X coordinate and index 1 the Y coordinate.*- **ViewXYtoSourceXY** (viewx As Int, viewy As Int) As Float()
*Returns a Float array containing the X and Y pixel position on the full size image of the specified point of the view.  
 Index 0 of the array contains the X coordinate and index 1 the Y coordinate.*
- **Properties:**

- **Background** As android.graphics.drawable.Drawable
- **CenterX** As Float [read only]
*Gets the X pixel value of the full image point which is at the centre of the view.  
 Can only be set programatically by SetScaleAndCenter or SetScaleAndCenterPixels*- **CenterY** As Float [read only]
*Gets the Y pixel value of the full image point which is at the centre of the view.  
 Can only be set programmatically by SetScaleAndCenter or SetScaleAndCenterPixels*- **CircleColor** As Int
*Gets or sets the colour of the inner ring of the circle.  
 The default is 0xff20b2aa - LightSeaGreen.*- **CircleDrawnRadius** As Float [read only]
*Gets the radius of the circle in pixels as last drawn regardless of the state of EnableCircleScale.  
 This can be used to position other drawn items relative to the circle.*- **CircleMinimumRadius** As Float
*Gets or sets the minimum radius of the circle as a factor between 0 and 1 of the width of the view.  
This prevents the circle being drawn vanishingly small when zoomed out if EnableCircleScale is True.  
 The default is 0.02.*- **CircleRadius** As Float
*Gets or sets the radius of the circle as a factor between 0 and 1 of the width of the view or of the full image.  
If EnableCircleScale is True the factor is that of the full size image width.  
If EnableCircleScale is False the factor is that of the width of the view.  
 The default is 0.002 which is appropriate if EnableCircleScale is True.*- **CircleWidth** As Float
*Gets or sets the width of stroke used to draw the circle (not the radius).  
 The value is a factor between 0 and 1 of the radius of the circle as drawn. The default is 0.2.*- **CircleX** As Float
*Gets or sets the X position factor of the point on the full image at which to draw the circle.  
 The default is 0.5, the centre of the image.*- **CircleXPixels** As Float
*Gets or sets the X position in pixels of the point on the full image at which to draw the circle.  
 The default is the centre of the image.*- **CircleY** As Float
*Gets or sets the Y position factor of the point on the full image at which to draw the circle.  
 The default is 0.5, the centre of the image.*- **CircleYPixels** As Float
*Gets or sets the Y position in pixels of the point on the full image at which to draw the circle.  
 The default is the centre of the image.*- **ClickImageX** As Float [read only]
*When accessed in a Click or LongClick event gets the X pixel position on the full size image of the point clicked.*- **ClickImageY** As Float [read only]
*When accessed in a Click or LongClick event gets the Y pixel position on the full size image of the point clicked.*- **ClickViewX** As Float [read only]
*When accessed in a Click or LongClick event gets the X pixel position on the view of the point clicked.*- **ClickViewY** As Float [read only]
*When accessed in a Click or LongClick event gets the Y pixel position on the view of the point clicked.*- **Color** As Int [write only]
- **DoubleTapZoomDuration** As Int [write only]
*Sets the duration of a double tap zoom animation, in milliseconds. The default is 500ms.*- **EnableCircle** As Boolean
*Gets or sets whether a circle will be drawn at the image coordinates specified by CircleX and CircleY.  
 The default is False.*- **EnableCircleScale** As Boolean
*Gets or sets whether the size of the circle will increase and decrease when the image is zoomed.  
If True the circle will resize to bound the same features on the image whatever the zoom.  
If False the circle will maintain a fixed size on the screen of the device.  
 The default is True.*- **Enabled** As Boolean
- **Height** As Int
- **Image** As android.graphics.Bitmap [write]
*Load an existing Bitmap into the view.  
This is unsuitable for large images because it bypasses subsampling and may cause OutOfMemoryErrors.  
 This is an easy way to add pan and zoom functionality to an image already in memory*- **Image** As android.graphics.Bitmap [read]
*Returns a Bitmap containing the image presently displayed in the ScaleImageView*- **ImageFile** *As String [write only]*
*Load an image from a file saved on the device file system into the view.  
This method can display JPG and PNG images of any size.  
In order to support huge images without running out of memory, a sub-sampled base layer is first loaded.  
 Higher resolution tiles are loaded for the visible area as the user zooms in.*- **IsReady** As Boolean [read only]
*Gets whether the view is initialised, has dimensions and will display an image.  
 Returns True if the view is ready to display an image and accept touch gestures.*- **Left** As Int
- **MaxZoom** As Float
*Gets or set the maximum permitted zoom level of the displayed image. The default is 2.0.  
 The minimum zoom level is set automatically to fit the entire image to the view.*- **Orientation** As Int
*Gets or set the orientation of the image relative to the source file.  
 Valid values for orientation are 0, 90, 180, 270 and -1 or one of the ORIENTATION values.*- **ORIENTATION\_0** As Int [read only]
*Display the image file in its native orientation. Value is 0.*- **ORIENTATION\_180** As Int [read only]
*Rotate the image 180 degrees. Value is 180.*- **ORIENTATION\_270** As Int [read only]
*Rotate the image 270 degrees clockwise. Value is 270.*- **ORIENTATION\_90** As Int [read only]
*Rotate the image 90 degrees clockwise. Value is 90.*- **ORIENTATION\_USE\_EXIF** As Int [read only]
*Attempt to use EXIF information on the image to rotate it. Value is -1.*- **Padding** As Int()
- **PAN\_LIMIT\_CENTER** As Int [read only]
*Allow the image to be panned until a corner reaches the center of the screen but no further.  
 Useful when you need to pan any spot on the image to the exact center of the screen.*- **PAN\_LIMIT\_INSIDE** As Int [read only]
*Don't allow the image to be panned off screen.  
 As much of the image as possible is always displayed, centered in the view when it is smaller.*- **PAN\_LIMIT\_OUTSIDE** As Int [read only]
*Allow the image to be panned until it is just off screen, but no further.  
 The edge of the image will stop when it is flush with the screen edge.*- **PanLimit** As Int [write only]
*Sets the image pan limit to one of the PAN\_LIMIT values.  
 The default is 3 = PAN\_LIMIT\_CENTER.*- **Parent** As Object [read only]
- **Scale** As Float [read only]
*Get the current scale of the image as set by the user.  
 Can only be set programmatically by SetScaleAndCenter or SetScaleAndCenterPixels.*- **SrcHeight** As Int [read only]
*Get the height of the current full size image in pixels.  
 Note that this does not take the applied rotation into account.*- **SrcWidth** As Int [read only]
*Get the width of the current full size image in pixels.  
 Note that this does not take the applied rotation into account.*- **Tag** As Object
- **TileBackgroundColor** As Int [write only]
*Default none. Renders a background color behind tiles. Useful when rendering a transparent PNG.  
Note: transparent PNGs require double the memory of PNGs with no alpha layer, and may cause out of memory errors.  
 The default is none.*- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

  
  
EDIT: Version 2.00 now posted. ScaleImageView is now a Custom View. The API above has been updated. See Post #3 below for more details.  
EDIT: Version 2.20 now posted. The API above has been updated. See Post #36 below for more details.  
EDIT: Version 2.30 now posted. A readable Image property has been added to get the image presently displayed by ScaleImageView. See post #37.