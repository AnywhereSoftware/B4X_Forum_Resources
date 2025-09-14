B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private Tjo As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	'Initialize the static sub so that field names will be updated.  If you don't use the standard naming conventions you will need to change the class name
End Sub

'Creates a new Font from the specified name, style and point size.
Public Sub Create(Name As String, Style As Int, Size As Int)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("java.awt.Font",Array As Object(Name, Style, Size))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Checks if this Font has a glyph for the specified character.
Public Sub CanDisplay(C As Char) As Boolean
	Return Tjo.RunMethod("canDisplay",Array As Object(C))
End Sub
'Returns a new Font using the specified font type and the specified font file.
Public Sub CreateFont(FontFormat As Int,DirName As String, FileName As String) As AWTFont
	'Code for File Object Creation
	Dim IStream As InputStream = JavaxPrint_Utils.GetInputStream(DirName,FileName)

	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.awt.Font")
	Dim O As Object = Tjo1.RunMethod("createFont",Array As Object(FontFormat, IStream))
	Dim Wrapper As AWTFont
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub

'Creates a new Font object by replicating the current Font object and applying a new size to it.
Public Sub DeriveFont(Size As Float) As AWTFont
	Dim O As Object = Tjo.RunMethod("deriveFont",Array As Object(Size))
	Dim Wrapper As AWTFont
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Creates a new Font object by replicating the current Font object and applying a new style to it.
Public Sub DeriveFont2(Style As Int) As AWTFont
	Dim O As Object = Tjo.RunMethod("deriveFont",Array As Object(Style))
	Dim Wrapper As AWTFont
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub

'Creates a new Font object by replicating this Font object and applying a new style and size.
Public Sub DeriveFont3(Style As Int, Size As Float) As AWTFont
	Dim O As Object = Tjo.RunMethod("deriveFont",Array As Object(Style, Size))
	Dim Wrapper As AWTFont
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub

'Compares this Font object to the specified Object.
Public Sub Equals(Obj As Object) As Boolean
	Return Tjo.RunMethod("equals",Array As Object(Obj))
End Sub
'Returns a map of font attributes available in this Font.
Public Sub GetAtts As Map
	Return Tjo.RunMethod("getAttributes",Null)
End Sub
'Returns the keys of all the attributes supported by this Font.
Public Sub GetAvailableAtts As JavaObject
	Return Tjo.RunMethod("getAvailableAttributes",Null)
End Sub
'Returns the baseline appropriate for displaying this character.
Public Sub GetBaselineFor(C As Char) As Byte
	Return Tjo.RunMethod("getBaselineFor",Array As Object(C))
End Sub
'Returns the family name of this Font.
Public Sub GetFamily As String
	Return Tjo.RunMethod("getFamily",Null)
End Sub
'Returns the family name of this Font, localized for the specified locale.
Public Sub GetFamily2(L As JavaObject) As String
	Return Tjo.RunMethod("getFamily",Array As Object(L))
End Sub

'Returns a Font object from the system properties list.
Public Sub GetFont2(Nm As String) As AWTFont
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.awt.Font")
	Dim O As Object = Tjo1.RunMethod("getFont",Array As Object(Nm))
	Dim Wrapper As AWTFont
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Gets the specified Font from the system properties list.
Public Sub GetFont3(Nm As String, TFont As AWTFont) As AWTFont
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.awt.Font")
	Dim O As Object = Tjo1.RunMethod("getFont",Array As Object(Nm, TFont))
	Dim Wrapper As AWTFont
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Returns the font face name of this Font.
Public Sub GetFontName As String
	Return Tjo.RunMethod("getFontName",Null)
End Sub
'Returns the font face name of the Font, localized for the specified locale.
Public Sub GetFontName2(Locale As Object) As String
	Return Tjo.RunMethod("getFontName",Array As Object(Locale))
End Sub

'Returns the logical name of this Font.
Public Sub GetName As String
	Return Tjo.RunMethod("getName",Null)
End Sub

'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Returns the postscript name of this Font.
Public Sub GetPSName As String
	Return Tjo.RunMethod("getPSName",Null)
End Sub
'Returns the point size of this Font, rounded to an integer.
Public Sub GetSize As Int
	Return Tjo.RunMethod("getSize",Null)
End Sub
'Returns the point size of this Font in float value.
Public Sub GetSize2D As Float
	Return Tjo.RunMethod("getSize2D",Null)
End Sub
'Returns the style of this Font.
Public Sub GetStyle As Int
	Return Tjo.RunMethod("getStyle",Null)
End Sub
'Indicates whether or not this Font object's style is BOLD.
Public Sub IsBold As Boolean
	Return Tjo.RunMethod("isBold",Null)
End Sub
'Indicates whether or not this Font object's style is ITALIC.
Public Sub IsItalic As Boolean
	Return Tjo.RunMethod("isItalic",Null)
End Sub
'Indicates whether or not this Font object's style is PLAIN.
Public Sub IsPlain As Boolean
	Return Tjo.RunMethod("isPlain",Null)
End Sub
'Indicates whether or not this Font object has a transform that affects its size in addition to the Size attribute.
Public Sub IsTransformed As Boolean
	Return Tjo.RunMethod("isTransformed",Null)
End Sub

'Converts this Font object to a String representation.
Public Sub ToString As String
	Return Tjo.RunMethod("toString",Null)
End Sub

'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

