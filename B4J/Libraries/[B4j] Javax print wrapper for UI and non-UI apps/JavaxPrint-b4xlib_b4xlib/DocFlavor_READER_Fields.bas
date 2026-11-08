B4J=true
Group=DocFlavor
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

'Doc flavor with MIME type = "text/html; charset=utf-16", print data representation class name = "java.io.Reader" (character stream).
Public Sub TEXT_HTML As DocFlavor_READER
	Dim Wrapper As DocFlavor_READER
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.READER")
	Wrapper.SetObject(Tjo.GetField("TEXT_HTML"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "text/plain; charset=utf-16", print data representation class name = "java.io.Reader" (character stream).
Public Sub TEXT_PLAIN As DocFlavor_READER
	Dim Wrapper As DocFlavor_READER
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.READER")
	Wrapper.SetObject(Tjo.GetField("TEXT_PLAIN"))
	Return Wrapper
End Sub
