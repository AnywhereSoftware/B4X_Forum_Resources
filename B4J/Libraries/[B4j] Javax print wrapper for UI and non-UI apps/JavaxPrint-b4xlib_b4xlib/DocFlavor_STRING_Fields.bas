B4J=true
Group=DocFlavor
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Code Module
Sub Process_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
End Sub

'Doc flavor with MIME type = 'text/html; charset=utf-16', print data representation class name = 'java.lang.String'.
Public Sub TEXT_HTML As DocFlavor_STRING
	Dim Wrapper As DocFlavor_STRING
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.STRING")
	Wrapper.SetObject(Tjo.GetField("TEXT_HTML"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = 'text/plain; charset=utf-16', print data representation class name = 'java.lang.String'.
Public Sub TEXT_PLAIN As DocFlavor_STRING
	Dim Wrapper As DocFlavor_STRING
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.STRING")
	Wrapper.SetObject(Tjo.GetField("TEXT_PLAIN"))
	Return Wrapper
End Sub

