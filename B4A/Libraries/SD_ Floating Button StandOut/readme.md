### SD: Floating Button StandOut by Star-Dust
### 01/10/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/80847/)

**(No WRAP, but B4A)**   
I've been in a new challenge. I reworked a little release published by [USER=33472]@JordiCP[/USER]. Find **[SIZE=5][Here](https://www.b4x.com/android/forum/threads/chathead-wrapper-inline-java.62027/#content)[/SIZE]**  
  
He entered the Java code taken by GitHub (see <https://github.com/henrychuangtw/Android-ChatHead>) and wrapped it with "#IF JAVA" inside a B4A module.  
  
With his permission I extended a bit of the B4A code and retouched the Java code (for that little I remember Java) and I realized one thing I longed for: A flying button that always stands out even on other Apps On the Desktop.  
  
You can get the full version by making a donation..  
  
**SD\_FloatingStandOut  
  
Author:** Star-Dust  
**Version:** 0.09  

- **FloatingStandOut**
*Code module  
 Subs in this code module will be accessible from all modules.*

- **Fields:**

- **ActiveService** As Boolean
- **ENABLEDROP** As Boolean
- **EventClick** As String
- **EventDoubleClick** As String
- **EventLongClick** As String
- **EventMove** As String
- **HALF\_STICK\_TO\_BORDER** As Boolean
- **HeightImage** As Int
- **NameFileImage** As String
- **NotificationBody** As String
- **NotificationTitle** As String
- **PathImage** As String
- **StartActivity\_OnClick** As Boolean
- **StartActivity\_OnDoubleClick** As Boolean
- **StartActivity\_OnLongClick** As Boolean
- **STICK\_TO\_BORDER** As Boolean
- **StopFloating\_OnClick** As Boolean
- **StopFloating\_OnDoubleClick** As Boolean
- **StopFloating\_OnLongClick** As Boolean
- **WhiteCircle** As Boolean
- **WidthImage** As Int
- **X** As Int
- **Y** As Int

- **Functions:**

- **Process\_Globals** As String
- **SetEvent** (EventName As String) As String
 *SetEvent("FL")  
 Sub FL\_OnClick(X as int, Y as int)  
 Sub FL\_OnDoubleClick(X as int, Y as int)  
 Sub FL\_OnLongClick(X as int, Y as int)  
 Sub FL\_OnMove(X as int, Y as int)*- **SetImageBitmap** (img As Bitmap) As String
- **SetStartActivity** (OnClick As Boolean, OnDoubleClick As Boolean, OnLongClick As Boolean) As String
- **SetStopFloating** (OnClick As Boolean, OnDoubleClick As Boolean, OnLongClick As Boolean) As String
- **Start** (Me\_CallBack As Object) As String
*Es. Start(Me,Application.PackageName)*- **Stop** As String

- **SpecialPermission**

- **Functions:**

- **ActivatePermissionResumable** As ResumableSub
- **Class\_Globals** As String
- **GetPermission** As Boolean
- **Initialize** As String
*Inizializza l'oggetto. Puoi aggiungere parametri a questo metodo,se necessario.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **OpenSettingPermission** As String
- **SdkVersion** As Int

- **chElement**

- **Fields:**

- **active** As Boolean
- **id** As Int
- **instance** As JavaObject
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **ttype** As chType
- **xpos** As Int
- **ypos** As Int

- **Functions:**

- **Initialize**
*Inizializza i campi al loro valore predefinito.*
- **standout**

- **Fields:**

- **CallBack** As Object
- **Snotif** As Notification

- **Functions:**

- **process\_globals**

  
  
[SIZE=5]N.B. Don't forget [/SIZE][SIZE=4]ADD to Manifest[/SIZE]  
<uses-permission android:name="android.permission.SYSTEM\_ALERT\_WINDOW"/>  
  
request permission SDK 23+  

```B4X
    Dim Permission As SpecialPermission  
    Permission.Initialize  
    If Permission.GetPermission Then  
        FloatingStandOut.Start(Me)  
    Else  
        Permission.OpenSettingPermission  
    End If
```

  
  
With resumable sub  

```B4X
Sub RequestPermission  
    Dim Permission As SpecialPermission  
    Permission.Initialize  
    Log(Permission.GetPermission)  
    Wait For (Permission.ActivatePermissionResumable) Complete (Success As Boolean)  
    If Success Then FloatingStandOut.Start(Me)  
End Sub
```