B4J=true
Group=DocFlavor
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

'Service formatted print data doc flavor with print data representation class name = "java.awt.print.Pageable" (pageable object).
Public Sub PAGEABLE As DocFlavor_SERVICE_FORMATTED
	Dim Wrapper As DocFlavor_SERVICE_FORMATTED
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.SERVICE_FORMATTED")
	Wrapper.SetObject(Tjo.GetField("PAGEABLE"))
	Return Wrapper
End Sub

'Service formatted print data doc flavor with print data representation class name = "java.awt.print.Printable" (printable object).
Public Sub PRINTABLE As DocFlavor_SERVICE_FORMATTED
	Dim Wrapper As DocFlavor_SERVICE_FORMATTED
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.SERVICE_FORMATTED")
	Wrapper.SetObject(Tjo.GetField("PRINTABLE"))
	Return Wrapper
End Sub

'Service formatted print data doc flavor with print data representation class name = "java.awt.image.renderable.RenderableImage" (renderable image object).
Public Sub RENDERABLE_IMAGE As DocFlavor_SERVICE_FORMATTED
	Dim Wrapper As DocFlavor_SERVICE_FORMATTED
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.SERVICE_FORMATTED")
	Wrapper.SetObject(Tjo.GetField("RENDERABLE_IMAGE"))
	Return Wrapper
End Sub
