### ShowCaseView Wrapper by jahswant
### 05/10/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/55379/)

**ShowCaseView With this lib you can capture user attention or a first run tutorial.  
Version:** 1  

- **ShowcaseView**
Events:

- **onhide**
- **onshow**

- **Fields:**

- **ba As BA**

- **Methods:**

- **AddToParent** (Parent As ViewGroup, left As Int, top As Int, width As Int, height As Int)
- **BringToFront**
- **DesignerCreateView** (base As PanelWrapper, lw As LabelWrapper, props As Map)
- **Hide**
*Hide's the Case*- **Initialize** (EventName As String)
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
- **Show**
*Show's the Case*- **setShowcasePosition** (x As Float, y As Float)
*Set a specific position to showcase  
x:   
 y:* 
- **Properties:**

- **Background As Drawable**
- **Color As Int** *[write only]*
- **Enabled As Boolean**
- **Height As Int**
- **Left As Int**
- **ShotType As Int** *[write only]*
Set the shot method of the showcase - only once or no limit- **ShowcaseView As View** *[write only]*
Set the view to showcase- **Tag As Object**
- **Top As Int**
- **Visible As Boolean**
- **Width As Int**
- **blockTouch As Boolean** *[write only]*
Decide whether touches outside the showcased circle should be ignored or
not
![](https://www.b4x.com/android/forum/attachments/35205) ![](https://www.b4x.com/android/forum/attachments/35206) ![](https://www.b4x.com/android/forum/attachments/35207)