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

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

'Constructs a SimpleDoc with the specified print data, doc flavor and doc attribute set.
Public Sub Create(PrintData As Object, Flavor As Object, Atts As Object)
	If JavaxPrint_Utils.IsPackageObject(PrintData) Then PrintData = CallSub(PrintData,"GetObject")
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")
	If Flavor <> Null Then Flavor = CallSub(Flavor,"GetObject")
	Tjo.InitializeNewInstance("javax.print.SimpleDoc",Array As Object(PrintData, Flavor, Atts))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Obtains the set of printing attributes for this doc object.
Public Sub GetAttributes As DocAttributeSet
	Dim O As Object = Tjo.RunMethod("getAttributes",Null)
	Dim Wrapper As DocAttributeSet
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(o)
	Return Wrapper
End Sub
'Determines the doc flavor in which this doc object will supply its piece of print data.
Public Sub GetDocFlavor As DocFlavor
	Dim Wrapper As DocFlavor
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("getDocFlavor",Null))
	Return Wrapper
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Obtains the print data representation object that contains this doc object's piece of print data in the format corresponding to the supported doc flavor.
Public Sub GetPrintData As Object
	Return Tjo.RunMethod("getPrintData",Null)
End Sub
'Obtains a reader for extracting character print data from this doc.
Public Sub GetReaderForText As JavaObject
	Return Tjo.RunMethod("getReaderForText",Null)
End Sub
'Obtains an input stream for extracting byte print data from this doc.
Public Sub GetStreamForBytes As InputStream
	Return Tjo.RunMethod("getStreamForBytes",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

