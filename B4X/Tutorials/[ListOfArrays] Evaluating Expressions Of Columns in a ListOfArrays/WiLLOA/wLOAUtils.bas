B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.5
@EndOfDesignText@
Sub Process_Globals
	Private dividerChar As String = Chr(0x2015)	
	Private dividerLine As String
	Private EvalExpression As String
	
	Public unusualVals As List
End Sub

'Comment
Public Sub unusualValues As List
	If Not (unusualVals.IsInitialized) Then unusualVals = emptyList
	Return unusualVals
End Sub

'Comment
Public Sub eval(LOA_ As ListOfArrays, colName As String, Expression As String)
	If EvalExpression.Length > 0 Then EvalExpression = EvalExpression & CRLF
	EvalExpression = EvalExpression & "EVAL: " & colName  & " = " & Expression
	Dim e As wLOAEval
	e.Initialize(Me, "Eval")
	e.Eval(LOA_, colName, Expression)
End Sub

'Comment
Public Sub selectIfTrue(LOA_ As ListOfArrays, Expression As String) As ListOfArrays
	Dim e As wLOAEval
	e.Initialize(Me, "Eval")
	Dim lst As List = e.Eval2(LOA_, Expression)
	Dim newLOA As ListOfArrays = LOAUtils.CreateEmpty(LOA_.header) 
	For i = 0 To lst.Size - 1
		If lst.Get(i) = True Then newLOA.AddRow(LOA_.GetRow(i))
	Next
	Return newLOA
End Sub

'Comment
Public Sub constants(nrows As Int, ncols As Int, cons As Object) As ListOfArrays
	Dim consx() As Object = ArgToArray(cons)
	Dim header(ncols) As Object
	For j = 0 To ncols - 1
		header(j) = "c_" & (j + 1)
	Next
	Dim LOA As ListOfArrays = LOAUtils.CreateEmpty(header)
	For i = 0 To nrows - 1
		Dim r(ncols) As Object
		Dim consIndex As Int = -1
		For j = 0 To ncols - 1
			consIndex = consIndex + 1
			If consIndex = consx.length Then consIndex = 0
			r(j) = consx(consIndex)
		Next
		LOA.AddRow(r)
	Next
	Return LOA
End Sub

'Comment
Public Sub collect(nrows As Int, ncols As Int, collection As Object) As ListOfArrays
	Dim values() As Object = ArgToArray(collection)
	Dim header(ncols) As Object
	For j = 0 To ncols - 1
		header(j) = "c_" & (j + 1)
	Next
	Dim LOA As ListOfArrays = LOAUtils.CreateEmpty(header)
	Dim k As Int = - 1
	For i = 0 To nrows - 1
		Dim r(ncols) As Object
		For j = 0 To ncols - 1
			k = k + 1
			If k > values.Length - 1 Then k = 0
			r(j) = values(k)
		Next
		LOA.AddRow(r)
	Next
	Return LOA
End Sub

'Comment
Public Sub sequence(nrows As Int, ncols As Int, range_ As Object) As ListOfArrays
	Dim rangex() As Object = ArgToArray(range_)
	Dim startat, endat, stepsize As Int
	Select rangex.Length
		Case 0
			Return constants(nrows, ncols, Null)
		Case 1
			startat = 0
			endat = rangex(0)
			stepsize = 1
		Case 2
			startat = rangex(0)
			endat = rangex(1)
			stepsize = 1
		Case 3
			startat = rangex(0)
			endat = rangex(1)
			stepsize = rangex(2)
	End Select
	Dim nvalues As Int = Floor((endat - startat + 1) / stepsize)
	Dim result(nvalues + 1) As Object
	Dim k As Int = -1
	For j = startat To endat Step stepsize
		k = k + 1
		result(k) = j
	Next
	Return constants(nrows, ncols, result)
End Sub

'Comment
Public Sub randomInt(nrows As Int, ncols As Int, range_ As Object) As ListOfArrays
	Dim rangex() As Object = ArgToArray(range_)
	Dim startat, endat As Int
	Select rangex.Length
		Case 0
			Return constants(nrows, ncols, Null)
		Case 1
			startat = 0
			endat = rangex(0)
		Case Else
			startat = rangex(0)
			endat = rangex(1)
	End Select
	
	Dim header(ncols) As Object
	For j = 0 To ncols - 1
		header(j) = "c_" & (j + 1)
	Next
	Dim LOA As ListOfArrays = LOAUtils.CreateEmpty(header)
	For i = 0 To nrows - 1
		Dim r(ncols) As Object
		For j = 0 To ncols - 1
			r(j) = Rnd(startat, endat + 1)
		Next
		LOA.AddRow(r)
	Next
	Return LOA
End Sub

'Comment
Public Sub randomDouble(nrows As Int, ncols As Int, decimals As Int) As ListOfArrays
	Dim multx As Long = Power(10, decimals)
	Dim scale As Double = 1 / multx
	
	Dim header(ncols) As Object
	For j = 0 To ncols - 1
		header(j) = "c_" & (j + 1)
	Next
	Dim LOA As ListOfArrays = LOAUtils.CreateEmpty(header)
	For i = 0 To nrows - 1
		Dim r(ncols) As Object
		For j = 0 To ncols - 1
			Dim rndnum As Long = Rnd(0, multx)
			Dim numb As Double = scale * rndnum
			r(j) = numb
		Next
		LOA.AddRow(r)
	Next
	Return LOA
End Sub

'Comment
Public Sub selectCols(LOA As ListOfArrays, selection As Object) As ListOfArrays
	Dim selx() As Object = ArgToArray(selection)
	Dim ncols As Int = selx.length
	Dim header(ncols) As Object
	For j = 0 To ncols - 1
		header(j) = selx(j)
	Next
	Dim res As ListOfArrays = LOAUtils.CreateEmpty(header)
	Dim colIndices(ncols) As Int
	For j = 0 To ncols - 1
		Dim cname As String = selx(j)
		colIndices(j) = LOA.mIndicesMap.Get(cname)
	Next
	Dim iter As LOASet = LOA.CreateLOASet
	Do While iter.NextRow
		Dim newRow(ncols) As Object
		Dim row() As Object = iter.Row
		For j = 0 To ncols - 1
			newRow(j) = row(colIndices(j))
		Next
		res.AddRow(newRow)
	Loop
	Return res		
End Sub

'Comment
Public Sub excludeCols(LOA As ListOfArrays, selection As Object) As ListOfArrays
	Dim selx() As Object = ArgToArray(selection)
	Dim ncols As Int = selx.length
	Dim header() As Object = LOA.header
	Dim skip(header.length) As Boolean
	For j = 0 To ncols - 1
		Dim exclname As String = selx(j)
		Dim index As Int = LOA.mIndicesMap.GetDefault(exclname.toLowerCase, -1)
		skip(index) = True	
	Next
	Dim lst As List: lst.Initialize
	For j = 0 To header.length - 1
		If Not(skip(j)) Then lst.Add(header(j))
	Next
	Return selectCols(LOA, lst)
End Sub

'Comment
Public Sub display(LOA As ListOfArrays, showNRows As Int, decimals As Int)
	Log(TAB)
	If EvalExpression.Length > 0 Then Log(EvalExpression)
	EvalExpression = ""
	
	Dim sb As StringBuilder
	Dim nrows As Int = LOA.mInternalArray.Size - 1
	Dim ncols As Int = LOA.NumberOfColumns
	Dim h() As Object = LOA.header
	Dim widths(h.Length) As Int
	For j = 0 To ncols - 1
		Dim len As Int = h(j).As(String).length
		widths(j) = len
	Next

	For i = 0 To nrows - 1
		Dim r() As Object = LOA.GetRow(i)	
		For j = 0 To ncols - 1
			Dim obj As Object = r(j)
			If obj = Null Then 
				obj = "--"
			End If
			Dim s As String
			If IsNumber(obj) And decimals > -1 Then 
				s = NumberFormat2(obj, 1, decimals, decimals, False)
			Else
				s = obj	
			End If
			Dim m As Int  = s.Length
			If m < 25 Then
				If m > widths(j) Then widths(j) = m
			End If
		Next
	Next

	sb.Initialize
	For j = 0 To ncols - 1
		Dim s As String = h(j)
		Dim nsp As Int = 1.6 * (widths(j) - s.Length)
		For k = 0 To nsp
			s = s & " "
		Next
		sb.Append(s)
		If j < ncols - 1 Then sb.Append(TAB)
	Next
	Log(sb.ToString)
	Log(separatorLine & separatorLine)
	
	Dim showN As Int = showNRows
	If showN = 0 Then showN = nrows
	For i = 0 To showN - 1
		sb.Initialize
		Dim r(ncols) As Object = LOA.GetRow(i)
		For j = 0 To ncols - 1
			Dim val As Object = r(j)
			If val = Null Then 
				val = "--"
			End If

			If decimals > -1 And IsNumber(val) Then 
				s = NumberFormat2(val, 1, decimals, decimals, False)
			Else
				s = val
				If s.Length > widths(j) Then s = s.SubString2(0, widths(j) - 1) & Chr(0X2026)
			End If
			Dim nsp As Int = 1.6 * (widths(j) - s.Length)
			For k = 0 To nsp
				s = s & " "
			Next
			sb.Append(s)
			If j < ncols - 1 Then sb.Append(TAB)
		Next
		Log(sb.ToString)
	Next
	Log($"${separatorLine} #rows=${nrows} #cols=${ncols}"$)
End Sub

'Comment
Public Sub Eval_Function (Name As String, Values As List) As String
	Dim LOA As ListOfArrays = Values.Get(0)
	Dim Temps As Map = Values.Get(1)
	Dim nrows As Int = Values.Get(2)
	Values.RemoveAt(0)
	Values.RemoveAt(0)
	Values.RemoveAt(0)
	
	Dim nargs As Int = Values.Size
	Dim matrix(nrows, nargs) As Object
	For j = 0 To nargs - 1
		Dim ref As String = Values.get(j)
		Dim lst As List
		If LOA.mIndicesMap.ContainsKey(ref) Then 
			lst = LOA.GetColumn(ref)
		Else if Temps.ContainsKey(ref) Then 
			Dim obj As Object = Temps.Get(ref)
			If obj Is List Then 
				lst = obj
			Else
				lst.initialize
				For i = 0 To nrows - 1
					lst.Add(obj)
				Next
			End If
		Else if IsNumber(ref) Then 
			lst.initialize
			For i = 0 To nrows - 1
				lst.Add(ref)
			Next
		Else If ref = "false" Or ref = "true" Then 
			lst.initialize
			For i = 0 To nrows - 1
				lst.Add(ref.As(Boolean))
			Next
		Else
			'This is an error: ref should be:
			'keyword of LOA
			'keyword of temps, includes tokenized string literals
			'number literal
			'false, true
			Log("???" & ref)
		End If
		For i = 0 To nrows - 1
			matrix(i, j) = lst.Get(i)
		Next
	Next
	Dim resultLst As List
	resultLst.Initialize

	Select Name 'it will be lower case
		Case "min"
			For i = 0 To nrows - 1
				Dim minimum As Double = 1 / 0
				For j = 0 To nargs - 1
					Dim obj As Object = matrix(i,j)
					If IsNumber(obj) Then 
						Dim val As Double = obj
						If val < minimum Then minimum = val
					End If
				Next
				resultLst.Add(minimum)	
			Next
		Case "max"
			For i = 0 To nrows - 1
				Dim maximum As Double = -1 / 0
				For j = 0 To nargs - 1
					Dim obj As Object = matrix(i,j)
					If IsNumber(obj) Then 
						Dim val As Double = obj
						If val > maximum Then maximum = val
					End If
				Next
				resultLst.Add(maximum)	
			Next
		Case "sin"
			For i = 0 To nrows - 1
				Dim obj As Object = matrix(i,0)
				If IsNumber(obj) Then 
					Dim val As Double = obj
					resultLst.Add(SinD(val))
				Else
					resultLst.Add(Null)		
				End If
			Next
		Case "cos"
			For i = 0 To nrows - 1
				Dim obj As Object = matrix(i,0)
				If IsNumber(obj) Then 
					Dim val As Double = obj
					resultLst.Add(CosD(val))	
				Else
					resultLst.Add(Null)		
				End If
			Next
		Case "tan"
			For i = 0 To nrows - 1
				Dim obj As Object = matrix(i,0)
				If IsNumber(obj) Then 
					Dim val As Double = obj
					resultLst.Add(TanD(val))	
				Else
					resultLst.Add(Null)		
				End If
			Next
		Case "abs"
			For i = 0 To nrows - 1
				Dim obj As Object = matrix(i,0)
				If IsNumber(obj) Then 
					Dim val As Double = obj
					resultLst.Add(Abs(val))	
				Else
					resultLst.Add(Null)		
				End If
			Next
		Case "sqrt"
			For i = 0 To nrows - 1
				Dim obj As Object = matrix(i,0)
				If IsNumber(obj) Then 
					Dim val As Double = obj
					resultLst.Add(Sqrt(val))	
				Else
					resultLst.Add(Null)		
				End If
			Next
		Case "atan"
			For i = 0 To nrows - 1
				Dim obj0 As Object = matrix(i,0)
				Dim obj1 As Object = matrix(i,1)
				If IsNumber(obj0) And IsNumber(obj1) Then 
					Dim val0 As Double = obj0
					Dim val1 As Double = obj1
					resultLst.Add(ATan2D(val0, val1))	
				Else
					resultLst.Add(Null)		
				End If
			Next
		Case "power"
			For i = 0 To nrows - 1
				Dim obj0 As Object = matrix(i,0)
				Dim obj1 As Object = matrix(i,1)
				If IsNumber(obj0) And IsNumber(obj1) Then 
					Dim val0 As Double = obj0
					Dim val1 As Double = obj1
					resultLst.Add(Power(val0, val1))	
				Else
					resultLst.Add(Null)		
				End If
			Next
		Case "logarithm"
			For i = 0 To nrows - 1
				Dim obj0 As Object = matrix(i,0)
				Dim obj1 As Object = matrix(i,1)
				If IsNumber(obj0) And IsNumber(obj1) Then 
					Dim val0 As Double = obj0
					Dim val1 As Double = obj1
					resultLst.Add(Logarithm(val0, val1))	
				Else
					resultLst.Add(Null)		
				End If
			Next
		Case "and", "nand"
			For i = 0 To nrows - 1
				Dim res As Boolean = True
				For j = 0 To nargs - 1
					Dim obj As Object = matrix(i,j)
					If obj Is Boolean Then 
						If False = obj Then
							res = False
							Exit
						End If
					Else
						res = False
						Exit
					End If
				Next
				If Name.StartsWith("n") Then res = Not(res)
				resultLst.Add(res)
			Next
		Case "or", "nor"
			For i = 0 To nrows - 1
				Dim res As Boolean = False
				For j = 0 To nargs - 1
					Dim obj As Object = matrix(i,j)
					If obj Is Boolean Then 
						If True = matrix(i, j) Then
							res = True
							Exit
						End If
					End If
				Next
				If Name.StartsWith("n") Then res = Not(res)
				resultLst.Add(res)
			Next
		Case "asc"
			For i = 0 To nrows - 1
				Dim obj As Object = matrix(i,0)
				If obj Is String Then 
					resultLst.Add(Asc(matrix(i, 0)))	
				Else
					resultLst.Add(Null)	
				End If
			Next
		Case "chr"
			For i = 0 To nrows - 1
				Dim obj As Object = matrix(i,0)
				If IsNumber(obj) Then 
					Dim vali As Int = obj
					resultLst.Add(Chr(vali))	
				Else
					resultLst.Add(Null)		
				End If
			Next
		Case "length"
			For i = 0 To nrows - 1
				Dim obj As Object = matrix(i,0)
				If obj Is String Then 
					resultLst.Add(obj.As(String).Length)
				Else
					resultLst.Add(Null)	
				End If
			Next
		Case Else
			Log("Invalid function: " & Name)
			Dim e As wLOAEval = Sender
			e.Error = True
			Return Null
	End Select
	Dim newTemp As String = "_temp_" & Temps.Size
	Temps.Put(newTemp, resultLst)
	Return newTemp
End Sub

'Comment
Public Sub renameColumns(LOA As ListOfArrays, mp As Map)
	Dim indexMap As Map = LOA.mIndicesMap
	For Each kw As String In mp.Keys
		Dim kwl As String = kw.toLowerCase
		If indexMap.ContainsKey(kwl) Then 
			Dim index As Int = indexMap.Get(kwl)
			Dim newName As String = mp.Get(kw)
			indexMap.Put(newName.toLowerCase, index)
			LOA.Header(index) = newName
			Dim removals As List: removals.initialize
			For Each nam As String In indexMap.Keys
				If nam.ToLowerCase = kwl Then removals.Add(nam)
			Next
			For Each nam As String In removals
				indexMap.Remove(nam)
			Next
		End If
	Next
End Sub

'Comment
Public Sub shuffleRows(LOA As ListOfArrays)
	Dim ncols As Int = LOA.NumberOfColumns	
	Dim iter As LOASet = LOA.CreateLOASet
	Do While iter.NextRow
		For k = 1 To 5 * ncols
			Dim i1 As Int = Rnd(0, ncols)
			Dim i2 As Int = Rnd(0, ncols)
			Dim temp As Object = iter.Row(i1)
			iter.Row(i1) = iter.Row(i2)
			iter.Row(i2) = temp
		Next
	Loop
End Sub

'Comment
Public Sub shuffleCols(LOA As ListOfArrays)
	For j = 0 To LOA.NumberOfColumns - 1
		Dim lst As List = LOA.GetColumn(j)
		For k = 1 To 5 * lst.Size
			Dim i1 As Int = Rnd(0, lst.Size)
			Dim i2 As Int = Rnd(0, lst.Size)
			Dim temp As Object = lst.get(i1)
			lst.set(i1, lst.get(i2))
			lst.set(i2, temp)
		Next
		LOA.SetColumn(j, lst)
	Next
End Sub

'Comment
Public Sub range(startat As Int, endAt As Int, stepSize As Int) As Object()
	Dim n As Int = (endAt - startat + 1) / stepSize
	Dim res(n) As Object
	Dim index As Int 
	For i = startat To endAt Step stepSize
		res(index) = i
		index = index + 1
	Next
	Return res
End Sub

'Comment
Public Sub mergeMatch(LOA1 As ListOfArrays, LOA2 As ListOfArrays)
	Dim n1 As Int = LOA1.mInternalArray.size
	Dim n2 As Int = LOA2.mInternalArray.size
	If n1 < n2 Then 
		For i = n1 To n2 - 1
			Dim r(LOA1.NumberOfColumns) As Object
			For j = 0 To LOA1.NumberOfColumns - 1
				r(j) = Null
			Next
			LOA1.AddRow(r)
		Next
	Else if n2 < n1 Then 
		For i = n2 To n1 - 1
			Dim r(LOA2.NumberOfColumns) As Object
			For j = 0 To LOA2.NumberOfColumns - 1
				r(j) = Null
			Next
			LOA2.AddRow(r)
		Next
	End If
	LOA1.Merge(LOA2)
End Sub

'Comment
Public Sub ArgToArray(arg As Object) As Object()
	If arg = Null Then 
		Return Array()
	Else If isArray(arg) Then
		Return arg
	Else if arg Is List Then
		Dim lst As List = arg
		Dim result(lst.size) As Object
		For i = 0 To lst.Size - 1
			result(i) = lst.get(i)
		Next
		Return result
	Else if arg Is String Then
		If arg.As(String).Length = 0 Then 
			Return Array()
		Else 
			Return Array(arg)
		End If
	Else
		Return Array(arg)
	End If
End Sub

'Comment
Public Sub isArray(obj As Object) As Boolean
	If obj = Null Then Return False
	Return GetType(obj).StartsWith("[")
End Sub

'Comment
Public Sub emptyList As List
	Dim lst As List
	lst.Initialize
	Return lst
End Sub

'Comment
Public Sub separatorLine As String
	If dividerLine.Length > 0 Then Return dividerLine
	Dim sb As StringBuilder
	sb.initialize
	For i = 1 To 12
		sb.Append(dividerChar)
	Next
	dividerLine = sb.toString
	Return dividerLine
End Sub
