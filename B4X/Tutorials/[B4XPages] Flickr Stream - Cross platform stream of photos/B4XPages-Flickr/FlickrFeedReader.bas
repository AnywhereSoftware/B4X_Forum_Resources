B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
Sub Class_Globals
	Type FlickrPhoto (Id As String, Secret As String, Title As String, Farm As String, ServerId As String)
	Public FlickrPhotos As List
	Public DownloadedPhotos As B4XOrderedMap
	Private Timer1 As Timer
	Private CurrentlyDownloadingIds As B4XSet
	Private API_KEY As String = "b2e49942769c914723424149a3d55ed2"
	Private const NUMBER_OF_PHOTOS_TO_KEEP As Int = 30
	Private MainPage As B4XMainPage
End Sub

Public Sub Initialize
	FlickrPhotos.Initialize
	DownloadedPhotos.Initialize
	CurrentlyDownloadingIds.Initialize
	Timer1.Initialize("Timer1", 100)
	DownloadFeed
	MainPage = B4XPages.MainPage
End Sub

Private Sub DownloadFeed
	Do While FlickrPhotos.Size = 0
		Dim j As HttpJob
		j.Initialize("", Me)
		j.Download($"https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=${API_KEY}&page=1&per_page=200&format=json&nojsoncallback=1"$)
		Wait For (j) JobDone (j As HttpJob)
		If j.Success Then
			ParseFeed(j.GetString)		
		End If
		j.Release
		Sleep(5000)
	Loop
End Sub

Private Sub ParseFeed(s As String)
	Dim parser As JSONParser
	parser.Initialize(s)
	Dim m As Map = parser.NextObject
	m = m.Get("photos")
	Dim list As List = m.Get("photo")
	For Each p As Map In list
		FlickrPhotos.Add(CreateFlickrPhoto(p.Get("id"), p.Get("secret"), p.Get("title"), p.Get("farm"), p.Get("server")))
	Next
End Sub

Private Sub Timer1_Tick
	If FlickrPhotos.Size = 0 Then Return
	Dim CurrentIndex As Int = MainPage.GetCurrentIndex
	For i = Max(0, CurrentIndex - 3) To Min(CurrentIndex + 3, FlickrPhotos.Size - 1)
		Dim item As FlickrPhoto = FlickrPhotos.Get(i)
		If DownloadedPhotos.ContainsKey(item.Id) Then
			Dim index As Int = DownloadedPhotos.Keys.IndexOf(item.Id)
			If index < DownloadedPhotos.Size - 10 Then
				'move it to the back of the list
				DownloadedPhotos.Keys.RemoveAt(index)
				DownloadedPhotos.Keys.Add(item.Id)
			End If
		Else If CurrentlyDownloadingIds.Contains(item.Id) = False Then 
			DownloadPhoto (item)			
		End If
	Next
End Sub

Private Sub DownloadPhoto(fp As FlickrPhoto)
	CurrentlyDownloadingIds.Add(fp.Id)
	'Log("download: " & fp.Id)
	Dim j As HttpJob
	j.Initialize("", Me)
	j.Download($"https://farm${fp.Farm}.staticflickr.com/${fp.ServerId}/${fp.Id}_${fp.Secret}_c.jpg"$)
	Wait For (j) JobDone (j As HttpJob)
	If j.Success Then
		DownloadedPhotos.Put(fp.Id, j.GetBitmap)
		TrimPhotosCache
		If Timer1.Enabled Then MainPage.NewPhotoAvailable
	End If
	j.Release
	CurrentlyDownloadingIds.Remove(fp.Id)
End Sub

Private Sub TrimPhotosCache
	Do While DownloadedPhotos.Size > NUMBER_OF_PHOTOS_TO_KEEP
		DownloadedPhotos.Remove(DownloadedPhotos.Keys.Get(0))
	Loop
End Sub

Public Sub Start
	Timer1.Enabled = True
End Sub

Public Sub Stop
	Timer1.Enabled = False
End Sub


Private Sub CreateFlickrPhoto (Id As String, Secret As String, Title As String, Farm As String, ServerId As String) As FlickrPhoto
	Dim t1 As FlickrPhoto
	t1.Initialize
	t1.Id = Id
	t1.Secret = Secret
	t1.Title = Title
	t1.Farm = Farm
	t1.ServerId = ServerId
	Return t1
End Sub