B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' SVGVectorizer.bas
Sub Class_Globals
	Private Potrace As String 
	Private xui As XUI
	
	Private mForm As Form
	Private wv As WebView
	Private mOutputPath As String
	
	'=========================================================================================================
	' MULTI COLOR
	' Un seuil autour de 48 ou 64 est un bon compromis
	' Il élargis la “zone de tolérance” autour de chaque couleur quantifiée.
	' couvre la quantification (pas de 32)
	' absorbe le bruit et la compression
	' permet de regrouper correctement les pixels autour de leur couleur quantifiée
	' évite de fusionner des couleurs trop éloignées
	' reste stable pour des images très différentes
	'=========================================================================================================
	Private const THRESH As Int = 48 '64
	Private mEdge As Boolean = True

	' Gestion des erreurs	
	Private mErrorTarget As Object
	Private mErrorEvent As String

	
End Sub

' ===================================
'  Initialize the vectorizer
' ===================================
' Form : The form used
' Potrace_Path : The path to the potrace executable
Public Sub Initialize(Form As Form, Potrace_Path As String)
	
	mForm = Form
	Potrace = Potrace_Path
	wv.Initialize("wv")
	
	' Remove the scrollbars
	CSSUtils.SetStyleProperty(wv, "overflow-x", "hidden") 
	CSSUtils.SetStyleProperty(wv, "overflow-y", "hidden")
	
End Sub

#Region Monochrome
' ===================================================
'  Vectorize a B4XBitmap image into SVG (Monochrome)
' ===================================================
' Bmp : The image to convert
' Edge : True = With edges
Public Sub VectorizeBW(Bmp As B4XBitmap, Edge As Boolean) As String
	
	mEdge = Edge
	Dim bc As BitmapCreator
	bc.Initialize(Bmp.Width, Bmp.Height)
	bc.CopyPixelsFromBitmap(Bmp)
	
	Dim px As ARGBColor
	bc.GetARGB(0, 0, px)
	
	' Temporary files
	Dim pbm As String = File.Combine(File.DirTemp, "input_" & DateTime.Now & ".pbm")
	Dim svg As String = File.Combine(File.DirTemp, "output_" & DateTime.Now & ".svg")
	
	SavePBM_BlackOnTransparent(bc,pbm)
	RunPotrace(pbm, svg)

	If File.Exists("", svg) Then
		Dim out As String = File.ReadString("", svg)
		File.Delete("", pbm)
		File.Delete("", svg)
		Return out
	Else
		RaiseError("Potrace did not generate an SVG (monochrome) file..")
		File.Delete("", pbm)
		Return ""
	End If

End Sub

Private Sub SavePBM_BlackOnTransparent(bc As BitmapCreator, OutFile As String)
	Dim hasInk As Boolean = False
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("P1").Append(CRLF)
	sb.Append(bc.mWidth).Append(" ").Append(bc.mHeight).Append(CRLF)

	Dim px As ARGBColor

	For y = 0 To bc.mHeight - 1
		For x = 0 To bc.mWidth - 1
			bc.GetARGB(x, y, px)

			' Transparence -> blanc
			If px.a < 20 Then
				sb.Append("0 ")
				Continue
			End If

			' Luminance (human perception)
			Dim lum As Int = (px.r * 299 + px.g * 587 + px.b * 114) / 1000

			' Fine thresholding
			If lum < 100 Then
				sb.Append("1 ")
				hasInk = True
			Else
				sb.Append("0 ")
			End If
		Next
		sb.Append(CRLF)
	Next
	If hasInk = False Then Return

	File.WriteString("", OutFile, sb.ToString)
End Sub


#End Region

#region une couleur
' ===================================================
'  Vectorize a B4XBitmap image into SVG (Single color)
' ===================================================
' Bmp : The image to convert
' Edge : True = With edges
Public Sub VectorizeSingleColor(bmp As B4XBitmap , Edge As Boolean) As String
	
	mEdge = Edge
	Dim bc As BitmapCreator
	bc.Initialize(bmp.Width, bmp.Height)
	bc.CopyPixelsFromBitmap(bmp)

	Dim palette As List = Quantize16(bmp)

	'We explicitly remove white from the "useful" palette.
	Dim colorsOnly As List
	colorsOnly.Initialize
	For Each col As ARGBColor In palette
		If Not (col.r = 255 And col.g = 255 And col.b = 255) Then
			colorsOnly.Add(col)
		End If
	Next

	' If there's no color, we can revert to the classic BW mode.
	If colorsOnly.Size = 0 Then
		Return VectorizeBW(bmp, mEdge)
	End If

	' If only ONE color: case "single color"
	If colorsOnly.Size = 1 Then
		Dim col As ARGBColor = colorsOnly.Get(0)

		Dim pbm As String = File.Combine(File.DirTemp, "singlecolor_" & col.r & "_" & col.g & "_" & col.b & ".pbm")
		SavePBMForColor(bc, pbm, col)

		Dim svgPath As String = pbm.Replace(".pbm", ".svg")
		RunPotrace(pbm, svgPath)

		If File.Exists("", svgPath) = False Then Return ""

		Dim content As String = File.ReadString("", svgPath)
		
		File.Delete("", pbm)
		File.Delete("", svgPath)
		
		Dim paths As String = ExtractPaths(content)
		paths = paths.Replace("<path ", $"<path fill='rgb(${col.r},${col.g},${col.b})' "$)

		' We wrap it in an SVG
		Dim scale As Int = 10
		Dim svgFinal As StringBuilder
		svgFinal.Initialize
		svgFinal.Append($"<svg xmlns='http://www.w3.org/2000/svg' width='${bc.mWidth}' height='${bc.mHeight}' viewBox='0 0 ${bc.mWidth * scale} ${bc.mHeight * scale}'>"$).Append(CRLF)
		svgFinal.Append("<g transform='translate(0," & (bc.mHeight * scale) & ") scale(1,-1)'>").Append(CRLF)
		svgFinal.Append(paths).Append(CRLF)
		svgFinal.Append("</g>").Append(CRLF)
		svgFinal.Append("</svg>")

		Return svgFinal.ToString
	End If

	Return VectorizeColor(bmp, mEdge)
End Sub

#End Region

#Region Color 16
Private Sub Quantize16(bmp As B4XBitmap) As List
	Dim bc As BitmapCreator
	bc.Initialize(bmp.Width, bmp.Height)
	bc.CopyPixelsFromBitmap(bmp)

	Dim px As ARGBColor
	Dim histo As Map
	histo.Initialize

	' Color histogram (reduced to 32 levels)
	For y = 0 To bc.mHeight - 1
		For x = 0 To bc.mWidth - 1
			bc.GetARGB(x, y, px)

			If px.a < 10 Then Continue ' eliminate transparent background

			If px.r > 245 And px.g > 245 And px.b > 245 Then
				' We ignore white in the histogram, but we keep it for the palette
				Continue
			End If

			Dim r As Int = Bit.And(px.r, 0xE0)
			Dim g As Int = Bit.And(px.g, 0xE0)
			Dim b As Int = Bit.And(px.b, 0xE0)

			Dim key As Int = r * 65536 + g * 256 + b

			If histo.ContainsKey(key) Then
				histo.Put(key, histo.Get(key) + 1)
			Else
				histo.Put(key, 1)
			End If
		Next
	Next

	' Convert to a list (key, frequency)
	Dim entries As List
	entries.Initialize

	For Each k As Int In histo.Keys
		entries.Add(Array As Int(k, histo.Get(k)))
	Next

	' Manual sorting in descending order by frequency
	For i = 0 To entries.Size - 2
		For j = i + 1 To entries.Size - 1
			Dim A1() As Int = entries.Get(i)
			Dim B1() As Int = entries.Get(j)
			If B1(1) > A1(1) Then
				entries.Set(i, B1)
				entries.Set(j, A1)
			End If
		Next
	Next

	' Build the final palette
	Dim palette As List
	palette.Initialize

	For i = 0 To Min(15, entries.Size - 1)
		Dim e() As Int = entries.Get(i)
		Dim k As Int = e(0)

		Dim col As ARGBColor
		col.Initialize
		col.r = Bit.And(Bit.ShiftRight(k, 16), 0xFF)
		col.g = Bit.And(Bit.ShiftRight(k, 8), 0xFF)
		col.b = Bit.And(k, 0xFF)

		palette.Add(col)
	Next

	' Explicitly add pure white
	Dim white As ARGBColor
	white.Initialize
	white.r = 255
	white.g = 255
	white.b = 255
	palette.Add(white)

	Return palette
End Sub

Private Sub SavePBMForColor(bc As BitmapCreator, OutFile As String, col As ARGBColor)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("P1").Append(CRLF)
	sb.Append(bc.mWidth).Append(" ").Append(bc.mHeight).Append(CRLF)

	Dim px As ARGBColor
	Dim hasInk As Boolean = False

	For y = 0 To bc.mHeight - 1
		For x = 0 To bc.mWidth - 1
			bc.GetARGB(x, y, px)
			
			' Ignore transparency
			If px.a < 10 Then
				sb.Append("0 ")
				Continue
			End If

			Dim match As Boolean = _
			    (Abs(px.r - col.r) < THRESH And _
     			Abs(px.g - col.g) < THRESH And _
     			Abs(px.b - col.b) < THRESH)

			If col.r = 255 And col.g = 255 And col.b = 255 Then
				match = (px.r > 245 And px.g > 245 And px.b > 245)
			End If

			If match Then
				sb.Append("1 ")
				hasInk = True
			Else
				sb.Append("0 ")
			End If
		Next
		sb.Append(CRLF)
	Next

	If hasInk = False Then Return

	File.WriteString("", OutFile, sb.ToString)
End Sub

' ===================================================
'  Vectorize a B4XBitmap image into SVG (Multi color)
' ===================================================
' Bmp : The image to convert
' Edge : True = With edges
Public Sub VectorizeColor(bmp As B4XBitmap, Edge As Boolean) As String
	
	mEdge = Edge
	Dim bc As BitmapCreator
	bc.Initialize(bmp.Width, bmp.Height)
	bc.CopyPixelsFromBitmap(bmp)
	
	Dim palette As List = Quantize16(bmp)

	Dim scale As Int = 10
	Dim svgFinal As StringBuilder
	svgFinal.Initialize

	' --- SVG HEADER ---
	svgFinal.Append($"<svg xmlns='http://www.w3.org/2000/svg' width='${bc.mWidth}' height='${bc.mHeight}' viewBox='0 0 ${bc.mWidth * scale} ${bc.mHeight * scale}'>"$).Append(CRLF)

	' --- CORRECTION DU FLIP VERTICAL ---
	' translate AVANT scale
	svgFinal.Append("<g transform='translate(0," & (bc.mHeight * scale) & ") scale(1,-1)'>").Append(CRLF)

	Log("Wait...")

	For Each col As ARGBColor In palette
	
		Dim pbm As String = File.Combine(File.DirTemp, "layer_" & col.r & "_" & col.g & "_" & col.b & ".pbm")
		SavePBMForColor(bc, pbm, col)
		
		If File.Size("", pbm) < 20 Then Continue ' couche vide
				
		Dim svg As String = pbm.Replace(".pbm", ".svg")
		RunPotrace(pbm, svg)

		If File.Exists("", svg) Then
			
			Dim content As String = File.ReadString("", svg)
			Dim paths As String = ExtractPaths(content)
        
			' Add a fill if absent
			paths = paths.Replace("<path ", $"<path fill='rgb(${col.r},${col.g},${col.b})' "$)

			svgFinal.Append(paths).Append(CRLF)
		Else
			RaiseError($"Potrace n'a pas généré de SVG pour la couleur ${col.r},${col.g},${col.b}"$)
			Continue
		End If
		
		File.Delete("", pbm) 
		File.Delete("", svg)
	Next

	svgFinal.Append("</g>").Append(CRLF)
	svgFinal.Append("</svg>")

	Return svgFinal.ToString
End Sub

Private Sub ExtractPaths(svg As String) As String
	Dim res As StringBuilder
	res.Initialize

	Dim m As Matcher = Regex.Matcher("(?i)<path[^>]*>", svg)
	Do While m.Find
		res.Append(m.Match).Append(CRLF)
	Loop

	Return res.ToString
End Sub
#End Region

#Region SVG to PNG
' ===================================
'  Convert a SVG File into BMP image 
' ===================================
' SVGPath : SVG File source
' OutputPath : Path to the output file
Public Sub SVGToPNG(SVGPath As String, OutputPath As String)
	
	mOutputPath = OutputPath
	wv.Visible = True
	
	mForm.RootPane.AddNode(wv, 0, mForm.RootPane.Height, mForm.RootPane.Width, mForm.RootPane.Height) 'Hidden
	
	Dim svg As String = File.ReadString(File.GetFileParent(SVGPath), File.GetName(SVGPath))
	
	Dim size As Map = GetSVGDeclaredSize(svg)
	Dim w As Double = SVGUnitToPixels(size.Get("width_value"), size.Get("width_unit"))
	Dim h As Double = SVGUnitToPixels(size.Get("height_value"), size.Get("height_unit"))
	
	wv.SetSize(w,h)
	
	Dim html As String = $"
<html>
<head><meta charset='UTF-8'>
<style>
::-webkit-scrollbar { display: none; }
body { margin:0; padding:0; overflow:hidden; }
html { overflow:hidden; }
</style>
</head>
<body>
${svg}
</body>
</html>
"$

	wv.LoadHtml(html)
	Wait For wv_PageFinished (Url As String)

	Sleep(200)

	Dim bmp As B4XBitmap = wv.Snapshot
	If bmp.IsInitialized = False Then
		RaiseError("Snapshot WebView invalide : PNG non généré.")
		Return
	End If

	' Open an output stream to save the image
	Dim out As OutputStream
	out = File.OpenOutput(File.GetFileParent(mOutputPath), File.GetName(mOutputPath), False)
    
	' Save the snapshot as a PNG file
	bmp.WriteToStream(out, 100, "PNG")
    
	' Close the output stream
	out.Close
	
	If File.Exists(File.GetFileParent(SVGPath), File.GetName(SVGPath)) = False Then
		RaiseError("Le fichier SVG n'existe pas : " & SVGPath)
		Return
	End If

End Sub

Private Sub GetSVGDeclaredSize(SVG As String) As Map
	Dim res As Map
	res.Initialize

	Dim m As Matcher = Regex.Matcher("width\s*=\s*['""]([\d\.]+)([a-zA-Z%]*)['""]", SVG)
	If m.Find Then
		res.Put("width_value", m.Group(1))
		Dim u As String = m.Group(2)
		If u = Null Or u.Length = 0 Then u = "px"
		res.Put("width_unit", u)
	End If

	m = Regex.Matcher("height\s*=\s*['""]([\d\.]+)([a-zA-Z%]*)['""]", SVG)
	If m.Find Then
		res.Put("height_value", m.Group(1))
		Dim u As String = m.Group(2)
		If u = Null Or u.Length = 0 Then u = "px"
		res.Put("height_unit", u)
	End If

	Return res
End Sub

Private Sub SVGUnitToPixels(value As Double, unit As String) As Double
	If unit = Null Then unit = "px"
	unit = unit.ToLowerCase

	Select unit
		Case "px"
			Return value
		Case "pt"
			Return value *1.33
		Case "in"
			Return value * 96
		Case "cm"
			Return value * 37.7952755906
		Case "mm"
			Return value * 3.77952755906
		Case "%"
			Return value
		Case Else
			Return value
	End Select
End Sub

#End Region

#Region POTRACE CALL
' ===========================
' POTRACE CALL
' https://potrace.sourceforge.net/
' ===========================
Private Sub RunPotrace(PBMFile As String, SVGFile As String)
	
	Dim params As List
	params.Initialize'
	params.Add("--svg")
	If mEdge Then
		params.Add("--tight") 'Eliminate the edges
	End If
	params.Add(PBMFile)
	params.Add("-o")
	params.Add(SVGFile)

	Dim sh As Shell
	sh.InitializeDoNotHandleQuotes("potrace", Potrace, params)

	Dim result As ShellSyncResult = sh.RunSynchronous(60000) ' 60 sec timeout
	
	If result.Success = False Then
		RaiseError("Potrace a échoué : " & result.StdErr)
		'Log("======== ERROR ========")
		'Log("ExitCode: " & result.ExitCode)
		'Log("STDOUT: " & result.StdOut)
		'Log("STDERR: " & result.StdErr)
	End If

End Sub
#End Region

#Region Error handling
' ================
'  Error handling
' ================
' Target : The target page
' EventName : The name of the sub to call
Public Sub SetErrorHandler(Target As Object, EventName As String)
	
	mErrorTarget = Target
	mErrorEvent = EventName.ToLowerCase
End Sub

Private Sub RaiseError(msg As String)
	Log("SVGVectorizer ERROR: " & msg)
	If mErrorTarget <> Null And mErrorEvent <> "" Then
		CallSubDelayed2(mErrorTarget, mErrorEvent, msg)
	End If
End Sub
#End Region

