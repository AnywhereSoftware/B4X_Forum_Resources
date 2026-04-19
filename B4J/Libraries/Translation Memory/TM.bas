B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private db As TMDB
	Private mSourceLang As String
	Private mTargetLang As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(dir As String,filename As String,sourceLang As String,targetLang As String)
	db.Initialize(dir,filename,sourceLang,targetLang)
	mSourceLang = sourceLang
	mTargetLang = targetLang
End Sub

Public Sub Clear
	db.DeleteAll
End Sub

Public Sub Import(paths As List)
	Dim tmMap As Map
	tmMap.Initialize
	For Each path As String In paths
		path = path.ToLowerCase
		If path.EndsWith("csv") Then
			Dim parser As CSVParser
			parser.Initialize
			Dim list1 As List = parser.Parse(File.ReadString(File.DirApp,"data.csv"),",",True)
			For Each row() As String In list1
				LoadRowToTMMap(row,tmMap)
			Next
		else if path.EndsWith("txt") Then
			 For Each line As String In Regex.Split(CRLF,File.ReadString(path,""))
			     Dim row() As String = Regex.Split("\t",line)
				LoadRowToTMMap(row,tmMap)
			 Next
		else if path.EndsWith("tmx") Then
			Dim importer As TMXImporter
			importer.Initialize
			Dim list1 As List = importer.importedList(path,"",mSourceLang,mTargetLang)
			For Each segment As List In list1
				LoadListToTMMap(segment,tmMap)
			Next
		End If
	Next
	db.PutWithTransaction(tmMap)
End Sub


Private Sub LoadListToTMMap(list1 As List,tmMap As Map)
	Dim source As String = list1.Get(0)
	Dim target As String = list1.Get(1)
	Dim note As String
	If list1.Size > 2 Then
		note = list1.Get(2)
	End If
	Dim targetList As List
	If tmMap.ContainsKey(source) Then
		targetList = tmMap.Get(source)
	Else
		targetList.Initialize
		tmMap.Put(source,targetList)
	End If
	Dim targetMap As Map
	targetMap.Initialize
	targetMap.Put("text",target)
	targetMap.Put("note",note)
	targetList.Add(targetMap)
End Sub

Private Sub LoadRowToTMMap(row() As String,tmMap As Map)
	Dim source As String = row(0)
	Dim target As String = row(1)
	Dim note As String
	If row.Length > 2 Then
		note = row(2)
	End If
	Dim targetList As List
	If tmMap.ContainsKey(source) Then
		targetList = tmMap.Get(source)
	Else
		targetList.Initialize
		tmMap.Put(source,targetList)
	End If
	Dim targetMap As Map
	targetMap.Initialize
	targetMap.Put("text",target)
	targetMap.Put("note",note)
	targetList.Add(targetMap)
End Sub

Public Sub GetMatchedMap(text As String,isSource As Boolean,matchAll As Boolean) As ResumableSub
	wait for (db.GetMatchedMapAsync(text,isSource,matchAll,100)) complete (done As Map)
	Return done
End Sub

public Sub getMatchList(source As String,matchrate As Double,getOne As Boolean,limit As Int) As ResumableSub
	Dim matchList As List
	matchList.Initialize
	Dim kvs As TMDB = db
	
	Dim matchedMap As Map
	If kvs.ContainsKey(source) And getOne Then
		matchedMap.Initialize
		matchedMap.Put(source,kvs.Get(source))
	Else if matchrate<1 Then 'fuzzy match
		wait for (kvs.GetMatchedMapAsync(source,True,False,limit)) Complete (resultMap As Map)
		matchedMap=resultMap
	Else
		Return matchList
	End If

	source=source.ToLowerCase.Trim
	For Each key As String In matchedMap.Keys
		Dim lowerCased As String=key.ToLowerCase.Trim
		If basicCompare(source,lowerCased)=False Then
			Continue
		End If

		Dim similarity As Double
		If lowerCased=source Then 'exact match
			similarity=1.0
		Else
			wait for (editDistance.getSimilarity(source,lowerCased)) Complete (Result As Double)
			similarity=Result
		End If

		If similarity>=matchrate Then

			Dim targetList As List = kvs.Get(key)

			For Each targetMap As Map In targetList
				Dim target As String
				Dim tmPairList As List
				tmPairList.Initialize
				tmPairList.Add(similarity)
				tmPairList.Add(key)
				target=targetMap.Get("text")
				Dim note As String
				note=targetMap.Get("note")
				tmPairList.Add(target)
				tmPairList.Add(note)
				matchList.Add(tmPairList)
			Next
			
			If getOne Then
				Return matchList
			End If
		End If
	Next
	Return subtractedAndSortMatchList(matchList,limit)
End Sub

Sub basicCompare(str1 As String,str2 As String) As Boolean
	Dim temp As String
	If str1.Length>str2.Length Then
		temp=str1
		str1=str2
		str2=temp
	End If
	If str1.Length-str2.Length>str2.Length/2 Then
		Return False
	Else
		Return True
	End If
End Sub

Sub subtractedAndSortMatchList(matchList As List,maxNum As Int) As List
	If matchList.Size<=1 Then
		Return matchList
	End If
	Dim newlist As List
	newlist.Initialize
	Dim sortedList As List
	sortedList=BubbleSort(matchList)
	For i=0 To Min(maxNum,sortedList.Size-1)
		newlist.Add(sortedList.Get(i))
	Next
	Return newlist
End Sub

Sub BubbleSort(matchList As List) As List
	For j=0 To matchList.Size-1
		For i = 1 To matchList.Size - 1
			If  NextIsMoreSimilar(matchList.Get(i),matchList.Get(i-1)) Then
				matchList=Swap(matchList,i, i-1)
			End If
		Next
	Next
	Return matchList
End Sub

Sub Swap(matchList As List,index1 As Int, index2 As Int) As List
	Dim temp As List
	temp = matchList.Get(index1)
	matchList.Set(index1,matchList.Get(index2))
	matchList.Set(index2,temp)
	Return matchList
End Sub

Sub NextIsMoreSimilar(list2 As List,list1 As List) As Boolean
	'list2 is the next
	If list2.Get(0)>list1.Get(0) Then
		Return True
	Else
		Return False
	End If
End Sub