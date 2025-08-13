### jSD_Wacom by Star-Dust
### 05/08/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/144728/)

I was asked by a customer to connect to wacom devices for signing.  
At first I thought some wrapping would be needed and not being java savvy I would commission someone capable to do it for me.  
  
At the end of last month I found myself with a few more coins in my pocket and I bought a wacom on an offer and started playing with it.  
I started using their sw by calling it from B4J. Everything worked but I was not satisfied.  
So I started testing the sample sources in VB.NET, C#, JAVA and I managed to get them to work perfectly. But the idea of having a library in B4J appealed to me.  
  
So for 2 weeks I've been starting to transport the code in B4J. I was able to connect and send the images and other commands but still couldn't capture the signature. Then a lighting and banging the nose of JAVA (I've learned a lot about java these days) I produced the first library.  
  
Unfortunately I can't share it for free, but I would like to share a DEMO version that you can find in this post. However, you can ask for all the information you need.  
  
**jSD\_Wacom  
  
Author:** Star-Dust  
**Version:** 1.07  

- **PenRoute**

- **Fields:**

- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **Pressure** As Int
- **Rdy** As Int
- **Sw** As Int
- **X** As Int
- **Y** As Int

- **Functions:**

- **Initialize**
*Inizializza i campi al loro valore predefinito.*
- **wacom**

- **Events:**

- **ButtonClick** (Name As String)
- **CaptureSign** (bmp As B4XBitmap)
- **CaptureStart** (Success As Boolean)
- **PenPoint** (PenData As PenRoute)

- **Functions:**

- **CaptureClearScreen** As String
- **CaptureStart** (background As B4XBitmap, ButtonName As String()) As String
 *wacom.CaptureStart(xui.LoadBitmap(path,file),array As String ("OK","CLEAR","CANCEL"))  
 wacom.CaptureStart(null,null)*- **CaptureStop**
- **Class\_Globals** As String
- **ClearScreen** As String
- **Info** As InfoType
- **Initialize** (CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **isConnect** As Boolean
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **SetBackground** (bmp As B4XBitmap) As String

- **Properties:**

- **PenWrite**

  
  
  
 ![](https://www.b4x.com/android/forum/attachments/137051)