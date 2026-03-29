B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.5
@EndOfDesignText@
#Region Helpers
Sub Process_Globals
	Dim weekdays() As String = Array As String("", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
	Dim monthnames() As String = Array As String("", "January", "February", "March", "April", "May", "June", _
							"July", "August", "September", "October", "November", "December")
End Sub

Private Sub register(mp As Map, dat As String)
	If mp.ContainsKey(dat) Then
		mp.Put(dat, 1 + mp.Get(dat))
	Else
		mp.Put(dat, 1)
	End If
End Sub

Private Sub isArray(obj As Object) As Boolean
	If obj = Null Then Return False
	Return GetType(obj).StartsWith("[")
End Sub

Private Sub ArgToArray(arg As Object) As Object()
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

Private Sub generic(f As String, LOA As ListOfArrays, arg As Object, extra() As Object) As ListOfArrays
	Dim colArr() As Object = ArgToArray(arg)
	If colArr.Length = 0 Then colArr = LOA.Header
	Dim nrows As Int = LOA.mInternalArray.Size - 1
	Dim nCols As Int = colArr.Length
	Dim h(nCols) As Object
	Dim LOAh() As Object = LOA.header
	Dim newLOA As ListOfArrays
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
			newLOA = LOAUtils.CreateEmpty(Array(h(j)))
			For i = 0 To nrows - 1
				newLOA.addRow(Array(rlst.Get(i)))
			Next
		Else
			newLOA.AddColumn(h(j), rlst)
		End If
	Next
	Return newLOA
End Sub
#end region

'Comment
Public Sub contains(LOA As ListOfArrays, arg As Object, Str As String, caseSens As Boolean) As ListOfArrays
	Dim params() As Object = Array(Str, caseSens)
	Return generic("contains_X", LOA , arg, params)
End Sub

Private Sub contains_X(lst As List, params() As Object) As List	
	Dim Str As String = params(0)
	Dim caseSens As Boolean= params(1)
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is String) Then 
			If caseSens Then 
				rlst.Add(obj.As(String).Contains(Str))
			Else
				rlst.Add(obj.As(String).toLowerCase.Contains(Str.toLowerCase))
			End If
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst
End Sub

'Comment
Public Sub substring(LOA As ListOfArrays, arg As Object, StartAt As Int, EndAtP1 As Int) As ListOfArrays
	Dim params() As Object = Array(StartAt, EndAtP1)
	Return generic("substring_X", LOA , arg, params)
End Sub

Private Sub substring_X(lst As List, params() As Object) As List	
	Dim StartAT As Int = params(0)
	Dim EndAtP1 As Int = params(1)
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is String) Then 
			Dim s As String = obj
			If StartAT < s.Length Then 
				Dim n As Int = EndAtP1
				If n = -1 Then n = s.length
				rlst.Add(s.SubString2(StartAT, n))
			Else
				rlst.Add(s)
			End If
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst
End Sub

'Comment
Public Sub indexOf(LOA As ListOfArrays, arg As Object, Str As String, caseSens As Boolean) As ListOfArrays
	Return indexOf2(LOA, arg, Str, caseSens, -1)
End Sub

'Comment
Public Sub indexOf2(LOA As ListOfArrays, arg As Object, Str As String, caseSens As Boolean, StartAt As Int) As ListOfArrays
	Dim params() As Object = Array(Str, caseSens, StartAt)
	Return generic("indexOf2_X", LOA , arg, params)
End Sub 

Private Sub indexOf2_X(lst As List, params() As Object) As List	
	Dim Str As String = params(0)
	Dim caseSens As Boolean= params(1)
	Dim n As Int = params(2)
	If n < 0 Then n = 0
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is String) Then 
			Dim s As String = obj
			If caseSens Then 
				rlst.Add(s.IndexOf2(Str, n))
			Else
				rlst.Add(s.toLowerCase.IndexOf2(Str.toLowerCase, n))
			End If
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst
End Sub

'Comment
Public Sub lastIndexOf(LOA As ListOfArrays, arg As Object, Str As String, caseSens As Boolean) As ListOfArrays
	Return lastIndexOf2(LOA, arg, Str, caseSens, -1)
End Sub

'Comment
Public Sub lastIndexOf2(LOA As ListOfArrays, arg As Object, Str As String, caseSens As Boolean, StartAt As Int) As ListOfArrays
	Dim params() As Object = Array(Str, caseSens, StartAt)
	Return generic("lastIndexOf2_X", LOA , arg, params)
End Sub

Private Sub lastIndexOf2_X(lst As List, params() As Object) As List
	Dim Str As String = params(0)
	Dim caseSens As Boolean= params(1)
	Dim StartAt As Int = params(2)
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is String) Then 
			Dim s As String = obj
			Dim n As Int = StartAt
			If n < 0 Then n = s.Length - 1
			If caseSens Then 
				rlst.Add(s.LastIndexOf2(Str, n))
			Else
				rlst.Add(s.toLowerCase.LastIndexOf2(Str.toLowerCase, n))
			End If
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst
End Sub 

'Comment
Public Sub replace(LOA As ListOfArrays, arg As Object, Str As String, replaceMent As String, caseSens As Boolean) As ListOfArrays
	Dim params() As Object = Array(Str, replaceMent, caseSens)
	Return generic("replace_X", LOA , arg, params)
End Sub

Private Sub replace_X(lst As List, params() As Object) As List
	Dim Str As String = params(0)
	Dim replaceMent As String = params(1)
	Dim caseSens As Boolean= params(2)
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is String) Then 
			Dim s As String = obj
			If caseSens Then 
				rlst.Add(s.replace(Str, replaceMent))
			Else
				rlst.Add(s.toLowerCase.replace(Str.toLowerCase, replaceMent))
			End If
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst
End Sub 

'Comment
Public Sub toLowerCase(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("LC_X", LOA , arg, Array())
End Sub

Private Sub LC_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is String) Then 
			Dim s As String = obj
			rlst.Add(s.toLowerCase)
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst
End Sub

'Comment
Public Sub toUpperCase(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("UC_X", LOA , arg, Array())
End Sub

Private Sub UC_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is String) Then 
			Dim s As String = obj
			rlst.Add(s.toUpperCase)
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst
End Sub

'Comment
Public Sub toDate(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("toDate_X", LOA , arg, Array(0))
End Sub

Private Sub toDate_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is String) Then rlst.Add(DateTime.DateParse(obj)) Else rlst.Add(Null)
	Next
	Return rlst	
End Sub

'Comment
Public Sub asDate(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("asDate_X", LOA , arg, Array())
End Sub

Private Sub asDate_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is Long) Then rlst.Add(DateTime.Date(obj)) Else rlst.Add(Null)
	Next
	Return rlst	
End Sub

'Comment
Public Sub toTime(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("toTime_X", LOA , arg, Array())
End Sub

Private Sub toTime_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is String) Then rlst.Add(DateTime.TimeParse(obj)) Else rlst.Add(Null)
	Next
	Return rlst	
End Sub

'Comment
Public Sub asTime(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("asTime_X", LOA , arg, Array())
End Sub

Private Sub asTime_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is Long) Then rlst.Add(DateTime.Time(obj)) Else rlst.Add(Null)
	Next
	Return rlst	
End Sub

'Comment
Public Sub toDateTime(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("toDateTime_X", LOA , arg, Array())
End Sub

Private Sub toDateTime_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		Dim v() As String = Regex.Split("T", obj)
		If Not(obj = Null) And (obj Is String) Then rlst.Add(DateTime.DateTimeParse(v(0), v(1))) Else rlst.Add(Null)
	Next
	Return rlst	
End Sub

'Comment
Public Sub asDateTime(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("asDateTime_X", LOA , arg, Array())
End Sub

Private Sub asDateTime_X(lst As List, extra() As Object) As List	'ignore
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is Long) Then rlst.Add(DateTime.Date(obj) & "T" & DateTime.Time(obj)) Else rlst.Add(Null)
	Next
	Return rlst	
End Sub

'Comment
Public Sub dayOfYear(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("dayOfYear"))
End Sub

'Comment
Public Sub dayOfMonth(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("dayOfMonth"))
End Sub

'Comment
Public Sub dayOfWeek(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("dayOfWeek"))
End Sub

'Comment
Public Sub weekday(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("weekday"))
End Sub

'Comment
Public Sub weekday3lets(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("weekday3lets"))
End Sub

'Comment
Public Sub weekday3caps(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("weekday3lets"))
End Sub

'Comment
Public Sub quarter(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("quarter"))
End Sub

'Comment
Public Sub week(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("week"))
End Sub

'Comment
Public Sub year(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("year"))
End Sub

'Comment
Public Sub month(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("week"))
End Sub

'Comment
Public Sub monthname(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("monthname"))
End Sub

'Comment
Public Sub month3lets(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("month3lets"))
End Sub

'Comment
Public Sub month3caps(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("month3caps"))
End Sub

'Comment
Public Sub hour(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("hour"))
End Sub

'Comment
Public Sub minute(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("minute"))
End Sub

'Comment
Public Sub second(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Return generic("dateTime_X", LOA , arg, Array("second"))
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

'Comment
Public Sub addPeriod(LOA As ListOfArrays, arg As Object, params() As Object) As ListOfArrays
	Return generic("addPeriod", LOA , arg, params)
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

'Comment
Public Sub monthdays(LOA As ListOfArrays, arg As Object, yr As Int, mnth As Int) As ListOfArrays
	Return generic("monthdays", LOA , arg, Array(yr, mnth))
End Sub

Private Sub monthdays_X(lst As List, extra() As Object) As List	'ignore
	Dim yr As Int = extra(0)
	Dim mnth As Int = extra(1)
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is Long) Then 
			rlst.Add(DateUtils.NumberOfDaysInMonth(yr, mnth)) 
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst	
End Sub

'Comment
Public Sub daysBetween(LOA As ListOfArrays, arg As Object, endDate As Object) As ListOfArrays
	Return generic("daysBetween", LOA , arg, Array(endDate))
End Sub

Private Sub daysBetween_X(lst As List, extra() As Object) As List	'ignore
	Dim endDate As Object = extra(0)
	If endDate Is String Then 
		Dim d As Long = DateTime.DateParse(endDate)
	Else
		Dim d As Long = endDate
	End If
	Dim rlst As List = emptyLst
	For Each obj As Object In lst
		If Not(obj = Null) And (obj Is Long) Then 
			rlst.Add(DateUtils.PeriodBetweenInDays(obj, d).Days) 
		Else 
			rlst.Add(Null)
		End If
	Next
	Return rlst	
End Sub

'Comment
Public Sub dateAndTime(LOA As ListOfArrays, arg As Object, extra() As Object) As ListOfArrays
	Return generic("dateAndTime", LOA , arg, extra)
End Sub

Private Sub dateAndTime_X(lst As List, extra() As Object) As List	'ignore
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

'Comment
Public Sub recode(LOA As ListOfArrays, arg As Object, mp As Map) As ListOfArrays
	Dim colArr() As Object = ArgToArray(arg)
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
	Dim newLOA As ListOfArrays = LOAUtils.CreateEmpty(newNames)
	For i = 0 To nrows - 1
		Dim r() As Object = LOA.GetRow(i)
		Dim newr(newCols) As Object
		For j = 0 To newCols - 1
			Dim nam As String = colArr(j)
			Dim index As Int = LOA.ColumnIndexToOrdinal(nam)
			Dim origObj As Object = r(index)
			newr(j) = mp.GetDefault(origObj, origObj)
		Next
		newLOA.AddRow(newr)
	Next
	Return newLOA
End Sub

'Comment
Public Sub standardize(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Dim colArr() As Object = ArgToArray(arg)
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
	Dim newLOA As ListOfArrays = LOAUtils.CreateEmpty(newNames)
	For i = 0 To nrows - 1
		Dim r() As Object = LOA.GetRow(i)
		Dim newr(newCols) As Object
		For j = 0 To newCols - 1
			Dim nam As String = colArr(j)
			Dim index As Int = LOA.ColumnIndexToOrdinal(nam)
			Dim origObj As Object = r(index)
			newr(j) = origObj
		Next
		newLOA.AddRow(newr)
	Next
	For j = 0 To newCols - 1
		Dim lst As List = newLOA.GetColumn(j)
		Dim sum As Double
		Dim nsum As Double
		For i = 0 To nrows - 1
			Dim obj As Object = newLOA.GetValue(i, j)
			If Not(obj = Null) And IsNumber(obj) Then
				sum = sum + obj.As(Double)
				nsum = nsum + 1				
			End If
		Next
		If nsum > 1 Then 
			Dim meanx As Double = sum / nsum
			Dim sumx As Double
			Dim numx As Double
			For i = 0 To nrows - 1
				Dim obj As Object = newLOA.GetValue(i, j)
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
		For i = 0 To nrows - 1
			Dim obj As Object = newLOA.GetValue(i, j)
			If Not(obj = Null) And IsNumber(obj) Then
				Dim d As Double = obj
				lst.Set(i, (d - meanx) / stdevx)
			Else
				lst.Set(i, Null)
			End If
		Next
		newLOA.SetColumn(j, lst)
	Next
	Return newLOA
End Sub

'Comment
Public Sub normalize(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Dim colArr() As Object = ArgToArray(arg)
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
	Dim newLOA As ListOfArrays = LOAUtils.CreateEmpty(newNames)
	For i = 0 To nrows - 1
		Dim r() As Object = LOA.GetRow(i)
		Dim newr(newCols) As Object
		For j = 0 To newCols - 1
			Dim nam As String = colArr(j)
			Dim index As Int = LOA.ColumnIndexToOrdinal(nam)
			Dim origObj As Object = r(index)
			newr(j) = origObj
		Next
		newLOA.AddRow(newr)
	Next
	For j = 0 To newCols - 1
		Dim lst As List = newLOA.GetColumn(j)
		Dim minvalue As Double = 1 / 0
		Dim maxvalue As Double = -1 / 0
		
		For i = 0 To nrows - 1
			Dim obj As Object = newLOA.GetValue(i, j)
			If Not(obj = Null) And IsNumber(obj) Then
				Dim d As Double = obj
				If d < minvalue Then minvalue = d
				If d > maxvalue Then maxvalue = d
			End If
		Next
		For i = 0 To nrows - 1
			Dim obj As Object = newLOA.GetValue(i, j)
			If Not(obj = Null) And IsNumber(obj) Then
				Dim d As Double = obj
				lst.Set(i, (d - minvalue) / (maxvalue - minvalue))
			Else
				lst.Set(i, Null)
			End If
		Next
		newLOA.SetColumn(j, lst)
	Next
	Return newLOA
End Sub

'Comment
Public Sub one_hot(LOA As ListOfArrays, arg As Object) As ListOfArrays
	Dim colArr() As Object = ArgToArray(arg)
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
			Dim newLOA As ListOfArrays = LOAUtils.CreateEmpty(h)

			For i = 0 To nrows - 1
				Dim obj As Object = lst.Get(i)
				Dim newCat As Int = mp.Get(obj.As(String))
				Dim r(mp.Size) As Object
				For m = 0 To mp.Size - 1
					r(m) = 0
					If m = newCat Then r(m) = 1
				Next
				newLOA.AddRow(r)
			Next
		End If
		LOAAll.Merge(newLOA)
	Next
	LOAAll.RemoveColumn(0)
	Return LOAAll
End Sub

'Comment
Public Sub info(LOA As ListOfArrays, arg As Object) As ListOfArrays
	wLOAUtils.unusualVals = emptyLst
	Dim colArr() As Object = ArgToArray(arg)
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

	Dim newLOA As ListOfArrays = LOAUtils.CreateEmpty(newNames)
	
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
			wLOAUtils.unusualVals = Invalids
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
			nValid = nItems
			nInvalid = -1
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
	
	Dim rlabels() As String = Array As String("Column Type", "Num Rows", "Num Missing", "Num Unusual", "Num Valid", "Minimum", "Maximum", "Decimals", "String Length")
	For k = 0 To kInfo - 1
		Dim r(newCols + 1) As Object
		r(0) = rlabels(k)
		For j = 0 To newCols- 1
			r(j + 1) = infoData(j, k)
		Next
		newLOA.AddRow(r)
	Next
	Return newLOA
End Sub

#if TODO
-Stats any combination of columns or all (mean, mode, stddev, Unique Values, Most Frequent, median, percentiles)
-Error reporting with trace or fire exception
-Col Index not found is most common
#End If
