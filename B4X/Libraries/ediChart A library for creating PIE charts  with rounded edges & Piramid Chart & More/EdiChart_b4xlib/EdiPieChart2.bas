B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
'Custom View class
'version: 3.00
'#DesignerProperty: Key: FirstColor, DisplayName: First Color, FieldType: Color, DefaultValue: #FFA9D8FF, Description:
'#DesignerProperty: Key: SecondColor, DisplayName: Second Color, FieldType: Color, DefaultValue: 0xFF004884, Description:
'#DesignerProperty: Key: ColorEmpty, DisplayName: Color Empty, FieldType: Color, DefaultValue: 0xFFE4DADA, Description:
#DesignerProperty: Key: StrokeWidth, DisplayName: Stroke Width, FieldType: Int, DefaultValue: 10, Description:
'#DesignerProperty: Key: Duration, DisplayName: Duration From 0 To 100, FieldType: Int, DefaultValue: 3000, Description: Milliseconds
#DesignerProperty: Key: PieStyle, DisplayName: Pie Style, FieldType: String, DefaultValue: FLAT, List: FLAT|ROUND
#DesignerProperty: Key: Legend, DisplayName: Legend, FieldType: String, DefaultValue: YES, List: YES|NO
#DesignerProperty: Key: Percent, DisplayName: Perc, FieldType: String, DefaultValue: YES, List: YES|NO
#DesignerProperty: Key: Altro, DisplayName: Altro, FieldType: String, DefaultValue: Altro



Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI
	Private mLbl As B4XView
	Private cx, cy, radius As Float
	Private stroke As Float
	Private mBase As B4XView
	Private currentValue As Float
	Private DurationFromZeroTo100 As Int
	Private bc As BitmapCreator
	Private emptyBrush As BCBrush
	Private Ombra As BCBrush
	
	Private fullBrush As BCBrush
	Private TransparentBrush As BCBrush
	Private iv As B4XView
	Private clr1, clr2 As Int
	Private LoopIndex As Int
	
	Private ListaColori As List
	Private Brush As List
	Private ValoriList As List
	Private Totale As Float
	
	Private MaxElementi As Int=12
	
	Private DatiGrafico As List
	Private AngoloAttuale As Float
	Private IndexFetta As Int
	Private tmrAnimazione As Timer
	Private Raggio As Float
	#if b4j
	Private Pannello As Pane
	Private PanelLegenda As Pane
	#else 
	Private Pannello As Panel
	Private PanelLegenda As Panel	
	
	#end if
	Private VisualizzaLegenda As Boolean
	Private Percentuale As Boolean
	Private StileGrafico As String
	Private TextAltro As String
	Private percentualeMax As Float
	
	Type Elemento (Nome As String, Valore As Double)
	Type Grafico (Nome As String, Valore As Double, Percentuale As Double, Colore As Int)
	
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	ListaColori.Initialize
	ValoriList.Initialize
	Brush.Initialize

	
	ListaColori.Add(0xfff45559)'rosso
	ListaColori.Add(0xffffa14f)'arancio
	ListaColori.Add(0xffffd54f)'giallo
	ListaColori.Add(0xff2196f3)'blu
	ListaColori.Add(0xff465a65)'nero
	ListaColori.Add(0xff5cb774)'verde
	ListaColori.Add(0xff1aa3b5)'verde acqua
	ListaColori.Add(0xfff98882)
	ListaColori.Add(0xff00d4f8)
	ListaColori.Add(0xff02ebdc)
	ListaColori.Add(0xfffea058)
	ListaColori.Add(0xffb891fc)
	ListaColori.Add(xui.Color_LightGray)
	
	
End Sub
'Sub RndColor(index As Int) As Int
'	Dim colori() As Int = Array As Int(xui.Color_Red, xui.Color_Blue, xui.Color_Green, xui.Color_Orange, xui.Color_Purple, xui.Color_Yellow, xui.Color_Cyan)
'	If index >= colori.Length Then
'		Return Colors.RGB(Rnd(50,200), Rnd(50,200), Rnd(50,200))
'	Else
'		Return colori(index)
'	End If
'End Sub



Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	#IF B4J
	mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top, mBase.Width,  mBase.Height)
	#ELSE
		mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top, mBase.Width,mBase.Height)' Min(mBase.Width, mBase.Height), Min(mBase.Width, mBase.Height))
	
	#End If
	
	
	Dim clrEmpty As Int = xui.PaintOrColorToColor(Props.Get("ColorEmpty"))
	'clr1 = xui.PaintOrColorToColor(Props.Get("FirstColor"))
	'clr2 = xui.PaintOrColorToColor(Props.Get("SecondColor"))
	stroke = DipToCurrent(Props.Get("StrokeWidth"))
	
	
	If Props.Get("Legend")="YES" Then
		VisualizzaLegenda=True
	Else
		VisualizzaLegenda=False
	End If
	
	If Props.Get("Percent")="YES" Then
		Percentuale=True
	Else
		Percentuale=False
	End If
	
	TextAltro= Props.Get("Altro")
	
	StileGrafico= Props.Get("PieStyle")
	
	
	
	DurationFromZeroTo100 = Props.Get("Duration")
	mLbl = Lbl
	cx = Min(mBase.Width, mBase.Height) / 2
	cy = Min(mBase.Width, mBase.Height) / 2
	
	'PanelLegenda.Color=Colors.Blue
	'Log("BLU")
	radius = cx - 10dip
	mLbl.SetTextAlignment("CENTER", "CENTER")
	Dim iiv As ImageView
	iiv.Initialize("")
	iv = iiv
	mBase.AddView(iv, 0, 0, mBase.Width, mBase.Width)
	mBase.AddView(mLbl, 0,  Min(mBase.Width, mBase.Height) / 2 - 20dip,  Min(mBase.Width, mBase.Height), 40dip)
	ResetBC
	emptyBrush = bc.CreateBrushFromColor(clrEmpty)
	Ombra = bc.CreateBrushFromColor(0x32A9A9A9)'grigio trasparente
	Pannello.Initialize("")
	mBase.AddView(Pannello, 0, 0, mBase.Width, mBase.Width)
	PanelLegenda.Initialize("")
	'mBase.AddView(PanelLegenda,(cx+10dip)*2, 0, mBase.Width-cx, mBase.Height)
	mBase.AddView(PanelLegenda,mBase.Width/3*1.8, 0, mBase.Width, mBase.Height)
	
	InitColor
	TransparentBrush = bc.CreateBrushFromColor(xui.Color_Transparent)
	DrawValue(currentValue)
End Sub

Private Sub ResetBC
	bc.Initialize(iv.Width, iv.Width)
'	Dim g As BitmapCreator
'	g.Initialize(bc.mWidth, bc.mHeight)
'	Dim r As B4XRect
'	r.Initialize(0, 0, bc.mWidth, 2) 'ignore
'	bc.FillGradient(Array As Int(clr1, clr2), r, "LEFT_RIGHT")
'	For y = 0 To g.mHeight - 1
'		For x = 0 To g.mWidth - 1
'			Dim angle As Float = ATan2D(y - cy, x - cx) + 90.5
'			If angle < 0 Then angle = angle + 360
'			g.CopyPixel(bc, bc.mWidth * angle / 360, 0, x, y)
'		Next
'	Next
'	fullBrush = bc.CreateBrushFromBitmapCreator(g)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	Dim w As Int = Min(Width, Height)
	cx = w / 2
	cy = w / 2
	radius = cx - 10dip
	iv.SetLayoutAnimated(0, 0, 0, w, w)
	PanelLegenda.SetLayoutAnimated(0, Width/3*1.8, 0, w, w)
	'Log("RIDIMENSIONA")
	#IF B4I
		'PanelLegenda.SetLayoutAnimated(0,w+10dip,0,w/2,Height)
	#End If
	'PanelLegenda.Color=Colors.Red
	bc.Initialize(iv.Width, iv.Width)
	If bc.mWidth <> w Then
		ResetBC
	End If
	mLbl.SetLayoutAnimated(0, 0, cy - 20dip, w, 40dip)
End Sub

'Public Sub setValue(NewValue As Float)
'	AnimateValueTo(NewValue)
'End Sub
'
'Public Sub getValue As Float
'	Return currentValue
'End Sub


Sub Grafico(lista As List,Ordine As Boolean)
	
    
	Dim listaFinale As List = CalcolaGrafico(lista,Ordine )
    
	' Stampa per controllo
'	For Each g As Grafico In listaFinale
'		Log($"${g.Nome} - ${g.Valore} - ${NumberFormat(g.Percentuale,1,1)}% - Colore=${g.Colore}"$)
'	Next
	
	DisegnaGraficoTorta(listaFinale)
End Sub

Sub DisegnaGraficoTorta( Lista As List)
	'disegno in base a lista secca calcolata
	bc.DrawRect2(bc.TargetRect, TransparentBrush, True, 0)
	mLbl.Text = $"$1.0{Totale}"$
	Dim angoloStart As Float = -90
	Dim i As Int=0
	Dim r As Float = radius

	For Each g As Grafico In Lista
		
		Dim sweepAngle As Float = 360 * (g.Percentuale / 100)

		'cvs.DrawArc(cx - r, cy - r, cx + r, cy + r, angoloStart, sweepAngle, True, g.Colore, True)
		bc.DrawArc2(cx, cy, radius, Brush.Get(I), False, stroke, angoloStart, sweepAngle)
		
		If StileGrafico="ROUND" Then
'			Log(AngoloAttuale)
			bc.DrawCircle((cx)+(radius-stroke/2)*CosD(angoloStart),(cy)+(radius-stroke/2)*SinD(angoloStart),stroke/2.05,ListaColori.Get(i),True,0)
		End If
		
		angoloStart = angoloStart + sweepAngle
		i=i+1
	Next
	If StileGrafico="ROUND" Then
'			Log(AngoloAttuale)
		angoloStart=-90
		bc.DrawCircle((cx)+(radius-stroke/2)*CosD(angoloStart),(cy)+(radius-stroke/2)*SinD(angoloStart),stroke/2.05,ListaColori.Get(0),True,0)
	End If
	bc.SetBitmapToImageView(bc.Bitmap, iv)
End Sub



Sub CalcolaGrafico(ListaInput As List,ordine As Boolean) As List
	'serve per ridisegnare il grafico
	percentualeMax=0
	Dim ListaGrafico As List
	ListaGrafico.Initialize

	' Ordina la lista in base al Valore (decrescente)
	'ListaInput.SortType("Valore", False)
    If ordine=True Then
		ListaInput = OrdinaPerValore(ListaInput)
	End If
	' Calcola totale
	'Dim Totale As Double = 0
	Totale=0
	For Each e As Elemento In ListaInput
		Totale = Totale + e.Valore
	Next
    
	Dim AltroValore As Double = 0
    Dim perc As Double=0
	
	For i = 0 To ListaInput.Size - 1
		Dim e As Elemento = ListaInput.Get(i)
        
		If i < MaxElementi Or ListaInput.Size <= MaxElementi+1 Then
			Dim g As Grafico
			g.Initialize
			g.Nome = e.Nome
			g.Valore = e.Valore
			g.Percentuale = (e.Valore / Totale) * 100
			perc=perc+g.Percentuale
			If g.Percentuale>percentualeMax Then
				percentualeMax=g.Percentuale
			End If
			g.Colore =  ListaColori.Get(i)
			ListaGrafico.Add(g)
		Else
			AltroValore = AltroValore + e.Valore
		End If
	Next
    
	' Aggiunge la voce Altro se serve
	If ListaInput.Size > MaxElementi+1 Then
		Dim g As Grafico
		g.Initialize
		g.Nome = TextAltro
		g.Valore = AltroValore
		g.Percentuale = 100-perc'(AltroValore / Totale) * 100
		If g.Percentuale>percentualeMax Then
			percentualeMax=g.Percentuale
		End If
		g.Colore = xui.Color_LightGray
		ListaGrafico.Add(g)
	End If
    
	Return ListaGrafico
End Sub

'Private Sub AnimateValueTo(NewValue As Float)
'	LoopIndex = LoopIndex + 1
'	Dim MyIndex As Int = LoopIndex
'	Dim n As Long = DateTime.Now
'	Dim duration As Int = Abs(currentValue - NewValue) / 100 * DurationFromZeroTo100 + 1000
'	Dim start As Float = currentValue
'	currentValue = NewValue
'	Dim tempValue As Float
'	Do While DateTime.Now < n + duration
'		tempValue = ValueFromTimeEaseInOut(DateTime.Now - n, start, NewValue - start, duration)
'		DisegnaGrafico(tempValue)
'		Sleep(10)
'		If MyIndex <> LoopIndex Then Return
'	Loop
'	DisegnaGrafico(currentValue)
'End Sub

'quartic easing in/out from http://gizma.com/easing/
Private Sub ValueFromTimeEaseInOut(Time As Float, Start As Float, ChangeInValue As Float, Duration As Int) As Float
	Time = Time / (Duration / 2)
	If Time < 1 Then
		Return ChangeInValue / 2 * Time * Time * Time * Time + Start
	Else
		Time = Time - 2
		Return -ChangeInValue / 2 * (Time * Time * Time * Time - 2) + Start
	End If
End Sub

Private Sub DrawValue(Value As Float)
	bc.DrawRect2(bc.TargetRect, TransparentBrush, True, 0)
	mLbl.Text = $"$1.0{Value}"$
	Dim startAngle = -90, sweepAngle = Value / 100 * 360 As Float
	
	bc.DrawArc2(cx-2, cy+2, radius, Ombra, False, stroke, startAngle,360)
	
	bc.DrawArc2(cx, cy, radius, emptyBrush, False, stroke, startAngle, -(360 - sweepAngle))
	'bc.DrawCircle((cx)+(radius-stroke/2)*CosD(startAngle),(cy)+(radius-stroke/2)*SinD(startAngle),stroke/2,clr1,True,0)
	'bc.DrawArc2(cx, cy, radius, fullBrush, False, stroke, startAngle, sweepAngle)
	
	'legge il colore alla fine del brush per disegnare la pallina
	'Dim colore As Int
	'colore=bc.GetColor(cx+(radius-stroke/2)*CosD(sweepAngle-91),cy+(radius-stroke/2)*SinD(sweepAngle-91))
	
	'bc.DrawCircle(cx+(radius-stroke/2)*CosD(sweepAngle-90),cy+(radius-stroke/2)*SinD(sweepAngle-90),stroke/2,colore,True,0)
	
	
	
	
	bc.SetBitmapToImageView(bc.Bitmap, iv)
End Sub

private Sub InitColor
	Dim i As Int
	Brush.Initialize
	Brush.Clear
	For i=0 To MaxElementi
		Brush.Add(bc.CreateBrushFromColor(ListaColori.Get(i)))
	Next	
End Sub

Public Sub setColors(NewValue As List)
	ListaColori=NewValue
	InitColor
End Sub

Public Sub getColors As List
	Return ListaColori
End Sub


private Sub DimezzaSaturazione(coloreARGB As Int) As Int
	Dim r, g, b As Float
	r = Bit.And(Bit.ShiftRight(coloreARGB, 16), 0xFF) / 255
	g = Bit.And(Bit.ShiftRight(coloreARGB, 8), 0xFF) / 255
	b = Bit.And(coloreARGB, 0xFF) / 255

	Dim maxV As Float = Max(r, Max(g, b))
	Dim minV As Float = Min(r, Min(g, b))
	Dim delta As Float = maxV - minV

	Dim h, s, v As Float
	v = maxV

	If maxV = 0 Then
		s = 0
	Else
		s = delta / maxV
	End If

	' Calcolo hue
	If delta = 0 Then
		h = 0
	Else If maxV = r Then
		h = (g - b) / delta
	Else If maxV = g Then
		h = 2 + (b - r) / delta
	Else
		h = 4 + (r - g) / delta
	End If

	h = h * 60
	If h < 0 Then h = h + 360

	' Dimezza saturazione
	s = s / 2

	' Converti HSV -> RGB
	Dim i As Int = Floor(h / 60)
	Dim f As Float = h / 60 - i
	Dim p As Float = v * (1 - s)
	Dim q As Float = v * (1 - s * f)
	Dim t As Float = v * (1 - s * (1 - f))

	Select i Mod 6
		Case 0
			r = v: g = t: b = p
		Case 1
			r = q: g = v: b = p
		Case 2
			r = p: g = v: b = t
		Case 3
			r = p: g = q: b = v
		Case 4
			r = t: g = p: b = v
		Case 5
			r = v: g = p: b = q
	End Select	
	Return xui.Color_ARGB(255, r * 255, g * 255, b * 255)
End Sub

Public Sub setValori(NewValue As List)
	ValoriList=NewValue
	'Totale=0
	For i=0 To ValoriList.Size-1
		'Totale=Totale+ValoriList.Get(i)
	Next	
	InitColor
	currentValue=0
	'AnimateValueTo(100)
	'DisegnaGrafico(100)
End Sub

Public Sub getValori As List
	Return ValoriList
End Sub

Sub DisegnaGrafico(Value) As Float
	bc.DrawRect2(bc.TargetRect, TransparentBrush, True, 0)
	mLbl.Text = $"$1.0{Totale}"$
	Dim startAngle = -90, sweepAngle = Value / 100 * 360 As Float
	Dim rotazione As Float
	bc.DrawArc2(cx-2, cy+2, radius, Ombra, False, stroke, startAngle,360)	
	Dim DIVISIONE As Float
	'Log(Totale)
	'DIVISIONE=Totale/360
	Log(DIVISIONE)
	'DISEGNO NON SELEZIONATO
	bc.DrawArc2(cx, cy, radius, emptyBrush, False, stroke, startAngle, -(360 - sweepAngle))
	
	'pallino iniziale
	
	For I=0 To ValoriList.Size-1
		If I=0 Then
		Log(I)
		
		Log(startAngle)
		
		Log(sweepAngle)
		rotazione=sweepAngle-startAngle-ValoriList.Get(I)/DIVISIONE-90
		Log("Rotazione:" & rotazione)
		bc.DrawCircle((cx)+(radius-(stroke-i)/2)*CosD(startAngle),(cy)+(radius-(stroke-i)/2)*SinD(startAngle),(stroke-i)/2,ListaColori.Get(I),True,0)
		bc.DrawArc2(cx, cy, radius-I*10, Brush.Get(I), False, (stroke-i), startAngle, rotazione)
		'legge il colore alla fine del brush per disegnare la pallina
		'Dim colore As Int
		'colore=bc.GetColor(cx+(radius-stroke/2)*CosD(sweepAngle-91),cy+(radius-stroke/2)*SinD(sweepAngle-91))	
		bc.DrawCircle(cx+(radius-(stroke-i)/2)*CosD(sweepAngle),cy+(radius-(stroke-i)/2)*SinD(sweepAngle),(stroke-i)/2,ListaColori.Get(I),True,0)
		startAngle=startAngle+(ValoriList.Get(I)/DIVISIONE)
		'bc.SetBitmapToImageView(bc.Bitmap, iv)
		'Sleep(10)
		End If
	Next 
	
	
	
	bc.SetBitmapToImageView(bc.Bitmap, iv)
End Sub


private Sub OrdinaPerValore(Lista As List) As List
	Dim arr(Lista.Size) As Elemento
	For i = 0 To Lista.Size - 1
		arr(i) = Lista.Get(i)
	Next
    
	' Ordinamento a bolle (bubble sort) semplice, dal maggiore al minore
	For i = 0 To arr.Length - 2
		For j = i + 1 To arr.Length - 1
			If arr(j).Valore > arr(i).Valore Then
				Dim temp As Elemento = arr(i)
				arr(i) = arr(j)
				arr(j) = temp
			End If
		Next
	Next
    
	' Ricostruisce la lista ordinata
	Dim Ordinata As List
	Ordinata.Initialize
	For i = 0 To arr.Length - 1
		Ordinata.Add(arr(i))
	Next
    
	Return Ordinata
End Sub


	#if b4j
private Sub MostraLegenda(pnlLegenda As Pane, Lista As List)
	pnlLegenda.RemoveAllNodes
	#else
private Sub MostraLegenda(pnlLegenda As Panel, Lista As List)
	pnlLegenda.RemoveAllViews
	#End If
    #If B4A Or B4i
	pnlLegenda.Color = xui.Color_Transparent
	Dim canva As B4XCanvas
	canva.Initialize(pnlLegenda)
    #End If
    #If B4J
    Dim canva As B4XCanvas
    canva.Initialize(pnlLegenda)
    #End If

	If VisualizzaLegenda = False Then Return

	Dim dimensione As Float = pnlLegenda.Height / Lista.Size
	Dim top As Float = 0
	Dim i As Int = 0

	For Each g As Grafico In Lista
		Dim cerchioRaggio As Float = dimensione / 4
		Dim cerchioCX As Float = cerchioRaggio + 4dip ' distanza dal bordo
		Dim cerchioCY As Float = top + dimensione / 2

		' Etichetta (testo)
		Dim lbl As Label
		lbl.Initialize("")
		lbl.Text = $"${g.Nome}: ${NumberFormat(g.Percentuale, 1, 1)}%"$

		' Altezza stimata del font (approssimata per tutti i B4X, migliorabile con StringMeasure)
		Dim fontH As Float = 18dip
		Dim lblTop As Float = top + (dimensione - fontH) / 2

        #If B4J
        pnlLegenda.AddNode(lbl, cerchioCX * 2.5, lblTop, pnlLegenda.Width - cerchioCX * 2, fontH)
        #Else
		pnlLegenda.AddView(lbl, cerchioCX * 2.5, lblTop, pnlLegenda.Width - cerchioCX * 2, fontH)
		'lbl.TextColor = g.Colore
        #End If

		' Cerchio
		canva.DrawCircle(cerchioCX, cerchioCY, cerchioRaggio, ListaColori.Get(i), False, 4dip)

		top = top + dimensione
		i = i + 1
	Next
End Sub

private Sub AvviaAnimazioneTorta(lista As List)
	DatiGrafico = lista
	

	AngoloAttuale = -90
	IndexFetta = 0

	If tmrAnimazione.IsInitialized = False Then
		tmrAnimazione.Initialize("tmrAnimazione", 10)
	End If
	'If VisualizzaLegenda=True Then
	MostraLegenda(PanelLegenda,DatiGrafico)
	'End If
	tmrAnimazione.Enabled = True
End Sub

private Sub tmrAnimazione_Tick
	'bc.DrawRect2(bc.TargetRect, TransparentBrush, True, 0)
	Dim canvas As B4XCanvas
	canvas.Initialize(Pannello)
	'canvas.Initialize(mBase.GetView(0))
	
	If IndexFetta >= DatiGrafico.Size Then
		If StileGrafico="ROUND" Then
			'Log("qui")
			AngoloAttuale=-90
			'Log(AngoloAttuale)
			bc.DrawCircle((cx)+(radius-stroke/2)*CosD(AngoloAttuale),(cy)+(radius-stroke/2)*SinD(AngoloAttuale),stroke/2.05,ListaColori.Get(0),True,0)
			bc.SetBitmapToImageView(bc.Bitmap, iv)
		'MostraLegenda(PanelLegenda,DatiGrafico)
		End If
		mLbl.Text = $"$1.0{Totale}"$
		tmrAnimazione.Enabled = False
		Return
	End If
	Raggio=cy-20dip
	
	Dim g As Grafico = DatiGrafico.Get(IndexFetta)
	Dim sweepTotale As Float = 360 * (g.Percentuale / 100)

	' Disegniamo a piccoli step
	Dim sweepStep As Float = 5
	If sweepStep > sweepTotale Then sweepStep = sweepTotale

	' Disegna un pezzo
	'CanvasTorta.DrawArc(cx - Raggio, cy - Raggio, cx + Raggio, cy + Raggio, AngoloAttuale, sweepStep, True, g.Colore, True)
	
	If AngoloAttuale>265 Then
		'non disegno perche ho fatto il giro
		'Log("Superato")
	Else
		
		
		bc.DrawArc2(cx, cy, radius, Brush.Get(IndexFetta), False, stroke, AngoloAttuale, sweepStep)
		If StileGrafico="ROUND" Then
'			Log(AngoloAttuale)
			bc.DrawCircle((cx)+(radius-stroke/2)*CosD(AngoloAttuale),(cy)+(radius-stroke/2)*SinD(AngoloAttuale),stroke/2.05,ListaColori.Get(IndexFetta),True,0)
		End If
		
	End If
	
	
	
	
	AngoloAttuale = AngoloAttuale + sweepStep
	' Se abbiamo finito di disegnare questa fetta, passiamo alla prossima
	If AngoloAttuale >= -90 + 360 * SommaPercentuali(IndexFetta + 1) Then
		If Percentuale=True Then
			Dim angoloMezzo As Float = AngoloAttuale - sweepTotale + sweepTotale / 2
			Dim angoloCorretto As Float = angoloMezzo '- 90 ' Corregge per partire da mezzogiorno
			Dim rad As Float = angoloCorretto * cPI / 180

			Dim etX As Float = cx + Cos(rad) * (Raggio * 0.8)
			Dim etY As Float = cy + Sin(rad) * (Raggio * 0.8)

			' Calcola rettangolo centrato attorno al punto
			Dim text As String = NumberFormat(g.Percentuale, 1, 1) & "%"
			Dim Font1 As B4XFont = xui.CreateDefaultFont(12)
			Dim textWidth As Float = canvas.MeasureText(text, Font1).Width
			Dim textHeight As Float = 15dip'font.ToNativeFont.Size

			Dim rect As B4XRect
			rect.Initialize(etX - textWidth / 2, etY - textHeight / 2, etX + textWidth / 2, etY + textHeight / 2)

			canvas.DrawText(text, rect.CenterX, rect.CenterY, Font1, xui.Color_Black, "CENTER")
		End If
		IndexFetta = IndexFetta + 1
	End If
	
	bc.SetBitmapToImageView(bc.Bitmap, iv)
	'Panel1.Invalidate
End Sub

private Sub SommaPercentuali(maxIndex As Int) As Float
	Dim somma As Float = 0
	For i = 0 To maxIndex - 1
		Dim g As Grafico = DatiGrafico.Get(i)
		somma = somma + g.Percentuale
	Next
	Return somma / 100 ' ritorna in [0..1]
End Sub

Sub GraficoAnimato(Lista As List,Order As Boolean)
	
	Dim dati As List = CalcolaGrafico(Lista,Order)
	'bc.Initialize(iv.Width, iv.Width)
	TransparentBrush = bc.CreateBrushFromColor(xui.Color_Transparent)
	bc.DrawRect2(bc.TargetRect, TransparentBrush, True, 0)
	#if b4j
	Pannello.RemoveAllNodes
	PanelLegenda.RemoveAllNodes
	#else
	Pannello.RemoveAllViews
	PanelLegenda.RemoveAllViews
	Pannello.Color=xui.Color_Transparent
	#end if	
	AvviaAnimazioneTorta( dati)
End Sub