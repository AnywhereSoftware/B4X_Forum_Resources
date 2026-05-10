### [B4XLIB] WebViewPdfExport by Segga
### 05/08/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170969/)

Generates a full-content PDF from your WebView. No print dialogs. Automatically opens the system share sheet or saves directly to the device.  
Captures the entire page, not just the visible viewport. Multi-page content paginates automatically.  
iOS and B4J require no extra setup.  
Android's PdfPrint.jar is based on [brettwold's gist](https://gist.github.com/brettwold/838c092329c486b6112c8ebe94c8007e), enhanced with a completion callback for silent PDF generation.  
**Usage**  

```B4X
Dim pdfExport As WebViewPdfExport  
pdfExport.Initialize(myWebView)  
Wait For (pdfExport.ExportAndShare("Report.pdf", "Share Report")) Complete (success As Boolean)
```

  
**or export without the share sheet**  

```B4X
Wait For (pdfExport.ExportToFile("Report.pdf")) Complete (success As Boolean)
```

  
**Setup**  
Copy **WebViewPdfExport.b4xlib** to your **B4X Additional Libraries** folder.  
  
**Android only** requires a couple of additional steps:  

- Unzip and copy **PdfPrint.jar** to your **B4A Additional Libraries** folder
- Add to **Main.bas**:
- ```B4X
  #AdditionalJar: PdfPrint.jar
  ```
- Add to **Manifest Editor**
- ```B4X
  AddApplicationText(
  ```
<provider
android:name="android.support.v4.content.FileProvider"
android:authorities="$PACKAGE$.provider"
android:exported="false"
android:grantUriPermissions="true">
<meta-data
android:name="android.support.FILE\_PROVIDER\_PATHS"
android:resource="@xml/provider\_paths"/>
</provider>
)
CreateResource(xml, provider\_paths,
<files-path name="name" path="shared" />
)
**Notes  
B4i:** The PDF is generated at your WebView's current width. If your HTML has wide tables or layouts, make sure it's responsive or keep columns to a minimum so nothing gets clipped.  
**B4A:** Content is re-rendered at A4 width regardless of screen size, so wider layouts are handled automatically.  
**B4J:** The HTML is saved to a file and opened in the default browser. The user can then print or save as PDF from there — PDF quality depends on the browser's print engine.