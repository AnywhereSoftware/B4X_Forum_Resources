B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
	Type B4XCacheItem (Value As Object, LastAccessedTime As Long, Key As String, Eternal As Boolean)
	Private Data As B4XOrderedMap
	Private mMaxSize As Int = 100
	Private RemoveThreshold As Float = 0.3
	Private EternalCounts As Int
End Sub

Public Sub Initialize
	Data.Initialize
End Sub

'Gets or sets the maximum cache size.
Public Sub setMaxSize(s As Int)
	mMaxSize = s
	TrimIfOversize
End Sub

Public Sub getMaxSize As Int
	Return mMaxSize
End Sub

'Gets an item from the cache. Returns Null if the key doesn't exist.
Public Sub Get (Key As String) As Object
	Dim ci As B4XCacheItem = Data.Get(Key)
	If ci <> Null Then
		If ci.Eternal = False Then ci.LastAccessedTime = DateTime.Now
		Return ci.Value
	End If
	Return Null
End Sub

'Puts an iten in the cache. The cache will be trimmed if it is larger than MaxSize.
'The Value is returned.
Public Sub Put (Key As String, Value As Object) As Object
	If IsEternal(Key) Then EternalCounts = EternalCounts - 1
	Data.Put(Key, CreateB4XCacheItem(Value, Key))
	TrimIfOversize
	Return Value
End Sub

'Adds an "eternal" item to the cache. The item will not be removed automatically and will not affect the size limit.
'The Value is returned.
Public Sub PutEternal (Key As String, Value As Object) As Object
	If IsEternal(Key) Then EternalCounts = EternalCounts - 1
	Dim ci As B4XCacheItem = CreateB4XCacheItem(Value, Key)
	ci.Eternal = True
	ci.LastAccessedTime = 9223372036854775807
	EternalCounts = EternalCounts + 1
	Data.Put(Key, ci)
	Return Value
End Sub

'Removes an item from the cache.
Public Sub Remove (Key As String)
	If IsEternal(Key) Then EternalCounts = EternalCounts - 1
	Data.Remove(Key)
End Sub

Private Sub IsEternal(Key As String) As Boolean
	Dim ci As B4XCacheItem = Data.Get(Key)
	Return IIf(ci = Null, False, ci.Eternal)
End Sub

'Returns True if the key exists.
Public Sub ContainsKey(Key As String) As Boolean
	Return Data.ContainsKey(Key)
End Sub

Private Sub TrimIfOversize
	If Data.Size - EternalCounts > mMaxSize Then
		Dim values As List = Data.Values
		values.SortType("LastAccessedTime", True)
		Dim NumberOfItemsToRemove As Int = Ceil(mMaxSize * RemoveThreshold)
		For i = 0 To NumberOfItemsToRemove
			Data.Remove(values.Get(i).As(B4XCacheItem).Key)
		Next
	End If
End Sub

'Removes items that weren't accessed in the last AgeMs milliseconds.
Public Sub RemoveOldItems (AgeMs As Long)
	Dim values As List = Data.Values
	Dim level As Long = DateTime.Now - AgeMs
	For Each ci As B4XCacheItem In values
		If ci.LastAccessedTime <= level Then
			Data.Remove(ci.Key)
		End If
	Next
End Sub

'Returns the cache size.
Public Sub Size As Int
	Return Data.Size
End Sub

'Returns the cache keys. Don't modify this list as it is not copied.
Public Sub Keys As List
	Return Data.Keys
End Sub

Private Sub CreateB4XCacheItem (Value As Object, Key As String) As B4XCacheItem
	Dim t1 As B4XCacheItem
	t1.Initialize
	t1.Value = Value
	t1.LastAccessedTime = DateTime.Now
	t1.Key = Key
	Return t1
End Sub