### Protect app  with code by pliroforikos
### 12/31/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/136386/)

This library protects app with pin. It uses a protected kvs (pinLockerLP.dat) file to store the pin. User can enable or disable pin.  
  
You can also set the size of the pin and change all labels, msgs, tost messages etc. according to your language.  
  
![](https://www.b4x.com/android/forum/attachments/122352)![](https://www.b4x.com/android/forum/attachments/122353)  
  
**pinLockerLP**  
 **Author: Leon Prokopis**  
 **Version: 1.10**  

- **pinLockerLP**

- **Public Fields:**

- Public **MAXPASSLENGHT** As Int = 4
- Public **textDlgTitle** As String = "Secure Application"
- Public **textBtnOK** As String = "Ok"
- Public **textBtnNo** As String = ""
- Public **textBtnCancel** As String = "Cancel"
- Public **textLabelEnablePin** As String = "Enable Pin"
- Public **textHintPin1** As String = "Pin"
- Public **textHintPin2** As String = "Retype Pin"
- Public **textToastMsgSuccessSavePin** As String = "Pin saved"
- Public **textToastMsgPinDisaled** As String = "Pin disabled"
- Public **textLabelEnablePin** As String = "Pin enabled"
- Public **textHintEnterPin** As String = "Enter Pin"
- Public **textToastWrongPin** As String = "Wrong Pin entered"

- **Functions:**

- **createPin**
Call the Pin creation dialog. Also in this dialog you can enable or disable pin- **dlgAskPin**
Ask pin from user- **isPinActive** As Boolean
Returns True if pin enabled or else returns False- **Initialize**
Initializes lib
**Changelog**  
  

- **1.00**

- Release

- **1.10**

- Repair a small bug of unitialized value
- Smaller font size when asking pin

**Dont forget to set KVS\_ENCRYPTION to build Configuration**  
![](https://www.b4x.com/android/forum/attachments/122356)  
  
Feel free to decompress lib and use it as u like. Feedback always welcome.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private locker As PinLockerLP  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    locker.Initialize(Root)  
    locker.MAXPASSLENGHT = 4  
   
    Root.LoadLayout("MainPage")  
End Sub  
  
  
Private Sub Button1_Click  
    locker.createPin  
End Sub  
  
Private Sub Button2_Click  
    If locker.IsPinActive Then  
        locker.dlgAskPin  
    End If  
End Sub
```