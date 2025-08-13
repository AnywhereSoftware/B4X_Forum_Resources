### SD_NativeAccess (jna) by Star-Dust
### 04/05/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/146316/)

This library allows access to the [**jna**](https://javadoc.io/doc/net.java.dev.jna/jna/5.0.0/index.html) to use some functions for managing windows and applications.  
You need to get these JARs and include them in the additional libraries folder: [**jna-5.10.0**](https://mvnrepository.com/artifact/net.java.dev.jna/jna/5.10.0) and [**jna-platform-5.10.0**](https://mvnrepository.com/artifact/net.java.dev.jna/jna-platform/5.10.0)  
  
With this library you can obtain the Handle of the applications that run on your Windows PC, both visible and invisible ones. A bit like you would with the task manager.  
From the Hande you can get the name of the window, the coordinates and dimensions and finally the file name and path of the app.  
There are many other functions that can be implemented with jna, as soon as I have time I will add a few more  
  
**SD\_NativeAccess  
  
Author:** Star-Dust  
**Version:** 1.07  

- **Na\_Rectangle**

- **Fields:**

- **Height** As Int
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **Left** As Int
- **Top** As Int
- **Width** As Int

- **Functions:**

- **Initialize**
*Inizializza i campi al loro valore predefinito.*
- **NativeAccess**

- **Functions:**

- **Class\_Globals** As String
- **FlashWindow**(Handle As Object, Count As Int, DurateMillisec As Int, BlinkType As Int)
- **GetCOM** As List
 *USB or COM*- **GetIdleTime** As Long
- **GetListWindowsHandle** (OnlyVisible As Boolean) As List
- **GetListWindowsTitle** (OnlyVisible As Boolean) As List
- **GetRegisterCurrentUser** (KeyPath As String, KeyValue As String) As String
- **GetRegisterLocalMachine** (KeyPath As String, KeyValue As String) As String
- **GetUSB** As List
- **GetWindowRect** (Handle As Object) As Na\_Rectangle
- **GetWindowsActiveTitle** As String
- **Initialize** As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **KillWindowsByHandle** (Handle As Object) As String
- **KillWindowsByName** (Title As String) As String
- **Minimize** (Handle As Object) As String
- **Monitor** (On As Boolean) As String
- **RenameWindow** (WindowsTitle As String, NewTitle As String) As Boolean
- **SetForegroundWindow** (Title As String) As String
- **SetWindowRec** (Handle As Object, Left As Int, Top As Int, Width As Int, Height As Int) As String

  
Update  

- rel 1.01

- Add **Monitor** (On As Boolean)

- rel. 1.02

- Added **GetUSB**
returns the list of installed usb devices- Added **GetCOM**
returns the list of serial port- Added **GetIdleTime**
returns the user's idle time
- rel 1.03

- Added **GetRegisterCurrentUser** (KeyPath As String, KeyValue As String) As String

- rel 1.04

- Added **GetRegisterLocalMachine** (KeyPath As String, KeyValue As String) As String

- rel 1.05

- Added **KillWindowsByName** and **KillWindowsByHandle**

- rel 1.06

- Added **FlashWindow**

- rel 1.07

- Added **RenameWindow**