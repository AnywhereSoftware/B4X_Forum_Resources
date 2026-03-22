B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.45
@EndOfDesignText@
Sub Class_Globals
	Public mInternalArray As List
	Public mFirstDataRowIndex As Int
	Public mIndicesMap As Map
End Sub

'Use LOAUtils.Create or Wrap methods instead.
Public Sub Initialize (Data As List)
	If Initialized (Data) Then
		If Data.Size > 0 Then
			Dim FirstRow() As Object = Data.Get(0) 'ignore - just to test class
		End If
		mInternalArray = Data
	Else
		mInternalArray.Initialize
	End If
	InternalUpdateIndicesMap
End Sub
'Internal method.
Public Sub InternalUpdateIndicesMap
	If getFirstRowIsHeader = False Then Return
	If NotInitialized(mIndicesMap) Then
		mIndicesMap.Initialize
	End If
	mIndicesMap.Clear
	For i = 0 To getNumberOfColumns - 1
		mIndicesMap.Put(i, i)
	Next
	Dim headers() As Object = getHeader
	For i = 0 To headers.Length - 1
		mIndicesMap.Put(headers(i), i)
		mIndicesMap.Put(headers(i).As(String).ToLowerCase, i)
	Next
End Sub

'Gets or sets the LOA header. The header is added as the first row in the internal array.
Public Sub setHeader(Header() As Object)
	If getFirstRowIsHeader And mInternalArray.Size > 0 Then
		'there is already a header. Replace it
		mInternalArray.Set(0, Header)
		InternalUpdateIndicesMap
	Else
		mInternalArray.InsertAt(0, Header)
		setFirstRowIsHeader(True)
	End If
End Sub

'Returns the headers.
Public Sub getHeader As Object()
	If getFirstRowIsHeader And mInternalArray.Size > 0 Then
		Return mInternalArray.Get(0)
	Else
		Return Array()
	End If
End Sub

'Internal method. Gets or sets whether the first row in the LOA is a header.
Public Sub getFirstRowIsHeader As Boolean
	Return mFirstDataRowIndex = 1
End Sub

Public Sub setFirstRowIsHeader(b As Boolean)
	mFirstDataRowIndex = IIf(b, 1, 0)
	InternalUpdateIndicesMap
End Sub

'Converts the stored values types based on the passed indices.
'This method is useful in cases where data is stored as strings, for example with CSV files.
'Non-selected columns will be removed.
Public Sub ConvertTypes (IntIndices As List, DoubleIndices As List, LongIndices As List, ObjectIndices As List)
	If getIsEmpty Then Return
	Dim AllIndices As B4XOrderedMap = B4XCollections.CreateOrderedMap
	Dim ii() As List = Array As List(IntIndices, DoubleIndices, LongIndices, ObjectIndices)
	For i = 0 To ii.Length - 1
		For Each ix As Int In ObjectIndicesToIntIndices(ii(i))
			AllIndices.Put(ix, i)
		Next
	Next
	AllIndices.Keys.Sort(True)
	If getFirstRowIsHeader Then
		mInternalArray.Set(0, CopyRow(mInternalArray.Get(0), AllIndices.Keys))
	End If
	For RowIndex = mFirstDataRowIndex To mInternalArray.Size - 1
		Dim Row() As Object = mInternalArray.Get(RowIndex)
		Dim NewRow(AllIndices.Size) As Object
		Dim nix As Int
		For Each ix As Int In AllIndices.Keys
			Dim ConvertType As Int = AllIndices.Get(ix)
			Dim o As Object
			Select ConvertType
				Case 0
					Dim IntValue As Int = Row(ix)
					o = IntValue
				Case 1
					Dim DoubleValue As Double = Row(ix)
					o = DoubleValue
				Case 2
					Dim LongValue As Long = Row(ix)
					o = LongValue
				Case 3
					o = Row(ix)
			End Select
			NewRow(nix) = o
			nix = nix + 1
		Next
		mInternalArray.Set(RowIndex, NewRow)
	Next
	InternalUpdateIndicesMap
End Sub

'Returns a list with arrays of strings with the data. Should be used to save the data as CSV.
'Types other than strings and numbers will be converted to a their default string representation.
Public Sub ToListOfStrings As List
	Dim res As List = B4XCollections.CreateList(Null)
	For Each row() As Object In mInternalArray
		Dim NewRow(row.Length) As String
		For i = 0 To row.Length - 1
			NewRow(i) = row(i)	
		Next
		res.Add(NewRow)
	Next
	Return res
End Sub

'Returns the array of the specified row.
Public Sub GetRow(RowIndex As Int) As Object()
	Return mInternalArray.Get(mFirstDataRowIndex + RowIndex)
End Sub

'Replaces the specified row with the new row. Note that the array is reused. Do not modify the passed Row.
Public Sub SetRow(RowIndex As Int, Row() As Object)
	CheckColumnsMatch("SetRow", Row.Length)
	mInternalArray.Set(mFirstDataRowIndex + RowIndex, Row)
End Sub

'Returns the value stored in the specified row and column.
Public Sub GetValue(RowIndex As Int, ColumnIndex As Object) As Object
	Dim row() As Object = GetRow(RowIndex)
	Return row(ColumnIndexToOrdinal(ColumnIndex))
End Sub

'Returns the value stored in the specified row and column. Returns DefaultValue if RowIndex is out of bounds or the value is Null.
'Useful together with GetRowIndexByValue.
Public Sub GetValueDefault(RowIndex As Int, ColumnIndex As Object, DefaultValue As Object) As Object
	If RowIndex < 0 Or RowIndex >= getSize Then Return DefaultValue
	Dim o As Object = GetValue(RowIndex, ColumnIndex)
	Return IIf(o = Null, DefaultValue, o)
End Sub

'Sets the value stored in the specified row and column.
Public Sub SetValue(RowIndex As Int, ColumnIndex As Object, Value As Object)
	Dim row() As Object = GetRow(RowIndex)
	row(ColumnIndexToOrdinal(ColumnIndex)) = Value
End Sub

'Returns the number of columns.
Public Sub getNumberOfColumns As Int
	If mInternalArray.Size = 0 Then Return 0
	Dim row() As Object = mInternalArray.Get(0)
	Return row.Length
End Sub

'Returns the number of rows, not including the header if available.
Public Sub getSize As Int
	Return Max(0, mInternalArray.Size - mFirstDataRowIndex)
End Sub

'Tests whether the LOA is empty. 
Public Sub getIsEmpty As Boolean
	Return mInternalArray.Size <= mFirstDataRowIndex
End Sub

'Used internally to convert the column name or ordinal to ordinal.
Public Sub ColumnIndexToOrdinal (Index As Object) As Int
	If getFirstRowIsHeader = False Then Return Index
	Dim ix As Int = mIndicesMap.GetDefault(Index, -1)
	If ix = -1 Then ix = mIndicesMap.GetDefault(Index.As(String).ToLowerCase, -1)
	If ix = -1 Then ThrowError("Column index not found: " & Index)
	Return ix
End Sub

'Creates a LOASet that iterates over the data.
'Example:<code>
'Dim ls As LOASet = table.CreateLOASet
'Do While ls.NextRow
' If ls.GetValue("Some column") > 100 Then ls.CollectIndex
'Loop
'table.DeleteRows(ls.CollectedIndices)</code>
Public Sub CreateLOASet As LOASet
	Dim l As LOASet
	l.Initialize(Me)
	Return l
End Sub

'Returns a list with the values from the column. Items are the value themselves, not an array of objects.
'It excludes the header if one is set.
Public Sub GetColumn(ColumnIndex As Object) As List
	ColumnIndex = ColumnIndexToOrdinal(ColumnIndex)
	Dim res As List = B4XCollections.CreateList(Null)
	For i = mFirstDataRowIndex To mInternalArray.Size - 1
		Dim row() As Object = mInternalArray.Get(i)
		res.Add(row(ColumnIndex))
	Next
	Return res
End Sub

'Adds a column to the LOA. Number of rows must match. The list should hold the values directly, not arrays of objects.
'Use Merge if the list holds arrays of objects.
Public Sub AddColumn(Header As String, Column As List)
	If mInternalArray.Size = 0 Then
		If Header <> "" Then
			mInternalArray.Add(Array(Header))
			setFirstRowIsHeader(True)
		End If
		For Each o As Object In Column
			mInternalArray.Add(Array(o))
		Next
	Else
		If (getFirstRowIsHeader = True) <> (Header <> "") Then ThrowError("AddColumn - column header state must match LOA header state.")
		If getSize <> Column.Size Then ThrowError("AddColumn - number of rows do not match.")
		For i = 0 To mInternalArray.Size - 1
			Dim row1() As Object = mInternalArray.Get(i)
			Dim NewRow(row1.Length + 1) As Object
			ArrayCopy(row1, 0, NewRow, 0, row1.Length)
			NewRow(row1.Length) = IIf(i = 0 And mFirstDataRowIndex = 1, Header, Column.Get(i - mFirstDataRowIndex))
			mInternalArray.Set(i, NewRow)
		Next
	End If
	InternalUpdateIndicesMap
End Sub

'Replaces the column with the new one. The passed columns should hold values, not arrays of objects.
Public Sub SetColumn(ColumnIndex As Object, Column As List)
	If Column.Size <> getSize Then ThrowError("SetColumn - sizes do not match.")
	Dim ix As Int = ColumnIndexToOrdinal(ColumnIndex)
	For i = mFirstDataRowIndex To mInternalArray.Size - 1
		Dim row() As Object = mInternalArray.Get(i)
		row(ix) = Column.Get(i - mFirstDataRowIndex)
	Next
End Sub

'Returns a list with the column indices. It will be 0..n-1.
'Can be useful for methods that accept a list of indices.
Public Sub getColumnIndices As List
	Dim res As List = B4XCollections.CreateList(Null)
	For i = 0 To getNumberOfColumns - 1
		res.Add(i)
	Next
	Return res
End Sub

'Adds a row to the LOA. Number of columns must match number of items.
Public Sub AddRow(Row() As Object)
	CheckColumnsMatch("AddRow", Row.Length)
	mInternalArray.Add(Row)
End Sub

'Inserts a row at the specified index.
Public Sub InsertRow(RowIndex As Int, Row() As Object)
	CheckColumnsMatch("InsertRow", Row.Length)
	mInternalArray.InsertAt(RowIndex + mFirstDataRowIndex, Row)
End Sub

Private Sub CheckColumnsMatch(MethodName As String, OtherCount As Int)
	Dim cols As Int = getNumberOfColumns
	If cols > 0 And cols <> OtherCount Then
		ThrowError($"${MethodName} - Number of columns do not match."$)
	End If
End Sub

'Adds all rows from LOA to this table. Number of columns must match. The arrays of objects are reused.
'Header in LOA is excluded.
Public Sub AddRows(LOA As ListOfArrays)
	If LOA.IsEmpty Then Return
	CheckColumnsMatch("AddRows", LOA.NumberOfColumns)
	If LOA.FirstRowIsHeader Then
		#if B4J
		mInternalArray.AddAll(LOA.mInternalArray.SubList(LOA.mFirstDataRowIndex, LOA.mInternalArray.Size))
		#else
		mInternalArray.AddAll(B4XCollections.SubList(LOA.mInternalArray, LOA.mFirstDataRowIndex, LOA.mInternalArray.Size))
		#end if
	Else
		mInternalArray.AddAll(LOA.mInternalArray)
	End If
End Sub

'Removes all rows. Keeps the header if there is one.
Public Sub Clear
	Dim header() As Object = getHeader
	mInternalArray.Clear
	If header.Length > 0 Then mInternalArray.Add(header)
End Sub

'Adds all columns from LOA to this table. Number of rows must match.
Public Sub Merge(LOA As ListOfArrays)
	If getSize <> LOA.Size Or mFirstDataRowIndex <> LOA.mFirstDataRowIndex Then ThrowError("Merge - number of rows do not match.")
	For i = 0 To mInternalArray.Size - 1
		Dim row1() As Object = mInternalArray.Get(i)
		Dim row2() As Object = LOA.mInternalArray.Get(i)
		Dim NewRow(row1.Length + row2.Length) As Object
		ArrayCopy(row1, 0, NewRow, 0, row1.Length)
		ArrayCopy(row2, 0, NewRow, row1.Length, row2.Length)
		mInternalArray.Set(i, NewRow)
	Next
	InternalUpdateIndicesMap
End Sub

Private Sub ArrayCopy(SrcArray() As Object, SrcOffset As Int, DestArray() As Object, DestOffset As Int, Length As Int)
	#if B4A or B4J
	Bit.ArrayCopy(SrcArray, SrcOffset, DestArray, DestOffset, Length)
	#Else
	For i = 0 To Length - 1
		DestArray(DestOffset + i) = SrcArray(SrcOffset + i)
	Next
	#End If
End Sub

Private Sub ThrowError(Message As String)
	LogColor("Error: " & Message, 0xffff0000)
	#if B4A or B4J
	Me.As(JavaObject).RunMethod("raiseException", Array(Message))
	#else
	Dim no As NativeObject
	no.Initialize("NSException").RunMethod("raise:format:", Array("", Message))
	#end if
End Sub

'Returns a shallow copy of this table. The arrays of objects are reused.
Public Sub Clone As ListOfArrays
	Dim New As ListOfArrays
	New.Initialize(Null)
	New.mInternalArray.AddAll(mInternalArray)
	New.FirstRowIsHeader = getFirstRowIsHeader
	Return New
End Sub

'Returns a deep copy of this table. Modifying the values in the rows will not change this table.
Public Sub DeepClone As ListOfArrays
	Dim New As ListOfArrays
	New.Initialize(Null)
	For Each Row() As Object In mInternalArray
		Dim NewRow(Row.Length) As Object
		ArrayCopy(Row, 0, NewRow, 0, Row.Length)
		New.mInternalArray.Add(NewRow)
	Next
	New.FirstRowIsHeader = getFirstRowIsHeader
	Return New
End Sub

'Iterates over the rows. Should be called with <code>For Each row() As Object In loa.IterateRows</code>.
'Do not modify the returned list structure. It is allowed to set values in the arrays.
Public Sub IterateRows As List
	If getIsEmpty Then
		Return B4XCollections.GetEmptyList
	End If
	If getFirstRowIsHeader Then
		#if B4J
		Return mInternalArray.SubList(1, mInternalArray.Size)
		#else
		Return B4XCollections.SubList(mInternalArray, 1, mInternalArray.Size)
		#End If
		'Will be changed once List.SubList is available in the next version of B4X.
	Else
		Return mInternalArray
	End If
End Sub

'Creates a new LOA with the selected rows. The arrays of objects are reused. Use DeepClone to create a copy.
Public Sub GetRows (RowIndices As List) As ListOfArrays
	Dim loa As ListOfArrays
	loa.Initialize(Null)
	If getFirstRowIsHeader Then
		loa.Header = getHeader
	End If
	For Each index As Int In RowIndices
		loa.AddRow(GetRow(index))
	Next
	Return loa
End Sub

'Deletes the selected rows.
Public Sub DeleteRows(RowIndices As List)
	RowIndices.Sort(True)
	For i = RowIndices.Size - 1 To 0 Step -1
		mInternalArray.RemoveAt(mFirstDataRowIndex + RowIndices.Get(i))
	Next
End Sub

'Given a list of row indices, returns a list with all row indices
'that are NOT included in the given list.
Public Sub NegateRowsSelection(RowIndices As List) As List
	Dim s As B4XBitSet = B4XCollections.CreateBitSet(getSize)
	For Each ix As Int In RowIndices
		s.Set(ix, True)
	Next
	Dim res As List
	res.Initialize
	For i = 0 To s.Size - 1
		If s.Get(i) = False Then res.Add(i)
	Next
	Return res
End Sub

'Returns the union of the two selections.
Public Sub OrRowsSelections(Selection1 As List, Selection2 As List) As List
	Dim s As B4XSet
	s = B4XCollections.CreateSet2(Selection1)
	For Each i As Int In Selection2
		s.Add(i)
	Next
	Return s.AsList
End Sub

'Returns the intersection of the two selections.
Public Sub AndRowsSelections(Selection1 As List, Selection2 As List) As List
	Dim s1 As B4XSet = B4XCollections.CreateSet2(Selection1)
	Dim s2 As B4XSet = B4XCollections.CreateSet2(Selection2)
	Dim res As List = B4XCollections.CreateList(Null)
	For Each i As Int In s1.AsList
		If s2.Contains(i) Then res.Add(i)
	Next
	Return res
End Sub

'Returns a map where:
'Key   = value from ColumnIndex
'Value = a single row index.
'ColumnIndex - column name or ordinal whose values will be used as keys.
'KeepFirst - when duplicate keys exist:
'            True  = keep the first row index
'            False = keep the last row index
Public Sub GetRowIndices(ColumnIndex As Object, KeepFirst As Boolean) As Map
	Dim res As Map
	res.Initialize
	Dim ix As Int
	For Each o As Object In GetColumn(ColumnIndex)
		If KeepFirst = False Or res.ContainsKey(o) = False Then
			res.Put(o, ix)
		End If
		ix = ix + 1
	Next
	Return res
End Sub

'Returns a B4XOrderedMap where:
'Key   = value from ColumnIndex
'Value = ListOfArrays containing all rows where this value appears.
'The row arrays are reused.
Public Sub GroupBy(ColumnIndex As Object) As B4XOrderedMap
	Dim res As B4XOrderedMap
	res.Initialize
	Dim ix As Int
	For Each o As Object In GetColumn(ColumnIndex)
		Dim l1 As ListOfArrays = res.Get(o)
		If NotInitialized(l1) Then
			l1 = LOAUtils.CreateEmpty(getHeader)
			res.Put(o, l1)
		End If
		l1.AddRow(GetRow(ix))
		ix = ix + 1
	Next
	Return res
End Sub

'Returns a list with the unique values stored in the specified column.
Public Sub GetUniqueValues (ColumnIndex As Object) As List
	Dim s As B4XSet = B4XCollections.CreateSet2(GetColumn(ColumnIndex))
	Return s.AsList
End Sub

'Returns the index of the first row where the specified column matches the given value.  Note that the value type must be exact. Use As to cast if needed.
'Returns -1 if not found.
Public Sub GetRowIndexByValue(ColumnIndex As Object, Value As Object) As Int
	ColumnIndex = ColumnIndexToOrdinal(ColumnIndex)
	If Value = Null Then
		For i = 0 To getSize - 1
			Dim row() As Object = GetRow(i)
			If row(ColumnIndex) = Null Then Return i
		Next
	Else
		For i = 0 To getSize - 1
			Dim row() As Object = GetRow(i)
			If Value = row(ColumnIndex) Then Return i
		Next
	End If
	Return -1
End Sub

'Returns a list with the indices of the rows where the specified column are not null.
'Same as calling loa.NegateRowsSelection(loa.GetRowIndicesByValue(ColumnIndex, Null))
Public Sub GetRowIndicesNonNull(ColumnIndex As Object) As List
	Return NegateRowsSelection(GetRowIndicesByValue(ColumnIndex, Null))
End Sub

'Returns a list with the indices of rows where the specified column matches the given value. Note that the value type must be exact. Use As to cast if needed.
'Use GroupBy or GetRowIndices for more options and when searching for multiple values.
Public Sub GetRowIndicesByValue(ColumnIndex As Object, Value As Object) As List
	ColumnIndex = ColumnIndexToOrdinal(ColumnIndex)
	Dim res As List = B4XCollections.CreateList(Null)
	If Value = Null Then
		For i = 0 To getSize - 1
			Dim row() As Object = GetRow(i)
			If row(ColumnIndex) = Null Then
				res.Add(i)
			End If
		Next
	Else
		For i = 0 To getSize - 1
			Dim row() As Object = GetRow(i)
			If Value = row(ColumnIndex) Then
				res.Add(i)
			End If
		Next
	End If
	Return res
End Sub

'Returns a LOA with all rows where the specified column matches the given value. Note that the value type must be exact. Use As to cast if needed.
'The row arrays are reused.
'Use GroupBy or GetRowIndices for more options and when searching for multiple values.
'Same as calling LOA.GetRows(LOA.GetRowIndicesByValue(...)).
Public Sub GetRowsByValue (ColumnIndex As Object, Value As Object) As ListOfArrays
	Return GetRows(GetRowIndicesByValue(ColumnIndex, Value))
End Sub


Private Sub CopyRow(Row() As Object, NumericIndices As List) As Object()
	Dim val(NumericIndices.Size) As Object
	For i = 0 To val.Length - 1
		val(i) = Row(NumericIndices.Get(i))
	Next
	Return val
End Sub

'Removes a column from the table.
Public Sub RemoveColumn(Index As Object)
	Dim indices As List = getColumnIndices
	indices.RemoveAt(ColumnIndexToOrdinal(Index))
	For i = 0 To mInternalArray.Size - 1
		mInternalArray.Set(i, CopyRow(mInternalArray.Get(i), indices))
	Next
	InternalUpdateIndicesMap
End Sub

Private Sub ObjectIndicesToIntIndices(Indices As List) As List
	If NotInitialized(Indices) Then Return B4XCollections.GetEmptyList
	If getFirstRowIsHeader = False Then Return Indices
	Dim NumericValueIndices As List = B4XCollections.CreateList(Null)
	For Each ox As Object In Indices
		Dim ix As Int = mIndicesMap.GetDefault(ox, -1)
		If ix = -1 Then ix = mIndicesMap.GetDefault(ox.As(String).ToLowerCase, -1)
		If ix = -1 Then ThrowError("Index not found: " & ox)
		NumericValueIndices.Add(ix)
	Next
	Return NumericValueIndices
End Sub

'Creates a new table based on the given indices. Set the order of indices as needed. Duplicates are allowed.
Public Sub ToListOfArrays(ColumnIndices As List) As ListOfArrays
	ColumnIndices = ObjectIndicesToIntIndices(ColumnIndices)
	Dim New As List
	New.Initialize
	For Each row() As Object In mInternalArray
		New.Add(CopyRow(row, ColumnIndices))
	Next
	Dim n As ListOfArrays
	n.Initialize(New)
	n.FirstRowIsHeader = getFirstRowIsHeader
	Return n
End Sub

'Returns a list of maps, one map per data row.
'Each map uses the column headers as keys and the row values as values.
Public Sub ToListOfMaps As List
	If getFirstRowIsHeader = False Then ThrowError("Headers must be set")
	Dim h() As Object = getHeader
	Dim res As List = B4XCollections.CreateList(Null)
	For i = mFirstDataRowIndex To mInternalArray.Size - 1
		Dim row() As Object = mInternalArray.Get(i)
		Dim m As Map = CreateMap()
		For c = 0 To row.Length - 1
			m.Put(h(c), row(c))
		Next
		res.Add(m)
	Next
	Return res
End Sub

'Returns a string representation of the table.
'MaxNumberOfRows - Maximum rows to print. Pass 0 to print all.
Public Sub ToString (MaxNumberOfRows As Int) As String
	Dim sb As StringBuilder
	sb.Initialize
	If MaxNumberOfRows > 0 And getFirstRowIsHeader Then MaxNumberOfRows = MaxNumberOfRows + 1
	For i = 0 To Min(IIf(MaxNumberOfRows > 0, MaxNumberOfRows, mInternalArray.Size), mInternalArray.Size) - 1
		Dim row() As Object = mInternalArray.Get(i)
		If i > 0 Then sb.Append(CRLF)
		For r = 0 To row.Length - 1
			If r > 0 Then sb.Append(TAB)
			Dim s As String = row(r)
			If i >= mFirstDataRowIndex And s.Length > 20 Then s = s.SubString2(0, 20) & "..."
			sb.Append(s)
		Next
		If i = 0 Then
			sb.Append(" (#rows=").Append(getSize).Append(", #cols=").Append(getNumberOfColumns).Append(")")
			If getFirstRowIsHeader Then sb.Append(CRLF).Append("----------------------------- ")
		End If
	Next 
	Return sb.ToString
End Sub

'Sorts the table based on the given index. The column must be a column of numbers or strings.
Public Sub Sort (ColumnIndex As Object, Ascending As Boolean)
	If getIsEmpty Then Return
	ColumnIndex = ColumnIndexToOrdinal(ColumnIndex)
	Dim ListToSort As List
	If getFirstRowIsHeader Then
		#if B4J
		ListToSort = B4XCollections.CreateList(IterateRows)
		#else
		ListToSort = IterateRows
		#End If
	Else
		ListToSort = mInternalArray
	End If
	#if B4A or B4J
	Dim ListOfArraysComparator As JavaObject
	Dim row() As Object = ListToSort.Get(0)
	ListOfArraysComparator.InitializeNewInstance(GetType(Me) & "$ListOfArrays", Array(ColumnIndex, Ascending, row(ColumnIndex)))
	Dim collections As JavaObject
	collections.InitializeStatic("java.util.Collections")
	collections.RunMethod("sort", Array(ListToSort, ListOfArraysComparator))
	#else if B4i
	Me.as(NativeObject).RunMethod("sortArray:::", Array(ListToSort, ColumnIndex, Ascending))
	#end if
	If getFirstRowIsHeader Then
		For i = 0 To ListToSort.Size - 1
			mInternalArray.Set(mFirstDataRowIndex + i, ListToSort.Get(i))
		Next
	End If
End Sub

#if Java
public static void raiseException(String message) {
	throw new java.lang.RuntimeException(message);
}

public static class ListOfArrays implements java.util.Comparator<Object[]> {
	final int index;
	final boolean ascending;
	final boolean isNumber;
	public ListOfArrays(int index, boolean ascending, Object firstItem) {
		this.index = index;
		this.ascending = ascending;
		this.isNumber = firstItem instanceof Number;
	}
@Override
	public int compare(Object[] o1, Object[] o2) {
		int r;
		if (isNumber)
			r = Double.compare(((Number)o1[index]).doubleValue(), ((Number)o2[index]).doubleValue());
		else
			r = ((Comparable)o1[index]).compareTo((Comparable)o2[index]);
		return ascending ? r : -r;
	}
}
#End If

#if OBJC
- (void) sortArray:(NSMutableArray*)items :(int)index :(BOOL)ascending {
	B4IArray* firstItem = items[0];
	BOOL isNumber = [firstItem.objectsData[index] isKindOfClass:[NSNumber class]];
	NSStringCompareOptions mask = (NSStringCompareOptions)0;
	[items sortUsingComparator:^NSComparisonResult(B4IArray* a, B4IArray* b) {
			NSComparisonResult r;
			if (isNumber)
				r = [(NSNumber*)a.objectsData[index] compare:(NSNumber*)b.objectsData[index]];
			else
				r = [(NSString *)a.objectsData[index] compare:(NSString *)b.objectsData[index] options:mask];
		
		return ascending ? r : -r;
	 }];
}
#End If