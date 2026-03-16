B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.45
@EndOfDesignText@
Sub Class_Globals
	#if B4J
	Private DateTimeMethods As Map = CreateMap(91: "getDate", 92: "getTime", 93: "getTimestamp")
	#end if
	Public mSQL As SQL
End Sub

'Initializes DBQuery.
Public Sub Initialize (SQL1 As SQL)
	mSQL = SQL1
End Sub

'Closes the SQL connection.
Public Sub Close
	mSQL.Close
End Sub

Private Sub HeadersFromRS(rs As ResultSet) As Object()
	Dim cols As Int = rs.ColumnCount
	Dim headers(cols) As Object
	For i = 0 To cols - 1
		headers(i) = rs.GetColumnName(i)
	Next
	Return headers
End Sub

'Executes the SQL command, with optional parameterized parameters. Pass Null for Args if not needed.
'For multiple inserts, it is recommended to enclose the commands with a transaction.
'Example:<code>db.ExecNonQuery("INSERT INTO table1 VALUES (?, ?, 0)", Array("some text", 2))</code>
Public Sub ExecNonQuery(Query As String, Args As List)
	mSQL.ExecNonQuery2(Query, Args)
End Sub

'Executes the query and returns the value of the first column in the first row.
'Returns the passed DefaultValue if zero rows returned or the value is Null.
'Example: <code>Dim RowCount As Int = db.ExecQuerySingleResult("SELECT count(*) FROM table1", Null, 0)</code>
Public Sub ExecQuerySingleResult(Query As String, Args As List, DefaultValue As Object) As Object
	Dim res As Object = ExecQueryHelper(Query, Args, True)
	If res = Null Then Return DefaultValue
	Return res
End Sub

'Executes the query and returns a ListOfArrays with the result. Pass Null for Args if not needed.
'Example:<code>Dim res As ListOfArrays = db.ExecQuery($"SELECT * FROM table1 WHERE name = ?"$, Array("John"))
'Log(res.ToString(10))</code>
Public Sub ExecQuery(Query As String, Args As List) As ListOfArrays
	Return ExecQueryHelper(Query, Args, False)
End Sub

'Begins an atomic transaction. All commands will either be committed together
'after a call to TransactionSuccessful, or rolled back after a call to Rollback.
'Executing multiple commands in a single transaction is significantly faster
'(up to x100) than executing each command separately.
'Recommended pattern:<code>
'db.BeginTransaction
'Try
'	'block of statements like:
'	For i = 1 To 1000
'		db.ExecNonQuery("INSERT INTO table1 VALUES(...)")
'	Next
'	db.TransactionSuccessful
'Catch
'	Log(LastException.Message)
'	db.Rollback 'no changes will be made
'End Try
'</code>
Public Sub BeginTransaction
	mSQL.BeginTransaction
End Sub

'Commits the transaction. In B4A it also calls SQL.EndTransaction
'(not needed in B4J / B4i).
'See BeginTransaction for more details.
Public Sub TransactionSuccessful
	mSQL.TransactionSuccessful
	#if B4A
	mSQL.EndTransaction
	#End If
End Sub

'Rolls back the transaction. No changes will be made to the DB.
'In B4A it calls SQL.EndTransaction without SQL.TransactionSuccessful,
'which is semantically the same.
Public Sub Rollback
	#if B4J or b4i
	mSQL.Rollback
	#else if b4a
	mSQL.EndTransaction
	#End If
End Sub

#if B4J
Private Sub ExecQueryHelper(Query As String, Args As List, SingleResult As Boolean) As Object
	Dim rs As ResultSet = mSQL.ExecQuery2(Query, Args)
	Dim jrs As JavaObject = rs
	Dim rsmd As JavaObject = jrs.RunMethod("getMetaData", Null)
	If Not(SingleResult) Then
		Dim headers() As Object = HeadersFromRS(rs)
		Dim loa As ListOfArrays = LOAUtils.CreateEmpty(headers)
	End If
	Dim cols As Int = rs.ColumnCount
	Dim ColsType As List
	Dim row(0) As Object
	Do While rs.NextRow
		If NotInitialized(ColsType) Then
			ColsType = B4XCollections.CreateList(Null)
			For i = 0 To cols - 1
				ColsType.Add(rsmd.RunMethod("getColumnType", Array(i + 1)))
			Next
		End If
		Dim row(cols) As Object
		For i = 0 To cols - 1
			Dim ct As Int = ColsType.Get(i)
			'check whether it is a blob field
			If ct = -2 Or ct = 2004 Or ct = -3 Or ct = -4 Then
				row(i) = rs.GetBlob2(i)
			Else if ct = 2 Or ct = 3 Then
				row(i) = rs.GetDouble2(i)
			Else If DateTimeMethods.ContainsKey(ct) Then
				Dim SQLTime As JavaObject = jrs.RunMethodJO(DateTimeMethods.Get(ct), Array(i + 1))
				If SQLTime.IsInitialized Then
					row(i) = SQLTime.RunMethod("getTime", Null)
				Else
					row(i) = Null
				End If
			Else
				row(i) = jrs.RunMethod("getObject", Array(i + 1))
			End If
		Next
		If SingleResult Then Exit
		loa.AddRow(row)
	Loop
	rs.Close
	If SingleResult Then
		Return IIf(row.Length = 0, Null, row(0))
	End If
	Return loa
End Sub
#else if B4A

Private Sub ExecQueryHelper(Query As String, Args As List, SingleResult As Boolean) As Object
	If NotInitialized(Args) Then Args = B4XCollections.GetEmptyList
	Dim sargs(Args.Size) As String
	For i = 0 To Args.Size - 1
		sargs(i) = Args.get(i)
	Next
	Dim rs As ResultSet = mSQL.ExecQuery2(Query, sargs)
	Dim jrs As JavaObject = rs
	Dim cols As Int = rs.ColumnCount
	If Not(SingleResult) Then
		Dim headers() As Object = HeadersFromRS(rs)
		Dim loa As ListOfArrays = LOAUtils.CreateEmpty(headers)
	End If
	Dim row(0) As Object
	Do While rs.NextRow
		Dim row(cols) As Object
		Dim o As Object
		For i = 0 To cols - 1
			Dim t As Int = jrs.RunMethod("getType", Array(i))
			Select t
				Case 0 'NULL
					o = Null
				Case 1 'INTEGER
					Dim l As Long = rs.GetLong2(i)
					o = IIf(l = l.As(Int), l.As(Int), l)
				Case 2 'REAL
					o = rs.GetDouble2(i)
				Case 3 'string
					o = rs.GetString2(i)
				Case 4 'blob
					o = rs.GetBlob2(i)
			End Select
			row(i) = o
		Next
		If SingleResult Then Exit
		loa.AddRow(row)
	Loop
	rs.Close
	If SingleResult Then
		Return IIf(row.Length = 0, Null, row(0))
	End If
	Return loa
End Sub

#else if b4i
Private Sub ExecQueryHelper(Query As String, Args As List, SingleResult As Boolean) As Object
	Dim rs As ResultSet = mSQL.ExecQuery2(Query, Args)
	Dim cols As Int = rs.ColumnCount
	If Not(SingleResult) Then
		Dim headers() As Object = HeadersFromRS(rs)
		Dim loa As ListOfArrays = LOAUtils.CreateEmpty(headers)
	End If
	
	Dim no As NativeObject = rs
	no = no.GetField("_object").GetField("_statement")
	Dim row(0) As Object
	Do While rs.NextRow
		Dim ColsType As List = Me.As(NativeObject).RunMethod("getColumnTypes:", Array(no))
		Dim row(cols) As Object
		Dim o As Object
		For i = 0 To cols - 1
			Dim t As Int = ColsType.Get(i)
			Select t
				Case 5 'NULL
					o = Null
				Case 1 'INTEGER
					Dim l As Long = rs.GetLong2(i)
					o = IIf(l = l.As(Int), l.As(Int), l)
				Case 2 'REAL
					o = rs.GetDouble2(i)
				Case 3 'string
					o = rs.GetString2(i)
				Case 4 'blob
					o = rs.GetBlob2(i)
			End Select
			row(i) = o
		Next
		If SingleResult Then Exit
		loa.AddRow(row)
	Loop
	rs.Close
	If SingleResult Then
		Return IIf(row.Length = 0, Null, row(0))
	End If
	Return loa
End Sub


#if OBJC
#import "sqlite3.h"
#import <objc/runtime.h>
- (NSArray *)getColumnTypes:(NSObject *)obj {
    static ptrdiff_t offset = -1;
    if (offset == -1) {
        Ivar iv = class_getInstanceVariable([obj class], "_statement");
        if (iv == NULL) return nil;
        offset = ivar_getOffset(iv);
    }

    sqlite3_stmt *stmt = *(sqlite3_stmt **)((uint8_t *)(__bridge void *)obj + offset);
    int cols = sqlite3_column_count(stmt);
    NSMutableArray *res = [NSMutableArray arrayWithCapacity:cols];
    for (int i = 0; i < cols; i++) {
        [res addObject:@(sqlite3_column_type(stmt, i))];
    }
    return res;
}

#End If
#End If