B4J=true
Group=AttributeSets
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
'<link>DocAttributes|https://docs.oracle.com/en/java/javase/11/docs/api/java.desktop/javax/print/attribute/DocAttribute.html </link>
'	Attributes supported by DocAttributeSte :
'	Chromaticity, Compression, 
'	DocumentName, 
'	Finishings, 
'	Media, MediaName, MediaPrintableArea, MediaSizeName, 
'	MediaTray, 
'	NumberUp, 
'	OrientationRequested, 
'	PageRanges, PrinterResolution, PrintQuality, 
Sub Class_Globals
	

	Private Tjo As JavaObject
End Sub


Public Sub Initialize
	Tjo.InitializeNewInstance("javax.print.attribute.HashDocAttributeSet",Null)
End Sub

'Adds the specified attribute to this attribute set if it is not already present, first removing any existing in the same attribute category as the specified attribute value.
'Attributes supported by DocAttributeSet :
'	Chromaticity, Compression, 
'	DocumentName, 
'	Finishings, 
'	Media, MediaName, MediaPrintableArea, MediaSizeName, 
'	MediaTray, 
'	NumberUp, 
'	OrientationRequested, 
'	PageRanges, PrinterResolution, PrintQuality, 
'	SheetCollate, Sides
Public Sub Add(Attr As Attribute) As Boolean
	Return Tjo.RunMethod("add",Array As Object(Attr.GetObject))
End Sub
'Adds the specified attribute to this attribute set if it is not already present, first removing any existing in the same attribute category as the specified attribute value.
'Parameter is an unwrapped value
Public Sub AddNative(Attr As Object) As Boolean
	Return Tjo.RunMethod("add",Array As Object(Attr))
End Sub
'Adds all of the elements in the specified set to this attribute.
Public Sub AddAll(Atts As AttributeSet) As Boolean
	Return Tjo.RunMethod("addAll",Array As Object(Atts.GetObject))
End Sub
'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Removes all attributes from this attribute set.
Public Sub Clear
	Tjo.RunMethod("clear",Null)
End Sub
'Returns true if this attribute set contains an attribute for the specified category.
Public Sub ContainsKey(Category As Class_Wrapper) As Boolean
	Return Tjo.RunMethod("containsKey",Array As Object(Category.GetObject))
End Sub
'Returns true if this attribute set contains the given attribute.
Public Sub ContainsValue(Attr As Attribute) As Boolean
	Return Tjo.RunMethod("containsValue",Array As Object(Attr.GetObject))
End Sub
'Compares the specified object with this attribute set for equality.
Public Sub Equals(TObject As DocAttributeSet) As Boolean
	Return Tjo.RunMethod("equals",Array As Object(TObject.GetObject))
End Sub
'Returns the attribute value which this attribute set contains in the given attribute category.
Public Sub Get(Category As Class_Wrapper) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("get",Array As Object(Category.GetObject)))
	Return Wrapper
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Returns the hash code value for this attribute set.
Public Sub HashCode As Int
	Return Tjo.RunMethod("hashCode",Null)
End Sub
'Returns true if this attribute set contains no attributes.
Public Sub IsEmpty As Boolean
	Return Tjo.RunMethod("isEmpty",Null)
End Sub
'Removes the specified attribute from this attribute set if present.
Public Sub Remove(Attr As Attribute) As Boolean
	Return Tjo.RunMethod("remove",Array As Object(Attr.GetObject))
End Sub
'Removes any attribute for this category from this attribute set if present.
Public Sub Remove2(Category As Class_Wrapper) As Boolean
	Return Tjo.RunMethod("remove",Array As Object(Category.GetObject))
End Sub
'Returns the number of attributes in this attribute set.
Public Sub Size As Int
	Return Tjo.RunMethod("size",Null)
End Sub
'Returns an array of the attributes contained in this set.
Public Sub ToArray As Attribute()
	Dim RetArr(Size) As Attribute
	Dim Arr() As Object = Tjo.RunMethod("toArray",Null)
	For i = 0 To Arr.Length - 1
		Dim O As Object = Arr(i)
		Dim Wrapper As Attribute
		Wrapper.Initialize
		Wrapper.SetObject(O)
		RetArr(i) = Wrapper
	Next
	Return RetArr
End Sub

'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

