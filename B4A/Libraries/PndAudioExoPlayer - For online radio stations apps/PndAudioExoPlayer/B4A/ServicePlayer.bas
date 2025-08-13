B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=11.45
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False	
#End Region

Sub Process_Globals
	Private PndAudioExoPlayer1 As PndAudioExoPlayer
	Private AlbumArt1 As Bitmap
	Private AlbumArt2 As Bitmap
	Private AlbumArt3 As Bitmap
	Private SongName As String
	Private StationName As String
	Private ExampleStreams As Map
	Private ExampleAlbumArt As Map
	Private CurentStationId As Int = 1
	Private NotifImage As Bitmap
	Private PhoneWakeState1 As PhoneWakeState
End Sub

Sub Service_Create
	PndAudioExoPlayer1.Initialize("PndAudioExoPlayer1", "MyAppUserAgent/1.0", True, True)
	PndAudioExoPlayer1.Volume = 1.0
	
	ExampleStreams.Initialize ' example for 3 different radio stations
	ExampleStreams.Put(1, "https://metal-hammer.stream.laut.fm/metal-hammer")
	ExampleStreams.Put(2, "https://kathy.torontocast.com:2820/stream/1/")
	ExampleStreams.Put(3, "http://192.95.18.39:5784/stream/1/")

	AlbumArt1.Initialize(File.DirAssets, "art1.jpg")
	AlbumArt2.Initialize(File.DirAssets, "art2.jpg")
	AlbumArt3.Initialize(File.DirAssets, "art3.jpg")
	
	ExampleAlbumArt.Initialize ' example for 3 different album arts
	ExampleAlbumArt.Put(1, AlbumArt1)
	ExampleAlbumArt.Put(2, AlbumArt2)
	ExampleAlbumArt.Put(3, AlbumArt3)
	
	NotifImage = LoadBitmapResize(File.DirAssets, "smiley.png", 24dip, 24dip, False)
	
	Log("AudioSessionId: " & PndAudioExoPlayer1.AudioSessionId)
End Sub

Sub Service_Start (StartingIntent As Intent)
	Dim n As NB6
	n.Initialize("default", Application.LabelName, "LOW").SmallIcon(NotifImage).AutoCancel(False)
	n.AddButtonAction(NotifImage, "Stop", StopPlayer, "stop")
	Dim Noti As Notification = n.Build("PndAudioExoplayer", "Example", "tag", Main)
	Service.AutomaticForegroundMode = Service.AUTOMATIC_FOREGROUND_ALWAYS
	Service.StartForeground(1, Noti)
	Noti.Notify(1)
	PhoneWakeState1.PartialLock
End Sub

Sub Service_Destroy
	PhoneWakeState1.ReleasePartialLock
	PndAudioExoPlayer1.Release
End Sub

Sub UpdateNotification (NotifiSongName As String, NotifiRadioName As String)
	Dim n As NB6
	n.Initialize("default", Application.LabelName, "LOW").SmallIcon(NotifImage).AutoCancel(False)
	n.AddButtonAction(NotifImage, "Stop", StopPlayer, "stop")
	Dim Noti As Notification = n.Build(NotifiRadioName, NotifiSongName, "tag", Main)
	Noti.Notify(1)	
End Sub


Sub Play
	'ProgressiveMediaSource - for MPEG (MP3), AAC, OGG streams
	PndAudioExoPlayer1.ProgressiveMediaSource(ExampleStreams.Get(CurentStationId))
	'HlsMediaSource - for HLS streams (stream Url ends with .m3u8) - usually PndAudioExoPlayer1_OnMetadata will not fire with HLS streams as there is no metadata
	'PndAudioExoPlayer1.HlsMediaSource("https://stream.radiofrance.fr/francemusique/francemusique.m3u8") 
	PndAudioExoPlayer1.Play
End Sub

Sub Stop
	PndAudioExoPlayer1.Stop
	UpdateNotification("Example", "PndAudioExoplayer")
End Sub

Sub PreviousStation
	CurentStationId = CurentStationId - 1
	If CurentStationId < 1 Then CurentStationId = 3
	Play
End Sub

Sub NextStation
	CurentStationId = CurentStationId + 1
	If CurentStationId > 3 Then CurentStationId = 1
	Play
End Sub

Sub IsPlayerPlaying As Boolean
	Return PndAudioExoPlayer1.IsPlaying
End Sub

Sub SetPlayerVolume(Volume As Float)
	PndAudioExoPlayer1.Volume = Volume
	Log("Volume: " & PndAudioExoPlayer1.Volume)
End Sub

Private Sub PndAudioExoPlayer1_OnAudioSessionIdChanged (AudioSessionId As Int)
	Log("OnAudioSessionIdChanged AudioSessionId: " & AudioSessionId)
End Sub

Private Sub PndAudioExoPlayer1_OnIsPlayingChanged (IsPlaying As Boolean)
	Log("OnIsPlayingChanged IsPlaying: " & IsPlaying)
End Sub
	
Private Sub PndAudioExoPlayer1_OnMetadata (Metadata As String)
	Log("OnMetadata Metadata: " & Metadata)
	Try
		Dim tStart As Int = Metadata.IndexOf("title=")
		Dim tEnd As Int = Metadata.IndexOf2("""", tStart + 7)
		SongName = Metadata.SubString2(tStart + 7, tEnd)
		B4XPages.MainPage.lblSong.Text = "Song name:" & CRLF & SongName
		PndAudioExoPlayer1.UpdateMediaSession(SongName, StationName, ExampleAlbumArt.Get(CurentStationId))
		UpdateNotification(SongName, StationName)
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub PndAudioExoPlayer1_OnPlaybackStateChanged (PlaybackState As Int)
	Log("OnPlaybackStateChanged PlaybackState: " & PlaybackState)
	' PlaybackState = 1 - Idle
	' PlaybackState = 2 - Buffering
	' PlaybackState = 3 - Ready
	' PlaybackState = 4 - Ended
	If PlaybackState = 1 Then
		B4XPages.MainPage.lblStatus.Text =  "Player status:" & CRLF & "Idle"
		PndAudioExoPlayer1.UpdateMediaSession(" ", "Idle", ExampleAlbumArt.Get(CurentStationId))
	Else If PlaybackState = 2 Then
		B4XPages.MainPage.lblStatus.Text =  "Player status:" & CRLF & "Buffering..."
		PndAudioExoPlayer1.UpdateMediaSession(" ", "Buffering...", ExampleAlbumArt.Get(CurentStationId))
	Else If PlaybackState = 3 Then
		B4XPages.MainPage.lblStatus.Text =  "Player status:" & CRLF & "Ready"
	Else If PlaybackState = 4 Then
		B4XPages.MainPage.lblStatus.Text =  "Player status:" & CRLF & "Ended"
		PndAudioExoPlayer1.UpdateMediaSession(" ", "Ended", ExampleAlbumArt.Get(CurentStationId))
	End If
End Sub

Private Sub PndAudioExoPlayer1_OnPlayerError (Error As String)
	Log("OnPlayerError Error: " & Error)
End Sub

'RENAMED FROM PndAudioExoPlayer1_OnTracksInfoChanged
Private Sub PndAudioExoPlayer1_OnTracksChanged (Metadata As String)
	Log("OnTracksChanged Metadata: " & Metadata)
	Try
		Dim nameStart As Int = Metadata.IndexOf("name=")
		Dim nameEnd As Int = Metadata.IndexOf2("""", nameStart + 6)
		StationName = Metadata.SubString2(nameStart + 6, nameEnd)
		B4XPages.MainPage.lblRadioStationName.Text = "Radio station name:" & CRLF & StationName
		Dim genreStart As Int = Metadata.IndexOf("genre=")
		Dim genreEnd As Int = Metadata.IndexOf2("""", genreStart + 7)
		B4XPages.MainPage.lblGenre.Text = "Genre:" & CRLF &  Metadata.SubString2(genreStart + 7, genreEnd)
		Dim bitrateStart As Int = Metadata.IndexOf("bitrate=")
		Dim bitrateEnd As Int = Metadata.IndexOf2(",", bitrateStart + 8)
		B4XPages.MainPage.lblBitRate.Text = "Bitrate:" & CRLF &  Metadata.SubString2(bitrateStart + 8, bitrateEnd) & " bits per second (bps)"	
		PndAudioExoPlayer1.UpdateMediaSession(SongName, StationName, ExampleAlbumArt.Get(CurentStationId))
		UpdateNotification(SongName, StationName)
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub PndAudioExoPlayer1_MediaSessionOnPause 'event raised from external devices like: smart watch, headphones play/pause button, remote control, etc.
	Log("MediaSessionOnPause")
	Stop
End Sub

Private Sub PndAudioExoPlayer1_MediaSessionOnPlay 'event raised from external devices like: smart watch, headphones play/pause button, remote control, etc.
	Log("MediaSessionOnPlay")
	Play
End Sub

Private Sub PndAudioExoPlayer1_MediaSessionOnStop 'event raised from external devices like: smart watch, headphones play/pause button, remote control, etc.
	Log("MediaSessionOnStop")
	Stop
End Sub

' in this event you can get keycode from remote device
Private Sub PndAudioExoPlayer1_MediaSessionOnButton (KeyCode As Int) 'event raised from external devices like: smart watch, headphones play/pause button, remote control, etc.
	If KeyCode = KeyCodes.KEYCODE_MEDIA_PREVIOUS Then
		Log ("MediaSessionOnButton PREVIOUS")
		PreviousStation
	Else if KeyCode = KeyCodes.KEYCODE_MEDIA_NEXT Then
		Log ("MediaSessionOnButton NEXT")
		NextStation
	End If
End Sub