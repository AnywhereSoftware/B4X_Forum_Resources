### B4J PDFBox test project by PaulMeuris
### 08/07/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/142202/)

![](https://www.b4x.com/android/forum/attachments/132183)  
In my search for a good PDF file viewer in B4J i came across a few examples.  
DonManfred wrote a PDFBox (2.0.17) wrapper. Spsp wrote a ‘clsPDFViewer’.  
 The thread from knutf: [pdfboxwrapper](https://www.b4x.com/android/forum/threads/pdfboxwrapper-class-module-show-pdf-document-in-b4j.103350/) looked the most promising. So most of the credit goes to knutf for this application.  
I took the essential java object statements and included them in my application.  
I am using the Apache PDFBox 2.0.26 API and added the .jar reference in the Main module:  

```B4X
#AdditionalJar: pdfbox-app-2.0.26.jar
```

  
When the application starts the first thing you have to do is open the file dialog by clicking on the blue button on the top left.  
![](https://www.b4x.com/android/forum/attachments/132185)  
![](https://www.b4x.com/android/forum/attachments/132186)  
Then the selected file will be loaded. In the image below the B4X booklet B4X Basic Language is loaded.  
![](https://www.b4x.com/android/forum/attachments/132187)  
The application provides two ways of viewing: page by page or scrolling.  
In the paging mode the green buttons can be used to go to a specific page or the Page number input field can be used to type a page number and press on the ENTER key.  
When you click on the Scrolling switch the full PDF document is added to the scrolling pane.  
![](https://www.b4x.com/android/forum/attachments/132188)  
On my old laptop the 139 pages from the booklet were loaded in approximately 17 seconds.  
![](https://www.b4x.com/android/forum/attachments/132189)  
In this mode the red buttons can’t be used. You can however scroll through the entire text.  
The Page number input field can also be used to go to a specific page in the PDF document.  
![](https://www.b4x.com/android/forum/attachments/132190)  
Click on the Scrolling switch again and you can use the paging mode again. The now green buttons can be used.  
![](https://www.b4x.com/android/forum/attachments/132191)  
The essential code from the application looks like this:  

```B4X
Private Sub initpage  
    joswing.InitializeStatic("javafx.embed.swing.SwingFXUtils")  
    jofile.InitializeNewInstance("java.io.File",Array(pdffile))  
    joPDDocument.InitializeStatic("org.apache.pdfbox.pdmodel.PDDocument")  
    jopdfdoc = joPDDocument.RunMethod("load",Array(jofile))  
    jorenderer.InitializeNewInstance("org.apache.pdfbox.rendering.PDFRenderer",Array(jopdfdoc))  
    dpi = joscreen.InitializeStatic("javafx.stage.Screen").RunMethodJO("getPrimary",Null).RunMethod("getDpi",Null)  
    numpages = jopdfdoc.RunMethod("getNumberOfPages",Array())  
    lblnumpages.Text = " Total pages: " & numpages  
    pagenumber = 1  
    zoom = 0.8  
    ivpdf.Initialize("")  
    pnpdf.Initialize("")  
    pnpagepdf.Initialize("")  
    ftfpagenum.Text = pagenumber     
End Sub  
Private Sub renderpage(pnum As Int)  
    img = jorenderer.RunMethod("renderImageWithDPI",Array(pnum-1,dpi*zoom))  
    ivpdf.SetImage(joswing.RunMethodjo("toFXImage",Array(img,Null)))  
    pnpagepdf.RemoveAllNodes  
    pnpagepdf.AddNode(ivpdf,0,0,ivpdf.Width,ivpdf.Height)  
    sppagepdf.InnerNode = pnpagepdf  
    sppagepdf.InnerNode.PrefHeight = 1185dip * zoom  
    sppagepdf.VPosition = 0  
End Sub  
Private Sub renderallpages  
    If allpages_available = True Then  
        Return  
    End If  
    pnpdf.RemoveAllNodes  
    Dim toppos As Int = 0  
    For i = 0 To numpages - 1  
        img = jorenderer.RunMethod("renderImageWithDPI",Array(i,dpi*zoom))  
        Dim iv As ImageView  
        iv.Initialize("")  
        iv.SetImage(joswing.RunMethodjo("toFXImage",Array(img,Null)))  
        pnpdf.AddNode(iv,0,toppos,iv.Width,iv.Height)  
        toppos = toppos + (1185dip * zoom)  
    Next  
    sppdf.InnerNode = pnpdf  
    sppdf.InnerNode.PrefHeight = 1185dip * zoom * numpages  
    sppdf.VPosition = 0  
    allpages_available = True  
    Sleep(0)  
End Sub
```

  
You can download the attached zip-file to do some testing.  
The application has some limitations.  
I have set the dimensions fixed for a half-screen layout (on my 15.6 inch old laptop). This way i can look something up and compare it with the source code in the IDE on the other half of my screen.  
The zoom factor is set to 0.8 which gives a good scrolling response. A zoom factor of 1 seems to be causing some slow scrolling.  
The page layout is ideal for A4 pages in portrait mode. In landscape mode you have to resize the window.  
Happy testing!  
Paul