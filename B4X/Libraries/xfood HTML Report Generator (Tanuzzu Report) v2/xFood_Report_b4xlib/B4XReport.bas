B4X=true
Type=Class
Version=2.0
VersionCode=1
ModulesStructureVersion=1
B4A=true
B4i=true
B4J=true
ApiLevel=1
@EndOfDesignText@

'B4XReport - Motore di rendering per i report creati con ReportDesigner.html
'
'Questa libreria legge il file JSON prodotto dal Report Designer (ReportDesigner.html)
'e genera l'HTML del report. L'HTML usa regole CSS @page cosi' che la stampa a PDF
'delle piattaforme (B4J WebView.Print, browser, ecc.) produca pagine perfettamente
'impaginate e leggibili.
'
'Esempio di utilizzo (B4J):
'   Dim rep As B4XReport
'   rep.Initialize
'   rep.LoadTemplate(File.ReadString(File.DirApp, "Report.json"))
'   rep.SetDataRecords(MyRecords)             'List di Map (una per riga)
'   Dim html As String = rep.RenderToHTML
'   WebView1.LoadHtml(html)
'
'Le piattaforme B4X non hanno un'API unica e affidabile per scrivere PDF nativi
'cross-platform, quindi la libreria genera un HTML perfettamente stampabile.
'Sulle piattaforme che supportano un WebView (B4J, B4A, B4i) basta mostrare
'l'HTML in un WebView e usare la stampa del sistema (che permette di "Salvare
'come PDF"). La pagina usa page-break-after per separare correttamente le pagine.

'Design: puro B4X, nessuna dipendenza nativa. Funziona su B4A, B4i e B4J.

Sub Class_Globals
	Public Title As String
	Public PageW As Int
	Public PageH As Int
	Private Const mmToPx As Double = 3.7795
	Private mTitle As String = ""
	Private mPageSize As String = "A4"
	Private mPageOrient As String = "portrait"
	Private mPageW As Int = 210
	Private mPageH As Int = 297
	Private mMarginT As Double = 10
	Private mMarginB As Double = 10
	Private mMarginL As Double = 15
	Private mMarginR As Double = 15
	Private Const PT_PER_MM As Double = 2.8346456693
	Private Const F_HELVC As Int = 1
	Private Const F_BOLD As Int = 2
	Private Const F_OBLQ As Int = 3
	Private mBandH As Map
	Private mBandRepeat As Map
	Private mElements As List
	Private mDataFields As List
	Private mDataSourceType As String = "manual"
	Private mDataSourceConfig As String = ""
	Private mRecords As List
	Private mRecordsTitolo As Map
	Private mRecordsPie As Map
	Private mRecordsFooter As Map
	Private mPageCalc As Map
	Private mReportCalc As Map
End Sub

#Region Bande

'Definizione delle bande del Report Designer (stesso ordine del designer)
Private Sub GetBandKeys As List
	Dim l As List
	l.Initialize
	l.Add("reportHdr")
	l.Add("pageHdr")
	l.Add("detail")
	l.Add("pageFtr")
	l.Add("reportFtr")
	Return l
End Sub

Private Sub GetBandTop(BandKey As String) As Double
	Select BandKey
		Case "reportHdr"
			Return 0
		Case "pageHdr"
			Return mBandH.GetDefault("reportHdr", 30)
		Case "detail"
			Return mBandH.GetDefault("reportHdr", 30) + mBandH.GetDefault("pageHdr", 20)
		Case "pageFtr"
			Return mPageH - mBandH.GetDefault("reportFtr", 20) - mBandH.GetDefault("pageFtr", 15)
		Case "reportFtr"
			Return mPageH - mBandH.GetDefault("reportFtr", 20)
		Case Else
			Return 0
	End Select
End Sub

Private Sub IsDetailBand(BandKey As String) As Boolean
	Return BandKey = "detail"
End Sub

'Ritorna la modalità di ripetizione di una banda: "every_page", "first_only", "last_only"
Private Sub BandRepeatMode(BandKey As String) As String
	Select BandKey
		Case "reportHdr"
			Return mBandRepeat.GetDefault("reportHdr", "first_only")
		Case "pageHdr"
			Return mBandRepeat.GetDefault("pageHdr", "every_page")
		Case "detail"
			Return "every_record"
		Case "pageFtr"
			Return mBandRepeat.GetDefault("pageFtr", "every_page")
		Case "reportFtr"
			Return mBandRepeat.GetDefault("reportFtr", "last_only")
		Case Else
			Return "first_only"
	End Select
End Sub

'Indica se una banda deve essere renderizzata nella pagina indicata (0-based)
Private Sub BandRenderedOnPage(BandKey As String, PageNum As Int, TotalPages As Int) As Boolean
	Dim mode As String = BandRepeatMode(BandKey)
	If mode = "every_page" Then Return True
	If mode = "first_only" Then Return (PageNum = 0)
	If mode = "last_only" Then Return (PageNum = TotalPages - 1)
	Return (PageNum = 0)
End Sub

#End Region

#Region Inizializzazione

Public Sub Initialize
	mBandH.Initialize
	mBandRepeat.Initialize
	mElements.Initialize
	mRecords.Initialize
	mRecordsTitolo.Initialize
	mRecordsPie.Initialize
	mRecordsFooter.Initialize
	mPageCalc.Initialize
	mReportCalc.Initialize
	mDataFields.Initialize
	SetDefaultBandHeights
End Sub

Private Sub SetDefaultBandHeights
	mBandH.Put("reportHdr", 30)
	mBandH.Put("pageHdr", 20)
	mBandH.Put("detail", 60)
	mBandH.Put("pageFtr", 15)
	mBandH.Put("reportFtr", 20)
	mBandRepeat.Put("reportHdr", "first_only")
	mBandRepeat.Put("pageHdr", "every_page")
	mBandRepeat.Put("pageFtr", "every_page")
	mBandRepeat.Put("reportFtr", "last_only")
End Sub

#End Region

#Region Caricamento template

'Carica un template dal JSON generato dal Report Designer.
'Return True se il parsing e' riuscito.
Public Sub LoadTemplate(JSONString As String) As Boolean
	Try
		Dim parser As JSONParser
		parser.Initialize(JSONString)
		Dim data As Map = parser.NextObject
		Log("LT: NextObject ok, size=" & data.Size)

		mTitle = data.GetDefault("title", "Report")
		mPageSize = data.GetDefault("pageSize", "A4")
		mPageOrient = data.GetDefault("pageOrient", "portrait")
		mMarginT = data.GetDefault("marginT", 10)
		mMarginB = data.GetDefault("marginB", 10)
		mMarginL = data.GetDefault("marginL", 15)
		mMarginR = data.GetDefault("marginR", 15)

		Select mPageSize
			Case "A4"
				mPageW = 210 : mPageH = 297
			Case "A5"
				mPageW = 148 : mPageH = 210
			Case "Letter"
				mPageW = 216 : mPageH = 279
			Case Else
				mPageW = 210 : mPageH = 297
		End Select

		If mPageOrient = "landscape" Then
			Dim temp As Int = mPageW
			mPageW = mPageH
			mPageH = temp
		End If

		Title = mTitle
		PageW = mPageW
		PageH = mPageH

		mBandH.Clear
		Dim bh As Map = data.GetDefault("bandH", Null)
		Log("LT: bandH=" & bh)
		If bh <> Null And bh.Size > 0 Then
			For Each k As String In bh.Keys
				mBandH.Put(k, bh.Get(k))
			Next
		Else
			SetDefaultBandHeights
		End If
		'assicura che tutte le bande abbiano un'altezza definita
		For Each k As String In GetBandKeys
			If mBandH.ContainsKey(k) = False Then
				If k = "reportHdr" Then mBandH.Put(k, 30)
				If k = "pageHdr" Then mBandH.Put(k, 20)
				If k = "detail" Then mBandH.Put(k, 60)
				If k = "pageFtr" Then mBandH.Put(k, 15)
				If k = "reportFtr" Then mBandH.Put(k, 20)
			End If
		Next

		mBandRepeat.Clear
		Dim br As Map = data.GetDefault("bandRepeat", Null)
		Log("LT: bandRepeat=" & br)
		If br <> Null And br.Size > 0 Then
			For Each k As String In br.Keys
				mBandRepeat.Put(k, br.Get(k))
			Next
		End If
		'assicura che tutte le bande abbiano una modalità di ripetizione definita
		For Each k As String In GetBandKeys
			If k <> "detail" And mBandRepeat.ContainsKey(k) = False Then
				If k = "reportHdr" Then mBandRepeat.Put(k, "first_only")
				If k = "pageHdr" Then mBandRepeat.Put(k, "every_page")
				If k = "pageFtr" Then mBandRepeat.Put(k, "every_page")
				If k = "reportFtr" Then mBandRepeat.Put(k, "last_only")
			End If
		Next

		mElements.Initialize
		If data.ContainsKey("elements") Then
			Dim eObj As Object = data.Get("elements")
			Log("LT: elements type=" & eObj & " isList=" & (eObj Is List))
			If eObj Is List Then
				Dim els As List = eObj
				For Each el As Map In els
					mElements.Add(el)
				Next
			End If
		End If

		mDataFields.Initialize
		If data.ContainsKey("dataFields") Then
			Dim dObj As Object = data.Get("dataFields")
			Log("LT: dataFields type=" & dObj & " isList=" & (dObj Is List))
			If dObj Is List Then
				Dim dfs As List = dObj
				For Each df As Map In dfs
					mDataFields.Add(df)
				Next
			End If
		End If

		mDataSourceType = data.GetDefault("dataSourceType", "manual")
		mDataSourceConfig = data.GetDefault("dataSourceConfig", "")

		Return True
	Catch
		Log("LT: EXCEPTION: " & LastException.Message)
		Return False
	End Try
End Sub

'Carica un template da un file.
Public Sub LoadTemplateFromFile(Dir As String, FileName As String) As Boolean
	Dim text As String
	Try
		text = File.ReadString(Dir, FileName)
	Catch
		Log(LastException.Message)
		Return False
	End Try
	Return LoadTemplate(text)
End Sub

'Imposta i record (List di Map, una Map per riga) da usare nel report.
Public Sub SetDataRecords(Records As List)
	mRecords.Clear
	If Records = Null Then Return
	For Each r As Map In Records
		mRecords.Add(r)
	Next
End Sub

'Imposta un singolo record (comodo per report a scheda singola).
Public Sub SetSingleRecord(Record As Map)
	mRecords.Clear
	If Record <> Null Then mRecords.Add(Record)
End Sub

'Alias di SetDataRecords: imposta i record (List di Map) della banda detail.
Public Sub SetDataRecordsDettail(Records As List)
	SetDataRecords(Records)
End Sub

'Imposta una singola Map con i dati della testata del report (banda reportHdr, es. dati aziendali).
Public Sub SetDataRecordsTitolo(Titolo As Map)
	mRecordsTitolo = Titolo
End Sub

'Imposta una singola Map con i totalizzatori (banda pageFtr, es. totali per pagina).
Public Sub SetDataRecordsPie(Pie As Map)
	mRecordsPie = Pie
End Sub

'Imposta una singola Map con i dati di fine report (banda reportFtr, es. totali/footer finali).
Public Sub SetDataRecordsFooter(Fine As Map)
	mRecordsFooter = Fine
End Sub

#End Region

#Region Rendering

'Genera l'HTML completo del report, con paginazione automatica dei record.
Public Sub RenderToHTML As String
	If mElements.Size = 0 Then Return "<html><body><p>Nessun elemento.</p></body></html>"
	If mRecords.Size = 0 Then
		Return RenderSinglePage("", Null)
	End If
	Return BuildMultiPage
End Sub

Private Sub BuildMultiPage As String
	Dim sb As StringBuilder
	sb.Initialize

	Dim headerH As Double = mBandH.GetDefault("reportHdr", 30) + mBandH.GetDefault("pageHdr", 20)
	'L'header di report viene renderizzato solo nella prima pagina ma occupa spazio.
	Dim detailH As Double = GetDetailHeight
	Dim footerH As Double = mBandH.GetDefault("pageFtr", 15) + mBandH.GetDefault("reportFtr", 20)

	Dim availableH As Double = mPageH - headerH - footerH
	Dim maxPerPage As Int = Max(1, Floor(availableH / detailH))
	Dim totalPages As Int = Max(1, Ceil(mRecords.Size / maxPerPage))

	'Aggregati a livello di intero report (per i campi calcolati con ambito "report")
	ComputeCalcForElements(mReportCalc, mRecords)

	For p = 0 To totalPages - 1
		Dim startIdx As Int = p * maxPerPage
		Dim endIdx As Int = Min(startIdx + maxPerPage, mRecords.Size)

		'Aggregati della pagina corrente (per i campi calcolati con ambito "page")
		Dim pageRecs As List
		pageRecs.Initialize
		For rr = startIdx To endIdx - 1
			pageRecs.Add(mRecords.Get(rr))
		Next
		ComputeCalcForElements(mPageCalc, pageRecs)

		Dim sbPage As StringBuilder
		sbPage.Initialize
		sbPage.Append("<div class='page'>" & CRLF)

		'Bande non-detail: rendering in base alla relativa modalità di ripetizione
		'configurata nel JSON (every_page, first_only, last_only)
		For Each bk As String In GetBandKeys
			If bk = "detail" Then Continue
			Dim renderNow As Boolean = BandRenderedOnPage(bk, p, totalPages)
			If renderNow Then
				sbPage.Append(RenderBandElements(bk, Null, 0, totalPages, 1))
			End If
		Next

		'Dettaglio: renderizza ogni record della pagina
		For rowIdx = startIdx To endIdx - 1
			Dim rec As Map = mRecords.Get(rowIdx)
			Dim rowOffset As Double = (rowIdx - startIdx) * detailH
			sbPage.Append(RenderBandElements("detail", rec, rowOffset, totalPages, rowIdx + 1))
		Next

		sbPage.Append("</div>" & CRLF)
		sb.Append(sbPage.ToString)
	Next

	Return WrapDocument(sb.ToString)
End Sub

'Renderizza una singola pagina (report a scheda, senza tabulato).
Private Sub RenderSinglePage(PageContent As String, Rec As Map) As String
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<div class='page'>" & CRLF)
	For Each bk As String In GetBandKeys
		If bk = "detail" Then
			'per scheda singola con record: renderizza un solo record in posizione 0
			If Rec <> Null Then
				sb.Append(RenderBandElements("detail", Rec, 0, 1, 1))
			End If
		Else
			sb.Append(RenderBandElements(bk, Null, 0, 1, 1))
		End If
	Next
	sb.Append("</div>" & CRLF)
	Return WrapDocument(sb.ToString)
End Sub

'Calcola l'altezza reale della banda detail in base agli elementi.
Private Sub GetDetailHeight As Double
	Dim maxY As Double = 0
	For Each el As Map In mElements
		If el.Get("band") = "detail" Then
			Dim bottom As Double = el.Get("y") + el.Get("h")
			If bottom > maxY Then maxY = bottom
		End If
	Next
	Return Max(5, maxY + 2)
End Sub

Private Sub RenderBandElements(BandKey As String, Rec As Map, RowOffset As Double, TotalPages As Int, RowNum As Int) As String
	Dim bandTop As Double = GetBandTop(BandKey)
	Dim dataRec As Map = Rec
	Select BandKey
		Case "reportHdr"
			dataRec = mRecordsTitolo
		Case "pageFtr"
			dataRec = mRecordsPie
		Case "reportFtr"
			dataRec = mRecordsFooter
	End Select
	Dim sb As StringBuilder
	sb.Initialize
	For Each el As Map In mElements
		If el.Get("band") <> BandKey Then Continue
		sb.Append(RenderElement(el, dataRec, bandTop, RowOffset, TotalPages, RowNum))
	Next
	Return sb.ToString
End Sub

#End Region

#Region Elemento

'Calcola l'aggregato (SUM/COUNT/AVG/MIN/MAX) su una lista di record per un campo.
Private Sub ComputeAggregates(Recs As List, FieldName As String, Fn As String) As Double
	Dim cnt As Int = 0
	Dim s As Double = 0
	Dim mn As Double = 0
	Dim mx As Double = 0
	Dim first As Boolean = True
	For Each rec As Map In Recs
		If rec = Null Or FieldName = "" Then Continue
		If rec.ContainsKey(FieldName) = False Then Continue
		Dim v As Object = rec.Get(FieldName)
		If v = Null Then Continue
		Dim n As Double = ToNumber(v)
		cnt = cnt + 1
		If first Then
			mn = n
			mx = n
			first = False
		Else
			If n < mn Then mn = n
			If n > mx Then mx = n
		End If
		s = s + n
	Next
	Select Fn
		Case "COUNT"
			Return cnt
		Case "MIN"
			Return mn
		Case "MAX"
			Return mx
		Case "AVG"
			If cnt > 0 Then Return s / cnt Else Return 0
		Case Else
			Return s
	End Select
End Sub

'Ritorna il tipo del campo dati (per la formattazione dei calcoli).
Private Sub GetDataFieldType(FieldName As String) As String
	If mDataFields.Size > 0 Then
		For Each df As Map In mDataFields
			If df.GetDefault("name", "") = FieldName Then Return df.GetDefault("type", "text")
		Next
	End If
	Return "text"
End Sub

'Converte una stringa numerica (eventualmente con separatori di migliaia/virgola) in Double.
'Converte un valore (numero o stringa) in Double.
'Gestisce sia numeri nativi (99.99 -> 99.99) sia stringhe formattate in stile
'italiano ("1.250,00" -> 1250.00).
Private Sub ToNumber(obj As Object) As Double
	Try
		Dim d As Double = obj
		Return d
	Catch
		'non direttamente numerico: prova a interpretare come stringa italiana
	End Try
	Dim s0 As String = obj
	If s0 = "" Or s0 = "null" Then Return 0
	Dim cleaned As String = ""
	For i = 0 To s0.Length - 1
		Dim ch As String = s0.CharAt(i)
		If (ch >= "0" And ch <= "9") Or ch = "," Or ch = "-" Or ch = "." Then cleaned = cleaned & ch
	Next
	cleaned = cleaned.Replace(".", "").Replace(",", ".")
	If cleaned = "" Or cleaned = "-" Or cleaned = "." Then Return 0
	Try
		Return cleaned
	Catch
		Return 0
	End Try
End Sub

'Calcola i valori di tutti i campi calcolati su una lista di record e li salva in CalcMap.
Private Sub ComputeCalcForElements(CalcMap As Map, Recs As List)
	CalcMap.Clear
	For Each el As Map In mElements
		If el.GetDefault("type", "") <> "calcfield" Then Continue
		Dim fb As Double = ComputeAggregates(Recs, el.GetDefault("source", ""), el.GetDefault("calcFn", "SUM"))
		CalcMap.Put(el.Get("id"), FormatCalc(el, fb))
	Next
End Sub

'Formatta il valore aggregato secondo il tipo del campo e il prefisso dell'elemento.
Private Sub FormatCalc(el As Map, v As Double) As String
	Dim s As String = FormatNumIT(v, el)
	Dim pre As String = el.GetDefault("value", "")
	If pre <> "" Then s = pre & " " & s
	Return s
End Sub

'Formatta un numero nello stile italiano: punto per le migliaia, virgola per i decimali.
'Decimali e simbolo valuta sono configurabili sull'elemento (calcDecimals, calcSymbol).
Private Sub FormatNumIT(v As Double, el As Map) As String
	Dim dec As Int = el.GetDefault("calcDecimals", 2)
	If dec < 0 Then dec = 0
	If dec > 6 Then dec = 6
	Dim sym As String = el.GetDefault("calcSymbol", "")
	Dim neg As Boolean = False
	Dim n As Double = v
	If n < 0 Then
		neg = True
		n = -n
	End If
	Dim fact As Double = 1
	For i = 1 To dec
		fact = fact * 10
	Next
	Dim scaled As Long = Round(n * fact)
	Dim intP As Long = Round(scaled / fact)
	Dim fracP As Long = scaled - intP * fact
	Dim fracStr As String = fracP
	If dec > 0 Then
		Do While fracStr.Length < dec
			fracStr = "0" & fracStr
		Loop
	End If
	Dim s As String = AddThousands(intP)
	If dec > 0 Then s = s & "," & fracStr
	If neg Then s = "-" & s
	If sym <> "" Then s = s & " " & sym
	Return s
End Sub

'Aggiunge il separatore delle migliaia (punto) a un numero intero Long.
Private Sub AddThousands(num As Long) As String
	Dim numStr As String = num
	Dim res As String = ""
	Dim c As Int = 0
	For i = numStr.Length - 1 To 0 Step -1
		res = numStr.CharAt(i) & res
		c = c + 1
		If c Mod 3 = 0 And i > 0 Then res = "." & res
	Next
	Return res
End Sub

'Ritorna il valore formattato di un campo calcolato per l'elemento dato.
Private Sub GetCalcValue(el As Map) As String
	Dim cKey As String = el.Get("id")
	Dim cMap As Map = mPageCalc
	If el.GetDefault("calcScope", "page") = "report" Then cMap = mReportCalc
	If cMap.ContainsKey(cKey) Then Return cMap.Get(cKey)
	Return "{" & el.GetDefault("calcFn", "SUM") & "(" & el.GetDefault("source", "") & ")}"
End Sub

Private Sub RenderElement(el As Map, Rec As Map, BandTop As Double, RowOffset As Double, TotalPages As Int, RowNum As Int) As String
	Dim elType As String = el.Get("type")
	Dim elX As Double = el.Get("x")
	Dim elY As Double = el.Get("y")
	Dim elW As Double = el.Get("w")
	Dim elH As Double = el.Get("h")
	Dim elSource As String = el.GetDefault("source", "")
	Dim elValue As String = el.GetDefault("value", "")

	Dim absX As Double = mMarginL + elX
	Dim absY As Double = BandTop + elY + RowOffset

	Dim style As String = "position:absolute;left:" & NumberToString(absX) & "mm;top:" & NumberToString(absY) & "mm;"
	style = style & "width:" & NumberToString(elW) & "mm;min-height:" & NumberToString(elH) & "mm;"
	style = style & "font-family:" & el.GetDefault("fontName", "Arial") & ";"
	style = style & "font-size:" & el.GetDefault("fontSize", 10) & "pt;"
	If el.GetDefault("fontBold", False) = True Then
		style = style & "font-weight:bold;"
	Else
		style = style & "font-weight:normal;"
	End If
	style = style & "font-style:" & el.GetDefault("fontStyle", "normal") & ";"
	style = style & "color:" & el.GetDefault("fontColor", "#000000") & ";"
	style = style & "text-align:" & el.GetDefault("hAlign", "left") & ";"

	Dim bgColor As String = el.GetDefault("bgColor", "")
	If bgColor <> "" Then style = style & "background:" & bgColor & ";"

	Dim bw As Int = el.GetDefault("borderWidth", 0)
	If bw > 0 Then
		If elType = "text" Or elType = "label" Then
			style = style & "border:" & bw & "px solid " & el.GetDefault("borderColor", "#000000") & ";"
		End If
	End If

	Dim content As String = ""

	Select elType
		Case "text"
			content = GetFieldValue(elSource, elValue, Rec)
		Case "label"
			content = elValue
		Case "sysfield"
			content = GetSystemField(elSource, RowNum, TotalPages)
		Case "calcfield"
			content = GetCalcValue(el)
		Case "hline"
			Dim lineW As Int = 1
			If bw > 0 Then lineW = bw
			style = style & "border-top:" & lineW & "px solid " & el.GetDefault("fontColor", "#000000") & ";height:0;"
		Case "rect"
			Dim rbw As Int = Max(1, bw)
			If bgColor = "" Then
				style = style & "background:transparent;border:" & rbw & "px solid " & el.GetDefault("fontColor", "#000000") & ";"
			Else
				style = style & "background:" & bgColor & ";"
			End If
		Case "circle"
			Dim cbw As Int = Max(1, bw)
			style = style & "border-radius:50%;"
			If bgColor = "" Then
				style = style & "background:transparent;border:" & cbw & "px solid " & el.GetDefault("fontColor", "#000000") & ";"
			Else
				style = style & "background:" & bgColor & ";"
			End If
		Case "image"
			Dim imgData As String = el.GetDefault("imageData", "")
			If imgData <> "" Then
				style = style & "overflow:hidden;"
				content = "<img src='" & imgData & "' style='width:100%;height:100%;object-fit:contain;'>"
			End If
		Case "ean13"
			content = RenderEAN13(ValoreCampo(Rec, elSource), elW * mmToPx, elH * mmToPx)
		Case "qrcode"
			Dim qrText As String = elSource
			If elSource <> "" And Rec <> Null And Rec.ContainsKey(elSource) Then
				qrText = ValoreCampo(Rec, elSource)
			End If
			content = RenderQR(qrText, elW * mmToPx, elH * mmToPx)
	End Select

	Return "<div style='" & style & "'>" & content & "</div>" & CRLF
End Sub

Private Sub GetFieldValue(Source As String, DefaultValue As String, Rec As Map) As String
	If Source = "" Then Return DefaultValue
	If Rec = Null Then Return "{" & Source & "}"
	If Rec.ContainsKey(Source) = False Then Return "[" & Source & "]"
	Return ValoreCampo(Rec, Source)
End Sub

'Ritorna il valore di un campo applicando eventuali formattazioni note.
'La formattazione e' determinata dal campo dataFields se presente, altrimenti
'per campi chiave (prezzo, quantita) si applica una formattazione di default.
Public Sub ValoreCampo(Rec As Map, FieldName As String) As String
	If FieldName = "" Then Return ""
	If Rec = Null Then Return ""
	If Rec.ContainsKey(FieldName) = False Then Return "[" & FieldName & "]"

	Dim v As String = Rec.Get(FieldName)
	If v = "null" Then v = ""

	Dim fieldType As String = ""
	If mDataFields.Size > 0 Then
		For Each df As Map In mDataFields
			If df.GetDefault("name", "") = FieldName Then
				fieldType = df.GetDefault("type", "text")
				Exit
			End If
		Next
	End If

	Select fieldType
		Case "number"
			Try
				Return NumberFormat2(v, 0, 2, 2, False)
			Catch
				Return v
			End Try
		Case "currency"
			Try
				Return NumberFormat2(v, 0, 2, 2, True) & " EUR"
			Catch
				Return v
			End Try
		Case "date"
			'Il designer gestisce le date come testo; qui si restituisce il testo.
			Return v
		Case Else
			'Default per campi comuni non dichiarati come dataFields
			Select FieldName
				Case "prezzo"
					Try
						Return NumberFormat2(v, 0, 2, 2, True) & " EUR"
					Catch
						Return v
					End Try
				Case "quantita", "qta"
					Try
						Return NumberFormat2(v, 0, 0, 0, False)
					Catch
						Return v
					End Try
				Case Else
					Return v
			End Select
	End Select
End Sub

Private Sub GetSystemField(FieldName As String, RowNum As Int, TotalPages As Int) As String
	Select FieldName
		Case "page_num"
			Return RowNum
		Case "page_total"
			Return TotalPages
		Case "date"
			Return DateTime.Date(DateTime.Now)
		Case "datetime"
			Return DateTime.Date(DateTime.Now) & " " & DateTime.Time(DateTime.Now)
		Case "title"
			Return mTitle
		Case "user"
			Return GetUserName
		Case "logo"
			Return ""
		Case Else
			Return ""
	End Select
End Sub

'Ritorna il nome utente derivato dal percorso della cartella home, se disponibile.
Private Sub GetUserName As String
	Dim path As String = File.DirApp
	Dim usersKey As String = "\Users\"
	Dim idx As Int = path.IndexOf(usersKey)
	If idx > -1 Then
		Dim after As String = path.SubString(idx + usersKey.Length)
		Dim q As Int = after.IndexOf("\")
		If q > -1 Then Return after.SubString2(0, q)
		Return after
	End If
	Dim homeKey As String = "/home/"
	Dim p2 As Int = path.IndexOf(homeKey)
	If p2 > -1 Then
		Dim after2 As String = path.SubString(p2 + homeKey.Length)
		Dim q2 As Int = after2.IndexOf("/")
		If q2 > -1 Then Return after2.SubString2(0, q2)
		Return after2
	End If
	Return ""
End Sub

#End Region

#Region Documento

Private Sub WrapDocument(PageBody As String) As String
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<!DOCTYPE html>" & CRLF)
	sb.Append("<html><head><meta charset='UTF-8'>" & CRLF)
	sb.Append("<title>" & EscapeHtml(mTitle) & "</title>" & CRLF)
	sb.Append("<style>" & CRLF)
	sb.Append("@page{size:" & mPageW & "mm " & mPageH & "mm;margin:0}" & CRLF)
	sb.Append("html,body{margin:0;padding:0}" & CRLF)
	sb.Append("body{font-family:Arial,sans-serif;color:#000}" & CRLF)
	sb.Append(".page{position:relative;width:" & mPageW & "mm;height:" & mPageH & "mm;page-break-after:always;overflow:hidden}" & CRLF)
	sb.Append("</style></head>" & CRLF)
	sb.Append("<body>" & CRLF)
	sb.Append(PageBody)
	sb.Append("</body></html>" & CRLF)
	Return sb.ToString
End Sub

Private Sub EscapeHtml(s As String) As String
	s = s.Replace("&", "&amp;")
	s = s.Replace("<", "&lt;")
	s = s.Replace(">", "&gt;")
	Return s
End Sub

'Formatta un numero senza trailing zeros e con la virgola come separatore,
'per i valori in mm dentro lo stile CSS.
Private Sub NumberToString(v As Double) As String
	Return NumberToString4(v)
End Sub

'Formatta un numero in stile PDF (punto decimale, 4 decimali).
Private Sub NumberToString4(v As Double) As String
	Dim s As String = NumberFormat2(v, 0, 1, 4, False)
	Return s.Replace(",", ".")
End Sub

#End Region

#Region PDF

'Genera un documento PDF nativo (puro B4X, nessuna libreria esterna) con il report.
'Return: il contenuto binario-testuale del file PDF.
'Nota: indispensabile per una resa corretta nei lettori PDF.
Public Sub RenderToPDF As String
	Dim totalPages As Int = 1
	Dim maxPerPage As Int = 1
	Dim detailH As Double = GetDetailHeight
	Dim headerH As Double = mBandH.GetDefault("reportHdr", 30) + mBandH.GetDefault("pageHdr", 20)
	Dim footerH As Double = mBandH.GetDefault("pageFtr", 15) + mBandH.GetDefault("reportFtr", 20)
	Dim availableH As Double = mPageH - headerH - footerH
	If mRecords.Size > 0 Then
		detailH = GetDetailHeight
		maxPerPage = Max(1, Floor(availableH / detailH))
		totalPages = Max(1, Ceil(mRecords.Size / maxPerPage))
	End If

	'Aggregati a livello di intero report (per i campi calcolati con ambito "report")
	ComputeCalcForElements(mReportCalc, mRecords)

	'Prepara i content stream di ogni pagina
	Dim contents As List
	contents.Initialize
	For p = 0 To totalPages - 1
		Dim cs As StringBuilder
		cs.Initialize
		DrawPdfPage(cs, p, totalPages, maxPerPage, detailH)
		contents.Add(cs.ToString)
	Next

	'Numero di oggetti del documento = 2*N + 5 (vedi schema generatore)
	Dim objCount As Int = 2 * totalPages + 5
	Dim fontBase As Int = 2 * totalPages + 3
	Dim Wpt As Double = mPageW * PT_PER_MM
	Dim Hpt As Double = mPageH * PT_PER_MM

	Dim objs As List
	objs.Initialize
	objs.Add("") 'placeholder indice 0
	'1: Catalog
	objs.Add("<< /Type /Catalog /Pages 2 0 R >>")
	'2: Pages
	Dim kidSB As StringBuilder
	kidSB.Initialize
	kidSB.Append("<< /Type /Pages /Count " & totalPages & " /Kids [")
	For p = 0 To totalPages - 1
		kidSB.Append(" " & (3 + p * 2) & " 0 R")
	Next
	kidSB.Append(" ] >>")
	objs.Add(kidSB.ToString)
	'Pagine + Content
	For p = 0 To totalPages - 1
		Dim pageId As Int = 3 + p * 2
		Dim contentId As Int = pageId + 1
		objs.Add("<< /Type /Page /Parent 2 0 R /MediaBox [0 0 " & NumberToString4(Wpt) & " " & NumberToString4(Hpt) & "] /Resources <</Font <</F1 " & fontBase & " 0 R /F2 " & (fontBase + 1) & " 0 R /F3 " & (fontBase + 2) & " 0 R>> >> /Contents " & contentId & " 0 R >>")
		Dim streamStr As String = contents.Get(p)
		objs.Add("<< /Length " & streamStr.Length & " >>" & CRLF & "stream" & CRLF & streamStr & "endstream")
	Next
	'Font: Helvetica, Helvetica-Bold, Helvetica-Oblique
	objs.Add("<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>")
	objs.Add("<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica-Bold >>")
	objs.Add("<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica-Oblique >>")

	'Assembla il documento con la tabella xref
	Dim doc As StringBuilder
	doc.Initialize
	doc.Append("%PDF-1.4" & CRLF)
	Dim offsets As List
	offsets.Initialize
	offsets.Add(0) 'indice 0 non usato
	For i = 1 To objCount
		offsets.Add(doc.Length)
		doc.Append(i & " 0 obj" & CRLF)
		doc.Append(objs.Get(i))
		doc.Append(CRLF & "endobj" & CRLF)
	Next
	Dim xrefStart As Int = doc.Length
	doc.Append("xref" & CRLF)
	doc.Append("0 " & (objCount + 1) & CRLF)
	doc.Append("0000000000 65535 f" & CRLF)
	For i = 1 To objCount
		doc.Append(PdfOffset10(offsets.Get(i)) & " 00000 n" & CRLF)
	Next
	doc.Append("trailer" & CRLF)
	doc.Append("<< /Size " & (objCount + 1) & " /Root 1 0 R >>" & CRLF)
	doc.Append("startxref" & CRLF)
	doc.Append(xrefStart & CRLF)
	doc.Append("%%EOF" & CRLF)
	Return doc.ToString
End Sub

'Formatta un offset xref come stringa di 10 cifre.
Private Sub PdfOffset10(off As Int) As String
	Dim s As String = off
	For i = 1 To 10
		If s.Length >= 10 Then Exit
		s = "0" & s
	Next
	Return s
End Sub

'Disegna il content stream di una pagina del report.
Private Sub DrawPdfPage(cs As StringBuilder, PageNum As Int, TotalPages As Int, MaxPerPage As Int, DetailH As Double) As String
	Dim startIdx As Int = PageNum * MaxPerPage
	Dim endIdx As Int = Min(startIdx + MaxPerPage, mRecords.Size)
	Dim rowNum As Int = startIdx + 1
	Dim Hpt As Double = mPageH * PT_PER_MM

	'Aggregati della pagina corrente (per i campi calcolati con ambito "page")
	Dim pageRecs As List
	pageRecs.Initialize
	For rr = startIdx To endIdx - 1
		pageRecs.Add(mRecords.Get(rr))
	Next
	ComputeCalcForElements(mPageCalc, pageRecs)

	For Each bk As String In GetBandKeys
		If bk = "detail" Then Continue
		Dim renderNow As Boolean = BandRenderedOnPage(bk, PageNum, TotalPages)
		If renderNow Then
			'Banda non-detail sempre a offset 0 nella sua posizione
			DrawPdfBand(cs, bk, Null, 0, TotalPages, rowNum)
		End If
	Next

	For rowIdx = startIdx To endIdx - 1
		Dim rec As Map = mRecords.Get(rowIdx)
		Dim rowOffset As Double = (rowIdx - startIdx) * DetailH
		DrawPdfBand(cs, "detail", rec, rowOffset, TotalPages, rowIdx + 1)
	Next
	Return "" 'il disegno avviene su cs
End Sub

Private Sub DrawPdfBand(cs As StringBuilder, BandKey As String, Rec As Map, RowOffset As Double, TotalPages As Int, RowNum As Int)
	Dim bandTop As Double = GetBandTop(BandKey)
	Dim dataRec As Map = Rec
	Select BandKey
		Case "reportHdr"
			dataRec = mRecordsTitolo
		Case "pageFtr"
			dataRec = mRecordsPie
		Case "reportFtr"
			dataRec = mRecordsFooter
	End Select
	For Each el As Map In mElements
		If el.Get("band") <> BandKey Then Continue
		DrawPdfElement(cs, el, dataRec, bandTop, RowOffset, TotalPages, RowNum)
	Next
End Sub

Private Sub DrawPdfElement(cs As StringBuilder, el As Map, Rec As Map, BandTop As Double, RowOffset As Double, TotalPages As Int, RowNum As Int)
	Dim elType As String = el.Get("type")
	Dim elX As Double = el.Get("x")
	Dim elY As Double = el.Get("y")
	Dim elW As Double = el.Get("w")
	Dim elH As Double = el.Get("h")
	Dim elSource As String = el.GetDefault("source", "")
	Dim elValue As String = el.GetDefault("value", "")
	Dim r As Double = PT_PER_MM

	Dim xp As Double = (mMarginL + elX) * r
	Dim topMm As Double = BandTop + elY + RowOffset
	Dim yTopP As Double = mPageH * r - topMm * r
	Dim boxW As Double = elW * r
	Dim boxH As Double = elH * r
	Dim yBotP As Double = yTopP - boxH

	Dim fontColor As String = el.GetDefault("fontColor", "#000000")
	Dim bgColor As String = el.GetDefault("bgColor", "")
	Dim bw As Int = el.GetDefault("borderWidth", 0)

	Select elType
		Case "text", "label"
			Dim txt As String = elValue
			If elType = "text" Then txt = GetFieldValue(elSource, elValue, Rec)
			PdfDrawText(cs, txt, xp, yTopP, boxW, boxH, el, fontColor)
		Case "sysfield"
			Dim sf As String = GetSystemField(elSource, RowNum, TotalPages)
			PdfDrawText(cs, sf, xp, yTopP, boxW, boxH, el, fontColor)
		Case "calcfield"
			Dim cfTxt As String = GetCalcValue(el)
			PdfDrawText(cs, cfTxt, xp, yTopP, boxW, boxH, el, fontColor)
		Case "hline"
			Dim lineW As Double = Max(1, bw)
			Dim ly As Double = yTopP - boxH / 2
			cs.Append(lineW & " w" & CRLF)
			cs.Append(PdfRGB(fontColor) & " RG" & CRLF)
			cs.Append(NumberToString4(xp) & " " & NumberToString4(ly) & " m " & NumberToString4(xp + boxW) & " " & NumberToString4(ly) & " l S" & CRLF)
		Case "rect"
			If bgColor <> "" Then
				cs.Append(PdfRGB(bgColor) & " rg" & CRLF)
				cs.Append(NumberToString4(xp) & " " & NumberToString4(yBotP) & " " & NumberToString4(boxW) & " " & NumberToString4(boxH) & " re f" & CRLF)
			End If
			If bw > 0 Then
				Dim rbw As Double = Max(1, bw)
				cs.Append(rbw & " w" & CRLF)
				cs.Append(PdfRGB(fontColor) & " RG" & CRLF)
				cs.Append(NumberToString4(xp) & " " & NumberToString4(yBotP) & " " & NumberToString4(boxW) & " " & NumberToString4(boxH) & " re S" & CRLF)
			End If
		Case "circle"
			If bgColor <> "" Then
				cs.Append(PdfRGB(bgColor) & " rg" & CRLF)
				PdfDrawEllipse(cs, xp, yBotP, boxW, boxH)
				cs.Append("f" & CRLF)
			End If
			If bw > 0 Or bgColor = "" Then
				Dim cbw As Double = Max(1, bw)
				cs.Append(cbw & " w" & CRLF)
				cs.Append(PdfRGB(fontColor) & " RG" & CRLF)
				PdfDrawEllipse(cs, xp, yBotP, boxW, boxH)
				cs.Append("S" & CRLF)
			End If
		Case "image"
			'Immagine reali richiedono decodifica base64 (non supportata nativamente
			'nel PDF puro); disegniamo un placeholder.
			cs.Append("0.85 g" & CRLF)
			cs.Append(NumberToString4(xp) & " " & NumberToString4(yBotP) & " " & NumberToString4(boxW) & " " & NumberToString4(boxH) & " re f" & CRLF)
			cs.Append("0.6 0.6 0.6 RG 0.5 w" & CRLF)
			cs.Append(NumberToString4(xp) & " " & NumberToString4(yBotP) & " " & NumberToString4(xp + boxW) & " " & NumberToString4(yBotP + boxH) & " m S" & CRLF)
		Case "ean13"
			PdfDrawEAN13(cs, ValoreCampo(Rec, elSource), xp, yBotP, boxW, boxH)
		Case "qrcode"
			PdfDrawQR(cs, elSource, Rec, xp, yBotP, boxW, boxH)
	End Select
End Sub

'Disegna una stringa di testo allineata orizzontalmente e centrata verticalmente
'nella sua scatola.
Private Sub PdfDrawText(cs As StringBuilder, Text As String, Xp As Double, YTopP As Double, BoxW As Double, BoxH As Double, el As Map, ColorHex As String)
	If Text = "" Then Return
	Dim fontSize As Double = el.GetDefault("fontSize", 10)
	Dim bold As Boolean = el.GetDefault("fontBold", False)
	Dim italic As Boolean = el.GetDefault("fontStyle", "normal") = "italic"
	Dim hAlign As String = el.GetDefault("hAlign", "left")

	Dim f As Int = F_HELVC
	If bold And italic Then f = F_BOLD
	If bold And Not(italic) Then f = F_BOLD
	If Not(bold) And italic Then f = F_OBLQ

	Dim tw As Double = Text.Length * fontSize * 0.52
	Dim tx As Double = Xp
	If hAlign = "center" Then
		tx = Xp + (BoxW - tw) / 2
	Else If hAlign = "right" Then
		tx = Xp + BoxW - tw
	End If

	Dim center As Double = YTopP - BoxH / 2
	Dim baseline As Double = center - fontSize * 0.33

	cs.Append("BT" & CRLF)
	cs.Append("/F" & f & " " & NumberToString4(fontSize) & " Tf" & CRLF)
	cs.Append(PdfRGB(ColorHex) & " rg" & CRLF)
	cs.Append(NumberToString4(tx) & " " & NumberToString4(baseline) & " Td" & CRLF)
	cs.Append("(" & PdfEscape(Text) & ") Tj" & CRLF)
	cs.Append("ET" & CRLF)
End Sub

'Scrive un'ellisse (usando 4 curve di Bezier) nel content stream.
Private Sub PdfDrawEllipse(cs As StringBuilder, X As Double, Y As Double, W As Double, H As Double)
	Dim k As Double = 0.5522847498
	Dim cx As Double = X + W / 2
	Dim cy As Double = Y + H / 2
	Dim rx As Double = W / 2
	Dim ry As Double = H / 2
	Dim kx As Double = k * rx
	Dim ky As Double = k * ry
	cs.Append(NumberToString4(cx) & " " & NumberToString4(cy + ry) & " m" & CRLF)
	cs.Append(NumberToString4(cx + kx) & " " & NumberToString4(cy + ry) & " " & NumberToString4(cx + rx) & " " & NumberToString4(cy + ky) & " " & NumberToString4(cx + rx) & " " & NumberToString4(cy) & " c" & CRLF)
	cs.Append(NumberToString4(cx + rx) & " " & NumberToString4(cy - ky) & " " & NumberToString4(cx + kx) & " " & NumberToString4(cy - ry) & " " & NumberToString4(cx) & " " & NumberToString4(cy - ry) & " c" & CRLF)
	cs.Append(NumberToString4(cx - kx) & " " & NumberToString4(cy - ry) & " " & NumberToString4(cx - rx) & " " & NumberToString4(cy - ky) & " " & NumberToString4(cx - rx) & " " & NumberToString4(cy) & " c" & CRLF)
	cs.Append(NumberToString4(cx - rx) & " " & NumberToString4(cy + ky) & " " & NumberToString4(cx - kx) & " " & NumberToString4(cy + ry) & " " & NumberToString4(cx) & " " & NumberToString4(cy + ry) & " c" & CRLF)
End Sub

'Disegna un codice a barre EAN-13 come rettangoli.
Private Sub PdfDrawEAN13(cs As StringBuilder, Code As String, Xp As Double, YBot As Double, BoxW As Double, BoxH As Double)
	Code = StripNonDigits(Code)
	If Code.Length < 13 Then Code = Code & "0000000000000".SubString(Code.Length)
	If Code.Length > 13 Then Code = Code.SubString2(0, 13)
	Dim enc As String = EncodeEAN13(Code)

	Dim barW As Double = BoxW / 95
	Dim barH As Double = BoxH * 0.7
	Dim fontS As Double = Max(6, BoxH * 0.18)
	cs.Append("0 g" & CRLF)
	Dim x As Double = Xp
	For i = 0 To enc.Length - 1
		If enc.CharAt(i) = "1" Then
			cs.Append(NumberToString4(x) & " " & NumberToString4(YBot) & " " & NumberToString4(barW) & " " & NumberToString4(barH) & " re f" & CRLF)
		End If
		x = x + barW
	Next
	'codice sotto le barre
	Dim cy As Double = YBot + barH + fontS * 0.3
	Dim tw As Double = Code.Length * fontS * 0.5
	cs.Append("BT /F1 " & NumberToString4(fontS) & " Tf 0 0 0 rg " & NumberToString4(Xp + (BoxW - tw) / 2) & " " & NumberToString4(cy) & " Td (" & PdfEscape(Code) & ") Tj ET" & CRLF)
End Sub

'Disegna un QR placeholder leggibile (stesso pattern del rendere HTML).
Private Sub PdfDrawQR(cs As StringBuilder, Source As String, Rec As Map, Xp As Double, YBot As Double, BoxW As Double, BoxH As Double)
	Dim qrText As String = Source
	If Source <> "" And Rec <> Null And Rec.ContainsKey(Source) Then
		qrText = ValoreCampo(Rec, Source)
	End If
	Dim cw As Double = BoxW / 21
	Dim ch As Double = BoxH / 21
	cs.Append("0 g" & CRLF)
	'Finder patterns
	PdfQRFinder(cs, Xp, YBot, cw, ch)
	PdfQRFinder(cs, Xp + 14 * cw, YBot, cw, ch)
	PdfQRFinder(cs, Xp, YBot + 14 * ch, cw, ch)
	'timing
	For i = 8 To 12
		If i Mod 2 = 0 Then
			cs.Append(NumberToString4(Xp + 6 * cw) & " " & NumberToString4(YBot + i * ch) & " " & NumberToString4(cw) & " " & NumberToString4(ch) & " re f" & CRLF)
			cs.Append(NumberToString4(Xp + i * cw) & " " & NumberToString4(YBot + 6 * ch) & " " & NumberToString4(cw) & " " & NumberToString4(ch) & " re f" & CRLF)
		End If
	Next
	Dim h As Int = StringHash(qrText)
	Dim r As Int = 10 + (h Mod 4)
	Dim c As Int = 10 + ((h / 7) Mod 4)
	If c <= r Then c = c + 1
	For i = 0 To 40
		Dim rr As Int = (r + ((h + i * 5) Mod 5)) Mod 14
		Dim cc As Int = (c + ((h + i * 11) Mod 5)) Mod 14
		If rr < 0 Then rr = rr + 14
		If cc < 0 Then cc = cc + 14
		cs.Append(NumberToString4(Xp + (8 + cc) * cw) & " " & NumberToString4(YBot + (8 + rr) * ch) & " " & NumberToString4(cw) & " " & NumberToString4(ch) & " re f" & CRLF)
	Next
End Sub

'Calcola un hash intero deterministico di una stringa (usato per il QR placeholder).
Private Sub StringHash(s As String) As Int
	Dim h As Int = 0
	For i = 0 To s.Length - 1
		h = h * 31 + Asc(s.CharAt(i))
	Next
	If h < 0 Then h = -h
	If h < 0 Then h = 1
	Return h
End Sub

Private Sub PdfQRFinder(cs As StringBuilder, X As Double, Y As Double, Cw As Double, Ch As Double)
	cs.Append(NumberToString4(X) & " " & NumberToString4(Y) & " " & NumberToString4(7 * Cw) & " " & NumberToString4(7 * Ch) & " re f" & CRLF)
	cs.Append("1 g" & CRLF)
	cs.Append(NumberToString4(X + Cw) & " " & NumberToString4(Y + Ch) & " " & NumberToString4(5 * Cw) & " " & NumberToString4(5 * Ch) & " re f" & CRLF)
	cs.Append("0 g" & CRLF)
	cs.Append(NumberToString4(X + 2 * Cw) & " " & NumberToString4(Y + 2 * Ch) & " " & NumberToString4(3 * Cw) & " " & NumberToString4(3 * Ch) & " re f" & CRLF)
End Sub

'Converte un colore esadecimale "#RRGGBB" in "r g b" (0..1) per PDF.
Private Sub PdfRGB(HexColor As String) As String
	HexColor = HexColor.Trim.Replace("#", "")
	For i = 1 To 6
		If HexColor.Length >= 6 Then Exit
		HexColor = "0" & HexColor
	Next
	Dim rr As Double = HexByte(HexColor.SubString2(0, 2)) / 255
	Dim gg As Double = HexByte(HexColor.SubString2(2, 4)) / 255
	Dim bb As Double = HexByte(HexColor.SubString2(4, 6)) / 255
	Return NumberToString4(rr) & " " & NumberToString4(gg) & " " & NumberToString4(bb)
End Sub

Private Sub HexByte(Hex2 As String) As Int
	Return HexDigit(Hex2.CharAt(0)) * 16 + HexDigit(Hex2.CharAt(1))
End Sub

Private Sub HexDigit(c As String) As Int
	Dim ch As Int = Asc(c)
	If ch >= 48 And ch <= 57 Then Return ch - 48
	If ch >= 65 And ch <= 70 Then Return ch - 55
	If ch >= 97 And ch <= 102 Then Return ch - 87
	Return 0
End Sub

'Scapa i caratteri speciali per un literal di stringa PDF.
Private Sub PdfEscape(Text As String) As String
	Text = Text.Replace("\", "\\")
	Text = Text.Replace("(", "\(")
	Text = Text.Replace(")", "\)")
	Return Text
End Sub

#End Region

#Region Barcode e QR

'Rimuove tutti i caratteri non numerici da una stringa (puro B4X, cross-platform).
Private Sub StripNonDigits(s As String) As String
	Dim sb As StringBuilder
	sb.Initialize
	For i = 0 To s.Length - 1
		Dim ch As String = s.CharAt(i)
		If IsNumberChar(ch) Then sb.Append(ch)
	Next
	Return sb.ToString
End Sub

Private Sub IsNumberChar(ch As String) As Boolean
	Dim c As Int = Asc(ch)
	Return c >= 48 And c <= 57
End Sub

Private Sub RenderEAN13(Code As String, W As Double, H As Double) As String
	Code = StripNonDigits(Code)
	If Code.Length < 13 Then Code = Code & "0000000000000".SubString(Code.Length)
	If Code.Length > 13 Then Code = Code.SubString2(0, 13)

	Dim enc As String = EncodeEAN13(Code)

	Dim svgW As Int = Max(60, W)
	Dim svgH As Int = Max(30, H)
	Dim barW As Double = Max(1, svgW / 95)

	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<svg width='" & svgW & "' height='" & svgH & "' xmlns='http://www.w3.org/2000/svg'>")
	sb.Append("<rect width='" & svgW & "' height='" & svgH & "' fill='#fff'/>")
	Dim x As Double = 5
	For i = 0 To enc.Length - 1
		If enc.CharAt(i) = "1" Then
			sb.Append("<rect x='" & NumberToString(x) & "' y='0' width='" & NumberToString(barW) & "' height='" & NumberToString(svgH - 16) & "' fill='#000'/>")
		End If
		x = x + barW
	Next
	sb.Append("<text x='" & (svgW / 2) & "' y='" & (svgH - 5) & "' font-size='10' font-family='Arial' text-anchor='middle'>" & Code & "</text>")
	sb.Append("</svg>")
	Return sb.ToString
End Sub

'Codifiche a barre EAN-13 (stringhe binarie standard).
Private Sub EanL(d As Int) As String
	Dim codes As List
	codes.Initialize
	codes.AddAll(Array("0001101","0011001","0010011","0111101","0100011","0110001","0101111","0111011","0110111","0001011"))
	Return codes.Get(d)
End Sub

Private Sub EG(d As Int) As String
	Dim codes As List
	codes.Initialize
	codes.AddAll(Array("0100111","0110011","0011011","0100001","0011101","0111001","0000101","0010001","0001001","0010111"))
	Return codes.Get(d)
End Sub

Private Sub ER(d As Int) As String
	Dim codes As List
	codes.Initialize
	codes.AddAll(Array("1110010","1100110","1101100","1000010","1011100","1001110","1010000","1000100","1001000","1110100"))
	Return codes.Get(d)
End Sub

'Tabella di parita' per la prima cifra: stringa di 6 caratteri L/G.
Private Sub EPari(d As Int) As String
	Dim parity As List
	parity.Initialize
	parity.AddAll(Array("LLLLLL","LLGLGG","LLGGLG","LLGGGL","LGLLGG","LGGLLG","LGGGLL","LGLGLG","LGLGGL","LGGLGL"))
	Return parity.Get(d)
End Sub

Private Sub EncodeEAN13(Code As String) As String
	Dim d0 As Int = Asc(Code.CharAt(0)) - 48
	Dim pat As String = "101"
	Dim parity As String = EPari(d0)
	For i = 1 To 6
		Dim n As Int = Asc(Code.CharAt(i)) - 48
		If parity.CharAt(i - 1) = "L" Then
			pat = pat & EanL(n)
		Else
			pat = pat & EG(n)
		End If
	Next
	pat = pat & "01010"
	For i = 7 To 12
		Dim n As Int = Asc(Code.CharAt(i)) - 48
		pat = pat & ER(n)
	Next
	pat = pat & "101"
	Return pat
End Sub

Private Sub RenderQR(Texto As String, W As Double, H As Double) As String
	Dim cellW As Double = W / 21
	Dim cellH As Double = H / 21
	Dim svgW As Double = W
	Dim svgH As Double = H

	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<svg width='" & NumberToString(svgW) & "' height='" & NumberToString(svgH) & "' xmlns='http://www.w3.org/2000/svg'>")
	sb.Append("<rect width='" & NumberToString(svgW) & "' height='" & NumberToString(svgH) & "' fill='#fff'/>")
	DrawFinder(sb, 0.0, 0.0, cellW, cellH)
	DrawFinder(sb, 14.0 * cellW, 0.0, cellW, cellH)
	DrawFinder(sb, 0.0, 14.0 * cellH, cellW, cellH)
	'Timing patterns
	For i = 8 To 12
		Dim fillC As String
		If i Mod 2 = 0 Then fillC = "#000" Else fillC = "#fff"
		sb.Append("<rect x='" & NumberToString(6.0 * cellW) & "' y='" & NumberToString(i * cellH) & "' width='" & NumberToString(cellW) & "' height='" & NumberToString(cellH) & "' fill='" & fillC & "'/>")
		sb.Append("<rect x='" & NumberToString(i * cellW) & "' y='" & NumberToString(6.0 * cellH) & "' width='" & NumberToString(cellW) & "' height='" & NumberToString(cellH) & "' fill='" & fillC & "'/>")
	Next
	'Pattern dati deterministico calcolato dall'hash del testo.
	sb.Append(QrData(Texto, cellW, cellH))
	sb.Append("</svg>")
	Return sb.ToString
End Sub

'Genera i rect SVG dei dati del pattern QR calcolato dall'hash del testo.
Private Sub QrData(Texto As String, cW As Double, cH As Double) As String
	Dim h As Int = StringHash(Texto)
	Dim r As Int = 10 + (h Mod 4)
	Dim c As Int = 10 + ((h / 7) Mod 4)
	If c <= r Then c = c + 1
	Dim sb As StringBuilder
	sb.Initialize
	For i = 0 To 40
		Dim rr As Int = (r + ((h + i * 5) Mod 5)) Mod 14
		Dim cc As Int = (c + ((h + i * 11) Mod 5)) Mod 14
		If rr < 0 Then rr = rr + 14
		If cc < 0 Then cc = cc + 14
		sb.Append("<rect x='" & NumberToString((8 + cc) * cW) & "' y='" & NumberToString((8 + rr) * cH) & "' width='" & NumberToString(cW) & "' height='" & NumberToString(cH) & "' fill='#000'/>")
	Next
	Return sb.ToString
End Sub

Private Sub DrawFinder(sb As StringBuilder, x As Double, y As Double, cw As Double, ch As Double)
	sb.Append("<rect x='" & NumberToString(x) & "' y='" & NumberToString(y) & "' width='" & NumberToString(7 * cw) & "' height='" & NumberToString(7 * ch) & "' fill='#000'/>")
	sb.Append("<rect x='" & NumberToString(x + cw) & "' y='" & NumberToString(y + ch) & "' width='" & NumberToString(5 * cw) & "' height='" & NumberToString(5 * ch) & "' fill='#fff'/>")
	sb.Append("<rect x='" & NumberToString(x + 2 * cw) & "' y='" & NumberToString(y + 2 * ch) & "' width='" & NumberToString(3 * cw) & "' height='" & NumberToString(3 * ch) & "' fill='#000'/>")
End Sub

#End Region
