### Printing and Pdf creation by Erel
### 05/18/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/76712/)

This is an Android 4.4+ (API 19+) library.  
  
Its two main features are:  
1. Creating Pdf documents with the PdfDocument object.  
2. Printing with the Printer object.  
  
**Lets start with PdfDocument.**  
  

```B4X
Dim pdf As PdfDocument  
pdf.Initialize  
pdf.StartPage(595, 842) 'A4 size  
pdf.Canvas.DrawLine(2, 2, 593 , 840, Colors.Blue, 4)  
pdf.Canvas.DrawText("Hello", 100, 100, Typeface.DEFAULT_BOLD, 30 / GetDeviceLayoutValues.Scale , Colors.Yellow, "CENTER")  
pdf.FinishPage  
Dim out As OutputStream = File.OpenOutput(File.DirInternal, "1.pdf", False)  
pdf.WriteToStream(out)  
out.Close  
pdf.Close
```

  
  
1. Initialize.  
2. Call StartPage to add a new page. The page size is measured in 1 / 72th inch.  
3. Use the Canvas object to draw on the page. Note that you shouldn't use 'dip' units here.  
**You should divide the text size with GetDeviceLayoutValues.Scale when calling Canvas.DrawText.**  
4. Call FinishPage.  
5. Repeat the above 3 steps for each page.  
6. Save the document to a file.  
7. Close the pdf object.  
  
**Printing  
  
![](https://www.b4x.com/android/forum/attachments/53290)**  
  
The printing feature is based on the OS printing framework. Most popular printers are supported. You do need to first install a printer plug-in.  
  
For example to print to a HP printer: <https://play.google.com/store/apps/details?id=com.hp.android.printservice>  
  
Cannon: <https://play.google.com/store/apps/details?id=jp.co.canon.android.printservice.plugin>  
  
The Printer object can print bitmaps, html documents, WebView content and PDF documents.  
  
Example:  

```B4X
Sub Globals  
   Private printer As Printer  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   printer.Initialize("")  
   Print  
End Sub  
  
Sub Print  
   printer.PrintHtml("job", $"<b>Hello world!!!</b><br/>  
<h1>second line</h1>  
<img src="${WebViewAssetFile("smiley.png")}"/>"$)  
End Sub  
  
Sub WebViewAssetFile (FileName As String) As String  
   Dim jo As JavaObject  
   jo.InitializeStatic("anywheresoftware.b4a.objects.streams.File")  
   If jo.GetField("virtualAssetsFolder") = Null Then  
     Return "file:///android_asset/" & FileName.ToLowerCase  
   Else  
     Return "file://" & File.Combine(jo.GetField("virtualAssetsFolder"), _  
  jo.RunMethod("getUnpackedVirtualAssetFile", Array As Object(FileName)))  
   End If  
End Sub
```

  
  
The WebViewAssetFile is a utility sub that creates the url of an asset file (the url depends on the compilation mode).  
  
**Updates:**  
  
V1.11 - PrintPdf2 - Allows passing custom PrintAttributes, created with JavaObject.  
V1.10 - Adds support for printing PDF documents:  

```B4X
Printer.PrintPdf("Job Name", File.DirAssets, "My Document.pdf")
```