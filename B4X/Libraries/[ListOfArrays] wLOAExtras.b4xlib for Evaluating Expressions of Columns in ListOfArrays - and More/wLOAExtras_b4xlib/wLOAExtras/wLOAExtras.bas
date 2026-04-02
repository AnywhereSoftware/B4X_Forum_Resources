B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private dividerChar As String = Chr(0x2015)	
	Private dividerLine As String
	Private EvalExpression As String
	Private unusualVals As List

	Public DefaultStyle As String = "c"
	Private alph As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	
	Private callback As Object
	Private nameSub As String
	Private functionNames As Map
	
	Private weekdays() As String = Array As String("", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
	Private monthnames() As String = Array As String("", "January", "February", "March", "April", "May", "June", _
			"July", "August", "September", "October", "November", "December")
End Sub

Public Sub Initialize(calling As Object)
	callback = calling
End Sub

Private Sub applyStyle(index As Int) As String
	Dim head As String
	If SubExists(callback, nameSub) Then 
		head = CallSub2(callback, nameSub, index)
	Else
		Dim s As String = DefaultStyle.charAt(0)
		Select s
			Case "c": head = "c_" & (index + 1)
			Case "C": head = "C" & (index + 1)
			Case "_": head = "_" & (index + 1) & "_"
			Case "A", "a" 
				Dim c As String = alph.charAt(index Mod 26)
				Dim k As Int = index / 26
				Dim name As String
				For j = 0 To k
					name = name & c
				Next
				If s = "A" Then head = name Else head = name.toLowerCase
		End Select
	End If
	Return head
End Sub

#Region LOA Methods
'Used to create call back for generating  column names
Public Sub NameSchema(callingModule As Object, subName As String)
	callback = callingModule
	nameSub = subName
End Sub

'Computes the expression applied sequentially to each column specified.
'Results are appended to original LOA. New names are same as old names with _R as suffix.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'In the expression string, you can use ? to use the name of the column currently worked on
Public Sub EvalAppend(LOA_ As ListOfArrays, colspec As Object, Expression As String) As ListOfArrays
	Return evalGeneric(LOA_, colspec, Expression, "append")
End Sub

'Computes the expression applied sequentially to each column specified.
'Results replace the original columns. Names remain unchanged.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() the operations will be applied to all columns
'In the expression string, you can use ? to use the name of the column currently worked on
Public Sub EvalReplace(LOA_ As ListOfArrays, colspec As Object, Expression As String) As ListOfArrays
	Return evalGeneric(LOA_, colspec, Expression, "replace")
End Sub

'Computes the expression applied sequentially to each column specified.
'Results are placed in a new LOA. The Original LOA remains unchanged.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() the operations will be applied to all columns
'In the expression string, you can use ? to use the name of the column currently worked on
Public Sub EvalCreate(LOA_ As ListOfArrays, colspec As Object, Expression As String) As ListOfArrays
	Return evalGeneric(LOA_, colspec, Expression, "create")
End Sub

'Used internally by wEval
Public Sub Eval_Function (Name As String, Values As List) As String
	Dim LOA As ListOfArrays = Values.Get(0)
	Dim Temps As Map = Values.Get(1)
	Dim nrows As Int = Values.Get(2)
	Values.RemoveAt(0)
	Values.RemoveAt(0)
	Values.RemoveAt(0)
	Dim ncols As Int = Values.Size
	Dim matrix(nrows, ncols) As Object
	For j = 0 To ncols - 1
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
			Log("???" & ref)
		End If
		For i = 0 To nrows - 1
			matrix(i, j) = lst.Get(i)
		Next
	Next
	Dim resultLst As List
	resultLst.Initialize
	If SubExists(Me, Name & "_X") Then 
		resultLst = CallSub2(Me, Name & "_X", Array(nrows, ncols, matrix)) 
	Else
		Dim maybe As String
	#if DEMO
		Dim methodLOA As String
		Dim ar() As String = getJavaLine
		Dim prefix As String = ar(0)
		Dim foundStr As String = ar(1)
		Dim LOAName As String
		If foundStr.Length > 0 Then 
			methodLOA = getB4XCallingLine(prefix, foundStr)
			Log(methodLOA)
			LOAName = methodLOA.SubString(methodLOA.indexof("(") + 1)
			Dim k As Int = LOAName.IndexOf(",")
			If k > -1 Then LOAName = LOAName.SubString2(0, k)
		End If
		maybe = closestName2(LOA, Name)
		If maybe.Length > 0 Then maybe = $" (the closest name found is '${maybe}')"$
		If methodLOA.Length > 0 Then 			
			Log($"ERR: Unknown function '${Name}' in: ${methodLOA}  ${maybe}"$)
		Else
			Log($"ERR: Unknown function '${Name}'  ${maybe})"$)
		End If
	#Else
		Log($"ERR: Unknown function '${Name}'  ${maybe})"$) 
	#End If	
		ExitApplication
		Return Null
	End If
	Dim newTemp As String = "_temp_" & Temps.Size
	Temps.Put(newTemp, resultLst)
	Return newTemp
End Sub

'Displays a number of rows of a LOA. If showNRows = 0. it displays all rows. 
'If decimals > -1 then display that many decimals for all numerical values in LOA.
Public Sub Display(LOA As ListOfArrays, showNRows As Int, decimals As Int)
	Log(TAB)
#if DEMO
	Dim methodLOA As String
	Dim ar() As String = getJavaLine
	Dim prefix As String = ar(0)
	Dim foundStr As String = ar(1)
	Dim LOAName As String
	If foundStr.Length > 0 Then
		methodLOA = getB4XCallingLine(prefix, foundStr)
		If methodLOA.Length > 0 Then
			LOAName = methodLOA.SubString(methodLOA.indexof("(") + 1)
			LOAName = LOAName.SubString2(0, LOAName.IndexOf(","))
		End If
	End If
	If LOAName.Length > 0 Then Log("________ " & LOAName & " __________")
#End If	
	
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
		Dim nsp As Int = 2.0 * (widths(j) - s.Length)
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
			Dim nsp As Int = 2.0 * (widths(j) - s.Length)
			If s.Contains("x") Then nsp = nsp - 2   'special case for info 'Maximum
			For k = 0 To nsp
				s = s & " "
			Next
			sb.Append(s)
			If j < ncols - 1 Then sb.Append(TAB)
		Next
		Log(sb.ToString)
	Next
	Dim ln As String = separatorLine
	If showN < nrows Then 
		Dim s As String = ln.SubString2(0, 3) & $"first ${showN} rows"$ & ln.SubString(10)
		Log($"${s} #rows=${nrows} #cols=${ncols}"$)
	Else
		Log($"${separatorLine} #rows=${nrows} #cols=${ncols}"$)
	End If
End Sub

'Formats numerical data in place - LOA is modified.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all numerical columns
Public Sub Format(LOA As ListOfArrays, colspec As Object, params() As Object)
	Dim minInt As Int = params(0)
	Dim maxFract As Int = params(1)
	Dim minFract As Int = params(2)
	Dim prefix, suffix As String
	If params.Length > 4 Then 
		suffix = params(3)
		prefix = params(4)
	Else If params.Length > 3 Then 
		suffix = params(3)
	End If
	Dim colArr() As Object = colspecToArray(LOA, colspec)
	If colArr.Length = 0 Then colArr = LOA.Header
	Dim nrows As Int = LOA.mInternalArray.Size - 1
	Dim cols As Int = colArr.Length
	For j = 0 To cols - 1
		Dim nam As String = colArr(j)
		Dim index As Int = LOA.ColumnIndexToOrdinal(nam)
		Dim lst As List: lst.Initialize
		For i = 0 To nrows - 1
			Dim obj As Object = LOA.GetValue(i, index)
			If IsNumber(obj) Then 
				obj = prefix & NumberFormat2(obj, minInt, maxFract, minFract, False) & suffix
			End If
			lst.Add(obj)
		Next
		LOA.SetColumn(index, lst)
	Next
End Sub

'Renames columns as specified in a map.  LOA is modified.
Public Sub RenameColumns(LOA As ListOfArrays, mp As Map)
	Dim indexMap As Map = LOA.mIndicesMap
	For Each kw As String In mp.Keys
		Dim kwl As String = kw.toLowerCase
		If indexMap.ContainsKey(kwl) Then 
			Dim index As Int = indexMap.Get(kwl)
			Dim newName As String = mp.Get(kw)
			indexMap.Put(newName.toLowerCase, index)
			indexMap.Put(newName, index)
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

'Shuffles items in each row of LOA in place. LOA is modified.
Public Sub ShuffleRows(LOA As ListOfArrays)
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

'Shuffles items in each column of LOA in place. LOA is modified.
Public Sub ShuffleCols(LOA As ListOfArrays)
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

'Merges the second LOA2 with the first LOA1 which is modified to include both. 
'Number of rows will be the largest of the two. The original LOA1 will be lost.
Public Sub MergeMatch(LOA1 As ListOfArrays, LOA2 As ListOfArrays)
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

'Creates a nrows by ncols table all values are equal to cons. Default column names.
Public Sub Constants(nrows As Int, ncols As Int, cons As Object) As ListOfArrays
	Dim consx() As Object = argToArray(cons)
	Dim header(ncols) As Object
	For j = 0 To ncols - 1
		header(j) = applyStyle(j)
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

'Creates a nrows by ncols table. Values follow a sequence of numbers in range. 
'Range = StartA, EndAt, and optional Stepsize. Default column names.
Public Sub Sequence(nrows As Int, ncols As Int, range_ As Object) As ListOfArrays
	Dim rangex() As Object = argToArray(range_)
	Dim startat, endat, stepsize As Int
	Select rangex.Length
		Case 0
			Return Constants(nrows, ncols, Null)
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
	Dim nvalues As Int = 1 + Floor((endat - startat) / stepsize)
	Dim result(nvalues) As Object
	Dim k As Int = -1
	Log(startat & TAB & endat & TAB & stepsize & TAB & nvalues)
	For j = startat To endat Step stepsize
		k = k + 1
		result(k) = j
	Next
	Return Collect(nrows, ncols, result)
End Sub

'Creates a nrows by ncols table. Collecting a specified set of values. 
'When the collection runs out of values, it starts back at the beginning. Default column names.
Public Sub Collect(nrows As Int, ncols As Int, collection As Object) As ListOfArrays
	Dim values() As Object = argToArray(collection)
	Dim header(ncols) As Object
	For j = 0 To ncols - 1
		header(j) = applyStyle(j)
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

'Creates a nrows by ncols table. Default column names.
'Integer values are chosen randomly (pseudo) from range=start to endat exclusive.
Public Sub RandomInt(nrows As Int, ncols As Int, range_ As Object) As ListOfArrays
	Dim rangex() As Object = argToArray(range_)
	Dim startat, endat As Int
	Select rangex.Length
		Case 0
			Return Constants(nrows, ncols, Null)
		Case 1
			startat = 0
			endat = rangex(0)
		Case Else
			startat = rangex(0)
			endat = rangex(1)
	End Select
	
	Dim header(ncols) As Object
	For j = 0 To ncols - 1
		header(j) = applyStyle(j)
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

'Creates a nrows by ncols table. It generates double values between 0 and 1.
'The precision is specified by 'decimals'. Default column names.
Public Sub RandomDouble(nrows As Int, ncols As Int, decimals As Int) As ListOfArrays
	Dim multx As Long = Power(10, decimals)
	Dim scale As Double = 1 / multx
	
	Dim header(ncols) As Object
	For j = 0 To ncols - 1
		header(j) = applyStyle(j)
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

'Creates a new LOA based on whether the Expression is true.
Public Sub RowsIfTrue(LOA_ As ListOfArrays, Expression As String) As ListOfArrays
	Dim e As wLOAEval
	e.Initialize(Me, "Eval")
	Dim lst As List = e.eval_X(LOA_, "", Expression)
	Dim new As ListOfArrays = LOAUtils.CreateEmpty(LOA_.header) 
	For i = 0 To lst.Size - 1
		If lst.Get(i) = True Then new.AddRow(copyRow(LOA_.GetRow(i)))
	Next
	Return new
End Sub

'Creates a new LOA. Retrieves only the rows that have valid data in all columns.
'Valid is defined as non-Null and object type equal to the columns predomininant object Type.
'Predominant means >95% of column's items object type
Public Sub RowsIfValid(LOA As ListOfArrays) As ListOfArrays
	Dim new As ListOfArrays = LOAUtils.CreateEmpty(LOA.Header)
	For j = 0 To LOA.NumberOfColumns - 1
		Dim colname As String = LOA.Header(j)
		Info(LOA, colname)
		Dim lst As List = LOA.GetColumn(colname)
		If j = 0 Then 
			Dim drop(lst.Size) As Boolean
		End If
		For i = 0 To lst.Size - 1
			Dim obj As Object = lst.Get(i)
			If (obj = Null) Or (unusualVals.IndexOf(obj) > -1) Then drop(i) = True
		Next
	Next
	For i = 0 To lst.Size - 1
		If Not(drop(i)) Then new.AddRow(copyRow(LOA.GetRow(i)))
	Next
	Return new
End Sub

'Creates a new LOA based on selected columns in the order they are selected.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
Public Sub SelectCols(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Dim selx() As Object = colspecToArray(LOA, colspec)
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

'Creates a new LOA with specied columns removed. Order of remaining columns is unchanged.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
Public Sub ExcludeCols(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Dim selx() As Object = colspecToArray(LOA, colspec)
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
	Return SelectCols(LOA, lst)
End Sub

'Creates a new LOA. Recodes values into new values based on a Map.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.
Public Sub Recode(LOA As ListOfArrays, colspec As Object, mp As Map) As ListOfArrays
	Dim colArr() As Object = colspecToArray(LOA, colspec)
	If colArr.Length = 0 Then colArr = LOA.Header
	Dim nrows As Int = LOA.mInternalArray.Size - 1
	Dim oldnames() As Object = LOA.Header
	
	Dim newCols As Int = colArr.Length
	Dim newNames(newCols) As Object
	For j = 0 To newCols - 1
		Dim nam As String = colArr(j)
		Dim index As Int = LOA.ColumnIndexToOrdinal(nam)
		newNames(j) = oldnames(index) & "(R)"
	Next
	Dim new As ListOfArrays = LOAUtils.CreateEmpty(newNames)
	For i = 0 To nrows - 1
		Dim r() As Object = LOA.GetRow(i)
		Dim newr(newCols) As Object
		For j = 0 To newCols - 1
			Dim nam As String = colArr(j)
			Dim index As Int = LOA.ColumnIndexToOrdinal(nam)
			Dim origObj As Object = r(index)
			newr(j) = mp.GetDefault(origObj, origObj)
		Next
		new.AddRow(newr)
	Next
	Return new
End Sub

'Creates a new LOA. Recodes values of a column into 0 or 1 if an item = some value.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected. 
Public Sub One_Hot(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Dim colArr() As Object = colspecToArray(LOA, colspec)
	If colArr.Length = 0 Then colArr = LOA.Header
	Dim nrows As Int = LOA.mInternalArray.Size - 1
	Dim newCols As Int = colArr.Length
	
	Dim LOAAll As ListOfArrays = LOAUtils.CreateEmpty(Array("_DUMMY_"))
	For i = 0 To nrows - 1
		LOAAll.AddRow(Array(Null))
	Next
	
	For j = 0 To newCols - 1
		Dim nam As String = colArr(j)
		Dim lst As List = LOA.GetColumn(nam)
		Dim mp As Map: mp.initialize
		For i = 0 To nrows - 1
			Dim obj As Object = lst.Get(i)
			If Not(obj = Null) And (IsNumber(obj) Or (obj Is String)) Then 
				If mp.ContainsKey(obj) Then 
					Dim n As Int = mp.Get(obj)
					mp.Put(obj, n + 1)
				Else
					mp.Put(obj, 1)
				End If
			End If
		Next
		If mp.Size > 0 Then
			Dim scats As List: scats.Initialize
			For Each cat As Object In mp.Keys
				scats.Add((10000 + mp.Get(cat)) & TAB & cat)
			Next
			scats.Sort(False)
			Dim h(mp.size) As Object
			mp.clear
			For k = 0 To scats.Size - 1
				Dim s As String = scats.get(k)
				Dim v() As String = Regex.Split(TAB, s)
				mp.Put(v(1), k)
				h(k) = nam & "_" & v(1)
			Next
			Dim new As ListOfArrays = LOAUtils.CreateEmpty(h)

			For i = 0 To nrows - 1
				Dim obj As Object = lst.Get(i)
				Dim newCat As Int = mp.Get(obj.As(String))
				Dim r(mp.Size) As Object
				For m = 0 To mp.Size - 1
					r(m) = 0
					If m = newCat Then r(m) = 1
				Next
				new.AddRow(r)
			Next
		End If
		LOAAll.Merge(new)
	Next
	LOAAll.RemoveColumn(0)
	Return LOAAll
End Sub

'Creates a new LOA with information about one or more columns. The first column of the results are labels.
'Column Type	(derived from analyzing the data - it is the predominant type - >95% of items have it.
'Num Rows
'Num Missing    (Nulls)
'Num Unusual	(Not the Column Type)
'Num Valid
'Minimum
'Maximum		
'Decimals		
Public Sub Info(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	unusualVals = emptyLst
	Dim colArr() As Object = colspecToArray(LOA, colspec)
	If colArr.Length = 0 Then colArr = LOA.Header
	Dim nrows As Int = LOA.mInternalArray.Size - 1
	Dim oldnames() As Object = LOA.Header
	
	Dim newCols As Int = colArr.Length
	Dim newNames(newCols + 1) As Object
	newNames(0) = "                     " & TAB
	For j = 0 To newCols - 1
		Dim nam As String = colArr(j)
		Dim index As Int = LOA.ColumnIndexToOrdinal(nam)
		newNames(j + 1) = oldnames(index) & "_Info"
	Next
	
	Dim mp As Map: mp.initialize
	
	Dim new As ListOfArrays = LOAUtils.CreateEmpty(newNames)
	
	Dim kInfo As Int = 8
	Dim infoData(newCols, kInfo) As Object
	For j = 0 To newCols - 1
		Dim nMissing As Int
		Dim minValue As Double = 1 / 0
		Dim maxValue As Double = -1 / 0
		Dim Invalids As List: Invalids.initialize
		mp.clear
		Dim nam As String = colArr(j)
		Dim lst As List = LOA.GetColumn(nam)
		Dim typ As String = "object"
		For i = 0 To nrows - 1
			Dim obj As Object = lst.Get(i)
			If Not(obj = Null) Then
				Dim typ As String = GetType(obj)
				Dim k As Int = typ.LastIndexOf(".")
				typ = typ.SubString(k + 1)
				Dim index As Int = ".Byte.Integer.Long.Float.Double.Boolean.Char.String".IndexOf(typ)
				If index > -1 Then
					register(mp, typ)
				Else if isArray(obj) Then
					register(mp, "Array")
				Else if obj Is List Then
					register(mp, "List")
				Else if obj Is Map Then
					register(mp, "Map")
				Else
					register(mp, "Object")
				End If
				If IsNumber(obj) Then
					Dim dbl As Double = obj
					If dbl > maxValue Then maxValue = dbl
					If dbl < minValue Then minValue = dbl
				End If
			Else
				nMissing = nMissing + 1
			End If
			
		Next
		Dim maxn As Int
		Dim alln As Int
		Dim maxFound As String
		
		For Each kw As String In mp.Keys
			Dim m As Int = mp.Get(kw)
			If m > maxn Then
				maxn = m
				maxFound = kw
			End If
			alln = alln + m
		Next
		Dim maxn2 As Int
		Dim maxFound2 As String
		For Each kw As String In mp.Keys
			If maxFound <> kw Then
				Dim m As Int = mp.Get(kw)
				If m > maxn2 Then
					maxn2 = m
					maxFound2 = kw
				End If
			End If
		Next
		If (maxFound = "Integer" And maxFound2 ="Float") Or (maxFound = "Float" And maxFound2 ="Integer") Then
			maxFound = "Float"
			maxn = maxn + maxn2
		End If
		Dim nItems As Int = nrows
		If (maxn / alln) > .95 Then
			Dim lstType As String = maxFound
			Dim nValid As Int = maxn
			Dim nInvalid As Int = nItems - (nValid + nMissing)
			Invalids.clear
			For i = 0 To nrows - 1
				Dim obj As Object = lst.Get(i)
				If Not(obj = Null) Then
					Dim typ As String = GetType(obj)
					Dim k As Int = typ.LastIndexOf(".")
					typ = typ.SubString(k + 1)
					If typ <> lstType Then
						If Not(lstType = "Float" And typ = "Integer") Then
							Invalids.Add(obj)
						End If
					End If
				End If
			Next
			unusualVals = Invalids
			Dim isNumeric As Boolean = "Integer.Long.Float.Double".contains(maxFound)
			Dim origDecimals As Int
			If isNumeric Then
				If (maxFound = "Integer") Or (maxFound = "Double") Then
					origDecimals = 0
				Else
					origDecimals = 0
					For Each obj As Object In lst
						If (obj Is Float) Or (obj Is Double) Then
							Dim g As String = obj
							Dim k As Int = g.IndexOf(".")
							Dim m As Int = g.Length - k
							If m > origDecimals Then origDecimals = m
						End If
					Next
				End If
			Else if lstType = "String" Then
				Dim lengthCnt(25) As Int
				Dim cnt As Int
				For Each obj As Object In lst
					If (obj Is String) Then
						Dim g As String = obj
						Dim k As Int = Min(g.length, 24)
						lengthCnt(k) = lengthCnt(k) + 1
						cnt = cnt + 1
					End If
				Next
			End If
		Else
			Dim lstType As String = "Object"
			nValid = nItems
			nInvalid = 0
		End If
		Dim maxVal As Object = maxValue
		Dim minVal As Object = minValue
		If (-1 / 0) = maxValue Then
			maxVal = Null
		Else
			maxVal = NumberFormat2(maxVal, 0, origDecimals, origDecimals, False)
		End If
		If (1 / 0) = minValue Then
			minVal = Null
		Else
			minVal = NumberFormat2(minVal, 0, origDecimals, origDecimals, False)
		End If
		
		infoData(j, 0) = lstType
		infoData(j, 1) = nItems
		infoData(j, 2) = nMissing
		infoData(j, 3) = nInvalid
		infoData(j, 4) = nItems - nMissing - nInvalid
		infoData(j, 5) = minVal
		infoData(j, 6) = maxVal
		If isNumeric Then
			infoData(j, 7) = origDecimals
		Else
			infoData(j, 7) = Null
		End If
	Next
	
	Dim rlabels() As String = Array As String("Column Type", "Num Rows", "Num Missing", "Num Unusual", "Num Valid", "Minimum", "Maximum", "Decimals")
	For k = 0 To kInfo - 1
		Dim r(newCols + 1) As Object
		r(0) = rlabels(k)
		For j = 0 To newCols- 1
			r(j + 1) = infoData(j, k)
		Next
		new.AddRow(r)
	Next
	Return new
End Sub

'Retrieves the last computation of unusual values by wInfo.info
Public Sub UnusualValues As List
	If Not (unusualVals.IsInitialized) Then unusualVals = emptyLst
	Return unusualVals
End Sub

'Returns an array of integers ranging from startAt to endAt(inclusive) in stepsize chunks.
Public Sub Range(startat As Int, endAt As Int, stepSize As Int) As Object()
	Dim n As Int = (endAt - startat + 1) / stepSize
	Dim res(n) As Object
	Dim index As Int 
	For i = startat To endAt Step stepSize
		res(index) = i
		index = index + 1
	Next
	Return res
End Sub

#End Region 

#Region Date/Time functions

'Returns Date Longs corresponding to Date Strings in the column spec. Strings must be in DateTime.DateFormat
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub ToDate(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("toDate_X", LOA , colspec, Array(0))
End Sub

'Returns Date Longs corresponding to Time Strings in the column spec. Strings must be in DateTime.TimeFormat
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub ToTime(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("toTime_X", LOA , colspec, Array())
End Sub

'Returns Date Longs corresponding to Strings in the column spec. 
'Strings must be in [DateFormat]_T_[TimeFormat]. Ex. "1 JAN 2026_T_12:30"
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub ToDateTime(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("toDateTime_X", LOA , colspec, Array())
End Sub

'Returns Date Longs corresponding to numbers in the column spec. Numbers must be their proper range
'params = Array(Years, Months, Days, Hours, Minutes, Seconds)
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub DateAndTime(LOA As ListOfArrays, colspec As Object, params() As Object) As ListOfArrays
	Return generic("dateAndTime", LOA , colspec, params)
End Sub

'Returns Date Strings defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub AsDate(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("asDate_X", LOA , colspec, Array())
End Sub

'Returns Time Strings defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub AsTime(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("asTime_X", LOA , colspec, Array())
End Sub

'Returns Date_T_Time Strings defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub AsDateTime(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("asDateTime_X", LOA , colspec, Array())
End Sub

'Returns dayOfYear (integers) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub DayOfYear(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("dayOfYear"))
End Sub

'Returns dayOfMonth (1 - 31) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub DayOfMonth(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("dayOfMonth"))
End Sub

'Returns dayOfWeek (1 - 7; 1=Sunday) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub DayOfWeek(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("dayOfWeek"))
End Sub

'Returns dayOfYear (1 - 366) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Weekday(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("weekday"))
End Sub

'Returns weekday3lets defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Weekday3lets(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("weekday3lets"))
End Sub

'Returns weekday3caps defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Weekday3caps(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("weekday3lets"))
End Sub

'Returns quarter of the year (1 - 4) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Quarter(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("quarter"))
End Sub

'Returns week (1 - 52) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Week(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("week"))
End Sub

'Returns year (4 digit integers) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Year(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("year"))
End Sub

'Returns month (1 - 12) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Month(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("week"))
End Sub

'Returns month name (full name) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Monthname(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("monthname"))
End Sub

'Returns month name (first 3 letters) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Month3lets(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("month3lets"))
End Sub

'Returns month name (first 3 letters in CAPS) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Month3caps(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("month3caps"))
End Sub

'Returns hour (0 - 23; 24=0) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Hour(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("hour"))
End Sub

'Returns minute (0 - 59; 60=0) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Minute(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("minute"))
End Sub

'Returns second (0 - 59; 60= 0) defined by Longs in the column spec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Second(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , colspec, Array("second"))
End Sub

'Returns new incremented Longs defined by Longs in the column spec.  
'Numbers must be their proper range; params = Array(Years, Months, Days, Hours, Minutes, Seconds)
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub AddPeriod(LOA As ListOfArrays, colspec As Object, params() As Object) As ListOfArrays
	Return generic("addPeriod", LOA , colspec, params)
End Sub

'Returns the number of days in the month (28 - 31) of the Date Longs in the colspec.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub Monthdays(LOA As ListOfArrays, colspec As Object) As ListOfArrays
	Return generic("monthdays_X", LOA , colspec, Array())
End Sub

'Returns days (integers) between a Date String in the column spec and a specified end Date String. 
'If endDate is Null period is between first two columns.  
'If endDate is Null and only one column then endDate is set to todays date.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
'The original is un-affected.  The result has the same number of rows as the original LOA.  
'If the item is not a string the result is Null
Public Sub DaysBetween(LOA As ListOfArrays, colspec As Object, endDate As Object) As ListOfArrays
	Dim colArr() As Object = colspecToArray(LOA, colspec)
	Dim new As ListOfArrays
	If endDate = Null Then 
		If colArr.Length > 1 Then
			Dim nrows As Int = LOA.mInternalArray.Size - 1
			Dim newCols As Int = 1
			Dim nam1 As String = colArr(0)
			Dim nam2 As String = colArr(1)
			Dim newNames(1) As Object
			newNames(0) = nam2 & " - " & nam1
			
			new  = LOAUtils.CreateEmpty(newNames)
			Dim newr(1) As Object
			For i = 0 To nrows - 1
				Dim r() As Object = LOA.GetRow(i)
				Dim newr(newCols) As Object
				Dim nam1 As String = colArr(0)
				Dim index1 As Int = LOA.ColumnIndexToOrdinal(nam1)
				Dim obj1 As Object = r(index1)
				
				Dim nam2 As String = colArr(1)
				Dim index2 As Int = LOA.ColumnIndexToOrdinal(nam2)
				Dim obj2 As Object = r(index2)
				Log(obj1 & TAB & obj2)
				If obj1 Is String And obj2 Is String Then 
					Try
						Dim dt1 As Long = DateTime.DateParse(obj1)
						Dim dt2 As Long = DateTime.DateParse(obj2)
						Dim dif As Int = DateUtils.PeriodBetweenInDays(dt1, dt2).Days
						newr(0) = dif
					Catch
						newr(0) = Null
					End Try
				Else	
					newr(0) = Null
				End If
				new.AddRow(newr)
			Next
		Else
			new = generic("daysBetween_X", LOA , colspec, Array(DateTime.Date(DateTime.Now)))
		End If
	Else if colArr.Length > 1 Then
		new = generic("daysBetween_X", LOA , colspec, Array(endDate))		
	End If
	Return new
End Sub

#End Region

#Region STANDARD FUNCTION ITERATORS

Private Sub min_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim minimum As Double = 1 / 0
		For j = 0 To ncols - 1
			Dim obj As Object = matrix(i,j)
			If IsNumber(obj) Then 
				Dim val As Double = obj
				If val < minimum Then minimum = val
			End If
		Next
		resultLst.Add(minimum)	
	Next
	Return resultLst
End Sub

Private Sub max_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim maximum As Double = -1 / 0
		For j = 0 To ncols - 1
			Dim obj As Object = matrix(i,j)
			If IsNumber(obj) Then 
				Dim val As Double = obj
				If val > maximum Then maximum = val
			End If
		Next
		resultLst.Add(maximum)	
	Next
	Return resultLst
End Sub

Private Sub sin_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If IsNumber(obj) Then resultLst.Add(SinD(obj)) Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub cos_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If IsNumber(obj) Then resultLst.Add(CosD(obj)) Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub tan_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If IsNumber(obj) Then resultLst.Add(TanD(obj)) Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub abs_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If IsNumber(obj) Then resultLst.Add(Abs(obj)) Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub floor_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If IsNumber(obj) Then resultLst.Add(Floor(obj))	Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub ceil_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If IsNumber(obj) Then resultLst.Add(Ceil(obj)) Else resultLst.Add(Null)		
	Next
	Return resultLst
End Sub

Private Sub round_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If IsNumber(obj) Then resultLst.Add(Round(obj))	Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub sqrt_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If IsNumber(obj) Then resultLst.Add(Sqrt(obj)) Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub atan_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj0 As Object = matrix(i,0)
		Dim obj1 As Object = matrix(i,1)
		If IsNumber(obj0) And IsNumber(obj1) Then resultLst.Add(ATan2D(obj0, obj1)) Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub power_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj0 As Object = matrix(i,0)
		Dim obj1 As Object = matrix(i,1)
		If IsNumber(obj0) And IsNumber(obj1) Then resultLst.Add(Power(obj0, obj1)) Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub logarithm_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj0 As Object = matrix(i,0)
		Dim obj1 As Object = matrix(i,1)
		If IsNumber(obj0) And IsNumber(obj1) Then resultLst.Add(Logarithm(obj0, obj1)) Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub and_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim res As Boolean = True
		For j = 0 To ncols - 1
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
		resultLst.Add(res)
	Next
	Return resultLst
End Sub

Private Sub nand_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim res As Boolean = True
		For j = 0 To ncols - 1
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
		res = Not(res)
		resultLst.Add(res)
	Next
	Return resultLst
End Sub

Private Sub or_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim res As Boolean = False
		For j = 0 To ncols - 1
			Dim obj As Object = matrix(i,j)
			If obj Is Boolean Then 
				If True = matrix(i, j) Then
					res = True
					Exit
				End If
			End If
		Next
		resultLst.Add(res)
	Next
	Return resultLst
End Sub

Private Sub nor_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim res As Boolean = False
		For j = 0 To ncols - 1
			Dim obj As Object = matrix(i,j)
			If obj Is Boolean Then 
				If True = matrix(i, j) Then
					res = True
					Exit
				End If
			End If
		Next
		res = Not(res)
		resultLst.Add(res)
	Next
	Return resultLst
End Sub

Private Sub not_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is Boolean Then resultLst.Add(Not(obj.As(Boolean))) Else resultLst.Add(Null)	
	Next
	Return resultLst
End Sub

Private Sub asc_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is String Then resultLst.Add(Asc(matrix(i, 0))) Else resultLst.Add(Null)	
	Next
	Return resultLst
End Sub

Private Sub chr_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If IsNumber(obj) Then resultLst.Add(Chr(obj)) Else resultLst.Add(Null)		
	Next
	Return resultLst
End Sub

Private Sub length_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is String Then resultLst.Add(obj.As(String).Length) Else resultLst.Add(Null)	
	Next
	Return resultLst
End Sub

Private Sub substring2_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is String Then resultLst.Add(obj.As(String).substring2(matrix(i, 1), matrix(i,2))) Else resultLst.Add(Null)	
	Next
	Return resultLst
End Sub

Private Sub substring_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is String Then resultLst.Add(obj.As(String).substring(matrix(i, 1))) Else resultLst.Add(Null)	
	Next
	Return resultLst
End Sub

Private Sub replace_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is String Then resultLst.Add(obj.As(String).replace(matrix(i, 1), matrix(i, 2))) Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub toLowerCase_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is String Then resultLst.Add(obj.As(String).toLowerCase) Else resultLst.Add(Null)	
	Next
	Return resultLst
End Sub

Private Sub toUpperCase_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is String Then resultLst.Add(obj.As(String).toUpperCase) Else resultLst.Add(Null)	
	Next
	Return resultLst
End Sub

Private Sub toCamelCase_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is String Then resultLst.Add(totitle(obj).replace(" ","")) Else resultLst.Add(Null)	
	Next
	Return resultLst
End Sub

Private Sub toTitleCase_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is String Then resultLst.Add(totitle(obj)) Else resultLst.Add(Null)	
	Next
	Return resultLst
End Sub

Private Sub standardize_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If IsNumber(obj) Then resultLst.Add(obj) Else resultLst.Add(Null)	
	Next
	resultLst = standardize2(resultLst)
	Return resultLst
End Sub

Private Sub normalize_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If IsNumber(obj) Then resultLst.Add(obj) Else resultLst.Add(Null)	
	Next
	resultLst = standardize2(resultLst)
	Return resultLst
End Sub

Private Sub degreesToRadians_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If IsNumber(obj) Then resultLst.Add(obj) Else resultLst.Add(Null)	
	Next
	resultLst = dToR(resultLst)
	Return resultLst
End Sub

Private Sub radiansToDegrees_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If IsNumber(obj) Then resultLst.Add(obj) Else resultLst.Add(Null)	
	Next
	resultLst = rToD(resultLst)
	Return resultLst
End Sub

Private Sub contains_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is String Then resultLst.Add(obj.as(String).contains(matrix(i,1))) Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub indexof_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is String Then resultLst.Add(obj.as(String).indexOf(matrix(i,1)))	Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub indexof2_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is String Then resultLst.Add(obj.as(String).indexOf2(matrix(i,1), matrix(i,2))) Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub lastindexof_X(params() As Object) As List  'ignore
	Dim resultLst As List: resultLst.Initialize
	Dim nrows As Int = params(0)
	Dim ncols As Int = params(1)    'ignore
	Dim matrix(,) As Object = params(2)
	For i = 0 To nrows - 1
		Dim obj As Object = matrix(i,0)
		If obj Is String Then resultLst.Add(obj.as(String).lastindexOf(matrix(i,1))) Else resultLst.Add(Null)
	Next
	Return resultLst
End Sub

Private Sub setDateAndTime_X(lst As List, extra() As Object) As List	'ignore
	Dim pars(6) As Int
	For k = 0 To 5
		If k < extra.Length Then pars(k) = extra(k) Else pars(k) = 0
	Next
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is Long) Then
			rlst.Add(DateUtils.SetDateAndTime(pars(0), pars(1), pars(2), pars(3), pars(4), pars(5)))
		Else
			rlst.Add(Null)
		End If
	Next
	Return rlst
End Sub

Private Sub toDate_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is String) Then 
			Try
				rlst.Add(DateTime.DateParse(obj)) 
			Catch
				rlst.Add(Null)
			End Try
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst	
End Sub

Private Sub toTime_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is String) Then 
			Try
				rlst.Add(DateTime.TimeParse(obj)) 
			Catch
				rlst.Add(Null)
			End Try
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst	
End Sub

Private Sub toDateTime_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		Dim v() As String = Regex.Split("_T_", obj)
		If Not(obj = Null) And (obj Is String) Then 
			Try
				rlst.Add(DateTime.DateTimeParse(v(0), v(1))) 
			Catch
				rlst.Add(Null)
			End Try
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst	
End Sub

Private Sub asDate_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is Long) Then rlst.Add(DateTime.Date(obj)) Else rlst.Add(Null)
	Next
	Return rlst	
End Sub

Private Sub asTime_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is Long) Then rlst.Add(DateTime.Time(obj)) Else rlst.Add(Null)
	Next
	Return rlst	
End Sub

Private Sub asDateTime_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is Long) Then rlst.Add(DateTime.Date(obj) & "_T_" & DateTime.Time(obj)) Else rlst.Add(Null)
	Next
	Return rlst	
End Sub

Private Sub dateTime_X(lst As List, extra() As Object) As List	'ignore
	Dim f As String = extra(0)
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is Long) Then
			Dim result As Object
			Select f.toLowerCase
				Case "dayofyear": result = DateTime.GetDayOfYear(obj)
				Case "dayofmonth": result = DateTime.GetDayOfMonth(obj)
				Case "dayofweek": result = DateTime.GetDayOfWeek(obj)
				Case "weekday":	result = weekdays(DateTime.GetDayOfWeek(obj))
				Case "weekday3lets"
					result = weekdays(DateTime.GetDayOfWeek(obj))
					Dim t As String = weekdays(DateTime.GetDayOfWeek(obj))
					result = t.SubString2(0,3)
				Case "weekday3caps"
					Dim t As String = weekdays(DateTime.GetDayOfWeek(obj))
					result = t.SubString2(0,3).toUppercase
				Case "year": result = DateTime.GetYear(obj)
				Case "month": result = DateTime.GetMonth(obj)
				Case "monthname": result = monthnames(DateTime.GetMonth(obj))
				Case "month3lets"
					Dim t As String = monthnames(DateTime.GetMonth(obj))
					result = t.SubString2(0,3)
				Case "month3caps"
					Dim t As String = monthnames(DateTime.GetMonth(obj))
					result = t.SubString2(0,3).toUpperCase
				Case "quarter": result = 1 + (DateTime.GetMonth(obj) - 1) / 4
				Case "week": result = DateTime.GetDayOfYear(obj) / 52
				Case "hour": result = DateTime.GetHour(obj)
				Case "minute": result = DateTime.GetMinute(obj)
				Case "second": result = DateTime.GetSecond(obj)
			End Select
			rlst.Add(result) 
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst	
End Sub

Private Sub daysBetween_X(lst As List, extra() As Object) As List	'ignore
	Dim endDate As Object = extra(0)
	Dim d As Long = DateTime.DateParse(endDate)
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is String) Then 
			Dim x As String = DateTime.DateParse(obj)
			rlst.Add(DateUtils.PeriodBetweenInDays(x, d).Days) 
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst	
End Sub

Private Sub addPeriod_X(lst As List, extra() As Object) As List	'ignore
	Dim pars(6) As Int
	For k = 0 To 5
		If k < extra.Length Then pars(k) = extra(k) Else pars(k) = 0
	Next
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is Long) Then 
			Dim per As Period: per.initialize
			per.Years = pars(0)
			per.Months = pars(1)
			per.Days = pars(2)
			per.Hours = pars(3)
			per.Minutes = pars(4)
			per.Seconds = pars(5)
			rlst.Add(DateUtils.AddPeriod(obj, per)) 
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst	
End Sub

Private Sub monthdays_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is Long) Then
			Dim yr As Int = DateTime.GetYear(obj)
			Dim mnth As Int = DateTime.GetMonth(obj)
			rlst.Add(DateUtils.NumberOfDaysInMonth(mnth, yr)) 
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst	
End Sub

#End Region

#Region Helpers
Private Sub separatorLine As String
	If dividerLine.Length > 0 Then Return dividerLine
	Dim sb As StringBuilder
	sb.initialize
	For i = 1 To 12
		sb.Append(dividerChar)
	Next
	dividerLine = sb.toString
	Return dividerLine
End Sub

Private Sub isArray(obj As Object) As Boolean
	If obj = Null Then Return False
	Return GetType(obj).StartsWith("[")
End Sub

Private Sub closestName(LOA As ListOfArrays, nam As String) As String
	Dim parts As List: parts.Initialize
	For wl = 2 To nam.Length - 1
		For j = 0 To nam.Length - wl Step wl
			parts.Add(nam.SubString2(j, j + wl))
		Next
	Next
	Dim matches As List: matches.initialize
	If parts.Size = 0 Then 
		For Each kw As String In LOA.mIndicesMap.keys
			If nam.Contains(kw) Or kw.Contains(nam) Then 
				matches.Add((1000 + kw.Length) & TAB & kw)
			End If
		Next
	Else
		For Each kw As String In LOA.mIndicesMap.keys
			Dim cr As String = kw.replace(" ", "")
			Dim cnt As Int
			For Each p As String In parts
				If cr.Contains(p) Then cnt = cnt + 1			
			Next
			matches.Add((1000 + Ceil(100 * cnt / parts.size)) & TAB & kw)
		Next
	End If
	matches.Sort(False)
	If matches.Size > 0 Then
		Dim mostSimilar As String = matches.Get(0)
		If Abs(mostSimilar.Length - nam.Length) > 1 Then 
			Return ""
		Else
			Return mostSimilar.SubString(mostSimilar.IndexOf(TAB) + 1)
		End If
	Else
		Return ""	
	End If
End Sub

Private Sub closestName2(LOA As ListOfArrays, nam As String) As String
	If Not(functionNames.isInitialized) Then 
		functionNames.initialize
		Dim f1 As String = $"Min Max Sin Cos Tan Abs Floor Ceil Round Sqrt ATan Power Logarithm And Nand Or Nor Not "$
		Dim f2 As String = $"Asc Chr Length Substring2 Substring Replace ToLowerCase ToUpperCase ToCamelCase ToTitleCase Contains "$
		Dim f3 As String = $"Indexof Indexof2 Lastindex Lastindexof2 Standardize Normalize DegreesToRadians RadiansToDegrees"$
		Dim functions() As String = Regex.Split(" ", f1 & f2 & f3)
		For Each f As String In functions
			functionNames.Put(f.ToLowerCase, f)
		Next
	End If
	
	Dim parts As List: parts.Initialize
	For wl = 2 To nam.Length - 1
		For j = 0 To nam.Length - wl Step wl
			parts.Add(nam.SubString2(j, j + wl))
		Next
	Next
	Dim matches As List: matches.initialize
	If parts.Size = 0 Then 
		For Each kw As String In functionNames.keys
			If nam.Contains(kw) Or kw.Contains(nam) Then 
				matches.Add((1000 + kw.Length) & TAB & kw)
			End If
		Next
	Else
		For Each kw As String In LOA.mIndicesMap.keys
			Dim cr As String = kw.replace(" ", "")
			Dim cnt As Int
			For Each p As String In parts
				If cr.Contains(p) Then cnt = cnt + 1			
			Next
			matches.Add((1000 + Ceil(100 * cnt / parts.size)) & TAB & kw)
		Next
	End If
	matches.Sort(False)
	If matches.Size > 0 Then
		Dim mostSimilar As String = matches.Get(0)
		If Abs(mostSimilar.Length - nam.Length) > 1 Then 
			Return ""
		Else
			Return mostSimilar.SubString(mostSimilar.IndexOf(TAB) + 1)
		End If
	Else
		Return ""	
	End If
End Sub

Private Sub getJavaLine As String()
    Dim Throwable As JavaObject
	Throwable.InitializeNewInstance("java.lang.Throwable",Null)
    Dim sTrace() As Object = Throwable.RunMethod("getStackTrace", Null)
	Dim JO As JavaObject
	Dim foundStr As String

	For i = 0 To sTrace.Length - 1
		JO = sTrace(i)
		Dim s As String = JO.RunMethod("toString",Null)
		If s.Contains(".wloaextras.") Then 
			Dim prefix As String = s.SubString2(0,s.IndexOf(".wloaextras."))
			For j = i + 1 To sTrace.Length - 1
				JO = sTrace(j)
				Dim t As String = JO.RunMethod("toString",Null)
				If t.StartsWith(prefix) Then 
					If Not(t.contains(".wloaextras.")) Then 
						foundStr = t
						Exit							
					End If
				End If
			Next
			i = j + 1
		End If
	Next
	Return Array As String(prefix, foundStr)
End Sub

Private Sub getB4XCallingLine(prefix As String, foundStr As String) As String	'ignore
	Dim methodLOA As String
#if B4J
	Dim callingModule As String = foundStr.SubString(prefix.length)
	Dim parts() As String = Regex.Split("\.", callingModule)
	Dim module As String = parts(1)
	Dim lineNum As String = parts(3).SubString(5)
	lineNum = lineNum.trim
	lineNum = lineNum.substring2(0, lineNum.Length - 1)
	Dim path As String = File.DirApp & "\src\" & prefix.Replace(".", "\")
	Dim javalines As List = File.ReadList(path, module & ".java" )
	Dim n As Int = lineNum
	For k = n - 1 To 0 Step - 1
		If javalines.Get(k).As(String).contains("//BA.debug") Then 
			Dim w As String = javalines.Get(k)
			Dim method As String = w.SubString(w.IndexOf("wLOA.") + 5).Replace($"\""$, QUOTE)
			methodLOA = method.SubString2(0, method.LastIndexOf(QUOTE)) & Chr(0x2026)
			Exit
		End If
	Next
#End If
	Return methodLOA
End Sub

Private Sub colspecToArray(LOA As ListOfArrays, arg As Object) As Object() 'ignore
	Dim a() As Object = argToArray(arg)
	Dim colNames(a.length) As String
	For i = 0 To a.Length - 1
		Dim nam As String = a(i)
		If Not(LOA.mIndicesMap.ContainsKey(nam)) Then
			Dim maybe As String = closestName(LOA, nam)
#If DEMO
			Dim methodLOA As String
			Dim ar() As String = getJavaLine
			Dim prefix As String = ar(0)
			Dim foundStr As String = ar(1)
			If foundStr.Length > 0 Then 
				methodLOA = getB4XCallingLine(prefix, foundStr)
			End If
			If methodLOA.Length > 0 Then 
				Log($"ERR: Unknown column name in ${methodLOA}: '${nam}' (the closest name found is '${maybe}')"$)
			Else
				Log($"ERR: Unknown column name: '${nam}' (the closest name found is '${maybe}')"$)
			End If
#Else			
	 		Log($"ERR: Unknown column name: '${nam}' (the closest name found is '${maybe}')"$)
#End If
			ExitApplication
			Return Null
		End If
		colNames(i) = nam
	Next
	Return colNames
End Sub

Private Sub argToArray(arg As Object) As Object()
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

Private Sub emptyLst As List
	Dim rlst As List
	rlst.Initialize
	Return rlst
End Sub

Private Sub dToR(lst As List) As List
	For i = 0 To lst.Size - 1
		Dim obj As Object = lst.Get(i)
		If Not(obj = Null) And IsNumber(obj) Then 
			Dim d As Double = obj
			Do While d < 0
				d = d + 360
			Loop
			Do While d > 360
				d = d - 360
			Loop
			lst.Set(i, d * cPI / 180)
		Else	
			lst.Set(i, Null)
		End If
	Next	
	Return lst
End Sub

Private Sub rToD(lst As List) As List
	For i = 0 To lst.Size - 1
		Dim obj As Object = lst.Get(i)
		If Not(obj = Null) And IsNumber(obj) Then 
			Dim rad As Double = obj
			Dim d As Double = 180 * rad / cPI
			Do While d < 0
				d = d + 360
			Loop
			Do While d > 360
				d = d - 360
			Loop
			lst.Set(i, d)
		Else	
			lst.Set(i, Null)
		End If
	Next	
	Return lst
End Sub

Private Sub standardize2(lst As List) As List
	Dim sum, nsum As Double
	For i = 0 To lst.Size - 1
		Dim obj As Object = lst.Get(i)
		If Not(obj = Null) And IsNumber(obj) Then
			sum = sum + obj.As(Double)
			nsum = nsum + 1				
		End If
	Next
	If nsum > 1 Then 
		Dim meanx As Double = sum / nsum
		Dim sumx As Double
		Dim numx As Double
		For i = 0 To lst.Size - 1
			Dim obj As Object = lst.Get(i)
			If Not(obj = Null) And IsNumber(obj) Then
				Dim d As Double = obj
				Dim dif As Double = (d - meanx)
				sumx = sumx + dif * dif
				numx = numx + 1
			End If
		Next
		Dim var As Double = sumx / (numx - 1)
		Dim stdevx As Double = Sqrt(var)
	End If
	For i = 0 To lst.Size - 1
		Dim obj As Object = lst.Get(i)
		If Not(obj = Null) And IsNumber(obj) Then
			Dim d As Double = obj
			lst.Set(i, (d - meanx) / stdevx)
		Else
			lst.Set(i, Null)
		End If
	Next
	Return lst
End Sub

Private Sub totitle(t As String) As String
	Dim s As String = t
	s = s.ToLowerCase
	Dim mm As Matcher = Regex.Matcher("\b(\w)", s)
	Do While mm.Find
		Dim ii As Int = mm.GetStart(1)
		s = s.SubString2(0, ii) & s.SubString2(ii, ii + 1).ToUpperCase & s.SubString(ii + 1)
	Loop
	Return s
End Sub

Private Sub register(mp As Map, dat As String)
	If mp.ContainsKey(dat) Then
		mp.Put(dat, 1 + mp.Get(dat))
	Else
		mp.Put(dat, 1)
	End If
End Sub

Private Sub evalGeneric(LOA As ListOfArrays, colspec As Object, Expression As String, targetLocation As String) As ListOfArrays 'ignore
	Dim colArr() As Object = argToArray(colspec)
	If colArr.Length = 0 Then colArr = LOA.Header
	Dim newCols As Int = colArr.Length
	For j = 0 To newCols - 1
		Dim colName As String = colArr(j)
		
		Dim Expr As String = Expression.replace("?", colName)
		If targetLocation = "replace" Then confirmName(LOA, colName)
		Dim e As wLOAEval
		e.Initialize(Me, "Eval")
		Dim lst As List = e.eval_X(LOA, colName, Expression)
		Dim newName As String = colName

		Select targetLocation
			Case "append"
				Dim k As Int = newName.LastIndexOf("_R")
				If k > newName.Length - 4 Then 
					Dim vnum As Int = newName.SubString(k + 2)
					newName = newName & "_" & (vnum + 1)
				End If
				LOA.AddColumn(newName, lst)
			Case "replace"
				Dim inx As Int = LOA.ColumnIndexToOrdinal(colName)
				LOA.Header(inx) = newName
				LOA.SetColumn(inx, lst)
			Case "create"	
				If j = 0 Then 
					Dim newLOA As ListOfArrays = LOAUtils.CreateEmpty(Array(newName))
					For Each obj As Object In lst
						newLOA.AddRow(Array(obj))
					Next
				Else
					newLOA.AddColumn(newName, lst)
				End If
		End Select
		If EvalExpression.Length > 0 Then EvalExpression = EvalExpression & CRLF
		EvalExpression = EvalExpression & "EVAL: " & newName  & " = " & Expr
	Next
	Select targetLocation
		Case "append": Return LOA
		Case "replace": Return LOA
		Case "create": Return newLOA
	End Select	
End Sub

Private Sub confirmName(LOA As ListOfArrays, Nam As String)
	If Not(LOA.mIndicesMap.ContainsKey(Nam)) Then
		Dim maybe As String = closestName(LOA, Nam)
#If DEMO
		Dim methodLOA As String
		Dim ar() As String = getJavaLine
		Dim prefix As String = ar(0)
		Dim foundStr As String = ar(1)
		If foundStr.Length > 0 Then 
			methodLOA = getB4XCallingLine(prefix, foundStr)
		End If
		If methodLOA.Length > 0 Then 
			Log($"ERR: Unknown column name in ${methodLOA}: '${Nam}' (the closest name found is '${maybe}')"$)
		Else
			Log($"ERR: Unknown column name: '${Nam}' (the closest name found is '${maybe}')"$)
		End If
#Else			
 		Log($"ERR: Unknown column name: '${nam}' (the closest name found is '${maybe}')"$)
#End If
		ExitApplication
	End If
End Sub

Private Sub copyRow(r() As Object) As Object
	Dim newr(r.Length) As Object
	For j = 0 To r.Length - 1
		newr(j) = r(j)
	Next
	Return newr
End Sub

Private Sub generic(f As String, LOA As ListOfArrays, colspec As Object, params As Object) As ListOfArrays
	Dim extra() As Object = argToArray(params)
	Dim colArr() As Object = colspecToArray(LOA, colspec)
	If colArr.Length = 0 Then colArr = LOA.Header
	Dim nrows As Int = LOA.mInternalArray.Size - 1
	Dim nCols As Int = colArr.Length
	Dim h(nCols) As Object
	Dim LOAh() As Object = LOA.header
	Dim new As ListOfArrays
	For j = 0 To nCols - 1
		Dim lst As List = LOA.GetColumn(colArr(j))
		If f = "dateTime_X" Then
			Dim g As String = extra(0)
			h(j) = $"${LOAh(j)}_${g}"$
		Else	 
			h(j) = $"${LOAh(j)}_${f.SubString2(0, f.Length - 2)}"$
		End If
		Dim rlst As List = CallSub3(Me, f, lst, extra)
		If j = 0 Then 
			new = LOAUtils.CreateEmpty(Array(h(j)))
			For i = 0 To nrows - 1
				new.addRow(Array(rlst.Get(i)))
			Next
		Else
			new.AddColumn(h(j), rlst)
		End If
	Next
	Return new
End Sub

#End Region

#if TODO
	summaryStats(LOA As ListOfArrays, arg As Object) As ListOfArrays
	sum(LOA As ListOfArrays, arg As Object) As ListOfArrays
	mean(LOA As ListOfArrays, arg As Object) As ListOfArrays
	variance(LOA As ListOfArrays, arg As Object) As ListOfArrays
	stdDev(LOA As ListOfArrays, arg As Object) As ListOfArrays
	frequencies(LOA As ListOfArrays, arg As Object) As ListOfArrays
	median(LOA As ListOfArrays, arg As Object) As ListOfArrays
	percentiles(LOA As ListOfArrays, arg As Object, extra() as Object) As ListOfArrays
	
	Reshape and transpose
	Inverse?
	Linear regression?
	Breakdown
	Graphs?
	Grid?
#End If

