B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
	Type PainterType(CallBack As Object,EventName As String, PF As PageFormat, NumPages As Int, Painter As Object)
	Private PainterList As List
	Private Tjo As JavaObject
End Sub

'Creates a new, empty Book.
Public Sub Initialize
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("java.awt.print.Book",Null)
	PainterList.Initialize
End Sub

Public Sub UNKNOWN_NUMBER_OF_PAGES As Int
	Return Tjo.GetField("UNKNOWN_NUMBER_OF_PAGES")
End Sub


''Appends a single page to the end of this Book.
'Public Sub Append(Painter As Object, Page As PageFormat)
'	If JavaxPrint_Utils.IsPackageObject(Painter) Then Painter = CallSub(Painter,"GetObject")
'	Tjo.RunMethod("append",Array As Object(Painter, Page.GetObject))
'End Sub
''Appends numPages pages to the end of this Book.
'Public Sub Append2(Painter As Object, Page As PageFormat, NumPages As Int)
'	Tjo.RunMethod("append",Array As Object(Painter, Page.GetObject, NumPages))
'End Sub
'Appends a single page to the end of this Book.
Public Sub Append(CallBack As Object,EventName As String, Page As PageFormat)
'	If JavaxPrint_Utils.IsPackageObject(Painter) Then Painter = CallSub(Painter,"GetObject")
'	Tjo.RunMethod("append",Array As Object(Painter, Page.GetObject))
	PainterList.Add(CreatePainterType(CallBack,EventName,Page))
End Sub
'Appends numPages pages to the end of this Book.
Public Sub Append2(CallBack As Object,EventName As String, Page As PageFormat, NumPages As Int)
	For i = 0 To NumPages - 1
		PainterList.Add(CreatePainterType(CallBack,EventName,Page))
	Next
End Sub
'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Returns the number of pages in this Book.
Public Sub GetNumberOfPages As Int
	Return Tjo.RunMethod("getNumberOfPages",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Returns the PageFormat of the page specified by pageIndex.
Public Sub GetPageFormat(PageIndex As Int) As PageFormat
	Dim O As Object = Tjo.RunMethod("getPageFormat",Array As Object(PageIndex))
	Dim Wrapper As PageFormat
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Returns the Printable instance responsible for rendering the page specified by pageIndex.
Public Sub GetPrintable(PageIndex As Int) As JavaObject
	Return Tjo.RunMethod("getPrintable",Array As Object(PageIndex))
End Sub
'Sets the PageFormat and the Painter for a specified page number.
Public Sub SetPage(PageIndex As Int, CallBack As Object,EventName As String, Page As PageFormat)
	'Let an out of bounds exception be raiese if it needs to be
	PainterList.Set(PageIndex,CreatePainterType(CallBack,EventName,Page))
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

'Returns a list of PainterType
Public Sub GetPainterLIst As List
	Return PainterList
End Sub

Public Sub CreatePainterType (CallBack As Object, EventName As String, PF As PageFormat) As PainterType
	Dim t1 As PainterType
	t1.Initialize
	t1.CallBack = CallBack
	t1.EventName = EventName
	t1.PF = PF
	Return t1
End Sub

Public Sub CreatePainterType2 (PF As PageFormat,Painter As Object) As PainterType
	Dim t1 As PainterType
	t1.Initialize
	t1.Painter = Painter
	t1.PF = PF
	Return t1
End Sub