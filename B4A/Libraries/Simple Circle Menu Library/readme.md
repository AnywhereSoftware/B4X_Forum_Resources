### Simple Circle Menu Library by jahswant
### 05/10/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/72866/)

Simple customisable menu that could have from 1 to 10 (and more) buttons. Wraped from [this](https://github.com/Hitomis/CircleMenu) github project.  
**CircleMenuLibrary  
Version:** 1.2  

- **CircleMenuLibrary**
Events:

- **onMenuClosed**
- **onMenuOpened**
- **onMenuSelected** (Index As Int)

- **Fields:**

- **ba As BA**

- **Methods:**

- **AddToParent** (Parent As ViewGroup, left As Int, top As Int, width As Int, height As Int)
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
- **closeMenu**
*Close the CircleMenu*- **isOpened As Boolean**
*Returns whether the menu is alread open  
 Return type: @return:*- **openMenu**
*Open the CircleMenu*- **setMainIconBitmap** (openBitmap As Bitmap, closeBitmap As Bitmap)
 *openBitmap:   
 closeBitmap:* - **setMainIconDrawable** (openDrawable As Drawable, closeDrawable As Drawable)
 *openDrawable:   
 closeDrawable:* - **setMainIconResource** (openRes As Int, closeRes As Int)
 *openRes:   
 closeRes:* 
- **Properties:**

- **Background As Drawable**
- **Color As Int** *[write only]*
- **Enabled As Boolean**
- **Height As Int**
- **Left As Int**
- **MenuColors() As Int** *[write only]*
- **Parent As Object** *[read only]*
- **SubIconBitmaps As List** *[write only]*
- **SubIconDrawables() As Drawable** *[write only]*
- **SubIconResources() As Int** *[write only]*
- **Tag As Object**
- **Top As Int**
- **Visible As Boolean**
- **Width As Int**