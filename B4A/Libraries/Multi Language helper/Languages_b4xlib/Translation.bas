B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Private flName As String = "translation.txt"
	Private trFile As String
	Private lstLanguages As List
	Private lstWords As List
	Private lang As Map
	Private mWords As Map
End Sub


Public Sub Initialize
	trFile  = File.ReadString(File.DirAssets, flName)
	lstLanguages.Initialize
	lang.Initialize
	lstLanguages = getLanguages
	
	lstWords = LoadRawTranslation
	mWords.Initialize
	convertToMap(lstWords)
End Sub


'Get all File in one string And check onε by one each character of string
'Seperate words based on ; charachter
Private Sub LoadRawTranslation As List
	Private retList As List
	retList.Initialize
	Private size As Int = getLanguages.Size+1
	Private words(size) As String
	Private rowCounter As Int = 0
	Private i As Int = 0
	
	For j = 0 To trFile.Length-1
		If trFile.CharAt(j) <> ";" And trFile.CharAt(j) <> CRLF Then
			If rowCounter > 0 Then
				words(i) = words(i) & trFile.CharAt(j)
			End If
		Else if trFile.CharAt(j) = ";" Then
			i = i + 1
		else if trFile.CharAt(j) = CRLF Then
			If rowCounter > 0 Then
				retList.Add(words)
			End If
			i = 0
			rowCounter = rowCounter + 1
			Dim words(size) As String
		End If
	Next
	retList.Add(words)
	Return retList
End Sub


'Returning a list of languages set in file translation.txt 
Public Sub getLanguages As List
	Private i As Int = 0
	Private j As Int = 0
	Private retList As List
	Private word As String
	retList.Initialize
	
	Do While trFile.CharAt(j) <> CRLF
		If trFile.CharAt(j) <> ";" And trFile.CharAt(j) <> CRLF Then
			If i > 0 Then
				word = word  & trFile.CharAt(j)
			End If
			j = j + 1
		Else if trFile.CharAt(j) = ";" Then
			If i > 0 Then
				retList.Add(word)
				lang.Put(word, i)
				Private word As String
			End If
			i = i + 1
			j = j + 1
		End If
	Loop
	retList.Add(word)
	Return retList
End Sub


Private Sub convertToMap(l As List)
	Private size As Int = getLanguages.Size+1
	Private words(size) As String
	
	For i = 0 To l.Size-1
		words = l.Get(i)
		mWords.Put(words(0), words)
		Private words(size) As String
	Next
End Sub

'Return the word in a specific language
'Use getWord(key as String, word as String)
Public Sub getWord(k As String, l As String) As String
	Dim ar() As String  = mWords.Get(k)
	Dim index As Int = lang.Get(l)
	Return (ar(index))
End Sub


