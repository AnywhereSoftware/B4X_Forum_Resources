B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	
	Private Const NSVG_KAPPA90 As Float = 0.5522847493
	Private Const NSVG_EPSILON As Double = 0.000000000001

	Private Const NSVG_PAINT_UNDEF As Int = -1
	Private Const NSVG_PAINT_NONE As Int = 0
	Private Const NSVG_PAINT_COLOR As Int = 1
	Private Const NSVG_PAINT_LINEAR_GRADIENT As Int = 2
	Private Const NSVG_PAINT_RADIAL_GRADIENT As Int = 3

	Private Const NSVG_JOIN_MITER As Int = 0
	Private Const NSVG_JOIN_ROUND As Int = 1
	Private Const NSVG_JOIN_BEVEL As Int = 2
	Private Const NSVG_CAP_BUTT As Int = 0
	Private Const NSVG_CAP_ROUND As Int = 1
	Private Const NSVG_CAP_SQUARE As Int = 2
	Private Const NSVG_FILLRULE_NONZERO As Int = 0
	Private Const NSVG_FILLRULE_EVENODD As Int = 1

	Private Const NSVG_PAINT_FILL As Int = 0
	Private Const NSVG_PAINT_MARKERS As Int = 1
	Private Const NSVG_PAINT_STROKE As Int = 2

	Private Const NSVG_ALIGN_MIN As Int = 0
	Private Const NSVG_ALIGN_MID As Int = 1
	Private Const NSVG_ALIGN_MAX As Int = 2
	Private Const NSVG_ALIGN_NONE As Int = 0
	Private Const NSVG_ALIGN_MEET As Int = 1
	Private Const NSVG_ALIGN_SLICE As Int = 2

	Private Const NSVG_UNITS_USER As Int = 0
	Private Const NSVG_UNITS_PX As Int = 1
	Private Const NSVG_UNITS_PT As Int = 2
	Private Const NSVG_UNITS_PC As Int = 3
	Private Const NSVG_UNITS_MM As Int = 4
	Private Const NSVG_UNITS_CM As Int = 5
	Private Const NSVG_UNITS_IN As Int = 6
	Private Const NSVG_UNITS_PERCENT As Int = 7
	Private Const NSVG_UNITS_EM As Int = 8
	Private Const NSVG_UNITS_EX As Int = 9

	Private Const NSVG_USER_SPACE As Int = 0
	Private Const NSVG_OBJECT_SPACE As Int = 1
	Private Const NSVG_MAX_ATTR As Int = 128
	Private Const NSVG_MAX_DASHES As Int = 8
	Private Const NSVG_MAX_CLASSES As Int = 32
	Private Const NSVG_XML_MAX_ATTRIBS As Int = 256

	Private Const NSVG_SUBSAMPLES As Int = 5
	Private Const NSVG_FIXSHIFT As Int = 10
	Private Const NSVG_FIX As Int = 1024
	Private Const NSVG_FIXMASK As Int = 1023
	Private Const NSVG_PT_CORNER As Int = 1
	Private Const NSVG_PT_BEVEL As Int = 2
	Private Const NSVG_PT_LEFT As Int = 4

	Type nanoSvg_coord(value As Float, units As Int)
	Type nanoSvg_gradient(xform() As Float, nstops As Int, _
		stopColors() As Int, stopOffsets() As Float)
	Type nanoSvg_gradientData(id As String, href As String, gtype As Int, units As Int, _
		xform() As Float, nstops As Int, stopColors As List, stopOffsets As List, _
		x1 As nanoSvg_coord, y1 As nanoSvg_coord, x2 As nanoSvg_coord, y2 As nanoSvg_coord, _
		cx As nanoSvg_coord, cy As nanoSvg_coord, r As nanoSvg_coord)
	Type nanoSvg_path(pts() As Float, npts As Int, closed As Boolean, bounds() As Float)
	Type nanoSvg_shape(fillType As Int, fillColor As Int, fillGrad As nanoSvg_gradient, _
		strokeType As Int, strokeColor As Int, strokeGrad As nanoSvg_gradient, _
		opacity As Float, strokeWidth As Float, strokeDashOffset As Float, strokeDashArray() As Float, _
		strokeDashCount As Int, strokeLineJoin As Int, strokeLineCap As Int, miterLimit As Float, _
		fillRule As Int, paintOrder As Int, flags As Int, bounds() As Float, _
		fillGradient As String, strokeGradient As String, xform() As Float, paths As List)
	Type nanoSvg_attrib(xform() As Float, fillColor As Int, strokeColor As Int, _
		opacity As Float, fillOpacity As Float, strokeOpacity As Float, _
		fillGradient As String, strokeGradient As String, strokeWidth As Float, _
		strokeDashOffset As Float, strokeDashArray() As Float, strokeDashCount As Int, _
		strokeLineJoin As Int, strokeLineCap As Int, miterLimit As Float, fillRule As Int, _
		fontSize As Float, stopColor As Int, stopOpacity As Float, stopOffset As Float, _
		hasFill As Int, hasStroke As Int, visible As Boolean, paintOrder As Int)
	Type nanoSvg_style(className As String, props As String)

	Private gAttrs(NSVG_MAX_ATTR) As nanoSvg_attrib
	Private gAttrHead As Int
	Private gPts() As Float
	Private gNpts As Int
	Private gPlist As List
	Private gShapes As List
	Private gGradients As List
	Private gStyles As List
	Private gImgW As Float
	Private gImgH As Float
	Private gViewMinx As Float
	Private gViewMiny As Float
	Private gViewWidth As Float
	Private gViewHeight As Float
	Private gAlignX As Int
	Private gAlignY As Int
	Private gAlignType As Int
	Private gDpi As Float
	Private gDefsFlag As Boolean
	Private gStyleFlag As Boolean

	Private gTok As String
	Private gOutX As Float
	Private gOutY As Float
	Private gNa As Int
	Private gPaintType As Int
	Private gCpx As Float
	Private gCpy As Float
	Private gCpx2 As Float
	Private gCpy2 As Float
	Private gColors As Map

	Private gTessTol As Float
	Private gDistTol As Float
	Private gEx0() As Float
	Private gEy0() As Float
	Private gEx1() As Float
	Private gEy1() As Float
	Private gEdir() As Int
	Private gNedges As Int
	Private gOrder() As Int
	Private gTmpOrder() As Int
	Private gPtX() As Float
	Private gPtY() As Float
	Private gPtDx() As Float
	Private gPtDy() As Float
	Private gPtDmx() As Float
	Private gPtDmy() As Float
	Private gPtFl() As Int
	Private gNpoints As Int
	Private gQtX() As Float
	Private gQtY() As Float
	Private gQtFl() As Int
	Private gNpoints2 As Int
	Private gAx() As Int
	Private gAdx() As Int
	Private gAdir() As Int
	Private gAnext() As Int
	Private gAey() As Float
	Private gAcount As Int
	Private gAfree As Int
	Private gScan() As Int
	Private gBmp() As Byte
	Private gW As Int
	Private gH As Int
	Private gStride As Int
	Private gXmin As Int
	Private gXmax As Int
	Private gCType As Int
	Private gCx(6) As Float
	Private gCcolors(256) As Int
End Sub

' Initialize
Public Sub Initialize
	LoadColors
	gTessTol = 0.25
	gDistTol = 0.01
	'InitArrays
End Sub

Private Sub InitArrays
	gShapes.Initialize
	gPlist.Initialize
	gGradients.Initialize
	gStyles.Initialize
	
	gEx0 = Array As Float()
	gEy0 = Array As Float()
	gEx1 = Array As Float()
	gEy1 = Array As Float()
	gPtX = Array As Float()
	gPtY = Array As Float()
	gPtDx = Array As Float()
	gPtDy = Array As Float()
	gPtDmx = Array As Float()
	gPtDmy = Array As Float()
	gQtX = Array As Float()
	gQtY = Array As Float()
	gAey = Array As Float()
	
	gEdir = Array As Int()
	gPtFl = Array As Int()
	gQtFl = Array As Int()
	gAx = Array As Int()
	gAdx = Array As Int()
	gAdir = Array As Int()
	gAnext = Array As Int()
	gScan = Array As Int()
	gOrder = Array As Int()
	gTmpOrder = Array As Int()
	
	gBmp = Array As Byte()
	
	gNedges = 0
	gNpoints = 0
	gNpoints2 = 0
End Sub

' ** Description:
' Img - target
' SvgStr - Svg text
' Align - Alignment svg. Take a look at the optional keyboard. 
'    7: left/top, 8: center/top, 9: right/top, 
'    4: left/center, 5: (default) center/center, 6: right/center, 
'    1: left/bottom, 2: center/bottom, 3: right/bottom.
' Scale - Scale final image
' mScale - 0: auto scale, 1: scaling relative to width, 2: scaling relative to height
' OffsetX and OffsetX: shift by X and Y
Public Sub Render(Img As B4XImageView, SvgStr As String, Align As Int = 5, Scale As Float = 1, mScale As Int = 0, OffsetX As Int = 0, OffsetY As Int = 0) As Boolean
	If SvgStr = Null Or SvgStr = "" Then Return False
	
	Dim ww As Int = Img.mBase.Width
	Dim hh As Int = Img.mBase.Height
	If ww <= 0 Or hh <= 0 Then Return False
	
	If Align < 1 Or Align > 9 Then Align = 5
	If Scale <= 0 Then Scale = 1
	If mScale < 0 Or mScale > 2 Then mScale = 0
	
	InitArrays
	NsvgParse(SvgStr, "px", 96)
	If gImgW <= 0 Or gImgH <= 0 Then Return False
	
	If mScale = 0 Then mScale = IIf(gImgW > gImgH, 1, 2)
	Scale = Scale * IIf(mScale = 1, ww / gImgW, hh / gImgH)
	
	Dim pozX As Int = (ww - (Scale * gImgW)) / 2 * ((Align - 1) Mod 3)
	Dim pozY As Int = (hh - (Scale * gImgH)) / 2 * (2 - Floor((Align - 1) / 3))
	
	Dim imgdata(ww * hh * 4 + 4) As Byte
	NsvgRasterize(imgdata, OffsetX + pozX, OffsetY + pozY, Scale, ww, hh, ww * 4)
	
	Dim bc As BitmapCreator
	bc.Initialize(ww, hh)
	
	Dim lick As Int
	For y = 0 To hh - 1
		For x = 0 To ww - 1
			bc.SetColor(x, y, xui.Color_ARGB( _
                Bit.And(0xff, imgdata(lick + 3)), Bit.And(0xff, imgdata(lick)), _
                Bit.And(0xff, imgdata(lick + 1)), Bit.And(0xff, imgdata(lick + 2))))
			lick = lick + 4
		Next
	Next
	
	Img.Bitmap = bc.Bitmap
	Return True	
End Sub

Private Sub CH(s As String, i As Int) As Int
	If i < 0 Or i >= s.Length Then Return 0
	Return Asc(s.CharAt(i))
End Sub

Private Sub IsSpace(c As Int) As Boolean
	Return c = 32 Or (c >= 9 And c <= 13) Or c = 0
End Sub

Private Sub IsWs(c As Int) As Boolean
	Return c <> 0 And (c = 32 Or (c >= 9 And c <= 13))
End Sub

Private Sub IsDigit(c As Int) As Boolean
	Return c >= 48 And c <= 57
End Sub

Private Sub Sub2(s As String, a As Int, b As Int) As String
	If a < 0 Then a = 0
	If b > s.Length Then b = s.Length
	If b <= a Then Return ""
	Return s.SubString2(a, b)
End Sub

Private Sub StartsAt(s As String, pos As Int, pat As String) As Boolean
	If pos + pat.Length > s.Length Then Return False
	Return s.SubString2(pos, pos + pat.Length) = pat
End Sub

Private Sub F2I(v As Double) As Int
	If v >= 0 Then
		Return Floor(v)
	Else
		Return Ceil(v)
	End If
End Sub

Private Sub RoundF(x As Double) As Double
	If x >= 0 Then
		Return Floor(x + 0.5)
	Else
		Return Ceil(x - 0.5)
	End If
End Sub

Private Sub MinF(a As Float, b As Float) As Float
	If a < b Then Return a Else Return b
End Sub

Private Sub MaxF(a As Float, b As Float) As Float
	If a > b Then Return a Else Return b
End Sub

Private Sub ClampF(a As Float, mn As Float, mx As Float) As Float
	If a <> a Then Return mn
	If a < mn Then Return mn
	If a > mx Then Return mx
	Return a
End Sub

Private Sub FmodF(a As Float, b As Float) As Float
	Dim q As Double = a / b
	If q >= 0 Then
		q = Floor(q)
	Else
		q = Ceil(q)
	End If
	Return a - b * q
End Sub

Private Sub Coord(v As Float, u As Int) As nanoSvg_coord
	Dim c As nanoSvg_coord
	c.Initialize
	c.value = v
	c.units = u
	Return c
End Sub

Private Sub RGB3(r As Int, g As Int, b As Int) As Int
	Return Bit.Or(Bit.Or(r, Bit.ShiftLeft(g, 8)), Bit.ShiftLeft(b, 16))
End Sub

Private Sub AtofAt(s As String, start As Int) As Double
	Dim cur As Int = start
	Dim sign As Double = 1
	Dim res As Double = 0
	Dim hasInt As Boolean = False
	Dim hasFrac As Boolean = False
	Dim c As Int = CH(s, cur)
	If c = 43 Then
		cur = cur + 1
	Else If c = 45 Then
		sign = -1
		cur = cur + 1
	End If
	Do While IsDigit(CH(s, cur))
		res = res * 10 + (CH(s, cur) - 48)
		hasInt = True
		cur = cur + 1
	Loop
	If CH(s, cur) = 46 Then
		cur = cur + 1
		Dim scl As Double = 1
		Dim fr As Double = 0
		Do While IsDigit(CH(s, cur))
			fr = fr * 10 + (CH(s, cur) - 48)
			scl = scl * 10
			hasFrac = True
			cur = cur + 1
		Loop
		If hasFrac Then res = res + fr / scl
	End If
	If hasInt = False And hasFrac = False Then Return 0
	c = CH(s, cur)
	If c = 101 Or c = 69 Then
		cur = cur + 1
		Dim esign As Int = 1
		c = CH(s, cur)
		If c = 43 Then
			cur = cur + 1
		Else If c = 45 Then
			esign = -1
			cur = cur + 1
		End If
		Dim ev As Int = 0
		Dim hasExp As Boolean = False
		Do While IsDigit(CH(s, cur))
			If ev < 10000 Then ev = ev * 10 + (CH(s, cur) - 48)
			hasExp = True
			cur = cur + 1
		Loop
		If hasExp Then res = res * Power(10, esign * ev)
	End If
	Return res * sign
End Sub

Private Sub Atof(s As String) As Double
	Return AtofAt(s, 0)
End Sub

Private Sub ParseNumber(s As String, pos As Int) As Int
	Dim start As Int = pos
	Dim c As Int = CH(s, pos)
	If c = 45 Or c = 43 Then pos = pos + 1
	Do While IsDigit(CH(s, pos))
		pos = pos + 1
	Loop
	If CH(s, pos) = 46 Then
		pos = pos + 1
		Do While IsDigit(CH(s, pos))
			pos = pos + 1
		Loop
	End If
	c = CH(s, pos)
	If c = 101 Or c = 69 Then
		Dim c1 As Int = CH(s, pos + 1)
		If c1 <> 109 And c1 <> 120 Then
			pos = pos + 1
			c = CH(s, pos)
			If c = 45 Or c = 43 Then pos = pos + 1
			Do While IsDigit(CH(s, pos))
				pos = pos + 1
			Loop
		End If
	End If
	Dim e As Int = pos
	If e - start > 63 Then e = start + 63
	gTok = Sub2(s, start, e)
	Return pos
End Sub

Private Sub GetNextPathItemWhenArcFlag(s As String, pos As Int) As Int
	gTok = ""
	Do While CH(s, pos) <> 0 And (IsWs(CH(s, pos)) Or CH(s, pos) = 44)
		pos = pos + 1
	Loop
	If CH(s, pos) = 0 Then Return pos
	If CH(s, pos) = 48 Or CH(s, pos) = 49 Then
		gTok = Sub2(s, pos, pos + 1)
		Return pos + 1
	End If
	Return pos
End Sub

Private Sub GetNextPathItem(s As String, pos As Int) As Int
	gTok = ""
	Do While CH(s, pos) <> 0 And (IsWs(CH(s, pos)) Or CH(s, pos) = 44)
		pos = pos + 1
	Loop
	If CH(s, pos) = 0 Then Return pos
	Dim c As Int = CH(s, pos)
	If c = 45 Or c = 43 Or c = 46 Or IsDigit(c) Then
		Return ParseNumber(s, pos)
	End If
	gTok = Sub2(s, pos, pos + 1)
	Return pos + 1
End Sub

Private Sub GetNextDashItem(s As String, pos As Int) As Int
	gTok = ""
	Do While CH(s, pos) <> 0 And (IsWs(CH(s, pos)) Or CH(s, pos) = 44)
		pos = pos + 1
	Loop
	Dim st As Int = pos
	Do While CH(s, pos) <> 0 And IsWs(CH(s, pos)) = False And CH(s, pos) <> 44
		pos = pos + 1
	Loop
	Dim e As Int = pos
	If e - st > 63 Then e = st + 63
	gTok = Sub2(s, st, e)
	Return pos
End Sub

Private Sub IsCoordinate(s As String) As Boolean
	Dim p As Int = 0
	If CH(s, 0) = 45 Or CH(s, 0) = 43 Then p = 1
	Return IsDigit(CH(s, p)) Or CH(s, p) = 46
End Sub

Private Sub LoadColors
	gColors = CreateMap( _
		"aliceblue": 0xFFF8F0, "antiquewhite": 0xD7EBFA, "aqua": 0xFFFF00, "aquamarine": 0xD4FF7F, _
		"azure": 0xFFFFF0, "beige": 0xDCF5F5, "bisque": 0xC4E4FF, "black": 0x000000, _
		"blanchedalmond": 0xCDEBFF, "blue": 0xFF0000, "blueviolet": 0xE22B8A, "brown": 0x2A2AA5, _
		"burlywood": 0x87B8DE, "cadetblue": 0xA09E5F, "chartreuse": 0x00FF7F, "chocolate": 0x1E69D2, _
		"coral": 0x507FFF, "cornflowerblue": 0xED9564, "cornsilk": 0xDCF8FF, "crimson": 0x3C14DC, _
		"cyan": 0xFFFF00, "darkblue": 0x8B0000, "darkcyan": 0x8B8B00, "darkgoldenrod": 0x0B86B8, _
		"darkgray": 0xA9A9A9, "darkgreen": 0x006400, "darkgrey": 0xA9A9A9, "darkkhaki": 0x6BB7BD, _
		"darkmagenta": 0x8B008B, "darkolivegreen": 0x2F6B55, "darkorange": 0x008CFF, "darkorchid": 0xCC3299, _
		"darkred": 0x00008B, "darksalmon": 0x7A96E9, "darkseagreen": 0x8FBC8F, "darkslateblue": 0x8B3D48, _
		"darkslategray": 0x4F4F2F, "darkslategrey": 0x4F4F2F, "darkturquoise": 0xD1CE00, "darkviolet": 0xD30094, _
		"deeppink": 0x9314FF, "deepskyblue": 0xFFBF00, "dimgray": 0x696969, "dimgrey": 0x696969, _
		"dodgerblue": 0xFF901E, "firebrick": 0x2222B2, "floralwhite": 0xF0FAFF, "forestgreen": 0x228B22, _
		"fuchsia": 0xFF00FF, "gainsboro": 0xDCDCDC, "ghostwhite": 0xFFF8F8, "gold": 0x00D7FF, _
		"goldenrod": 0x20A5DA, "gray": 0x808080, "green": 0x008000, "greenyellow": 0x2FFFAD, _
		"grey": 0x808080, "honeydew": 0xF0FFF0, "hotpink": 0xB469FF, "indianred": 0x5C5CCD, _
		"indigo": 0x82004B, "ivory": 0xF0FFFF, "khaki": 0x8CE6F0, "lavender": 0xFAE6E6, _
		"lavenderblush": 0xF5F0FF, "lawngreen": 0x00FC7C, "lemonchiffon": 0xCDFAFF, "lightblue": 0xE6D8AD, _
		"lightcoral": 0x8080F0, "lightcyan": 0xFFFFE0, "lightgoldenrodyellow": 0xD2FAFA, "lightgray": 0xD3D3D3, _
		"lightgreen": 0x90EE90, "lightgrey": 0xD3D3D3, "lightpink": 0xC1B6FF, "lightsalmon": 0x7AA0FF, _
		"lightseagreen": 0xAAB220, "lightskyblue": 0xFACE87, "lightslategray": 0x998877, "lightslategrey": 0x998877, _
		"lightsteelblue": 0xDEC4B0, "lightyellow": 0xE0FFFF, "lime": 0x00FF00, "limegreen": 0x32CD32, _
		"linen": 0xE6F0FA, "magenta": 0xFF00FF, "maroon": 0x000080, "mediumaquamarine": 0xAACD66, _
		"mediumblue": 0xCD0000, "mediumorchid": 0xD355BA, "mediumpurple": 0xDB7093, "mediumseagreen": 0x71B33C, _
		"mediumslateblue": 0xEE687B, "mediumspringgreen": 0x9AFA00, "mediumturquoise": 0xCCD148, "mediumvioletred": 0x8515C7, _
		"midnightblue": 0x701919, "mintcream": 0xFAFFF5, "mistyrose": 0xE1E4FF, "moccasin": 0xB5E4FF, _
		"navajowhite": 0xADDEFF, "navy": 0x800000, "oldlace": 0xE6F5FD, "olive": 0x008080, _
		"olivedrab": 0x238E6B, "orange": 0x00A5FF, "orangered": 0x0045FF, "orchid": 0xDA70D6, _
		"palegoldenrod": 0xAAE8EE, "palegreen": 0x98FB98, "paleturquoise": 0xEEEEAF, "palevioletred": 0x9370DB, _
		"papayawhip": 0xD5EFFF, "peachpuff": 0xB9DAFF, "peru": 0x3F85CD, "pink": 0xCBC0FF, _
		"plum": 0xDDA0DD, "powderblue": 0xE6E0B0, "purple": 0x800080, "rebeccapurple": 0x993366, _
		"red": 0x0000FF, "rosybrown": 0x8F8FBC, "royalblue": 0xE16941, "saddlebrown": 0x13458B, _
		"salmon": 0x7280FA, "sandybrown": 0x60A4F4, "seagreen": 0x578B2E, "seashell": 0xEEF5FF, _
		"sienna": 0x2D52A0, "silver": 0xC0C0C0, "skyblue": 0xEBCD87, "slateblue": 0xCD5A6A, _
		"slategray": 0x908070, "slategrey": 0x908070, "snow": 0xFAFFFA, "springgreen": 0x7FFF00, _
		"steelblue": 0xB48246, "tan": 0x8CB4D2, "teal": 0x808000, "thistle": 0xD8BFD8, _
		"tomato": 0x4763FF, "transparent": 0x000000, "turquoise": 0xD0E040, "violet": 0xEE82EE, _
		"wheat": 0xB3DEF5, "white": 0xFFFFFF, "whitesmoke": 0xF5F5F5, "yellow": 0x00FFFF, _
		"yellowgreen": 0x32CD9A _
	)
End Sub

Private Sub ParseColorName(s As String) As Int
	If gColors.ContainsKey(s) Then Return gColors.Get(s)
	Return RGB3(128, 128, 128)
End Sub

Private Sub HexFields(s As String, maxd As Int, v() As Int) As Boolean
	Dim pos As Int = 1
	For i = 0 To 2
		Dim n As Int = 0
		Dim val As Int = 0
		Do While n < maxd
			Dim c As Int = CH(s, pos)
			Dim d As Int = -1
			If c >= 48 And c <= 57 Then
				d = c - 48
			Else If c >= 97 And c <= 102 Then
				d = c - 87
			Else If c >= 65 And c <= 70 Then
				d = c - 55
			End If
			If d < 0 Then Exit
			val = val * 16 + d
			n = n + 1
			pos = pos + 1
		Loop
		If n = 0 Then Return False
		v(i) = val
	Next
	Return True
End Sub

Private Sub ParseColorHex(s As String) As Int
	Dim v(3) As Int
	If HexFields(s, 2, v) Then Return RGB3(v(0), v(1), v(2))
	If HexFields(s, 1, v) Then Return RGB3(v(0) * 17, v(1) * 17, v(2) * 17)
	Return RGB3(128, 128, 128)
End Sub

Private Sub SkipWs(s As String, pos As Int) As Int
	Do While IsWs(CH(s, pos))
		pos = pos + 1
	Loop
	Return pos
End Sub

Private Sub ParseColorRGB(s As String) As Int
	Dim rgbi(3) As Int
	Dim rgbf(3) As Float
	Dim pos As Int = 4
	Dim sc As Int = 0
	Dim i As Int
	For i = 0 To 2
		pos = SkipWs(s, pos)
		Dim neg As Boolean = False
		Dim c As Int = CH(s, pos)
		If c = 43 Then
			pos = pos + 1
		Else If c = 45 Then
			neg = True
			pos = pos + 1
		End If
		If IsDigit(CH(s, pos)) = False Then Exit
		Dim v As Double = 0
		Do While IsDigit(CH(s, pos))
			If v < 100000 Then v = v * 10 + (CH(s, pos) - 48)
			pos = pos + 1
		Loop
		If neg And v > 0 Then v = 100000
		rgbi(i) = v
		sc = sc + 1
		If i < 2 Then
			pos = SkipWs(s, pos)
			If CH(s, pos) <> 44 Then Exit
			pos = pos + 1
		End If
	Next
	If sc <> 3 Then
		Dim delim(3) As Int
		delim(0) = 44 : delim(1) = 44 : delim(2) = 41
		pos = 4
		i = 0
		Do While i < 3
			pos = SkipWs(s, pos)
			If CH(s, pos) = 43 Then pos = pos + 1
			If CH(s, pos) = 0 Then Exit
			rgbf(i) = AtofAt(s, pos)
			Do While IsDigit(CH(s, pos))
				pos = pos + 1
			Loop
			If CH(s, pos) = 46 Then
				pos = pos + 1
				If IsDigit(CH(s, pos)) = False Then Exit
				Do While IsDigit(CH(s, pos))
					pos = pos + 1
				Loop
			End If
			If CH(s, pos) = 37 Then
				pos = pos + 1
			Else
				Exit
			End If
			pos = SkipWs(s, pos)
			If CH(s, pos) = delim(i) Then
				pos = pos + 1
			Else
				Exit
			End If
			i = i + 1
		Loop
		If i = 3 Then
			rgbi(0) = RoundF(rgbf(0) * 2.55)
			rgbi(1) = RoundF(rgbf(1) * 2.55)
			rgbi(2) = RoundF(rgbf(2) * 2.55)
		Else
			rgbi(0) = 128 : rgbi(1) = 128 : rgbi(2) = 128
		End If
	End If
	For i = 0 To 2
		If rgbi(i) > 255 Then rgbi(i) = 255
	Next
	Return RGB3(rgbi(0), rgbi(1), rgbi(2))
End Sub

Private Sub ParseColor(str As String) As Int
	Dim p As Int = 0
	Do While CH(str, p) = 32
		p = p + 1
	Loop
	Dim s As String = str.SubString(p)
	If s.Length >= 1 And CH(s, 0) = 35 Then
		Return ParseColorHex(s)
	Else If s.Length >= 4 And s.StartsWith("rgb(") Then
		Return ParseColorRGB(s)
	End If
	Return ParseColorName(s)
End Sub

Private Sub ParseOpacity(s As String) As Float
	Dim v As Float = Atof(s)
	If v < 0 Then v = 0
	If v > 1 Then v = 1
	Return v
End Sub

Private Sub ParseMiterLimit(s As String) As Float
	Dim v As Float = Atof(s)
	If v < 0 Then v = 0
	Return v
End Sub

Private Sub ParseUnits(s As String, p As Int) As Int
	Dim a As Int = CH(s, p)
	Dim b As Int = CH(s, p + 1)
	If a = 112 And b = 120 Then
		Return NSVG_UNITS_PX
	Else If a = 112 And b = 116 Then
		Return NSVG_UNITS_PT
	Else If a = 112 And b = 99 Then
		Return NSVG_UNITS_PC
	Else If a = 109 And b = 109 Then
		Return NSVG_UNITS_MM
	Else If a = 99 And b = 109 Then
		Return NSVG_UNITS_CM
	Else If a = 105 And b = 110 Then
		Return NSVG_UNITS_IN
	Else If a = 37 Then
		Return NSVG_UNITS_PERCENT
	Else If a = 101 And b = 109 Then
		Return NSVG_UNITS_EM
	Else If a = 101 And b = 120 Then
		Return NSVG_UNITS_EX
	End If
	Return NSVG_UNITS_USER
End Sub

Private Sub ParseCoordinateRaw(s As String) As nanoSvg_coord
	Dim c As nanoSvg_coord = Coord(0, NSVG_UNITS_USER)
	Dim pos As Int = ParseNumber(s, 0)
	c.units = ParseUnits(s, pos)
	c.value = Atof(gTok)
	Return c
End Sub

Private Sub ParseCoordinate(s As String, orig As Float, length As Float) As Float
	Return ConvertToPixels(ParseCoordinateRaw(s), orig, length)
End Sub

Private Sub XformIdentity(t() As Float)
	t(0) = 1
	t(1) = 0
	t(2) = 0
	t(3) = 1
	t(4) = 0
	t(5) = 0
End Sub

Private Sub XformSetTranslation(t() As Float, tx As Float, ty As Float)
	t(0) = 1
	t(1) = 0
	t(2) = 0
	t(3) = 1
	t(4) = tx
	t(5) = ty
End Sub

Private Sub XformSetScale(t() As Float, sx As Float, sy As Float)
	t(0) = sx
	t(1) = 0
	t(2) = 0
	t(3) = sy
	t(4) = 0
	t(5) = 0
End Sub

Private Sub XformSetSkewX(t() As Float, a As Float)
	t(0) = 1
	t(1) = 0
	t(2) = Tan(a)
	t(3) = 1
	t(4) = 0
	t(5) = 0
End Sub

Private Sub XformSetSkewY(t() As Float, a As Float)
	t(0) = 1
	t(1) = Tan(a)
	t(2) = 0
	t(3) = 1
	t(4) = 0
	t(5) = 0
End Sub

Private Sub XformSetRotation(t() As Float, a As Float)
	Dim cs As Float = Cos(a)
	Dim sn As Float = Sin(a)
	t(0) = cs
	t(1) = sn
	t(2) = -sn
	t(3) = cs
	t(4) = 0
	t(5) = 0
End Sub

Private Sub XformMultiply(t() As Float, s() As Float)
	Dim t0 As Float = t(0) * s(0) + t(1) * s(2)
	Dim t2 As Float = t(2) * s(0) + t(3) * s(2)
	Dim t4 As Float = t(4) * s(0) + t(5) * s(2) + s(4)
	t(1) = t(0) * s(1) + t(1) * s(3)
	t(3) = t(2) * s(1) + t(3) * s(3)
	t(5) = t(4) * s(1) + t(5) * s(3) + s(5)
	t(0) = t0
	t(2) = t2
	t(4) = t4
End Sub

Private Sub XformInverse(inv() As Float, t() As Float)
	Dim det As Double = t(0) * t(3) - t(2) * t(1)
	If det > -0.000001 And det < 0.000001 Then
		XformIdentity(t)
		Return
	End If
	Dim invdet As Double = 1 / det
	inv(0) = t(3) * invdet
	inv(2) = -t(2) * invdet
	inv(4) = (t(2) * t(5) - t(3) * t(4)) * invdet
	inv(1) = -t(1) * invdet
	inv(3) = t(0) * invdet
	inv(5) = (t(1) * t(4) - t(0) * t(5)) * invdet
End Sub

Private Sub XformPremultiply(t() As Float, s() As Float)
	Dim s2(6) As Float
	For i = 0 To 5
		s2(i) = s(i)
	Next
	XformMultiply(s2, t)
	For i = 0 To 5
		t(i) = s2(i)
	Next
End Sub

Private Sub XformPoint(x As Float, y As Float, t() As Float)
	gOutX = x * t(0) + y * t(2) + t(4)
	gOutY = x * t(1) + y * t(3) + t(5)
End Sub

Private Sub XformVec(x As Float, y As Float, t() As Float)
	gOutX = x * t(0) + y * t(2)
	gOutY = x * t(1) + y * t(3)
End Sub

Private Sub PtInBounds(x As Float, y As Float, b() As Float) As Boolean
	Return x >= b(0) And x <= b(2) And y >= b(1) And y <= b(3)
End Sub

Private Sub EvalBezier(t As Double, p0 As Double, p1 As Double, p2 As Double, p3 As Double) As Double
	Dim it As Double = 1 - t
	Return it * it * it * p0 + 3 * it * it * t * p1 + 3 * it * t * t * p2 + t * t * t * p3
End Sub

Private Sub CurveBounds(bounds() As Float, c() As Float, off As Int)
	Dim roots(2) As Double
	Dim a, b, cc, b2ac, t, v As Double
	Dim count As Int
	bounds(0) = MinF(c(off), c(off + 6))
	bounds(1) = MinF(c(off + 1), c(off + 7))
	bounds(2) = MaxF(c(off), c(off + 6))
	bounds(3) = MaxF(c(off + 1), c(off + 7))
	If PtInBounds(c(off + 2), c(off + 3), bounds) And PtInBounds(c(off + 4), c(off + 5), bounds) Then Return
	For i = 0 To 1
		Dim v0 As Double = c(off + i)
		Dim v1 As Double = c(off + 2 + i)
		Dim v2 As Double = c(off + 4 + i)
		Dim v3 As Double = c(off + 6 + i)
		a = -3 * v0 + 9 * v1 - 9 * v2 + 3 * v3
		b = 6 * v0 - 12 * v1 + 6 * v2
		cc = 3 * v1 - 3 * v0
		count = 0
		If Abs(a) < NSVG_EPSILON Then
			If Abs(b) > NSVG_EPSILON Then
				t = -cc / b
				If t > NSVG_EPSILON And t < 1 - NSVG_EPSILON Then
					roots(count) = t
					count = count + 1
				End If
			End If
		Else
			b2ac = b * b - 4 * cc * a
			If b2ac > NSVG_EPSILON Then
				t = (-b + Sqrt(b2ac)) / (2 * a)
				If t > NSVG_EPSILON And t < 1 - NSVG_EPSILON Then
					roots(count) = t
					count = count + 1
				End If
				t = (-b - Sqrt(b2ac)) / (2 * a)
				If t > NSVG_EPSILON And t < 1 - NSVG_EPSILON Then
					roots(count) = t
					count = count + 1
				End If
			End If
		End If
		For j = 0 To count - 1
			v = EvalBezier(roots(j), v0, v1, v2, v3)
			bounds(0 + i) = MinF(bounds(0 + i), v)
			bounds(2 + i) = MaxF(bounds(2 + i), v)
		Next
	Next
End Sub

Private Sub EncodePaintOrder(a As Int, b As Int, c As Int) As Int
	Return Bit.Or(Bit.Or(Bit.And(a, 3), Bit.ShiftLeft(Bit.And(b, 3), 2)), Bit.ShiftLeft(Bit.And(c, 3), 4))
End Sub

Private Sub NewAttr As nanoSvg_attrib
	Dim a As nanoSvg_attrib
	a.Initialize
	a.fillGradient = ""
	a.strokeGradient = ""
	Dim xf(6) As Float
	XformIdentity(xf)
	a.xform = xf
	Dim da(NSVG_MAX_DASHES) As Float
	a.strokeDashArray = da
	Return a
End Sub

Private Sub CopyAttr(d As nanoSvg_attrib, s As nanoSvg_attrib)
	For i = 0 To 5
		d.xform(i) = s.xform(i)
	Next
	d.fillColor = s.fillColor
	d.strokeColor = s.strokeColor
	d.opacity = s.opacity
	d.fillOpacity = s.fillOpacity
	d.strokeOpacity = s.strokeOpacity
	d.fillGradient = s.fillGradient
	d.strokeGradient = s.strokeGradient
	d.strokeWidth = s.strokeWidth
	d.strokeDashOffset = s.strokeDashOffset
	For i = 0 To NSVG_MAX_DASHES - 1
		d.strokeDashArray(i) = s.strokeDashArray(i)
	Next
	d.strokeDashCount = s.strokeDashCount
	d.strokeLineJoin = s.strokeLineJoin
	d.strokeLineCap = s.strokeLineCap
	d.miterLimit = s.miterLimit
	d.fillRule = s.fillRule
	d.fontSize = s.fontSize
	d.stopColor = s.stopColor
	d.stopOpacity = s.stopOpacity
	d.stopOffset = s.stopOffset
	d.hasFill = s.hasFill
	d.hasStroke = s.hasStroke
	d.visible = s.visible
	d.paintOrder = s.paintOrder
End Sub

Private Sub ResetParser
	gShapes.Initialize
	gPlist.Initialize
	gGradients.Initialize
	gStyles.Initialize
	For i = 0 To NSVG_MAX_ATTR - 1
		gAttrs(i) = NewAttr
	Next
	gAttrHead = 0
	Dim a As nanoSvg_attrib = gAttrs(0)
	a.fillColor = RGB3(0, 0, 0)
	a.strokeColor = RGB3(0, 0, 0)
	a.opacity = 1
	a.fillOpacity = 1
	a.strokeOpacity = 1
	a.stopOpacity = 1
	a.strokeWidth = 1
	a.strokeLineJoin = NSVG_JOIN_MITER
	a.strokeLineCap = NSVG_CAP_BUTT
	a.miterLimit = 4
	a.fillRule = NSVG_FILLRULE_NONZERO
	a.hasFill = 1
	a.visible = True
	a.paintOrder = EncodePaintOrder(NSVG_PAINT_FILL, NSVG_PAINT_STROKE, NSVG_PAINT_MARKERS)
	Dim p0(16) As Float
	gPts = p0
	gNpts = 0
	gImgW = 0
	gImgH = 0
	gViewMinx = 0
	gViewMiny = 0
	gViewWidth = 0
	gViewHeight = 0
	gAlignX = 0
	gAlignY = 0
	gAlignType = 0
	gDefsFlag = False
	gStyleFlag = False
End Sub

Private Sub ResetPath
	gNpts = 0
End Sub

Private Sub AddPoint(x As Float, y As Float)
	If (gNpts + 1) * 2 > gPts.Length Then
		Dim n(gPts.Length * 2 + 16) As Float
		For i = 0 To gNpts * 2 - 1
			n(i) = gPts(i)
		Next
		gPts = n
	End If
	gPts(gNpts * 2) = x
	gPts(gNpts * 2 + 1) = y
	gNpts = gNpts + 1
End Sub

Private Sub MoveTo(x As Float, y As Float)
	If gNpts > 0 Then
		gPts((gNpts - 1) * 2) = x
		gPts((gNpts - 1) * 2 + 1) = y
	Else
		AddPoint(x, y)
	End If
End Sub

Private Sub LineTo(x As Float, y As Float)
	If gNpts > 0 Then
		Dim px As Float = gPts((gNpts - 1) * 2)
		Dim py As Float = gPts((gNpts - 1) * 2 + 1)
		Dim dx As Float = x - px
		Dim dy As Float = y - py
		AddPoint(px + dx / 3, py + dy / 3)
		AddPoint(x - dx / 3, y - dy / 3)
		AddPoint(x, y)
	End If
End Sub

Private Sub CubicBezTo(cpx1 As Float, cpy1 As Float, cpx2 As Float, cpy2 As Float, x As Float, y As Float)
	If gNpts > 0 Then
		AddPoint(cpx1, cpy1)
		AddPoint(cpx2, cpy2)
		AddPoint(x, y)
	End If
End Sub

Private Sub ActualLength As Float
	Return Sqrt(gViewWidth * gViewWidth + gViewHeight * gViewHeight) / Sqrt(2)
End Sub

Private Sub ConvertToPixels(c As nanoSvg_coord, orig As Float, length As Float) As Float
	Dim attr As nanoSvg_attrib = gAttrs(gAttrHead)
	Select Case c.units
		Case NSVG_UNITS_USER, NSVG_UNITS_PX
			Return c.value
		Case NSVG_UNITS_PT
			Return c.value / 72 * gDpi
		Case NSVG_UNITS_PC
			Return c.value / 6 * gDpi
		Case NSVG_UNITS_MM
			Return c.value / 25.4 * gDpi
		Case NSVG_UNITS_CM
			Return c.value / 2.54 * gDpi
		Case NSVG_UNITS_IN
			Return c.value * gDpi
		Case NSVG_UNITS_EM
			Return c.value * attr.fontSize
		Case NSVG_UNITS_EX
			Return c.value * attr.fontSize * 0.52
		Case NSVG_UNITS_PERCENT
			Return orig + c.value / 100 * length
	End Select
	Return c.value
End Sub

Private Sub FindGradientData(id As String) As nanoSvg_gradientData
	If id.Length = 0 Then Return Null
	For i = gGradients.Size - 1 To 0 Step -1
		Dim g As nanoSvg_gradientData = gGradients.Get(i)
		If g.id = id Then Return g
	Next
	Return Null
End Sub

Private Sub NewGradientData As nanoSvg_gradientData
	Dim g As nanoSvg_gradientData
	g.Initialize
	g.id = ""
	g.href = ""
	Dim xf(6) As Float
	XformIdentity(xf)
	g.xform = xf
	g.stopColors.Initialize
	g.stopOffsets.Initialize
	g.x1 = Coord(0, NSVG_UNITS_USER)
	g.y1 = Coord(0, NSVG_UNITS_USER)
	g.x2 = Coord(0, NSVG_UNITS_USER)
	g.y2 = Coord(0, NSVG_UNITS_USER)
	g.cx = Coord(0, NSVG_UNITS_USER)
	g.cy = Coord(0, NSVG_UNITS_USER)
	g.r = Coord(0, NSVG_UNITS_USER)
	Return g
End Sub

Private Sub CreateGradient(id As String, localBounds() As Float, xform() As Float) As nanoSvg_gradient
	Dim data As nanoSvg_gradientData = FindGradientData(id)
	If data = Null Then Return Null
	Dim ref As nanoSvg_gradientData = data
	Dim src As nanoSvg_gradientData = Null
	Dim refIter As Int = 0
	Do While ref <> Null
		If ref.nstops > 0 Then
			src = ref
			Exit
		End If
		Dim nextRef As nanoSvg_gradientData = FindGradientData(ref.href)
		If nextRef = ref Then Exit
		ref = nextRef
		refIter = refIter + 1
		If refIter > 32 Then Exit
	Loop
	If src = Null Then Return Null

	Dim grad As nanoSvg_gradient
	grad.Initialize
	Dim gx(6) As Float
	grad.xform = gx
	Dim ox, oy, sw, sh, sl As Float
	If data.units = NSVG_OBJECT_SPACE Then
		ox = localBounds(0)
		oy = localBounds(1)
		sw = localBounds(2) - localBounds(0)
		sh = localBounds(3) - localBounds(1)
	Else
		ox = gViewMinx
		oy = gViewMiny
		sw = gViewWidth
		sh = gViewHeight
	End If
	sl = Sqrt(sw * sw + sh * sh) / Sqrt(2)
	If data.gtype = NSVG_PAINT_LINEAR_GRADIENT Then
		Dim x1 As Float = ConvertToPixels(data.x1, ox, sw)
		Dim y1 As Float = ConvertToPixels(data.y1, oy, sh)
		Dim x2 As Float = ConvertToPixels(data.x2, ox, sw)
		Dim y2 As Float = ConvertToPixels(data.y2, oy, sh)
		Dim dx As Float = x2 - x1
		Dim dy As Float = y2 - y1
		grad.xform(0) = dy
		grad.xform(1) = -dx
		grad.xform(2) = dx
		grad.xform(3) = dy
		grad.xform(4) = x1
		grad.xform(5) = y1
	Else
		Dim cx As Float = ConvertToPixels(data.cx, ox, sw)
		Dim cy As Float = ConvertToPixels(data.cy, oy, sh)
		Dim r As Float = ConvertToPixels(data.r, 0, sl)
		grad.xform(0) = r
		grad.xform(1) = 0
		grad.xform(2) = 0
		grad.xform(3) = r
		grad.xform(4) = cx
		grad.xform(5) = cy
	End If
	XformMultiply(grad.xform, data.xform)
	XformMultiply(grad.xform, xform)
	Dim n As Int = src.nstops
	Dim sc(n) As Int
	Dim so(n) As Float
	For i = 0 To n - 1
		sc(i) = src.stopColors.Get(i)
		so(i) = src.stopOffsets.Get(i)
	Next
	grad.stopColors = sc
	grad.stopOffsets = so
	grad.nstops = n
	gPaintType = data.gtype
	Return grad
End Sub

Private Sub GetAverageScale(t() As Float) As Float
	Dim sx As Float = Sqrt(t(0) * t(0) + t(2) * t(2))
	Dim sy As Float = Sqrt(t(1) * t(1) + t(3) * t(3))
	Return (sx + sy) * 0.5
End Sub

Private Sub GetLocalBounds(bounds() As Float, shape As nanoSvg_shape, xform() As Float)
	Dim curve(8) As Float
	Dim cb(4) As Float
	Dim first As Boolean = True
	For Each path As nanoSvg_path In shape.paths
		XformPoint(path.pts(0), path.pts(1), xform)
		curve(0) = gOutX
		curve(1) = gOutY
		Dim i As Int = 0
		Do While i < path.npts - 1
			XformPoint(path.pts((i + 1) * 2), path.pts((i + 1) * 2 + 1), xform)
			curve(2) = gOutX
			curve(3) = gOutY
			XformPoint(path.pts((i + 2) * 2), path.pts((i + 2) * 2 + 1), xform)
			curve(4) = gOutX
			curve(5) = gOutY
			XformPoint(path.pts((i + 3) * 2), path.pts((i + 3) * 2 + 1), xform)
			curve(6) = gOutX
			curve(7) = gOutY
			CurveBounds(cb, curve, 0)
			If first Then
				bounds(0) = cb(0)
				bounds(1) = cb(1)
				bounds(2) = cb(2)
				bounds(3) = cb(3)
				first = False
			Else
				bounds(0) = MinF(bounds(0), cb(0))
				bounds(1) = MinF(bounds(1), cb(1))
				bounds(2) = MaxF(bounds(2), cb(2))
				bounds(3) = MaxF(bounds(3), cb(3))
			End If
			curve(0) = curve(6)
			curve(1) = curve(7)
			i = i + 3
		Loop
	Next
End Sub

Private Sub AddShape
	Dim attr As nanoSvg_attrib = gAttrs(gAttrHead)
	If gPlist.Size = 0 Then Return
	Dim shape As nanoSvg_shape
	shape.Initialize
	shape.fillGradient = attr.fillGradient
	shape.strokeGradient = attr.strokeGradient
	Dim sx(6) As Float
	For i = 0 To 5
		sx(i) = attr.xform(i)
	Next
	shape.xform = sx
	Dim scale As Float = GetAverageScale(attr.xform)
	shape.strokeWidth = attr.strokeWidth * scale
	shape.strokeDashOffset = attr.strokeDashOffset * scale
	shape.strokeDashCount = attr.strokeDashCount
	Dim da(NSVG_MAX_DASHES) As Float
	For i = 0 To attr.strokeDashCount - 1
		da(i) = attr.strokeDashArray(i) * scale
	Next
	shape.strokeDashArray = da
	shape.strokeLineJoin = attr.strokeLineJoin
	shape.strokeLineCap = attr.strokeLineCap
	shape.miterLimit = attr.miterLimit
	shape.fillRule = attr.fillRule
	shape.opacity = attr.opacity
	shape.paintOrder = attr.paintOrder
	shape.paths = gPlist
	Dim newList As List
	newList.Initialize
	gPlist = newList

	Dim sb(4) As Float
	Dim first As nanoSvg_path = shape.paths.Get(0)
	sb(0) = first.bounds(0)
	sb(1) = first.bounds(1)
	sb(2) = first.bounds(2)
	sb(3) = first.bounds(3)
	For i = 1 To shape.paths.Size - 1
		Dim pth As nanoSvg_path = shape.paths.Get(i)
		sb(0) = MinF(sb(0), pth.bounds(0))
		sb(1) = MinF(sb(1), pth.bounds(1))
		sb(2) = MaxF(sb(2), pth.bounds(2))
		sb(3) = MaxF(sb(3), pth.bounds(3))
	Next
	shape.bounds = sb

	If attr.hasFill = 0 Then
		shape.fillType = NSVG_PAINT_NONE
	Else If attr.hasFill = 1 Then
		shape.fillType = NSVG_PAINT_COLOR
		shape.fillColor = Bit.Or(attr.fillColor, Bit.ShiftLeft(F2I(attr.fillOpacity * 255), 24))
	Else If attr.hasFill = 2 Then
		shape.fillType = NSVG_PAINT_UNDEF
	End If
	If attr.hasStroke = 0 Then
		shape.strokeType = NSVG_PAINT_NONE
	Else If attr.hasStroke = 1 Then
		shape.strokeType = NSVG_PAINT_COLOR
		shape.strokeColor = Bit.Or(attr.strokeColor, Bit.ShiftLeft(F2I(attr.strokeOpacity * 255), 24))
	Else If attr.hasStroke = 2 Then
		shape.strokeType = NSVG_PAINT_UNDEF
	End If
	If attr.visible Then shape.flags = 1 Else shape.flags = 0
	gShapes.Add(shape)
End Sub

Private Sub AddPath(closed As Boolean)
	Dim attr As nanoSvg_attrib = gAttrs(gAttrHead)
	If gNpts < 4 Then Return
	If closed Then LineTo(gPts(0), gPts(1))
	If (gNpts Mod 3) <> 1 Then Return
	Dim path As nanoSvg_path
	path.Initialize
	Dim pp(gNpts * 2) As Float
	path.closed = closed
	path.npts = gNpts
	For i = 0 To gNpts - 1
		XformPoint(gPts(i * 2), gPts(i * 2 + 1), attr.xform)
		pp(i * 2) = gOutX
		pp(i * 2 + 1) = gOutY
	Next
	path.pts = pp
	Dim pb(4) As Float
	Dim cb(4) As Float
	Dim k As Int = 0
	Do While k < path.npts - 1
		CurveBounds(cb, pp, k * 2)
		If k = 0 Then
			pb(0) = cb(0)
			pb(1) = cb(1)
			pb(2) = cb(2)
			pb(3) = cb(3)
		Else
			pb(0) = MinF(pb(0), cb(0))
			pb(1) = MinF(pb(1), cb(1))
			pb(2) = MaxF(pb(2), cb(2))
			pb(3) = MaxF(pb(3), cb(3))
		End If
		k = k + 3
	Loop
	path.bounds = pb
	gPlist.InsertAt(0, path)
End Sub

Private Sub ParseTransformArgs(s As String, pos As Int, args() As Float, maxNa As Int) As Int
	gNa = 0
	Dim ptr As Int = pos
	Do While CH(s, ptr) <> 0 And CH(s, ptr) <> 40
		ptr = ptr + 1
	Loop
	If CH(s, ptr) = 0 Then Return 1
	Dim endp As Int = ptr
	Do While CH(s, endp) <> 0 And CH(s, endp) <> 41
		endp = endp + 1
	Loop
	If CH(s, endp) = 0 Then Return 1
	Do While ptr < endp
		Dim c As Int = CH(s, ptr)
		If c = 45 Or c = 43 Or c = 46 Or IsDigit(c) Then
			If gNa >= maxNa Then Return 0
			ptr = ParseNumber(s, ptr)
			args(gNa) = Atof(gTok)
			gNa = gNa + 1
		Else
			ptr = ptr + 1
		End If
	Loop
	Return endp - pos
End Sub

Private Sub ParseMatrix(xform() As Float, s As String, pos As Int) As Int
	Dim t(6) As Float
	Dim len As Int = ParseTransformArgs(s, pos, t, 6)
	If gNa <> 6 Then Return len
	For i = 0 To 5
		xform(i) = t(i)
	Next
	Return len
End Sub

Private Sub ParseTranslate(xform() As Float, s As String, pos As Int) As Int
	Dim args(2) As Float
	Dim t(6) As Float
	Dim len As Int = ParseTransformArgs(s, pos, args, 2)
	If gNa = 1 Then args(1) = 0
	XformSetTranslation(t, args(0), args(1))
	For i = 0 To 5
		xform(i) = t(i)
	Next
	Return len
End Sub

Private Sub ParseScale(xform() As Float, s As String, pos As Int) As Int
	Dim args(2) As Float
	Dim t(6) As Float
	Dim len As Int = ParseTransformArgs(s, pos, args, 2)
	If gNa = 1 Then args(1) = args(0)
	XformSetScale(t, args(0), args(1))
	For i = 0 To 5
		xform(i) = t(i)
	Next
	Return len
End Sub

Private Sub ParseSkewX(xform() As Float, s As String, pos As Int) As Int
	Dim args(1) As Float
	Dim t(6) As Float
	Dim len As Int = ParseTransformArgs(s, pos, args, 1)
	XformSetSkewX(t, args(0) / 180 * cPI)
	For i = 0 To 5
		xform(i) = t(i)
	Next
	Return len
End Sub

Private Sub ParseSkewY(xform() As Float, s As String, pos As Int) As Int
	Dim args(1) As Float
	Dim t(6) As Float
	Dim len As Int = ParseTransformArgs(s, pos, args, 1)
	XformSetSkewY(t, args(0) / 180 * cPI)
	For i = 0 To 5
		xform(i) = t(i)
	Next
	Return len
End Sub

Private Sub ParseRotate(xform() As Float, s As String, pos As Int) As Int
	Dim args(3) As Float
	Dim m(6) As Float
	Dim t(6) As Float
	Dim len As Int = ParseTransformArgs(s, pos, args, 3)
	Dim na As Int = gNa
	If na = 1 Then
		args(1) = 0
		args(2) = 0
	End If
	XformIdentity(m)
	If na > 1 Then
		XformSetTranslation(t, -args(1), -args(2))
		XformMultiply(m, t)
	End If
	XformSetRotation(t, args(0) / 180 * cPI)
	XformMultiply(m, t)
	If na > 1 Then
		XformSetTranslation(t, args(1), args(2))
		XformMultiply(m, t)
	End If
	For i = 0 To 5
		xform(i) = m(i)
	Next
	Return len
End Sub

Private Sub ParseTransform(xform() As Float, s As String)
	Dim t(6) As Float
	Dim len As Int
	Dim pos As Int = 0
	XformIdentity(xform)
	Do While CH(s, pos) <> 0
		XformIdentity(t)
		Dim c As Int = CH(s, pos)
		If c = 109 And StartsAt(s, pos, "matrix") Then
			len = ParseMatrix(t, s, pos)
		Else If c = 116 And StartsAt(s, pos, "translate") Then
			len = ParseTranslate(t, s, pos)
		Else If c = 115 And StartsAt(s, pos, "scale") Then
			len = ParseScale(t, s, pos)
		Else If c = 114 And StartsAt(s, pos, "rotate") Then
			len = ParseRotate(t, s, pos)
		Else If c = 115 And StartsAt(s, pos, "skewX") Then
			len = ParseSkewX(t, s, pos)
		Else If c = 115 And StartsAt(s, pos, "skewY") Then
			len = ParseSkewY(t, s, pos)
		Else
			pos = pos + 1
			Continue
		End If
		If len <> 0 Then
			pos = pos + len
		Else
			pos = pos + 1
			Continue
		End If
		XformPremultiply(xform, t)
	Loop
End Sub

Private Sub ParseUrl(s As String) As String
	Dim pos As Int = 4
	If CH(s, pos) = 35 Then pos = pos + 1
	Dim st As Int = pos
	Dim cnt As Int = 0
	Do While cnt < 63 And CH(s, pos) <> 0 And CH(s, pos) <> 41
		pos = pos + 1
		cnt = cnt + 1
	Loop
	Return Sub2(s, st, pos)
End Sub

Private Sub ParseLineCap(s As String) As Int
	If s = "butt" Then Return NSVG_CAP_BUTT
	If s = "round" Then Return NSVG_CAP_ROUND
	If s = "square" Then Return NSVG_CAP_SQUARE
	Return NSVG_CAP_BUTT
End Sub

Private Sub ParseLineJoin(s As String) As Int
	If s = "miter" Then Return NSVG_JOIN_MITER
	If s = "round" Then Return NSVG_JOIN_ROUND
	If s = "bevel" Then Return NSVG_JOIN_BEVEL
	Return NSVG_JOIN_MITER
End Sub

Private Sub ParseFillRule(s As String) As Int
	If s = "nonzero" Then Return NSVG_FILLRULE_NONZERO
	If s = "evenodd" Then Return NSVG_FILLRULE_EVENODD
	Return NSVG_FILLRULE_NONZERO
End Sub

Private Sub ParsePaintOrder(s As String) As Int
	Select Case s
		Case "normal", "fill stroke markers"
			Return EncodePaintOrder(NSVG_PAINT_FILL, NSVG_PAINT_STROKE, NSVG_PAINT_MARKERS)
		Case "fill markers stroke"
			Return EncodePaintOrder(NSVG_PAINT_FILL, NSVG_PAINT_MARKERS, NSVG_PAINT_STROKE)
		Case "markers fill stroke"
			Return EncodePaintOrder(NSVG_PAINT_MARKERS, NSVG_PAINT_FILL, NSVG_PAINT_STROKE)
		Case "markers stroke fill"
			Return EncodePaintOrder(NSVG_PAINT_MARKERS, NSVG_PAINT_STROKE, NSVG_PAINT_FILL)
		Case "stroke fill markers"
			Return EncodePaintOrder(NSVG_PAINT_STROKE, NSVG_PAINT_FILL, NSVG_PAINT_MARKERS)
		Case "stroke markers fill"
			Return EncodePaintOrder(NSVG_PAINT_STROKE, NSVG_PAINT_MARKERS, NSVG_PAINT_FILL)
	End Select
	Return EncodePaintOrder(NSVG_PAINT_FILL, NSVG_PAINT_STROKE, NSVG_PAINT_MARKERS)
End Sub

Private Sub ParseStrokeDashArray(s As String, arr() As Float) As Int
	If CH(s, 0) = 110 Then Return 0
	Dim count As Int = 0
	Dim pos As Int = 0
	Dim sum As Float = 0
	Do While CH(s, pos) <> 0
		pos = GetNextDashItem(s, pos)
		If gTok.Length = 0 Then Exit
		If count < NSVG_MAX_DASHES Then
			arr(count) = Abs(ParseCoordinate(gTok, 0, ActualLength))
			count = count + 1
		End If
	Loop
	For i = 0 To count - 1
		sum = sum + arr(i)
	Next
	If sum <= 0.000001 Then count = 0
	Return count
End Sub

Private Sub ApplyClassStyles(value As String)
	Dim cur As Int = 0
	Do While CH(value, cur) <> 0
		Do While IsWs(CH(value, cur))
			cur = cur + 1
		Loop
		If CH(value, cur) = 0 Then Exit
		Dim cs As Int = cur
		Do While CH(value, cur) <> 0 And IsWs(CH(value, cur)) = False
			cur = cur + 1
		Loop
		Dim cn As String = Sub2(value, cs, cur)
		For i = gStyles.Size - 1 To 0 Step -1
			Dim sd As nanoSvg_style = gStyles.Get(i)
			If sd.className = cn Then ParseStyle(sd.props)
		Next
	Loop
End Sub

Private Sub ParseAttr(name As String, value As String) As Boolean
	Dim attr As nanoSvg_attrib = gAttrs(gAttrHead)
	Select Case name
		Case "style"
			ParseStyle(value)
		Case "display"
			If value = "none" Then attr.visible = False
		Case "fill"
			If value = "none" Then
				attr.hasFill = 0
			Else If value.StartsWith("url(") Then
				attr.hasFill = 2
				attr.fillGradient = ParseUrl(value)
			Else
				attr.hasFill = 1
				attr.fillColor = ParseColor(value)
			End If
		Case "opacity"
			attr.opacity = ParseOpacity(value)
		Case "fill-opacity"
			attr.fillOpacity = ParseOpacity(value)
		Case "stroke"
			If value = "none" Then
				attr.hasStroke = 0
			Else If value.StartsWith("url(") Then
				attr.hasStroke = 2
				attr.strokeGradient = ParseUrl(value)
			Else
				attr.hasStroke = 1
				attr.strokeColor = ParseColor(value)
			End If
		Case "stroke-width"
			attr.strokeWidth = ParseCoordinate(value, 0, ActualLength)
		Case "stroke-dasharray"
			attr.strokeDashCount = ParseStrokeDashArray(value, attr.strokeDashArray)
		Case "stroke-dashoffset"
			attr.strokeDashOffset = ParseCoordinate(value, 0, ActualLength)
		Case "stroke-opacity"
			attr.strokeOpacity = ParseOpacity(value)
		Case "stroke-linecap"
			attr.strokeLineCap = ParseLineCap(value)
		Case "stroke-linejoin"
			attr.strokeLineJoin = ParseLineJoin(value)
		Case "stroke-miterlimit"
			attr.miterLimit = ParseMiterLimit(value)
		Case "fill-rule"
			attr.fillRule = ParseFillRule(value)
		Case "font-size"
			attr.fontSize = ParseCoordinate(value, 0, ActualLength)
		Case "transform"
			Dim xf(6) As Float
			ParseTransform(xf, value)
			XformPremultiply(attr.xform, xf)
		Case "stop-color"
			attr.stopColor = ParseColor(value)
		Case "stop-opacity"
			attr.stopOpacity = ParseOpacity(value)
		Case "offset"
			attr.stopOffset = ParseCoordinate(value, 0, 1)
		Case "paint-order"
			attr.paintOrder = ParsePaintOrder(value)
		Case "class"
			ApplyClassStyles(value)
		Case Else
			Return False
	End Select
	Return True
End Sub

Private Sub ParseNameValue(s As String, st As Int, en As Int) As Boolean
	Dim p1 As Int = st
	Do While p1 < en And CH(s, p1) <> 58
		p1 = p1 + 1
	Loop
	Dim vl As Int = p1
	Do While p1 > st And (CH(s, p1) = 58 Or IsSpace(CH(s, p1)))
		p1 = p1 - 1
	Loop
	p1 = p1 + 1
	Dim n As Int = p1 - st
	If n > 511 Then n = 511
	Dim nm As String = Sub2(s, st, st + n)
	Do While vl < en And (CH(s, vl) = 58 Or IsSpace(CH(s, vl)))
		vl = vl + 1
	Loop
	n = en - vl
	If n > 511 Then n = 511
	Dim vv As String = Sub2(s, vl, vl + n)
	Return ParseAttr(nm, vv)
End Sub

Private Sub ParseStyle(s As String)
	Dim pos As Int = 0
	Do While CH(s, pos) <> 0
		Do While IsWs(CH(s, pos))
			pos = pos + 1
		Loop
		Dim st As Int = pos
		Do While CH(s, pos) <> 0 And CH(s, pos) <> 59
			pos = pos + 1
		Loop
		Dim en As Int = pos
		Do While en > st And (CH(s, en) = 59 Or IsSpace(CH(s, en)))
			en = en - 1
		Loop
		en = en + 1
		ParseNameValue(s, st, en)
		If CH(s, pos) <> 0 Then pos = pos + 1
	Loop
End Sub

Private Sub ParseAttrPair(name As String, value As String)
	If name = "style" Then
		ParseStyle(value)
	Else
		ParseAttr(name, value)
	End If
End Sub

Private Sub ParseAttribs(attr As List)
	For i = 0 To attr.Size - 1 Step 2
		ParseAttrPair(attr.Get(i), attr.Get(i + 1))
	Next
End Sub

Private Sub GetArgsPerElement(cmd As Int) As Int
	Select Case cmd
		Case 118, 86, 104, 72
			Return 1
		Case 109, 77, 108, 76, 116, 84
			Return 2
		Case 113, 81, 115, 83
			Return 4
		Case 99, 67
			Return 6
		Case 97, 65
			Return 7
		Case 122, 90
			Return 0
	End Select
	Return -1
End Sub

Private Sub PathMoveTo(args() As Float, rel As Boolean)
	If rel Then
		gCpx = gCpx + args(0)
		gCpy = gCpy + args(1)
	Else
		gCpx = args(0)
		gCpy = args(1)
	End If
	MoveTo(gCpx, gCpy)
End Sub

Private Sub PathLineTo(args() As Float, rel As Boolean)
	If rel Then
		gCpx = gCpx + args(0)
		gCpy = gCpy + args(1)
	Else
		gCpx = args(0)
		gCpy = args(1)
	End If
	LineTo(gCpx, gCpy)
End Sub

Private Sub PathHLineTo(args() As Float, rel As Boolean)
	If rel Then
		gCpx = gCpx + args(0)
	Else
		gCpx = args(0)
	End If
	LineTo(gCpx, gCpy)
End Sub

Private Sub PathVLineTo(args() As Float, rel As Boolean)
	If rel Then
		gCpy = gCpy + args(0)
	Else
		gCpy = args(0)
	End If
	LineTo(gCpx, gCpy)
End Sub

Private Sub PathCubicBezTo(args() As Float, rel As Boolean)
	Dim x2, y2, cx1, cy1, cx2, cy2 As Float
	If rel Then
		cx1 = gCpx + args(0)
		cy1 = gCpy + args(1)
		cx2 = gCpx + args(2)
		cy2 = gCpy + args(3)
		x2 = gCpx + args(4)
		y2 = gCpy + args(5)
	Else
		cx1 = args(0)
		cy1 = args(1)
		cx2 = args(2)
		cy2 = args(3)
		x2 = args(4)
		y2 = args(5)
	End If
	CubicBezTo(cx1, cy1, cx2, cy2, x2, y2)
	gCpx2 = cx2
	gCpy2 = cy2
	gCpx = x2
	gCpy = y2
End Sub

Private Sub PathCubicBezShortTo(args() As Float, rel As Boolean)
	Dim x1, y1, x2, y2, cx1, cy1, cx2, cy2 As Float
	x1 = gCpx
	y1 = gCpy
	If rel Then
		cx2 = gCpx + args(0)
		cy2 = gCpy + args(1)
		x2 = gCpx + args(2)
		y2 = gCpy + args(3)
	Else
		cx2 = args(0)
		cy2 = args(1)
		x2 = args(2)
		y2 = args(3)
	End If
	cx1 = 2 * x1 - gCpx2
	cy1 = 2 * y1 - gCpy2
	CubicBezTo(cx1, cy1, cx2, cy2, x2, y2)
	gCpx2 = cx2
	gCpy2 = cy2
	gCpx = x2
	gCpy = y2
End Sub

Private Sub PathQuadBezTo(args() As Float, rel As Boolean)
	Dim x1, y1, x2, y2, cx, cy, cx1, cy1, cx2, cy2 As Float
	x1 = gCpx
	y1 = gCpy
	If rel Then
		cx = gCpx + args(0)
		cy = gCpy + args(1)
		x2 = gCpx + args(2)
		y2 = gCpy + args(3)
	Else
		cx = args(0)
		cy = args(1)
		x2 = args(2)
		y2 = args(3)
	End If
	cx1 = x1 + 2 / 3 * (cx - x1)
	cy1 = y1 + 2 / 3 * (cy - y1)
	cx2 = x2 + 2 / 3 * (cx - x2)
	cy2 = y2 + 2 / 3 * (cy - y2)
	CubicBezTo(cx1, cy1, cx2, cy2, x2, y2)
	gCpx2 = cx
	gCpy2 = cy
	gCpx = x2
	gCpy = y2
End Sub

Private Sub PathQuadBezShortTo(args() As Float, rel As Boolean)
	Dim x1, y1, x2, y2, cx, cy, cx1, cy1, cx2, cy2 As Float
	x1 = gCpx
	y1 = gCpy
	If rel Then
		x2 = gCpx + args(0)
		y2 = gCpy + args(1)
	Else
		x2 = args(0)
		y2 = args(1)
	End If
	cx = 2 * x1 - gCpx2
	cy = 2 * y1 - gCpy2
	cx1 = x1 + 2 / 3 * (cx - x1)
	cy1 = y1 + 2 / 3 * (cy - y1)
	cx2 = x2 + 2 / 3 * (cx - x2)
	cy2 = y2 + 2 / 3 * (cy - y2)
	CubicBezTo(cx1, cy1, cx2, cy2, x2, y2)
	gCpx2 = cx
	gCpy2 = cy
	gCpx = x2
	gCpy = y2
End Sub

Private Sub VecRat(ux As Float, uy As Float, vx As Float, vy As Float) As Float
	Return (ux * vx + uy * vy) / (Sqrt(ux * ux + uy * uy) * Sqrt(vx * vx + vy * vy))
End Sub

Private Sub VecAng(ux As Float, uy As Float, vx As Float, vy As Float) As Float
	Dim r As Float = VecRat(ux, uy, vx, vy)
	If r < -1 Then r = -1
	If r > 1 Then r = 1
	Dim sg As Float = 1
	If ux * vy < uy * vx Then sg = -1
	Return sg * ACos(r)
End Sub

Private Sub PathArcTo(args() As Float, rel As Boolean)
	Dim rx, ry, rotx As Float
	Dim x1, y1, x2, y2, cx, cy, dx, dy, d As Float
	Dim x1p, y1p, cxp, cyp, s, sa, sb As Float
	Dim ux, uy, vx, vy, a1, da As Float
	Dim x, y, tanx, tany, a As Float
	Dim px, py, ptanx, ptany As Float
	Dim t(6) As Float
	Dim sinrx, cosrx As Float
	Dim fa, fs, ndivs As Int
	Dim hda, kappa As Float

	rx = Abs(args(0))
	ry = Abs(args(1))
	rotx = args(2) / 180 * cPI
	If Abs(args(3)) > 0.000001 Then fa = 1 Else fa = 0
	If Abs(args(4)) > 0.000001 Then fs = 1 Else fs = 0
	x1 = gCpx
	y1 = gCpy
	If rel Then
		x2 = gCpx + args(5)
		y2 = gCpy + args(6)
	Else
		x2 = args(5)
		y2 = args(6)
	End If
	dx = x1 - x2
	dy = y1 - y2
	d = Sqrt(dx * dx + dy * dy)
	If d < 0.000001 Or rx < 0.000001 Or ry < 0.000001 Then
		LineTo(x2, y2)
		gCpx = x2
		gCpy = y2
		Return
	End If
	sinrx = Sin(rotx)
	cosrx = Cos(rotx)
	x1p = cosrx * dx / 2 + sinrx * dy / 2
	y1p = -sinrx * dx / 2 + cosrx * dy / 2
	d = (x1p * x1p) / (rx * rx) + (y1p * y1p) / (ry * ry)
	If d > 1 Then
		d = Sqrt(d)
		rx = rx * d
		ry = ry * d
	End If
	s = 0
	sa = (rx * rx) * (ry * ry) - (rx * rx) * (y1p * y1p) - (ry * ry) * (x1p * x1p)
	sb = (rx * rx) * (y1p * y1p) + (ry * ry) * (x1p * x1p)
	If sa < 0 Then sa = 0
	If sb > 0 Then s = Sqrt(sa / sb)
	If fa = fs Then s = -s
	cxp = s * rx * y1p / ry
	cyp = s * -ry * x1p / rx
	cx = (x1 + x2) / 2 + cosrx * cxp - sinrx * cyp
	cy = (y1 + y2) / 2 + sinrx * cxp + cosrx * cyp
	ux = (x1p - cxp) / rx
	uy = (y1p - cyp) / ry
	vx = (-x1p - cxp) / rx
	vy = (-y1p - cyp) / ry
	a1 = VecAng(1, 0, ux, uy)
	da = VecAng(ux, uy, vx, vy)
	If fs = 0 And da > 0 Then
		da = da - 2 * cPI
	Else If fs = 1 And da < 0 Then
		da = da + 2 * cPI
	End If
	t(0) = cosrx
	t(1) = sinrx
	t(2) = -sinrx
	t(3) = cosrx
	t(4) = cx
	t(5) = cy
	ndivs = F2I(Abs(da) / (cPI * 0.5) + 1)
	hda = (da / ndivs) / 2
	If hda < 0.001 And hda > -0.001 Then
		hda = hda * 0.5
	Else
		hda = (1 - Cos(hda)) / Sin(hda)
	End If
	kappa = Abs(4 / 3 * hda)
	If da < 0 Then kappa = -kappa
	px = 0 : py = 0 : ptanx = 0 : ptany = 0
	For i = 0 To ndivs
		a = a1 + da * (i / ndivs)
		dx = Cos(a)
		dy = Sin(a)
		XformPoint(dx * rx, dy * ry, t)
		x = gOutX
		y = gOutY
		XformVec(-dy * rx * kappa, dx * ry * kappa, t)
		tanx = gOutX
		tany = gOutY
		If i > 0 Then CubicBezTo(px + ptanx, py + ptany, x - tanx, y - tany, x, y)
		px = x
		py = y
		ptanx = tanx
		ptany = tany
	Next
	gCpx = x2
	gCpy = y2
End Sub

Private Sub ParsePath(attr As List)
	Dim s As String = ""
	Dim hasD As Boolean = False
	For i = 0 To attr.Size - 1 Step 2
		Dim an As String = attr.Get(i)
		Dim av As String = attr.Get(i + 1)
		If an = "d" Then
			s = av
			hasD = True
		Else
			ParseAttrPair(an, av)
		End If
	Next
	If hasD Then
		Dim args(10) As Float
		Dim cmd As Int = 0
		Dim nargs As Int = 0
		Dim rargs As Int = 0
		Dim initPoint As Boolean = False
		Dim closedFlag As Boolean = False
		Dim pos As Int = 0
		ResetPath
		gCpx = 0 : gCpy = 0 : gCpx2 = 0 : gCpy2 = 0
		Do While CH(s, pos) <> 0
			gTok = ""
			If (cmd = 65 Or cmd = 97) And (nargs = 3 Or nargs = 4) Then
				pos = GetNextPathItemWhenArcFlag(s, pos)
			End If
			If gTok.Length = 0 Then pos = GetNextPathItem(s, pos)
			If gTok.Length = 0 Then Exit
			Dim item As String = gTok
			If cmd <> 0 And IsCoordinate(item) Then
				If nargs < 10 Then
					args(nargs) = Atof(item)
					nargs = nargs + 1
				End If
				If nargs >= rargs Then
					Select Case cmd
						Case 109, 77
							PathMoveTo(args, cmd = 109)
							If cmd = 109 Then cmd = 108 Else cmd = 76
							rargs = GetArgsPerElement(cmd)
							gCpx2 = gCpx
							gCpy2 = gCpy
							initPoint = True
						Case 108, 76
							PathLineTo(args, cmd = 108)
							gCpx2 = gCpx
							gCpy2 = gCpy
						Case 72, 104
							PathHLineTo(args, cmd = 104)
							gCpx2 = gCpx
							gCpy2 = gCpy
						Case 86, 118
							PathVLineTo(args, cmd = 118)
							gCpx2 = gCpx
							gCpy2 = gCpy
						Case 67, 99
							PathCubicBezTo(args, cmd = 99)
						Case 83, 115
							PathCubicBezShortTo(args, cmd = 115)
						Case 81, 113
							PathQuadBezTo(args, cmd = 113)
						Case 84, 116
							PathQuadBezShortTo(args, cmd = 116)
						Case 65, 97
							PathArcTo(args, cmd = 97)
							gCpx2 = gCpx
							gCpy2 = gCpy
						Case Else
							If nargs >= 2 Then
								gCpx = args(nargs - 2)
								gCpy = args(nargs - 1)
								gCpx2 = gCpx
								gCpy2 = gCpy
							End If
					End Select
					nargs = 0
				End If
			Else
				cmd = CH(item, 0)
				If cmd = 77 Or cmd = 109 Then
					If gNpts > 0 Then AddPath(closedFlag)
					ResetPath
					closedFlag = False
					nargs = 0
				Else If initPoint = False Then
					cmd = 0
				End If
				If cmd = 90 Or cmd = 122 Then
					closedFlag = True
					If gNpts > 0 Then
						gCpx = gPts(0)
						gCpy = gPts(1)
						gCpx2 = gCpx
						gCpy2 = gCpy
						AddPath(closedFlag)
					End If
					ResetPath
					MoveTo(gCpx, gCpy)
					closedFlag = False
					nargs = 0
				End If
				rargs = GetArgsPerElement(cmd)
				If rargs = -1 Then
					cmd = 0
					rargs = 0
				End If
			End If
		Loop
		If gNpts > 0 Then AddPath(closedFlag)
	End If
	AddShape
End Sub

Private Sub ParseRect(attr As List)
	Dim x, y, w, h As Float
	Dim rx As Float = -1
	Dim ry As Float = -1
	For i = 0 To attr.Size - 1 Step 2
		Dim an As String = attr.Get(i)
		Dim av As String = attr.Get(i + 1)
		If ParseAttr(an, av) = False Then
			Select Case an
				Case "x"
					x = ParseCoordinate(av, gViewMinx, gViewWidth)
				Case "y"
					y = ParseCoordinate(av, gViewMiny, gViewHeight)
				Case "width"
					w = ParseCoordinate(av, 0, gViewWidth)
				Case "height"
					h = ParseCoordinate(av, 0, gViewHeight)
				Case "rx"
					rx = Abs(ParseCoordinate(av, 0, gViewWidth))
				Case "ry"
					ry = Abs(ParseCoordinate(av, 0, gViewHeight))
			End Select
		End If
	Next
	If rx < 0 And ry > 0 Then rx = ry
	If ry < 0 And rx > 0 Then ry = rx
	If rx < 0 Then rx = 0
	If ry < 0 Then ry = 0
	If rx > w / 2 Then rx = w / 2
	If ry > h / 2 Then ry = h / 2
	If w <> 0 And h <> 0 Then
		ResetPath
		If rx < 0.00001 Or ry < 0.0001 Then
			MoveTo(x, y)
			LineTo(x + w, y)
			LineTo(x + w, y + h)
			LineTo(x, y + h)
		Else
			Dim k As Float = 1 - NSVG_KAPPA90
			MoveTo(x + rx, y)
			LineTo(x + w - rx, y)
			CubicBezTo(x + w - rx * k, y, x + w, y + ry * k, x + w, y + ry)
			LineTo(x + w, y + h - ry)
			CubicBezTo(x + w, y + h - ry * k, x + w - rx * k, y + h, x + w - rx, y + h)
			LineTo(x + rx, y + h)
			CubicBezTo(x + rx * k, y + h, x, y + h - ry * k, x, y + h - ry)
			LineTo(x, y + ry)
			CubicBezTo(x, y + ry * k, x + rx * k, y, x + rx, y)
		End If
		AddPath(True)
		AddShape
	End If
End Sub

Private Sub EllipsePath(cx As Float, cy As Float, rx As Float, ry As Float)
	ResetPath
	MoveTo(cx + rx, cy)
	CubicBezTo(cx + rx, cy + ry * NSVG_KAPPA90, cx + rx * NSVG_KAPPA90, cy + ry, cx, cy + ry)
	CubicBezTo(cx - rx * NSVG_KAPPA90, cy + ry, cx - rx, cy + ry * NSVG_KAPPA90, cx - rx, cy)
	CubicBezTo(cx - rx, cy - ry * NSVG_KAPPA90, cx - rx * NSVG_KAPPA90, cy - ry, cx, cy - ry)
	CubicBezTo(cx + rx * NSVG_KAPPA90, cy - ry, cx + rx, cy - ry * NSVG_KAPPA90, cx + rx, cy)
	AddPath(True)
	AddShape
End Sub

Private Sub ParseCircle(attr As List)
	Dim cx, cy, r As Float
	For i = 0 To attr.Size - 1 Step 2
		Dim an As String = attr.Get(i)
		Dim av As String = attr.Get(i + 1)
		If ParseAttr(an, av) = False Then
			Select Case an
				Case "cx"
					cx = ParseCoordinate(av, gViewMinx, gViewWidth)
				Case "cy"
					cy = ParseCoordinate(av, gViewMiny, gViewHeight)
				Case "r"
					r = Abs(ParseCoordinate(av, 0, ActualLength))
			End Select
		End If
	Next
	If r > 0 Then EllipsePath(cx, cy, r, r)
End Sub

Private Sub ParseEllipse(attr As List)
	Dim cx, cy, rx, ry As Float
	For i = 0 To attr.Size - 1 Step 2
		Dim an As String = attr.Get(i)
		Dim av As String = attr.Get(i + 1)
		If ParseAttr(an, av) = False Then
			Select Case an
				Case "cx"
					cx = ParseCoordinate(av, gViewMinx, gViewWidth)
				Case "cy"
					cy = ParseCoordinate(av, gViewMiny, gViewHeight)
				Case "rx"
					rx = Abs(ParseCoordinate(av, 0, gViewWidth))
				Case "ry"
					ry = Abs(ParseCoordinate(av, 0, gViewHeight))
			End Select
		End If
	Next
	If rx > 0 And ry > 0 Then EllipsePath(cx, cy, rx, ry)
End Sub

Private Sub ParseLine(attr As List)
	Dim x1, y1, x2, y2 As Float
	For i = 0 To attr.Size - 1 Step 2
		Dim an As String = attr.Get(i)
		Dim av As String = attr.Get(i + 1)
		If ParseAttr(an, av) = False Then
			Select Case an
				Case "x1"
					x1 = ParseCoordinate(av, gViewMinx, gViewWidth)
				Case "y1"
					y1 = ParseCoordinate(av, gViewMiny, gViewHeight)
				Case "x2"
					x2 = ParseCoordinate(av, gViewMinx, gViewWidth)
				Case "y2"
					y2 = ParseCoordinate(av, gViewMiny, gViewHeight)
			End Select
		End If
	Next
	ResetPath
	MoveTo(x1, y1)
	LineTo(x2, y2)
	AddPath(False)
	AddShape
End Sub

Private Sub ParsePoly(attr As List, closeFlag As Boolean)
	Dim args(2) As Float
	Dim nargs As Int
	Dim npts As Int = 0
	ResetPath
	For i = 0 To attr.Size - 1 Step 2
		Dim an As String = attr.Get(i)
		Dim av As String = attr.Get(i + 1)
		If ParseAttr(an, av) = False Then
			If an = "points" Then
				Dim pos As Int = 0
				nargs = 0
				Do While CH(av, pos) <> 0
					pos = GetNextPathItem(av, pos)
					args(nargs) = Atof(gTok)
					nargs = nargs + 1
					If nargs >= 2 Then
						If npts = 0 Then
							MoveTo(args(0), args(1))
						Else
							LineTo(args(0), args(1))
						End If
						nargs = 0
						npts = npts + 1
					End If
				Loop
			End If
		End If
	Next
	AddPath(closeFlag)
	AddShape
End Sub

Private Sub ParseSVG(attr As List)
	For i = 0 To attr.Size - 1 Step 2
		Dim an As String = attr.Get(i)
		Dim av As String = attr.Get(i + 1)
		If ParseAttr(an, av) = False Then
			Select Case an
				Case "width"
					gImgW = ParseCoordinate(av, 0, 0)
				Case "height"
					gImgH = ParseCoordinate(av, 0, 0)
				Case "viewBox"
					Dim pos As Int = ParseNumber(av, 0)
					gViewMinx = Atof(gTok)
					Do While CH(av, pos) <> 0 And (IsWs(CH(av, pos)) Or CH(av, pos) = 37 Or CH(av, pos) = 44)
						pos = pos + 1
					Loop
					If CH(av, pos) = 0 Then Return
					pos = ParseNumber(av, pos)
					gViewMiny = Atof(gTok)
					Do While CH(av, pos) <> 0 And (IsWs(CH(av, pos)) Or CH(av, pos) = 37 Or CH(av, pos) = 44)
						pos = pos + 1
					Loop
					If CH(av, pos) = 0 Then Return
					pos = ParseNumber(av, pos)
					gViewWidth = Atof(gTok)
					Do While CH(av, pos) <> 0 And (IsWs(CH(av, pos)) Or CH(av, pos) = 37 Or CH(av, pos) = 44)
						pos = pos + 1
					Loop
					If CH(av, pos) = 0 Then Return
					pos = ParseNumber(av, pos)
					gViewHeight = Atof(gTok)
				Case "preserveAspectRatio"
					If av.Contains("none") Then
						gAlignType = NSVG_ALIGN_NONE
					Else
						If av.Contains("xMin") Then
							gAlignX = NSVG_ALIGN_MIN
						Else If av.Contains("xMid") Then
							gAlignX = NSVG_ALIGN_MID
						Else If av.Contains("xMax") Then
							gAlignX = NSVG_ALIGN_MAX
						End If
						If av.Contains("yMin") Then
							gAlignY = NSVG_ALIGN_MIN
						Else If av.Contains("yMid") Then
							gAlignY = NSVG_ALIGN_MID
						Else If av.Contains("yMax") Then
							gAlignY = NSVG_ALIGN_MAX
						End If
						gAlignType = NSVG_ALIGN_MEET
						If av.Contains("slice") Then gAlignType = NSVG_ALIGN_SLICE
					End If
			End Select
		End If
	Next
End Sub

Private Sub ParseGradient(attr As List, gtype As Int)
	Dim g As nanoSvg_gradientData = NewGradientData
	g.units = NSVG_OBJECT_SPACE
	g.gtype = gtype
	If gtype = NSVG_PAINT_LINEAR_GRADIENT Then
		g.x1 = Coord(0, NSVG_UNITS_PERCENT)
		g.y1 = Coord(0, NSVG_UNITS_PERCENT)
		g.x2 = Coord(100, NSVG_UNITS_PERCENT)
		g.y2 = Coord(0, NSVG_UNITS_PERCENT)
	Else If gtype = NSVG_PAINT_RADIAL_GRADIENT Then
		g.cx = Coord(50, NSVG_UNITS_PERCENT)
		g.cy = Coord(50, NSVG_UNITS_PERCENT)
		g.r = Coord(50, NSVG_UNITS_PERCENT)
	End If
	XformIdentity(g.xform)
	For i = 0 To attr.Size - 1 Step 2
		Dim an As String = attr.Get(i)
		Dim av As String = attr.Get(i + 1)
		If an = "id" Then
			g.id = Sub2(av, 0, 63)
		Else If ParseAttr(an, av) = False Then
			Select Case an
				Case "gradientUnits"
					If av = "objectBoundingBox" Then
						g.units = NSVG_OBJECT_SPACE
					Else
						g.units = NSVG_USER_SPACE
					End If
				Case "gradientTransform"
					ParseTransform(g.xform, av)
				Case "cx"
					g.cx = ParseCoordinateRaw(av)
				Case "cy"
					g.cy = ParseCoordinateRaw(av)
				Case "r"
					g.r = ParseCoordinateRaw(av)
				Case "x1"
					g.x1 = ParseCoordinateRaw(av)
				Case "y1"
					g.y1 = ParseCoordinateRaw(av)
				Case "x2"
					g.x2 = ParseCoordinateRaw(av)
				Case "y2"
					g.y2 = ParseCoordinateRaw(av)
				Case "xlink:href"
					g.href = Sub2(av, 1, 63)
			End Select
		End If
	Next
	gGradients.Add(g)
End Sub

Private Sub ParseGradientStop(attr As List)
	Dim cur As nanoSvg_attrib = gAttrs(gAttrHead)
	cur.stopOffset = 0
	cur.stopColor = 0
	cur.stopOpacity = 1
	For i = 0 To attr.Size - 1 Step 2
		ParseAttr(attr.Get(i), attr.Get(i + 1))
	Next
	If gGradients.Size = 0 Then Return
	Dim g As nanoSvg_gradientData = gGradients.Get(gGradients.Size - 1)
	Dim idx As Int = g.nstops
	For i = 0 To g.nstops - 1
		Dim o As Float = g.stopOffsets.Get(i)
		If cur.stopOffset < o Then
			idx = i
			Exit
		End If
	Next
	Dim col As Int = Bit.Or(cur.stopColor, Bit.ShiftLeft(F2I(cur.stopOpacity * 255), 24))
	g.stopColors.InsertAt(idx, col)
	g.stopOffsets.InsertAt(idx, cur.stopOffset)
	g.nstops = g.nstops + 1
End Sub

Private Sub StartElement(el As String, attr As List)
	If gDefsFlag Then
		Select Case el
			Case "linearGradient"
				ParseGradient(attr, NSVG_PAINT_LINEAR_GRADIENT)
			Case "radialGradient"
				ParseGradient(attr, NSVG_PAINT_RADIAL_GRADIENT)
			Case "stop"
				ParseGradientStop(attr)
			Case "style"
				gStyleFlag = True
		End Select
		Return
	End If
	Select Case el
		Case "g"
			PushAttr
			ParseAttribs(attr)
		Case "path"
			PushAttr
			ParsePath(attr)
			PopAttr
		Case "rect"
			PushAttr
			ParseRect(attr)
			PopAttr
		Case "circle"
			PushAttr
			ParseCircle(attr)
			PopAttr
		Case "ellipse"
			PushAttr
			ParseEllipse(attr)
			PopAttr
		Case "line"
			PushAttr
			ParseLine(attr)
			PopAttr
		Case "polyline"
			PushAttr
			ParsePoly(attr, False)
			PopAttr
		Case "polygon"
			PushAttr
			ParsePoly(attr, True)
			PopAttr
		Case "linearGradient"
			ParseGradient(attr, NSVG_PAINT_LINEAR_GRADIENT)
		Case "radialGradient"
			ParseGradient(attr, NSVG_PAINT_RADIAL_GRADIENT)
		Case "stop"
			ParseGradientStop(attr)
		Case "defs"
			gDefsFlag = True
		Case "svg"
			ParseSVG(attr)
		Case "style"
			gStyleFlag = True
	End Select
End Sub

Private Sub EndElement(el As String)
	Select Case el
		Case "g"
			PopAttr
		Case "defs"
			gDefsFlag = False
		Case "style"
			gStyleFlag = False
	End Select
End Sub

Private Sub PushAttr
	If gAttrHead < NSVG_MAX_ATTR - 1 Then
		gAttrHead = gAttrHead + 1
		CopyAttr(gAttrs(gAttrHead), gAttrs(gAttrHead - 1))
	End If
End Sub

Private Sub PopAttr
	If gAttrHead > 0 Then gAttrHead = gAttrHead - 1
End Sub

Private Sub ParseContent(s As String)
	Dim p As Int = 0
	Do While IsWs(CH(s, p))
		p = p + 1
	Loop
	If CH(s, p) = 0 Then Return
	If gStyleFlag = False Then Return
	Dim n As Int = s.Length
	Dim i As Int = p
	Do While i < n
		Dim names As List
		names.Initialize
		Do While i < n And CH(s, i) <> 123
			Do While i < n And (IsWs(CH(s, i)) Or CH(s, i) = 44)
				i = i + 1
			Loop
			If i >= n Or CH(s, i) = 123 Then Exit
			Dim selStart As Int = i
			Do While i < n And IsWs(CH(s, i)) = False And CH(s, i) <> 44 And CH(s, i) <> 123
				i = i + 1
			Loop
			Dim selEnd As Int = i
			If CH(s, selStart) <> 46 Or names.Size >= NSVG_MAX_CLASSES Then Continue
			names.Add(Sub2(s, selStart + 1, selEnd))
		Loop
		If i >= n Then Exit
		i = i + 1
		Dim propsStart As Int = i
		Do While i < n And CH(s, i) <> 125
			i = i + 1
		Loop
		Dim props As String = Sub2(s, propsStart, i)
		For Each nm As String In names
			Dim sd As nanoSvg_style
			sd.Initialize
			sd.className = nm
			sd.props = props
			gStyles.Add(sd)
		Next
		If i < n Then i = i + 1
	Loop
End Sub

Private Sub ParseElement(s As String)
	Dim attr As List
	attr.Initialize
	Dim pos As Int = 0
	Dim startF As Boolean = False
	Dim endF As Boolean = False
	Do While IsWs(CH(s, pos))
		pos = pos + 1
	Loop
	If CH(s, pos) = 47 Then
		pos = pos + 1
		endF = True
	Else
		startF = True
	End If
	Dim c As Int = CH(s, pos)
	If c = 0 Or c = 63 Or c = 33 Then Return
	Dim ns As Int = pos
	Do While CH(s, pos) <> 0 And IsWs(CH(s, pos)) = False
		pos = pos + 1
	Loop
	Dim name As String = Sub2(s, ns, pos)
	If CH(s, pos) <> 0 Then pos = pos + 1
	Do While endF = False And CH(s, pos) <> 0 And attr.Size < NSVG_XML_MAX_ATTRIBS - 3
		Do While IsWs(CH(s, pos))
			pos = pos + 1
		Loop
		If CH(s, pos) = 0 Then Exit
		If CH(s, pos) = 47 Then
			endF = True
			Exit
		End If
		ns = pos
		Do While CH(s, pos) <> 0 And IsWs(CH(s, pos)) = False And CH(s, pos) <> 61
			pos = pos + 1
		Loop
		Dim an As String = Sub2(s, ns, pos)
		If CH(s, pos) <> 0 Then pos = pos + 1
		Do While CH(s, pos) <> 0 And CH(s, pos) <> 34 And CH(s, pos) <> 39
			pos = pos + 1
		Loop
		If CH(s, pos) = 0 Then Exit
		Dim QUOTE1 As Int = CH(s, pos)
		pos = pos + 1
		ns = pos
		Do While CH(s, pos) <> 0 And CH(s, pos) <> QUOTE1
			pos = pos + 1
		Loop
		Dim av As String = Sub2(s, ns, pos)
		If CH(s, pos) <> 0 Then pos = pos + 1
		attr.Add(an)
		attr.Add(av)
	Loop
	If startF Then StartElement(name, attr)
	If endF Then EndElement(name)
End Sub

Private Sub ParseXML(input As String)
	Dim pos As Int = 0
	Dim mark As Int = 0
	Dim inTag As Boolean = False
	Do While True
		If inTag = False Then
			Dim lt As Int = input.IndexOf2("<", pos)
			If lt < 0 Then Exit
			ParseContent(Sub2(input, mark, lt))
			mark = lt + 1
			pos = lt + 1
			inTag = True
		Else
			Dim gt As Int = input.IndexOf2(">", pos)
			If gt < 0 Then Exit
			ParseElement(Sub2(input, mark, gt))
			mark = gt + 1
			pos = gt + 1
			inTag = False
		End If
	Loop
End Sub

Private Sub ViewAlign(content As Float, container As Float, atype As Int) As Float
	If atype = NSVG_ALIGN_MIN Then
		Return 0
	Else If atype = NSVG_ALIGN_MAX Then
		Return container - content
	End If
	Return (container - content) * 0.5
End Sub

Private Sub ScaleGradient(grad As nanoSvg_gradient, tx As Float, ty As Float, sx As Float, sy As Float)
	Dim t(6) As Float
	XformSetTranslation(t, tx, ty)
	XformMultiply(grad.xform, t)
	XformSetScale(t, sx, sy)
	XformMultiply(grad.xform, t)
End Sub

Private Sub ScaleToViewbox(units As String)
	Dim bounds(4) As Float
	Dim t(6) As Float
	Dim tx, ty, sx, sy, us, avgs As Float
	If gShapes.Size = 0 Then
		bounds(0) = 0 : bounds(1) = 0 : bounds(2) = 0 : bounds(3) = 0
	Else
		Dim f As nanoSvg_shape = gShapes.Get(0)
		bounds(0) = f.bounds(0)
		bounds(1) = f.bounds(1)
		bounds(2) = f.bounds(2)
		bounds(3) = f.bounds(3)
		For i = 1 To gShapes.Size - 1
			Dim sh0 As nanoSvg_shape = gShapes.Get(i)
			bounds(0) = MinF(bounds(0), sh0.bounds(0))
			bounds(1) = MinF(bounds(1), sh0.bounds(1))
			bounds(2) = MaxF(bounds(2), sh0.bounds(2))
			bounds(3) = MaxF(bounds(3), sh0.bounds(3))
		Next
	End If
	If gViewWidth = 0 Then
		If gImgW > 0 Then
			gViewWidth = gImgW
		Else
			gViewMinx = bounds(0)
			gViewWidth = bounds(2) - bounds(0)
		End If
	End If
	If gViewHeight = 0 Then
		If gImgH > 0 Then
			gViewHeight = gImgH
		Else
			gViewMiny = bounds(1)
			gViewHeight = bounds(3) - bounds(1)
		End If
	End If
	If gImgW = 0 Then gImgW = gViewWidth
	If gImgH = 0 Then gImgH = gViewHeight
	
	tx = -gViewMinx
	ty = -gViewMiny
	If gViewWidth > 0 Then sx = gImgW / gViewWidth Else sx = 0
	If gViewHeight > 0 Then sy = gImgH / gViewHeight Else sy = 0
	us = 1 / ConvertToPixels(Coord(1, ParseUnits(units, 0)), 0, 1)
	
	If gAlignType = NSVG_ALIGN_MEET Then
		sx = MinF(sx, sy)
		sy = sx
		tx = tx + ViewAlign(gViewWidth * sx, gImgW, gAlignX) / sx
		ty = ty + ViewAlign(gViewHeight * sy, gImgH, gAlignY) / sy
	Else If gAlignType = NSVG_ALIGN_SLICE Then
		sx = MaxF(sx, sy)
		sy = sx
		tx = tx + ViewAlign(gViewWidth * sx, gImgW, gAlignX) / sx
		ty = ty + ViewAlign(gViewHeight * sy, gImgH, gAlignY) / sy
	End If
	sx = sx * us
	sy = sy * us
	avgs = (sx + sy) / 2
	
	For Each shape As nanoSvg_shape In gShapes
		shape.bounds(0) = (shape.bounds(0) + tx) * sx
		shape.bounds(1) = (shape.bounds(1) + ty) * sy
		shape.bounds(2) = (shape.bounds(2) + tx) * sx
		shape.bounds(3) = (shape.bounds(3) + ty) * sy
		For Each path As nanoSvg_path In shape.paths
			path.bounds(0) = (path.bounds(0) + tx) * sx
			path.bounds(1) = (path.bounds(1) + ty) * sy
			path.bounds(2) = (path.bounds(2) + tx) * sx
			path.bounds(3) = (path.bounds(3) + ty) * sy
			For i = 0 To path.npts - 1
				path.pts(i * 2) = (path.pts(i * 2) + tx) * sx
				path.pts(i * 2 + 1) = (path.pts(i * 2 + 1) + ty) * sy
			Next
		Next
		If shape.fillType = NSVG_PAINT_LINEAR_GRADIENT Or shape.fillType = NSVG_PAINT_RADIAL_GRADIENT Then
			ScaleGradient(shape.fillGrad, tx, ty, sx, sy)
			For i = 0 To 5
				t(i) = shape.fillGrad.xform(i)
			Next
			XformInverse(shape.fillGrad.xform, t)
		End If
		If shape.strokeType = NSVG_PAINT_LINEAR_GRADIENT Or shape.strokeType = NSVG_PAINT_RADIAL_GRADIENT Then
			ScaleGradient(shape.strokeGrad, tx, ty, sx, sy)
			For i = 0 To 5
				t(i) = shape.strokeGrad.xform(i)
			Next
			XformInverse(shape.strokeGrad.xform, t)
		End If
		shape.strokeWidth = shape.strokeWidth * avgs
		shape.strokeDashOffset = shape.strokeDashOffset * avgs
		For i = 0 To shape.strokeDashCount - 1
			shape.strokeDashArray(i) = shape.strokeDashArray(i) * avgs
		Next
	Next
End Sub

Private Sub CreateGradients
	Dim inv(6) As Float
	Dim lb(4) As Float
	For Each shape As nanoSvg_shape In gShapes
		If shape.fillType = NSVG_PAINT_UNDEF Then
			If shape.fillGradient.Length > 0 Then
				XformInverse(inv, shape.xform)
				GetLocalBounds(lb, shape, inv)
				gPaintType = NSVG_PAINT_UNDEF
				shape.fillGrad = CreateGradient(shape.fillGradient, lb, shape.xform)
				If shape.fillGrad <> Null Then shape.fillType = gPaintType
			End If
			If shape.fillType = NSVG_PAINT_UNDEF Then shape.fillType = NSVG_PAINT_NONE
		End If
		If shape.strokeType = NSVG_PAINT_UNDEF Then
			If shape.strokeGradient.Length > 0 Then
				XformInverse(inv, shape.xform)
				GetLocalBounds(lb, shape, inv)
				gPaintType = NSVG_PAINT_UNDEF
				shape.strokeGrad = CreateGradient(shape.strokeGradient, lb, shape.xform)
				If shape.strokeGrad <> Null Then shape.strokeType = gPaintType
			End If
			If shape.strokeType = NSVG_PAINT_UNDEF Then shape.strokeType = NSVG_PAINT_NONE
		End If
	Next
End Sub

Private Sub NsvgParse(input As String, units As String, dpi As Float)
	ResetParser
	gDpi = dpi
	ParseXML(input)
	CreateGradients
	ScaleToViewbox(units)
End Sub

Private Sub EnsureEdges
	If gNedges + 1 > gEx0.Length Then
		Dim cap As Int = gEx0.Length * 2
		If cap < 64 Then cap = 64
		Dim a0(cap) As Float
		Dim a1(cap) As Float
		Dim a2(cap) As Float
		Dim a3(cap) As Float
		Dim a4(cap) As Int
		For i = 0 To gNedges - 1
			a0(i) = gEx0(i)
			a1(i) = gEy0(i)
			a2(i) = gEx1(i)
			a3(i) = gEy1(i)
			a4(i) = gEdir(i)
		Next
		gEx0 = a0 : gEy0 = a1 : gEx1 = a2 : gEy1 = a3 : gEdir = a4
	End If
End Sub

Private Sub EnsurePoints(n As Int)
	If n > gPtX.Length Then
		Dim cap As Int = gPtX.Length * 2
		If cap < 64 Then cap = 64
		If cap < n Then cap = n
		Dim a0(cap) As Float
		Dim a1(cap) As Float
		Dim a2(cap) As Int
		For i = 0 To gNpoints - 1
			a0(i) = gPtX(i)
			a1(i) = gPtY(i)
			a2(i) = gPtFl(i)
		Next
		gPtX = a0 : gPtY = a1 : gPtFl = a2
	End If
End Sub

Private Sub PtEquals(x1 As Float, y1 As Float, x2 As Float, y2 As Float, tol As Float) As Boolean
	Dim dx As Float = x2 - x1
	Dim dy As Float = y2 - y1
	Return dx * dx + dy * dy < tol * tol
End Sub

Private Sub AddPathPoint(x As Float, y As Float, flags As Int)
	If gNpoints > 0 Then
		If PtEquals(gPtX(gNpoints - 1), gPtY(gNpoints - 1), x, y, gDistTol) Then
			gPtFl(gNpoints - 1) = Bit.Or(gPtFl(gNpoints - 1), flags)
			Return
		End If
	End If
	EnsurePoints(gNpoints + 1)
	gPtX(gNpoints) = x
	gPtY(gNpoints) = y
	gPtFl(gNpoints) = flags
	gNpoints = gNpoints + 1
End Sub

Private Sub AppendPathPoint(x As Float, y As Float, flags As Int)
	EnsurePoints(gNpoints + 1)
	gPtX(gNpoints) = x
	gPtY(gNpoints) = y
	gPtFl(gNpoints) = flags
	gNpoints = gNpoints + 1
End Sub

Private Sub DuplicatePoints
	If gQtX.Length < gNpoints Then
		Dim a0(gNpoints) As Float
		Dim a1(gNpoints) As Float
		Dim a2(gNpoints) As Int
		gQtX = a0 : gQtY = a1 : gQtFl = a2
	End If
	For i = 0 To gNpoints - 1
		gQtX(i) = gPtX(i)
		gQtY(i) = gPtY(i)
		gQtFl(i) = gPtFl(i)
	Next
	gNpoints2 = gNpoints
End Sub

Private Sub AddEdge(x0 As Float, y0 As Float, x1 As Float, y1 As Float)
	If y0 = y1 Then Return
	EnsureEdges
	Dim n As Int = gNedges
	If y0 < y1 Then
		gEx0(n) = x0
		gEy0(n) = y0
		gEx1(n) = x1
		gEy1(n) = y1
		gEdir(n) = 1
	Else
		gEx0(n) = x1
		gEy0(n) = y1
		gEx1(n) = x0
		gEy1(n) = y0
		gEdir(n) = -1
	End If
	gNedges = n + 1
End Sub

Private Sub Normalize(x As Float, y As Float) As Float
	Dim d As Float = Sqrt(x * x + y * y)
	If d > 0.000001 Then
		Dim id As Float = 1 / d
		x = x * id
		y = y * id
	End If
	gOutX = x
	gOutY = y
	Return d
End Sub

Private Sub FlattenCubicBez(x1 As Float, y1 As Float, x2 As Float, y2 As Float, x3 As Float, y3 As Float, x4 As Float, y4 As Float, level As Int, ptype As Int)
	If level > 10 Then Return
	Dim x12 As Float = (x1 + x2) * 0.5
	Dim y12 As Float = (y1 + y2) * 0.5
	Dim x23 As Float = (x2 + x3) * 0.5
	Dim y23 As Float = (y2 + y3) * 0.5
	Dim x34 As Float = (x3 + x4) * 0.5
	Dim y34 As Float = (y3 + y4) * 0.5
	Dim x123 As Float = (x12 + x23) * 0.5
	Dim y123 As Float = (y12 + y23) * 0.5
	Dim dx As Float = x4 - x1
	Dim dy As Float = y4 - y1
	Dim d2 As Float = Abs((x2 - x4) * dy - (y2 - y4) * dx)
	Dim d3 As Float = Abs((x3 - x4) * dy - (y3 - y4) * dx)
	If (d2 + d3) * (d2 + d3) < gTessTol * (dx * dx + dy * dy) Then
		AddPathPoint(x4, y4, ptype)
		Return
	End If
	Dim x234 As Float = (x23 + x34) * 0.5
	Dim y234 As Float = (y23 + y34) * 0.5
	Dim x1234 As Float = (x123 + x234) * 0.5
	Dim y1234 As Float = (y123 + y234) * 0.5
	FlattenCubicBez(x1, y1, x12, y12, x123, y123, x1234, y1234, level + 1, 0)
	FlattenCubicBez(x1234, y1234, x234, y234, x34, y34, x4, y4, level + 1, ptype)
End Sub

Private Sub FlattenShape(shape As nanoSvg_shape, scale As Float)
	For Each path As nanoSvg_path In shape.paths
		gNpoints = 0
		AddPathPoint(path.pts(0) * scale, path.pts(1) * scale, 0)
		Dim i As Int = 0
		Do While i < path.npts - 1
			Dim o As Int = i * 2
			FlattenCubicBez(path.pts(o) * scale, path.pts(o + 1) * scale, path.pts(o + 2) * scale, path.pts(o + 3) * scale, _
				path.pts(o + 4) * scale, path.pts(o + 5) * scale, path.pts(o + 6) * scale, path.pts(o + 7) * scale, 0, 0)
			i = i + 3
		Loop
		AddPathPoint(path.pts(0) * scale, path.pts(1) * scale, 0)
		Dim j As Int = gNpoints - 1
		For k = 0 To gNpoints - 1
			AddEdge(gPtX(j), gPtY(j), gPtX(k), gPtY(k))
			j = k
		Next
	Next
End Sub

Private Sub InitClosed(lft() As Float, rgt() As Float, i0 As Int, i1 As Int, lineWidth As Float)
	Dim w As Float = lineWidth * 0.5
	Dim dx As Float = gPtX(i1) - gPtX(i0)
	Dim dy As Float = gPtY(i1) - gPtY(i0)
	Dim len As Float = Normalize(dx, dy)
	dx = gOutX
	dy = gOutY
	Dim px As Float = gPtX(i0) + dx * len * 0.5
	Dim py As Float = gPtY(i0) + dy * len * 0.5
	Dim dlx As Float = dy
	Dim dly As Float = -dx
	lft(0) = px - dlx * w
	lft(1) = py - dly * w
	rgt(0) = px + dlx * w
	rgt(1) = py + dly * w
End Sub

Private Sub ButtCap(lft() As Float, rgt() As Float, px As Float, py As Float, dx As Float, dy As Float, lineWidth As Float, connect As Boolean)
	Dim w As Float = lineWidth * 0.5
	Dim dlx As Float = dy
	Dim dly As Float = -dx
	Dim lx As Float = px - dlx * w
	Dim ly As Float = py - dly * w
	Dim rx As Float = px + dlx * w
	Dim ry As Float = py + dly * w
	AddEdge(lx, ly, rx, ry)
	If connect Then
		AddEdge(lft(0), lft(1), lx, ly)
		AddEdge(rx, ry, rgt(0), rgt(1))
	End If
	lft(0) = lx
	lft(1) = ly
	rgt(0) = rx
	rgt(1) = ry
End Sub

Private Sub SquareCap(lft() As Float, rgt() As Float, px0 As Float, py0 As Float, dx As Float, dy As Float, lineWidth As Float, connect As Boolean)
	Dim w As Float = lineWidth * 0.5
	Dim px As Float = px0 - dx * w
	Dim py As Float = py0 - dy * w
	Dim dlx As Float = dy
	Dim dly As Float = -dx
	Dim lx As Float = px - dlx * w
	Dim ly As Float = py - dly * w
	Dim rx As Float = px + dlx * w
	Dim ry As Float = py + dly * w
	AddEdge(lx, ly, rx, ry)
	If connect Then
		AddEdge(lft(0), lft(1), lx, ly)
		AddEdge(rx, ry, rgt(0), rgt(1))
	End If
	lft(0) = lx
	lft(1) = ly
	rgt(0) = rx
	rgt(1) = ry
End Sub

Private Sub RoundCap(lft() As Float, rgt() As Float, px As Float, py As Float, dx As Float, dy As Float, lineWidth As Float, ncap As Int, connect As Boolean)
	Dim w As Float = lineWidth * 0.5
	Dim dlx As Float = dy
	Dim dly As Float = -dx
	Dim lx, ly, rx, ry, prevx, prevy As Float
	For i = 0 To ncap - 1
		Dim a As Float = i / (ncap - 1) * cPI
		Dim ax As Float = Cos(a) * w
		Dim ay As Float = Sin(a) * w
		Dim x As Float = px - dlx * ax - dx * ay
		Dim y As Float = py - dly * ax - dy * ay
		If i > 0 Then AddEdge(prevx, prevy, x, y)
		prevx = x
		prevy = y
		If i = 0 Then
			lx = x
			ly = y
		Else If i = ncap - 1 Then
			rx = x
			ry = y
		End If
	Next
	If connect Then
		AddEdge(lft(0), lft(1), lx, ly)
		AddEdge(rx, ry, rgt(0), rgt(1))
	End If
	lft(0) = lx
	lft(1) = ly
	rgt(0) = rx
	rgt(1) = ry
End Sub

Private Sub BevelJoin(lft() As Float, rgt() As Float, i0 As Int, i1 As Int, lineWidth As Float)
	Dim w As Float = lineWidth * 0.5
	Dim dlx0 As Float = gPtDy(i0)
	Dim dly0 As Float = -gPtDx(i0)
	Dim dlx1 As Float = gPtDy(i1)
	Dim dly1 As Float = -gPtDx(i1)
	Dim lx0 As Float = gPtX(i1) - (dlx0 * w)
	Dim ly0 As Float = gPtY(i1) - (dly0 * w)
	Dim rx0 As Float = gPtX(i1) + (dlx0 * w)
	Dim ry0 As Float = gPtY(i1) + (dly0 * w)
	Dim lx1 As Float = gPtX(i1) - (dlx1 * w)
	Dim ly1 As Float = gPtY(i1) - (dly1 * w)
	Dim rx1 As Float = gPtX(i1) + (dlx1 * w)
	Dim ry1 As Float = gPtY(i1) + (dly1 * w)
	AddEdge(lx0, ly0, lft(0), lft(1))
	AddEdge(lx1, ly1, lx0, ly0)
	AddEdge(rgt(0), rgt(1), rx0, ry0)
	AddEdge(rx0, ry0, rx1, ry1)
	lft(0) = lx1
	lft(1) = ly1
	rgt(0) = rx1
	rgt(1) = ry1
End Sub

Private Sub MiterJoin(lft() As Float, rgt() As Float, i0 As Int, i1 As Int, lineWidth As Float)
	Dim w As Float = lineWidth * 0.5
	Dim dlx0 As Float = gPtDy(i0)
	Dim dly0 As Float = -gPtDx(i0)
	Dim dlx1 As Float = gPtDy(i1)
	Dim dly1 As Float = -gPtDx(i1)
	Dim lx0, rx0, lx1, rx1, ly0, ry0, ly1, ry1 As Float
	If Bit.And(gPtFl(i1), NSVG_PT_LEFT) <> 0 Then
		lx0 = gPtX(i1) - gPtDmx(i1) * w
		lx1 = lx0
		ly0 = gPtY(i1) - gPtDmy(i1) * w
		ly1 = ly0
		AddEdge(lx1, ly1, lft(0), lft(1))
		rx0 = gPtX(i1) + (dlx0 * w)
		ry0 = gPtY(i1) + (dly0 * w)
		rx1 = gPtX(i1) + (dlx1 * w)
		ry1 = gPtY(i1) + (dly1 * w)
		AddEdge(rgt(0), rgt(1), rx0, ry0)
		AddEdge(rx0, ry0, rx1, ry1)
	Else
		lx0 = gPtX(i1) - (dlx0 * w)
		ly0 = gPtY(i1) - (dly0 * w)
		lx1 = gPtX(i1) - (dlx1 * w)
		ly1 = gPtY(i1) - (dly1 * w)
		AddEdge(lx0, ly0, lft(0), lft(1))
		AddEdge(lx1, ly1, lx0, ly0)
		rx0 = gPtX(i1) + gPtDmx(i1) * w
		rx1 = rx0
		ry0 = gPtY(i1) + gPtDmy(i1) * w
		ry1 = ry0
		AddEdge(rgt(0), rgt(1), rx1, ry1)
	End If
	lft(0) = lx1
	lft(1) = ly1
	rgt(0) = rx1
	rgt(1) = ry1
End Sub

Private Sub RoundJoin(lft() As Float, rgt() As Float, i0 As Int, i1 As Int, lineWidth As Float, ncap As Int)
	Dim w As Float = lineWidth * 0.5
	Dim dlx0 As Float = gPtDy(i0)
	Dim dly0 As Float = -gPtDx(i0)
	Dim dlx1 As Float = gPtDy(i1)
	Dim dly1 As Float = -gPtDx(i1)
	Dim a0 As Float = ATan2(dly0, dlx0)
	Dim a1 As Float = ATan2(dly1, dlx1)
	Dim da As Float = a1 - a0
	If da < cPI Then da = da + cPI * 2
	If da > cPI Then da = da - cPI * 2
	Dim n As Int = F2I(Ceil((Abs(da) / cPI) * ncap))
	If n < 2 Then n = 2
	If n > ncap Then n = ncap
	Dim lx As Float = lft(0)
	Dim ly As Float = lft(1)
	Dim rx As Float = rgt(0)
	Dim ry As Float = rgt(1)
	For i = 0 To n - 1
		Dim u As Float = i / (n - 1)
		Dim a As Float = a0 + u * da
		Dim ax As Float = Cos(a) * w
		Dim ay As Float = Sin(a) * w
		Dim lx1 As Float = gPtX(i1) - ax
		Dim ly1 As Float = gPtY(i1) - ay
		Dim rx1 As Float = gPtX(i1) + ax
		Dim ry1 As Float = gPtY(i1) + ay
		AddEdge(lx1, ly1, lx, ly)
		AddEdge(rx, ry, rx1, ry1)
		lx = lx1
		ly = ly1
		rx = rx1
		ry = ry1
	Next
	lft(0) = lx
	lft(1) = ly
	rgt(0) = rx
	rgt(1) = ry
End Sub

Private Sub StraightJoin(lft() As Float, rgt() As Float, i1 As Int, lineWidth As Float)
	Dim w As Float = lineWidth * 0.5
	Dim lx As Float = gPtX(i1) - (gPtDmx(i1) * w)
	Dim ly As Float = gPtY(i1) - (gPtDmy(i1) * w)
	Dim rx As Float = gPtX(i1) + (gPtDmx(i1) * w)
	Dim ry As Float = gPtY(i1) + (gPtDmy(i1) * w)
	AddEdge(lx, ly, lft(0), lft(1))
	AddEdge(rgt(0), rgt(1), rx, ry)
	lft(0) = lx
	lft(1) = ly
	rgt(0) = rx
	rgt(1) = ry
End Sub

Private Sub CurveDivs(r As Float, arc As Float, tol As Float) As Int
	Dim da As Float = ACos(r / (r + tol)) * 2
	Dim divs As Int = F2I(Ceil(arc / da))
	If divs < 2 Then divs = 2
	Return divs
End Sub

Private Sub ExpandStroke(npoints As Int, closed As Boolean, lineJoin As Int, lineCap As Int, lineWidth As Float)
	Dim ncap As Int = CurveDivs(lineWidth * 0.5, cPI, gTessTol)
	Dim lft(2) As Float
	Dim rgt(2) As Float
	Dim firstL(2) As Float
	Dim firstR(2) As Float
	Dim i0, i1, s, e As Int
	Dim dx, dy As Float
	If closed Then
		i0 = npoints - 1
		i1 = 0
		s = 0
		e = npoints
	Else
		i0 = 0
		i1 = 1
		s = 1
		e = npoints - 1
	End If
	If closed Then
		InitClosed(lft, rgt, i0, i1, lineWidth)
		firstL(0) = lft(0)
		firstL(1) = lft(1)
		firstR(0) = rgt(0)
		firstR(1) = rgt(1)
	Else
		dx = gPtX(i1) - gPtX(i0)
		dy = gPtY(i1) - gPtY(i0)
		Normalize(dx, dy)
		dx = gOutX
		dy = gOutY
		If lineCap = NSVG_CAP_BUTT Then
			ButtCap(lft, rgt, gPtX(i0), gPtY(i0), dx, dy, lineWidth, False)
		Else If lineCap = NSVG_CAP_SQUARE Then
			SquareCap(lft, rgt, gPtX(i0), gPtY(i0), dx, dy, lineWidth, False)
		Else If lineCap = NSVG_CAP_ROUND Then
			RoundCap(lft, rgt, gPtX(i0), gPtY(i0), dx, dy, lineWidth, ncap, False)
		End If
	End If
	For j = s To e - 1
		If Bit.And(gPtFl(i1), NSVG_PT_CORNER) <> 0 Then
			If lineJoin = NSVG_JOIN_ROUND Then
				RoundJoin(lft, rgt, i0, i1, lineWidth, ncap)
			Else If lineJoin = NSVG_JOIN_BEVEL Or Bit.And(gPtFl(i1), NSVG_PT_BEVEL) <> 0 Then
				BevelJoin(lft, rgt, i0, i1, lineWidth)
			Else
				MiterJoin(lft, rgt, i0, i1, lineWidth)
			End If
		Else
			StraightJoin(lft, rgt, i1, lineWidth)
		End If
		i0 = i1
		i1 = i1 + 1
	Next
	If closed Then
		AddEdge(firstL(0), firstL(1), lft(0), lft(1))
		AddEdge(rgt(0), rgt(1), firstR(0), firstR(1))
	Else
		dx = gPtX(i1) - gPtX(i0)
		dy = gPtY(i1) - gPtY(i0)
		Normalize(dx, dy)
		dx = gOutX
		dy = gOutY
		If lineCap = NSVG_CAP_BUTT Then
			ButtCap(rgt, lft, gPtX(i1), gPtY(i1), -dx, -dy, lineWidth, True)
		Else If lineCap = NSVG_CAP_SQUARE Then
			SquareCap(rgt, lft, gPtX(i1), gPtY(i1), -dx, -dy, lineWidth, True)
		Else If lineCap = NSVG_CAP_ROUND Then
			RoundCap(rgt, lft, gPtX(i1), gPtY(i1), -dx, -dy, lineWidth, ncap, True)
		End If
	End If
End Sub

Private Sub PrepareStroke(miterLimit As Float, lineJoin As Int)
	Dim n As Int = gNpoints
	If gPtDx.Length < n Then
		Dim b0(n) As Float
		Dim b1(n) As Float
		Dim b3(n) As Float
		Dim b4(n) As Float
		gPtDx = b0 : gPtDy = b1 : gPtDmx = b3 : gPtDmy = b4
	End If
	Dim i0 As Int = n - 1
	Dim i1 As Int = 0
	For i = 0 To n - 1
		Dim dx As Float = gPtX(i1) - gPtX(i0)
		Dim dy As Float = gPtY(i1) - gPtY(i0)
		Normalize(dx, dy)
		gPtDx(i0) = gOutX
		gPtDy(i0) = gOutY
		i0 = i1
		i1 = i1 + 1
	Next
	i0 = n - 1
	i1 = 0
	For j = 0 To n - 1
		Dim dlx0 As Float = gPtDy(i0)
		Dim dly0 As Float = -gPtDx(i0)
		Dim dlx1 As Float = gPtDy(i1)
		Dim dly1 As Float = -gPtDx(i1)
		gPtDmx(i1) = (dlx0 + dlx1) * 0.5
		gPtDmy(i1) = (dly0 + dly1) * 0.5
		Dim dmr2 As Float = gPtDmx(i1) * gPtDmx(i1) + gPtDmy(i1) * gPtDmy(i1)
		If dmr2 > 0.000001 Then
			Dim s2 As Float = 1 / dmr2
			If s2 > 600 Then s2 = 600
			gPtDmx(i1) = gPtDmx(i1) * s2
			gPtDmy(i1) = gPtDmy(i1) * s2
		End If
		If Bit.And(gPtFl(i1), NSVG_PT_CORNER) <> 0 Then
			gPtFl(i1) = NSVG_PT_CORNER
		Else
			gPtFl(i1) = 0
		End If
		Dim cross As Float = gPtDx(i1) * gPtDy(i0) - gPtDx(i0) * gPtDy(i1)
		If cross > 0 Then gPtFl(i1) = Bit.Or(gPtFl(i1), NSVG_PT_LEFT)
		If Bit.And(gPtFl(i1), NSVG_PT_CORNER) <> 0 Then
			If (dmr2 * miterLimit * miterLimit) < 1 Or lineJoin = NSVG_JOIN_BEVEL Or lineJoin = NSVG_JOIN_ROUND Then
				gPtFl(i1) = Bit.Or(gPtFl(i1), NSVG_PT_BEVEL)
			End If
		End If
		i0 = i1
		i1 = i1 + 1
	Next
End Sub

Private Sub FlattenShapeStroke(shape As nanoSvg_shape, scale As Float)
	Dim miterLimit As Float = shape.miterLimit
	Dim lineJoin As Int = shape.strokeLineJoin
	Dim lineCap As Int = shape.strokeLineCap
	Dim lineWidth As Float = shape.strokeWidth * scale
	For Each path As nanoSvg_path In shape.paths
		gNpoints = 0
		AddPathPoint(path.pts(0) * scale, path.pts(1) * scale, NSVG_PT_CORNER)
		Dim i As Int = 0
		Do While i < path.npts - 1
			Dim o As Int = i * 2
			FlattenCubicBez(path.pts(o) * scale, path.pts(o + 1) * scale, path.pts(o + 2) * scale, path.pts(o + 3) * scale, _
				path.pts(o + 4) * scale, path.pts(o + 5) * scale, path.pts(o + 6) * scale, path.pts(o + 7) * scale, 0, NSVG_PT_CORNER)
			i = i + 3
		Loop
		If gNpoints < 2 Then Continue
		Dim closed As Boolean = path.closed
		If PtEquals(gPtX(gNpoints - 1), gPtY(gNpoints - 1), gPtX(0), gPtY(0), gDistTol) Then
			gNpoints = gNpoints - 1
			closed = True
		End If
		If shape.strokeDashCount > 0 Then
			Dim idash As Int = 0
			Dim dashState As Boolean = True
			Dim totalDist As Float = 0
			Dim dashLen, allDashLen, dashOffset As Float
			Dim curX, curY As Float
			Dim curFl As Int
			If closed Then AppendPathPoint(gPtX(0), gPtY(0), gPtFl(0))
			DuplicatePoints
			gNpoints = 0
			curX = gQtX(0)
			curY = gQtY(0)
			curFl = gQtFl(0)
			AppendPathPoint(curX, curY, curFl)
			allDashLen = 0
			For k = 0 To shape.strokeDashCount - 1
				allDashLen = allDashLen + shape.strokeDashArray(k)
			Next
			If Bit.And(shape.strokeDashCount, 1) <> 0 Then allDashLen = allDashLen * 2
			dashOffset = FmodF(shape.strokeDashOffset, allDashLen)
			If dashOffset < 0 Then dashOffset = dashOffset + allDashLen
			Do While dashOffset > shape.strokeDashArray(idash)
				dashOffset = dashOffset - shape.strokeDashArray(idash)
				idash = (idash + 1) Mod shape.strokeDashCount
			Loop
			dashLen = (shape.strokeDashArray(idash) - dashOffset) * scale
			Dim j As Int = 1
			Do While j < gNpoints2
				Dim dx As Float = gQtX(j) - curX
				Dim dy As Float = gQtY(j) - curY
				Dim dist As Float = Sqrt(dx * dx + dy * dy)
				If (totalDist + dist) > dashLen Then
					Dim d As Float = (dashLen - totalDist) / dist
					Dim x As Float = curX + dx * d
					Dim y As Float = curY + dy * d
					AddPathPoint(x, y, NSVG_PT_CORNER)
					If gNpoints > 1 And dashState Then
						PrepareStroke(miterLimit, lineJoin)
						ExpandStroke(gNpoints, False, lineJoin, lineCap, lineWidth)
					End If
					dashState = Not(dashState)
					idash = (idash + 1) Mod shape.strokeDashCount
					dashLen = shape.strokeDashArray(idash) * scale
					curX = x
					curY = y
					curFl = NSVG_PT_CORNER
					totalDist = 0
					gNpoints = 0
					AppendPathPoint(curX, curY, curFl)
				Else
					totalDist = totalDist + dist
					curX = gQtX(j)
					curY = gQtY(j)
					curFl = gQtFl(j)
					AppendPathPoint(curX, curY, curFl)
					j = j + 1
				End If
			Loop
			If gNpoints > 1 And dashState Then
				PrepareStroke(miterLimit, lineJoin)
				ExpandStroke(gNpoints, False, lineJoin, lineCap, lineWidth)
			End If
		Else
			PrepareStroke(miterLimit, lineJoin)
			ExpandStroke(gNpoints, closed, lineJoin, lineCap, lineWidth)
		End If
	Next
End Sub

Private Sub SortEdges
	Dim n As Int = gNedges
	If n = 0 Then Return
	If gOrder.Length < n Then
		Dim o1(n + 1) As Int
		Dim o2(n + 1) As Int
		gOrder = o1
		gTmpOrder = o2
	End If
	For i = 0 To n - 1
		gOrder(i) = i
	Next
	Dim width As Int = 1
	Do While width < n
		Dim pos0 As Int = 0
		Do While pos0 < n
			Dim lo As Int = pos0
			Dim mid As Int = Min(pos0 + width, n)
			Dim hi As Int = Min(pos0 + 2 * width, n)
			Dim a As Int = lo
			Dim b As Int = mid
			Dim k As Int = lo
			Do While a < mid And b < hi
				If gEy0(gOrder(a)) <= gEy0(gOrder(b)) Then
					gTmpOrder(k) = gOrder(a)
					a = a + 1
				Else
					gTmpOrder(k) = gOrder(b)
					b = b + 1
				End If
				k = k + 1
			Loop
			Do While a < mid
				gTmpOrder(k) = gOrder(a)
				a = a + 1
				k = k + 1
			Loop
			Do While b < hi
				gTmpOrder(k) = gOrder(b)
				b = b + 1
				k = k + 1
			Loop
			pos0 = pos0 + 2 * width
		Loop
		Dim sw() As Int = gOrder
		gOrder = gTmpOrder
		gTmpOrder = sw
		width = width * 2
	Loop
End Sub

Private Sub ResetPool
	gAcount = 0
	gAfree = 0
End Sub

Private Sub EnsureActive(n As Int)
	If n >= gAx.Length Then
		Dim cap As Int = gAx.Length * 2
		If cap < 256 Then cap = 256
		If cap <= n Then cap = n + 1
		Dim a0(cap) As Int
		Dim a1(cap) As Int
		Dim a2(cap) As Int
		Dim a3(cap) As Int
		Dim a4(cap) As Float
		For i = 0 To gAx.Length - 1
			a0(i) = gAx(i)
			a1(i) = gAdx(i)
			a2(i) = gAdir(i)
			a3(i) = gAnext(i)
			a4(i) = gAey(i)
		Next
		gAx = a0 : gAdx = a1 : gAdir = a2 : gAnext = a3 : gAey = a4
		gAx(0) = 2147483647
	End If
End Sub

Private Sub AddActive(ei As Int, startPoint As Float) As Int
	Dim z As Int
	If gAfree <> 0 Then
		z = gAfree
		gAfree = gAnext(z)
	Else
		gAcount = gAcount + 1
		EnsureActive(gAcount)
		z = gAcount
	End If
	Dim dxdy As Float = (gEx1(ei) - gEx0(ei)) / (gEy1(ei) - gEy0(ei))
	If dxdy < 0 Then
		gAdx(z) = F2I(-RoundF(NSVG_FIX * -dxdy))
	Else
		gAdx(z) = F2I(RoundF(NSVG_FIX * dxdy))
	End If
	gAx(z) = F2I(RoundF(NSVG_FIX * (gEx0(ei) + dxdy * (startPoint - gEy0(ei)))))
	gAey(z) = gEy1(ei)
	gAnext(z) = 0
	gAdir(z) = gEdir(ei)
	Return z
End Sub

Private Sub FillScanline(x0 As Int, x1 As Int, maxWeight As Int)
	Dim len As Int = gW
	Dim i As Int = Bit.ShiftRight(x0, NSVG_FIXSHIFT)
	Dim j As Int = Bit.ShiftRight(x1, NSVG_FIXSHIFT)
	If i < gXmin Then gXmin = i
	If j > gXmax Then gXmax = j
	If i < len And j >= 0 Then
		If i = j Then
			gScan(i) = Bit.And(gScan(i) + Bit.ShiftRight((x1 - x0) * maxWeight, NSVG_FIXSHIFT), 255)
		Else
			If i >= 0 Then
				gScan(i) = Bit.And(gScan(i) + Bit.ShiftRight((NSVG_FIX - Bit.And(x0, NSVG_FIXMASK)) * maxWeight, NSVG_FIXSHIFT), 255)
			Else
				i = -1
			End If
			If j < len Then
				gScan(j) = Bit.And(gScan(j) + Bit.ShiftRight(Bit.And(x1, NSVG_FIXMASK) * maxWeight, NSVG_FIXSHIFT), 255)
			Else
				j = len
			End If
			i = i + 1
			Do While i < j
				gScan(i) = Bit.And(gScan(i) + maxWeight, 255)
				i = i + 1
			Loop
		End If
	End If
End Sub

Private Sub FillActiveEdges(e As Int, maxWeight As Int, fillRule As Int)
	Dim x0 As Int = 0
	Dim w As Int = 0
	Dim x1 As Int
	If fillRule = NSVG_FILLRULE_NONZERO Then
		Do While e <> 0
			If w = 0 Then
				x0 = gAx(e)
				w = w + gAdir(e)
			Else
				x1 = gAx(e)
				w = w + gAdir(e)
				If w = 0 Then FillScanline(x0, x1, maxWeight)
			End If
			e = gAnext(e)
		Loop
	Else If fillRule = NSVG_FILLRULE_EVENODD Then
		Do While e <> 0
			If w = 0 Then
				x0 = gAx(e)
				w = 1
			Else
				x1 = gAx(e)
				w = 0
				FillScanline(x0, x1, maxWeight)
			End If
			e = gAnext(e)
		Loop
	End If
End Sub

Private Sub RGBA(r As Int, g As Int, b As Int, a As Int) As Int
	Return Bit.Or(Bit.Or(Bit.And(r, 255), Bit.ShiftLeft(Bit.And(g, 255), 8)), _
		Bit.Or(Bit.ShiftLeft(Bit.And(b, 255), 16), Bit.ShiftLeft(Bit.And(a, 255), 24)))
End Sub

Private Sub LerpRGBA(c0 As Int, c1 As Int, u As Float) As Int
	Dim iu As Int = F2I(ClampF(u, 0, 1) * 256)
	Dim r As Int = Bit.ShiftRight(Bit.And(c0, 255) * (256 - iu) + (Bit.And(c1, 255) * iu), 8)
	Dim g As Int = Bit.ShiftRight(Bit.And(Bit.UnsignedShiftRight(c0, 8), 255) * (256 - iu) + (Bit.And(Bit.UnsignedShiftRight(c1, 8), 255) * iu), 8)
	Dim b As Int = Bit.ShiftRight(Bit.And(Bit.UnsignedShiftRight(c0, 16), 255) * (256 - iu) + (Bit.And(Bit.UnsignedShiftRight(c1, 16), 255) * iu), 8)
	Dim a As Int = Bit.ShiftRight(Bit.And(Bit.UnsignedShiftRight(c0, 24), 255) * (256 - iu) + (Bit.And(Bit.UnsignedShiftRight(c1, 24), 255) * iu), 8)
	Return RGBA(r, g, b, a)
End Sub

Private Sub ApplyOpacity(c As Int, u As Float) As Int
	Dim iu As Int = F2I(ClampF(u, 0, 1) * 256)
	Dim r As Int = Bit.And(c, 255)
	Dim g As Int = Bit.And(Bit.UnsignedShiftRight(c, 8), 255)
	Dim b As Int = Bit.And(Bit.UnsignedShiftRight(c, 16), 255)
	Dim a As Int = Bit.ShiftRight(Bit.And(Bit.UnsignedShiftRight(c, 24), 255) * iu, 8)
	Return RGBA(r, g, b, a)
End Sub

Private Sub Div255(x As Int) As Int
	Return Bit.ShiftRight((x + 1) * 257, 16)
End Sub

Private Sub BlendPixel(d As Int, c As Int, cover As Int)
	Dim cr As Int = Bit.And(c, 255)
	Dim cg As Int = Bit.And(Bit.UnsignedShiftRight(c, 8), 255)
	Dim cb As Int = Bit.And(Bit.UnsignedShiftRight(c, 16), 255)
	Dim ca As Int = Bit.And(Bit.UnsignedShiftRight(c, 24), 255)
	Dim a As Int = Div255(cover * ca)
	Dim ia As Int = 255 - a
	Dim r As Int = Div255(cr * a)
	Dim g As Int = Div255(cg * a)
	Dim b As Int = Div255(cb * a)
	r = r + Div255(ia * Bit.And(gBmp(d), 255))
	g = g + Div255(ia * Bit.And(gBmp(d + 1), 255))
	b = b + Div255(ia * Bit.And(gBmp(d + 2), 255))
	a = a + Div255(ia * Bit.And(gBmp(d + 3), 255))
	gBmp(d) = r
	gBmp(d + 1) = g
	gBmp(d + 2) = b
	gBmp(d + 3) = a
End Sub

Private Sub ScanlineSolid(d As Int, count As Int, co As Int, x As Int, y As Int, tx As Float, ty As Float, scale As Float)
	If gCType = NSVG_PAINT_COLOR Then
		Dim c0 As Int = gCcolors(0)
		For i = 0 To count - 1
			BlendPixel(d, c0, gScan(co))
			co = co + 1
			d = d + 4
		Next
	Else If gCType = NSVG_PAINT_LINEAR_GRADIENT Then
		Dim fx As Float = (x - tx) / scale
		Dim fy As Float = (y - ty) / scale
		Dim dx As Float = 1 / scale
		For i = 0 To count - 1
			Dim gy As Float = fx * gCx(1) + fy * gCx(3) + gCx(5)
			BlendPixel(d, gCcolors(F2I(ClampF(gy * 255, 0, 255))), gScan(co))
			co = co + 1
			d = d + 4
			fx = fx + dx
		Next
	Else If gCType = NSVG_PAINT_RADIAL_GRADIENT Then
		Dim rfx As Float = (x - tx) / scale
		Dim rfy As Float = (y - ty) / scale
		Dim rdx As Float = 1 / scale
		For i = 0 To count - 1
			Dim gx As Float = rfx * gCx(0) + rfy * gCx(2) + gCx(4)
			Dim gy2 As Float = rfx * gCx(1) + rfy * gCx(3) + gCx(5)
			Dim gd As Float = Sqrt(gx * gx + gy2 * gy2)
			BlendPixel(d, gCcolors(F2I(ClampF(gd * 255, 0, 255))), gScan(co))
			co = co + 1
			d = d + 4
			rfx = rfx + rdx
		Next
	End If
End Sub

Private Sub RasterizeSortedEdges(tx As Float, ty As Float, scale As Float, fillRule As Int)
	Dim active As Int = 0
	Dim e As Int = 0
	Dim maxWeight As Int = 255 / NSVG_SUBSAMPLES
	Dim t, q, p, z, prev, nxt, ei As Int
	Dim changed As Boolean
	Dim scany As Float
	If gAx.Length = 0 Then EnsureActive(1)
	For y = 0 To gH - 1
		For k = 0 To gW - 1
			gScan(k) = 0
		Next
		gXmin = gW
		gXmax = 0
		For s = 0 To NSVG_SUBSAMPLES - 1
			scany = (y * NSVG_SUBSAMPLES + s) + 0.5
			prev = 0
			z = active
			Do While z <> 0
				nxt = gAnext(z)
				If gAey(z) <= scany Then
					If prev = 0 Then
						active = nxt
					Else
						gAnext(prev) = nxt
					End If
					gAnext(z) = gAfree
					gAfree = z
				Else
					gAx(z) = gAx(z) + gAdx(z)
					prev = z
				End If
				z = nxt
			Loop
			Do While True
				changed = False
				prev = 0
				t = active
				Do While t <> 0 And gAnext(t) <> 0
					q = gAnext(t)
					If gAx(t) > gAx(q) Then
						gAnext(t) = gAnext(q)
						gAnext(q) = t
						If prev = 0 Then
							active = q
						Else
							gAnext(prev) = q
						End If
						changed = True
						prev = q
					Else
						prev = t
						t = gAnext(t)
					End If
				Loop
				If changed = False Then Exit
			Loop
			Do While e < gNedges
				ei = gOrder(e)
				If gEy0(ei) > scany Then Exit
				If gEy1(ei) > scany Then
					z = AddActive(ei, scany)
					If active = 0 Then
						active = z
					Else If gAx(z) < gAx(active) Then
						gAnext(z) = active
						active = z
					Else
						p = active
						Do While gAnext(p) <> 0 And gAx(gAnext(p)) < gAx(z)
							p = gAnext(p)
						Loop
						gAnext(z) = gAnext(p)
						gAnext(p) = z
					End If
				End If
				e = e + 1
			Loop
			If active <> 0 Then FillActiveEdges(active, maxWeight, fillRule)
		Next
		If gXmin < 0 Then gXmin = 0
		If gXmax > gW - 1 Then gXmax = gW - 1
		If gXmin <= gXmax Then
			ScanlineSolid(y * gStride + gXmin * 4, gXmax - gXmin + 1, gXmin, gXmin, y, tx, ty, scale)
		End If
	Next
End Sub

Private Sub UnpremultiplyAlpha(w As Int, h As Int, stride As Int)
	Dim o As Int
	Dim r, g, b, a, n As Int
	For y = 0 To h - 1
		For x = 0 To w - 1
			o = y * stride + x * 4
			r = Bit.And(gBmp(o), 255)
			g = Bit.And(gBmp(o + 1), 255)
			b = Bit.And(gBmp(o + 2), 255)
			a = Bit.And(gBmp(o + 3), 255)
			If a <> 0 Then
				gBmp(o) = r * 255 / a
				gBmp(o + 1) = g * 255 / a
				gBmp(o + 2) = b * 255 / a
			End If
		Next
	Next
	For y = 0 To h - 1
		For x = 0 To w - 1
			o = y * stride + x * 4
			a = Bit.And(gBmp(o + 3), 255)
			If a = 0 Then
				r = 0 : g = 0 : b = 0 : n = 0
				If x - 1 > 0 And Bit.And(gBmp(o - 1), 255) <> 0 Then
					r = r + Bit.And(gBmp(o - 4), 255)
					g = g + Bit.And(gBmp(o - 3), 255)
					b = b + Bit.And(gBmp(o - 2), 255)
					n = n + 1
				End If
				If x + 1 < w And Bit.And(gBmp(o + 7), 255) <> 0 Then
					r = r + Bit.And(gBmp(o + 4), 255)
					g = g + Bit.And(gBmp(o + 5), 255)
					b = b + Bit.And(gBmp(o + 6), 255)
					n = n + 1
				End If
				If y - 1 > 0 And Bit.And(gBmp(o - stride + 3), 255) <> 0 Then
					r = r + Bit.And(gBmp(o - stride), 255)
					g = g + Bit.And(gBmp(o - stride + 1), 255)
					b = b + Bit.And(gBmp(o - stride + 2), 255)
					n = n + 1
				End If
				If y + 1 < h And Bit.And(gBmp(o + stride + 3), 255) <> 0 Then
					r = r + Bit.And(gBmp(o + stride), 255)
					g = g + Bit.And(gBmp(o + stride + 1), 255)
					b = b + Bit.And(gBmp(o + stride + 2), 255)
					n = n + 1
				End If
				If n > 0 Then
					gBmp(o) = r / n
					gBmp(o + 1) = g / n
					gBmp(o + 2) = b / n
				End If
			End If
		Next
	Next
End Sub

Private Sub InitPaint(ptype As Int, color As Int, grad As nanoSvg_gradient, opacity As Float)
	gCType = ptype
	If ptype = NSVG_PAINT_COLOR Then
		gCcolors(0) = ApplyOpacity(color, opacity)
		Return
	End If
	For i = 0 To 5
		gCx(i) = grad.xform(i)
	Next
	Dim ns As Int = grad.nstops
	If ns = 0 Then
		For i = 0 To 255
			gCcolors(i) = 0
		Next
	Else If ns = 1 Then
		Dim c1 As Int = ApplyOpacity(grad.stopColors(0), opacity)
		For i = 0 To 255
			gCcolors(i) = c1
		Next
	Else
		Dim ca, cb As Int
		Dim ua, ub, du, u As Float
		Dim ia, ib, count As Int
		cb = 0
		ca = ApplyOpacity(grad.stopColors(0), opacity)
		ua = ClampF(grad.stopOffsets(0), 0, 1)
		ub = ClampF(grad.stopOffsets(ns - 1), ua, 1)
		ia = F2I(ua * 255)
		ib = F2I(ub * 255)
		For i = 0 To ia - 1
			gCcolors(i) = ca
		Next
		For i = 0 To ns - 2
			ca = ApplyOpacity(grad.stopColors(i), opacity)
			cb = ApplyOpacity(grad.stopColors(i + 1), opacity)
			ua = ClampF(grad.stopOffsets(i), 0, 1)
			ub = ClampF(grad.stopOffsets(i + 1), 0, 1)
			ia = F2I(ua * 255)
			ib = F2I(ub * 255)
			count = ib - ia
			If count > 0 Then
				u = 0
				du = 1 / count
				For j = 0 To count - 1
					gCcolors(ia + j) = LerpRGBA(ca, cb, u)
					u = u + du
				Next
			End If
		Next
		For i = ib To 255
			gCcolors(i) = cb
		Next
	End If
End Sub

Private Sub TransformEdges(tx As Float, ty As Float)
	For i = 0 To gNedges - 1
		gEx0(i) = tx + gEx0(i)
		gEy0(i) = (ty + gEy0(i)) * NSVG_SUBSAMPLES
		gEx1(i) = tx + gEx1(i)
		gEy1(i) = (ty + gEy1(i)) * NSVG_SUBSAMPLES
	Next
End Sub

Private Sub NsvgRasterize(dst() As Byte, tx As Float, ty As Float, scale As Float, w As Int, h As Int, stride As Int)
	gBmp = dst
	gW = w
	gH = h
	gStride = stride
	If gScan.Length < w Then
		Dim sc(w) As Int
		gScan = sc
	End If
	For Each shape As nanoSvg_shape In gShapes
		If Bit.And(shape.flags, 1) = 0 Then Continue
		For j = 0 To 2
			Dim po As Int = Bit.And(Bit.ShiftRight(shape.paintOrder, 2 * j), 3)
			If po = NSVG_PAINT_FILL And shape.fillType <> NSVG_PAINT_NONE Then
				ResetPool
				gNedges = 0
				FlattenShape(shape, scale)
				TransformEdges(tx, ty)
				SortEdges
				InitPaint(shape.fillType, shape.fillColor, shape.fillGrad, shape.opacity)
				RasterizeSortedEdges(tx, ty, scale, shape.fillRule)
			End If
			If po = NSVG_PAINT_STROKE And shape.strokeType <> NSVG_PAINT_NONE And (shape.strokeWidth * scale) > 0.01 Then
				ResetPool
				gNedges = 0
				FlattenShapeStroke(shape, scale)
				TransformEdges(tx, ty)
				SortEdges
				InitPaint(shape.strokeType, shape.strokeColor, shape.strokeGrad, shape.opacity)
				RasterizeSortedEdges(tx, ty, scale, NSVG_FILLRULE_NONZERO)
			End If
		Next
	Next
	UnpremultiplyAlpha(w, h, stride)
End Sub
