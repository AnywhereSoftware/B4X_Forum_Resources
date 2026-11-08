B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
#DesignerProperty: Key: PieStyle, DisplayName: Pie Style, FieldType: String, DefaultValue: FLAT, List: FLAT|ROUND
#DesignerProperty: Key: Legend, DisplayName: Legend, FieldType: String, DefaultValue: YES, List: YES|NO
#DesignerProperty: Key: Percent, DisplayName: Perc, FieldType: String, DefaultValue: YES, List: YES|NO
#DesignerProperty: Key: Altro, DisplayName: Altro, FieldType: String, DefaultValue: Altro
#DesignerProperty: Key: Space, DisplayName: Space, FieldType: Int, DefaultValue: 10


Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Private mLbl As B4XView
	Private cx, cy, radius As Float
	Private stroke As Float
	Private mBase As B4XView
	Public Tag As Object
	Private VisualizzaLegenda As Boolean
	Private Percentuale As Boolean
	Private StileGrafico As String
	Private TextAltro As String
	
	Private ListaColori As List
	Private Brush As List
	Private BrushChiaro As List
	Private BrushScuro As List
	Private BrushScuro2 As List
	Private Spazio As Float
	Private SpazioAnimato As Float
	
	
	Private ValoriList As List
	Private Totale As Float
	
	Private MaxElementi As Int=12
	#if b4j
	Private Pannello As Pane
	Private PanelLegenda As Pane
	#else 
	Private Pannello As Panel
	Private PanelLegenda As Panel	
	
	#end if
	Private iv As B4XView
	Private bc As BitmapCreator
	Private emptyBrush As BCBrush
	Private Ombra As BCBrush
	Private TransparentBrush As BCBrush
	Private listaFinale As List
	Private tmrAnimazione As Timer
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	ListaColori.Initialize
	ValoriList.Initialize
	Brush.Initialize
	BrushChiaro.Initialize
	BrushScuro.Initialize
	listaFinale.Initialize
	BrushScuro2.Initialize
	
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

'Base type must be Object
private Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	'Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor")) 'Example of getting a color value from Props
	#IF B4J
		mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top, Min(mBase.Width, mBase.Height), Min(mBase.Width, mBase.Height))
	#ELSE
		mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top, mBase.Width,mBase.Height)' Min(mBase.Width, mBase.Height), Min(mBase.Width, mBase.Height))	
	#End If
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
	'Dim clrEmpty As Int = xui.PaintOrColorToColor(Props.Get("ColorEmpty"))
	TextAltro= Props.Get("Altro")
	Spazio=Props.Get("Space")
	StileGrafico= Props.Get("PieStyle")
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
	#if b4j
	mBase.AddView(iv, 0, 0, mBase.Width, mBase.Width)
	#else
	mBase.AddView(iv, 0, 0, mBase.Height, mBase.Height)
	#end if
	mBase.AddView(mLbl, 0,  Min(mBase.Width, mBase.Height) / 2 - 20dip,  Min(mBase.Width, mBase.Height), 40dip)
	ResetBC
	'emptyBrush = bc.CreateBrushFromColor(clrEmpty)
	Ombra = bc.CreateBrushFromColor(0x32A9A9A9)'grigio trasparente
	Pannello.Initialize("")
	mBase.AddView(Pannello, 0, 0, mBase.Width, mBase.Width)
	
	
	PanelLegenda.Initialize("")
	'mBase.AddView(PanelLegenda,(cx+10dip)*2, 0, mBase.Width-cx, mBase.Height)
	mBase.AddView(PanelLegenda,mBase.Width/2+20dip, 0, mBase.Width, mBase.Height)
	
	InitColor
	TransparentBrush = bc.CreateBrushFromColor(xui.Color_Transparent)
	DrawValue(0)
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
	PanelLegenda.SetLayoutAnimated(0, Width/2, 0, w, w)
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


private Sub InitColor
	Dim i As Int
	Brush.Initialize
	BrushChiaro.Initialize
	BrushScuro.Initialize
	Brush.Clear
	BrushChiaro.Clear
	BrushScuro.Clear
	
	For i=0 To MaxElementi
		Brush.Add(bc.CreateBrushFromColor(ListaColori.Get(i)))
		BrushScuro.Add(bc.CreateBrushFromColor(OscuraColore(ListaColori.Get(i))))
		BrushScuro2.Add(bc.CreateBrushFromColor(OscuraColore(OscuraColore(ListaColori.Get(i)))))
		
		BrushChiaro.Add(bc.CreateBrushFromColor(DimezzaSaturazione(ListaColori.Get(i))))
	Next
End Sub

Private Sub DrawValue(Value As Float)
	ResetBC
	TransparentBrush = bc.CreateBrushFromColor(xui.Color_Transparent)
	InitColor
	bc.DrawRect2(bc.TargetRect, TransparentBrush, True, 0)

	If listaFinale.Size = 0 Then Return

	Dim separatore As Float = Value
	Dim AltezzaDisponibile As Float = bc.mHeight - (listaFinale.Size - 1) * separatore

	' Calcola altezza proporzionale di ogni segmento
	Dim Altezze(listaFinale.Size) As Float
	For i = 0 To listaFinale.Size - 1
		Dim G As Grafico = listaFinale.Get(i)
		Altezze(i) = (G.Percentuale / 100) * AltezzaDisponibile
	Next

	Dim yTop As Float = 0
	For i = 0 To listaFinale.Size - 1
		Dim G As Grafico = listaFinale.Get(i)
		Dim yBottom As Float = yTop + Altezze(i)
        
		Dim baseY As Float = bc.mHeight - yTop
		Dim topY As Float = bc.mHeight - yBottom
        
		' Larghezze proiettate
		Dim rightTopX As Float = cx + topY * SinD(-25)
		Dim rightTopY As Float = topY * CosD(-25)
		Dim rightBottomX As Float = cx + baseY * SinD(-25)
		Dim rightBottomY As Float = baseY * CosD(-25)

		Dim leftTopX As Float = cx + topY * SinD(25)
		Dim leftTopY As Float = topY * CosD(25)
		Dim leftBottomX As Float = cx + baseY * SinD(25)
		Dim leftBottomY As Float = baseY * CosD(25)

		' Faccia frontale
		Dim Rhombus As BCPath
		Rhombus.Initialize(cx, baseY)
		If i = listaFinale.Size - 1 Then
			Rhombus.LineTo(cx, 0) ' punta finale
		Else
			Rhombus.LineTo(cx, topY)
		End If
		Rhombus.LineTo(rightTopX, rightTopY)
		Rhombus.LineTo(rightBottomX, rightBottomY)
		bc.DrawPath2(Rhombus, Brush.Get(i), True, 0)

		If i < listaFinale.Size - 1 Then
			Dim dist1 As Float = rightTopY - topY

			' Piano taglio destro
			Rhombus.Initialize(cx, topY)
			Rhombus.LineTo(rightTopX, rightTopY)
			Rhombus.LineTo(cx, rightTopY + dist1)
			bc.DrawPath2(Rhombus, BrushScuro2.Get(i), True, 0)
		End If

		' Faccia sinistra
		Rhombus.Initialize(cx, baseY)
		Rhombus.LineTo(leftBottomX, leftBottomY)
		Rhombus.LineTo(leftTopX, leftTopY)
		If i = listaFinale.Size - 1 Then
			Rhombus.LineTo(cx, 0)
		Else
			Rhombus.LineTo(cx, topY)
		End If
		bc.DrawPath2(Rhombus, BrushChiaro.Get(i), True, 0)

		If i < listaFinale.Size - 1 Then
			Dim dist2 As Float = leftTopY - topY
			Rhombus.Initialize(cx, topY)
			Rhombus.LineTo(leftTopX, leftTopY)
			Rhombus.LineTo(cx, leftTopY + dist2)
			bc.DrawPath2(Rhombus, BrushScuro.Get(i), True, 0)
		End If

		yTop = yBottom + separatore
	Next

	bc.SetBitmapToImageView(bc.Bitmap, iv)
End Sub

'Private Sub DrawValueOld(Value As Float)
'	
'	ResetBC
'	TransparentBrush = bc.CreateBrushFromColor(xui.Color_Transparent)
'	InitColor
'	Dim DIMENSIONEALTEZZA As Float
'	
'	bc.DrawRect2(bc.TargetRect, TransparentBrush, True, 0)
'
'	
'	Dim DIMENSIONE As Float
'	Dim separatore As Float
'	separatore=10
'	DIMENSIONE=bc.mHeight/listaFinale.size-separatore
'	
'	If listaFinale.Size=0 Then Return
'
'	Dim i As Int
'	For i=1 To  listaFinale.Size
'		Dim G As Grafico
'		G=listaFinale.Get(i-1)
'		Log(G.Percentuale)
'		
'		Dim Rhombus As BCPath
'		'punto basso, punto a destra, punto a destra piu corto, punto centrale piu corto
'		If i=listaFinale.Size Then
'			Rhombus.Initialize(cx,bc.mHeight-(i-1)*DIMENSIONE-(i-1)*separatore).LineTo(cx,bc.mHeight-DIMENSIONE*i-(i)*separatore)'importante non -1 per fare la punta
'		Else
'			Rhombus.Initialize(cx,bc.mHeight-(i-1)*DIMENSIONE-(i-1)*separatore).LineTo(cx,bc.mHeight-DIMENSIONE*i-(i-1)*separatore)
'		End If
'		Rhombus.LineTo(cx+(bc.mHeight-DIMENSIONE*i-separatore*(i-1))*SinD(-25),(bc.mHeight-DIMENSIONE*i-separatore*(i-1))*CosD(-25))
'		Rhombus.LineTo(cx+(bc.mHeight-DIMENSIONE*(i-1)-separatore*(i-1))*SinD(-25),(bc.mHeight-DIMENSIONE*(i-1)-separatore*(i-1))*CosD(-25))
'		bc.DrawPath2(Rhombus, Brush.get(i-1), True, 0)
'		If i=listaFinale.Size Then
'		Else
'			Dim DIST1 As Float
'			DIST1=((bc.mHeight-DIMENSIONE*i-separatore*(i-1))*CosD(-25))-(bc.mHeight-DIMENSIONE*i-(i-1)*separatore)
'			'DISEGNO IL PIANO DI TAGLIO
'			Dim Rhombus As BCPath
'			Rhombus.Initialize(cx,bc.mHeight-DIMENSIONE*i-(i-1)*separatore)'(cx,bc.mHeight-(i-1)*Dimensione-(i-1)*separatore)
'			'Rhombus.LineTo(cx,bc.mHeight-Dimensione*i-(i-1)*separatore)
'			Rhombus.LineTo(cx+(bc.mHeight-DIMENSIONE*i-separatore*(i-1))*SinD(-25),(bc.mHeight-DIMENSIONE*i-separatore*(i-1))*CosD(-25))
'			'Rhombus.LineTo(cx+(bc.mHeight-Dimensione*(i-1)-separatore*(i-1))*SinD(-25),(bc.mHeight-Dimensione*(i-1)-separatore*(i-1))*CosD(-25))
'			Rhombus.LineTo(cx,(bc.mHeight-DIMENSIONE*i-separatore*(i-1))*CosD(-25)+DIST1)
'			
'			bc.DrawPath2(Rhombus, BrushScuro2.get(i-1), True, 0)
'		End If
'		
'	
'		'faccia sinistra
'		Dim Rhombus As BCPath
'		'punto basso, punto a destra, punto a destra piu corto, punto centrale piu corto
'		Rhombus.Initialize(cx,bc.mHeight-(i-1)*DIMENSIONE-(i-1)*separatore)
'		Rhombus.LineTo(cx+(bc.mHeight-(i-1)*DIMENSIONE-separatore*(i-1))*SinD(25),(bc.mHeight-(i-1)*DIMENSIONE-separatore*(i-1))*CosD(25))
'		Rhombus.LineTo(cx+(bc.mHeight-DIMENSIONE*i-separatore*(i-1))*SinD(25),(bc.mHeight-DIMENSIONE*i-separatore*(i-1))*CosD(25))
'		If i=listaFinale.Size Then
'			Rhombus.LineTo(cx,bc.mHeight-DIMENSIONE*i-(i)*separatore)'importante per chiudere la punta (non va -1)
'		Else
'			Rhombus.LineTo(cx,bc.mHeight-DIMENSIONE*i-(i-1)*separatore)
'		End If
'		
'		bc.DrawPath2(Rhombus, BrushChiaro.get(i-1), True, 0)
'		If i=listaFinale.Size Then
'		Else
'			'DISEGNO IL PIANO DI TAGLIO
'			Dim Rhombus As BCPath
'			Rhombus.Initialize(cx,bc.mHeight-DIMENSIONE*i-(i-1)*separatore)'(cx,bc.mHeight-(i-1)*Dimensione-(i-1)*separatore)
'			'Rhombus.LineTo(cx,bc.mHeight-Dimensione*i-(i-1)*separatore)
'			Rhombus.LineTo(cx+(bc.mHeight-DIMENSIONE*i-separatore*(i-1))*SinD(25),(bc.mHeight-DIMENSIONE*i-separatore*(i-1))*CosD(25))
'			'Rhombus.LineTo(cx+(bc.mHeight-Dimensione*(i-1)-separatore*(i-1))*SinD(-25),(bc.mHeight-Dimensione*(i-1)-separatore*(i-1))*CosD(-25))
'			Rhombus.LineTo(cx,(bc.mHeight-DIMENSIONE*i-separatore*(i-1))*CosD(25)+DIST1)
'			
'			bc.DrawPath2(Rhombus, BrushScuro.get(i-1), True, 0)
'		End If		
'	Next
'	
'	
'	
'	
'	bc.SetBitmapToImageView(bc.Bitmap, iv)
'End Sub



Sub Grafico(lista As List,order As Boolean)
	
	#if b4j
	Pannello.RemoveAllNodes
	PanelLegenda.RemoveAllNodes
	#else
	Pannello.RemoveAllViews
	PanelLegenda.RemoveAllViews
	Pannello.Color=xui.Color_Transparent
	#end if	
	
	listaFinale = CalcolaGrafico(lista,order)
    MostraLegenda(PanelLegenda,listaFinale)
	' Stampa per controllo
'	For Each g As Grafico In listaFinale
'		Log($"${g.Nome} - ${g.Valore} - ${NumberFormat(g.Percentuale,1,1)}% - Colore=${g.Colore}"$)
'	Next
	
	'DisegnaGraficoTorta(listaFinale)
	DrawValue(Spazio)
End Sub

Sub GraficoAnimato(lista As List,order As Boolean)
	SpazioAnimato=0
	#if b4j
	Pannello.RemoveAllNodes
	PanelLegenda.RemoveAllNodes
	#else
	Pannello.RemoveAllViews
	PanelLegenda.RemoveAllViews
	Pannello.Color=xui.Color_Transparent
	#end if	
	
	listaFinale = CalcolaGrafico(lista,order)
    MostraLegenda(PanelLegenda,listaFinale)
	' Stampa per controllo
'	For Each g As Grafico In listaFinale
'		Log($"${g.Nome} - ${g.Valore} - ${NumberFormat(g.Percentuale,1,1)}% - Colore=${g.Colore}"$)
'	Next
	
	'DisegnaGraficoTorta(listaFinale)
	If tmrAnimazione.IsInitialized = False Then
		tmrAnimazione.Initialize("tmrAnimazione", 20)
	End If
	
	'End If
	tmrAnimazione.Enabled = True
End Sub

private Sub tmrAnimazione_Tick
	
	If SpazioAnimato>Spazio Then
		tmrAnimazione.Enabled = False
		SpazioAnimato=Spazio
	End If
	DrawValue(SpazioAnimato)
	SpazioAnimato=SpazioAnimato+1
End Sub



private Sub CalcolaGrafico(ListaInput As List,ordine As Boolean) As List
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
		g.Colore = xui.Color_LightGray
		ListaGrafico.Add(g)
	End If
    
	Return ListaGrafico
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

private Sub OscuraColore(coloreARGB As Int) As Int
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

	' Oscura il colore del 10%
	v = v * 0.80
	If v < 0 Then v = 0

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

private Sub SchiarisciColore(coloreARGB As Int) As Int
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

	' Schiarisci del 10% (aumenta il valore v)
	v = Min(1, v + 0.20)

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


	#if b4j
private Sub MostraLegendaOLD(pnlLegenda As Pane, Lista As List)
	pnlLegenda.RemoveAllNodes
	#else
private Sub MostraLegendaOld(pnlLegenda As Panel, Lista As List)
	pnlLegenda.RemoveAllViews
	#End If
	#if B4A
	pnlLegenda.Color=xui.Color_Transparent
	Dim canva As B4XCanvas
	canva.Initialize(pnlLegenda)
	#end if
	If VisualizzaLegenda=False Then Return
	#if B4J
	Dim canva As B4XCanvas
	canva.Initialize(pnlLegenda)
	#end if
	Dim dimensione As Float
	dimensione=PanelLegenda.Height/Lista.Size
	Dim top As Int = 0
	Dim i As Int=0
	For Each g As Grafico In Lista
		Dim lbl As Label
		lbl.Initialize("")
		lbl.Text = $"${g.Nome}: ${NumberFormat(g.Percentuale,1,1)}%"$
		'lbl.TextColor=mLbl
		'lbl.TextColor = g.Colore
		#if b4j
		pnlLegenda.AddNode(lbl, dimensione*1.5, top, pnlLegenda.Width, dimensione)
		#else
		pnlLegenda.AddView(lbl, dimensione*1.5, top+dimensione/4, pnlLegenda.Width, dimensione)
			lbl.TextColor = g.Colore
		#end if
		canva.DrawCircle(dimensione/2,top+dimensione/2,dimensione/4,ListaColori.get(i),False,4dip)
		top = top + dimensione
		i=i+1
	Next
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
