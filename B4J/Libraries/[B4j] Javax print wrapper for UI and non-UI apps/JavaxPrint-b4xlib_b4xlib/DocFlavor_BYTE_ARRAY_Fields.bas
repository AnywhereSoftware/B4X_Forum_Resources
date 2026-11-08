B4J=true
Group=DocFlavor
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Code Module
Sub Process_Globals
	
End Sub

'Doc flavor with MIME type = "application/octet-stream", print data representation class name = "[B" (byte array).
Public Sub AUTOSENSE As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("AUTOSENSE"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "image/gif", print data representation class name = "[B" (byte array).
Public Sub GIF As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("GIF"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "image/jpeg", print data representation class name = "[B" (byte array).
Public Sub JPEG As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("JPEG"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "application/vnd.hp-PCL", print data representation class name = "[B" (byte array).
Public Sub PCL As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("PCL"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "application/pdf", print data representation class name = "[B" (byte array).
Public Sub PDF As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("PDF"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "image/png", print data representation class name = "[B" (byte array).
Public Sub PNG As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("PNG"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "application/postscript", print data representation class name = "[B" (byte array).
Public Sub POSTSCRIPT As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("POSTSCRIPT"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "text/html", encoded in the host platform encoding.
Public Sub TEXT_HTML_HOST As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("TEXT_HTML_HOST"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "text/html; charset=us-ascii", print data representation class name = "[B" (byte array).
Public Sub TEXT_HTML_US_ASCII As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("TEXT_HTML_US_ASCII"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "text/html; charset=utf-16", print data representation class name = "[B" (byte array).
Public Sub TEXT_HTML_UTF_16 As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("TEXT_HTML_UTF_16"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "text/html; charset=utf-16be" (big-endian byte ordering), print data representation class name = "[B" (byte array).
Public Sub TEXT_HTML_UTF_16BE As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("TEXT_HTML_UTF_16BE"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "text/html; charset=utf-16le" (little-endian byte ordering), print data representation class name = "[B" (byte array).
Public Sub TEXT_HTML_UTF_16LE As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("TEXT_HTML_UTF_16LE"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "text/html; charset=utf-8", print data representation class name = "[B" (byte array).
Public Sub TEXT_HTML_UTF_8 As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("TEXT_HTML_UTF_8"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "text/plain", encoded in the host platform encoding.
Public Sub TEXT_PLAIN_HOST As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("TEXT_PLAIN_HOST"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "text/plain; charset=us-ascii", print data representation class name = "[B" (byte array).
Public Sub TEXT_PLAIN_US_ASCII As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("TEXT_PLAIN_US_ASCII"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "text/plain; charset=utf-16", print data representation class name = "[B" (byte array).
Public Sub TEXT_PLAIN_UTF_16 As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("TEXT_PLAIN_UTF_16"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "text/plain; charset=utf-16be" (big-endian byte ordering), print data representation class name = "[B" (byte array).
Public Sub TEXT_PLAIN_UTF_16BE As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("TEXT_PLAIN_UTF_16BE"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "text/plain; charset=utf-16le" (little-endian byte ordering), print data representation class name = "[B" (byte array).
Public Sub TEXT_PLAIN_UTF_16LE As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("TEXT_PLAIN_UTF_16LE"))
	Return Wrapper
End Sub

'Doc flavor with MIME type = "text/plain; charset=utf-8", print data representation class name = "[B" (byte array).
Public Sub TEXT_PLAIN_UTF_8 As DocFlavor_BYTE_ARRAY
	Dim Wrapper As DocFlavor_BYTE_ARRAY
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.DocFlavor.BYTE_ARRAY")
	Wrapper.SetObject(Tjo.GetField("TEXT_PLAIN_UTF_8"))
	Return Wrapper
End Sub

