### [B4XDaisyUIKit] Beautiful, High-Performance PDF Rendering Made Simple (100% Beginner Friendly!) by Mashiane
### 08/05/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/171725/)

Hi B4X Community,  
  
Rending PDFs natively on Android can be a daunting task, requiring complex wrappers, native .so files, and tedious permission configurations. For years, the community has relied on the outstanding work of **DonManfred**, who wrapped Bartosz Schiller's popular **AndroidPdfViewer** and **PdfiumAndroid** GitHub libraries. This wrapper served as the foundation for excellent community examples, such as **walt61's** ad-free default viewer application, **PDFab**.  
  
Today, we are taking it a step further. Introducing **B4XDaisyPDFView**—a modern, high-level custom view that packages all of that low-level power into a clean, single B4X component. You no longer need to worry about manually configuring layouts, copying assets with boilerplate code, or handling complex configurators yourself. Our component is based on [PDFab](https://www.b4x.com/android/forum/threads/pdfab-a-default-pdf-viewer-app-based-on-donmanfreds-pdfium-wrap.155094/) but using B4XDaisyUIKit buttons.  
  
![](https://www.b4x.com/android/forum/attachments/172804) ![](https://www.b4x.com/android/forum/attachments/172805) ![](https://www.b4x.com/android/forum/attachments/172806)  
  
  

---

  
🌟 Features  

- **Simple Assets Loading:** Load assets directly with a single line of code.
- **Modern Properties:** Effortlessly toggle Auto-Spacing, Horizontal Swipe, Page Snapping, and Toolbars.
- **Touch Intercepting:** Built-in touch handling inside scrollable parent containers.
- **Clean Callback Events:** Easily trap page change, load complete, and screen tap events.

---

  
🛠️ Beginner-Friendly Code Example  
  
Setting up **B4XDaisyPDFView** is incredibly simple. Below is an example of how to initialize the component programmatically, set up its properties, load a PDF, and trap its key events.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
     
    ' Declare our custom view component  
    Private pdfViewer As B4XDaisyPDFView  
    Private NAVBAR_HEIGHT As Int = 56dip  
End Sub  
  
Public Sub Initialize As Object  
    Return Me  
End Sub  
  
' This is called when the B4XPage is created  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.Color = xui.Color_RGB(245, 247, 250) ' Soft background  
     
    ' 1. Initialize the component programmatically (or add via the Designer!)  
    pdfViewer.Initialize(Me, "pdfViewer")  
     
    ' 2. Programmatically add it to your root layout parent  
    pdfViewer.AddToParent(Root, 0, NAVBAR_HEIGHT, Root.Width, Root.Height - NAVBAR_HEIGHT)  
     
    ' 3. Configure properties easily with clean getters and setters  
    pdfViewer.AutoSpacing = True        ' Enable dynamic page margins  
    pdfViewer.EnableSwipe = True        ' Allow swipe gestures to turn pages  
    pdfViewer.PageSnap = True           ' Automatically snap pages to borders  
    pdfViewer.SwipeHorizontal = False   ' False for classic vertical scrolling  
    pdfViewer.ShowToolbar = True        ' Display the built-in control toolbar  
     
    ' 4. Load your PDF directly from the DirAssets folder  
    ' This automatically copies the file to the safe DefaultFolder and displays it!  
    pdfViewer.LoadAsset("chapter_5.pdf")  
End Sub  
  
' — TRAP EVENT CALLBACKS —  
  
' Triggered automatically when the PDF document is successfully parsed  
Private Sub pdfViewer_LoadComplete(Pages As Int)  
    Log("Success! PDF loaded with total pages: " & Pages)  
End Sub  
  
' Triggered automatically when the user scrolls to a new page  
Private Sub pdfViewer_PageChanged(Page As Int, TotalPages As Int)  
    ' Page index is 0-based, so add 1 for human-friendly display  
    Log("Switched to page: " & (Page + 1) & " of " & TotalPages)  
End Sub  
  
' Triggered when a user taps on the document  
Private Sub pdfViewer_OnTap(Target As Object)  
    Log("User tapped the PDF view panel!")  
End Sub
```

  
  

---

  
🎓 The History: Where Did It Come From?  
  
For those interested in how we got here, this project stands on the shoulders of giants:  

1. **AOSP Pdfium / AndroidPdfViewer:** Created by Bartosz Schiller on GitHub as a high-performance rendering engine on top of PdfiumAndroid.
2. **The DonManfred Wrap:** He brought Bartosz's NDK binaries to B4A under a compiled library PDFium - Pdfview2.
3. **The PDFab Example:** Inspired by **walt61's** PDFab, which showed the first low-level configuration approach using a compiled configurator:

' The original low-level PDFab configuration approach  
Dim cfg As Configurator = PDFView1.fromFile(xui.DefaultFolder, "chapter\_5.pdf")  
cfg.SetEventname("PDFium")  
cfg.autoSpacing(True)  
cfg.enableSwipe(True)  
cfg.pageSnap(True)  
cfg.swipeHorizontal(False)  
cfg.addOnErrorListener  
cfg.addOnLoadCompleteListener  
cfg.addOnPageChangeListener  
cfg.load  
  
With **B4XDaisyPDFView**, all of this configuration is handled behind the scenes, leaving your main page code exceptionally clean, readable, and highly maintainable!  
*We hope this helps onboard beginners to native PDF rendering in B4X. Let us know if you have any questions or feedback below!*  
  
[MEDIA=youtube]fxBBYSUItQM[/MEDIA]