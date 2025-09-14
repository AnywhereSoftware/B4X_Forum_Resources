B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

'Locates factories for print services that can be used with a print job to output a stream of data in the format specified by outputMimeType.
Public Sub LookupStreamPrintServiceFactories(Flavor As Object, OutputMimeType As Object) As List
	If Flavor <> Null Then Flavor = CallSub(Flavor,"GetObject")
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("javax.print.StreamPrintServiceFactory")
	Dim Temp() As Object = Tjo1.RunMethod("lookupStreamPrintServiceFactories",Array As Object(Flavor, OutputMimeType))
	Dim L As List
	L.Initialize
	For i = 0 To Temp.Length - 1
		Dim Wrapper As StreamPrintServiceFactory
		Wrapper.Initialize
		Wrapper.SetObject(Temp(i))
		L.Add(Wrapper)
	Next
	Return L
End Sub