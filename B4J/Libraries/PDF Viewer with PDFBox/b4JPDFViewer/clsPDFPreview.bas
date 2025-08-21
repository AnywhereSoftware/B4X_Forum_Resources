B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
Sub Class_Globals
	Private fFx As JFX
	Private fCallback As Object
	Private fEventName As String
	Private fFrm As Form
	Private btns As List
	Private panePDF As Pane
	Dim PDFViewer As clsPDFViewer
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(aCallback As Object,aEventName As String,Parent As Form,abuffer() As Byte,azoom As Float,acustombuttons As List)
	fCallback=aCallback
	fEventName=aEventName
	fFrm.Initialize("fFrm",600,500)
	LoadButtons(acustombuttons)
	LoadPanePDF
	PDFViewer.Initialize(Me,"PDFViewer",panePDF,1)
	fFrm.SetOwner(Parent)

	Dim Obj As Reflector
	Obj.Target = fFrm.RootPane
	Obj.AddEventHandler("rootpane_KeyPressed", "javafx.scene.input.KeyEvent.ANY")
	LoadPDFStream(abuffer)
	updateTitle(PDFViewer.getActivePage,PDFViewer.NumberOfPages,PDFViewer.getZoom)
End Sub

Private Sub updateTitle(apage As Int,apages As Int,azoom As Float)
	fFrm.Title=$"Page ${apage+1}/${apages} - Zoom ${NumberFormat2(azoom*100,1,0,0,False)}%"$ 
End Sub

private Sub LoadPDFStream(abuffer() As Byte)
	Dim ist As InputStream
	ist.InitializeFromBytesArray(abuffer,0,abuffer.Length)
	If PDFViewer.loadFromStream(ist) Then
	End If
End Sub

private Sub LoadPanePDF
	panePDF.Initialize("panePDF")
	fFrm.RootPane.AddNode(panePDF,0,100,fFrm.RootPane.Width,fFrm.RootPane.Height-100)	
End Sub

Private Sub LoadButtons(acustombuttons As List)
	Dim l As Int
	Dim buttons As List
	buttons.Initialize
	buttons.Add(CreateMap("image":"F100","tag":"first","hint":"F2 - First Page"))
	buttons.Add(CreateMap("image":"F104","tag":"previous","hint":"F3 - Previous Page"))
	buttons.Add(CreateMap("image":"F105","tag":"next","hint":"F4 - Next Page"))
	buttons.Add(CreateMap("image":"F101","tag":"last","hint":"F5 - Last Page"))
	buttons.Add(CreateMap("image":"F068","tag":"zoom-","hint":"F6 - Zoom -"))
	buttons.Add(CreateMap("image":"F067","tag":"zoom+","hint":"F7 - Zoom +"))
	buttons.Add(CreateMap("image":"F02F","tag":"print","hint":"F8 - Print"))
	buttons.Add(CreateMap("image":"F0C7","tag":"save","hint":"F9 - Save As"))
	If acustombuttons.IsInitialized Then
		buttons.AddAll(acustombuttons)
	End If
	btns.Initialize
	l=0
	For i=0 To buttons.Size-1
		Dim m As Map=buttons.Get(i)
		Dim b As Button
		b.Initialize("btn")
		b.Font=fFx.CreateFontAwesome(40)
		b.Text=Chr(Bit.ParseInt(m.GetDefault("image","0"),16))
		b.TooltipText=m.GetDefault("hint","")
		b.Tag=m
		btns.Add(b)
		fFrm.rootpane.AddNode(b,l,0,100,100)
		l=l+100
	Next
End Sub

Private Sub rootpane_KeyPressed_Event(e As Event)
	Dim KE As Reflector
	KE.Target = e
	Dim KeyCode As String = KE.RunMethod("getCode")
	Dim EventType As String = KE.RunMethod("getEventType")
	Select EventType
		Case "KEY_RELEASED"
			For i=0 To btns.Size-1
				Dim b As Button=btns.Get(i)
				If b.TooltipText.StartsWith(KeyCode & " - ") Then
					buttonClick(b.Tag)
					e.Consume
				End If
			Next
	End Select
End Sub

Public Sub fFrm_resize(Width As Double, Height As Double)
	panePDF.SetSize(Width,Height-100)
End Sub

Public Sub panePDF_resize(Width As Double, Height As Double)
	If PDFViewer.IsInitialized Then
		PDFViewer.containerResize(Width,Height)
	End If
End Sub

Public Sub Show
	fFrm.ShowAndWait
End Sub

private Sub buttonClick(atag As Map)
	Select Case atag.GetDefault("tag","")
		Case "first"
			PDFViewer.ActivePage=0
		Case "previous"
			PDFViewer.ActivePage=PDFViewer.ActivePage-1
		Case "next"
			PDFViewer.ActivePage=PDFViewer.ActivePage+1
		Case "last"
			PDFViewer.ActivePage=PDFViewer.getNumberOfPages-1
		Case "zoom-"
			PDFViewer.Zoom=PDFViewer.Zoom-0.1
		Case "zoom+"
			PDFViewer.Zoom=PDFViewer.Zoom+0.1
		Case "print"
			PDFViewer.printDoc(True)
		Case "save"
			Dim fc As FileChooser
			fc.Initialize
			fc.SetExtensionFilter("Fichier PDF",Array As String("*.pdf"))
			Dim fileName As String = fc.ShowSave(fFrm)
			PDFViewer.savetofile(fileName)
		Case Else
			CallSub3(fCallback,fEventName & "_" & atag.GetDefault("tag",""),PDFViewer,atag)
	End Select
End Sub

Sub btn_click
	Dim b As Button=Sender
	buttonClick(b.Tag)
End Sub

Sub pdfViewer_pageChanged(apage As Int)
	updateTitle(apage,PDFViewer.NumberOfPages,PDFViewer.Zoom)
End Sub

Sub pdfViewer_zoomChanged(aZoom As Float)
	updateTitle(PDFViewer.ActivePage,PDFViewer.NumberOfPages,aZoom)
End Sub