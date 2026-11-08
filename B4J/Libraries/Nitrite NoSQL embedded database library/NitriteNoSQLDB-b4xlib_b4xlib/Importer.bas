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
'Returns the wrapped object as Object
Public Sub GetObject As Object
  Return Tjo
End Sub
'Imports data from a file.
Public Sub ImportFrom(DirName As String, FileName As String)
  'Code for File Object Creation
  Dim TFile As JavaObject
  TFile.InitializeNewInstance("java.io.File",Array(DirName,FileName))
  Tjo.RunMethod("importFrom",Array As Object(TFile))
End Sub
'Imports data from an InputStream.
Public Sub ImportFrom2(Stream As InputStream)
  Tjo.RunMethod("importFrom",Array As Object(Stream))
End Sub
'Imports data from a file path.
Public Sub ImportFrom4(TFile As String)
  Tjo.RunMethod("importFrom",Array As Object(TFile))
End Sub


