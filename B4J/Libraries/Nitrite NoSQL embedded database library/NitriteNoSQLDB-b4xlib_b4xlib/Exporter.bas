B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
'The exporter exports byte arrays as a Base64 String, but the importer has no way of knowing the format of the data
'The data in affected fields will need to be unencoded before it can be used.
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
	Private Tjo As JavaObject
End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
End Sub
'Class is a subclass with no constructor, we need to set the object on which JavaObject will operate.
Public Sub SetObject(Target As JavaObject)
	Tjo = Target
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Exports data to a File.
Public Sub ExportTo(DirName As String, FileName As String)
	'Code for File Object Creation
	Dim TFile As JavaObject
	TFile.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Tjo.RunMethod("exportTo",Array As Object(TFile))
End Sub
'Exports data to an OutputStream.
Public Sub ExportTo2(Stream As OutputStream)
	Tjo.RunMethod("exportTo",Array As Object(Stream))
End Sub
'Exports data to a file.
Public Sub ExportTo4(TFile As String)
	Tjo.RunMethod("exportTo",Array As Object(TFile))
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub

'Sets ExportOptions to customize data export.
Public Sub WithOptions(Options As ExportOptions) As Exporter
	Dim Wrapper As Exporter
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("withOptions",Array As Object(Options.GetObject)))
	Return Wrapper
End Sub

