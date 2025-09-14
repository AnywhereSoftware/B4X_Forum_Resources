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
#DesignerProperty: Key: FirstColor, DisplayName: First Color, FieldType: Color, DefaultValue: #FFA9D8FF, Description:

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
	Private clr1 As Int
	Private ListaColori As List
	Private Brush As List
	Private BrushOmbra As List
	
	Private ValoriList As List
	Private Totale As Float
	Private sfondo As BCBrush
	
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
	Private percentualeMax As Float
	Private listaFinale As List
	Private tmrAnimazione As Timer
	Private ValoreAnima As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	ListaColori.Initialize
	ValoriList.Initialize
	listaFinale.Initialize
	Brush.Initialize
	BrushOmbra.Initialize
	
	
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
	mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top, mBase.Width, mBase.Height)
	#ELSE
		mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top, mBase.Width,mBase.Height)' Min(mBase.Width, mBase.Height), Min(mBase.Width, mBase.Height))	
	#End If
	If Props.Get("Legend")="YES" Then
		VisualizzaLegenda=True
	Else
		VisualizzaLegenda=False
	End If
	clr1 = xui.PaintOrColorToColor(Props.Get("FirstColor"))
	
	If Props.Get("Percent")="YES" Then
		Percentuale=True
	Else
		Percentuale=False
	End If
	'Dim clrEmpty As Int = xui.PaintOrColorToColor(Props.Get("ColorEmpty"))
	TextAltro= Props.Get("Altro")
	
	StileGrafico= Props.Get("PieStyle")
	mLbl = Lbl
	cx = mBase.Width / 2
	cy =  mBase.Height / 2
	
	PanelLegenda.Initialize("")
	'mBase.AddView(PanelLegenda,(cx+10dip)*2, 0, mBase.Width-cx, mBase.Height)
	mBase.AddView(PanelLegenda,mBase.Width/2, 0, mBase.Width, mBase.Height)
	'PanelLegenda.Color=Colors.Blue
	'Log("BLU")
	radius = cx - 10dip
	mLbl.SetTextAlignment("CENTER", "CENTER")
	Dim iiv As ImageView
	iiv.Initialize("")
	iv = iiv
	mBase.AddView(iv, 0, 0, mBase.Width, mBase.Height)
	mBase.AddView(mLbl, 0,  Min(mBase.Width, mBase.Height) / 2 - 20dip,  Min(mBase.Width, mBase.Height), 40dip)
	ResetBC
	'emptyBrush = bc.CreateBrushFromColor(clrEmpty)
	Ombra = bc.CreateBrushFromColor(0x32A9A9A9)'grigio trasparente
	Pannello.Initialize("")
	mBase.AddView(Pannello, 0, 0, mBase.Width, mBase.Width)
	
	InitColor
	TransparentBrush = bc.CreateBrushFromColor(xui.Color_Transparent)
	sfondo=bc.CreateBrushFromColor(clr1)
	DrawValue(0)
End Sub


Private Sub ResetBC
	bc.Initialize(iv.Width, iv.Height)
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
	cx = Width / 2
	cy = Height / 2
	radius = cx - 10dip
	iv.SetLayoutAnimated(0, 0, 0, Width, Height)
	Pannello.SetLayoutAnimated(0, 0, 0, Width, Height)
	'Log("RIDIMENSIONA")
	#IF B4I
	'PanelLegenda.SetLayoutAnimated(0,w+10dip,0,w/2,Height)
	#End If
	'PanelLegenda.Color=Colors.Red
	bc.Initialize(iv.Width, iv.Height)
	If bc.mWidth <> w Then
		ResetBC
	End If
	mLbl.SetLayoutAnimated(0, 0, cy - 20dip, w, 40dip)
	DrawValue(0)
End Sub


private Sub InitColor
	Dim i As Int
	Brush.Initialize
	BrushOmbra.Clear
	Brush.Clear
	For i=0 To MaxElementi
		Brush.Add(bc.CreateBrushFromColor(ListaColori.Get(i)))
		BrushOmbra.Add(bc.CreateBrushFromColor(OscuraColore(ListaColori.Get(i))))
	Next
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
	v = v * 0.90
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
Private Sub DrawValue(Value As Float)
	
	ResetBC
	TransparentBrush = bc.CreateBrushFromColor(xui.Color_Transparent)
	sfondo=bc.CreateBrushFromColor(clr1)
	InitColor
	
	Dim canvas As B4XCanvas
	#if b4j
	Pannello.RemoveAllNodes
	#else
	Pannello.RemoveAllViews
	Pannello.Color=xui.Color_Transparent
	#End If
	canvas.Initialize(Pannello)
	
	bc.DrawRect2(bc.TargetRect, TransparentBrush, True, 0)
	'mLbl.Text = $"$1.0{Value}"$
	'Dim startAngle = -90, sweepAngle = Value / 100 * 360 As Float
	
	'bc.DrawArc2(cx-2, cy+2, radius, Ombra, False, stroke, startAngle,360)
	
	'bc.DrawArc2(cx, cy, radius, emptyBrush, False, stroke, startAngle, -(360 - sweepAngle))
	
	Dim Dimensione As Float
	Dim separatore As Float
	separatore=20
	Dimensione=bc.mHeight/5-separatore
	
	'Dim Rhombus As BCPath
	'Rhombus.Initialize(0, bc.mHeight / 2).LineTo(bc.mWidth / 2, 0)
	'Rhombus.LineTo(bc.mWidth, bc.mHeight / 2).LineTo(bc.mWidth / 2, bc.mHeight)
	'bc.DrawPath2(Rhombus, Brush.get(0), True, 0)
	
	Dim Rhombus As BCPath
	'punto basso, punto a destra, punto a destra piu corto, punto centrale piu corto
	Rhombus.Initialize(0,bc.mHeight).LineTo(bc.mWidth,bc.mHeight)
	Rhombus.LineTo(bc.mWidth,bc.mHeight-35dip)
	Rhombus.LineTo(0,bc.mHeight-35dip)
	
	'Rhombus.LineTo(0,bc.mHeight)
	
	'Rhombus.LineTo(100,100)
	
	
	bc.DrawPath2(Rhombus, sfondo, True, 0)
	
	Dim larghezza As Float
	Dim Larghezza2 As Float
	larghezza=bc.mWidth/(listaFinale.Size+2)
	Larghezza2=larghezza*(listaFinale.Size-2)/listaFinale.Size
	'Log(percentualeMax)
	'Log(listaFinale.Size)
	'Log(bc.mHeight)
	'Log(bc.mWidth)
	Dim areaMax As Float
	areaMax=(bc.mHeight-70dip)
	For i=0 To listaFinale.Size-1
		'settore basso
		Dim Rhombus As BCPath
		'punto basso, punto a destra, punto a destra piu corto, punto centrale piu corto
		Rhombus.Initialize(0+larghezza*(i+1),bc.mHeight).LineTo(larghezza*(i+2),bc.mHeight)
		Rhombus.LineTo(larghezza*(i+2),bc.mHeight-35dip)
		Rhombus.LineTo(0+larghezza*(i+1),bc.mHeight-35dip)
		bc.DrawPath2(Rhombus, Brush.get(i), True, 0)
		Dim g As Grafico
		g=listaFinale.Get(i)
		Dim valorelunghezza As Float
		'Log("% " & g.Percentuale)
		'Log("prop " & proporzione(g.Percentuale))
		valorelunghezza=(areaMax * proporzione(g.Percentuale))*Value/100'per l'animazione
		'Log(valorelunghezza)
		
		'settore alto
		Dim Rhombus As BCPath
		'punto basso, punto a destra, punto a destra piu corto, punto centrale piu corto
		Rhombus.Initialize(larghezza*2+Larghezza2*(i),bc.mHeight-70dip).LineTo(larghezza*2+Larghezza2*(i+1),bc.mHeight-70dip)
		'il 50 serve a disegnare il cerchio dall'alto
		Rhombus.LineTo(larghezza*2+Larghezza2*(i+1),bc.mHeight- valorelunghezza-40dip)
		Rhombus.LineTo(larghezza*2+Larghezza2*(i),bc.mHeight- valorelunghezza-40dip)
		bc.DrawPath2(Rhombus, Brush.get(i), True, 0)
		
		'round in testa
		If StileGrafico="ROUND" Then
			bc.DrawCircle(larghezza*2+Larghezza2*(i+1)-Larghezza2/2,bc.mHeight- valorelunghezza- 40dip ,Larghezza2/2+0.1,ListaColori.Get(i),True,0)
		End If
		'unione piu scura
		Dim Rhombus As BCPath
		'punto basso, punto a destra, punto a destra piu corto, punto centrale piu corto
		Rhombus.Initialize(larghezza*2+Larghezza2*(i),bc.mHeight-70dip).LineTo(larghezza*2+Larghezza2*(i+1),bc.mHeight-70dip)
		Rhombus.LineTo(larghezza*(i+2),bc.mHeight-35dip)
		Rhombus.LineTo(0+larghezza*(i+1),bc.mHeight-35dip)
		bc.DrawPath2(Rhombus, BrushOmbra.get(i), True, 0)
		
		' Calcola rettangolo centrato attorno al punto
		Dim text As String = NumberFormat(g.Percentuale, 1, 1) & ""
		Dim Font1 As B4XFont = xui.CreateDefaultFont(12)
		Dim textWidth As Float = canvas.MeasureText(text, Font1).Width
		Dim textHeight As Float = 15dip'font.ToNativeFont.Size

		Dim rect As B4XRect
		rect.Initialize(larghezza*(i+1)+larghezza - textWidth / 2, bc.mHeight-15dip - textHeight / 2, larghezza*(i+1) + textWidth / 2, bc.mHeight-15dip + textHeight / 2)
		If Percentuale=True Then
			canvas.DrawText(text, rect.CenterX, rect.CenterY, Font1, xui.Color_White, "CENTER")
		End If
		If VisualizzaLegenda Then
			canvas.DrawTextRotated(g.Nome,larghezza*2+Larghezza2*(i+1)-Larghezza2/2+textHeight/2,bc.mHeight- 80dip,Font1,xui.Color_Black,"LEFT",-90)
		End If
	Next
	For i=0 To listaFinale.Size-1
		'unione piu scura
		Dim Rhombus As BCPath
		'punto basso, punto a destra, punto a destra piu corto, punto centrale piu corto
		Rhombus.Initialize(larghezza*2+Larghezza2*(i),bc.mHeight-70dip).LineTo(larghezza*2+Larghezza2*(i+1),bc.mHeight-70dip)
		Rhombus.LineTo(larghezza*(i+2),bc.mHeight-35dip)
		Rhombus.LineTo(0+larghezza*(i+1),bc.mHeight-35dip)
		bc.DrawPath2(Rhombus, BrushOmbra.get(i), True, 0)
		
	Next
	
	bc.SetBitmapToImageView(bc.Bitmap, iv)
End Sub
private Sub proporzione(valore As Float) As Float
	Dim risp As Float
	risp=valore/percentualeMax
	Return risp
End Sub

Sub Grafico(lista As List,order As Boolean)
	
    
	listaFinale  = CalcolaGrafico(lista,order)
    
	' Stampa per controllo
'	For Each g As Grafico In listaFinale
'		Log($"${g.Nome} - ${g.Valore} - ${NumberFormat(g.Percentuale,1,1)}% - Colore=${g.Colore}"$)
'	Next
	
	'DisegnaGraficoTorta(listaFinale)
	DrawValue(100)
End Sub

Sub GraficoAnimato(lista As List,order As Boolean)	   
	
	listaFinale  = CalcolaGrafico(lista,order)    
	' Stampa per controllo
'	For Each g As Grafico In listaFinale
'		Log($"${g.Nome} - ${g.Valore} - ${NumberFormat(g.Percentuale,1,1)}% - Colore=${g.Colore}"$)
'	Next
	
	'DisegnaGraficoTorta(listaFinale)
	'DrawValue(100)
	AvviaAnimazioneGrafico( order)
End Sub
private Sub AvviaAnimazioneGrafico(order As Boolean)
	ValoreAnima=5
	
	InitColor
	'DisegnaGraficoTorta(listaFinale)
	If tmrAnimazione.IsInitialized = False Then
		tmrAnimazione.Initialize("tmrAnimazione", 10)
	End If
	
	'End If
	tmrAnimazione.Enabled = True
End Sub
private Sub tmrAnimazione_Tick
	ValoreAnima=ValoreAnima+3
	If ValoreAnima>=100 Then
		tmrAnimazione.Enabled = False
		ValoreAnima=100
	End If
	DrawValue(ValoreAnima)
	
End Sub

private Sub CalcolaGrafico(ListaInput As List,ordine As Boolean) As List
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
			If g.Percentuale>percentualeMax Then
				percentualeMax=g.Percentuale
			End If
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
		If g.Percentuale>percentualeMax Then
			percentualeMax=g.Percentuale
		End If
		g.Colore = xui.Color_LightGray
		ListaGrafico.Add(g)
	End If
    
	Return ListaGrafico
End Sub


Private Sub OrdinaPerValore(Lista As List) As List
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


Private Sub Button2_Click
	
End Sub