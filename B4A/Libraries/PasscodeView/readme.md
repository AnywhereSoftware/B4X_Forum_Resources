### PasscodeView by DonManfred
### 09/07/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/78984/)

This is a wrap for [this github project](https://github.com/hanks-zyh/PasscodeView).  
  
![](https://www.b4x.com/android/forum/attachments/55268)  
  
![](https://www.b4x.com/android/forum/attachments/55269) ![](https://www.b4x.com/android/forum/attachments/55270)  
  
**PasscodeView  
Author:** DonManfred (wrapper)  
**Version:** 1  

- **PasscodeView**
Events:

- **onFail** ( As )
- **onSuccess** (number As String)

**Fields:**

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
- **clearInput**
- **initListener**
- **runOkAnimation**
- **runTipTextAnimation**
- **runWrongAnimation**

**Properties:**

- **Background As Drawable**
- **Color As Int** *[write only]*
- **CorrectInputTip As String**
- **CorrectStatusColor As Int**
- **Enabled As Boolean**
- **FirstInputTip As String**
- **Height As Int**
- **Left As Int**
- **LocalPasscode As String**
- **NormalStatusColor As Int**
- **NumberTextColor As Int**
- **Padding()() As Int**
- **Parent As Object** *[read only]*
- **PasscodeLength As Int**
- **PasscodeType As Int**
- **SecondInputTip As String**
- **Tag As Object**
- **Top As Int**
- **Visible As Boolean**
- **Width As Int**
- **WrongInputTip As String**
- **WrongLengthTip As String**
- **WrongStatusColor As Int**

  
  
Important:  
- V1.00 is for the old Android Support Libraries.  
- V1.01 and up is based on AndroidX.