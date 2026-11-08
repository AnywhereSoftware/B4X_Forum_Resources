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

'Creates an opaque sRGB color with the specified combined RGB value consisting of the red component in bits 16-23, the green component in bits 8-15, and the blue component in bits 0-7.
Public Sub Create(Rgb As Int) As AWTColor
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("java.awt.Color",Array As Object(Rgb))
	Return Me
End Sub

'Creates an sRGB color with the specified combined RGBA value consisting of the alpha component in bits 24-31, the red component in bits 16-23, the green component in bits 8-15, and the blue component in bits 0-7.
Public Sub Create2(aRgb As Int, Hasalpha As Boolean) As AWTColor
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("java.awt.Color",Array As Object(aRgb, Hasalpha))
	Return Me
End Sub
'Creates an opaque sRGB color with the specified red, green, and blue values in the range (0.0 - 1.0).
Public Sub Create3(R As Float, G As Float, B As Float) As AWTColor
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("java.awt.Color",Array As Object(R, G, B))
	Return Me
End Sub

'Creates an sRGB color with the specified red, green, blue, and alpha values in the range (0.0 - 1.0).
Public Sub Create4(R As Float, G As Float, B As Float, A As Float) As AWTColor
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("java.awt.Color",Array As Object(R, G, B, A))
	Return Me
End Sub

'Creates an opaque sRGB color with the specified red, green, and blue values in the range (0 - 255).
Public Sub Create5(R As Int, G As Int, B As Int) As AWTColor
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("java.awt.Color",Array As Object(R, G, B))
	Return Me
End Sub

'Creates an sRGB color with the specified red, green, blue, and alpha values in the range (0 - 255).
Public Sub Create6(R As Int, G As Int, B As Int, A As Int) As AWTColor
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("java.awt.Color",Array As Object(R, G, B, A))
	Return Me
End Sub



'Creates a color in the specified ColorSpace with the color components specified in the float array and the specified alpha.
Public Sub Create7(Cspace As JavaObject, Components() As Float, Alpha As Float) As AWTColor
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("java.awt.Color",Array As Object(Cspace, Components, Alpha))
	Return Me
End Sub


'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Creates a new Color that is a brighter version of this Color.
Public Sub Brighter As AWTColor
	Dim O As Object = Tjo.RunMethod("brighter",Null)
	Dim Wrapper As AWTColor
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Creates and returns a PaintContext used to generate a solid color field pattern.
Public Sub CreateContext(Cm As JavaObject, R As JavaObject, R2d As JavaObject, Xform As JavaObject, Hints As JavaObject) As JavaObject
	Return Tjo.RunMethod("createContext",Array As Object(Cm, R, R2d, Xform, Hints))
End Sub
'Creates a new Color that is a darker version of this Color.
Public Sub Darker As AWTColor
	Dim O As Object = Tjo.RunMethod("darker",Null)
	Dim Wrapper As AWTColor
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Converts a String to an integer and returns the specified opaque Color.
Public Sub Decode(Nm As String) As AWTColor
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.awt.Color")
	Dim O As Object = Tjo1.RunMethod("decode",Array As Object(Nm))
	Dim Wrapper As AWTColor
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Determines whether another object is equal to this Color.
Public Sub Equals(Obj As Object) As Boolean
	Return Tjo.RunMethod("equals",Array As Object(Obj))
End Sub
'Returns the alpha component in the range 0-255.
Public Sub GetAlpha As Int
	Return Tjo.RunMethod("getAlpha",Null)
End Sub
'Returns the blue component in the range 0-255 in the default sRGB space.
Public Sub GetBlue As Int
	Return Tjo.RunMethod("getBlue",Null)
End Sub
'Finds a color in the system properties.
Public Sub GetColor(Nm As String) As AWTColor
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.awt.Color")
	Dim O As Object = Tjo1.RunMethod("getColor",Array As Object(Nm))
	Dim Wrapper As AWTColor
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Finds a color in the system properties.
Public Sub GetColor2(Nm As String, V As AWTColor) As AWTColor
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.awt.Color")
	Dim O As Object = Tjo1.RunMethod("getColor",Array As Object(Nm, V.GetObject))
	Dim Wrapper As AWTColor
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Finds a color in the system properties.
Public Sub GetColor3(Nm As String, V As Int) As AWTColor
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.awt.Color")
	Dim O As Object = Tjo1.RunMethod("getColor",Array As Object(Nm, V))
	Dim Wrapper As AWTColor
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Returns a float array containing only the color components of the Color in the ColorSpace specified by the cspace parameter.
Public Sub GetColorComponents(Cspace As JavaObject, CompArray() As Float) As Float()
	Return Tjo.RunMethod("getColorComponents",Array As Object(Cspace, CompArray))
End Sub
'Returns a float array containing only the color components of the Color, in the ColorSpace of the Color.
Public Sub GetColorComponents2(CompArray() As Float) As Float()
	Return Tjo.RunMethod("getColorComponents",Array As Object(CompArray))
End Sub
'Returns the ColorSpace of this Color.
Public Sub GetColorSpace As JavaObject
	Return Tjo.RunMethod("getColorSpace",Null)
End Sub
'Returns a float array containing the color and alpha components of the Color, in the ColorSpace specified by the cspace parameter.
Public Sub GetComponents(Cspace As JavaObject, CompArray() As Float) As Float()
	Return Tjo.RunMethod("getComponents",Array As Object(Cspace, CompArray))
End Sub
'Returns a float array containing the color and alpha components of the Color, in the ColorSpace of the Color.
Public Sub GetComponents2(CompArray() As Float) As Float()
	Return Tjo.RunMethod("getComponents",Array As Object(CompArray))
End Sub
'Returns the green component in the range 0-255 in the default sRGB space.
Public Sub GetGreen As Int
	Return Tjo.RunMethod("getGreen",Null)
End Sub
'Creates a Color object based on the specified values for the HSB color model.
Public Sub GetHSBColor(H As Float, S As Float, B As Float) As AWTColor
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.awt.Color")
	Dim O As Object = Tjo1.RunMethod("getHSBColor",Array As Object(H, S, B))
	Dim Wrapper As AWTColor
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Returns the red component in the range 0-255 in the default sRGB space.
Public Sub GetRed As Int
	Return Tjo.RunMethod("getRed",Null)
End Sub
'Returns the RGB value representing the color in the default sRGB ColorModel.
Public Sub GetRGB As Int
	Return Tjo.RunMethod("getRGB",Null)
End Sub
'Returns a float array containing only the color components of the Color, in the default sRGB color space.
Public Sub GetRGBColorComponents(CompArray() As Float) As Float()
	Return Tjo.RunMethod("getRGBColorComponents",Array As Object(CompArray))
End Sub
'Returns a float array containing the color and alpha components of the Color, as represented in the default sRGB color space.
Public Sub GetRGBComponents(CompArray() As Float) As Float()
	Return Tjo.RunMethod("getRGBComponents",Array As Object(CompArray))
End Sub
'Returns the transparency mode for this Color.
Public Sub GetTransparency As Int
	Return Tjo.RunMethod("getTransparency",Null)
End Sub
'Computes the hash code for this Color.
Public Sub HashCode As Int
	Return Tjo.RunMethod("hashCode",Null)
End Sub
'Converts the components of a color, as specified by the HSB model, to an equivalent set of values for the default RGB model.
Public Sub HSBtoRGB(Hue As Float, Saturation As Float, Brightness As Float) As Int
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.awt.Color")
	Return Tjo1.RunMethod("HSBtoRGB",Array As Object(Hue, Saturation, Brightness))
End Sub
'Converts the components of a color, as specified by the default RGB model, to an equivalent set of values for hue, saturation, and brightness that are the three components of the HSB model.
Public Sub RGBtoHSB(R As Int, G As Int, B As Int, Hsbvals() As Float) As Float()
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("java.awt.Color")
	Return Tjo1.RunMethod("RGBtoHSB",Array As Object(R, G, B, Hsbvals))
End Sub
'Returns a string representation of this Color.
Public Sub ToString As String
	Return Tjo.RunMethod("toString",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub


