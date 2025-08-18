B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	Type TrieElement (Character As String, Children As List, Values As List)
	Public MaxIndexedLength As Int = 2
End Sub

Public Sub Initialize
	
End Sub

Public Sub BuildTrie (SortedItems As List) As TrieElement
	Dim n As Long = DateTime.Now
	Dim root As TrieElement = CreateTrieElement("")
	root.Children.Initialize
	Dim PathStack As List
	PathStack.Initialize
	For Each Item As String In SortedItems
		If Item.Length = 0 Then Continue
		
		Dim Lowercase As String = Item.ToLowerCase
		For i = 0 To Min(Lowercase.Length, MaxIndexedLength) - 1
			Dim c As String = Lowercase.CharAt(i)
			If PathStack.Size > i And PathStack.Get(i).As(TrieElement).Character = c Then
				
			Else
				'trim PathStack
				For p = PathStack.Size - 1 To i Step -1
					PathStack.RemoveAt(p)
				Next
				Dim parent As TrieElement = IIf(i = 0, root, PathStack.Get(i - 1))
				Dim NewElement As TrieElement = CreateTrieElement(c)
				parent.Children.Add(NewElement)
				PathStack.Add(NewElement)
			End If
			If i = Lowercase.Length - 1 Or i = MaxIndexedLength - 1 Then
				Dim LastElement As TrieElement = PathStack.Get(i)
				If LastElement.Values.IsInitialized = False Then LastElement.Values.Initialize
				LastElement.Values.Add(Item)
			End If
		Next
	Next
	Log($"Index size: ${SortedItems.Size}, time: ${DateTime.Now - n}ms"$)
	Return root
End Sub

Private Sub PrintPath (Path As List) 'ignore
	Dim sb As StringBuilder
	sb.Initialize
	For Each p As TrieElement In Path
		sb.Append(p.Character)
	Next
	Log(sb.ToString)
End Sub

Public Sub Test (root As TrieElement)
	Dim a As TrieElement = BinarySearch("a", root.Children)
	For Each t As TrieElement In a.Children
		Log(t.Character)
	Next
	Dim t As TrieElement = BinarySearch("t", a.Children)	
	PrintTrie(t)	
End Sub

Private Sub CollectResults(Parent As TrieElement, LowercaseFullQuery As String, Result As List)
	If Parent.Values.IsInitialized Then
		For Each value As String In Parent.Values
			If value.ToLowerCase.StartsWith(LowercaseFullQuery) Then Result.Add(value)
		Next
	End If
	For Each element As TrieElement In Parent.Children
		CollectResults(element, LowercaseFullQuery, Result)
	Next
End Sub

Private Sub PrintTrie (Root As TrieElement) 'ignore
	If Root.Values.IsInitialized Then
		Log(Root.Values) 'ignore
	End If
	For Each element As TrieElement In Root.Children
		PrintTrie(element)
	Next
End Sub

Public Sub GetAllPrefixMatches(Query As String, TrieRoot As TrieElement) As List
	Dim LowercaseAndTrimmed As String = IIf(Query.Length > MaxIndexedLength, Query.SubString2(0, MaxIndexedLength), Query).As(String).ToLowerCase
	Dim e As TrieElement = GetFromPrefix(LowercaseAndTrimmed, TrieRoot)
	Dim result As List
	result.Initialize
	If e <> Null Then
		CollectResults(e, Query.ToLowerCase, result)
	End If
	Return result
End Sub

Private Sub GetFromPrefix(Prefix As String, TrieRoot As TrieElement) As TrieElement
	Dim e As TrieElement = TrieRoot
	For i = 0 To Prefix.Length - 1
		e = BinarySearch(Prefix.CharAt(i), e.Children)
		If e = Null Then Return Null
	Next
	Return e
End Sub

Private Sub BinarySearch(Character As String, Children As List) As TrieElement
	Dim begin As Int = 0
	Dim last As Int = Children.Size - 1
	Dim mid As Int
	Do While begin <= last
		mid = (begin + last) / 2
		Dim CompareResult As Int = Children.Get(mid).As(TrieElement).Character.CompareTo(Character)
		If CompareResult < 0 Then
			begin = mid + 1
		Else If CompareResult > 0 Then
			last = mid - 1
		Else
			Return Children.Get(mid)
		End If
	Loop
	Return Null
End Sub


Private Sub CreateTrieElement (Character As String) As TrieElement
	Dim t1 As TrieElement
	t1.Initialize
	t1.Character = Character
	t1.Children.Initialize
	Return t1
End Sub
