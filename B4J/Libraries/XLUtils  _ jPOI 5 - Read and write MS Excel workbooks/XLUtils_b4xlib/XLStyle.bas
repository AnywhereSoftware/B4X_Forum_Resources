B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Private STYLE_KEY_HORIZONTAL_ALIGNMENT = "setAlignment" As String
	Private STYLE_KEY_BORDER_BOTTOM = "setBorderBottom" As String
	Private STYLE_KEY_BORDER_LEFT = "setBorderLeft" As String
	Private STYLE_KEY_BORDER_RIGHT = "setBorderRight" As String
	Private STYLE_KEY_BORDER_TOP = "setBorderTop" As String
	Private STYLE_KEY_BOTTOM_BORDER_COLOR = "setBottomBorderColor" As String
	Private STYLE_KEY_LEFT_BORDER_COLOR = "setLeftBorderColor" As String
	Private STYLE_KEY_RIGHT_BORDER_COLOR = "setRightBorderColor" As String
	Private STYLE_KEY_TOP_BORDER_COLOR = "setTopBorderColor" As String
	Private STYLE_KEY_DATA_FORMAT = "setDataFormat" As String
'	Private STYLE_KEY_FILL_BACKGROUND_COLOR = "setFillBackgroundColor" As String
	Private STYLE_KEY_FILL_FOREGROUND_COLOR = "setFillForegroundColor" As String
	Private STYLE_KEY_FILL_PATTERN = "setFillPattern" As String
	Private STYLE_KEY_FONT = "setFont" As String
	Private STYLE_KEY_HIDDEN = "setHidden" As String
	Private STYLE_KEY_INDENTION = "setIndention" As String
	Private STYLE_KEY_LOCKED = "setLocked" As String
	Private STYLE_KEY_ROTATION = "setRotation" As String
	Private STYLE_KEY_VERTICAL_ALIGNMENT = "setVerticalAlignment" As String
	Private STYLE_KEY_WRAP_TEXT = "setWrapText" As String
	Private bba As JavaObject
	Public StyleMap As Map
	Private writer As XLWorkbookWriter
End Sub

Public Sub Initialize (vwriter As XLWorkbookWriter) As XLStyle
	bba.InitializeStatic("anywheresoftware.b4a.BA")
	StyleMap.Initialize
	writer = vwriter
	Return Me
End Sub

'Sets the cell's fill color.
Public Sub ForegroundColor (Color As Short) As XLStyle
	StyleMap.Put(STYLE_KEY_FILL_FOREGROUND_COLOR, Color)
	StyleMap.Put(STYLE_KEY_FILL_PATTERN, "SOLID_FOREGROUND")
	Return Me
End Sub

'Sets whether the cells should be locked.
Public Sub Locked (Value As Boolean) As XLStyle
	StyleMap.Put(STYLE_KEY_LOCKED, Value)
	Return Me
End Sub

'Sets whether the cells should be hidden.
Public Sub Hidden (Value As Boolean) As XLStyle
	StyleMap.Put(STYLE_KEY_HIDDEN, Value)
	Return Me
End Sub

'Sets the wrap text property.
Public Sub WrapText (Value As Boolean) As XLStyle
	StyleMap.Put(STYLE_KEY_WRAP_TEXT, Value)
	Return Me
End Sub

'Sets the number of spaces to indent the text in the cell.
Public Sub Indention (Value As Short) As XLStyle
	StyleMap.Put(STYLE_KEY_INDENTION, Value)
	Return Me
End Sub

'Sets the text rotation between -90 to 90.
Public Sub Rotation (Value As Short) As XLStyle
	StyleMap.Put(STYLE_KEY_ROTATION, Value)
	Return Me
End Sub

'Sets the border color. One of XL.COLOR constants.
Public Sub BorderBottomColor (Color As Short) As XLStyle
	Return SetBorderColor(STYLE_KEY_BOTTOM_BORDER_COLOR, Color)
End Sub

'Sets the border color. One of XL.COLOR constants.
Public Sub BorderTopColor (Color As Short) As XLStyle
	Return SetBorderColor(STYLE_KEY_TOP_BORDER_COLOR, Color)
End Sub

'Sets the border color. One of XL.COLOR constants.
Public Sub BorderLeftColor (Color As Short) As XLStyle
	Return SetBorderColor(STYLE_KEY_LEFT_BORDER_COLOR, Color)
End Sub

'Sets the border color. One of XL.COLOR constants.
Public Sub BorderRightColor (Color As Short) As XLStyle
	Return SetBorderColor(STYLE_KEY_RIGHT_BORDER_COLOR, Color)
End Sub

Private Sub SetBorderColor (Property As String, Color As Short) As XLStyle
	StyleMap.Put(Property, Color)
	Return Me
End Sub

Public Sub DataFormat (Format As String) As XLStyle
	Dim ix As Short = writer.jWorkbook.RunMethodJO("createDataFormat", Null).RunMethod("getFormat", Array(Format))
	StyleMap.Put(STYLE_KEY_DATA_FORMAT, ix)
	Return Me
End Sub



'One of the following values: NONE, THIN, MEDIUM, DASHED, DOTTED, THICH, DOUBLE, HAIR, MEDIUM_DASHED, DASH_DOT, MEDIUM_DASH_DOT, DASH_DOT_DOT, MEDIUM_DASH_DOT_DOT, SLANTED_DASH_DOT
Public Sub BorderBottom (BorderStyle As String) As XLStyle
	Return SetBorder(STYLE_KEY_BORDER_BOTTOM, BorderStyle)
End Sub

'One of the following values: NONE, THIN, MEDIUM, DASHED, DOTTED, THICH, DOUBLE, HAIR, MEDIUM_DASHED, DASH_DOT, MEDIUM_DASH_DOT, DASH_DOT_DOT, MEDIUM_DASH_DOT_DOT, SLANTED_DASH_DOT
Public Sub BorderTop (BorderStyle As String) As XLStyle
	Return SetBorder(STYLE_KEY_BORDER_TOP, BorderStyle)
End Sub

'One of the following values: NONE, THIN, MEDIUM, DASHED, DOTTED, THICH, DOUBLE, HAIR, MEDIUM_DASHED, DASH_DOT, MEDIUM_DASH_DOT, DASH_DOT_DOT, MEDIUM_DASH_DOT_DOT, SLANTED_DASH_DOT
Public Sub BorderLeft (BorderStyle As String) As XLStyle
	Return SetBorder(STYLE_KEY_BORDER_LEFT, BorderStyle)
End Sub

'One of the following values: NONE, THIN, MEDIUM, DASHED, DOTTED, THICH, DOUBLE, HAIR, MEDIUM_DASHED, DASH_DOT, MEDIUM_DASH_DOT, DASH_DOT_DOT, MEDIUM_DASH_DOT_DOT, SLANTED_DASH_DOT
Public Sub BorderRight (BorderStyle As String) As XLStyle
	Return SetBorder(STYLE_KEY_BORDER_RIGHT, BorderStyle)
End Sub

Private Sub SetBorder (Property As String, Style As String) As XLStyle
	StyleMap.Put(Property, Style)
	Return Me
End Sub

'One of the following values: TOP, CENTER, JUSTIFY, DISTRIBUTED
Public Sub VerticalAlignment (Alignment As String) As XLStyle
	StyleMap.Put(STYLE_KEY_VERTICAL_ALIGNMENT, Alignment)
	Return Me
End Sub

'One of the following values: GENERAL, LEFT, CENTER, RIGHT, FILL, JUSTIFY, CENTER_SELECTION, DISTRIBUTED
Public Sub HorizontalAlignment (Alignment As String) As XLStyle
	StyleMap.Put(STYLE_KEY_HORIZONTAL_ALIGNMENT, Alignment)
	Return Me
End Sub

'Default font
Public Sub Font (Size As Short) As XLStyle
	Return FontColor(Size, writer.xl.COLOR_BLACK)
End Sub

'Default font with the set color. Color should be one of the XL color constants.
Public Sub FontColor (Size As Short, Color As Int) As XLStyle
	Dim f As PoiFont = writer.GetFont(Size, False, writer.DefaultFontName, False, False, Color)
	StyleMap.Put(STYLE_KEY_FONT, f.Index)
	Return Me	
End Sub

'Bold font.
Public Sub FontBold (Size As Short) As XLStyle
	Return FontBoldColor(Size, writer.xl.COLOR_BLACK)
End Sub

'Underlined, blue font.
Public Sub FontLink (Size As Short) As XLStyle
	Dim f As PoiFont = writer.GetFont(Size, False, writer.DefaultFontName, False, True, writer.xl.COLOR_BLUE)
	StyleMap.Put(STYLE_KEY_FONT, f.Index)
	Return Me
End Sub

'Bold font with the set color. Color should be one of the XL color constants.
Public Sub FontBoldColor (Size As Short, Color As Int) As XLStyle
	Dim f As PoiFont = writer.GetFont(Size, True, writer.DefaultFontName, False, False, Color)
	StyleMap.Put(STYLE_KEY_FONT, f.Index)
	Return Me
End Sub

Public Sub FontOther (PFont As PoiFont) As XLStyle
	StyleMap.Put(STYLE_KEY_FONT, PFont.Index)
	Return Me
End Sub

'Creates a new style with the same properties as this one. Returns the cloned style.
Public Sub Clone As XLStyle
	Dim NewStyle As XLStyle
	NewStyle.Initialize (writer)
	For Each k As String In StyleMap.Keys
		NewStyle.StyleMap.Put(k, StyleMap.Get(k))
	Next
	Return NewStyle
End Sub

'Imports the properties from the other style to this style.
Public Sub ImportStyle (OtherStyle As XLStyle) As XLStyle
	For Each k As String In OtherStyle.StyleMap.Keys
		StyleMap.Put(k, OtherStyle.StyleMap.Get(k))
	Next
	Return Me
End Sub

