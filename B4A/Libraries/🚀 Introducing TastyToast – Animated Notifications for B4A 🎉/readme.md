### 🚀 Introducing TastyToast – Animated Notifications for B4A 🎉 by fernando1987
### 02/11/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/165572/)

Based on the original [TastyToast](https://www.b4x.com/android/forum/threads/tasty-toast.69671/) thread, I have updated the library and added the **confusion** notification, inspired by the [TastyToast](https://github.com/yadav-rahul/TastyToast) repository.  
  
📌 **What's new in TastyToast?**  
✅ New animation to represent confusion.  
  
  
💡 **Special thanks** to the original author for sharing the source code @**[USER=47104]Johan Schoeman[/USER]** , which made this update and adaptation possible for our community.  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: TastyToast - Wrapped by Johan Schoeman  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
'#AdditionalRes: ..\resource  
#AdditionalRes: ..\resource_tastytoast  
  
'IMPORTANT!!!! YOU NEED TO SET THIS PATH CORRECTLY FOR YOUR OWN COMPUTER!!!!!!!!!!!!!!!!!!  
'THE BELOW PATH IS THE PATH FOR MY COMPUTER  
'#AdditionalRes: C:\ANDRIOD_SDK_TOOLS\extras\android\support\v7\appcompat\res, android.support.v7.appcompat  
'#AdditionalRes: C:\ANDRIOD_SDK_TOOLS\extras\android\support\design\res, android.support.design  
'#Extends: android.support.v7.app.AppCompatActivity  
  
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
  
    Dim tt As TastyToast  
    
    
    Private btnSuccess As Button  
    Private btnWarning As Button  
    Private btnError As Button  
    Private btnInfo As Button  
    Private btnDefault As Button  
    Private Btnconfution As Button  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    
    Activity.LoadLayout("main")  
  
    tt.Initialize  
  
    
End Sub  
  
Sub Activity_Resume  
    
    
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
  
Sub btnSuccess_Click  
    
    tt.showSuccessToast("Download Successful !")  
    
End Sub  
  
Sub btnWarning_Click  
    
    tt.showWarningToast("Are you sure ?")  
    
End Sub  
  
Sub btnError_Click  
    
    tt.showErrorToast("Downloading failed ! Try again later ")  
    
End Sub  
  
Sub btnInfo_Click  
    
    tt.showInfoToast("Searching for username : 'Johan' ")  
    
End Sub  
  
Sub btnDefault_Click  
    
    tt.showDefaultToast("This is Default Toast")  
    
End Sub  
  
Private Sub Btnconfution_Click  
    tt.showConfusingToast("This is Confusing Toast")  
End Sub
```

  
  
📸 **Screenshots   
![](https://www.b4x.com/android/forum/attachments/161649)![](https://www.b4x.com/android/forum/attachments/161650)![](https://www.b4x.com/android/forum/attachments/161651)![](https://www.b4x.com/android/forum/attachments/161652)![](https://www.b4x.com/android/forum/attachments/161653)![](https://www.b4x.com/android/forum/attachments/161654)**