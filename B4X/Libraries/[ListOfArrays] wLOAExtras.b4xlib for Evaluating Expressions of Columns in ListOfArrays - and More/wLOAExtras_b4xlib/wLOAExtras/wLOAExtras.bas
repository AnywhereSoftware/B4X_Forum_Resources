B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Type sortPair(number As Double, obj As Object)
	Private dividerChar As String = Chr(0x2015)	
	Private dividerLine As String
	Private EvalExpression As String

	Public HeaderStyle As String = "c"
	Private alph As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	
	Private callback As Object
	Private nameSub As String
	Private functionNames As Map
	
	Private weekdays() As String = Array As String("", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
	Private monthnames() As String = Array As String("", "January", "February", "March", "April", "May", "June", _
			"July", "August", "September", "October", "November", "December")
			
	Private traceHelper As List
	Private javamap As Map
	Private tokens As Map
	
	Private log_font As String
	Private Const COLUMN_TYPE_DATE As Int = 3
	Private Const COLUMN_TYPE_NUMBERS As Int = 2
	Private Const COLUMN_TYPE_TEXT As Int = 1
	Private Const COLUMN_TYPE_VOID As Int = 4
	
#If UI	or B4A
	Dim recordBlanks As Map
	Dim TableX As B4XTable
#End If
End Sub

Public Sub Initialize(calling As Object)
	tokens.Initialize
#If UI	or B4A
	recordBlanks.Initialize
#End If	
#if b4j and DEMO
	PrepareSourceLineNumbers(".display")
#End If
	callback = calling
	
	'This section is just to get the IDE Log FontName - can't be done in B4A
#If B4J
	Dim cDir As String = File.DirApp
	Dim user As String = cDir.SubString(cDir.IndexOf("Users\") + 6)
	user = user.SubString2(0, user.IndexOf("\"))
	cDir = cDir.SubString2(0, cDir.IndexOf("Users\") + 6) & user & "\AppData\Roaming\Anywhere Software\B4J"
	If File.Exists(cDir, "b4xV5.ini") Then
		Dim configLines As List = File.ReadList(cDir, "b4xV5.ini")
		For Each s As String In configLines
			If s.Contains("=") Then
				If s.StartsWith("logs_FontName2") Then
					log_font = s.SubString(s.IndexOf("=") + 1).trim
					Exit
				End If
			End If
		Next
	End If
#End If 
End Sub

Private Sub applyStyle(index As Int) As String
	Dim head As String
	If SubExists(callback, nameSub) Then 
		head = CallSub2(callback, nameSub, index)
	Else
		Dim s As String = HeaderStyle.charAt(0)
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

'Returns an Object Array with the predominant object type of each column in LOA
Public Sub getTypes(LOA As ListOfArrays) As Object()
	Dim types(LOA.NumberOfColumns) As Object
	For j = 0 To LOA.NumberOfColumns - 1
		Dim lst As List = LOA.GetColumn(LOA.Header(j))
		Dim mp As Map: mp.initialize	
		types(j) = getLstType(mp, lst, .50)
	Next
	Return types
End Sub

#If UI or B4A
'If the B4XTable is included in the Libraries Manager then will show a table of the LOA
Public Sub ShowInTable(LOA As ListOfArrays, Table As B4XTable)
	TableX = Table
	Table.Clear
	If LOA.IsEmpty Then Return
	If LOA.FirstRowIsHeader = False Then
		Log("ERR: Missing header names")
		Return
	End If
	Dim coltypes() As Object = getTypes(LOA)
	For j = 0 To LOA.ColumnIndices.Size - 1
		Dim col As Int = LOA.ColumnIndices.Get(j)
		Dim ColType As Int
		Dim ColName As String = LOA.Header(col)
		Dim ctype As String = coltypes(col)
		Select ctype
			Case "Long": ColType = COLUMN_TYPE_DATE
			Case "String" : ColType = COLUMN_TYPE_TEXT
			Case "Integer", "Float", "Double", "Short": ColType = COLUMN_TYPE_NUMBERS
			Case Else: ColType = COLUMN_TYPE_VOID
		End Select 
		Table.AddColumn(ColName, ColType)
		Dim lst As List = LOA.GetColumn(ColName)
		Dim newLst As List: newLst.Initialize
		For i = 0 To lst.Size - 1
			Dim obj As Object = lst.Get(i)
			If obj = Null Then 
				recordBlanks.Put(i & "_" & j, "")
				obj = 1 / 0			'Force overflow value in table to be checked for and rendered as dash
			Else 
				Dim typ As String = GetType(obj)
				Dim k As Int = typ.LastIndexOf(".")
				typ = typ.SubString(k + 1)
				If ctype.Length > 0 And typ.toLowerCase <> ctype.toLowerCase Then
					If Not(ColType = COLUMN_TYPE_NUMBERS And IsNumber(obj)) Then
						recordBlanks.Put(i & "_" & j, obj.As(String))
						obj = 1 / 0		'Force overflow value in table to be checked for and rendered with unusual value
					End If
				Else
				End If
			End If
			newLst.add(obj)
		Next
		If j = 0 Then 
			Dim newLOA As ListOfArrays = LOAUtils.CreateEmpty(Array(ColName))
			For Each obj As Object In newLst
				newLOA.addRow(Array(obj))
			Next
		Else
			newLOA.AddColumn(ColName, newLst)
		End If
	Next
	Table.SetData(B4XCollections.SubList(newLOA.mInternalArray, 1, newLOA.mInternalArray.Size))
	Sleep(500)
End Sub

Public Sub ExceptionHandler
	Dim rows As List = TableX.VisibleRowIds
	For j = 0 To TableX.Columns.Size - 1
		Dim col As B4XTableColumn = TableX.Columns.Get(j)
		For i = 0 To rows.Size - 1
			Dim pnl As B4XView = col.CellsLayouts.Get(i + 1)
			Dim lbl As B4XView = pnl.GetView(0)
			If lbl.Text = "OVERFLOW" Then
				lbl.Text = Chr(0x2015)
				Dim exception As String = recordBlanks.GetDefault((rows.get(i) - 1) & "_" & j, "")
				If exception.Length > 0 Then lbl.Text = exception
			End If
		Next
	Next
End Sub
#End If

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
		Dim maybe As String = closestName2(LOA, Name)
		If maybe.length = 0 Then 
			maybe = "There is no function name that is similar"
		Else
			maybe = "The closest name found is '${maybe}'"
		End If

		Dim ar() As String = getJavaLine
		Dim module As String = ar(1)
		Dim lineNum As Int = ar(2)
		If lineNum > -1 And javamap.IsInitialized Then
			Dim lst As List = javamap.Get(module)
			Dim v() As String = Regex.Split(TAB, lst.Get(lineNum))
			Log($"ERR: Unknown function '${Name}' in ${module} Line ${v(2)}: ${maybe}"$)
		Else
			Log($"ERR: Unknown function '${Name}': ${maybe}"$)
		End If
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
#if Demo
	Log("#If DemoLog")
#End If
	Dim ar() As String = getJavaLine
	Dim module As String = ar(1)
	Dim lineNum As Int = ar(2)
	Dim LOAName As String
	
	If lineNum > -1 And javamap.IsInitialized Then
		Dim lst As List = javamap.Get(module)
		Dim v() As String = Regex.Split(TAB, lst.Get(lineNum))
		LOAName = v(v.length -1)
		If LOAName.IndexOf("(") > - 1 Then 
			LOAName = LOAName.SubString2(LOAName.IndexOf("(") + 1, LOAName.IndexOf(",")).trim
			LOAName = LOAName.Replace("(", ": ")
		Else	
			LOAName = ""
		End If
	End If
	If LOAName.Length > 0 Then Log("________ " & LOAName & " __________")
	
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
	Dim mult As Int = 2.0
	If log_font = "Consolas" Then mult = 1.0

	Dim sample As Int = nrows
	If nrows > 1000 Then sample = 1000		'to compute widths
	For i = 0 To sample - 1
		Dim r() As Object = LOA.GetRow(i)
		For j = 0 To ncols - 1
			Dim obj As Object = r(j)
			If obj = Null Then 
				obj = "--"
			End If
			Dim s As String
			If IsNumber(obj) And decimals > -1 Then 
				s = NumberFormat2(obj, 1, decimals, decimals, False)
			Else if isArray(obj) Then 
				Dim arx() As Object = obj
				If arx.Length = 3 And ("_F_" = arx(1) Or "_%_" = arx(1)) Then 
					If arx(0) = Null Then 
						s = "--"
					Else
						Dim nd As Int = arx(2)
						If nd > 3 Then nd = decimals + 1
						s = NumberFormat2(arx(0), 1, nd, nd, False)
						If "_%_" = arx(1) Then s = s & "%"
					End If
				Else If arx.Length = 3 And ("_DASH_" = arx(1)) Then 
					s = arx(0) & "_" & arx(2)
				Else
					Dim sbx As StringBuilder: sbx.Initialize
					For mx = 0 To arx.Length - 1
						sbx.Append(arx(mx))
						If mx < arx.Length - 1 Then sbx.Append(",")
					Next
					s = sbx.toString
				End If
			Else
				Dim typ As String = GetType(obj)
				If Not(typ.StartsWith("java.lang")) Then
					If obj Is List Then 
						Dim al As List = obj
						If al.Size = 0 Then 
							obj = "--"
						Else
							obj = "[" & Chr(0X2026) & "]"
						End If
					Else
						Dim class As String = typ.SubString(typ.lastindexof(".") + 1).trim
						Dim ref As String = class & "Display"
						If SubExists(callback, ref) Then 
							obj = CallSub2(callback, ref, obj)
						End If
					End If
				End If
				s = obj	
			End If
			Dim m As Int  = s.Length
			If mult = 2.0 And IsNumber(s) And s.Length > 5 Then m = m + 2
			If m < 5 Then m = 5
			If m < 25 Then
				If m > widths(j) Then widths(j) = m
			End If
		Next
	Next
	sb.Initialize
	For j = 0 To ncols - 1
		Dim s As String = h(j)
		If mult = 2.0 Then
			Dim nsp As Int = mult * (widths(j) - s.Length)
		Else 
			Dim nsp As Int = mult * (widths(j))
		End If
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
				If isArray(val) Then 
					Dim arx() As Object = val
					If arx.Length = 3 And ("_F_" = arx(1) Or "_%_" = arx(1)) Then 
						If arx(0) = Null Then 
							val = "--"
						Else
							Dim nd As Int = arx(2)
							If nd > 5 Then
								nd = 5
								val = NumberFormat2(arx(0), 1, nd, nd, False) & Chr(0X2026)
							Else
								val = NumberFormat2(arx(0), 1, nd, nd, False)
								If "_%_" = arx(1) Then val = val.As(String) & "%"
							End If
						End If
					Else If arx.Length = 3 And ("_DASH_" = arx(1)) Then 
						val = arx(0) & "_" & arx(2)
					Else
						Dim sbx As StringBuilder: sbx.Initialize
						For mx = 0 To arx.Length - 1
							sbx.Append(arx(mx))
							If mx < arx.Length - 1 Then sbx.Append(",")
						Next
						val = sbx.toString
					End If

					Dim typ As String = GetType(val)
					If Not(typ.StartsWith("java.lang")) Then
						If val Is List Then 
							Dim al As List = val
							If al.Size = 0 Then 
								val = "--"
							Else
								val = "[" & Chr(0X2026) & "]"
							End If
						Else
							Dim class As String = typ.SubString(typ.lastindexof(".") + 1).trim
							Dim ref As String = class & "Display"
							If SubExists(callback, ref) Then 
								val = CallSub2(callback, ref, val)
							End If
						End If
					End If
				End If
				s = val
				If s.Length > widths(j) Then s = s.SubString2(0, widths(j) - 1) & Chr(0X2026)
			End If
			If mult = 2.0 Then
				Dim nsp As Int = mult * (widths(j) - s.Length)
			Else 
				Dim nsp As Int = mult * (widths(j))
			End If
			If s.Contains("M") And mult = 2.0 Then nsp = nsp - 2   'special case for info 'Maximum
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
	#if Demo
		Log("#End If")
	#End If

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
	Try
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
	Catch
		Dim ar() As String = getJavaLine
		Dim module As String = ar(1)
		Dim lineNum As Int = ar(2)
		If lineNum > -1 And javamap.IsInitialized Then
			Dim lst As List = javamap.Get(module)
			Dim v() As String = Regex.Split(TAB, lst.Get(lineNum))
			Log($"ERR: Error in Range object - only integers are valid: in ${module} Line ${v(2)}"$)
		Else
			Log($"ERR: Error in Range object - only integers are valid"$)
		End If
		ExitApplication
	End Try
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
'Predominant means > Threshold% of column's items object type
Public Sub RowsIfValid(LOA As ListOfArrays, Threshold As Double) As ListOfArrays
	Dim new As ListOfArrays = LOAUtils.CreateEmpty(LOA.Header)
	For j = 0 To LOA.NumberOfColumns - 1
		Dim colname As String = LOA.Header(j)
		Dim infox() As Object = computeInfoData(LOA, colname, j, Null, Threshold)
		Dim lstType As String = infox(0)
		Dim isNumeric As Boolean = infox(1)
		Dim lst As List = LOA.GetColumn(colname)
		If j = 0 Then 
			Dim drop(lst.Size) As Boolean
		End If
		For i = 0 To lst.Size - 1
			Dim obj As Object = lst.Get(i)
			If drop(i) = False Then 
				If Not(obj = Null) Then
					Dim typ As String = GetType(obj)
					Dim k As Int = typ.LastIndexOf(".")
					typ = typ.SubString(k + 1)
					If lstType.Length > 0 And typ.toLowerCase <> lstType.toLowerCase Then
						If Not(isNumeric And typ = "Integer") Then drop(i) = True
					End If
				Else
					drop(i) = True
				End If
			End If
		Next
	Next
	For i = 0 To lst.Size - 1
		If Not(drop(i)) Then new.AddRow(copyRow(LOA.GetRow(i)))
	Next
	Return new
End Sub

'Creates two new LOAs. The percent of the larger of the two is specified. For example 80 for 80% | 20% split.
'The rows are selected randomly using a pseudonumber generator.
'The arrays are returned in a a tuple object array - Array(_Largest, _Smallest)
'Rows are copied - originals remain independent and intact
Public Sub RowsSplit2(LOA As ListOfArrays, LargestPercent As Double) As Object()
	Dim nrows As Int = LOA.mInternalArray.size - 1
	Dim indices As List: indices.initialize
	For i = 0 To nrows - 1
		indices.Add(i)		
	Next
	Dim n2 As Int = (LargestPercent / 100.0) * nrows
	Dim n1 As Int = nrows - n2
	Dim sIndices As List: sIndices.Initialize
	For i = 0 To n1 - 1
		Dim index As Int = Rnd(0, indices.Size)
		sIndices.Add(indices.Get(index))
		indices.RemoveAt(index)
	Next
	Dim new1 As ListOfArrays = LOAUtils.CreateEmpty(LOA.Header)
	For i = 0 To indices.Size - 1
		Dim r() As Object = copyRow(LOA.GetRow(indices.Get(i)))
		new1.AddRow(r)
	Next

	Dim new2 As ListOfArrays = LOAUtils.CreateEmpty(LOA.Header)
	For i = 0 To sIndices.Size - 1
		Dim r() As Object = copyRow(LOA.GetRow(sIndices.Get(i)))
		new2.AddRow(r)
	Next
	Return Array(new1, new2)
End Sub

'Creates a composite LOA with the lowest n1 values and the highest n2 values for numerical data.
'Used to to identify anomolies in the data.
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() or "" the operations will be applied to all columns
Public Sub Outliers(LOA As ListOfArrays, colspec As Object, nLowest As Int, nHighest As Int) As ListOfArrays
	Dim colArr() As Object = colspecToArray(LOA, colspec)
	If colArr.length = 0 Then colArr = LOA.header
	Dim newCols As Int = colArr.Length
	Dim newHeaders As List: newHeaders.Initialize
	Dim types As List: types.Initialize
	For j = 0 To newCols - 1
		Dim nam As String = colArr(j)
		Dim lst As List = LOA.GetColumn(nam)
		Dim mp As Map: mp.initialize
		Dim lstType As String = getLstType(mp, lst, .50)
		If  "Integer.Long.Float.Double".contains(lstType) Then 
			newHeaders.Add(nam)
			types.Add(nam)
		End If
	Next
	Dim hdr(newHeaders.size) As Object
	For j = 0 To newHeaders.size - 1
		hdr(j) = newHeaders.get(j)
	Next
	For j = 0 To newHeaders.size - 1
		Dim nam As String = newHeaders.get(j)
		Dim lst As List = LOA.GetColumn(nam)
		Dim lstType As String = types.Get(j)
		Dim temp As List: temp.Initialize
		For i = 0 To lst.Size - 1
			Dim obj As Object = lst.get(i)
			If Not(obj = Null) Then
				Dim typ As String = GetType(obj)
				Dim k As Int = typ.LastIndexOf(".")
				typ = typ.SubString(k + 1).toLowerCase
				If "integer.long.float.double".contains(typ) Then 
					temp.Add(NewSortPair(obj, Array(obj, "_DASH_", i)))
				End If
			End If
		Next
		temp.SortType("number", True)
		Dim resList As List: resList.Initialize
		For i = 0 To Min(nLowest, temp.size) - 1
			resList.add(temp.Get(i).As(sortPair).Obj)
		Next
		resList.Add(Null)
		
		Dim nst As Int = temp.size - nHighest
		For i = Max(0, nst) To temp.size - 1
			resList.Add(temp.Get(i).As(sortPair).Obj)
		Next

		If j = 0 Then 
			Dim newLOA As ListOfArrays = LOAUtils.CreateEmpty(Array(nam))
			For i = 0 To resList.size - 1
				newLOA.AddRow(Array(resList.Get(i)))
			Next
		Else
			newLOA.AddColumn(nam, resList)
		End If 
	Next
	Return newLOA
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
'Column Type	(derived from analyzing the data - it is the predominant type - > Threhold% of items have it.
'Num Rows
'Num Missing    (Nulls)
'Num Unusual	(Not the Column Type)
'Num Valid
'Minimum
'Maximum		
'Decimals		
Public Sub Info(LOA As ListOfArrays, colspec As Object, Threshold As Double) As ListOfArrays
	Dim colArr() As Object = colspecToArray(LOA, colspec)
	If colArr.Length = 0 Then colArr = LOA.Header
	Dim oldnames() As Object = LOA.Header
	
	Dim newCols As Int = colArr.Length
	Dim newNames(newCols + 1) As Object
	If log_font = "Consolas" Then
		newNames(0) = "       " & TAB
	Else 
		newNames(0) = "                     " & TAB
	End If
	For j = 0 To newCols - 1
		Dim nam As String = colArr(j)
		Dim index As Int = LOA.ColumnIndexToOrdinal(nam)
		newNames(j + 1) = oldnames(index) & "_Info"
	Next
	
	Dim new As ListOfArrays = LOAUtils.CreateEmpty(newNames)
	
	Dim kInfo As Int = 9
	Dim infoData(newCols, kInfo) As Object
	For j = 0 To newCols - 1
		Dim nam As String = colArr(j)
		computeInfoData(LOA, nam, j, infoData, Threshold)
	Next
		
	Dim rlabels() As String = Array As String("Column Type", "Number Rows", "Number Missing", "Number Unusual", "Number Valid", "Minimum", "Maximum", "Decimals", "Unusual Values")
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

Private Sub GetPackageName As String
    #If B4A
    Return Application.PackageName
    #Else If B4I
    Dim no As NativeObject
    no = no.Initialize("NSBundle").RunMethod("mainBundle", Null)
    Dim name As Object = no.RunMethod("objectForInfoDictionaryKey:", Array("CFBundleIdentifier"))
    Return name
    #Else If B4J
    Dim joBA As JavaObject
    joBA.InitializeStatic("anywheresoftware.b4a.BA")
    Return joBA.GetField("packageName")
    #End If
End Sub

Private Sub getJavaLine As String()
#if B4A
	Return Array As String("", "", -1)
#End if
    Dim Throwable As JavaObject
	Throwable.InitializeNewInstance("java.lang.Throwable",Null)
    Dim sTrace() As Object = Throwable.RunMethod("getStackTrace", Null)
	Dim JO As JavaObject
	Dim foundStr As String
	Dim prefix As String = GetPackageName
	For i = 0 To sTrace.Length - 1
		JO = sTrace(i)
		Dim s As String = JO.RunMethod("toString",Null)
		If s.StartsWith(prefix) Then 
			Dim rest As String = s.SubString(prefix.Length + 1)
			Dim thisModule As String = rest.SubString2(0, rest.IndexOf("."))
			For j = i + 1 To sTrace.Length - 1
				JO = sTrace(j)
				Dim t As String = JO.RunMethod("toString",Null)
				If t.StartsWith(prefix) And Not(t.contains(".wloaeval") Or t.contains(".wloaextras"))  Then
					If Not(t.contains("." & thisModule & ".")) Then 
						foundStr = t
						Exit							
					End If
				End If
			Next
		End If
		If foundStr.Length > 0 Then Exit
	Next
	If foundStr.Length = 0 Then
		Return Array As String("", "", -1)
	Else
		Dim callingModule As String = foundStr.SubString(prefix.length)
		Dim parts() As String = Regex.Split("\.", callingModule)
		Dim module As String = parts(1)
		Dim lineNum As String = parts(3).SubString(5)
		lineNum = lineNum.trim
		lineNum = lineNum.substring2(0, lineNum.Length - 1)
		Return Array As String(prefix, module, lineNum - 3)
	End If
End Sub

Private Sub getB4XCallingLine(prefix As String, module As String, lineNum As Int) As String	'ignore
	Dim methodLOA As String
#if B4J
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

Public Sub HandleError(ref As String, lastExpression As String)
	Dim ar() As String = getJavaLine
	Dim module As String = ar(1)
	Dim lineNum As String = ar(2)
	If lineNum > -1 And javamap.IsInitialized Then
		Dim lst As List = javamap.Get(module)
		Dim v() As String = Regex.Split(TAB, lst.Get(lineNum))
		Log($"ERR: Unknown item '${ref}' in expression:  ${lastExpression} [${module} line ${v(2)}]"$)
	Else
		Log($"ERR: Unknown item '${ref}' in expression:  ${lastExpression}"$)
	End If
End Sub

Private Sub colspecToArray(LOA As ListOfArrays, arg As Object) As Object() 'ignore
	Dim a() As Object = argToArray(arg)
	Dim colNames(a.length) As String
	For i = 0 To a.Length - 1
		Dim nam As String = a(i)
		If Not(LOA.mIndicesMap.ContainsKey(nam)) Then
			Dim maybe As String = closestName(LOA, nam)
			If maybe.length = 0 Then 
				maybe = "(There is no column name that is similar)"
			Else
				maybe = "(the closest name found is '${maybe}')"
			End If

			Dim ar() As String = getJavaLine
			Dim module As String = ar(1)
			Dim lineNum As String = ar(2)
			If lineNum > -1 And javamap.IsInitialized Then
				Dim lst As List = javamap.Get(module)
				Dim v() As String = Regex.Split(TAB, lst.Get(lineNum))
				Log($"ERR: Unknown column name in ${module} Line ${v(2)}: '${nam}' ${maybe}"$)
			Else
				Log($"ERR: Unknown column name: '${nam}' ${maybe})"$)
			End If

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

Public Sub emptyLst As List
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
	Dim sum, sumsq, nsum As Double
	For i = 0 To lst.Size - 1
		Dim obj As Object = lst.Get(i)
		If Not(obj = Null) And IsNumber(obj) Then
			Dim d As Double = obj
			sum = sum + d
			sumsq = sumsq + d* d
			nsum = nsum + 1				
		End If
	Next
	If nsum > 1 Then 
		Dim mean As Double = sum / nsum
		Dim var As Double = (sumsq - (sum * sum) / nsum) / (nsum - 1)
		Dim stdevx As Double = Sqrt(var)
	Else
		Return lst
	End If
	For i = 0 To lst.Size - 1
		Dim obj As Object = lst.Get(i)
		If Not(obj = Null) And IsNumber(obj) Then
			Dim d As Double = obj
			lst.Set(i, (d - mean) / stdevx)
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
		If maybe.length = 0 Then 
			maybe = "(There is no column name that is similar)"
		Else
			maybe = "(the closest name found is '${maybe}')"
		End If

		Dim ar() As String = getJavaLine
		Dim module As String = ar(1)
		Dim lineNum As String = ar(2)
		If lineNum > -1 And javamap.IsInitialized Then
			Dim lst As List = javamap.Get(module)
			Dim v() As String = Regex.Split(TAB, lst.Get(lineNum))
			Log($"ERR: Unknown column name in ${module} Line ${v(2)}: '${Nam}' ${maybe}"$)
		Else
			Log($"ERR: Unknown column name: '${Nam}' ${maybe})"$)
		End If
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

Private Sub getLstType(mp As Map, lst As List, threshold as double) As String		'This uses the random sample of 1000 for LOA with more than 1000 rows
	Dim typ As String = "object"
	Dim custom As String
	Dim mmm As Int = Min(lst.Size, 1000)
	Dim rndSelect As List: rndSelect.initialize
	Dim rndPossibles As List: rndPossibles.initialize
	If mmm >= 1000 Then 
		For i = 0 To lst.Size - 1
			rndPossibles.Add(i)	
		Next
	End If
	For i = 0 To  mmm - 1
		If mmm < 1000 Then 
			Dim obj As Object = lst.Get(i)
		Else
			Dim rndIndex As Int = Rnd(0, rndPossibles.Size)
			Dim obj As Object = lst.Get(rndPossibles.Get(rndIndex))
			rndPossibles.removeAt(rndIndex)
		End If
		If Not(obj = Null) Then
			Dim typ As String = GetType(obj)
			If Not(typ.StartsWith("java.lang")) Then 
				custom = typ.SubString(typ.lastindexof(".") + 1).trim
				custom = custom.CharAt(0).As(String).ToUpperCase & custom.SubString(1)
			End If
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
			Else if custom.Length > 0 Then 
				register(mp, custom)
			Else
				register(mp, "Object")
			End If
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
	Dim lstType As String
	If (maxn / alln) > threshold Then
		lstType = maxFound
	End If 
	Return lstType
End Sub

Private Sub computeInfoData(LOA As ListOfArrays, nam As String, j As Int, details As Object, threshold As Double) As Object()
	threshold = threshold / 100
	If Not(details = Null) Then 
		Dim infoData(,) As Object = details
	End If
	Dim nrows As Int = LOA.mInternalArray.Size - 1
	Dim mp As Map: mp.initialize
	Dim lst As List = LOA.GetColumn(nam)
	Dim Invalids As List: Invalids.initialize

	Dim lstType As String = getLstType(mp, lst, threshold) 

	Dim nItems As Int = nrows
	Dim isNumeric As Boolean = "Integer.Long.Float.Double".contains(lstType)
	Dim nMissing As Int
	For i = 0 To nrows - 1
		Dim obj As Object = lst.Get(i)
		If obj = Null Then
			nMissing = nMissing + 1
		End If
	Next

	Dim nValid As Int
	Dim nInvalid As Int
	If lstType.Length > 0 Then
		Invalids.clear
		For i = 0 To nrows - 1
			Dim obj As Object = lst.Get(i)
			If Not(obj = Null) Then
				Dim typ As String = GetType(obj)
				Dim k As Int = typ.LastIndexOf(".")
				typ = typ.SubString(k + 1)
				If lstType.Length > 0 And typ.toLowerCase <> lstType.toLowerCase Then
					If Not(isNumeric And IsNumber(typ)) Then
						Invalids.Add(obj)
						nInvalid = nInvalid + 1
					Else
						nValid = nValid + 1
					End If
				Else
					nValid = nValid + 1
				End If
			End If
		Next
		Dim origDecimals As Int
		If isNumeric Then
			If (lstType = "Integer") Or (lstType = "Long") Then
				origDecimals = 0
			Else
				origDecimals = 0
				For Each obj As Object In lst
					If (obj Is Float) Or (obj Is Double) Then
						Dim g As String = obj
						Dim k As Int = g.IndexOf(".")
						Dim m As Int = g.Length - k
						If m > origDecimals Then 
							origDecimals = m
						End If
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
		Invalids.clear
		nInvalid = 0
	End If

	Dim minValue As Double = 1 / 0
	Dim maxValue As Double = -1 / 0
	If isNumeric Then 
		For i = 0 To nrows - 1
			Dim obj As Object = lst.Get(i)
			If Not(obj = Null) Then
				If IsNumber(obj) Then
					Dim dbl As Double = obj
					If dbl > maxValue Then maxValue = dbl
					If dbl < minValue Then minValue = dbl
				End If
			End If
		Next
	End If

	Dim maxVal As Object = maxValue
	Dim minVal As Object = minValue
	If (-1 / 0) = maxValue Then maxVal = Null
	If (1 / 0) = minValue Then minVal = Null
	
	If Not(details = Null) Then 
		infoData(j, 0) = lstType
		infoData(j, 1) = nItems
		infoData(j, 2) = nMissing
		infoData(j, 3) = nInvalid
		infoData(j, 4) = nItems - nMissing - nInvalid
		infoData(j, 5) = Array(minVal, "_F_", origDecimals)
		infoData(j, 6) = Array(maxVal, "_F_", origDecimals)
		If isNumeric Then
			infoData(j, 7) = origDecimals
		Else
			infoData(j, 7) = Null
		End If
		infoData(j, 8) = Invalids
		Return Array()
	Else	
		Return Array(lstType, isNumeric, origDecimals, Invalids, minVal, maxVal)
	End If
End Sub

Private Sub tokenizeQuotes(Input As String) As String	'ignore
	Dim Q As String = QUOTE
	Dim InsideQuotes As Boolean
	Dim mainsb As StringBuilder: mainsb.Initialize
	Dim sb As StringBuilder: sb.Initialize
	Dim CurrentIndex As Int = 0
	Do While CurrentIndex < Input.Length
		Dim c As String
		c = Input.CharAt(CurrentIndex)
		If InsideQuotes Then
			If c = Q Then
				Dim temp As String = "_TEMP" & tokens.size & "_"
				mainsb.Append(temp)
				tokens.Put(temp, sb.ToString)
				sb.Initialize
				InsideQuotes = False
			Else
				sb.Append(c)
			End If
		Else
			If c = Q Then
				InsideQuotes = True
			Else
				mainsb.Append(c)
			End If
		End If
		CurrentIndex = CurrentIndex + 1
	Loop
	Return mainsb.toString
End Sub

#End Region

#Region NewMethods (post Version 1.02)

'Creates a new LOA with a statistical summary of numerical columns of an existing LOA
'"colspec" can be: 1. column names as List; 2. column names as Array; 3. column name as String
'If colspec is Null or Array() the method will be applied to all columns
'If a column is non-numerical it is excluded from the summary
'Threhold defines what is considered unusual (> 95% = Threshold = 95)
Public Sub StatsNumerical(LOA As ListOfArrays, colspec As Object, nBins As Int, binStyle As String, Threshold As Double) As ListOfArrays
	Dim colArr() As Object = argToArray(colspec)
	If colArr.Length = 0 Then colArr = LOA.Header
	Dim newCols As Int = colArr.Length
	Dim newLOA As ListOfArrays = LOAUtils.CreateEmpty(Array("Statistic"))
	Dim labels() As String = Array As String("Number Valid", "Minimum", "Maximum", "Sum", "Mean", _
		"Variance", "Std. Dev.", "Bin Size", "1%tile", "5%tile", "10%tile", "25%tile", "33.3%tile", _
		"50%(Median)", "66.7%tile", "75%tile", "90%tile", "95%tile", "99%tile")
	For mm = 0 To 7
		newLOA.AddRow(Array(labels(mm)))
	Next
	For j = 0 To newCols - 1
		Dim colName As String = colArr(j)
		Dim infox() As Object = computeInfoData(LOA, colName, j, Null, Threshold)
		Dim isNumeric As Boolean = infox(1)
		If isNumeric Then 
			Dim dec As Int = infox(2)
			Dim inValids As List = infox(3)
			Dim minx As Double = infox(4)
			Dim maxx As Double = infox(5)
			Dim lst As List = LOA.GetColumn(colName)
			Dim vlst As List: vlst.initialize
			For Each obj As Object In lst
				If Not(obj = Null) And inValids.IndexOf(obj) = -1 Then vlst.Add(obj.As(Double))
			Next
			
			Dim rlst As List: rlst.Initialize
			Dim num As Double = vlst.Size
			rlst.Add(Array(num, "_F_", 0))
			rlst.Add(Array(minx, "_F_", dec))
			rlst.Add(Array(maxx, "_F_", dec))

			Dim rSum, rSumSq As Double
			For Each d As Double In vlst
				rSum = rSum + d
				rSumSq = rSumSq + d * d
			Next

			rlst.Add(IIf(lst.Size = 0, Null, Array(rSum, "_F_", dec)))
			rlst.Add(IIf(lst.Size = 0, Null, Array(rSum / num, "_F_", dec + 1)))
			If num > 1 Then 
				Dim var As Double = (rSumSq - (rSum * rSum) / num) / (num - 1)
				rlst.Add(Array(var, "_F_", dec + 2))
				rlst.Add(Array(Sqrt(var), "_F_", dec + 2))
			Else
				rlst.Add(Null)
			End If

			vlst.Sort(True)
		
			Dim Rangex As Double = maxx - minx
			Dim StepS As Double = Rangex / nBins.As(Double)
			rlst.Add(Array(StepS, "_F_", dec + 2))
			Dim binsU(nBins) As Double
			For m = 0 To nBins - 1
				binsU(m) = minx + (m + 1)  * StepS
			Next
			binsU(nBins - 1) = maxx
			If j = 0 Then 
				For mm = 1 To nBins
					newLOA.AddRow(Array("Bin #" & mm))
				Next
			End If
			Dim nsum As Int
			Dim lastNsum As Int
			Dim testIndex As Int
			For m = 0 To vlst.Size - 1
				Dim d As Double = vlst.Get(m)
				If d > binsU(testIndex) Then
					Select binStyle
						Case "%"
							rlst.Add(Array(100 * (nsum - lastNsum) / num, "_%_", 0))
						Case "#"
							rlst.Add(Array(nsum - lastNsum, "_F_", dec))
					End Select
					testIndex = testIndex + 1
					lastNsum = nsum
				End If
				nsum = nsum + 1
			Next
			Select binStyle
				Case "%"
					rlst.Add(Array(100 * (nsum - lastNsum) / num, "_%_", 0))
				Case "#"
					rlst.Add(Array(nsum - lastNsum, "_F_", dec))
			End Select

			If j = 0 Then 
				For mm = 8 To labels.length - 1
					newLOA.AddRow(Array(labels(mm)))
				Next
			End If
			Dim criteria() As Double = Array As Double (.00, .01, .05, .10, .25, .33333, .5, .66667, .75, .90, .95, 1.1)
			Dim csum As Double
			Dim testIndex As Int
			For m = 0 To vlst.Size - 1
				Dim d As Double = vlst.Get(m)
				csum = csum + 1
				Dim prop As Double = csum / num
				If prop > criteria(testIndex) Then 
					rlst.Add(Array(d, "_F_", dec))
					testIndex = testIndex + 1
				End If
			Next
			newLOA.AddColumn(colName, rlst)
		End If
	Next
	Return newLOA
End Sub

Public Sub NumberValid(LOA As ListOfArrays) As Map
	Dim firstItem As Object = LOA.GetValue(0, 0)
	If firstItem = "Column Type" Then 
		Dim ar() As Object = LOA.GetRow(4)
	Else
		Dim ar() As Object = LOA.GetRow(0)
	End If
	Dim res As Map: res.initialize
	Dim h() As Object = LOA.header
	For j = 1 To ar.Length - 1
		Dim lbl As String = h(j)		
		Dim o As Object = ar(j)
		res.Put(lbl, o)
	Next
	Return res
End Sub

Public Sub NumberMissing(LOA As ListOfArrays) As Map
	Dim firstItem As Object = LOA.GetValue(0, 0)
	If firstItem <> "Column Type" Then Return Null
	Dim ar() As Object = LOA.GetRow(2)
	Dim res As Map: res.initialize
	Dim h() As Object = LOA.header
	For j = 1 To ar.Length - 1
		Dim lbl As String = h(j)		
		Dim o As Object = ar(j)
		res.Put(lbl, o)
	Next
	Return res
End Sub

Public Sub NumberUnusual(LOA As ListOfArrays) As Map
	Dim firstItem As Object = LOA.GetValue(0, 0)
	If firstItem <> "Column Type" Then Return Null
	Dim ar() As Object = LOA.GetRow(3)
	Dim res As Map: res.initialize
	Dim h() As Object = LOA.header
	For j = 1 To ar.Length - 1
		Dim lbl As String = h(j)		
		Dim o As Object = ar(j)
		res.Put(lbl, o)
	Next
	Return res
End Sub

'Retrieves the lists of unusual values found wInfo.info
Public Sub UnusualValues(LOA As ListOfArrays) As Map
	Dim unusualVals As Map: unusualVals.Initialize
	Dim firstItem As Object = LOA.GetValue(0, 0)
	If firstItem <> "Column Type" Then Return Null
	Dim ar() As Object = LOA.GetRow(8)
	Dim res As Map: res.initialize
	Dim h() As Object = LOA.header
	For j = 1 To ar.Length - 1
		Dim lbl As String = h(j)		
		Dim o As Object = ar(j)
		res.Put(lbl, o)
	Next
	Return res
End Sub

Public Sub GetDecimals(LOA As ListOfArrays) As Map
	Dim firstItem As Object = LOA.GetValue(0, 0)
	If firstItem <> "Column Type" Then Return Null
	Dim ar() As Object = LOA.GetRow(7)
	Dim res As Map: res.initialize
	Dim h() As Object = LOA.header
	For j = 1 To ar.Length - 1
		Dim lbl As String = h(j)		
		Dim o As Object = ar(j)
		res.Put(lbl, o)
	Next
	Return res
End Sub

Public Sub GetMinimum(LOA As ListOfArrays) As Map
	Dim firstItem As Object = LOA.GetValue(0, 0)
	If firstItem = "Column Type" Then 
		Dim ar() As Object = LOA.GetRow(5)
	Else
		Dim ar() As Object = LOA.GetRow(1)
	End If
	Dim res As Map: res.initialize
	Dim h() As Object = LOA.header
	For j = 1 To ar.Length - 1
		Dim o() As Object = ar(j)
		Dim lbl As String = h(j)		
		res.Put(lbl, o(0))
	Next
	Return res
End Sub

Public Sub GetMaximum(LOA As ListOfArrays) As Map
	Dim firstItem As Object = LOA.GetValue(0, 0)
	If firstItem = "Column Type" Then 
		Dim ar() As Object = LOA.GetRow(6)
	Else
		Dim ar() As Object = LOA.GetRow(2)
	End If
	Dim res As Map: res.initialize
	Dim h() As Object = LOA.header
	For j = 1 To ar.Length - 1
		Dim o() As Object = ar(j)
		Dim lbl As String = h(j)		
		res.Put(lbl, o(0))
	Next
	Return res
End Sub

Public Sub GetSum(LOA As ListOfArrays) As Map
	Dim firstItem As Object = LOA.GetValue(0, 0)
	If firstItem = "Column Type" Then Return Null
	Dim ar() As Object = LOA.GetRow(3)
	Dim res As Map: res.initialize
	Dim h() As Object = LOA.header
	For j = 1 To ar.Length - 1
		Dim o() As Object = ar(j)
		Dim lbl As String = h(j)		
		res.Put(lbl, o(0))
	Next
	Return res
End Sub

Public Sub GetMean(LOA As ListOfArrays) As Map
	Dim firstItem As Object = LOA.GetValue(0, 0)
	If firstItem = "Column Type" Then Return Null
	Dim ar() As Object = LOA.GetRow(4)
	Dim res As Map: res.initialize
	Dim h() As Object = LOA.header
	For j = 1 To ar.Length - 1
		Dim o() As Object = ar(j)
		Dim lbl As String = h(j)		
		res.Put(lbl, o(0))
	Next
	Return res
End Sub

Public Sub GetVariance(LOA As ListOfArrays) As Map
	Dim firstItem As Object = LOA.GetValue(0, 0)
	If firstItem = "Column Type" Then Return Null
	Dim ar() As Object = LOA.GetRow(5)
	Dim res As Map: res.initialize
	Dim h() As Object = LOA.header
	For j = 1 To ar.Length - 1
		Dim o() As Object = ar(j)
		Dim lbl As String = h(j)		
		res.Put(lbl, o(0))
	Next
	Return res
End Sub

Public Sub GetStdDev(LOA As ListOfArrays) As Map
	Dim firstItem As Object = LOA.GetValue(0, 0)
	If firstItem = "Column Type" Then Return Null
	Dim ar() As Object = LOA.GetRow(6)
	Dim res As Map: res.initialize
	Dim h() As Object = LOA.header
	For j = 1 To ar.Length - 1
		Dim o() As Object = ar(j)
		Dim lbl As String = h(j)		
		res.Put(lbl, o(0))
	Next
	Return res
End Sub

#End Region

Private Sub processB4XModule(traceHelperOutput As List, module As String, projectFolder As String, special As String, LineExtras As Map) As Map
	tokens.clear
	Dim b4xSubs As Map: b4xSubs.initialize
	Dim lines As List = File.ReadList(projectFolder, module)
	module = module.SubString2(0, module.LastIndexOf("."))
	Dim lineCount As Int = -1
	Dim currentSub As String
	For i = 0 To lines.Size - 1
		Dim s As String = lines.Get(i)
		Dim saves As String = s
		s = s.toLowerCase.trim
		Dim k As Int = s.IndexOf("'")
		If k > - 1 Then s = s.SubString2(0, k)
		Dim k As Int = s.IndexOf(QUOTE)
		If k > - 1 Then s = s.SubString2(0, k)
		If s.contains("@endofdesigntext@") Then lineCount = -1
		lineCount = lineCount + 1
		If s.Contains(" sub ") Or s.StartsWith("sub ") Then 
			currentSub = s
		End If
		
		If special.Length > 0  And s.Length > 0 Then
			Dim v() As String = Regex.Split("\,", special)
			For Each qq As String In v
				qq = qq.toLowerCase
				Dim kkk As Int = s.indexOf(qq)
				If kkk > -1 Then LineExtras.Put(lineCount, saves.SubString(kkk + qq.length + 1).trim)
			Next
		End If
		
		If s = "end sub" Then 
			Dim k1 As Int = currentSub.IndexOf(" sub ") + 5
			Dim k2 As Int = currentSub.IndexOf2("(", k1)
			If k2 = -1 Then k2 = currentSub.IndexOf2(" ", k1)
			If k2 = -1 Then k2 = currentSub.length
			currentSub = currentSub.SubString2(k1, k2).trim
			b4xSubs.Put(currentSub, lineCount)
		End If
	Next
	Return b4xSubs
End Sub

Private Sub processJavaModule(b4xSubs As Map, traceHelperOutput As List, module As String, _
		path As String, LineExtras As Map)
	traceHelper.initialize
	Dim output As List = traceHelperOutput
	Dim javaFile As String = module.toLowerCase & ".java"
	If File.Exists(path, javaFile) Then 
		Dim javalines As List = File.ReadList(path, javaFile)
		Dim details(javalines.size) As Object
		Dim lastSubname As String
		Dim lastRef As Int
		For i = 0 To javalines.Size - 1
			Dim s As String = javalines.Get(i)
			If s.StartsWith(" //BA.") Then 
				Dim refNum As Int = s.substring2(s.IndexOf("=") + 1, s.IndexOf(";"))
				If s.Contains("Sub ") Then 
					lastSubname = s.SubString(s.IndexOf("Sub ") + 4).trim
					Dim kx As Int = lastSubname.IndexOf("(")
					If kx = -1 Then kx = lastSubname.IndexOf(" ")
					If kx = -1 Then kx = lastSubname.IndexOf(QUOTE)
					lastSubname = lastSubname.SubString2(0, kx).trim
				End If
				If s.Contains("End Sub") Then refNum = -refNum
				details(i) = Array(refNum, lastSubname)
				lastRef = refNum
			Else if s.tolowercase.startsWith("resumablesub") Then
				Dim k As Int = s.IndexOf("Sub_") + 4
				Dim subname As String = s.SubString(k)
				Dim kx As Int = subname.IndexOf("(")
				If kx = -1 Then kx = subname.IndexOf(" ")
				If kx = -1 Then kx = subname.IndexOf(QUOTE)
				details(i) = Array(-1, subname)
				lastSubname = subname
				lastRef = -1
			Else
				details(i) = Array(lastRef, lastSubname)
			End If
		Next
		
		Dim currentEnd As Int = -2
		For i = details.Length - 1 To 0 Step - 1
			Dim ar() As Object = details(i)
			Dim refNum As Int = ar(0)
			Dim method As String = ar(1)
			If refNum < 0 Then 
				currentEnd = -refNum
				refNum = 0
			Else
				refNum = currentEnd - refNum
			End If
			If method.Length = 0 Then refNum = -1
			details(i) = Array(refNum, method)
		Next
	
		For i = 0 To details.Length - 1
			Dim ar() As Object = details(i)
			Dim method As String = ar(1)
			Dim lineNum As Int = -1
			If method.Length > 0 Then
				Dim lineCnt As Int = b4xSubs.GetDefault(method.toLowerCase, -1)
				If lineCnt > - 1 Then 
					Dim refNum As Int = ar(0)
					Dim lineNum As Int = lineCnt - refNum
					If LineExtras.ContainsKey(lineNum) Then 
						output.Add(i & TAB & method & TAB & lineNum & TAB & LineExtras.Get(lineNum))
					Else	
						output.Add(i & TAB & method & TAB & lineNum)
					End If
				Else
					output.Add(i & TAB & method & TAB & (-1))
				End If
			Else
				output.Add(i & TAB & method & TAB & (-1))
			End If
		Next
		output.Add(javalines.Size & TAB & "_" & TAB & 0)
	End If
End Sub

Private Sub PrepareSourceLineNumbers(special As String)
#if B4j
	'Index start / end of all subs in all modules in parent - not modules in libraries
	Dim mainModule As String = File.DirApp
	mainModule = mainModule.SubString2(0, mainModule.lastIndexOf("\"))
	Dim sourceFiles As List: sourceFiles.Initialize
	Dim tempfiles As List = File.ListFiles(mainModule)
	For Each s As String In tempfiles
		If s.Contains(".bas") Or (s.Contains(".b4j") And Not(s.Contains(".meta"))) Then sourceFiles.Add(Array(mainModule, s))
	Next
	Dim parent As String = mainModule.SubString2(0, mainModule.lastIndexOf("\"))
	Dim tempfiles As List = File.ListFiles(parent)
	Dim isPages As Boolean
	For Each s As String In tempfiles
		If File.IsDirectory(parent, s) Then 
			If s = "B4J" Then isPages = True
		End If
	Next
	If isPages Then 
		For Each s As String In tempfiles
			If s.Contains(".bas") Then sourceFiles.Add(Array(parent, s))
		Next
	End If

	Dim allModules As Map: allModules.initialize

	Dim projName As String = GetPackageName
	Dim path As String = File.DirApp & "\src\" & projName.Replace(".", "\")

	Dim traceHelperOutput As List: traceHelperOutput.Initialize
	For Each ar() As Object In sourceFiles
		Dim b4xSubs As Map: b4xSubs.initialize
		Dim folder As String = ar(0)
		Dim module As String = ar(1)
		Dim LineExtras As Map: LineExtras.initialize
		Dim b4xSubs As Map = processB4XModule(traceHelperOutput, module, folder, special, LineExtras)
		If module.EndsWith(".b4j") Then 
			module = "Main"
		Else
			module = module.SubString2(0, module.LastIndexOf("."))
		End If
		traceHelperOutput.Add("*" & module)
		processJavaModule(b4xSubs, traceHelperOutput, module, path, LineExtras)
	Next
	
	traceHelper.initialize
	Dim lastRef As String
	Dim lastMethod As String
	For i = 0 To traceHelperOutput.Size - 1
		Dim s As String = traceHelperOutput.Get(i)
		If s.StartsWith("*") Then 
			traceHelper.add(s)
			lastRef = ""
			lastMethod = ""
		Else
			Dim v() As String = Regex.Split(TAB, s)
			If v(1) <> "-1" And v(2) <> "-1" Then 
				If v(2) <> lastRef Then
					If v(1) = lastMethod Then s = s.Replace(v(1), QUOTE)
					lastMethod = v(1)
					traceHelper.add(s)
				End If
				lastRef = v(2)
			End If
		End If
	Next
	
	File.WriteList(File.DirApp, "traceHelper.txt", traceHelper)
'
'______________________________________	
'	Dim traceHelper As List = File.ReadList(File.DirApp, "traceHelper.txt")
	javamap.initialize
	Dim currentModule As String
	Dim currentMethod As String = "?"
	Dim lst As List: lst.initialize
	For Each s As String In traceHelper
		If s.StartsWith("*") Then 
			If lst.Size > 0 Then 
				javamap.Put(currentModule.toLowerCase, lst)
			End If
			currentModule = s.SubString(1)
			Dim currentMethod As String
			Dim currentLine As Int = -1
			Dim lst As List: lst.initialize
		Else
			Dim v() As String = Regex.Split(TAB, s)
			Dim thisLine As Int = v(0)
			If v(1) = "_" Then 
				For j = currentLine + 1 To thisLine - 1
					lst.Add(j & TAB & "?" & TAB & 0)
				Next
			End If
			If v(1) = QUOTE Then 
				s = s.Replace(QUOTE, currentMethod)
			Else
				currentMethod = v(1)
			End If
			
			If thisLine > currentLine + 1 Then
				For j = currentLine + 1 To thisLine - 1
					If currentLine = -1 Then 
						lst.Add(j & TAB & "?" & TAB & 0)
					Else
						lst.Add(j & TAB & s.SubString(s.IndexOf(TAB) + 1))
					End If
				Next
				lst.Add(s)
				currentLine = thisLine
			End If
		End If
	Next
	If lst.Size > 0 Then 
		javamap.Put(currentModule.toLowerCase, lst)
	End If
#End IF
End Sub


#if TODO
	Breakdown using grouping function
	Reshape and transpose?  Actually not that simple since columns have names!
	
	THESE will require interfacing with Python - so only for B4J
	Inverse? Use Python to ensure accuracy and validity
	Linear regression? examples from AI (other AI functions, interfacing with Python)
	
	Graphs?  'Uses UI, use existing Libraries, or create a new one? My favourites: Histo, Error, Scatter, Line, Time
			Least favourites: Bar, Piechart, Animated 
	
	Grid?  'Uses UI, use wGrid?
#End If

Public Sub NewSortPair (number As Double, obj As Object) As sortPair
	Dim t1 As sortPair
	t1.Initialize
	t1.number = number
	t1.obj = obj
	Return t1
End Sub