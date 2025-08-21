### PDFium - Pdfview2 by DonManfred
### 09/26/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/102756/)

This is a wrap for a PDF-View which is based on PDFium.  
It is based on these two Github-Projects: [Pdfium](https://github.com/barteksc/PdfiumAndroid) and [Android PDF-View](https://github.com/barteksc/AndroidPdfViewer)  
The PDF-View is based on Pdfium 1.9  
  
The Library, resp. the Natives inside, are 64bit Compliant btw.  
  
It supports Horizontal and Vertical scrolling, Pagesnap.  
  
**PDFium**  
  
**Author:** Bartosz Schiller (Pdfium), DonManfred(wrap)  
**Version:** 1.0  

- **Configurator**

- **Events:**

- **loadComplete** (pages As Int)
- **onInitiallyRendered** (page As Int)
- **onPageChanged** (oldPage As Int, newPage As Int)
- **PageNum** (page As Int)
- **Show()**

- **Functions:**

- **addLinkHandler** As Configurator
- **addOnDrawListener** As Configurator
- **addOnErrorListener** As Configurator
- **addOnLoadCompleteListener** As Configurator
- **addOnPageChangeListener** As Configurator
- **addOnPageErrorListener** As Configurator
- **addOnPageScrollListener** As Configurator
- **addOnRenderListener** As Configurator
- **addOnTapListener** As Configurator
- **addScrollHandle** As Configurator
- **autoSpacing** (autoSpacing As Boolean) As Configurator
- **defaultPage** (defaultPage As Int) As Configurator
- **enableAnnotationRendering** (annotationRendering As Boolean) As Configurator
- **enableAntialiasing** (antialiasing As Boolean) As Configurator
- **enableDoubletap** (enableDoubletap As Boolean) As Configurator
- **enableSwipe** (enableSwipe As Boolean) As Configurator
- **IsInitialized** As Boolean
- **load** As Configurator
- **nightMode** (nightMode As Boolean) As Configurator
- **pageFitPolicy** (pageFitPolicy As com.github.barteksc.pdfviewer.util.FitPolicy) As Configurator
- **pageFling** (pageFling As Boolean) As Configurator
- **pages** (pageNumbers As Int) As Configurator
- **pageSnap** (pageSnap As Boolean) As Configurator
- **password** (password As String) As Configurator
- **SetEventname** (EventName As String)
- **spacing** (spacing As Int) As Configurator
- **swipeHorizontal** (swipeHorizontal As Boolean) As Configurator

- **PDFView**

- **Functions:**

- **BringToFront**
- **DesignerCreateView** (base As Panel, lw As Label, props As Map)
- **doAutoSpacing** As Boolean
- **doPageFling** As Boolean
- **doPageSnap** As Boolean
- **doRenderDuringScale** As Boolean
- **enableAnnotationRendering** (annotationRendering As Boolean)
- **enableAntialiasing** (enableAntialiasing As Boolean)
- **enableRenderDuringScale** (renderDuringScale As Boolean)
- **fitToWidth** (page As Int)
- **fromAsset** (assetName As String) As com.github.barteksc.pdfviewer.PDFView.Configurator
*Use an asset file as the pdf source*- **fromBytes** (bytes As Byte()) As com.github.barteksc.pdfviewer.PDFView.Configurator
*Use bytearray as the pdf source, documents is not saved*- **fromFile** (path As String, filename As String) As com.github.barteksc.pdfviewer.PDFView.Configurator
*Use a file as the pdf source  
path:  
filename:* - **fromSource** (docSource As com.github.barteksc.pdfviewer.source.DocumentSource) As com.github.barteksc.pdfviewer.PDFView.Configurator
*Use custom source as pdf source*- **fromStream** (stream As java.io.InputStream) As com.github.barteksc.pdfviewer.PDFView.Configurator
*Use stream as the pdf source. Stream will be written to bytearray, because native code does not support Java Streams*- **fromUri** (path As String, filename As String) As com.github.barteksc.pdfviewer.PDFView.Configurator
*Use URI as the pdf source, for use with content providers*- **getLinks** (page As Int) As java.util.List
*Will be empty until document is loaded*- **getPageAtPositionOffset** (positionOffset As Float) As Int
*Get page number at given offset  
positionOffset: scroll offset between 0 and 1  
Return type: @return:page number at given offset, starting from 0*- **getPageSize** (pageIndex As Int) As com.shockwave.pdfium.util.SizeF
- **Initialize** (EventName As String)
- **Invalidate**
- **Invalidate2** (arg0 As android.graphics.Rect)
- **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **IsInitialized** As Boolean
- **jumpTo** (page As Int)
- **jumpTo2** (page As Int, withAnimation As Boolean)
*Go to the given page.  
page: Page index.*- **loadPages**
*Load all the parts around the center of the screen,  
 taking into account X and Y offsets, zoom level, and  
 the current page displayed*- **moveRelativeTo** (dx As Float, dy As Float)
*Move relatively to the current position.  
dx: The X difference you want to apply.  
dy: The Y difference you want to apply.*- **moveTo** (offsetX As Float, offsetY As Float)
- **moveTo2** (offsetX As Float, offsetY As Float, moveHandle As Boolean)
*Move to the given X and Y offsets, but check them ahead of time  
 to be sure not to go outside the the big strip.  
offsetX: The big strip X offset to use as the left border of the screen.  
offsetY: The big strip Y offset to use as the right border of the screen.  
moveHandle: whether to move scroll handle or not*- **onBitmapRendered** (part As com.github.barteksc.pdfviewer.model.PagePart)
*Called when a rendering task is over and  
 a PagePart has been freshly created.  
part: The created PagePart.*- **performPageSnap**
*Animate to the nearest snapping position for the current SnapPolicy*- **recycle**
- **RemoveView**
- **RequestFocus** As Boolean
- **resetZoom**
- **resetZoomWithAnimation**
- **SendToBack**
- **SetBackgroundImage** (arg0 As android.graphics.Bitmap) As BitmapDrawable
- **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
- **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
- **setPositionOffset2** (progress As Float, moveHandle As Boolean)
 *progress: must be between 0 and 1  
moveHandle: whether to move scroll handle*- **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)
- **stopFling**
- **toCurrentScale** (size As Float) As Float
- **toRealScale** (size As Float) As Float
- **useBestQuality** (bestQuality As Boolean)
- **zoomCenteredRelativeTo** (dzoom As Float, pivot As android.graphics.PointF)
- **zoomCenteredTo** (zoom As Float, pivot As android.graphics.PointF)
*Change the zoom level, relatively to a pivot point.  
 It will call moveTo() to make sure the given point stays  
 in the middle of the screen.  
zoom: The zoom level.  
pivot: The point on the screen that should stays.*- **zoomTo** (zoom As Float)
*Change the zoom level*- **zoomWithAnimation** (scale As Float)
- **zoomWithAnimation2** (centerX As Float, centerY As Float, scale As Float)

- **Properties:**

- **AnnotationRendering** As Boolean [read only]
- **Antialiasing** As Boolean [read only]
- **Background** As android.graphics.drawable.Drawable
- **BestQuality** As Boolean [read only]
- **Color** As Int [write only]
- **CurrentPage** As Int [read only]
- **CurrentXOffset** As Float [read only]
- **CurrentYOffset** As Float [read only]
- **documentFitsView** As Boolean [read only]
*Checks if whole document can be displayed on screen, doesn't include zoom*- **DocumentMeta** As com.shockwave.pdfium.PdfDocument.Meta [read only]
*Returns null if document is not loaded*- **Enabled** As Boolean
- **Height** As Int
- **Left** As Int
- **MaxZoom** As Float
- **MidZoom** As Float
- **MinZoom** As Float
- **NightMode** As Boolean [write only]
- **Padding** As Int()
- **PageCount** As Int [read only]
- **pageFillsScreen** As Boolean [read only]
- **PageFitPolicy** As com.github.barteksc.pdfviewer.util.FitPolicy [read only]
- **PageFling** As Boolean [write only]
- **PageSnap** As Boolean [write only]
- **Parent** As Object [read only]
- **PositionOffset** As Float
*Get current position as ratio of document length to visible area.  
 0 means that document start is visible, 1 that document end is visible*- **Recycled** As Boolean [read only]
- **SpacingPx** As Int [read only]
- **SwipeEnabled** As Boolean
- **SwipeVertical** As Boolean [read only]
- **TableOfContents** As java.util.List [read only]
*Will be empty until document is loaded*- **Tag** As Object
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int
- **Zoom** As Float [read only]
- **Zooming** As Boolean [read only]

- **PdfDocument**

- **Functions:**

- **hasPage** (index As Int) As Boolean
- **Initialize** (doc As com.shockwave.pdfium.PdfDocument)
- **IsInitialized** As Boolean

- **PdfDocumentMeta**

- **Functions:**

- **IsInitialized** As Boolean

- **Properties:**

- **CreationDate** As String [read only]
- **Creator** As String [read only]
- **Keywords** As String [read only]
- **ModDate** As String [read only]
- **Producer** As String [read only]
- **Subject** As String [read only]
- **Title** As String [read only]

- **PdfSize**

- **Functions:**

- **equals** (obj As Object) As Boolean
- **Initialize** (width As Int, height As Int)
- **IsInitialized** As Boolean

- **Properties:**

- **Height** As Int [read only]
- **Width** As Int [read only]

- **PdfiumCore**

- **Functions:**

- **closeDocument** (doc As com.shockwave.pdfium.PdfDocument)
*Release native resources and opened file*- **getDocumentMeta** (doc As com.shockwave.pdfium.PdfDocument) As com.shockwave.pdfium.PdfDocument.Meta
*Get metadata for given document*- **getNumFd** (fdObj As android.os.ParcelFileDescriptor) As Int
- **getPageCount** (doc As com.shockwave.pdfium.PdfDocument) As Int
*Get total numer of pages in document*- **getPageHeight** (doc As com.shockwave.pdfium.PdfDocument, index As Int) As Int
*Get page height in pixels. <br>  
 This method requires page to be opened.*- **getPageHeightPoint** (doc As com.shockwave.pdfium.PdfDocument, index As Int) As Int
*Get page height in PostScript points (1/72th of an inch).<br>  
 This method requires page to be opened.*- **getPageLinks** (doc As com.shockwave.pdfium.PdfDocument, pageIndex As Int) As java.util.List
*Get all links from given page*- **getPageSize** (doc As com.shockwave.pdfium.PdfDocument, index As Int) As com.shockwave.pdfium.util.Size
*Get size of page in pixels.<br>  
 This method does not require given page to be opened.*- **getPageWidth** (doc As com.shockwave.pdfium.PdfDocument, index As Int) As Int
*Get page width in pixels. <br>  
 This method requires page to be opened.*- **getPageWidthPoint** (doc As com.shockwave.pdfium.PdfDocument, index As Int) As Int
*Get page width in PostScript points (1/72th of an inch).<br>  
 This method requires page to be opened.*- **getTableOfContents** (doc As com.shockwave.pdfium.PdfDocument) As java.util.List
*Get table of contents (bookmarks) for given document*- **Initialize** (EventName As String)
- **loadComplete** (arg0 As Int)
- **mapPageCoordsToDevice** (doc As com.shockwave.pdfium.PdfDocument, pageIndex As Int, startX As Int, startY As Int, sizeX As Int, sizeY As Int, rotate As Int, pageX As Double, pageY As Double) As android.graphics.Point
*Map page coordinates to device screen coordinates  
doc: pdf document  
pageIndex: index of page  
startX: left pixel position of the display area in device coordinates  
startY: top pixel position of the display area in device coordinates  
sizeX: horizontal size (in pixels) for displaying the page  
sizeY: vertical size (in pixels) for displaying the page  
rotate: page orientation: 0 (normal), 1 (rotated 90 degrees clockwise),  
 2 (rotated 180 degrees), 3 (rotated 90 degrees counter-clockwise)  
pageX: X value in page coordinates  
pageY: Y value in page coordinate  
Return type: @return:mapped coordinates*- **mapRectToDevice** (doc As com.shockwave.pdfium.PdfDocument, pageIndex As Int, startX As Int, startY As Int, sizeX As Int, sizeY As Int, rotate As Int, coords As android.graphics.RectF) As android.graphics.RectF
 *Return type: @return:mapped coordinates*- **onPageChanged** (arg0 As Int, arg1 As Int)
- **onPageError** (arg0 As Int, arg1 As Throwable)
- **openPage** (doc As com.shockwave.pdfium.PdfDocument, pageIndex As Int) As Long
*Open page and store native pointer in {@link PdfDocument}*- **renderPage** (doc As com.shockwave.pdfium.PdfDocument, surface As android.view.Surface, pageIndex As Int, startX As Int, startY As Int, drawSizeX As Int, drawSizeY As Int)
*Render page fragment on {@link Surface}.<br>  
 Page must be opened before rendering.*- **renderPage2** (doc As com.shockwave.pdfium.PdfDocument, surface As android.view.Surface, pageIndex As Int, startX As Int, startY As Int, drawSizeX As Int, drawSizeY As Int, renderAnnot As Boolean)
*Render page fragment on {@link Surface}. This method allows to render annotations.<br>  
 Page must be opened before rendering.*- **renderPageBitmap** (doc As com.shockwave.pdfium.PdfDocument, bitmap As android.graphics.Bitmap, pageIndex As Int, startX As Int, startY As Int, drawSizeX As Int, drawSizeY As Int)
*Render page fragment on {@link Bitmap}.<br>  
 Page must be opened before rendering.  
 <p>  
 Supported bitmap configurations:  
 <ul>  
 <li>ARGB\_8888 - best quality, high memory usage, higher possibility of OutOfMemoryError  
 <li>RGB\_565 - little worse quality, twice less memory usage  
 </ul>*- **renderPageBitmap2** (doc As com.shockwave.pdfium.PdfDocument, bitmap As android.graphics.Bitmap, pageIndex As Int, startX As Int, startY As Int, drawSizeX As Int, drawSizeY As Int, renderAnnot As Boolean)
*Render page fragment on {@link Bitmap}. This method allows to render annotations.<br>  
 Page must be opened before rendering.  
 <p>  
 For more info see {@link PdfiumCore#renderPageBitmap(PdfDocument, Bitmap, int, int, int, int, int)}*
  

```B4X
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Private btnFirst As Button  
    Private btnPrev As Button  
    Private lblPages As Label  
    Private btnNext As Button  
    Private btnLast As Button  
    Private glPages As Int  
    Dim pdf As PdfiumCore  
    Private PDFView1 As PDFView  
End Sub  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("Layout1")  
    pdf.Initialize("PDFium")  
    File.Copy(File.DirAssets,"sample.pdf",File.DirInternal,"sample.pdf")  
    Dim cfg As Configurator = PDFView1.fromUri(File.DirInternal,"sample.pdf")  
    cfg.SetEventname("PDFium")  
    cfg.autoSpacing(True).enableSwipe(True).pageSnap(True).swipeHorizontal(False).addOnErrorListener.addOnLoadCompleteListener.addOnPageChangeListener.addOnPageErrorListener.addOnTapListener.load  
End Sub  
  
Sub PDFium_loadComplete(pages As Int)  
    Log($"PDFium_loadComplete(${pages})"$)  
    glPages = pages  
    lblPages.Text = $"${glPages}"$  
End Sub  
Sub PDFium_onInitiallyRendered(page As Int)
```

  
  
  
Due to the Size of the native .so Files the library is big (18mb) and can be downloaded from my Dropbox.  
The Example is to big (2mb) too so it is available on Dropbox too.  
  
> Copyright 2017 Bartosz Schiller  
>   
> Licensed under the Apache License, Version 2.0 (the "License");  
> you may not use this file except in compliance with the License.  
> You may obtain a copy of the License at  
>   
>  <http://www.apache.org/licenses/LICENSE-2.0>  
>   
> Unless required by applicable law or agreed to in writing, software  
> distributed under the License is distributed on an "AS IS" BASIS,  
> WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
> See the License for the specific language governing permissions and  
> limitations under the License.

  
Please respect License if you want to use it in your project.  
  

[[SIZE=7]Download HERE[/SIZE]](https://www.dropbox.com/sh/j7eymu1gyg583qt/AAC4mo-M-PP6gAlRht7sU8pGa?dl=0)

  
[SIZE=5]Linked Tutorials:[/SIZE]  
- [Access to the PDF Pages and create a Bitmap containing a specific Page](https://www.b4x.com/android/forum/threads/pdfium-pdfview2.102756/#post-644710).