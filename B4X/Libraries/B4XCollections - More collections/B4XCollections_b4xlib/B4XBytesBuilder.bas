B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
Sub Class_Globals
	Private mBuffer() As Byte
	Private mLength As Int
End Sub

Public Sub Initialize
	Dim mBuffer(100) As Byte
	mLength = 0
End Sub

'returns the old length
Private Sub ChangeLength (NewLength As Int) As Int
	Dim OldLength As Int = mLength
	mLength = NewLength
	If mBuffer.Length < mLength Then
		Dim b(Max(mBuffer.Length * 2, NewLength)) As Byte
		Bit.ArrayCopy(mBuffer, 0, b, 0, mBuffer.Length)
		mBuffer = b
	End If
	Return OldLength
End Sub

'Adds data. The data will be appended to the currently stored data.
Public Sub Append(Data() As Byte) As B4XBytesBuilder
	Return Append2(Data, 0, Data.Length)
End Sub

'Adds data. The data will be appended to the currently stored data.
'StartIndex - Index of the first byte to be copied.
'Length - Number of bytes to copy.
Public Sub Append2(Data() As Byte, StartIndex As Int, Length As Int) As B4XBytesBuilder
	Dim OldLength As Int = ChangeLength(mLength + Length)
	Bit.ArrayCopy(Data, StartIndex, mBuffer, OldLength, Length)
	Return Me
End Sub

Public Sub Clear
	ChangeLength(0)
End Sub

'Inserts data at the specified index.
'Existing data will not be replaced, just pushed.
Public Sub Insert(Index As Int, Data() As Byte)
	If Index >= mLength Then
		If Index > mLength Then Log("Index too large")
		Append(Data)
	Else
		Dim AfterIndex() As Byte = SubArray(Index)
		ChangeLength(mLength + Data.Length)
		Bit.ArrayCopy(Data, 0, mBuffer, Index, Data.Length)
		Bit.ArrayCopy(AfterIndex, 0, mBuffer, Index + Data.Length, AfterIndex.Length)
	End If
End Sub

'Puts the data in the given index. Unlike Insert this method will replace existing data.
Public Sub Set(Index As Int, Data() As Byte)
	If Index >= mLength Then
		If Index > mLength Then Log("Index too large")
		Append(Data)
	Else
		If Data.Length + Index > mLength Then
			ChangeLength(Data.Length + Index)
		End If
		Bit.ArrayCopy(Data, 0, mBuffer, Index, Data.Length)
	End If
End Sub

'Removes a section from the store. Returns the removed data.
Public Sub Remove(BeginIndex As Int, EndIndex As Int) As Byte()
	Dim res() As Byte = SubArray2(BeginIndex, EndIndex)
	If EndIndex <= mLength Then
		Dim AfterEndIndex() As Byte = SubArray(EndIndex)
		Bit.ArrayCopy(AfterEndIndex, 0, mBuffer, BeginIndex, AfterEndIndex.Length)
	End If
	ChangeLength(mLength - (EndIndex - BeginIndex))
	Return res
End Sub

'Similar to String.Substring. Returns a copy of the data starting from BeginIndex.
Public Sub SubArray(BeginIndex As Int) As Byte()
	Return SubArray2(BeginIndex, mLength)
End Sub

'Similar to String.Substring2. Returns a copy of the data starting from BeginIndex
'and up to EndIndex (EndIndex byte is excluded).
Public Sub SubArray2(BeginIndex As Int, EndIndex As Int) As Byte()
	Dim b(EndIndex - BeginIndex) As Byte
	Bit.ArrayCopy(mBuffer, BeginIndex, b, 0, b.Length)
	Return b
End Sub

Public Sub getLength As Int
	Return mLength
End Sub

'Returns a copy of the stored data.
Public Sub ToArray() As Byte()
	Return SubArray(0)
End Sub

'Change to public if you want to access the buffer directly.
'Remember that the buffer includes data beyond the currently stored data.
Private Sub getBuffer As Byte() 'ignore
End Sub

'Similar to String.IndexOf. Searches for the given data and returns its index or -1 if not found.
Public Sub IndexOf(SearchFor() As Byte) As Int
	Return IndexOf2(SearchFor, 0)
End Sub

'Similar to String.IndexOf2. Searches for the given data starting from the given index.
Public Sub IndexOf2(SearchFor() As Byte, Index As Int) As Int
	For i1 = Index To mLength - SearchFor.Length
		For i2 = 0 To SearchFor.Length - 1
			If SearchFor(i2) <> mBuffer(i1 + i2) Then
				Exit	
			End If
		Next
		If i2 = SearchFor.Length Then
			Return i1
		End If
	Next
	Return -1
End Sub

'Returns a reference to the internal buffer.
Public Sub getInternalBuffer As Byte()
	Return mBuffer
End Sub



