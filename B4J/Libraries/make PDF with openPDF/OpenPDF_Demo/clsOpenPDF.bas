B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
'15/05/2025
Sub Class_Globals
	'In punti tipografici, le dimensioni A4 sono 595 x 842
	'0,0 angolo basso a sinistra
	'595,842 angolo in alto a destra
	'area utile 585 larghezza, 832 altezza
	Private fx As JFX
	Private doc As JavaObject
	Private out As JavaObject
	Private writer As JavaObject
	'
	Private savePath As String
	Private saveFile As String
	'
	Private cFontSize As Float = 10
	Private r As Int = 0
	Private g As Int = 0
	Private b As Int = 0
	Private cAllineamento As Int = 0 'sinistra
	Private cThickness As Float = 0.3 'spessore linea
	'
	Private fontName As String = "Helvetica"
	'Helvetica-Bold
	'Helvetica-Oblique
	'Helvetica-BoldOblique
	'Courier
	'Courier-Bold
	'Courier-Oblique
	'Courier-BoldOblique
	'Times-Roman
	'Times-Bold
	'Times-Italic
	'Times-BoldItalic
	'Symbol
	'ZapfDingbats
	Private fontEncoding As String = "Cp1252"
End Sub

Public Sub Initialize (outputPath As String, outputFile As String)
	' === Inizializza il documento PDF ===
	savePath = outputPath
	saveFile = outputFile
	'
	doc.InitializeNewInstance("com.lowagie.text.Document", Null)
	out.InitializeNewInstance("java.io.FileOutputStream", Array(outputPath & "\" & outputFile))
	writer = writer.InitializeStatic("com.lowagie.text.pdf.PdfWriter").RunMethod("getInstance", Array(doc, out))
	
	doc.RunMethod("open", Null)
End Sub
'
Public Sub setNomeFont (param As String)
	fontName = param
End Sub
'
Public Sub getNomeFont As String
	Return fontName
End Sub
'
Public Sub setEnCodingFont (param As String)
	fontEncoding = param
End Sub
'
Public Sub getEnCodingFont As String
	Return fontEncoding
End Sub
'
Public Sub setColore (ColorValue As Int)
	r = Bit.And(Bit.ShiftRight(ColorValue, 16), 0xFF)
	g = Bit.And(Bit.ShiftRight(ColorValue, 8), 0xFF)
	b = Bit.And(ColorValue, 0xFF)
End Sub
'
Public Sub getColore As Int
	Dim alpha As Int = 255 ' Opaco
	Return Bit.Or(Bit.ShiftLeft(alpha, 24), Bit.Or(Bit.ShiftLeft(r, 16), Bit.Or(Bit.ShiftLeft(g, 8), b)))
End Sub
'
Public Sub setThickness (param As Float)
	cThickness = param
End Sub
'
Public Sub getThickness As Float
	Return cThickness
End Sub
'
Public Sub setAllineamento (param As Int)
	cAllineamento = param
End Sub
'
Public Sub getAllineamento As Int
	Return cAllineamento
End Sub
'
Public Sub setFontSize (param As Float)
	cFontSize = param
End Sub
'
Public Sub getFontSize As Float
	Return cFontSize
End Sub
'
Public Sub AddText(x As Float, y As Float, sText As String)
	Dim contentByte As JavaObject = writer.RunMethod("getDirectContent", Null)

	Dim baseFont As JavaObject
	baseFont = baseFont.InitializeStatic("com.lowagie.text.pdf.BaseFont") _
		.RunMethod("createFont", Array(fontName, fontEncoding, True))

	contentByte.RunMethod("beginText", Null)
	contentByte.RunMethod("setFontAndSize", Array(baseFont, AsJavaFloat(cFontSize)))

	' Imposta colore
	Dim color As JavaObject
	color.InitializeNewInstance("java.awt.Color", Array(r, g, b))
	contentByte.RunMethod("setColorFill", Array(color))

	' Allineamento: 0=sinistra, 1=centro, 2=destra
	contentByte.RunMethod("showTextAligned", Array(AsJavaInt(cAllineamento), sText, AsJavaFloat(x), AsJavaFloat(y), AsJavaFloat(0)))

	contentByte.RunMethod("endText", Null)
End Sub

'
Public Sub addImage (imagePath As String, imageName As String)
	' === Aggiungi un'immagine ===
	Dim img As JavaObject
	img = img.InitializeStatic("com.lowagie.text.Image").RunMethod("getInstance", Array(imagePath & "\" & imageName))
	img.RunMethod("scaleToFit", Array(200.0f, 200.0f))
	img.RunMethod("setAlignment", ArrayAsInt(1)) ' 1 = centro
	doc.RunMethod("add", Array(img))
End Sub
'
Public Sub addImage2 (imagePath As String, imageName As String, asseX As Float, asseY As Float)
    Dim img As JavaObject
    img = img.InitializeStatic("com.lowagie.text.Image").RunMethod("getInstance", Array(File.Combine(imagePath, imageName)))
    img.RunMethod("scaleToFit", Array(200.0f, 200.0f))
    img.RunMethod("setAbsolutePosition", Array(asseX, asseY))
    doc.RunMethod("add", Array(img))
End Sub
'
Public Sub DisegnaLinea(startX As Float, startY As Float, endX As Float, endY As Float)
	Dim contentByte As JavaObject = writer.RunMethod("getDirectContent", Null)

	' Imposta colore
	Dim color As JavaObject
	color.InitializeNewInstance("java.awt.Color", Array(r, g, b))
	contentByte.RunMethod("setColorStroke", Array(color))

	' Imposta spessore
	contentByte.RunMethod("setLineWidth", Array(AsJavaFloat(cThickness)))

	' Disegna linea
	contentByte.RunMethod("moveTo", Array(AsJavaFloat(startX), AsJavaFloat(startY)))
	contentByte.RunMethod("lineTo", Array(AsJavaFloat(endX), AsJavaFloat(endY)))
	contentByte.RunMethod("stroke", Null)
End Sub
'
Public Sub DisegnaCerchio(x As Float, y As Float, raggio As Float, spessore As Float)
	Dim contentByte As JavaObject = writer.RunMethod("getDirectContent", Null)

	' Imposta colore del bordo
	Dim color As JavaObject
	color.InitializeNewInstance("java.awt.Color", Array(r, g, b))
	contentByte.RunMethod("setColorStroke", Array(color))

	' Imposta spessore bordo
	contentByte.RunMethod("setLineWidth", Array(AsJavaFloat(spessore)))

	' Disegna il cerchio come un'ellisse con uguali larghezza/altezza
	contentByte.RunMethod("circle", Array(AsJavaFloat(x), AsJavaFloat(y), AsJavaFloat(raggio)))

	' Traccia il bordo del cerchio
	contentByte.RunMethod("stroke", Null)
End Sub


Public Sub SaveANDShow (show As Boolean)
	doc.RunMethod("close", Null)
	'saved into outputPath
'	Log(savePath)
'	Log(saveFile)
	If show Then
		fx.ShowExternalDocument(File.GetUri(savePath, saveFile))
	End If
End Sub
'
Private Sub ArrayAsInt(Value As Int) As Object()
	Return Array As Object(Value)
End Sub
'
Private Sub AsJavaInt(i As Int) As Object
	Dim jo As JavaObject
	Return jo.InitializeNewInstance("java.lang.Integer", Array(i))
End Sub
'
Private Sub AsJavaFloat(f As Float) As Object
	Dim jo As JavaObject
	Return jo.InitializeNewInstance("java.lang.Float", Array(f))
End Sub
'
Public Sub NuovaPagina()
	doc.RunMethod("newPage", Null)
End Sub
'
Public Sub DisegnaRettangolo(asseX As Float, asseY As Float, larghezzaX As Float, altezzaY As Float)
	Dim contentByte As JavaObject = writer.RunMethod("getDirectContent", Null)
	' Imposta colore
	Dim color As JavaObject
	color.InitializeNewInstance("java.awt.Color", Array(r, g, b))
	contentByte.RunMethod("setColorStroke", Array(color))
	' Imposta spessore
	contentByte.RunMethod("setLineWidth", Array(AsJavaFloat(cThickness)))
	' Disegna rettangolo
	contentByte.RunMethod("rectangle", Array(AsJavaFloat(asseX), AsJavaFloat(asseY), AsJavaFloat(larghezzaX), AsJavaFloat(altezzaY)))
	' Traccia il bordo del rettangolo
	contentByte.RunMethod("stroke", Null)
End Sub
'
Public Sub AddTextVerticale(x As Float, y As Float, sText As String, ruotaOraria As Boolean)
	Dim contentByte As JavaObject = writer.RunMethod("getDirectContent", Null)

	Dim baseFont As JavaObject
	baseFont = baseFont.InitializeStatic("com.lowagie.text.pdf.BaseFont") _
		.RunMethod("createFont", Array(fontName, fontEncoding, True))

	contentByte.RunMethod("beginText", Null)
	contentByte.RunMethod("setFontAndSize", Array(baseFont, AsJavaFloat(cFontSize)))

	Dim color As JavaObject
	color.InitializeNewInstance("java.awt.Color", Array(r, g, b))
	contentByte.RunMethod("setColorFill", Array(color))

	Dim angolo As Float = IIf(ruotaOraria, 270, 90)
	contentByte.RunMethod("showTextAligned", Array(AsJavaInt(0), sText, AsJavaFloat(x), AsJavaFloat(y), AsJavaFloat(angolo)))

	contentByte.RunMethod("endText", Null)
End Sub

'
Public Sub ImpostaMetadati(titolo As String, autore As String, oggetto As String, paroleChiave As String)
	doc.RunMethod("addTitle", Array(titolo))
	doc.RunMethod("addAuthor", Array(autore))
	doc.RunMethod("addSubject", Array(oggetto))
	doc.RunMethod("addKeywords", Array(paroleChiave))
End Sub
'
Public Sub AddTable(asseX As Float, asseY As Float, numberColumn As Int, columnWidths As List, headers As List, lineHeight As Float)
	' === Crea la tabella con il numero di colonne ===
	Dim table As JavaObject
	table.InitializeNewInstance("com.lowagie.text.pdf.PdfPTable", Array(numberColumn))

	' === Imposta la larghezza delle colonne ===
	Dim widths(numberColumn) As Float
	For i = 0 To columnWidths.Size - 1
		widths(i) = columnWidths.Get(i)
	Next
	table.RunMethod("setWidths", Array(widths))

	' === Disegna i rettangoli per le intestazioni e aggiungi il testo ===
	Dim currentX As Float = asseX ' Posizione iniziale sulla X
	Dim currentY As Float = asseY ' Posizione iniziale sulla Y

	For i = 0 To headers.Size - 1
		' Disegna un rettangolo attorno all'intestazione della colonna
		DisegnaRettangolo(currentX, currentY - 20, widths(i), 20) ' Disegna il rettangolo (in alto)
        
		' Aggiungi il testo dell'intestazione all'interno del rettangolo
		AddText(currentX + 5, currentY - 15, headers.Get(i)) ' Aggiungi il testo con un piccolo margine

		' Aggiorna la posizione sulla X per la prossima intestazione
		currentX = currentX + widths(i)
	Next

	' === Aggiungi la tabella al documento ===
	doc.RunMethod("add", Array(table))

	' === Disegna le linee verticali tra le colonne ===
	currentX = asseX ' Ripristina la posizione iniziale sulla X
	For i = 0 To numberColumn - 1
		' Disegna la linea verticale tra le colonne
		DisegnaLinea(currentX, asseY, currentX, lineHeight)
		currentX = currentX + widths(i) ' Sposta la posizione per la colonna successiva
	Next

	' === Disegna la linea verticale finale per chiudere l'ultima colonna ===
	currentX = asseX + widths(0) ' Riprende la posizione della prima colonna e somma la larghezza
	For i = 1 To numberColumn - 1
		currentX = currentX + widths(i) ' Aggiorna la posizione X per l'ultima colonna
	Next
	' Disegna l'ultima linea verticale
	DisegnaLinea(currentX, asseY, currentX, lineHeight)

	' === Disegna una riga orizzontale alla fine della tabella ===
	Dim endX As Float = asseX + widths(0) ' Inizia dalla posizione della prima colonna
	For i = 1 To numberColumn - 1
		endX = endX + widths(i) ' Somma tutte le larghezze delle colonne per determinare la fine
	Next

	' Disegna la riga orizzontale (alla base della tabella)
	DisegnaLinea(asseX, lineHeight, endX, lineHeight)
End Sub
'
Public Sub DisegnaRettangoloArrotondato(asseX As Float, asseY As Float, larghezzaX As Float, altezzaY As Float, raggioAngolo As Float)
	Dim contentByte As JavaObject = writer.RunMethod("getDirectContent", Null)

	' Imposta colore
	Dim color As JavaObject
	color.InitializeNewInstance("java.awt.Color", Array(r, g, b))
	contentByte.RunMethod("setColorStroke", Array(color))

	' Imposta spessore
	contentByte.RunMethod("setLineWidth", Array(AsJavaFloat(cThickness)))

	' Disegna rettangolo con angoli arrotondati
	contentByte.RunMethod("roundRectangle", Array( _
		AsJavaFloat(asseX), AsJavaFloat(asseY), _
		AsJavaFloat(larghezzaX), AsJavaFloat(altezzaY), _
		AsJavaFloat(raggioAngolo)))

	' Traccia il bordo
	contentByte.RunMethod("stroke", Null)
End Sub
'
Public Sub AddEAN13(x As Float, y As Float, codice12 As String, larghezza As Float, altezza As Float)
	Dim codice As String = codice12
	Try
		' Verifica che il codice sia valido (12 cifre)
		If codice12.Length = 12 Then
			codice = CalcolaEAN13CheckDigit (codice12)
		End If
		Dim barcode As JavaObject
		barcode.InitializeNewInstance("com.lowagie.text.pdf.BarcodeEAN", Null)
		barcode.RunMethod("setCodeType", Array(BarcodeType("EAN13")))
		barcode.RunMethod("setCode", Array(codice))
		barcode.RunMethod("setBarHeight", Array(AsJavaFloat(altezza)))
		barcode.RunMethod("setX", Array(AsJavaFloat(larghezza / 100))) ' Spaziatura tra le barre
		barcode.RunMethod("setSize", Array(AsJavaFloat(cFontSize))) ' Grandezza del testo

		Dim cb As JavaObject = writer.RunMethod("getDirectContent", Null)
		Dim image As JavaObject = barcode.RunMethod("createImageWithBarcode", Array(cb, Null, Null))

		image.RunMethod("setAbsolutePosition", Array(x, y))
		doc.RunMethod("add", Array(image))
	Catch
		Log("Errore durante la creazione del codice EAN13: " & LastException.Message)
	End Try
End Sub

Private Sub BarcodeType(name As String) As Object
	Dim jo As JavaObject
	Return jo.InitializeStatic("com.lowagie.text.pdf.BarcodeEAN").GetField(name)
End Sub
'
Public Sub CalcolaEAN13CheckDigit(codice12 As String) As String
	Dim tp As String = "0"
	Dim td As String = "0"
	For i = 0 To 11
		Dim cifra As String = codice12.CharAt(i)
		If i Mod 2 = 0 Then
			td = td + cifra
		Else
			tp = tp + cifra
		End If
	Next
	tp = (tp * 3) + td
	Dim intero As Int = (10 - (tp Mod 10)) Mod 10
	Return codice12 & intero ' .As(String)
End Sub
'
Public Sub HexToRGB(HexColor As String)
	If HexColor.StartsWith("#") Then HexColor = HexColor.SubString(1)
	r = Bit.ParseInt(HexColor.SubString2(0, 2), 16)
	g = Bit.ParseInt(HexColor.SubString2(2, 4), 16)
	b = Bit.ParseInt(HexColor.SubString2(4, 6), 16)
End Sub