###  Reduce an image file to a specific size - for example, <500KB to upload to the Forum. by William Lancee
### 09/26/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/143155/)

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
  
    Public original As B4XBitmap  
    Public stage As B4XRect  
    Public imageLayer As B4XView  
    Public imageCV As B4XCanvas  
    Private imageDir As String  
    Private imageFile As String  
      
    Private maxSize As Long = 200000  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    imageCV.Initialize(Root)  
    Public stage As B4XRect  
    stage.Initialize(0, 0, Root.Width, Root.Height)  
      
    'specify your imageFile  
    imageDir = "C:\Users\willi\Desktop\Images"  
    imageFile = "TrainMoment.png"   'as an example  
  
    original = xui.LoadBitmap(imageDir, imageFile)  
    imageCV.DrawBitmap(original, stage)  
  
  
    Dim fn As String = imageFile.SubString2(0, imageFile.LastIndexOf(".")) & "_NEW.jpeg"  
    Dim bmp As B4XBitmap = imageCV.CreateBitmap  
  
    Dim sz As Long = 1 / 0  
    Dim perc As Float = 100  
    Do While sz > maxSize  
        Dim out As OutputStream = File.OpenOutput(imageDir, fn, False)  
        bmp.WriteToStream(out, perc, "JPEG")  
        out.Close  
        sz = File.Size(imageDir, fn)  
        perc = perc - 1  
        Log(perc & TAB & sz)  
        If perc < 5 Then Exit  
    Loop  
    bmp = xui.LoadBitmap(imageDir, fn)  
    imageCV.DrawBitmap(bmp, stage)  
End Sub
```