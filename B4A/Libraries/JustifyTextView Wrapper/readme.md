### JustifyTextView Wrapper by jahswant
### 04/29/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/55330/)

**JustifyTextView With this library you can justify the text in a textView.  
Version:** 1  

- **JustifyTextView**
Fields:

- **ba As BA**

- **Methods:**

- **AddToParent** (Parent As ViewGroup, left As Int, top As Int, width As Int, height As Int)
- **BringToFront**
- **DesignerCreateView** (base As PanelWrapper, lw As LabelWrapper, props As Map)
- **Initialize** (EventName As String)
*Initializes the view.  
Example :  
Dim MyView As JustifyTextView  
MyView.Initialize("MyView")  
 Activity.AddView(MyView,0,0,100%x,100%y)*- **Invalidate**
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
- **SetText** (st As String, wrap As Boolean)
 *st: String to Justify.  
wrap: Set to true or false depending on what you want.  
Example   
Dim From As String  
From = File.ReadString(File.DirInternal, "from.txt")  
 MyView.SetText(From,False)*
- **Properties:**

- **Background As Drawable**
- **Color As Int** *[write only]*
- **Enabled As Boolean**
- **Height As Int**
- **Left As Int**
- **Tag As Object**
- **TextSize As Int** *[write only]*
- **Top As Int**
- **Visible As Boolean**
- **Width As Int**

![](https://www.b4x.com/android/forum/attachments/35166) ![](https://www.b4x.com/android/forum/attachments/35167)