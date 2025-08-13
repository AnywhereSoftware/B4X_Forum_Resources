### Glassmorphism effect for B4J by kimstudio
### 11/19/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/144264/)

BitmapCreator based Glassmorphism effect by drawing blurred part under pane:  
  
![](https://www.b4x.com/android/forum/attachments/136180)  
  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI   
    Dim bce As BitmapCreatorEffects  
    Private Pane1 As Pane  
    Dim bm, bb, bp As BitmapCreator  
    Private Canvas1 As Canvas  
    Dim br As B4XRect  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
      
    bce.Initialize  
    Dim im As Image = fx.LoadImage(File.DirAssets, "20004.jpg")  
    bm.Initialize(im.Width, im.Height)  
    bm.CopyPixelsFromBitmap(im)  
      
    Dim imb As B4XBitmap = bce.Blur(im)  
    bb.Initialize(im.Width, im.Height)  
    bb.CopyPixelsFromBitmap(imb)  
      
    bp.Initialize(Pane1.Width, Pane1.Height)  
    br.Initialize(Pane1.Left, Pane1.Top, Pane1.Left+Pane1.Width, Pane1.Top+Pane1.Height)  
    bp.DrawBitmapCreator(bb, br, 0, 0, True)  
    Canvas1.DrawImage(bm.Bitmap, 0 ,0 ,Canvas1.Width, Canvas1.Height)  
    Canvas1.DrawImage(bp.Bitmap, Pane1.Left, Pane1.Top, Pane1.Width, Pane1.Height)  
End Sub
```