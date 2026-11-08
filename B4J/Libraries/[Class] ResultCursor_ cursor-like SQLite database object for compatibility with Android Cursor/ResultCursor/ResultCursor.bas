B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
'v.0.11 (c) Vlad Pomelov aka Peacemaker
'SQLite Cursor-like class for B4J as of Android Cursor
Private Sub Class_Globals
	Private mSQL As SQL
	Private mQuery As String
	Private mStringArgs() As String
	Private mRowCount As Int
	Private mColumnCount As Int
	Private mPosition As Int = -1
	Private mLimit As Int
	Private mColumns As Map
	Private mRows As List
	Private mInitialized As Boolean
End Sub

'Executes the query and returns the result.
'StringArgs - Values to replace question marks in the query. Pass Null if not needed.
'Limit - Limits the results. Pass 0 for all results.
Public Sub Initialize (SQL As SQL, Query As String, StringArgs() As String, Limit As Int)
	mSQL = SQL
	mQuery = Query
	mStringArgs = StringArgs
	mLimit = Limit
	
	ExecuteSQL
	mPosition = -1
	mInitialized = True
End Sub

'Frees resources
Sub Close
	mColumns = Null
	mRows = Null
	mSQL = Null
	mInitialized = False
End Sub

Private Sub ExecuteSQL
	Dim cur As ResultSet
	If mStringArgs = Null Then
		Dim mStringArgs(0) As String
	End If
	cur = mSQL.ExecQuery2(mQuery, mStringArgs)
	Dim mRows As List
	mRows.Initialize
	mRowCount = 0
	
	Dim jrs As JavaObject = cur
	Dim rsmd As JavaObject = jrs.RunMethod("getMetaData", Null)
	mColumnCount = cur.ColumnCount
	
	mColumns.Initialize
	For i = 0 To mColumnCount - 1
		mColumns.Put(cur.GetColumnName(i), i)
	Next
	mRows.Initialize
	Do While cur.NextRow
		Dim row(mColumnCount) As Object
		For i = 0 To mColumnCount - 1
			Dim ct As Int = rsmd.RunMethod("getColumnType", Array(i + 1))
			'check whether it is a blob field
			If ct = -2 Or ct = 2004 Or ct = -3 Or ct = -4 Then
				row(i) = cur.GetBlob2(i)
			Else if ct = 2 Or ct = 3 Then
				row(i) = cur.GetDouble2(i)
			Else
				row(i) = jrs.RunMethod("getObject", Array(i + 1))
			End If
		Next
		mRows.Add(row)
		mRowCount = mRowCount + 1
		If mLimit > 0 And mRows.Size >= mLimit Then Exit
	Loop
	cur.Close
End Sub

Sub GetString(ColumnName As String) As String
	Dim n As Int = mColumns.Get(ColumnName)
	Dim res() As Object = mRows.Get(mPosition)
	Return res(n).As(String)
End Sub

Sub GetString2 (Index As Int) As String
	Dim res() As Object = mRows.Get(mPosition)
	Return res(Index).As(String)
End Sub

'Returns the name of the column at the specified index.
'The first column index is 0.
Sub GetColumnName (Index As Int) As String
	Return mColumns.GetKeyAt(Index)
End Sub

Sub GetBlob (ColumnName As String) As Byte()
	Dim n As Int = mColumns.Get(ColumnName)
	Dim res() As Object = mRows.Get(mPosition)
	Dim blob() As Byte = res(n)
	Return blob
End Sub

Sub GetDouble (ColumnName As String) As Double
	Dim n As Int = mColumns.Get(ColumnName)
	Dim res() As Object = mRows.Get(mPosition)
	Return res(n).As(Double)
End Sub

Sub GetDouble2 (Index As Int) As Double
	Dim res() As Object = mRows.Get(mPosition)
	Return res(Index).As(Double)
End Sub

Sub GetBlob2 (Index As Int) As Byte()
	Dim res() As Object = mRows.Get(mPosition)
	Dim blob() As Byte = res(Index)
	Return blob
End Sub

Sub GetInt (ColumnName As String) As Int
	Dim n As Int = mColumns.Get(ColumnName)
	Dim res() As Object = mRows.Get(mPosition)
	Return res(n).As(Int)
End Sub

Sub GetInt2 (Index As Int) As Int
	Dim res() As Object = mRows.Get(mPosition)
	Return res(Index).As(Int)
End Sub

Sub GetLong (ColumnName As String) As Long
	Dim n As Int = mColumns.Get(ColumnName)
	Dim res() As Object = mRows.Get(mPosition)
	Return res(n).As(Long)
End Sub

Sub GetLong2 (Index As Int) As Long
	Dim res() As Object = mRows.Get(mPosition)
	Return res(Index).As(Long)
End Sub

'Gets the number of columns available in the result set.
Sub getColumnCount As Int
	Return mColumnCount
End Sub

'Gets the numbers or rows available in the result set.
Sub getRowCount As Int
	Return mRowCount
End Sub

'Gets Or sets the current position (row).
'Note that the starting position of a cursor returned from a query Is -1.
'The first valid position Is 0.
Sub getPosition As Int
	Return mPosition
End Sub

'Gets Or sets the current position (row).
'Note that the starting position of a cursor returned from a query Is -1.
'The first valid position Is 0.
Sub setPosition (i As Int)
	mPosition = i
End Sub

'Stored SQL-query that was executed
Sub getQuery As String
	Return mQuery
End Sub

'Stored arguments of the SQL-query that was executed
Sub getSQLreqArgs As String()
	Return mStringArgs
End Sub

Sub IsInitialized As Boolean
	Return mInitialized
End Sub