B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	

	Private Tjo As JavaObject
End Sub

'*
Public Sub Initialize

End Sub

Public Sub Create
	Tjo.InitializeNewInstance("javax.print.StreamPrintServiceFactory",Null)
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Queries the factory for the document format that is emitted by printers obtained from this factory.
Public Sub GetOutputFormat As String
	Return Tjo.RunMethod("getOutputFormat",Null)
End Sub
'Returns a StreamPrintService that can print to the specified output stream.
Public Sub GetPrintService(Out As OutputStream) As JavaObject
	Return Tjo.RunMethod("getPrintService",Array As Object(Out))
End Sub
'Queries the factory for the document flavors that can be accepted by printers obtained from this factory.
Public Sub GetSupportedDocFlavors As List
	Dim Temp() As Object = Tjo.RunMethod("getSupportedDocFlavors",Null)
	Dim L As List
	L.Initialize
	For i = 0 To Temp.Length - 1
		Dim Wrapper As DocFlavor
		Wrapper.Initialize
		Wrapper.SetObject(Temp(i))
		L.Add(Wrapper)
	Next
	Return L
End Sub


'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

