B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.45
@EndOfDesignText@
Sub Class_Globals
	Public CurrentIndex As Int
	Private mCollectedValues As List
	Private mLOA As ListOfArrays
	Private mROW() As Object
End Sub

'Use ListOfArrays.CreateLOASet
Public Sub Initialize (loa As ListOfArrays)
	CurrentIndex = -1
	mCollectedValues.Initialize
	mLOA = loa
End Sub

'Moves to the next row.
'Returns True if the new current row is valid.
Public Sub NextRow As Boolean
	CurrentIndex = CurrentIndex + 1
	If CurrentIndex < mLOA.Size Then
		mROW = mLOA.GetRow(CurrentIndex)
		Return True
	Else
		Dim mROW() As Object
		Return False
	End If
End Sub

'Returns the current row.
Public Sub getRow As Object()
	Return mROW
End Sub

'Returns the value stored in the specified column of the current row.
Public Sub GetValue(ColumnIndex As Object) As Object
	Return mROW(mLOA.ColumnIndexToOrdinal(ColumnIndex))
End Sub

'Returns the value stored in the specified column of the current row. Returns the DefaultValue is the stored value is Null.
Public Sub GetValueDefault(ColumnIndex As Object, DefaultValue As Object) As Object
	Dim o As Object = GetValue(ColumnIndex)
	Return IIf(o = Null, DefaultValue, o)
End Sub

'Sets the value of the specified column.
Public Sub SetValue(ColumnIndex As Object, Value As Object)
	mROW(mLOA.ColumnIndexToOrdinal(ColumnIndex)) = Value
End Sub

'Adds the current row index to CollectedValues.
'Same as calling CollectValue(LOASet.CurrentIndex).
Public Sub CollectIndex
	mCollectedValues.Add(CurrentIndex)
End Sub

'Returns the list of values collected with CollectIndex or CollectValue methods.
Public Sub getCollectedValues As List
	Return mCollectedValues
End Sub

'Adds the value to CollectedValues.
Public Sub CollectValue (Value As Object)
	mCollectedValues.Add(Value)
End Sub

'Returns True if the current row is the first row.
Public Sub getIsFirst As Boolean
	Return CurrentIndex = 0
End Sub

'Returns True if the current row is the last row.
Public Sub getIsLast As Boolean
	Return CurrentIndex = mLOA.Size - 1
End Sub
