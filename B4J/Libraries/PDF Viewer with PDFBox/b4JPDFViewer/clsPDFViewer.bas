B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.82
@EndOfDesignText@
Sub Class_Globals
	Private fEventName As String
	Private fCallback As Object
	Private fDoc As JavaObject
	Private fIsRendering As Boolean=False
	Private fRenderer As JavaObject
	Private fUtils As JavaObject
	Private fContainer As Pane
	Private fPage As Pane
	Private fScrollPane As ScrollPane
	Private fZoom As Float
	Private fActivePage As Int
	Type PDFrectangle (width As Double, height As Double, imv As ImageView, imageIsSet As Boolean)
	Private fDocIsLoaded As Boolean
End Sub

Public Sub Initialize(aCallBack As Object, aEventName As String, aPane As Pane, aZoom As Float) 
	fEventName = aEventName
	fCallback = aCallBack
	fContainer = aPane
	fZoom=aZoom
	fScrollPane.Initialize("")
	fContainer.AddNode(fScrollPane,0,0,fContainer.Width,fContainer.Height)
	fUtils.InitializeStatic("javafx.embed.swing.SwingFXUtils")
	fPage.Initialize("")
	fScrollPane.InnerNode=fPage
End Sub

public Sub getNumberOfPages As Int
	If fDocIsLoaded Then
		Return fDoc.RunMethod("getNumberOfPages",Array())
	Else
		Return 0
	End If
End Sub

public Sub getActivePage As Int
	If fDocIsLoaded Then
		Return fActivePage
	Else
		Return -1
	End If
End Sub

public Sub setActivePage(apage As Int) 
	If (apage>=0) And (apage<getNumberOfPages) Then
		fActivePage=apage
		If Repaint Then
			CallSub2(fCallback,fEventName&  "_pageChanged",fActivePage)
		Else
			CallSubDelayed(Me,Repaint) 
		End If
	End If
End Sub

public Sub getZoom As Float
	If fDocIsLoaded Then
		Return fZoom
	Else
		Return 0
	End If
End Sub

public Sub setZoom(azoom As Float)
	azoom=Round2(azoom,1)
	If (azoom>=0.1) And (azoom<=2) Then
		fZoom=azoom
		If Repaint Then
			CallSub2(fCallback,fEventName&  "_zoomChanged",fZoom)
		Else
			CallSubDelayed(Me,Repaint)
		End If
	End If
End Sub

public Sub loadFromFile(aname As String) As Boolean
	Try
		closeDocument
		Dim fi As JavaObject
		fi.InitializeNewInstance("java.io.File",Array(aname))
		Dim PDDocument As JavaObject 
		PDDocument.InitializeStatic("org.apache.pdfbox.pdmodel.PDDocument")
		fDoc = PDDocument.RunMethod("load",Array(fi))
		fRenderer.InitializeNewInstance("org.apache.pdfbox.rendering.PDFRenderer",Array(fDoc))
		fDocIsLoaded = True
		If getNumberOfPages>0 Then
			fActivePage=0
		Else
			fActivePage=-1
		End If
		Repaint
		Return True
	Catch
		fDocIsLoaded = False
		Return False
	End Try
End Sub

public Sub loadFromStream(astream As InputStream) As Boolean
	Try
		closeDocument
		Dim PDDocument As JavaObject
		PDDocument.InitializeStatic("org.apache.pdfbox.pdmodel.PDDocument")
		fDoc = PDDocument.RunMethod("load",Array(astream))
		fRenderer.InitializeNewInstance("org.apache.pdfbox.rendering.PDFRenderer",Array(fDoc))
		fDocIsLoaded = True
		Repaint
		Return True
	Catch
		fDocIsLoaded = False
		Return False
	End Try
End Sub

public Sub closeDocument()
	If fDoc.IsInitialized Then 
		fDoc.RunMethod("close",Null)
	End If
	fDocIsLoaded = False
	fPage.RemoveAllNodes
End Sub

private  Sub renderPage(apage As Int, aZoom As Float) As Image
	If fDocIsLoaded Then
		Dim scrn As JavaObject
		Dim dpi As Float = scrn.InitializeStatic("javafx.stage.Screen").RunMethodJO("getPrimary",Null).RunMethod("getDpi",Null)
		Dim dpizoom As Float=dpi*aZoom
		Dim img As Object = fRenderer.RunMethod("renderImageWithDPI",Array(apage,dpizoom))
		Return fUtils.RunMethodjo("toFXImage",Array(img,Null))
	Else
		Return Null
	End If
End Sub

private Sub getRotationAngle(apage As Int) As Int
	Return fDoc.RunMethodJO("getPage",Array(apage)).RunMethod("getRotation",Null)
End Sub

private Sub getPageSizeInPixels(apage As Int, aZoom As Float) As PDFrectangle
	Dim scrn As JavaObject
	Dim dpi As Float = scrn.InitializeStatic("javafx.stage.Screen").RunMethodJO("getPrimary",Null).RunMethod("getDpi",Null)
	Dim pg As JavaObject = fDoc.RunMethodJO("getPage",Array(apage))
	Dim r As PDFrectangle
	r.Initialize
	Dim mb As JavaObject = pg.RunMethodJO("getMediaBox",Null)
	If getRotationAngle(apage) Mod 180 = 0 Then
		r.height = Floor( mb.RunMethod("getHeight",Null) / 72 * dpi * aZoom)
		r.width = Floor( mb.RunMethod("getWidth",Null) / 72 * dpi * aZoom)
	Else
		r.height = Floor( mb.RunMethod("getWidth",Null) / 72 * dpi * aZoom)
		r.width = Floor( mb.RunMethod("getHeight",Null) / 72 * dpi * aZoom)
	End If
	Return r
End Sub

private Sub Repaint As Boolean
	If (fDocIsLoaded=False) Or (fIsRendering) Then 
		Return False
	End If
	
	fIsRendering=True
	fPage.RemoveAllNodes
	Dim rect As PDFrectangle = getPageSizeInPixels(fActivePage,fZoom)
	rect.imv.Initialize("")

	If rect.imageIsSet = False Then
		rect.imv.SetImage(renderPage(fActivePage,fZoom))
		rect.imageIsSet = True
	End If

	fPage.SetLayoutAnimated(0,0,0,rect.width,rect.height)
	fPage.AddNode(rect.imv,Max((fScrollPane.Width-rect.width)/2,0),Max((fScrollPane.height-rect.height)/2,0),rect.Width,rect.Height)
	fIsRendering=False
	Return True
End Sub

public Sub printDoc(awithDialog As Boolean)
	callJava(Me,"doPrint",Array(fDoc,awithDialog))
End Sub

private Sub callJava(aOwner As JavaObject,aMethod As String,aParams() As Object)
	aOwner.RunMethod(aMethod,aParams)
End Sub

#if java
	import java.awt.print.PrinterException;
	import java.awt.print.PrinterJob;
	import java.io.File;
	import java.io.IOException;
	import org.apache.pdfbox.pdmodel.PDDocument;
	import org.apache.pdfbox.printing.PDFPageable;

	public void doPrint(PDDocument doc,boolean withDialog) throws IOException, PrinterException {
		try {
			PrinterJob job = PrinterJob.getPrinterJob();
			job.setPageable(new PDFPageable(doc));
			if((!withDialog) || (job.printDialog())){
				job.print();
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}
#end if

public Sub containerResize (aWidth As Double, aHeight As Double)
	If fScrollPane.IsInitialized Then
		fScrollPane.SetSize(aWidth,aHeight)
	End If
End Sub

public Sub saveToFile(afilename As String)
	If afilename.Trim<>"" Then
		fDoc.RunMethod("save",Array(afilename))
	End If
End Sub

