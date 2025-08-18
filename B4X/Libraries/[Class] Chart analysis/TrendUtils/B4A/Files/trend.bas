B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
'v.0.26 (c) Vlad Pomelov aka Peacemaker
'Class for trend\chart analysis
Private Sub Class_Globals
	Private dbName As String
	Private const dbTable As String = "trend_table"
	Private mSQL As SQL
	Private mInitialized As Boolean
	Private OverallAVG As Double    'average Y-value of the whole period
	'type has fields for parameters of the analyzed data range, including "stableZZ" where ZZ = percent
	Type TrendResult (MinX As String, MaxX As String, MinY As String, MaxY As String, AvgX As String, AvgY As Double, rising As Boolean, falling As Boolean, wobbling As Boolean, hasMaxY As Boolean, hasMinY As Boolean, stable As Boolean, stableWithin As Float)
	
	Public NameYaxis As String = "Temperature"	'edit in your code
	Public UnitsYaxis As String = "°C"	'edit in your code
	Public NameXaxis As String = "Time"	'edit in your code
	Public UnitsXaxis As String = "hours"	'edit in your code
	
	Public Const DESC_TERM_ISRISING As String = "is rising"
	Public Const DESC_TERM_ISFALLING As String = "is falling"
	Public Const DESC_TERM_ISWOBBLING As String = "is wobbling"
	Public Const DESC_TERM_HADMAX As String = "had a maximum"
	Public Const DESC_TERM_HADMIN As String = "had a minimum"
	Public Const DESC_TERM_ISSTABLE As String = "is stable"
	Public Const DESC_TERM_UPTO As String = "up to"
	Public Const DESC_TERM_WITHIN As String = "within"
	Public Const DESC_TERM_AT As String = "at"
	Public Const DESC_TERM_AROUND As String = "around"
End Sub

'The object must be initialized first.
Public Sub Initialize
	If dbName <> "" And mSQL.IsInitialized Then
		Close
	End If
	Dim dbName As String = "trend_db_" & DateTime.Now & ".sqlite"
	File.Delete(Folder, dbName)	'deleted old database for clean test
	If mSQL.IsInitialized = False Then
		#if B4J
		mSQL.InitializeSQLite(Folder, dbName, True)
		#else if B4A
		mSQL.Initialize(Folder, dbName, True)
		#end if
	End If
	
	Dim ft As Map
	ft.Initialize
	ft.Put("id", DBUtils.DB_INTEGER)
	ft.Put("x", DBUtils.DB_TEXT)
	ft.Put("y", DBUtils.DB_REAL)
	DBUtils.CreateTable(mSQL, dbTable, ft, "id")
	mInitialized = True
End Sub

'Set the data set period: map key = X abscissa, map value = Y ordinate value
'Example:
'Dim SourceMap As Map = CreateMap("Temperature 10:00":10, "Temperature 10:10":13, "Temperature 10:20":16, "Temperature 10:30":19, "Temperature 14:00":30)
Public Sub DataMapToTrend(SourceMap As Map)
	DBUtils.ClearTable(mSQL, dbTable)
	Dim L As List:L.Initialize
	For i = 0 To SourceMap.Size - 1
		Dim ft As Map
		ft.Initialize
		ft.Put("x", SourceMap.GetKeyAt(i))
		ft.Put("y", SourceMap.GetValueAt(i))
		L.Add(ft)
	Next	
	DBUtils.InsertMaps(mSQL, dbTable, L)
	OverallAVG = mSQL.ExecQuerySingleResult("SELECT AVG(y) FROM " & dbTable)
End Sub

Public Sub AverageY As Double
	Return OverallAVG
End Sub

'Checks if the chart is of rising character
'StartPercent, StopPercent: range of data, all data are when StartPercent = 0%, StartPercent = 100%
Public Sub isRisingY (StartPercent As Int, StopPercent As Int) As TrendResult
	Dim count As Int = DBUtils.GetIntFromSQL(mSQL, dbTable, "SELECT count(*) FROM " & dbTable)	'data qty
	Dim StartPercent2 As Int = StartPercent * count / 100
	Dim StopPercent2 As Int = StopPercent * count / 100
	Dim Range As Int = StopPercent2 - StartPercent2
	If Range <= 0 Then 
		'Log("isRisingY.Error: StartPercent must be smaller than StopPercent")
		StopPercent2 = StartPercent2 + 1
	End If
	Private SubIntervals_qty As Int = Calc_SubIntervals(StartPercent2, StopPercent2) 'the source period is divided into this number parts [ i] (iterable) to compare them
	
	Dim Interval As Int = Floor(Range / SubIntervals_qty) + 1	'qty of analysing subintervals of the whole data set
	Dim operations As List
	operations.Initialize
	For i = StartPercent2 To StopPercent2 - Interval Step Interval
		Dim upto As Int = i + Interval
		Dim req As String = "SELECT AVG(y) FROM " & dbTable & " WHERE id >= " & i & " AND id <= " & upto
		'Log(req)
		Dim avg As Double = mSQL.ExecQuerySingleResult(req)
		operations.Add(avg)
	Next
	
	Dim oper_qty As Int
	For i = 0 To operations.Size - 2
		Dim prev As Double = operations.Get(i)
		Dim nex As Double = operations.Get(i+1)
		If nex >= prev Then
			oper_qty = oper_qty + 1
		Else
			oper_qty = oper_qty - 1
		End If
	Next
	Private result As TrendResult
	result.Initialize
	If oper_qty >= operations.Size / 2 Then
		result.rising = True
	Else
		result.rising = False
	End If
	result.MaxY = MaxY(StartPercent, StopPercent)
	result.MaxX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id <= " & StopPercent2 & " ORDER BY id DESC LIMIT 1")
	result.MinY = MinY(StartPercent, StopPercent)
	Sleepp(0)
	result.MinX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id >= " & StartPercent2 & " ORDER BY id ASC LIMIT 1")
	Dim AvgID As Int = (StopPercent2 + StartPercent2)/2
	result.avgX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id >= " & AvgID & " ORDER BY id ASC LIMIT 1")
	result.avgY = AvgY(StartPercent, StopPercent)
	Return result
End Sub

'Checks if the chart is of falling character
'StartPercent, StopPercent: range of data, all data are when StartPercent = 0%, StartPercent = 100%
Public Sub isFallingY (StartPercent As Int, StopPercent As Int) As TrendResult
	Dim count As Int = DBUtils.GetIntFromSQL(mSQL, dbTable, "SELECT count(*) FROM " & dbTable)	'data qty
	Dim StartPercent2 As Int = StartPercent * count / 100
	Dim StopPercent2 As Int = StopPercent * count / 100
	Dim Range As Int = StopPercent2 - StartPercent2
	If Range <= 0 Then 
		'Log("isFallingY.Error: StartPercent must be smaller than StopPercent")
		StopPercent2 = StartPercent2 + 1
	End If
	Private SubIntervals_qty As Int = Calc_SubIntervals(StartPercent2, StopPercent2) 'the source period is divided into this number parts [ i] (iterable) to compare them
	Dim Interval As Int = Floor(Range / SubIntervals_qty) + 1	'qty of analysing subintervals of the whole data set
	Dim operations As List
	operations.Initialize
	For i = StartPercent2 To StopPercent2 - Interval Step Interval
		Dim upto As Int = i + Interval
		Dim req As String = "SELECT AVG(y) FROM " & dbTable & " WHERE id >= " & i & " AND id <= " & upto
		'Log(req)
		Dim avg As Double = mSQL.ExecQuerySingleResult( req)
		operations.Add(avg)
	Next
	Dim oper_qty As Int
	For i = 0 To operations.Size - 2
		Dim prev As Double = operations.Get(i)
		Dim nex As Double = operations.Get(i+1)
		If nex <= prev Then
			oper_qty = oper_qty + 1
		Else
			oper_qty = oper_qty - 1
		End If
	Next
	Private result As TrendResult
	result.Initialize
	If oper_qty >= operations.Size / 2 Then
		result.falling = True
	Else
		result.falling = False
	End If

	result.MaxY = MaxY(StartPercent, StopPercent)
	result.MaxX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id <= " & StopPercent2 & " ORDER BY id DESC LIMIT 1")
	result.MinY = MinY(StartPercent, StopPercent)
	Sleepp(0)
	result.MinX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id >= " & StartPercent2 & " ORDER BY id ASC LIMIT 1")
	Dim AvgID As Int = (StopPercent2 + StartPercent2)/2
	result.avgX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id >= " & AvgID & " ORDER BY id ASC LIMIT 1")
	result.avgY = AvgY(StartPercent, StopPercent)
	Return result
End Sub

'Checks if the chart is wobbling character.
'StartPercent, StopPercent: range of data, all data are when StartPercent = 0%, StartPercent = 100%
Public Sub isWobblingY (StartPercent As Int, StopPercent As Int) As TrendResult
	Dim count As Int = DBUtils.GetIntFromSQL(mSQL, dbTable, "SELECT count(*) FROM " & dbTable)	'data qty
	Dim StartPercent2 As Int = StartPercent * count / 100
	Dim StopPercent2 As Int = StopPercent * count / 100
	Dim Range As Int = StopPercent2 - StartPercent2
	If Range <= 0 Then 
		'Log("isWobblingY.Error: StartPercent must be smaller than StopPercent")
		StopPercent2 = StartPercent2 + 1
	End If
	Private SubIntervals_qty As Int = Calc_SubIntervals(StartPercent2, StopPercent2) 'the source period is divided into this number parts [ i] (iterable) to compare them
	Dim Interval As Int = Floor(Range / SubIntervals_qty) + 1	'qty of analysing subintervals of the whole data set
	Dim operations As List
	operations.Initialize
	For i = StartPercent2 To StopPercent2 - Interval Step Interval
		Dim upto As Int = i + Interval
		Dim req As String = "SELECT AVG(y) FROM " & dbTable & " WHERE id >= " & i & " AND id <= " & upto
		'Log(req)
		Dim avg As Double = mSQL.ExecQuerySingleResult( req)
		operations.Add(avg)
	Next
	Dim avg As Double = AvgY(StartPercent, StopPercent)
	Dim oper_qty As Int

	For i = 0 To operations.Size - 2
		Dim prev As Double = operations.Get(i)
		Dim nex As Double = operations.Get(i+1)
		If nex >= prev Then
			oper_qty = oper_qty + 1
		Else
			oper_qty = oper_qty - 1
		End If
	Next
	Private result As TrendResult
	result.Initialize
	If oper_qty > 1 And oper_qty <= operations.Size / 2 Then
		result.wobbling = True
	Else
		result.wobbling = False
	End If
'	Log("oper_qty = " & oper_qty)
	result.MaxY = MaxY(StartPercent, StopPercent)
	result.MaxX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id <= " & StopPercent2 & " ORDER BY id DESC LIMIT 1")
	result.MinY = MinY(StartPercent, StopPercent)
	Sleepp(0)
	result.MinX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id >= " & StartPercent2 & " ORDER BY id ASC LIMIT 1")
	Dim AvgID As Int = (StopPercent2 + StartPercent2)/2
	result.avgX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id >= " & AvgID & " ORDER BY id ASC LIMIT 1")
	result.avgY = avg
	Return result
End Sub

'Checks if the chart has a maxumum
'StartPercent, StopPercent: range of data, all data are when StartPercent = 0%, StartPercent = 100%
Public Sub hasMaximum (StartPercent As Int, StopPercent As Int) As TrendResult
	Dim count As Int = DBUtils.GetIntFromSQL(mSQL, dbTable, "SELECT count(*) FROM " & dbTable)	'data qty
	Dim StartPercent2 As Int = StartPercent * count / 100
	Dim StopPercent2 As Int = StopPercent * count / 100
	Dim Range As Int = StopPercent2 - StartPercent2
	If Range <= 0 Then
		'Log("hasMaximum.Error: StartPercent must be smaller than StopPercent")
		StopPercent2 = StartPercent2 + 1
	End If

'	Private LeftRising As TrendResult = isRisingY(StartPercent, StartPercent + (StopPercent - StartPercent)/2)
'	Private RightFalling As TrendResult = isFallingY(StopPercent * 0.5, StopPercent)
	Private LeftRising As TrendResult = isRisingY(StartPercent, StartPercent + (StopPercent - StartPercent) * 0.7)
	Private RightFalling As TrendResult = isFallingY(StartPercent + (StopPercent - StartPercent) * 0.3, StopPercent)
	
	Private result As TrendResult
	result.Initialize
	result.MaxY = MaxY(StartPercent, StopPercent)
	result.MaxX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id <= " & StopPercent2 & " ORDER BY id DESC LIMIT 1")
	result.MinY = MinY(StartPercent, StopPercent)
	Sleepp(0)
	result.MinX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id >= " & StartPercent2 & " ORDER BY id ASC LIMIT 1")
	Dim AvgID As Int = (StopPercent2 + StartPercent2)/2
	result.avgX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id >= " & AvgID & " ORDER BY id ASC LIMIT 1")
	result.avgY = AvgY(StartPercent, StopPercent)
	
	If LeftRising.rising Or RightFalling.falling Then
		result.hasMaxY = True
	Else
		result.hasMaxY = False
	End If

	Return result
End Sub

'Checks if the chart has a minimum
'StartPercent, StopPercent: range of data, all data are when StartPercent = 0%, StartPercent = 100%
Public Sub hasMinimum (StartPercent As Int, StopPercent As Int) As TrendResult
	Dim count As Int = DBUtils.GetIntFromSQL(mSQL, dbTable, "SELECT count(*) FROM " & dbTable)	'data qty
	Dim StartPercent2 As Int = StartPercent * count / 100
	Dim StopPercent2 As Int = StopPercent * count / 100
	Dim Range As Int = StopPercent2 - StartPercent2
	If Range <= 0 Then
		'Log("hasMinimum.Error: StartPercent must be smaller than StopPercent")
		StopPercent2 = StartPercent2 + 1
	End If
'	Private LeftFalling As TrendResult = isFallingY(StartPercent, StartPercent + (StopPercent - StartPercent)/2)
'	Private RightRising As TrendResult = isRisingY(StopPercent * 0.5, StopPercent)
	Private LeftFalling As TrendResult = isFallingY(StartPercent, StartPercent + (StopPercent - StartPercent) * 0.7)
	Private RightRising As TrendResult = isRisingY(StartPercent + (StopPercent - StartPercent) * 0.3, StopPercent)
	
	Private result As TrendResult
	result.Initialize
	result.MaxY = MaxY(StartPercent, StopPercent)
	result.MaxX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id <= " & StopPercent2 & " ORDER BY id DESC LIMIT 1")
	result.MinY = MinY(StartPercent, StopPercent)
	Sleepp(0)
	result.MinX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id >= " & StartPercent2 & " ORDER BY id ASC LIMIT 1")
	Dim AvgID As Int = (StopPercent2 + StartPercent2)/2
	result.avgX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id >= " & AvgID & " ORDER BY id ASC LIMIT 1")
	result.avgY = AvgY(StartPercent, StopPercent)
		
	If LeftFalling.falling Or RightRising.rising Then
		result.hasMinY = True
	Else
		result.hasMinY = False
	End If
	Return result
End Sub

Private Sub Folder As String
	#if B4J
	Dim res As String = File.DirApp
	#else if B4A
	Dim res As String = DBUtils.GetDBFolder
	#end if
	Return res
End Sub

Public Sub IsInitialized As Boolean
	Return mInitialized
End Sub

Public Sub Close
	If mSQL.IsInitialized Then mSQL.Close
	File.Delete(Folder, dbName)
	mInitialized = False
End Sub

'Returns max of the range
'StartPercent, StopPercent: range of data, all data are when StartPercent = 0%, StartPercent = 100%
Public Sub MaxY (StartPercent As Int, StopPercent As Int) As String
	Dim count As Int = DBUtils.GetIntFromSQL(mSQL, dbTable, "SELECT count(*) FROM " & dbTable)	'data qty
	Dim StartPercent2 As Int = StartPercent * count / 100
	Dim StopPercent2 As Int = StopPercent * count / 100
	Dim Range As Int = StopPercent2 - StartPercent2
	If Range <= 0 Then 
		'Log("MaxY.Error: StartPercent must be smaller than StopPercent")
		StopPercent2 = StartPercent2 + 1
	End If

	Dim MaxValue As String = mSQL.ExecQuerySingleResult("SELECT MAX(y) FROM " & dbTable & " WHERE id >= " & StartPercent2 & " AND id <= " & StopPercent2)
	Return MaxValue
End Sub

'Returns min of the range
'StartPercent, StopPercent: range of data, all data are when StartPercent = 0%, StartPercent = 100%
Public Sub MinY (StartPercent As Int, StopPercent As Int) As String
	Dim count As Int = DBUtils.GetIntFromSQL(mSQL, dbTable, "SELECT count(*) FROM " & dbTable)	'data qty
	Dim StartPercent2 As Int = StartPercent * count / 100
	Dim StopPercent2 As Int = StopPercent * count / 100
	Dim Range As Int = StopPercent2 - StartPercent2
	If Range <= 0 Then 
		'Log("MinY.Error: StartPercent must be smaller than StopPercent")
		StopPercent2 = StartPercent2 + 1
	End If

	Dim MinValue As String = mSQL.ExecQuerySingleResult( "SELECT MIN(y) FROM " & dbTable & " WHERE id >= " & StartPercent2 & " AND id <= " & StopPercent2)
	Return MinValue
End Sub

'Returns average value of the range
'StartPercent, StopPercent: range of data, all data are when StartPercent = 0%, StartPercent = 100%
Public Sub AvgY (StartPercent As Int, StopPercent As Int) As String
	Dim count As Int = DBUtils.GetIntFromSQL(mSQL, dbTable, "SELECT count(*) FROM " & dbTable)	'data qty
	Dim StartPercent2 As Int = StartPercent * count / 100
	Dim StopPercent2 As Int = StopPercent * count / 100
	Dim Range As Int = StopPercent2 - StartPercent2
	If Range <= 0 Then 
		'Log("AvgY.Error: StartPercent must be smaller than StopPercent")
		StopPercent2 = StartPercent2 + 1
	End If

	Dim AvgValue As String = mSQL.ExecQuerySingleResult( "SELECT AVG(y) FROM " & dbTable & " WHERE id >= " & StartPercent2 & " AND id <= " & StopPercent2)
	Return AvgValue
End Sub

Private Sub Calc_SubIntervals (StartPercent As Int, StopPercent As Int) As Int
	Dim count As Int = DBUtils.GetIntFromSQL(mSQL, dbTable, "SELECT count(*) FROM " & dbTable & " WHERE id >= " & StartPercent & " AND id <= " & StopPercent)
	Private SubIntervals_qty As Int 'the source period is divided into this number parts [ i] (iterable) to compare them
	If count > 100 Then
		SubIntervals_qty = 10
	Else
		SubIntervals_qty = count - 1
	End If
	If SubIntervals_qty < 1 Then SubIntervals_qty = 1
	Return SubIntervals_qty
End Sub

'Checks if the chart is wobbling within +/- StableWithin/2 % value.
'StartPercent, StopPercent: range of data, all data are when StartPercent = 0%, StartPercent = 100%
Public Sub isStableY (StableWithin As Float, StartPercent As Int, StopPercent As Int) As TrendResult
	Dim count As Int = DBUtils.GetIntFromSQL(mSQL, dbTable, "SELECT count(*) FROM " & dbTable)	'data qty
	Dim StartPercent2 As Int = StartPercent * count / 100
	Dim StopPercent2 As Int = StopPercent * count / 100
	Dim Range As Int = StopPercent2 - StartPercent2
	If Range <= 0 Then 
		'Log("isStableY.Error: StartPercent must be smaller than StopPercent")
		StopPercent2 = StartPercent2 + 1
	End If

	Private result As TrendResult
	result.Initialize
	result.MaxY = MaxY(StartPercent, StopPercent)
	result.MaxX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id <= " & StopPercent2 & " ORDER BY id DESC LIMIT 1")
	result.MinY = MinY(StartPercent, StopPercent)
	Sleepp(0)
	result.MinX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id >= " & StartPercent2 & " ORDER BY id ASC LIMIT 1")
	Dim AvgID As Int = (StopPercent2 + StartPercent2)/2
	result.avgX = mSQL.ExecQuerySingleResult("SELECT x FROM " & dbTable & " WHERE id >= " & AvgID & " ORDER BY id ASC LIMIT 1")
	result.avgY = AvgY(StartPercent, StopPercent)
	
	Dim delta As Double = Abs(result.MaxY - result.MinY) / result.avgY * 100
'	Log("delta = " & delta & " %")

	If delta <= Abs(StableWithin)  Then
		result.stable = True
	Else
		result.stable = False
	End If
	result.StableWithin = StableWithin
	Return result
End Sub

'Returns an iconified string, with the automated checkings of the chart.
'StartPercent, StopPercent: range of data, all data are when StartPercent = 0%, StartPercent = 100%
Public Sub AutoAnalysis1 (StartPercent As Int, StopPercent As Int) As String
	#if B4A
		ProgressDialogShow("")
	Sleepp(10)
	#end if
	Dim Range As Int = StopPercent - StartPercent
	If Range <= 0 Then
		Log("Error: StartPercent must be smaller than StopPercent")
		StopPercent = StartPercent
	End If
	Private SubIntervals_qty As Int = Calc_SubIntervals(StartPercent, StopPercent) 'the source period is divided into this number parts [ i] (iterable) to compare them
	Dim Interval As Int = Floor(Range / SubIntervals_qty) + 1	'qty of analysing subintervals of the whole data set
	Dim an As String
	For i = StartPercent To StopPercent - Interval Step Interval
		Dim m As Map
		m.Initialize
		Dim upto As Int = i + Interval
		Dim upto As Int = i + Interval
		Dim rising As TrendResult = isRisingY(i, upto)
		Dim falling As TrendResult = isFallingY(i, upto)
		Dim wobbling As TrendResult = isWobblingY(i, upto)
		Dim hasmax As TrendResult = hasMaximum(i, upto)
		Dim hasmin As TrendResult = hasMinimum(i, upto)
		Dim stable100 As TrendResult = isStableY(100, i, upto)
		Dim stable50 As TrendResult = isStableY(50, i, upto)
		Dim stable20 As TrendResult = isStableY(20, i, upto)
		
		If rising.rising Then
			an = an & "↗"
		End If
		If falling.falling Then
			an = an & "↘"
		End If
		If wobbling.wobbling Then
			If stable20.stable Then
				an = an & "↝↝↝"	'wobbling within a narrow range
			else if stable50.stable  Then
				an = an & "↝↝"	'wobbling within a middle size range
			else if stable100.stable Then
				an = an & "↝"	'wobbling within a big range
			End If
			an = an & "↝"
		End If
		If hasmax.hasMaxY Then
			an = an & "↷"	'maximum
		End If
		If hasmin.hasMinY Then
			an = an & "↺"	'minimum
		End If
		an = an & "."
		#if B4A
			Sleepp(0)
		#Else if B4J
			If (i Mod 3) = 0 Then Sleepp(0)
		#End If
	Next
	#if B4A
		ProgressDialogHide
	#End If
	Return an
End Sub

Private Sub Sleepp(i As Int)
	Sleep(i)
End Sub

'Automated checkings of the chart.
'Returns the map of approximated curve.
'StartPercent, StopPercent: range of data, all data are when StartPercent = 0%, StartPercent = 100%
Public Sub AutoAnalysis2 (StartPercent As Int, StopPercent As Int) As Map
	#if B4A
		ProgressDialogShow("")
		Sleepp(10)
	#end if
	
	Dim Range As Int = StopPercent - StartPercent
	If Range <= 0 Then
		Log("Error: StartPercent must be smaller than StopPercent")
		StopPercent = StartPercent
	End If
	Private SubIntervals_qty As Int = Calc_SubIntervals(StartPercent, StopPercent) 'the source period is divided into this number parts [ i] (iterable) to compare them
	Dim Interval As Int = Floor(Range / SubIntervals_qty) + 1	'qty of analysing subintervals of the whole data set
	Dim curve As Map
	curve.Initialize
	Dim count As Int
	For i = StartPercent To StopPercent - Interval Step Interval
		Dim m As Map
		m.Initialize
		Dim upto As Int = i + Interval
		Dim rising As TrendResult = isRisingY(i, upto)
		Dim falling As TrendResult = isFallingY(i, upto)
		Sleepp(0)
		Dim wobbling As TrendResult = isWobblingY(i, upto)
		Dim hasmax As TrendResult = hasMaximum(i, upto)
		Sleepp(0)
		Dim hasmin As TrendResult = hasMinimum(i, upto)
		
		If rising.rising Then
			curve.Put((count & "_" & rising.MinX), rising.MinY)
			curve.Put(((count+1) & "_" & rising.MaxX), rising.MaxY)
		else if falling.falling Then
			curve.Put(((count+2) & "_" & falling.MinX), falling.MaxY)
			curve.Put(((count+3) & "_" & falling.MaxX), falling.MinY)
		else if wobbling.wobbling Then
			curve.Put(((count+5) & "_" & wobbling.avgX), wobbling.avgY)
			curve.Put(((count+55) & "_" & wobbling.avgX), wobbling.avgY)
			curve.Put(((count+555) & "_" & wobbling.avgX), wobbling.avgY)
		else if hasmax.hasMaxY Then
			curve.Put(((count+7) & "_" & hasmax.MinX), hasmax.MinY)
			curve.Put(((count+8) & "_" & hasmax.avgX), hasmax.avgY)
			curve.Put(((count+9) & "_" & hasmax.MaxX), hasmax.MaxY)
		else if hasmin.hasMinY Then
			curve.Put(((count+10) & "_" & hasmin.MinX), hasmin.MinY)
			curve.Put(((count+11) & "_" & hasmin.avgX), hasmin.avgY)
			curve.Put(((count+12) & "_" & hasmin.MaxX), hasmin.MaxY)
		End If
		count = count + 1
		#if B4A
			Sleepp(0)
		#Else if B4J
			If (i Mod 3) = 0 Then Sleepp(0)
		#End If
	Next
	#if B4A
		ProgressDialogHide
	#End If
	Return curve
End Sub

'Automated checkings of the chart.
'Returns the text description of the chart.
Public Sub AutoAnalysis_Whole_Simple As String
	#if B4A
	ProgressDialogShow("")
	Sleepp(10)
	#end if
	Dim rising As TrendResult = isRisingY(0, 100)
	Dim falling As TrendResult = isFallingY(0, 100)
	Sleepp(0)
	Dim wobbling As TrendResult = isWobblingY(0, 100)
	Dim hasmax As TrendResult = hasMaximum(0, 100)
	Dim hasmin As TrendResult = hasMinimum(0, 100)
	Sleepp(0)
	
	Dim res As StringBuilder
	res.Initialize
	res.Append(NameYaxis).Append(": ").Append(hasmin.MinY).Append(" ... ").Append(hasmax.MaxY).Append(" ").Append(UnitsYaxis).Append(CRLF)
	
	If rising.rising Then
		res.Append(NameYaxis).Append(" ").Append(DESC_TERM_ISRISING).Append(" ").Append(DESC_TERM_UPTO).Append(" ").Append(rising.MaxY).Append(" ").Append(UnitsYaxis).Append(CRLF)
	End If
	If falling.falling Then
		res.Append(NameYaxis).Append(" ").Append(DESC_TERM_ISFALLING).Append(" ").Append(DESC_TERM_UPTO).Append(" ").Append(falling.MinY).Append(" ").Append(UnitsYaxis).Append(CRLF)
	End If
	If wobbling.wobbling Then
		res.Append(NameYaxis).Append(" ").Append(DESC_TERM_ISWOBBLING).Append(" ").Append(DESC_TERM_AROUND).Append(" ").Append(wobbling.avgY).Append(" ").Append(UnitsYaxis).Append(CRLF)
	End If
	If hasmax.hasMaxY Then
		res.Append(NameYaxis).Append(" ").Append(DESC_TERM_HADMAX).Append(" ").Append(DESC_TERM_UPTO).Append(" ").Append(hasmax.MaxY).Append(" ").Append(UnitsYaxis).Append(CRLF)
	End If
	If hasmin.hasMinY Then
		res.Append(NameYaxis).Append(" ").Append(DESC_TERM_HADMIN).Append(" ").Append(DESC_TERM_UPTO).Append(" ").Append(hasmin.MinY).Append(" ").Append(UnitsYaxis).Append(CRLF)
	End If
	
	Dim stable As TrendResult
	For i = 10 To 100 Step 30
		Sleepp(0)
		stable = isStableY(i, 0, 100)
		If stable.stable Then
			Exit
		End If
	Next
	
	If stable.stable Then
		res.Append(NameYaxis).Append(" ").Append(DESC_TERM_ISSTABLE).Append(" ").Append(DESC_TERM_WITHIN).Append(" ").Append(stable.stableWithin).Append(" %, ").Append(stable.AvgY).Append(" ").Append(UnitsYaxis).Append(CRLF)
	End If
	
	#if B4A
	ProgressDialogHide
	#End If
Return res.ToString
End Sub