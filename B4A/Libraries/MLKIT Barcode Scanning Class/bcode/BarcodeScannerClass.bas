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
	Type ScannerResult (Success As Boolean, Value As String, Barcode As JavaObject, format As String, display As String)
	Private formatMap As Map
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	formatMap.Initialize
	formatMap.put(0,"All Formats")
	formatMap.put(4096, "AZTEC")
	formatMap.put(8, "Codabar")
	formatMap.put(1, "Code 128")
	formatMap.put(2, "Code 39")
	formatMap.put(4, "Code 93")
	formatMap.put(16,"Data Matrix")
	formatMap.put(32, "EAN-13")
	formatMap.put(64, "EAN-8")
	formatMap.put(128, "ITF")
	formatMap.put(2048, "PDF-417")
	formatMap.put(256, "QR Code")
	formatMap.put(-1, "UNKNOWN")
	formatMap.put(512, "UPC-A")
	formatMap.put(1024, "UPC-E")
End Sub

Public Sub Scan (Formats As List, bitmap As Bitmap) As ResumableSub
	Dim builder As JavaObject
	builder.InitializeNewInstance("com.google.mlkit.vision.barcode.BarcodeScannerOptions.Builder",Null)
	Dim f(Formats.Size - 1) As Int
	For i = 1 To Formats.Size - 1
		f(i - 1) = Formats.Get(i)
	Next
	builder.RunMethod("setBarcodeFormats", Array(Formats.Get(0), f))
	Dim options As JavaObject = builder.RunMethod("build", Null)
	Dim scanning As JavaObject
	Dim scanner As JavaObject = scanning.InitializeStatic("com.google.mlkit.vision.barcode.BarcodeScanning").RunMethod("getClient", Array(options))
	
	Dim jo As JavaObject
	Dim inpimage As JavaObject = jo.InitializeStatic("com.google.mlkit.vision.common.InputImage").RunMethod("fromBitmap",Array(bitmap, 0))


	Dim o As JavaObject = scanner.RunMethod("process", Array(inpimage))
	Do While o.RunMethod("isComplete", Null).As(Boolean) = False
		Sleep(50)
	Loop
	If o.RunMethod("isSuccessful", Null) Then
		Dim barcodelist As List = o.RunMethod("getResult",Null)
		Dim res(barcodelist.Size) As ScannerResult
		Dim i As Int
		For i = 0 To barcodelist.Size - 1
			Dim jo As JavaObject = barcodelist.Get(i)
			res(i).display = jo.RunMethod("getDisplayValue",Null)
			res(i).format = formatMap.Get(jo.RunMethod("getFormat",Null))
			res(i).Success = True
			res(i).value = jo.RunMethod("getRawValue",Null)
		Next
		Return res
	Else
		Return Null
	End If
End Sub

