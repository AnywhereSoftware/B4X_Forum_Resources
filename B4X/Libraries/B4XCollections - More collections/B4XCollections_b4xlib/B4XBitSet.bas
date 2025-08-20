B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
Sub Class_Globals
	#if B4i
	Private data() As Byte
	#else
	Private data() As Int
	#End If
	Private mSize As Int
End Sub

Public Sub Initialize (Size As Int)
	mSize = Size
	Clear
End Sub

'Sets the value of the bit at the specified index.
Public Sub Set(Index As Int, Value As Boolean)
	Dim dindex As Int = Bit.ShiftRight(Index, 5)
	Dim offset As Int = Bit.And(0x0000001f, Index)
	#if B4i
	Dim BlockValue As Int = Bit.FastArrayGetInt(data, dindex)
	#else
	Dim BlockValue As Int = data(dindex)
	#End If
	Dim NewBlockValue As Int
	If Value Then
		NewBlockValue = Bit.Or(BlockValue, Bit.ShiftLeft(1, offset))
	Else
		NewBlockValue = Bit.And(BlockValue, Bit.Not(Bit.ShiftLeft(1, offset)))
	End If
	#if B4i
	Bit.FastArraySetInt(data, dindex, NewBlockValue)
	#else
	data(dindex) = NewBlockValue
	#End If
End Sub

'Gets the value of the bit at the specified index.
Public Sub Get(Index As Int) As Boolean
	Dim dindex As Int = Bit.ShiftRight(Index, 5)
	Dim offset As Int = Bit.And(0x0000001f, Index)
	#if B4i
	Dim BlockValue As Int = Bit.FastArrayGetInt(data, dindex)
	#else
	Dim BlockValue As Int = data(dindex)
	#End If
	Return Bit.And(BlockValue, Bit.ShiftLeft(1, offset)) <> 0
End Sub
'Returns the BitSet size.
Public Sub getSize As Int
	Return mSize
End Sub

'Clears the BitSet.
Public Sub Clear
	#if B4i
	Dim data(4 * (Bit.ShiftRight(mSize, 5) + 1)) As Byte
	#else
	Dim data(Bit.ShiftRight(mSize, 5) + 1) As Int
	#End If
End Sub