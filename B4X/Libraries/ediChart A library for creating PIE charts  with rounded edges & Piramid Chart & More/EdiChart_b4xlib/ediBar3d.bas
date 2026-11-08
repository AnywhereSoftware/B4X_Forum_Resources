B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
#DesignerProperty: Key: Stylegrafico, DisplayName: Style Chart, FieldType: String, DefaultValue: LIGHT, List: LIGHT|DARK
#DesignerProperty: Key: Legend, DisplayName: Legend, FieldType: String, DefaultValue: YES, List: YES|NO
#DesignerProperty: Key: Percent, DisplayName: Perc, FieldType: String, DefaultValue: YES, List: YES|NO
#DesignerProperty: Key: Altro, DisplayName: Altro, FieldType: String, DefaultValue: Altro
#DesignerProperty: Key: FirstColor, DisplayName: First Color, FieldType: Color, DefaultValue: #FF483C34, Description:
#DesignerProperty: Key: LegendaColor, DisplayName: Legend Color, FieldType: Color, DefaultValue: #77FFFFFF, Description:

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Private mLbl As B4XView
	
	
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
	Private BrushChiari As List
	Private colorelegenda As Int
	
	Private ValoriList As List
	Private Totale As Float
	Private sfondo As BCBrush
	
	Private MaxElementi As Int=10
	#if b4j
	Private Pannello As Pane
	Private PanelLegenda As Pane
	#else 
	Private Pannello As Panel
	Private PanelLegenda As Panel	
	
	#end if
	Private iv As B4XView
	Private bc As BitmapCreator
	
	Private TransparentBrush As BCBrush
	Private percentualeMax As Float
	Private listaFinale As List
	
	
	Private ColoreVetro1 As Int=0x66dbecf4
	Private ColoreVetro2 As Int=0x66c2d5dd
	Private ColoreVetro3 As Int=0x55edfaff
	'per tema dark
	Private ColoreVetro10 As Int=0x665f6163
	Private ColoreVetro20 As Int=0x664e4e4e
	Private ColoreVetro30 As Int=0x5567696b
	
	Private BrushVetro1 As BCBrush
	Private BrushVetro2 As BCBrush
	Private BrushVetro3 As BCBrush
	
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
	BrushChiari.Initialize
	
	ListaColori.Add(0xffffc515)'giallo
	ListaColori.Add(0xfff5772b)'arancio
	ListaColori.Add(0xffe93249)'rosso
	ListaColori.Add(0xfff47e96)'rova
	ListaColori.Add(0xffdc89ba)'rosascuro
	ListaColori.Add(0xffae8ab4)'viola
	ListaColori.Add(0xff6e86b7)'blu
	ListaColori.Add(0xff4dbbec)'celeste
	ListaColori.Add(0xff53c1be)'verdeacqua
	ListaColori.Add(0xff8eca81)'verde
	ListaColori.Add(xui.Color_Gray)
	
	
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
	colorelegenda = xui.PaintOrColorToColor(Props.Get("LegendaColor"))
	
	
	
	If Props.Get("Percent")="YES" Then
		Percentuale=True
	Else
		Percentuale=False
	End If
	'Dim clrEmpty As Int = xui.PaintOrColorToColor(Props.Get("ColorEmpty"))
	TextAltro= Props.Get("Altro")
	
	StileGrafico= Props.Get("Stylegrafico")
	'Log(StileGrafico)
	mLbl = Lbl
	'cx = mBase.Width / 2
	'cy =  mBase.Height / 2
	
	PanelLegenda.Initialize("")
	'mBase.AddView(PanelLegenda,(cx+10dip)*2, 0, mBase.Width-cx, mBase.Height)	
	If VisualizzaLegenda=True Then
		mBase.AddView(PanelLegenda,mBase.Width/3*2+10dip, 0, mBase.Width, mBase.Height)
	Else
		'sposta la legenda oltre lo schermo
		mBase.AddView(PanelLegenda,mBase.Width, 0, mBase.Width, mBase.Height)
	End If
	#if b4a
	PanelLegenda.Color=colorelegenda
	#end if
	'Log("BLU")
	'radius = cx - 10dip
	mLbl.SetTextAlignment("CENTER", "CENTER")
	Dim iiv As ImageView
	iiv.Initialize("")
	iv = iiv
	If VisualizzaLegenda=True Then
		'con legenda prende 2/3 dello schermo
		
		mBase.AddView(iv, 0, 0, mBase.Width/3*2, mBase.Height)	
	Else
		mBase.AddView(iv, 0, 0, mBase.Width, mBase.Height)
		
	End If
	
	mBase.AddView(mLbl, 0,  Min(mBase.Width, mBase.Height) / 2 - 20dip,  Min(mBase.Width, mBase.Height), 40dip)
	ResetBC
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
	'cx = Width / 2
	'cy = Height / 2
	'radius = cx - 10dip
	If VisualizzaLegenda=True Then
		iv.SetLayoutAnimated(0, 0, 0, Width/3*2, Height)
		Pannello.SetLayoutAnimated(0, 0, 0, Width/3*2, Height)
		PanelLegenda.SetLayoutAnimated(0, Width/3*2+10dip, 0, Width/3*2, Height)
	Else
		iv.SetLayoutAnimated(0, 0, 0, Width, Height)
		Pannello.SetLayoutAnimated(0, 0, 0, Width, Height)
	End If
	'Log("RIDIMENSIONA")
	#IF B4I
	'PanelLegenda.SetLayoutAnimated(0,w+10dip,0,w/2,Height)
	#End If
	'PanelLegenda.Color=Colors.Red
	bc.Initialize(iv.Width, iv.Height)
	If bc.mWidth <> w Then
		ResetBC
	End If
	'mLbl.SetLayoutAnimated(0, 0, cy - 20dip, w, 40dip)
	DrawValue(0)
End Sub


private Sub InitColor
	Dim i As Int
	Brush.Initialize
	BrushOmbra.Clear
	BrushChiari.Clear
	
	Brush.Clear
	For i=0 To MaxElementi
		Brush.Add(bc.CreateBrushFromColor(ListaColori.Get(i)))
		BrushOmbra.Add(bc.CreateBrushFromColor(OscuraColore(ListaColori.Get(i))))
		BrushChiari.Add(bc.CreateBrushFromColor(DimezzaSaturazione(ListaColori.Get(i))))
		
	Next
	If StileGrafico="DARK" Then
		BrushVetro1 = bc.CreateBrushFromColor(ColoreVetro10)
		BrushVetro2 = bc.CreateBrushFromColor(ColoreVetro20)
		BrushVetro3 = bc.CreateBrushFromColor(ColoreVetro30)
		
	Else
		BrushVetro1 = bc.CreateBrushFromColor(ColoreVetro1)
		BrushVetro2 = bc.CreateBrushFromColor(ColoreVetro2)
		BrushVetro3 = bc.CreateBrushFromColor(ColoreVetro3)
		
	End If
	
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
	's = s / 2 '-50%
	s = s * 0.7 '-30%

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
Try
		
	ResetBC
	TransparentBrush = bc.CreateBrushFromColor(xui.Color_Transparent)
	sfondo=bc.CreateBrushFromColor(clr1)
	
	
	Dim canvas As B4XCanvas
	#if b4j
	Pannello.RemoveAllNodes
	#else
	Pannello.RemoveAllViews
	Pannello.Color=xui.Color_Transparent
	#End If
	canvas.Initialize(Pannello)
	
	bc.DrawRect2(bc.TargetRect, TransparentBrush, True, 0)
	
	
	
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
	areaMax=(bc.mHeight-60dip)
	areaMax=areaMax*Value/100
	For i=0 To listaFinale.Size-1
'		'settore basso
'		Dim Rhombus As BCPath
'		'punto basso, punto a destra, punto a destra piu corto, punto centrale piu corto
'		Rhombus.Initialize(0+larghezza*(i+1),bc.mHeight).LineTo(larghezza*(i+2),bc.mHeight)
'		Rhombus.LineTo(larghezza*(i+2),bc.mHeight-35dip)
'		Rhombus.LineTo(0+larghezza*(i+1),bc.mHeight-35dip)
'		bc.DrawPath2(Rhombus, Brush.get(i), True, 0)
		
		'disegno vetro sinistro

		
		Dim Rhombus As BCPath
		Rhombus.Initialize(larghezza*(i+1),bc.mHeight-35dip)		
		Rhombus.LineTo(larghezza*(i+2)-2*larghezza/3,bc.mHeight-35dip+larghezza/3/2)
		Rhombus.LineTo(larghezza*(i+2)-2*larghezza/3,larghezza/3/1.8-larghezza/3/2)
		Rhombus.LineTo(larghezza*(i+1),larghezza/3/1.8)
		bc.DrawPath2(Rhombus, BrushVetro1, True, 0)
		
		'disegno vetro destro
		Dim Rhombus As BCPath
		Rhombus.Initialize(larghezza*(i+2)-2*larghezza/3,bc.mHeight-35dip+larghezza/3/2)
		Rhombus.LineTo(larghezza*(i+2)-larghezza/3,bc.mHeight-35dip)
		Rhombus.LineTo(larghezza*(i+2)-larghezza/3,larghezza/3/1.8)
		Rhombus.LineTo(larghezza*(i+2)-2*larghezza/3,larghezza/3/1.8-larghezza/3/2)
		bc.DrawPath2(Rhombus, BrushVetro2, True, 0)
		
		
		
		Dim g As Grafico
		g=listaFinale.Get(i)
		Dim valorelunghezza As Float
		'Log("% " & g.Percentuale)
		'Log("prop " & proporzione(g.Percentuale))
		valorelunghezza=areaMax * proporzione(g.Percentuale)
		'Log(valorelunghezza)
		If valorelunghezza<20dip Then
				valorelunghezza=20dip
		End If
'		Log(valorelunghezza & "  " & areaMax)
		
				
		'	If ( bc.mHeight- valorelunghezza)>(bc.mHeight-20dip) Then
		'		valorelunghezza=35dip
		'	End If
		
		'disegno parte a sinistra
		Dim Rhombus As BCPath
		Rhombus.Initialize(1+larghezza*(i+1),bc.mHeight-35dip)
		Rhombus.LineTo(1+larghezza*(i+2)-2*larghezza/3,bc.mHeight-35dip+larghezza/3/2)
		Rhombus.LineTo(1+larghezza*(i+2)-2*larghezza/3, bc.mHeight- valorelunghezza-   larghezza/3/1.8+larghezza/3/2)
		Rhombus.LineTo(1+larghezza*(i+1), bc.mHeight- valorelunghezza-   larghezza/3/1.8)
		bc.DrawPath2(Rhombus, Brush.get(i), True, 0)
		
		'disegno parete destro
		Dim Rhombus As BCPath
		Rhombus.Initialize(larghezza*(i+2)-2*larghezza/3,bc.mHeight-35dip+larghezza/3/2)
		Rhombus.LineTo(larghezza*(i+2)-larghezza/3,bc.mHeight-35dip)
		Rhombus.LineTo(larghezza*(i+2)-larghezza/3, bc.mHeight- valorelunghezza-  larghezza/3/1.8)
		Rhombus.LineTo(larghezza*(i+2)-2*larghezza/3, bc.mHeight- valorelunghezza-  larghezza/3/1.8-larghezza/3/2)
		bc.DrawPath2(Rhombus, BrushOmbra.get(i), True, 0)
		
		'disegno triangolo destro
		Dim Rhombus As BCPath
		Rhombus.Initialize(larghezza*(i+2)-2*larghezza/3, bc.mHeight- valorelunghezza-   larghezza/3/1.8+larghezza/3/2)
		Rhombus.LineTo(larghezza*(i+2)-larghezza/3, bc.mHeight- valorelunghezza-  larghezza/3/1.8)
		Rhombus.LineTo(larghezza*(i+2)-2*larghezza/3, bc.mHeight- valorelunghezza-  larghezza/3/1.8-larghezza/3/2)
		bc.DrawPath2(Rhombus, Brush.get(i), True, 0)
		
		'disegno triangolo sinistro
		Dim Rhombus As BCPath
		Rhombus.Initialize(larghezza*(i+2)-2*larghezza/3, bc.mHeight- valorelunghezza-   larghezza/3/1.8+larghezza/3/2)
		Rhombus.LineTo(larghezza*(i+1), bc.mHeight- valorelunghezza-  larghezza/3/1.8)
		Rhombus.LineTo(larghezza*(i+2)-2*larghezza/3, bc.mHeight- valorelunghezza-  larghezza/3/1.8-larghezza/3/2)
		bc.DrawPath2(Rhombus, BrushChiari.get(i), True, 0)
		
		'disegno linee alto
		bc.DrawLine2(larghezza*(i+2)-2*larghezza/3, larghezza/3/1.8+larghezza/3/2, larghezza*(i+1),larghezza/3/1.8,BrushVetro3,1)
		bc.DrawLine2(larghezza*(i+2)-2*larghezza/3, larghezza/3/1.8+larghezza/3/2, larghezza*(i+2)-larghezza/3,larghezza/3/1.8,BrushVetro3,1)
		
		

'		
		' Calcola rettangolo centrato attorno al punto
		If VisualizzaLegenda = False Then
				
			Dim text As String = NumberFormat(g.Percentuale, 1, 1) & "%"
				If listaFinale.Size>8 Then
					Dim Font1 As B4XFont = xui.CreateDefaultFont(9)
				Else
					Dim Font1 As B4XFont = xui.CreateDefaultFont(11)
				End If
			
		Else
			Dim text As String = NumberFormat(g.Percentuale, 1, 1) & ""
			Dim Font1 As B4XFont = xui.CreateDefaultFont(8)
		End If
		Dim textWidth As Float = canvas.MeasureText(text, Font1).Width
		Dim textHeight As Float = 15dip'font.ToNativeFont.Size
'
		Dim rect As B4XRect
		rect.Initialize(larghezza*(i+1)+larghezza - textWidth / 2, bc.mHeight-10dip - textHeight / 2, larghezza*(i+1) + textWidth / 2, bc.mHeight-10dip + textHeight / 2)
		If Percentuale=True Then
			canvas.DrawText(text, rect.CenterX, rect.CenterY, Font1, xui.Color_White, "CENTER")
		End If
'		If VisualizzaLegenda Then
'			canvas.DrawTextRotated(g.Nome,larghezza*2+Larghezza2*(i+1)-Larghezza2/2+textHeight/2,bc.mHeight- 80dip,Font1,xui.Color_Black,"LEFT",-90)
'		End If
	Next

	Catch
'		Log(LastException)
	End Try

	bc.SetBitmapToImageView(bc.Bitmap, iv)
End Sub
private Sub proporzione(Valore As Float) As Float
	Dim risp As Float
	risp=Valore/percentualeMax
	Return risp
End Sub

Sub Grafico(lista As List,order As Boolean)
	#if b4j
	Pannello.RemoveAllNodes
	PanelLegenda.RemoveAllNodes
	#else
	Pannello.RemoveAllViews
	PanelLegenda.RemoveAllViews
	Pannello.Color=xui.Color_Transparent
	PanelLegenda.Color=colorelegenda
	#end if	
	InitColor
	
	listaFinale  = CalcolaGrafico(lista,order)
	MostraLegenda(PanelLegenda,listaFinale)
	' Stampa per controllo
'	For Each g As Grafico In listaFinale
'		Log($"${g.Nome} - ${g.Valore} - ${NumberFormat(g.Percentuale,1,1)}% - Colore=${g.Colore}"$)
'	Next
	
	'DisegnaGraficoTorta(listaFinale)
	DrawValue(100)
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


private Sub OrdinaPerValoreDesc(Lista As List) As List
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

Private Sub OrdinaPerValore(Lista As List) As List
	Dim arr(Lista.Size) As Elemento
	For i = 0 To Lista.Size - 1
		arr(i) = Lista.Get(i)
	Next
	
	' Ordinamento a bolle (bubble sort) dal minore al maggiore
	For i = 0 To arr.Length - 2
		For j = i + 1 To arr.Length - 1
			If arr(j).Valore < arr(i).Valore Then
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
Sub MostraLegenda(pnlLegenda As Pane, Lista As List)
	pnlLegenda.RemoveAllNodes
	#else
private Sub MostraLegenda(pnlLegenda As Panel, Lista As List)
	pnlLegenda.RemoveAllViews
	#End If
    #If B4A Or B4i
	pnlLegenda.Color = colorelegenda'xui.Color_Transparent
	'PanelLegenda.Color=colorelegenda
	Dim canva As B4XCanvas
	canva.Initialize(pnlLegenda)
    #End If
    #If B4J
	Dim canva As B4XCanvas
	canva.Initialize(pnlLegenda)
    #End If

	If VisualizzaLegenda = False Then Return

	Dim dimensione As Float = pnlLegenda.Height / (MaxElementi+1)'Lista.Size
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
		#if b4a
		lbl.TextColor=xui.Color_DarkGray
		#end if
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


Sub GraficoAnimato(Lista As List,Order As Boolean)
	
	'bc.Initialize(iv.Width, iv.Height)
	#if b4j
	Pannello.RemoveAllNodes
	PanelLegenda.RemoveAllNodes
	#else
	Pannello.RemoveAllViews
	PanelLegenda.RemoveAllViews
	Pannello.Color=xui.Color_Transparent
	PanelLegenda.Color=colorelegenda
	#end if	
	
	listaFinale  = CalcolaGrafico(Lista,Order)
	MostraLegenda(PanelLegenda,listaFinale)
	' Stampa per controllo
'	For Each g As Grafico In listaFinale
'		Log($"${g.Nome} - ${g.Valore} - ${NumberFormat(g.Percentuale,1,1)}% - Colore=${g.Colore}"$)
'	Next
	
	'DisegnaGraficoTorta(listaFinale)
	'DrawValue(100)
	AvviaAnimazioneGrafico( Order)
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