### B4XOCRPage - Specific OCR capture area (using MLKIT GMS Vision OCR) by Magma
### 05/27/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/167161/)

Hi there…  
  
If you already seen the example of [Erel with Barcode/QRCode Reading-Scanner using ML / GMS Vision Lib](https://www.b4x.com/android/forum/threads/class-google-code-scanner-no-permission-very-simple-to-use-barcode-scanning.160725/page-2#post-1024791)… you will understand the simplicity… well i wanted to do the same with ocr having specific Region (orthogon-square) for cropping - recognizing the text from specific area….  
  
\* The B4XOCRPage based on [OCR TextRecognition using ML Kit](https://www.b4x.com/android/forum/threads/b4x-textrecognition-based-on-mlkit.161210/)  
\*\* [Will need also Camera2 Library and CamEX2](https://www.b4x.com/android/forum/threads/camera2-still-images-and-videos.83920/#content)…  
  
The result saving in a public text string having it in "main.ocrresult"  
  
The w and h is the size of Panel -> using for crop image and also showing the specific region of orthogon - capturing…  
  
here we go:  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView 'ignore  
    Private xui As XUI 'ignore  
   
    Private pnlPreview As B4XView  
    Private camex As CamEx2  
    Private MyTaskIndex As Int  
    Private camtimer As Timer  
    Private IntervalBetweenPreviewsMs As Int = 500  
  
    Private recognizer As TextRecognizer  
    Private textResultLabel As Label  
    Private okreturn As Label  
   
  
    Dim w As Int = 200dip 'pnlPreview.Width / 2  
    Dim h As Int = 200dip 'pnlPreview.Height / 3  
  
    Private alreadyworks As Int = 0  
  
End Sub  
  
'You can add more parameters here.  
Public Sub Initialize As Object  
    Return Me  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    'load the layout to Root  
    Root.LoadLayout("camera_layout") ' Layout with only a Panel named pnlPreview  
  
    B4XPages.SetTitle(Me, "OCR Recognizing")  
  
    ' Create label for OCR text  
    textResultLabel.Initialize("")  
    okreturn.Initialize("okreturn")  
  
   
    okreturn.TextColor=Colors.White  
    okreturn.TextSize=42  
    okreturn.Typeface = Typeface.MATERIALICONS  
    okreturn.Text=Chr(0xE86C)  
    okreturn.Gravity=Gravity.CENTER  
   
   
   
    textResultLabel.TextColor = Colors.White  
    textResultLabel.TextSize = 22  
    textResultLabel.Gravity = Gravity.CENTER  
    okreturn.Width=100dip  
    okreturn.Height=100dip  
  
   
    Root.AddView(okreturn,50%x-(okreturn.Width/2),100%y-(okreturn.Height*1),100dip,100dip)  
   
  
    Root.AddView(textResultLabel, 0, 20dip, 100%x, 50dip)  
   
    alreadyworks=0  
    recognizer.Initialize("Latin")  
   
    StartCamera  
   
End Sub  
  
Private Sub StartCamera  
    pnlPreview.Visible = True  
  
    camex.Initialize(pnlPreview)  
  
    Wait For (camex.OpenCamera(False)) Complete (TaskIndex As Int)  
    If TaskIndex > 0 Then  
        MyTaskIndex = TaskIndex  
        For Each size As CameraSize In camex.GetSupportedPreviewSizes  
            If size.Height <= 480 Then  
                camex.PreviewSize = size  
                Exit  
            End If  
        Next  
  
        Wait For (camex.PrepareSurface(MyTaskIndex)) Complete (Success As Boolean)  
        If Success Then  
            camex.StartPreview(MyTaskIndex, False)  
            AddCropOverlay  
            camtimer.Initialize("camtimer", IntervalBetweenPreviewsMs)  
            alreadyworks=1  
            camtimer.Enabled = True  
        Else  
            Log("Failed to prepare camera surface.")  
        End If  
    End If  
End Sub  
  
Private Sub AddCropOverlay  
   
    For i = pnlPreview.NumberOfViews - 1 To 0 Step -1  
        Dim v As View  
        v = pnlPreview.GetView(i)  
        If v.Tag.As(String).Contains("CropOverlay") Then  
            v.RemoveView  
        End If  
    Next  
  
    Dim overlay1 As B4XView = xui.CreatePanel("")  
    overlay1.SetColorAndBorder(xui.Color_ARGB(180,  0, 0, 0), 0dip, 0, 0dip)  
    overlay1.Tag = "CropOverlay1"  
    Dim left As Int = (pnlPreview.Width - w) / 2  
    Dim top As Int = (pnlPreview.Height - h) / 2  
    pnlPreview.AddView(overlay1, 0,  0, 100%x, top)  
  
    Dim overlay2 As B4XView = xui.CreatePanel("")  
    overlay2.SetColorAndBorder(xui.Color_ARGB(180,  0, 0, 0), 0dip, 0, 0dip)  
    overlay2.Tag = "CropOverlay2"  
    Dim left As Int = (pnlPreview.Width - w) / 2  
    Dim top As Int = (pnlPreview.Height - h) / 2  
    pnlPreview.AddView(overlay2,  0,  top, left, h)  
  
  
    Dim overlay3 As B4XView = xui.CreatePanel("")  
    overlay3.SetColorAndBorder(xui.Color_ARGB(180,  0, 0, 0), 0dip, 0, 0dip)  
    overlay3.Tag = "CropOverlay3"  
    Dim left As Int = (pnlPreview.Width - w) / 2  
    Dim top As Int = (pnlPreview.Height - h) / 2  
    pnlPreview.AddView(overlay3,  left+w,  top,  100%x-(left+w), h)  
  
  
    Dim overlay4 As B4XView = xui.CreatePanel("")  
    overlay4.SetColorAndBorder(xui.Color_ARGB(180,  0, 0, 0), 0dip, 0, 0dip)  
    overlay4.Tag = "CropOverlay4"  
    Dim left As Int = (pnlPreview.Width - w) / 2  
    Dim top As Int = (pnlPreview.Height - h) / 2  
    pnlPreview.AddView(overlay4,  0,  (top+h),  100%x, 100%y-(top+h))  
  
  
  
    Dim overlay As B4XView = xui.CreatePanel("")  
   
    overlay.SetColorAndBorder(xui.Color_Transparent, 3dip, xui.Color_Red, 0dip)  
    overlay.Tag = "CropOverlay"  
  
    Dim left As Int = (pnlPreview.Width - w) / 2  
    Dim top As Int = (pnlPreview.Height - h) / 2  
  
    pnlPreview.AddView(overlay, left, top, w, h)  
   
    If alreadyworks=1 Then camtimer.Enabled=True  
  
End Sub  
  
Private Sub camtimer_Tick  
    alreadyworks=0  
    camtimer.Enabled=False  
    Try  
    Dim bmp As Bitmap = camex.GetPreviewBitmap(800, 1280)  
    If bmp.IsInitialized = False Then Return  
  
    Dim b4xBmp As B4XBitmap = bmp  
    Dim cropped As B4XBitmap = CropFromOverlay(b4xBmp)  
    If cropped.IsInitialized = False Then Return  
  
    Wait For (recognizer.Recognize(cropped)) Complete (Result As TextRecognizerResult)  
    If Result.Success Then  
        If Result.text.trim<>"" Then  
        textResultLabel.Text = Result.Text.Replace(CRLF," ")  
        okreturn.Text=Chr(0xE86C)  
        End If  
    Else  
        'textResultLabel.Text = ""  
        'okreturn.Text=""  
    End If  
    Catch  
        Log(LastException)  
    End Try  
    camtimer.Enabled=True  
    alreadyworks=1  
End Sub  
  
Private Sub CropFromOverlay(sourceBmp As B4XBitmap) As B4XBitmap  
    For i = 0 To pnlPreview.NumberOfViews - 1  
        Dim v As B4XView = pnlPreview.GetView(i)  
        If v.Tag <> Null And v.Tag = "CropOverlay" Then  
            Dim scaleX As Float = sourceBmp.Width / pnlPreview.Width  
            Dim scaleY As Float = sourceBmp.Height / pnlPreview.Height  
  
            Dim x As Int = v.Left * scaleX  
            Dim y As Int = v.Top * scaleY  
            Dim w As Int = v.Width * scaleX  
            Dim h As Int = v.Height * scaleY  
  
            If x + w > sourceBmp.Width Or y + h > sourceBmp.Height Then Return Null  
            Return sourceBmp.Crop(x, y, w, h)  
        End If  
    Next  
    Return Null  
End Sub  
  
  
Private Sub B4XPage_Disappear  
    If camtimer.IsInitialized Then camtimer.Enabled = False  
    If camex.IsInitialized Then camex.Stop  
End Sub  
  
Private Sub B4XPage_Appear  
    If camex.IsInitialized Then StartCamera  
End Sub  
  
  
  
Private Sub okreturn_Click  
    Main.ocrresult=textResultLabel.Text  
    B4XPages.ClosePage(Me)  
End Sub
```