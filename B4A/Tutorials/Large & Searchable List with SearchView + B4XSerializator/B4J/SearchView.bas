Type=Class
Version=4.01
ModulesStructureVersion=1
B4J=true
@EndOfDesignText@
'version 1.00
'Class module
Sub Class_Globals
	Private prefixList As Map
	Private substringList As Map
	Private MIN_LIMIT, MAX_LIMIT As Int
	MIN_LIMIT = 2
	MAX_LIMIT = 4 'doesn't limit the words length. Only the index.
	Private allItems As List
End Sub

Public Sub Initialize 
	prefixList.Initialize
	substringList.Initialize
End Sub


'Builds the index and returns an object which you can store as a process global variable
'in order to avoid rebuilding the index when the device orientation changes.
Public Sub SetItems(Items As List) As Object()
	allItems = Items
	Dim startTime As Long 
	startTime = DateTime.Now
	Dim noDuplicates As Map
	noDuplicates.Initialize
	prefixList.Clear
	substringList.Clear
	Dim m As Map
	Dim li As List
	For i = 0 To Items.Size - 1
		Dim item As String
		item = Items.Get(i)
		item = item.ToLowerCase
		noDuplicates.Clear
		For start = 0 To item.Length
			Dim count As Int
			count = MIN_LIMIT
			Do While count <= MAX_LIMIT And start + count <= item.Length
				Dim str As String
				str = item.SubString2(start, start + count)
				If noDuplicates.ContainsKey(str) = False Then 
					noDuplicates.Put(str, "")
					If start = 0 Then m = prefixList Else m = substringList
					li = m.Get(str)
					If li.IsInitialized = False Then
						li.Initialize
						m.Put(str, li)
					End If
					li.Add(i) 'Preserve the original case
				End If
				count = count + 1
			Loop
		Next
	Next
	Log("Index time: " & (DateTime.Now - startTime) & " ms (" & Items.Size & " Items)")
	Return Array As Object(allItems, prefixList, substringList)
End Sub

