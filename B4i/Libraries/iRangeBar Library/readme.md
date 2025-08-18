### iRangeBar Library by walterf25
### 01/07/2021
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/114742/)

Hello everyone, i am please to post my first B4i wrapped library, i am working on a project for a customer and I had the need to use a RangeBar view, after trying to create one with B4X and not getting the results i wanted I decided to search online for something that could be wrapped easily, after a lot of searching around I came across the following library, it didn't take very long to wrap it, please take a look and let me know if you guys see any issues.  
  
All the images used can be custom made and set them in the library.  
![](https://www.b4x.com/android/forum/attachments/89682)  
  
  
**iRangeBar  
Version:** 1  

- **iRangeBar**
Events:

- **SliderValueChanged** (leftValue As Double, rightValue As Double)
- **Click**
- **LongClick**

- **Methods:**

- **IsInitialized As BOOL**
*Tests whether this object was initialized.*- **CalcRelativeKeyboardHeight:** (KeyboardHeight As double) **As double**
*Calculates the keyboard top point relative to the current view.*- **SetColorAnimated::** (DurationMS As int, BackgroundColor As int) **As void**
*Animates the view's background color.  
DurationMS - Animation duration measured in milliseconds.  
BackgroundColor - The new background color.  
 Note that Labels do not support this type of animation.*- **SetAlphaAnimated::** (DurationMS As int, Alpha As float) **As void**
*Animates the view's alpha level.  
DurationMS - Animation duration measured in milliseconds.  
 Alpha - The new alpha level (0 - transparent, 1 - fully opaque).*- **SetLayoutAnimated::::::** (DurationMS As int, DampingRatio As float, Left As float, Top As float, Width As float, Height As float) **As void**
*Animates the view's layout.  
DurationMS - Animation duration measured in milliseconds. Set to 0 to change the layout immediately.  
DampingRatio - If smaller than 1 then a spring effect will be applied to the animation. The minimum value should be 0.1.  
Set to 1 for no spring effect.  
 Left, Top, Width and Height - The new layout.*- **SetBorder:::** (Width As float, Color As int, CornerRadius As float) **As void**
*Sets the view's border width, color and corner radius.  
 Note that the corner radius should be 0 if the view should show a shadow as well.*- **SetShadow:::::** (Color As int, OffsetX As float, OffsetY As float, Opacity As float, StaticRect As BOOL) **As void**
*Adds a shadow to to the view. The border corners radius should be set to 0 when adding shadows.  
Colors - The shadow color.  
OffsetX, OffsetY - The horizontal and vertical offsets.  
Opacity - Sets the shadow opacity: 0 - transparent, 1 - opaque.  
 StaticRect - (optimization parameter) Set this parameter to True if the view's size is constant.*- **SizeToFit As void**
*Resizes the view to make it fit its content.*- **RequestFocus As BOOL**
*Tries to set the focus on the current view. Returns True if the focus was set. Most views are not focusable.  
 When a text view is focused the keyboard is shown.*- **ResignFocus As BOOL**
*Removes the focus from the current view. Removing the focus from a text view will hide the keyboard.*- **RemoveViewFromParent As void**
*Removes the view from its parent (same as B4A View.RemoveView method).*- **BringToFront As void**
*Brings the view to front.*- **SendToBack As void**
*Sends the view to the back.*- **SetParallaxEffect::** (Vertical As int, Horizontal As int) **As void**
*Adds a parallax effect to the view. The view will slightly move when the device is tilted.  
Vertical - Vertical offset. Can be a positive or negative value.  
 Horizontal - Horizontal offset. Can be a positive or negative value.*- **DesignerCreateView:::** (base As B4IPanelWrapper\*, lw As B4ILabelWrapper\*, props As B4IMap\*) **As void**
- **setMinValue::** (minValue As double, maxValue As double) **As void**
*Sets the Minimum and Maximum Value*- **setLeftValue::** (leftValue As double, rightValue As double) **As void**
*Sets the Left and Right Values*- **setMinimumDistance:** (minimumDistance As double) **As void**
*Sets the Minimum Distance between left and right value*- **assigntrackImage:** (trackimage As UIImage\*) **As void**
*Sets the background Image for the RangeBar*- **assignrangeImage:** (rangeimage As UIImage\*) **As void**
*Sets the Range Image*- **assignleftThumb:** (thumbimage As UIImage\*) **As void**
*Sets the Left Thumb image*- **assignrightThumb:** (thumbimage As UIImage\*) **As void**
*Seets the Right Thumb image*
- **Properties:**

- **Tag As NSObject\***
*Gets or sets the Tag object. This is a placeholder for any object you like to tie to this object.*- **Left As float**
*Gets or sets the view's left position.*- **Top As float**
*Gets or sets the view's top position.*- **Width As float**
*Gets or sets the view's width.*- **Height As float**
*Gets or sets the view's height.*- **Color As int**
*Gets or sets the view's background color.*- **Alpha As float**
*Gets or sets the view's alpha level. 0 - transparent, 1 (default) - fully opaque.*- **TintColor As int**
*Gets or sets the view's tint color. Some views use this color to change their appearance.*- **Visible As BOOL**
*Gets or sets whether the view is visible.*- **IsFocused As BOOL** *[read only]*
Returns true if the view is focused.- **UserInteractionEnabled As BOOL**
*Gets or sets whether the user can interact with this view. True by default.*- **Parent As B4IViewWrapper\*** *[read only]*
Returns the views parent. The returned view can be uninitialized (if there is no parent).- **BaseView As B4IViewWrapper\*** *[read only]*
- **Text As NSString\***
- **minimumValue As double** *[read only]*
- **maximumValue As double** *[read only]*
- **leftValue As double** *[read only]*
- **rightValue As double** *[read only]*
- **leftThumbView As UIView\*** *[read only]*
- **rightThumbView As UIView\*** *[read only]*
- **pushable As BOOL**
*@property (nonatomic, assign) float minimumDistance;*- **disableOverlapping As BOOL**
- **sendInstantUpdates As BOOL**
- **trackImage As UIImage\***
*Images*- **rangeImage As UIImage\***
- **leftThumbImage As UIImage\***
- **rightThumbImage As UIImage\***

  
**Updated Library Zip folder and included the xml file 1/6/2021**