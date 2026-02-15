###  B4J/B4A: Blur Image Effect by Peter Simpson
### 02/10/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170264/)

Hello everyone,  
Nothing new hear, and yes this can be achieved using Bitmap Creator. I wrapped this last year whilst learning Java for a personal project. I've just cleaned it up a bit for the B4X community.  
  
**B4J library tab:**  
![](https://www.b4x.com/android/forum/attachments/169865)  
  
**B4J Images:**  
![](https://www.b4x.com/android/forum/attachments/169780)![](https://www.b4x.com/android/forum/attachments/169781)  
  
**B4A library tab:**  
![](https://www.b4x.com/android/forum/attachments/169866)  
  
**B4A Images:**  
![](https://www.b4x.com/android/forum/attachments/169782)![](https://www.b4x.com/android/forum/attachments/169783)  
  

```B4X
Private Sub Button1_Click  
    Dim Img As B4XBitmap = ImageView1.GetBitmap ' CAN ALSO USE ImageView1.Snapshot  
    If Img.IsInitialized = False Then Return  
  
    'Loop for slow transition blur effect  
    For i = 0 To 99  
        BI.BlurAsync(Img, i)  
        Sleep(20) '20 milliseconds per transition for slow blur  
    Next  
End Sub  
  
Sub BI_BlurDone(Blurred As Object)  
    Dim Bmp As B4XBitmap = Blurred  
    If Bmp.IsInitialized = False Then Return  
    ImageView1.SetBitmap(Bmp)  
End Sub
```

  
  
**SS\_BlurImage  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **Functions:**

- **Cancel**
*Cancel any pending blur task.  
 This attempts to cancel the running future if present.*- **Release**
*Release engine resources and shutdown the dispatcher.  
 After calling release the engine cannot be reused.*


- **Functions:**

- **BlurPixels** (pix As Int(), w As Int, h As Int, radius As Int) As Int()

- **BlurImage**

- **Events:**

- **BlurDone**

- **Functions:**

- **BlurAsync** (Source As Object, Radius As Int)
*Start an asynchronous blur operation.  
 Source is the platform image object or wrapper. Pass a Bitmap, Image, B4XBitmap.  
 Radius is the blur radius.*- **Cancel**
*Cancel any pending asynchronous blur operation.  
 Cancellation is cooperative; if the blur is already running it will attempt to stop.*- **Initialize** (EventName As String)
*Initialize the BlurImage engine.*- **IsInitialized** As Boolean
- **Release**
*Release resources used by the engine.  
 This will cancel pending tasks and shut down the internal dispatcher.*
  
  
**Enjoy…**