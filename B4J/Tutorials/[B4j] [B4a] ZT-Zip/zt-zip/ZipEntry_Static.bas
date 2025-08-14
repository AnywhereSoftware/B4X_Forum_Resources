B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.51
@EndOfDesignText@
'Code Module
Sub Process_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
End Sub

'
Public Sub CENATT As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENATT")
End Sub

'
Public Sub CENATX As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENATX")
End Sub

'
Public Sub CENCOM As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENCOM")
End Sub

'
Public Sub CENCRC As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENCRC")
End Sub

'
Public Sub CENDSK As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENDSK")
End Sub

'
Public Sub CENEXT As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENEXT")
End Sub

'
Public Sub CENFLG As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENFLG")
End Sub

'
Public Sub CENHDR As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENHDR")
End Sub

'
Public Sub CENHOW As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENHOW")
End Sub

'
Public Sub CENLEN As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENLEN")
End Sub

'
Public Sub CENNAM As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENNAM")
End Sub

'
Public Sub CENOFF As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENOFF")
End Sub

'
Public Sub CENSIG As Long
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENSIG")
End Sub

'
Public Sub CENSIZ As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENSIZ")
End Sub

'
Public Sub CENTIM As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENTIM")
End Sub

'
Public Sub CENVEM As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENVEM")
End Sub

'
Public Sub CENVER As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("CENVER")
End Sub

'Compression method for compressed (deflated) entries.
Public Sub DEFLATED As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("DEFLATED")
End Sub

'
Public Sub ENDCOM As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("ENDCOM")
End Sub

'
Public Sub ENDHDR As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("ENDHDR")
End Sub

'
Public Sub ENDOFF As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("ENDOFF")
End Sub

'
Public Sub ENDSIG As Long
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("ENDSIG")
End Sub

'
Public Sub ENDSIZ As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("ENDSIZ")
End Sub

'
Public Sub ENDSUB As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("ENDSUB")
End Sub

'
Public Sub ENDTOT As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("ENDTOT")
End Sub

'
Public Sub EXTCRC As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("EXTCRC")
End Sub

'
Public Sub EXTHDR As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("EXTHDR")
End Sub

'
Public Sub EXTLEN As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("EXTLEN")
End Sub

'
Public Sub EXTSIG As Long
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("EXTSIG")
End Sub

'
Public Sub EXTSIZ As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("EXTSIZ")
End Sub

'
Public Sub LOCCRC As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("LOCCRC")
End Sub

'
Public Sub LOCEXT As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("LOCEXT")
End Sub

'
Public Sub LOCFLG As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("LOCFLG")
End Sub

'
Public Sub LOCHDR As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("LOCHDR")
End Sub

'
Public Sub LOCHOW As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("LOCHOW")
End Sub

'
Public Sub LOCLEN As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("LOCLEN")
End Sub

'
Public Sub LOCNAM As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("LOCNAM")
End Sub

'
Public Sub LOCSIG As Long
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("LOCSIG")
End Sub

'
Public Sub LOCSIZ As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("LOCSIZ")
End Sub

'
Public Sub LOCTIM As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("LOCTIM")
End Sub

'
Public Sub LOCVER As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("LOCVER")
End Sub

'Compression method for uncompressed entries.
Public Sub STORED As Int
	Dim TJO As JavaObject
	TJO.InitializeStatic("java.util.zip.ZipEntry")
	Return TJO.GetField("STORED")
End Sub

