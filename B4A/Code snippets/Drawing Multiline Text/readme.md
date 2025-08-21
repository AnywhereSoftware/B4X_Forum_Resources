### Drawing Multiline Text by Erel
### 05/12/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/103845/)

This code creates a label with the text and returns a snapshot of the label:  
  

```B4X
Sub TextToBitmap (Width As Int, Fnt As B4XFont, Clr As Int, Text As Object) As B4XBitmap  
   Dim lbl As Label  
   lbl.Initialize("")  
   Dim x As B4XView = lbl  
   x.Font = Fnt  
   x.TextColor = Clr  
   x.SetLayoutAnimated(0, 0, 0, Width, 0)  
   Dim su As StringUtils  
   x.Height = su.MeasureMultilineTextHeight(x, Text)  
   x.Text = Text  
   Return x.Snapshot  
End Sub
```

  
Depends on: XUI, StringUtils  
  
Usage example of drawing multiline text on a PDF document (Printing library):  

```B4X
Sub Process_Globals  
   Private rp As RuntimePermissions  
   Private xui As XUI  
End Sub  
  
Sub Globals  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   rp.CheckAndRequest(rp.PERMISSION_WRITE_EXTERNAL_STORAGE)  
   Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
   If Result Then  
       Dim pdf As PdfDocument  
       pdf.Initialize  
       pdf.StartPage(595, 842) 'A4 size  
       Dim bmp As B4XBitmap = TextToBitmap(200dip, xui.CreateDefaultBoldFont(20), xui.Color_Black, _  
        $"s dflkj sdfkls  
dffwje klfj wlkef jwlke fjlwkef jklwe jflkwe jflkwe jflkwe jflkwe jfl  
sdf  
we  
gfkwe lg;kw e;lg wklelg; weg wel;g"$)  
         Dim rect As Rect  
       rect.Initialize(30, 30, 0, 0)  
       rect.Width = bmp.Width / bmp.Scale  
       rect.Height = bmp.Height / bmp.Scale  
       pdf.Canvas.DrawBitmap(bmp, Null, rect)  
       pdf.FinishPage  
       Dim out As OutputStream = File.OpenOutput(File.DirRootExternal, "1.pdf", False)  
       pdf.WriteToStream(out)  
       out.Close  
       pdf.Close  
   End If  
End Sub
```