B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.3
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub
Sub deg2rad(Angle2 As Double) As Double
	Return Angle2* 0.01745329252
End Sub
Sub Rad2Deg(angle2 As Double) As Double
	angle2=angle2*57.2957795
'	If angle2<0 Then angle2=angle2+360
	Return angle2
End Sub
Sub CleanList(points As List) As List
	Private dataset As List
	Private flag=False As Boolean
	dataset.Initialize
	For x=0 To points.Size-1
		Private t() As Int=points.Get(x)
		If dataset.Size=0 Then
			dataset.Add(t)
		
		Else
			flag=False
			For y=0 To dataset.Size-1
				Private st()=dataset.Get(y) As Int
				flag=ComparePoints(st,t)
				If flag=False Then Continue
			Next
			If flag=False Then	dataset.Add(t)
		End If
	Next
	Return dataset
End Sub
Sub FindMinYPoint(datal As List) As Int()
	Private firstPoint() As Int = datal.Get(0)
	For x=0 To datal.Size-1
		Private point() As Int=datal.Get(x)
		If point(1)<firstPoint(1) Then
			firstPoint=point
		End If
	Next
	Return firstPoint
End Sub
' Placeholder voor de 'distance'-functie, deze moet je nog definiëren
Sub distance(p1() As Int, p2() As Int) As Double
	' Hier moet je de formule voor de afstand tussen twee punten invoeren.
	' Bijv: de Euclidische afstand tussen twee 2D-punten.
	Private dx As Double = p1(0) - p2(0)
	Private dy As Double = p1(1) - p2(1)
	Return Sqrt(dx * dx + dy * dy)
End Sub
Sub NearestPoints(points As List, p() As Int, k As Int,stp As Int) As List
	' Bereken de k dichtstbijzijnde buren van een punt.
	#if debug
	Log("nearest points")
	#end if
	' Maak een lijst om de afstanden en de bijbehorende punten op te slaan
	Private distances As List
	distances.Initialize
	For Each point() As Int In points
		Private dist As Double = distance(p, point) ' Roep de functie 'distance' aan die de afstand berekent
'		Private Angle1 As Int=Rad2Deg(Angle(p,point,prevousangle))
		Private pointAndDist As sorttype
		pointAndDist.distance=dist
'		pointAndDist.Angle=Angle1
		pointAndDist.point=point
		distances.Add(pointAndDist)
	Next

	' Sorteer de lijst op afstand
	distances.SortType("distance", True) ' Sorteer op basis van de afstand (in oplopende volgorde)

	' Selecteer de k dichtstbijzijnde punten
	Private nearestNeighbours As List
	nearestNeighbours.Initialize
	For i = 0 To Min(k, distances.Size) - 1
		Private neighbour As sorttype = distances.Get(i)
		#if debug
		Log("buren" & neighbour.point(0) & "--" & neighbour.point(1) & "  afstand" & neighbour.distance & " angle: " & Rad2Deg(neighbour.angle))
		
		If stp=13 Then
'			cvs.DrawCircle(neighbour.point(0),neighbour.point(1),8,fx.Colors.blue,True,1)
			main.cvs.DrawCircle(p(0),p(1),8,fx.Colors.black,True,1)
			Main.cvs.DrawText(neighbour.angle,neighbour.point(0),neighbour.point(1),fx.DefaultFont(16),fx.Colors.DarkGray,"LEFT")
		End If
		#end if
		nearestNeighbours.Add(neighbour)
	Next
	#if debug
	Log("----------")
	#end if
	Return nearestNeighbours
End Sub
Sub Anglenew(PointA() As Int, PointB() As Int) As Double
	' Bereken de hoek met behulp van atan2
	Dim Angleres As Double = ATan2(PointB(1) - PointA(1), PointB(0) - PointA(0))

	' Meet de hoek vanuit de linkerkant van de Y-as
	Angleres = cPI - Angleres

	' Zorg ervoor dat de hoek tussen 0 en 2 Pi ligt
	If Angleres < 0 Then
		Angleres = Angleres + (2 * cPI)
	End If

	Return Angleres
End Sub

Sub SortByAngle1(Points As List, TargetPoint() As Int, PrevAngle As Double) As List
	Dim SortedPoints As List
	SortedPoints.Initialize

	Dim Candidates As List
	Candidates.Initialize

	For p = 0 To Points.Size - 1
		Dim Point As sorttype = Points.Get(p)
		

		' Call your Angle function to calculate the angle between points
		Dim AngleDiff As Double = PrevAngle - Anglenew(Point.point, TargetPoint)
		If AngleDiff < 0 Then
			AngleDiff = AngleDiff + (2 * cPI) ' B4J uses cPI for π constant
		End If
		If AngleDiff>deg2rad(273) Then
'			Log("overflow" & Rad2Deg(AngleDiff)) ''Angleres=2*cpi-angleres
			AngleDiff=2*cPI-AngleDiff
			
		End If
		Point.Angle=AngleDiff
		Candidates.Add(Point)
	Next
	' Sort the candidates list by "angle" in descending order
	Candidates.SortType("Angle", False) ' False for descending order
		#if debug
	For x=0 To Candidates.Size-1
		Private dis1 As sorttype =Candidates.Get(x)
	
	
		Log("Candidates:" & dis1.point(0) & "--"  & dis1.point(1) & " angle: " & NumberFormat((Rad2Deg(dis1.Angle)),1,3)  & "  prevang " & NumberFormat(Rad2Deg(PrevAngle),1,1))
		
	Next
	Log("-------nieuw-------------")
	#end if
	Return Candidates
End Sub


Sub ConvertToArray(tp As sorttype) As Int()
	Private ar(2) As Int
	ar(0)=tp.point(0)
	ar(1)=tp.point(1)
	Return ar
End Sub
Sub RemovePoint (dataset As List,point() As Int)
	For x=0 To dataset.size-1
		Private tt() As Int=dataset.Get(x)
		If tt(0)=point(0) And tt(1)=point(1) Then
			dataset.RemoveAt(x)
			Exit
		End If
	Next
End Sub
Sub IntersectsQ(p1() As Int, p2 As sorttype, p3() As Int, p4() As Int) As Boolean
	' p1, p2, p3, p4 zijn punten in de vorm van een lijst [x, y]
	
	Private p0x As Double = p1(0)
	Private p0y As Double = p1(1)
	Private p1x As Double = p2.point(0)
	Private p1y As Double = p2.point(1)
	Private p2x As Double = p3(0)
	Private p2y As Double = p3(1)
	Private p3x As Double = p4(0)
	Private p3y As Double = p4(1)
	#if debug
	Log("intersects:p0x " & p0x & " p0y:" & p0y & " p1y:" & p1x & " p1y:" & p1y& " p2x " & p2x & " p2y:" & p2y & " p3y:" & p3x & " p3y:" & p3y )
	#end if
	Private s10x As Double = p1x - p0x
	Private s10y As Double = p1y - p0y
	Private s32x As Double = p3x - p2x
	Private s32y As Double = p3y - p2y

	Private denom As Double = s10x * s32y - s32x * s10y
	If denom = 0 Then
		Return False
	End If

	Private denom_positive As Boolean = denom > 0
	Private s02x As Double = p0x - p2x
	Private s02y As Double = p0y - p2y
	Private s_numer As Double = s10x * s02y - s10y * s02x
	If (s_numer < 0) = denom_positive Then
		Return False
	End If

	Private t_numer As Double = s32x * s02y - s32y * s02x
	If (t_numer < 0) = denom_positive Then
		Return False
	End If

	If (s_numer > denom) = denom_positive Or (t_numer > denom) = denom_positive Then
		Return False
	End If

	Private t As Double = t_numer / denom
	Private x As Double = p0x + (t * s10x)
	Private y As Double = p0y + (t * s10y)

	If (x = p1x And y = p1y) Or (x = p2x And y = p2y) Or (x = p3x And y = p3y) Or (x = p0x And y = p0y) Then
		Return False
	End If
	#if debug
	Log(" intersectie")
	#end if
	Return True
End Sub
Sub ComparePoints(p1() As Int, p2() As Int) As Boolean
	If (p1(0)=p2(0) And p1(1)=p2(1)) Then Return True
	Return False
End Sub
Sub concave(pointslist As List, k As Int) As List
	' Bereken de concave hull voor een lijst van punten. Elk punt is een lijst
	' met x- en y-coördinaten. K bepaalt het aantal te beschouwen buren.
	Private kk As Int = Max(k, 3) ' make sure k >= 3
	Private dataset As List = CleanList(pointslist) ' remove equal points
	If dataset.Size < 3 Then
		Return Null ' a minimum of 3 dissimilar points is required
	End If
	If dataset.Size = 3 Then
		Return dataset ' for a 3 points dataset, the polygon is the dataset itself
	End If
	#if debug
	Log("k factor" & k)
	#end if
	Private firstPoint() As Int = FindMinYPoint(dataset)
	#if debug
	Log("first: " & firstPoint(1))
	#end if
	Private currentPoint() As Int = firstPoint
	Private hull As List
	hull.Initialize
	hull.Add(firstPoint) ' Initialize hull

	dataset.RemoveAt(dataset.IndexOf(firstPoint)) ' Verwijder het verwerkte punt

	Private previousAngle As Double = 0
	Private Stp=2 As Int
	Private stop=Stp+kk As Int

	Log(stop & ","& kk)
	Do While (ComparePoints(currentPoint,firstPoint)=False Or (Stp = 2)) And (dataset.Size > 0)
		If Stp = 5 Then	dataset.Add(firstPoint) ' add the firstPoint again

		Private kNearestPoints As List = NearestPoints(dataset, currentPoint, kk,Stp)

		Private cPoints As List = SortByAngle1(kNearestPoints, currentPoint, previousAngle) ' sort the candidates (neighbours) in descending order of right-hand turn
		Private its As Boolean = True
		Private i As Int = -1
		Do While (its = True) And (i < cPoints.Size-1) ' select the first candidate that does not intersect any of the polygon edges
			i = i + 1
			If ConvertToArray(cPoints.Get(i)) = firstPoint Then
				Private lastPoint = 1 As Int
			Else
				Private lastPoint = 0 As Int
			End If
			Private j As Int = 2
			its = False
			#if debug
			Log("hullsize: " & hull.Size & " step " & Stp & " j " & j & " lastpoint: " & lastPoint)
			#end if
			Do While (its = False) And (j < hull.Size - lastPoint)
				#if debug
				Log("hullMinLastpoint: " & (hull.Size-lastPoint) & " j" & j & " i: " & i)
				#end if
				its = IntersectsQ(hull.Get(Stp - 2), cPoints.Get(i), hull.get(Stp - 1 - j), hull.Get(Stp - j))
				j = j + 1
			Loop
		Loop
		
		If its = True Then ' since all candidates intersect at least one edge, try again with a higher number of neighbours
			Log("intersects all candidates")
'			Return hull
			Return concave(pointslist, kk + 1)
		End If
		currentPoint = ConvertToArray(cPoints.Get(i))
		
		hull.Add(currentPoint) ' a valid candidate was found
		#if debug
		Log("hullsize:"& hull.Size & " step " & Stp)
		#end if

		previousAngle = Anglenew(hull.Get(Stp-2), hull.Get(Stp - 1))
		
		#if debug
		Log("currentpoint:" & currentPoint(0) & "-" & currentPoint(1) & " previous angle: " & Rad2Deg(previousAngle))
		#end if
	
		RemovePoint(dataset,currentPoint)
		Stp = Stp + 1
	Loop
	Private allInside As Boolean = True
	i = dataset.Size
	#if debug
	Log("datasetsize" & dataset.Size)
	#end if
	Do While (allInside = True) And (i > 0) ' check if all the given points are inside the computed polygon
		allInside = PointInPolygon(dataset.Get(i-1), hull)
		i = i - 1
	Loop
'	allInside=True
	If allInside = False Then
		Log("not all inside")
		Return concave(pointslist, kk + 1) ' since at least one point is out of the computed polygon, try again with a higher number of neighbours
	End If
	#if debug
	Log("hull gevonden")
	#end if
	For x=0 To hull.Size-1
		Private qu() As Int=hull.Get(x)
		Private quu As xy
		quu.x=qu(0)
		quu.y=qu(1)
		hull.Set(x,quu)
	Next
	Return hull ' a valid hull was found!
End Sub

' Function to check if a point is inside the polygon
Sub PointInPolygon( point()As Int,polygon As List) As Boolean
	Dim numPoints As Int = polygon.Size
	Dim x As Double = point(0)
	Dim y As Double = point(1)
	Dim inside As Boolean = False
	Dim j As Int = numPoints - 1

	For i = 0 To numPoints - 1
		Private p1() As Int = polygon.Get(i)
		Dim xi As Double = p1(0)
		Dim yi As Double = p1(1)
		Private p2() As Int=polygon.get(j)
		Dim xj As Double = p2(0)
		Dim yj As Double = p2(1)
        
		If ((yi > y) <> (yj > y)) And (x < (xj - xi) * (y - yi) / (yj - yi) + xi) Then
			inside = True
		End If
		j = i
	Next
	'    Log("point in polygon:" & inside)
	
	Return inside
End Sub



'1: kk ← Max[k,3] ► make sure k>=3
'2: dataset ← CleanList[pointsList] ► remove equal points
'3: If Length[dataset] < 3
'4: Return[null] ► a minimum of 3 dissimilar points Is required
'5: If Length[dataset] = 3
'6: Return[dataset] ► For a 3 points dataset, the polygon Is the dataset itself
'7: kk ← Min[kk,Length[dataset]-1] ► make sure that k neighbours can be found
'8: firstPoint ← FindMinYPoint[dataset]
'9: hull ← {firstPoint} ► initialize the hull with the first point
'10: currentPoint ← firstPoint
'11: dataset ← RemovePoint[dataset,firstPoint] ► remove the first point
'12: previousAngle ← 0
'13: Step ← 2
'14: While ((currentPoint≠firstPoint)Or(Step=2))And(Length[dataset]>0)
'15: If Step=5
'16: dataset ← AddPoint[dataset,firstPoint] ► add the firstPoint again
'17: kNearestPoints ← NearestPoints[dataset,currentPoint,kk] ► find the nearest neighbours
'18: cPoints ← SortByAngle[kNearestPoints,currentPoint,prevAngle] ► sort the candidates
'(neighbours) in descending order of right-hand turn
'19: its ← True
'20: i ← 0
'21: While (its=True)And(i<Length[cPoints]) ► Select the first candidate that does Not Intersects any
'of the polygon edges
'22: i++
'23: If cPointsi=firstPoint
'24: lastPoint ← 1
'25: Else
'26: lastPoint ← 0
'27: j ← 2
'28: its ← False
'29: While (its=False)And(j<Length[hull]-lastPoint)
'30: its ← IntersectsQ[{hullstep-1,cPointsi},{hullstep-1-j,hullstep-j}]
'31: j++
'32: If its=True ► since all candidates intersect at least one edge, Try again with a higher number of neighbours
'33: Return[ConcaveHull[pointsList,kk+1]]
'34: currentPoint ← cPointsi
'35: hull ← AddPoint[hull,currentPoint] ► a valid candidate was found
'36: prevAngle ← Angle[hullstep,hullstep-1]
'37: dataset ← RemovePoint[dataset,currentPoint]
'38: Step++
'39: allInside ← True
'40: i ← Length[dataset]
'41: While (allInside=True)And(i>0) ► check If all the given points are inside the computed polygon
'42: allInside ← PointInPolygonQ[dataseti,hull]
'43: i--
'44: If allInside=False
'45: Return[ConcaveHull[pointsList,kk+1]] ► since at least one point Is out of the computed polygon,
'Try again with a higher number of neighbours
'46: Return[hull] ► a valid hull was found!