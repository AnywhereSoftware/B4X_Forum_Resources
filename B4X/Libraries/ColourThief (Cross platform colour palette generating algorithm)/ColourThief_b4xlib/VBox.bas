B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	
	Public r1, r2 ,g1, g2, b1, b2 							As Int
	Public avg 												As Map
	Public volume, cnt, product 							As Int
	Public histo(300 * 300) 								As Int
	Private SIGBITS 										As Int = 5
	Private RSHIFT 											As Int = 8 - SIGBITS
	Private CountNull 										As Map	

End Sub

Public Sub Initialize (rr1 As Int, rr2 As Int, gg1 As Int, gg2 As Int, bb1 As Int, bb2 As Int, hist() As Int)

	r1=rr1
	r2=rr2
	g1=gg1
	g2=gg2
	b1=bb1
	b2=bb2
	histo = hist	
		
End Sub


Public Sub toString As String
    Return "r1: " & r1 & " / r2: " & r2 & " / g1: " & g1 & " / g2: " & g2 & " / b1: " & b1 & " / b2: " & b2
End Sub

Public Sub getVolume(recompute As Boolean) As Int
	If volume = 0 Or recompute Then
		volume = ((r2 - r1 + 1) * (g2 - g1 + 1) * (b2 - b1 + 1))
	End If
	
	Return volume
End Sub

Public Sub count(recompute As Boolean) As Int
	
	If recompute = True Or CountNull.IsInitialized = False Then
		
		CountNull.Initialize
		
		Dim i, j, k, index, npix As Int

		For i = r1 To r2
			For j = g1 To g2
				For k = b1 To b2
					index = getColorIndex(i, j, k)
					npix = npix + histo (index)
				Next
			Next
		Next
		
		cnt = npix
	End If
		
	Return cnt
End Sub

Public Sub getColorIndex(r As Int, g As Int, b As Int) As Int
	Return (Bit.ShiftLeft (r , (2 * SIGBITS)) + (Bit.ShiftLeft(g , SIGBITS)) + b)
End Sub

Public Sub clone As VBox
	
	Dim clne As VBox
	clne.Initialize (r1, r2, g1, g2, b1, b2, histo)

	Return clne
End Sub

Public Sub avrg(recompute As Boolean) As ARGBColor
	
	If avg.IsInitialized = False Or recompute Then
		avg.Initialize
		
		Dim ntot, rsum, gsum, bsum, hval, i, j, k, histoindex As Int
		Dim MULT2 As Double = Bit.ShiftLeft (1 , (8 - SIGBITS))
		
		For i = r1 To r2
			For j = g1 To g2
				For k = b1 To b2
					histoindex = getColorIndex(i, j, k)
					
					Dim g As Int
					g = histo(histoindex)

					hval = g
					ntot = ntot + hval
					rsum = rsum + (hval * (i + 0.5) * MULT2)
					gsum = gsum + (hval * (j + 0.5) * MULT2)
					bsum = bsum + (hval * (k + 0.5) * MULT2)
				Next
			Next
		Next
	End If
		
	Dim arr(3) As Double
	
	If ntot > 0 Then
		arr (0) = rsum / ntot
		arr (1) = gsum / ntot
		arr (2) = bsum / ntot
	Else
		arr (0) = (MULT2 * (r1 + r2 + 1) / 2)
		arr (1) = (MULT2 * (g1 + g2 + 1) / 2)
		arr (2) = (MULT2 * (b1 + b2 + 1) / 2)
	End If

	Dim c As ARGBColor
	c.Initialize
	c.a = 255
	c.r = arr(0)
	c.g = arr(1)
	c.b = arr(2)
		
	Return c
	
End Sub

Public Sub contains(pixel As ARGBColor) As Boolean
	Dim rval As Int = Bit.ShiftRight (pixel.r, RSHIFT)
	Dim gval As Int = Bit.ShiftRight (pixel.g, RSHIFT)
	Dim bval As Int = Bit.ShiftRight (pixel.b, RSHIFT)
	Return (rval >= r1 And rval <= r2 And gval >= g1 And gval <= g2 And bval >= b1 And bval <= b2)
End Sub

