B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	
	Public vboxes 										As List
	Private MAX_Double 									As Double = 9007199254740991
	Private SIGBITS 									As Int = 5
	Private RSHIFT 										As Int = 8 - SIGBITS
	Private FRACT_BY_POPULATION 						As Double = 0.75
	Private MAX_ITERATIONS 								As Int = 1000
	Private VBOX_LENGTH 								As Int = Bit.ShiftLeft (1 , SIGBITS)

	Type CountProduct (v As VBox, cnt As Int, pr As Int)
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

	vboxes.Initialize
		
End Sub

Public Sub push(box As VBox)
    vboxes.add(box)
End Sub

Public Sub getColorIndex(r As Int, g As Int, b As Int) As Int
	Return (Bit.ShiftLeft (r , (2 * SIGBITS)) + (Bit.ShiftLeft(g , SIGBITS)) + b)
End Sub

Public Sub palette As Map

	Dim p As Map
    Dim i As Int
	
	p.Initialize
	
	For Each v As VBox In vboxes
		p.Put (i, v.avrg(False))
		i=i+1
	Next
	
    Return p
End Sub

Public Sub size As Int
    Return vboxes.size
End Sub

Public Sub color (c As ARGBColor) As ARGBColor
	For Each v As VBox In vboxes
		If v.contains (c) Then
			Return v.avrg (False)		
		End If
	Next

	Return nearest(c)
End Sub

Public Sub nearest(clor As ARGBColor) As ARGBColor
	Dim d1 As Double = MAX_Double
	Dim d2 As Double
	Dim pColor As ARGBColor
	Dim vbcolor As ARGBColor

	For Each v As VBox In vboxes
		vbcolor = v.avrg(False)
		d2 = Sqrt(Power(clor.a - clor.r, 2) + Power(clor.g - clor.g, 2) + Power(clor.b - clor.b, 2))

		If d2 < d1 Then
			d1 = d2
			pColor = vbcolor
		End If
	Next
	
	Return pColor
End Sub

Private Sub getHisto(pixels As List) As Int()
	
	Dim histo(300 * 300) As Int
	
	Dim index, rval, gval, bval As Int
	
	For Each pixel As ARGBColor In pixels

		rval = Bit.ShiftRight (pixel.r, RSHIFT)
		gval = Bit.ShiftRight (pixel.g, RSHIFT)
		bval = Bit.ShiftRight (pixel.b, RSHIFT)
		index = getColorIndex(rval, gval, bval)

		histo(index) = histo (index) +1
	Next
	
	Return histo
End Sub

Private Sub vboxFromPixels(pixels As List, histo () As Int) As VBox
	
	Dim rmin As Int = 1000000
	Dim rmax As Int = 0
	Dim gmin As Int = 1000000
	Dim gmax As Int = 0
	Dim bmin As Int = 1000000
	Dim bmax As Int = 0
	Dim rval, gval, bval As Int
	
	Dim c As Int
	
	For Each pixel As ARGBColor In pixels
		rval = Bit.ShiftRight (pixel.r , RSHIFT)
		gval = Bit.ShiftRight (pixel.g , RSHIFT)
		bval = Bit.ShiftRight (pixel.b , RSHIFT)

		If rval < rmin Then
			rmin = rval
		Else If rval > rmax Then
			rmax = rval
		End If
			
		If gval < gmin Then
			gmin = gval
		Else If gval > gmax Then
			gmax = gval
		End If
		
		If bval < bmin Then
			bmin = bval
		else if bval > bmax Then
			bmax = bval
		End If
		
		c=c+1
	Next
	
	Dim vvbox As VBox
	vvbox.Initialize (rmin, rmax, gmin, gmax, bmin, bmax, histo)
	Return vvbox
	
End Sub

Private Sub medianCutApply(histo() As Int, vbbox As VBox) As List
	
	If vbbox.count(False) = 0 Then Return Null

	If vbbox.count(False) = 1 Then
		Dim v As VBox
		v = vbbox.clone
		
		Dim l As List
		l.Initialize
		l.Add (v)
		
		Return l
	End If

	
	Dim rw As Int = vbbox.r2 - vbbox.r1 + 1
	
	Dim gw As Int = vbbox.g2 - vbbox.g1 + 1

	Dim bw As Int = vbbox.b2 - vbbox.b1 + 1
	
	Dim maxw As Int = Max(Max(rw, gw), bw)

	Dim total, i, j, k, sum, index As Int

	Dim partialsum, lookaheadsum As Map
	partialsum.Initialize
	lookaheadsum.Initialize

	
	If maxw = rw Then
		For i = vbbox.r1 To vbbox.r2
			sum = 0

			For j = vbbox.g1 To vbbox.g2
				For k = vbbox.b1 To vbbox.b2
					index = getColorIndex(i, j, k)
					
					Dim r As Int
					r = histo(index)
					sum = sum + r

				Next
			Next

			total = total + sum
			partialsum.put(i, total)
		Next
	else if maxw = gw Then
		For i = vbbox.g1 To vbbox.g2
			sum = 0
			For j = vbbox.r1 To vbbox.r2
				For k = vbbox.b1 To vbbox.b2
					index = getColorIndex(j, i, k)
					Dim r As Int
					r = histo(index)
					sum = sum + r
				Next
			Next
			total = total + sum
			partialsum.put(i, total)
		Next
	Else
		For i = vbbox.b1 To vbbox.b2
			sum = 0
			For j = vbbox.r1 To vbbox.r2
				For k = vbbox.g1 To vbbox.g2
					index = getColorIndex(j, k, i)
					Dim r As Int
					r = histo(index)
					sum = sum + r
				Next
			Next
			
			total = total + sum
			partialsum.put(i, total)
		Next
	End If
	
	For i = 0 To VBOX_LENGTH -1
		
		If partialsum.ContainsKey (i) = False Then
			partialsum.Put (i, -1)
		End If
	Next
	
	For i = 0 To VBOX_LENGTH -1
		Dim ps As Int
		ps = partialsum.Get (i)
		If ps <> -1 Then 
			ps = total - ps
			lookaheadsum.Put (i,ps)
		End If
		
	Next
	
	If maxw = rw Then
		Return doCut("r", vbbox, partialsum, lookaheadsum, total)
	Else If	maxw = gw Then
		Return doCut("g", vbbox, partialsum, lookaheadsum, total)
	Else
		Return doCut("b", vbbox, partialsum, lookaheadsum, total)
	End If

End Sub

Private Sub doCut(clor As String, vbbox As VBox, partialsum As Map, lookaheadsum As Map, total As Int) As List
	
	Dim dim1, dim2 As Int
	
	If clor = "r" Then
		dim1 = vbbox.r1
		dim2 = vbbox.r2
	else if clor = "g" Then
		dim1 = vbbox.g1
		dim2 = vbbox.g2
	else if clor = "b" Then
		dim1 = vbbox.b1
		dim2 = vbbox.b2
	End If
	
	Dim vbbox1, vbbox2 As VBox
	Dim i, count2, left, right, d2 As Int
	
	For i = dim1 To dim2
		If partialsum.get(i) > total / 2 Then
			vbbox1 = vbbox.clone
			vbbox2 = vbbox.clone
			left = i - dim1
			right = dim2 - i
			
			If left <= right Then
				d2 = Min(dim2 - 1, (i + right / 2))
			Else
				d2 = Max(dim1, (i - 1 - left / 2))
			End If
			
			'avoid 0-count boxes
			Do While partialsum.ContainsKey(d2) = False
				d2 = d2+1
			Loop

			If lookaheadsum.ContainsKey(d2) Then count2 = lookaheadsum.get(d2) Else count2 = 0
			
			Do While count2 = 0 And d2 > partialsum.Get(d2-1) And partialsum.get(d2-1) > 0
				count2 = lookaheadsum.get(d2-1)
			Loop
			
			If clor = "r" Then
				vbbox1.R2 = d2
				vbbox2.R1 = vbbox1.R2+1
			else if clor= "g" Then
				vbbox1.G2 = d2
				vbbox2.G1 = vbbox1.G2 + 1
			else if clor = "b" Then
				vbbox1.B2 = d2
				vbbox2.B1 = vbbox1.B2 + 1
			End If

			Dim l As List
			l.Initialize
			l.Add (vbbox1)
			l.Add (vbbox2)
			
			Return l
		End If
	Next
	Return Null
End Sub

Public Sub quantize(pixels As List, maxcolors As Int) As CMap
    
   	If pixels.IsInitialized = False Or maxcolors < 2 Or maxcolors > 256 Then
		Return Null
	End If

	Dim histo() As Int = getHisto(pixels)
	
	'get the beginning vbox from the colors
	Dim vvbox As VBox = vboxFromPixels(pixels, histo)
	
	Dim pq As List
	pq.Initialize
	pq.add(vvbox)

	' Round up To have the same behaviour As in JavaScript
	Dim target As Int = Ceil(FRACT_BY_POPULATION * maxcolors)

	' first set of colors, sorted by population
	pq = iter(pq, target, histo, 1)

	' Re-sort by the product of pixel occupancy times the size in color space.
	pq = Sort (pq, "PRODUCT",True)
	
	' Next set - generate the median cuts using the (npix * vol) sorting.
	If maxcolors > pq.size Then
		pq = iter(pq, maxcolors, histo, -1)
	End If

	'Reverse To put the highest elements first into the color map
	pq = Sort (pq,"PRODUCT", False)
	
	Dim ccmap As CMap
	ccmap.Initialize
	
	For Each v As VBox In pq
		If v.count (False) > 0 Then 
			ccmap.push (v)
		End If
	Next

	Return ccmap
End Sub


Private Sub iter(lh As List, target As Int, histo() As Int, Comparitor As Int) As List
	Dim niters As Int
	Dim vvbox As VBox

	Do While (niters < MAX_ITERATIONS)
	    vvbox = lh.get(lh.size - 1)
		
	    If vvbox.count(False) = 0 Then
'	        lh.Sort (False)
	        niters=niters +1
	        Exit
	    End If
		
	    lh.removeat(lh.size- 1)

	    'Do the cut
	    Dim vboxes As List = medianCutApply(histo, vvbox)
	    
		If vboxes.IsInitialized Then
			Dim vbox1 As VBox = vboxes.Get(0)
			
			vbox1 = VB_EVAL (vbox1)
			lh.add(vbox1)
		End If
		
		If vboxes.IsInitialized And vboxes.Size>1 Then
	    	Dim vbox2 As VBox = vboxes.Get(1)
			vbox2 = VB_EVAL (vbox2)
			lh.add(vbox2)
		End If

		If Comparitor = 1 Then
				lh = Sort (lh, "COUNT", True)
		Else
				lh = Sort (lh, "PRODUCT", True)
		End If
		
		niters = niters + 1
		
	    If lh.size >= target Then Return lh

		If niters+1 > MAX_ITERATIONS Then Return lh
	Loop
	
	Return lh
End Sub

Private Sub VB_EVAL (v As VBox) As VBox

	v.cnt = v.count (False)
	v.volume = v.getVolume(True)
	v.product = v.cnt * v.volume
	
	Return v
End Sub

private Sub Sort (lh As List, s As String, dir As Boolean) As List
	
	Dim sl As List
	sl.Initialize
	
	'Make a copy of all the vboxes in a CountProduct type so we can quick sort them
	
	For Each v As VBox In lh
		Dim cp As CountProduct
		cp.v = v
		cp.pr = v.product
		cp.cnt = v.cnt
		sl.Add (cp)
	Next
	
	If s = "COUNT" Then
		sl.SortType ("cnt", dir)
	Else
		sl.SortType ("pr", dir)
	End If
	
	Dim rl As List
	rl.Initialize
	
	For Each cp As CountProduct In sl
		rl.Add (cp.v)	
	Next
		
	Return (rl)
	
End Sub