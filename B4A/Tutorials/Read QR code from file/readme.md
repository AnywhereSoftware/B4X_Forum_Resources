### Read QR code from file by yiankos1
### 08/15/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/133453/)

Hello team,  
  
If you want to scan QR code from a file (Bitmap or pdf) you can try this code:  
You need [PDFium](https://www.b4x.com/android/forum/threads/pdfium-pdfview2.102756/) and [Barcode Reader](https://www.b4x.com/android/forum/threads/b4x-b4xpages-barcode-reader.120417/#content)  
  

```B4X
'Code module  
'Subs in this code module will be accessible from all modules.  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Public glDoc As Object  
    Private detector As JavaObject  
    Private xui As XUI  
End Sub  
  
Public Sub Initialize  
    CreateDetector (Array("QR_CODE"))'"CODE_128", "CODE_93",  
End Sub  
  
Private Sub CreateDetector (Codes As List)  
    Dim ctxt As JavaObject  
    ctxt.InitializeContext  
    Dim builder As JavaObject  
    builder.InitializeNewInstance("com/google/android/gms/vision/barcode/BarcodeDetector.Builder".Replace("/", "."), Array(ctxt))  
    Dim barcodeClass As String = "com/google/android/gms/vision/barcode/Barcode".Replace("/", ".")  
    Dim barcodeStatic As JavaObject  
    barcodeStatic.InitializeStatic(barcodeClass)  
    Dim format As Int  
    For Each formatName As String In Codes  
        format = Bit.Or(format, barcodeStatic.GetField(formatName))  
    Next  
    builder.RunMethod("setBarcodeFormats", Array(format))  
    detector = builder.RunMethod("build", Null)  
    Dim operational As Boolean = detector.RunMethod("isOperational", Null)  
    If operational = False Then  
        ToastMessageShow("Failed to create detector",False)  
    End If  
  
    detectFile  
End Sub  
  
Sub detectFile  
      
    Dim frameBuilder As JavaObject  
    frameBuilder.InitializeNewInstance("com/google/android/gms/vision/Frame.Builder".Replace("/", "."), Null)  
  
    If KVS.Get("type")="pdf" Then 'PDF or BITMAP  
        Private pdf As PdfiumCore  
        pdf.Initialize("pdf")  
        glDoc = pdf.newDocument(Starter.Provider.SharedFolder,"vev", 268435456,"") 'LOAD YOUR PDF FILE  
        Dim bmp As Bitmap  
        bmp.InitializeMutable(768dip,1024dip) ' Bitmap on which the Page is rendered  
        Log("OpenPage")  
        pdf.openPage(glDoc,0) ' Mandatory to do before you want to render a Page  
        Log("RenderBitmap")  
        pdf.renderPageBitmap(glDoc,bmp,0,0,0,768dip,1024dip)  
        Log("Set Bitmap to Imageview")  
        frameBuilder.RunMethod("setBitmap",Array(bmp))  
    Else  
        frameBuilder.RunMethod("setBitmap",Array(LoadBitmap(Starter.Provider.SharedFolder,"vev"))) 'LOAD BITMAP FILE  
    End If  
      
    Dim frame As JavaObject = frameBuilder.RunMethod("build", Null)  
    Dim SparseArray As JavaObject = detector.RunMethod("detect", Array(frame))  
    Dim Matches As Int = SparseArray.RunMethod("size", Null)  
    If Matches > 0 Then  
        Dim barcode As JavaObject = SparseArray.RunMethod("valueAt", Array(0))  
        Dim raw As String = barcode.GetField("rawValue")  
        FoundBarcode(raw)  
    Else  
          
    End If  
      
End Sub  
  
Private Sub FoundBarcode (msg As String)  
      
    Log(msg)  
      
End Sub
```