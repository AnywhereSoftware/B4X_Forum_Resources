B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.82
@EndOfDesignText@
' download https://www.apache.org/dyn/closer.lua/pdfbox/2.0.26/pdfbox-app-2.0.26.jar
' added	#AdditionalJar: pdfbox-app-2.0.26.jar
' see this link for original code
' https://www.b4x.com/android/forum/threads/pdfboxwrapper-class-module-show-pdf-document-in-b4j.103350/#post-647789

#IgnoreWarnings: 2,9

Sub Class_Globals
	Private myEventName As String
	Private myCallback As Object
	Private xui As XUI
	
	Type PDFrectangle (x As Double, y As Double, width As Double, height As Double,index As Int, imv As ImageView, imageIsSet As Boolean)

	Private thisDoc As JavaObject
	Private renderer As JavaObject
	Private utils As JavaObject
	Private myZoom As Float
	Private PagesRects As List
	Private const pageSpace As Float = 6
	Private const LeftRightSpace As Float = 6
	Private myDocName As String

	Private DocIsLoaded As Boolean
	Private isRenderingPages As Boolean
	
	Private pneMyPages As Pane
	Private maxwidth As Float
	Private stopRenderingPages As Boolean
End Sub

'Initializes the object.
'  CallBack:   module that receives events
'  EventName:  event prefix
'  Document:   path and filename to PDF-document to view
'  Pane:       pane for the viewer
'  Layoutname: The layout for the viewer. Must contain a ScrollPane namedm "myScrollPane". Optional is nodes called: "SpinnerZoom", "SpinnerPageNumber" and "LabelFileName"
'  Zoom:       View Zoom of the document (1=100%)
'Returns true if document was succesfull loaded
Public Sub Initialize(CallBack As Object, EventName As String, Zoom As Float, MaxWidthView as Float) As Boolean
	myEventName = EventName
	myCallback = CallBack

	utils.InitializeStatic("javafx.embed.swing.SwingFXUtils")
	pneMyPages.Initialize("")
	maxwidth=MaxWidthView
	ResetNodes
End Sub
Private Sub ResetNodes
	pneMyPages.RemoveAllNodes
	PagesRects.Initialize
	pneMyPages.PrefHeight = 0
	pneMyPages.PrefWidth = 05
End Sub

Public Sub getPanelAllPage As Pane
	Return getPanelAllPage
End Sub

'Gives the number of pages in loaded PDF-document, give 0 if no loaded document
public Sub getNumberOfPages() As Int
	If DocIsLoaded Then
		Return thisDoc.RunMethod("getNumberOfPages",Array())
	Else
		Return 0
	End If
End Sub

'convert 
Public Sub StringZoomToFloat(Zoom As String) As Float
	Return Zoom.Replace("%","")/100
End Sub
Public Sub FloatZoomToString(Zoom As Float) As String
	Return Round2(Zoom * 100,1) & "%"
End Sub

'Open PDF file 
'  Stream:	  inputstream E.g. from GetInputStream methode on HttpJob object
'  Zoom:      View Zoom of the document (1=100%)
'  DescriptiveName: a text to show in viewer E.g. the URL used to get inputstream from HttpJob
'returns true: no error, false: error opening file
public Sub loadDocumentFromInputStream(Stream As InputStream, Zoom As Float, DescriptiveName As String) As Boolean
	Try		
		Dim PDDocument As JavaObject
		PDDocument.InitializeStatic("org.apache.pdfbox.pdmodel.PDDocument")
		thisDoc = PDDocument.RunMethod("load",Array(Stream))
		renderer.InitializeNewInstance("org.apache.pdfbox.rendering.PDFRenderer",Array(thisDoc))
		myDocName = DescriptiveName
		DocIsLoaded = True
		Repaint(Zoom)
		Return True
	Catch
		DocIsLoaded = False
		ResetNodes
		Return False
	End Try
End Sub

'Open PDF file 
'  name: path + filename
'  Zoom:      View Zoom of the document (1=100%)
'returns true: no error, false: error opening file
public Sub loadDocument(name As String, Zoom As Float) As Boolean
	Try
		Dim fi As JavaObject
		fi.InitializeNewInstance("java.io.File",Array(name))
		Dim PDDocument As JavaObject 
		PDDocument.InitializeStatic("org.apache.pdfbox.pdmodel.PDDocument")
		thisDoc = PDDocument.RunMethod("load",Array(fi))
		renderer.InitializeNewInstance("org.apache.pdfbox.rendering.PDFRenderer",Array(thisDoc))
		myDocName = name
		DocIsLoaded = True

		Repaint(Zoom)
		Return True
	Catch
		DocIsLoaded = False
		ResetNodes
	
		Return False
	End Try
End Sub

public Sub loadDocumentFromInputStreamToImage(Stream As InputStream, PageNum As Int, DescriptiveName As String) As Image
	Try		
		Dim PDDocument As JavaObject
		PDDocument.InitializeStatic("org.apache.pdfbox.pdmodel.PDDocument")
		thisDoc = PDDocument.RunMethod("load",Array(Stream))
		renderer.InitializeNewInstance("org.apache.pdfbox.rendering.PDFRenderer",Array(thisDoc))
		myDocName = DescriptiveName
		DocIsLoaded = True
		
		Return PageToImage(PageNum)
	Catch
		DocIsLoaded = False
		ResetNodes
		Return Null
	End Try
End Sub

public Sub loadDocumentToImage(name As String, PageNum As Int) As Image
	Try
		Dim fi As JavaObject
		fi.InitializeNewInstance("java.io.File",Array(name))
		Dim PDDocument As JavaObject
		PDDocument.InitializeStatic("org.apache.pdfbox.pdmodel.PDDocument")
		thisDoc = PDDocument.RunMethod("load",Array(fi))
		renderer.InitializeNewInstance("org.apache.pdfbox.rendering.PDFRenderer",Array(thisDoc))
		myDocName = name
		DocIsLoaded = True
		Return PageToImage(PageNum)
	Catch
		DocIsLoaded = False
		ResetNodes
		Return Null
	End Try
End Sub

'Unloads an open document
public Sub closeDocument()
	If thisDoc.IsInitialized Then thisDoc.RunMethod("close",Null)
	DocIsLoaded = False
	ResetNodes
	Repaint(1)
End Sub
'Gives an rendered image of one page in specified Zoom
'   Zoom:    1 is 100% size on stage screen dpi
public Sub renderPage(p As Int, Zoom As Float) As Image
	If DocIsLoaded Then
		Dim scrn As JavaObject
		Dim dpi As Float = scrn.InitializeStatic("javafx.stage.Screen").RunMethodJO("getPrimary",Null).RunMethod("getDpi",Null)
		Dim img As Object = renderer.RunMethod("renderImageWithDPI",Array(p,dpi*Zoom))
		Return utils.RunMethodjo("toFXImage",Array(img,Null))
	Else
		Return Null
	End If
End Sub
'Gives the rotation angle for the specified page in degrees
Public Sub getRotationAngle(page As Int) As Int
	Return thisDoc.RunMethodJO("getPage",Array(page)).RunMethod("getRotation",Null)
End Sub
'Gives the Page size in pixels Zoomd to specified Zoom and with stage screen dpi
'   Zoom:    1 is 100% size on stage screen dpi
Public Sub getPageSizeInPixels(p As Int, Zoom As Float) As PDFrectangle
	Dim scrn As JavaObject
	Dim dpi As Float = scrn.InitializeStatic("javafx.stage.Screen").RunMethodJO("getPrimary",Null).RunMethod("getDpi",Null)
	Dim pg As JavaObject = thisDoc.RunMethodJO("getPage",Array(p))
	Dim r As PDFrectangle
	r.Initialize
	Dim mb As JavaObject = pg.RunMethodJO("getMediaBox",Null)
	If getRotationAngle(p) Mod 180 = 0 Then
		r.height = Floor( mb.RunMethod("getHeight",Null) / 72 * dpi * Zoom)
		r.width = Floor( mb.RunMethod("getWidth",Null) / 72 * dpi * Zoom)
	Else
		r.height = Floor( mb.RunMethod("getWidth",Null) / 72 * dpi * Zoom)
		r.width = Floor( mb.RunMethod("getHeight",Null) / 72 * dpi * Zoom)
	End If
	Return r
End Sub

Public Sub PageToImage(PageNum As Int) As Image
	If DocIsLoaded And PageNum<getNumberOfPages Then
		If stopRenderingPages Then
			Return Null 'Repaint is already running and waiting for the pagerendering to stop
		else If isRenderingPages Then
			Return Null
		End If
			
		Return renderPage(PageNum,1)
	Else
		Return Null
	End If
End Sub

'Repaint all pages in document on the viewer scrollpane
'This is as Resumable sub that returns controll to the caller when 
'all page sizes is calculated and the first page is rendered.
'The rendering continues one page a time after the message cue is processed,
'until all pages are rendered
'   Zoom:    1 is 100% size on stage screen dpi
Public Sub Repaint(Zoom As Float)
	If DocIsLoaded Then 
		If stopRenderingPages Then
			Return 'Repaint is already running and waiting for the pagerendering to stop
		else If isRenderingPages Then 
			stopRenderingPages = True
			Wait For RenderingPagesFinished
		End If
		Dim newZoom As Float
		If Round2(Zoom,1) < 0.1 Then
			newZoom = 0.1
		Else if Round2(Zoom,1) > 2 Then
			newZoom = 2
		Else
			newZoom = Round2( Zoom,2)
		End If
		If newZoom <> myZoom Then 
			myZoom = newZoom
		End If
		pneMyPages.RemoveAllNodes
		PagesRects.Initialize
		Dim ypos As Float


		For i = 0 To getNumberOfPages - 1
			Dim rect As PDFrectangle = getPageSizeInPixels(i,myZoom)
			rect.imv.Initialize("")
			rect.y = ypos
			rect.index = i
			If maxwidth < rect.width + LeftRightSpace * 2 Then maxwidth = rect.width + LeftRightSpace * 2
			ypos = ypos + rect.height + pageSpace
			PagesRects.add(rect)
		Next		
		pneMyPages.PrefWidth = maxwidth 
		For i = 0 To getNumberOfPages - 1
			rect = PagesRects.Get(i)
			rect.x = (maxwidth - rect.width)/2
			Dim pne As Pane
			pne.Initialize("")
			pne.As(B4XView).Color=xui.Color_White
			pne.AddNode(rect.imv,0,0,-1,-1)
			pneMyPages.AddNode(pne,rect.x,rect.y + pageSpace/2, rect.width,rect.height)
			rect.width = rect.Width + LeftRightSpace * 2
			rect.height = rect.Height + pageSpace
		Next
		isRenderingPages = True
		For i = 0 To getNumberOfPages - 1
			rect = PagesRects.Get(i)
			If rect.imageIsSet = False Then
				rect.imv.SetImage(renderPage(i,myZoom))
				rect.imageIsSet = True
			End If
			Sleep(0)
			If stopRenderingPages = True Then 
				stopRenderingPages = False
				CallSubDelayed(Me,"RenderingPagesFinished")
				Exit
			End If
		Next
		isRenderingPages = False
	End If
End Sub

'Gives the path and filename to loaded document
Public Sub getDocName As String
	Return myDocName
End Sub
