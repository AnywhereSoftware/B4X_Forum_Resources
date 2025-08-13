B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
'version: 1.00
Sub Class_Globals
	Public Const FORMAT_ALL_FORMATS = 0, FORMAT_AZTEC = 4096, FORMAT_CODABAR = 8, FORMAT_CODE_128 = 1, FORMAT_CODE_39 = 2, FORMAT_CODE_93 = 4 As Int
	Public Const FORMAT_DATA_MATRIX = 16, FORMAT_EAN_13 = 32, FORMAT_EAN_8 = 64, FORMAT_ITF = 128, FORMAT_PDF417 = 2048, FORMAT_QR_CODE = 256 As Int
	Public Const FORMAT_UPC_A = 512, FORMAT_UPC_E = 1024 As Int
	Type ScannerResult (Success As Boolean, Value As String, Barcode As JavaObject)
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub Scan (Formats As List) As ResumableSub
	Dim builder As JavaObject
	builder.InitializeNewInstance("com/google/mlkit/vision/codescanner/GmsBarcodeScannerOptions.Builder".Replace("/", "."), Null)
	Dim f(Formats.Size - 1) As Int
	For i = 1 To Formats.Size - 1
		f(i - 1) = Formats.Get(i)
	Next
	builder.RunMethod("setBarcodeFormats", Array(Formats.Get(0), f))
'	builder.RunMethod("enableAutoZoom", Null)
	Dim options As JavaObject = builder.RunMethod("build", Null)
	Dim scanning As JavaObject
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim scanner As JavaObject = scanning.InitializeStatic("com/google/mlkit/vision/codescanner/GmsBarcodeScanning".Replace("/", ".")).RunMethod("getClient", Array(ctxt, options))
	Dim o As JavaObject = scanner.RunMethod("startScan", Null)
	Do While o.RunMethod("isComplete", Null).As(Boolean) = False
		Sleep(50)
	Loop
	Dim res As ScannerResult
	res.Initialize
	If o.RunMethod("isSuccessful", Null) Then
		res.Success = True
		res.Barcode = o.RunMethod("getResult", Null)
		res.Value = res.Barcode.RunMethod("getRawValue", Null)
	End If
	Return res
End Sub