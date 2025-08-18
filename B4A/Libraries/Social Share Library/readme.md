### Social Share Library by hatzisn
### 09/06/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/99714/)

**(2020-06-09) SocialShare library is now b4xlib (B4A & B4i)**. The old code for B4A is shown further bellow (it has changed a bit) and for B4XPages is the following:  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private sc As SocialShare  
    
End Sub  
  
Public Sub Initialize  
    
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    sc.Initialize(B4XPages.GetNativeParent(Me), Root)  
    
End Sub  
  
  
Sub Button1_Click  
  
    'For b4i only ChooseChannel is exposed just to make it clearer but if you put also empty string it will work  
    sc.ShareMessage("Trial message with url: https://www.google.com", sc.ChooseChannel)  
   
#If B4A  
    'For B4A you select social channel  
    'For example  
    sc.ShareMessage("This is a trial message with a URL for Viber  https://www.google.com", sc.Viber)  
    'OR  
    sc.ShareMessage("This is a trial message with a URL for Twitter   https://www.google.com", sc.Twitter)  
#End if  
End sub
```

  
  
  
  
**(2019-02-16)** The Enum SocialChannel was removed (because it was practically useless) and the library use has changed. Please see the code bellow on the new usage.  
  
  
  
Hi everyone,  
  
This is a library to share text in all social apps and not only… I compiled the code into a library and made it a lot easier for me and for everyone to use it. Usage:  
  

```B4X
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
    Private Social As SocialShare  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("Share")  
  
    'Added args in the initialization  
    Social.Initialize(Me, Activity)  
  
End Sub  
  
  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub cmdViber_Click  
    Social.ShareMessage("This is a trial message with a URL for Viber  https://www.google.com", Social.Viber)  
End Sub  
  
Sub cmdTwitter_Click  
    Social.ShareMessage("This is a trial message with a URL for Twitter   https://www.google.com", Social.Twitter)  
End Sub
```

  
  
**Thanks to the excelent [Martin Pearman's tool](http://b4a.martinpearman.co.uk/xml2bb/) the description is as follows:  
  
  
NHSocialShare  
Author:** Nikolaos Hatzistelios  
**Version:** 1.1  
  

- **Fields:**

- **Facebook As String**
- **Twitter As String**
- **Viber As String**
- **FacebookMessenger As String**
- **Instagram As String**
- **Whatsapp As String**
- **Skype As String**
- **Choosechannel As String**

  

- **Methods**

- **IsInitialized As boolean**
*Tests whether the object has been initialized.*- **Initialize** (ba As anywheresoftware.b4a.BA) **As String**
*Initializes the object. You can add parameters to this method if needed.*- **Sharemessage** (Message As String, SocialChannelClassValue As String) **As String**

  
Have fun…