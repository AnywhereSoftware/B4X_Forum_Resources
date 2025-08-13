### SD: MenuClose by Star-Dust
### 04/01/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/93659/)

I had the need to create a menu when it is required to exit App from the Back button of the device but also from the home button.  
  
So I have to create something similar to closing the device.  
Here is my new office.  
  
**SD\_MenuClose  
  
Author:** Star-Dust  
**Version:** 0.05  

- **MenuClose**

- **Functions:**

- **Class\_Globals** As String
- **ExitApplication2** As String
Close the application and connected services- **Initialize** (BackgroundColor As Int, TextColor As Int) As String
*Initializes the object. You can add parameters to this method if needed.  
 <code> MenuClose.Initialize(Colors.ARGB(200,150,150,150),Colors.White) </code>*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
  
![](https://www.b4x.com/android/forum/attachments/68505)  
  
**use**:  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("Layout1")  
  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event  
    If KeyCode=KeyCodes.KEYCODE_BACK Then  
        Dim MC As MenuClose  
        MC.Initialize  
        Return True  
    End If  
   
    Return False  
End Sub
```

  
  

- **1.04**

- Added BackgroundColor parameter

- **1.05**

- Added TextColor parameter