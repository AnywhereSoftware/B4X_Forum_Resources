B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private k_y As String 
End Sub

'Initializes with API KEY YOUTBE
Public Sub Initialize(key As String)
	k_y = key
End Sub


Sub DirectLinkYT(filmato As String) As ResumableSub
	'#Region YOUTUBE
	Dim DOWNLOADYOU As HttpJob
	DOWNLOADYOU.Initialize("", Me)
'	Log($"https://www.youtube.com/get_video_info?&video_id=${filmato}&key=${k_you}"$)
	'DOWNLOADYOU.Download($"https://www.youtube.com/get_video_info?&video_id=${filmato}&key=${k_y}"$)
	'Log($"https://www.youtube.com/get_video_info?html5=1&video_id=${filmato}&key=${k_y}"$)
	'DOWNLOADYOU.Download($"https://www.youtube.com/get_video_info?html5=1&video_id=${filmato}&key=${k_y}"$)
	DOWNLOADYOU.Download($"https://www.youtube.com/get_video_info?video_id=${filmato}&html5=1&c=TVHTML5&cver=6.20180913&key=${k_y}"$)

	Wait For (DOWNLOADYOU) JobDone(DOWNLOADYOU As HttpJob)
	If DOWNLOADYOU.Success Then
		'Log(DOWNLOADYOU.GetString)
		Dim string_decode As String = DOWNLOADYOU.GetString
		
		'Decode URL
		Dim decode_link As StringUtils
		Dim string_decode2 As String = decode_link.DecodeUrl(string_decode,"UTF-8")
		'Log(string_decode2)
		If string_decode2.Contains("status=fail") Then
			Dim urlritorno As String = "UNPLAYABLE"
			Dim ritorno As Map
			ritorno.Initialize
			ritorno.Put("link_movie", "")
			ritorno.Put("link_immagine", "")
			ritorno.Put("link_movie_mute", "")
			ritorno.Put("state_movie", "UNPLAYABLE")
			Return ritorno
		End If
			
		'Prelevo la string JSON valida
		#if B4A or B4J
		Dim fino_a As Int = string_decode2.IndexOf($"{"$)
		Dim json_valido As String = string_decode2.SubString2(fino_a, string_decode2.Length)
		'Log(json_valido)
		#Else if B4i
		Dim fino_a As Int = string_decode2.IndexOf($"{"$)
				
		Dim json_pulito As String = string_decode2.SubString2(fino_a, string_decode2.Length)
		Dim lunghezza As Int = json_pulito.LastIndexOf($"}"$)
		'Log(lunghezza)
		
		Dim lunghezza As Int = json_pulito.LastIndexOf("}")
		'Log(lunghezza)
		Dim json_valido As String = json_pulito.SubString2(0, lunghezza + 1)
		#End if
		
	
		Dim parser As JSONParser
		parser.Initialize(json_valido)
		'parser.Initialize(File.ReadString(File.DirAssets, "test.json"))
		Dim root As Map = parser.NextObject
		
		'Verifichiamo se Video è disponibile
		Dim playabilityStatus As Map = root.Get("playabilityStatus")
		Dim status As String = playabilityStatus.Get("status")
		'Check se errore
		If status = "UNPLAYABLE" Then
			Dim ritorno As Map
			ritorno.Initialize
			ritorno.Put("link_movie", "")
			ritorno.Put("link_immagine", "")
			ritorno.Put("link_movie_mute", "")
			ritorno.Put("state_movie", "UNPLAYABLE")
			Return ritorno
		End If
		
		'Immagine
		Dim videoDetails As Map = root.Get("videoDetails")
		Dim isOwnerViewing As String = videoDetails.Get("isOwnerViewing")
		Dim thumbnail As Map = videoDetails.Get("thumbnail")
		Dim thumbnails As List = thumbnail.Get("thumbnails")
		For Each colthumbnails As Map In thumbnails
			Dim width As Int = colthumbnails.Get("width")
			Dim urlfoto As String = colthumbnails.Get("url")
			Dim height As Int = colthumbnails.Get("height")
			If width >= 336 Then Exit
		Next

		Dim streamingData As Map = root.Get("streamingData")
		'Con Audio
		Dim formats As List = streamingData.Get("formats")
		For Each colformats As Map In formats
			Dim itag As Int = colformats.Get("itag")
			Dim fps As Int = colformats.Get("fps")
			Dim projectionType As String = colformats.Get("projectionType")
			Dim bitrate As Int = colformats.Get("bitrate")
			Dim mimeType As String = colformats.Get("mimeType")
			Dim audioQuality As String = colformats.Get("audioQuality")
			Dim approxDurationMs As String = colformats.Get("approxDurationMs")
			
			'Qui Preleviamo filmato con Audio
			Dim urlaudio As String = colformats.Get("url")
			'Se quality è hd720 Stoppiamo e carichiamo
			Dim qualityaudio As String = colformats.Get("quality")
			'If qualityaudio = "hd720" Then Exit
			If qualityaudio = "medium" Then Exit
			
			Dim audioSampleRate As String = colformats.Get("audioSampleRate")
			Dim qualityLabel As String = colformats.Get("qualityLabel")
			Dim audioChannels As Int = colformats.Get("audioChannels")
			Dim width As Int = colformats.Get("width")
			Dim contentLength As String = colformats.Get("contentLength")
			Dim lastModified As String = colformats.Get("lastModified")
			Dim height As Int = colformats.Get("height")
			Dim averageBitrate As String = colformats.Get("averageBitrate")
			
		Next
	
		'Senza audio
		Dim adaptiveFormats As List = streamingData.Get("adaptiveFormats")
		For Each coladaptiveFormats As Map In adaptiveFormats
			
			'Qui preleviamo filmato
			Dim urladapt As String = coladaptiveFormats.Get("url")
				
			'Se quality è large Stoppiamo e carichiamo
			Dim qualityapt As String = coladaptiveFormats.Get("quality")
			If qualityapt = "large" Then Exit
				
		Next
	
	End If
	DOWNLOADYOU.Release

	If urlaudio.Length > 20 Then
		Dim ritorno As Map
		ritorno.Initialize
		ritorno.Put("link_movie", urlaudio)
		ritorno.Put("link_immagine", urlfoto)
		ritorno.Put("link_movie_mute", urladapt)
		ritorno.Put("state_movie", "")
	Else
		Dim ritorno As Map
		ritorno.Initialize
		ritorno.Put("link_movie", urlaudio)
		ritorno.Put("link_immagine", urlfoto)
		ritorno.Put("link_movie_mute", urladapt)
		ritorno.Put("state_movie", "UNPLAYABLE")
	End If
	
	Return ritorno
	'#End Region
End Sub