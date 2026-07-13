Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1
@EndOfDesignText@
'Style class for JTSDrawer. Holds all visual properties used when drawing geometries.
'Fields are public for short syntax: style.StrokeColor = xui.Color_Red
'Call Initialize to get sensible defaults (black 2px stroke, no fill, circle point shape).
Sub Class_Globals
	Private xui As XUI
	
	'--- Stroke (outline) ---
	'Whether to draw the outline of geometries.
	Public Stroke As Boolean
	'Outline colour, e.g. xui.Color_Black.
	Public StrokeColor As Int
	'Outline thickness in pixels.
	Public StrokeWidth As Float
	
	'--- Fill ---
	'Whether to fill polygons (ignored for points/lines).
	Public Fill As Boolean
	'Fill colour, e.g. xui.Color_Yellow.
	Public FillColor As Int
	
	'--- Point appearance ---
	'Shape used when drawing Point/MultiPoint geometries.
	'Use one of the SHAPE_* constants below.
	Public PointShape As Int
	'Radius/half-size of point symbols in pixels.
	Public PointRadius As Float
	
	'--- Shape constants for PointShape ---
	Public SHAPE_CIRCLE As Int = 0
	Public SHAPE_SQUARE As Int = 1
	Public SHAPE_CROSS As Int = 2
	Public SHAPE_TRIANGLE As Int = 3
End Sub

'Initialises the style with sensible defaults:
'black 2px stroke, no fill, yellow fill colour (used if Fill is enabled),
'point shape = filled circle, point radius = 4 px.
Public Sub Initialize
	Stroke = True
	StrokeColor = xui.Color_Black
	StrokeWidth = 2
	
	Fill = False
	FillColor = xui.Color_Yellow
	
	PointShape = SHAPE_CIRCLE
	PointRadius = 4
End Sub

'Convenience: configure stroke in one call.
'color: outline colour. width: outline thickness in pixels.
Public Sub SetStroke(color As Int, width As Float)
	Stroke = True
	StrokeColor = color
	StrokeWidth = width
End Sub

'Convenience: configure fill in one call.
'color: fill colour.
Public Sub SetFill(color As Int)
	Fill = True
	FillColor = color
End Sub

'Convenience: disable stroke.
Public Sub NoStroke
	Stroke = False
End Sub

'Convenience: disable fill.
Public Sub NoFill
	Fill = False
End Sub

'Returns a deep copy of this style. Useful for temporary overrides:
'  Dim tmp As JTSStyle = drawer.Style.Clone
'  tmp.StrokeColor = xui.Color_Red
'  drawer.Style = tmp
'  drawer.DrawGeometry(g)
'  drawer.Style = original
Public Sub Clone As JTSStyle
	Dim s As JTSStyle
	s.Initialize
	s.Stroke = Stroke
	s.StrokeColor = StrokeColor
	s.StrokeWidth = StrokeWidth
	s.Fill = Fill
	s.FillColor = FillColor
	s.PointShape = PointShape
	s.PointRadius = PointRadius
	Return s
End Sub
