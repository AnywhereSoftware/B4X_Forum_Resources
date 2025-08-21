### Spinner Wheel - Vertical and Horizontal (24 June: new lib files in post #47) by Johan Schoeman
### 12/10/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/62723/)

It wraps the Vertical Spinner Wheel part of [this Github project](https://github.com/ai212983/android-spinnerwheel). Spin the wheel with a finger - up or down. The spinner is cyclic i.e it acts like a circular buffer.  
  
Posting:  
1. B4A project demonstrating the use of the Vertical Spinner Wheel - b4aAndroidSpinnerWheel.zip  
2. Zipped files with the required library files (including nineoldandroids) - copy them to your additional library folder. Library files are in AndroidSpinnerWheel.zip  
  
Please note: have added no code in the designer or in the B4A project to position the views - just plonked down and dragged them in the designer. Leaving positioning to those making use of this project.  
  
I will add the Horizontal Spinner Wheel part of the project at some stage…  
  
![](https://www.b4x.com/android/forum/attachments/40875)  
  
Sample code:  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: AndroidSpinnerWheel  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: landscape  
    #CanInstallToExternalStorage: False  
#End Region  
  
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
  
    Private vsw1, vsw2 As WheelVerticalView  
    Dim months() As String  
    Dim cities() As String  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("main")  
   
    vsw1.ItemDimmedAlpha = 100  
    vsw1.SpinnerTextColor = Colors.Red  
    vsw1.SpinnerTextSize = 18  
    months = Array As String("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")  
    vsw1.SpinnerItems = months  
    vsw1.setupSpinnerWheel  
   
    vsw2.ItemDimmedAlpha = 150  
    vsw2.SpinnerTextColor = Colors.Yellow  
    vsw2.SpinnerTextSize = 23   
    cities = Array As String("New York", "Washington", "Chicago", "Atlanta", "Orlando", "Los Angeles", "Houston", "New Orleans")   
    vsw2.SpinnerItems = cities  
    vsw2.setupSpinnerWheel  
   
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub vsw1_value_changed(index As Int)  
   
    Log("Selected Month = " & months(index))  
   
End Sub  
  
Sub vsw2_value_changed(index As Int)  
   
    Log("Selected City = " & cities(index))  
   
End Sub
```

  
  
The library:  
  
**AndroidSpinnerWheel  
Author:** Github: Dimitri Fedorov; Wrapped by: Johan Schoeman  
**Version:** 1  
**WheelVerticalView  
Events:**  

- **value\_changed** (index as Int )

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
- **setupSpinnerWheel**

**Properties:**  

- **Background As Drawable**
- **Color As Int** *[write only]*
- **Enabled As Boolean**
- **Height As Int**
- **ItemDimmedAlpha As Int** *[write only]*
- **Left As Int**
- **SpinnerItems() As String** *[write only]*
- **SpinnerTextColor As Int** *[write only]*
- **SpinnerTextSize As Int** *[write only]*
- **Tag As Object**
- **Top As Int**
- **Visible As Boolean**
- **Width As Int**

  