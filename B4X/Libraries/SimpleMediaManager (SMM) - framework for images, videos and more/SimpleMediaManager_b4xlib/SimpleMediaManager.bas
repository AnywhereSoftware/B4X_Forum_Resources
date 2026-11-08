B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
#Event: MediaReady (Success As Boolean, Media As SMMedia)
Sub Class_Globals
	Type SMMediaMeta (Mime As String, MediaType As Int, Key As String, MetaState As Int, Job As HttpJob, Permanent As Boolean, WaitingRequestsSets As B4XSet, FirstUrl As String, Dir As String, FileName As String)
	Type SMMedia (Media As Object, Meta As SMMediaMeta, UsedBy As B4XSet, MediaState As Int, WaitingRequestsSets As B4XSet, Job As HttpJob)
	Type SMMediaRequest (Key As String, Url As String, Mime As String, Extra As Map)
	Type SMMediaRequestSet (Loading As SMMediaRequest, MainMedia As SMMediaRequest, Error As SMMediaRequest, Target As B4XView, NumberOfAncestors As Int, RequestState As Int, _
		Callback As Object)
	Public Const STATE_LOADING = 1, STATE_ERROR = 2, STATE_READY = 3 As Int
	Private MetaCache As Map
	Private MediaCache As B4XOrderedMap
	Public MaxMediaCacheSize As Int = 40
	Private ViewsRequestSet As Map
	Private ImagesLoader As BitmapsAsync
	Private JobEmpty As HttpJob
	Public const KEY_DEFAULT_LOADING = "~loading", KEY_DEFAULT_ERROR = "~error" As String
	Public const MIME_UNKNOWN As String = "~unknown"
	Public MaxImageSize = 1000 As Int
	Public DefaultFadeAnimationDuration As Int = 300
	Public DefaultResizeMode As String = "FIT"
	Public DefaultBackgroundColor As Int = xui.Color_White
	Public DefaultForegroundColor As Int = xui.Color_Black
	Public ViewsManager As SMMViews
	Private xui As XUI
	Public DefaultLoadingRequest, DefaultErrorRequest As SMMediaRequest
	Public Const REQUEST_ROUNDIMAGE = "round_image", REQUEST_BACKGROUND = "background", REQUEST_RESIZE_MODE = "resize_mode", REQUEST_FADE_ANIMATION_DURATION = "fade_animation" As String
	Public Const REQUEST_CORNERS_RADIUS = "cornersradius" As String
	Public Const REQUEST_FOREGROUND = "foreground" As String
	Public Const REQUEST_CALLBACK = "callback" As String
	Public Const REQUEST_ZOOMIMAGEVIEW = "zoomimageview" As String
	Private Const REQUEST_FILE = "file", REQUEST_DIR = "dir" As String
	Public Const REQUEST_HEADERS = "headers" As String
	Private LastTrimCache As Long
	Public MinTimeBetweenTrims As Long = 2000
	Public SleepDurationBeforeDownload As Long = 50 
	Private HttpRequestsManager As RequestsManager
	Public B4ASdkVersion As Int
	Public DefaultRequestTimeout As Int = 30000
	#if SMM_WEBP
	Private WebP1 As WebP
	#End If
End Sub

Public Sub Initialize
	ImagesLoader.Initialize
	ImagesLoader.MaxFileSize = 8 * 1024 * 1024
	MetaCache.Initialize
	MediaCache.Initialize
	ViewsRequestSet.Initialize
	ViewsManager.Initialize (Me)
	#if B4A
	Dim build As JavaObject
	B4ASdkVersion =  build.InitializeStatic("android.os.Build$VERSION").GetField("SDK_INT")
	#end if
	AddLocalMedia(KEY_DEFAULT_ERROR, Null, "none")
	DefaultLoadingRequest = CreateSMMRequest(KEY_DEFAULT_LOADING, "", MIME_UNKNOWN)
	DefaultLoadingRequest.Extra.Put(REQUEST_BACKGROUND, xui.Color_White)
	DefaultErrorRequest = CreateSMMRequest(KEY_DEFAULT_ERROR, "", MIME_UNKNOWN)
	DefaultErrorRequest.Extra.Put(REQUEST_BACKGROUND, 0xFF6A6A6A)
	AddLocalMedia(KEY_DEFAULT_LOADING, Null, "none")
	LastTrimCache = DateTime.Now
	HttpRequestsManager.Initialize
	#if SMM_WEBP
	WebP1.Initialize
	#End If
End Sub

'Gets or sets the maximum file size of images that will be loaded. Default size is 8mb (8 * 1024 * 1024)
Public Sub setMaxImageFileSize (s As Long)
	ImagesLoader.MaxFileSize = s
End Sub

Public Sub getMaxImageFileSize As Long
	Return ImagesLoader.MaxFileSize
End Sub

'Adds a local media directly to the cache. Local media is never removed from the cache. 
'You can use this method to replace the default loading and error medias, by setting the key to manager.KEY_DEFAULT_LOADING or manager.KEY_DEFAULT_ERROR.
'In most cases you should use SetMediaFromFile.
'Key - An arbitrary string that will be used instead of the url to identify the media.
'Media - B4XBitmap for images, array of bytes for animated gifs and file url for videos.
'Mime - image/*, image/gif or video/*.
Public Sub AddLocalMedia (Key As String, Media As Object, Mime As String) As SMMedia
	Dim meta As SMMediaMeta = CreateSMMediaMeta(Mime, Key, STATE_READY, True)
	Dim smedia As SMMedia = CreateSMMedia(Media, meta, STATE_READY)
	MetaCache.Put(meta.Key, meta)
	MediaCache.Put(meta.Key, smedia)
	Return smedia
End Sub

'Designer script SetMedia. Expec
Private Sub DesignerSetMedia(DesignerArgs As DesignerArgs)
	Dim Target As B4XView = DesignerArgs.GetViewFromArgs(0)
	Dim url As String = DesignerArgs.Arguments.Get(1)
	If DesignerArgs.FirstRun Then
		SetMedia(Target, url)
	Else
		PanelResized(Target)
	End If
End Sub

'Loads the media and shows it in the Target panel. The panel is assumed to be empty (or was previously set with this manager).
Public Sub SetMedia(Target As B4XView, Url As String)
	SetMediaWithExtra(Target, Url, MIME_UNKNOWN, CreateMap())
End Sub

'Loads a media with additional settings.
'Target - Target panel. Should be empty (or was previously set with this manager).
'Url - Resource url.
'Mime - Mime type if known. Pass empty string if unknown.
'Extra - Map with extra settings. The keys should be based on the REQUEST constants:
'REQUEST_ROUNDIMAGE (boolean) - whether to make the images round. Standard images only.
'REQUEST_CORNERS_RADIUS (int) - sets the images corners radius. Standard images only.
'REQUEST_BACKGROUND (int) - sets the panel background color.
'REQUEST_RESIZE_MODE (string) - B4XImageView resize mode (FIT, FILL, FILL_NO_DISTORTIONS, FILL_WIDTH, FILL_HEIGHT and NONE). Standard images only.
'REQUEST_FADE_ANIMATION_DURATION (int) - The fade in animation duration. Pass 0 to disable.
'REQUEST_FOREGROUND (int) - Controller color in B4J video player.
'REQUEST_CALLBACK (Me) - Sets the target module and enables the SMM_MediaReady event.
'Note that the default fields (ex: DefaultBackgroundColor) will be used when a key is missing.
Public Sub SetMediaWithExtra (Target As B4XView, Url As String, Mime As String, Extra As Map)
	If Mime = "" Then Mime = MIME_UNKNOWN
	If Extra = Null Or Extra.IsInitialized = False Then
		Dim Extra As Map
		Extra.Initialize
	End If
	Dim Request As SMMediaRequest = CreateSMMRequest2(Url, Url, Mime, Extra)
	Dim rs As SMMediaRequestSet = CreateSMMediaRequestSet(CloneRequest(DefaultLoadingRequest), _
		Request, _
		CloneRequest(DefaultErrorRequest), Target)
	If Extra.ContainsKey(REQUEST_CALLBACK) Then rs.Callback = Extra.Get(REQUEST_CALLBACK)
	SetMediaWithRequestSet(rs)
End Sub

'Similar to SetMediaWithExtra. Loads a local file. The Mime type must be set.
'This is different than AddLocalMedia where the media is directly added to the cache.
'Use this method to display local resources. Use AddLocalMedia to add error / loading resources.
Public Sub SetMediaFromFile(Target As B4XView, Dir As String, FileName As String, Mime As String, Extra As Map)
	If Extra = Null Or Extra.IsInitialized = False Then
		 Dim Extra As Map
		 Extra.Initialize
	End If
	Extra.Put(REQUEST_DIR, IIf(Dir = "", FileName, Dir))
	Extra.Put(REQUEST_FILE, IIf(Dir = "", "", FileName))
	If ViewsManager.MimeToMediaType(Mime) = ViewsManager.MEDIA_TYPE_NONE Then
		Log("Invalid mime!")
		Return
	End If
	SetMediaWithExtra(Target, xui.FileUri(Dir, FileName), Mime, Extra)
End Sub

'Low level method.
'Never reuse a request or request set!
'Allows setting non-default loading and error requests. Loading and error requests must point to a local resource, added with AddLocalMedia.
Public Sub SetMediaWithRequestSet (RequestSet As SMMediaRequestSet)
	RegisterForMeta(RequestSet)
End Sub

Private Sub RegisterForMeta (RequestSet As SMMediaRequestSet)
	#if SMM_DEBUG
	Log("RegisterForMeta: " & RequestSet.MainMedia.Key)
	#End If
	ClearMedia(RequestSet.Target)
	ViewsRequestSet.Put(RequestSet.Target, RequestSet)
	Dim media As SMMedia = MediaCache.Get(RequestSet.MainMedia.Key)
	
	'short path
	If media <> Null And media.MediaState = STATE_READY Then
		media.WaitingRequestsSets.Add(RequestSet)
		MediaIsReady(media)
	Else
		If media <> Null And media.MediaState = STATE_ERROR Then
			Log("Unexpected state:  media.MediaState = STATE_ERROR")
		End If
		RequestSet.RequestState = STATE_LOADING
		ViewsManager.AddMedia(RequestSet, MediaCache.Get(RequestSet.Loading.Key), RequestSet.Loading)
		If MetaCache.ContainsKey(RequestSet.MainMedia.Key) Then
			Dim meta As SMMediaMeta = MetaCache.Get(RequestSet.MainMedia.Key)
			meta.WaitingRequestsSets.Add(RequestSet)
			If meta.MetaState <> STATE_LOADING Then
				MetaIsReady(meta)
			End If
		Else
			meta = CreateSMMediaMeta(RequestSet.MainMedia.Mime, RequestSet.MainMedia.Key, IIf(RequestSet.MainMedia.Mime = MIME_UNKNOWN, STATE_LOADING, STATE_READY), False)
			meta.FirstUrl = RequestSet.MainMedia.Url
			meta.WaitingRequestsSets.Add(RequestSet)
			meta.Dir = RequestSet.MainMedia.Extra.GetDefault(REQUEST_DIR, "")
			meta.FileName = RequestSet.MainMedia.Extra.GetDefault(REQUEST_FILE, "")
			MetaCache.Put(meta.Key, meta)
			If meta.MetaState = STATE_LOADING Then
				Dim job As HttpJob
				job.Initialize("", Me)
				job.Head(RequestSet.MainMedia.Url)
				job.GetRequest.Timeout = DefaultRequestTimeout
				AddHeadersToJob(job, RequestSet.MainMedia)
				meta.Job = job
				Wait For (job) JobDone (job As HttpJob)
				meta.Job = JobEmpty
				If job.Success Then
					Dim o As Object = job.Response.ContentType
					meta.Mime = IIf(o = Null, "", o).As(String)
					meta.MediaType = ViewsManager.MimeToMediaType(meta.Mime)
					meta.MetaState = STATE_READY
				Else
					#if SMM_DEBUG
					Log("RegisterForMeta: failed to make HEAD request: " & RequestSet.MainMedia.Key)
					#End If
					meta.MetaState = STATE_ERROR
				End If
				job.Release
			End If
			
			MetaIsReady(meta)
		End If
	End If
End Sub

Private Sub AddHeadersToJob(j As HttpJob, request As SMMediaRequest)
	If request.Extra.ContainsKey(REQUEST_HEADERS) Then
		Dim headers As Map = request.Extra.Get(REQUEST_HEADERS)
		For Each key As String In headers.Keys
			j.GetRequest.SetHeader(key, headers.Get(key))
		Next
	End If
End Sub

Private Sub MetaIsReady (Meta As SMMediaMeta)
	For Each RequestSet As SMMediaRequestSet In Meta.WaitingRequestsSets.AsList
	#if SMM_DEBUG
		Log("MetaIsReady: " & RequestSet.MainMedia.Key & ", MediaCache contains? "  & MediaCache.ContainsKey(Meta.Key) & ", " & Meta.Mime)
	#End If
		If MediaCache.ContainsKey(Meta.Key) Then
			Dim Media As SMMedia = MediaCache.Get(Meta.Key)
			'move it to the front
			MediaCache.Remove(Meta.Key)
			MediaCache.Put(Meta.Key, Media)
			Media.WaitingRequestsSets.Add(RequestSet)
			If Media.MediaState <> STATE_LOADING Then
				MediaIsReady(Media)
			End If
		Else
			Media = CreateSMMedia(Null, Meta, IIf(Meta.MetaState = STATE_READY, STATE_LOADING, STATE_ERROR))
			Media.WaitingRequestsSets.Add(RequestSet)
			MediaCache.Put(Media.Meta.Key, Media)
			TrimMediaCacheImpl
			If Media.MediaState = STATE_ERROR Then
				MediaIsReady(Media)
			Else
				Dim MediaType As Int = Media.Meta.MediaType
				Select MediaType
					Case ViewsManager.MEDIA_TYPE_GIF, ViewsManager.MEDIA_TYPE_IMAGE, ViewsManager.MEDIA_TYPE_WEBP
						DownloadImageMedia(Media, RequestSet.MainMedia)
					Case ViewsManager.MEDIA_TYPE_VIDEO, ViewsManager.MEDIA_TYPE_HTML
						Media.MediaState = STATE_READY
						Media.Media = Meta.FirstUrl
						MediaIsReady(Media)
					Case ViewsManager.MEDIA_TYPE_NONE
						Log("Unexpected mime: " & Media.Meta.Mime)
						Media.MediaState = STATE_ERROR
						MediaIsReady(Media)
				End Select
			End If
		End If
	Next
	Meta.WaitingRequestsSets.Clear
	If Meta.MetaState = STATE_ERROR Then
		#if SMM_DEBUG
		Log("Removing meta with error: " & Meta.Key)
		#End If
		MetaCache.Remove(Meta)
	End If
End Sub

Private Sub DownloadImageMedia (Media As SMMedia, Request As SMMediaRequest)
	If Media.Meta.MetaState = STATE_READY Then
		If SleepDurationBeforeDownload > 0 Then
			Sleep(SleepDurationBeforeDownload)
			CancelDisconnectedTargets(Media)
			If IsMediaStillRelevant(Media) = False Then
				#if SMM_DEBUG
				Log("Media no longer relevant (after sleep): " & Media.Meta.Key)
				#End If
				DeleteMedia(Media) 'media is loading state. Remove it.
				Return
			End If
		End If
		If Media.Meta.Dir = "" Then
			Dim job As HttpJob
			job.Initialize("", Me)
			job.Download(Media.Meta.FirstUrl)
			job.GetRequest.Timeout = DefaultRequestTimeout
			AddHeadersToJob(job, Request)
		#if SMM_DEBUG
			Log("DownloadImageMedia start: " & Media.Meta.Key)
		#End If
			Media.Job = job
			Wait For (job) JobDone (job As HttpJob)
			Media.Job = JobEmpty
		#if SMM_DEBUG
			Log("DownloadImageMedia end: " & Media.Meta.Key & ", success? " & job.Success)
		#End If
			
			If job.Success Then
				Wait For (PrepareMedia(Media, job, "", "", False)) Complete (Unused As Boolean)
				Media.MediaState = IIf(Media.Media <> Null, STATE_READY, STATE_ERROR)
			Else
				Media.MediaState = STATE_ERROR
			End If
			job.Release
		Else
			#if SMM_DEBUG
			Log("DownloadImageMedia from file: " & Media.Meta.Key)
		#End If
			Wait For (PrepareMedia(Media, Null, Media.Meta.Dir, Media.Meta.FileName, True)) Complete (Unused As Boolean)
			Media.MediaState = IIf(Media.Media <> Null, STATE_READY, STATE_ERROR)
		End If
		
	Else ' If media.Meta.MetaState = STATE_ERROR Then
		Media.MediaState = STATE_ERROR
	End If
	MediaIsReady(Media)
End Sub

Private Sub PrepareMedia(Media As SMMedia, job As HttpJob, Dir As String, FileName As String, FromFile As Boolean) As ResumableSub
	Dim MediaType As Int = Media.Meta.MediaType
	If MediaType = ViewsManager.MEDIA_TYPE_IMAGE Then
		Dim SkipRegularImageLoading As Boolean 'ignore
		#if B4J and SMM_IMAGE4J
		If Media.Meta.Mime = "image/vnd.microsoft.icon" Or Media.Meta.Mime = "image/x-icon" Then
			Media.Media = LoadIcoImage(IIf(FromFile, File.OpenInput(Dir, FileName), job.GetInputStream))
			SkipRegularImageLoading = True
		End If
		#End If
		If SkipRegularImageLoading = False Then
			If FromFile Then
				Wait For (ImagesLoader.LoadFromFile(Dir, FileName, MaxImageSize, MaxImageSize)) Complete (bmp As B4XBitmap)
			Else
				Wait For (ImagesLoader.LoadFromHttpJob(job, MaxImageSize, MaxImageSize)) Complete (bmp As B4XBitmap)
			End If
			Media.Media = IIf(bmp.IsInitialized, bmp, Null)
		End If
		If (xui.IsB4A Or xui.IsB4J) And Media.Meta.Mime = "image/jpeg" And Media.Media <> Null Then
			PreprocessExif(Media, IIf(FromFile, File.OpenInput(Dir, FileName), job.GetInputStream))
		End If
	Else
		Dim in As InputStream = IIf(FromFile, File.OpenInput(Dir, FileName), job.GetInputStream)
		Select MediaType
			Case ViewsManager.MEDIA_TYPE_GIF
				Media.Media = Bit.InputStreamToBytes(in)
			Case ViewsManager.MEDIA_TYPE_WEBP
			#if SMM_WEBP
				Dim imagedata() As Byte = Bit.InputStreamToBytes(in)
				If IsWebPAnimated(Media) Then
					#if B4A
					Dim ImageDecoder As JavaObject
					Dim bb As JavaObject
					bb = bb.InitializeStatic("java.nio.ByteBuffer").RunMethod("wrap", Array(imagedata))
					Dim source As Object = ImageDecoder.InitializeStatic("android.graphics.ImageDecoder").RunMethod("createSource", Array(bb))
					Media.Media = source
					#End If
				Else
					Media.Media = WebP1.LoadWebP(imagedata)
				End If
			#End If
		End Select
	End If
	
	Return True
End Sub

Public Sub IsWebPAnimated(Media As SMMedia) As Boolean
	#if B4A
	Return B4ASdkVersion >= 28 And Media.Meta.MediaType = ViewsManager.MEDIA_TYPE_WEBP
	#else
	Return False
	#End If
End Sub

Private Sub MediaIsReady (Media As SMMedia)
	CancelDisconnectedTargets(Media)
	For Each req As SMMediaRequestSet In Media.WaitingRequestsSets.AsList
		req.RequestState = Media.MediaState
		If Media.MediaState = STATE_READY Then
			Media.UsedBy.Add(req)
			ViewsManager.AddMedia(req, Media, GetRequestFromRequestSet(req))
		Else if Media.MediaState = STATE_ERROR Then
			ViewsManager.AddMedia(req, MediaCache.Get(req.Error.Key), GetRequestFromRequestSet(req))
		Else
			Log("MediaIsReady Unexpected state!")
		End If
	Next
	Media.WaitingRequestsSets.Clear
	If Media.MediaState = STATE_ERROR Then
		#if SMM_DEBUG
		Log("Removing media with error: " & Media.Meta.Key)
		#End If
		MediaCache.Remove(Media.Meta.Key)
	End If
End Sub


Public Sub PanelResized (Target As B4XView)
	Dim set As SMMediaRequestSet = ViewsRequestSet.Get(Target)
	If set <> Null Then
		ViewsManager.ParentResized(Target)
	End If
End Sub

'Clears the media associated with this target.
Public Sub ClearMedia(Target As B4XView)
	If ViewsRequestSet.ContainsKey(Target) Then
		CancelRequest(ViewsRequestSet.Get(Target))
	End If
End Sub


Private Sub CancelRequest (RequestSet As SMMediaRequestSet)
	#if SMM_DEBUG
	Log("CancelRequest: " & RequestSet.MainMedia.Key)
	#End If
	ViewsRequestSet.Remove(RequestSet.Target)
	ViewsManager.CancelRequest(RequestSet.Target)
	Dim meta As SMMediaMeta = MetaCache.Get(RequestSet.MainMedia.Key)
	If meta <> Null Then
		meta.WaitingRequestsSets.Remove(RequestSet)
		Dim media As SMMedia = MediaCache.Get(RequestSet.MainMedia.Key)
		If media <> Null Then
			media.WaitingRequestsSets.Remove(RequestSet)
			media.UsedBy.Remove(RequestSet)
			CancelDisconnectedTargets(media)
		End If
	End If
End Sub

'Forces a cache trim.
Public Sub TrimMediaCache
	LastTrimCache = 0
	TrimMediaCacheImpl	
End Sub

Private Sub TrimMediaCacheImpl
	If DateTime.Now > LastTrimCache + MinTimeBetweenTrims Then
		Dim OnlyLookForDisconnectedTargets As Boolean = MediaCache.Size < MaxMediaCacheSize
		LastTrimCache = DateTime.Now
		#if SMM_DEBUG
		Log("TrimMediaCache: " & MediaCache.Size)
		#End If
		Dim i As Int = 0
		Do While i < MediaCache.Size
			Dim Media As SMMedia = MediaCache.Get(MediaCache.Keys.Get(i))
			CancelDisconnectedTargets(Media)
			If OnlyLookForDisconnectedTargets = False And MediaCache.Size > MaxMediaCacheSize / 2 And IsMediaStillRelevant(Media) = False Then
				DeleteMedia(Media)
				i = i - 1
			End If
			i = i + 1
		Loop
	End If
End Sub

Private Sub DeleteMedia (Media As SMMedia)
	#if SMM_DEBUG
	Log("*** DeleteMedia: " & Media.Meta.Key & ", state=" & Media.MediaState)
	#End If
	If Media.MediaState = STATE_READY Then
		Select Media.Meta.MediaType
			Case ViewsManager.MEDIA_TYPE_IMAGE
				#if B4A
				Dim jo As JavaObject = Media.Media 'B4XBitmap
				jo.RunMethod("recycle", Null)
				#End IF
			Case ViewsManager.MEDIA_TYPE_HTML
				MetaCache.Remove(Media.Meta.Key)
		End Select
	Else if Media.MediaState = STATE_LOADING Then
		#if SMM_DEBUG
		Log("delete media with state loading")
		#end if
		If Media.Job.IsInitialized Then
			HttpRequestsManager.CancelRequest(Media.Meta.FirstUrl, Media.Job)
		End If
	End If
	MediaCache.Remove(Media.Meta.Key)
End Sub


Private Sub IsMediaStillRelevant (Media As SMMedia) As Boolean
	Return Media.Meta.Permanent Or (Media.MediaState = STATE_LOADING And Media.WaitingRequestsSets.Size > 0) Or (Media.MediaState <> STATE_LOADING And Media.UsedBy.Size > 0)
End Sub

Private Sub CancelDisconnectedTargets (Media As SMMedia)
	For Each set As B4XSet In Array(Media.UsedBy, Media.WaitingRequestsSets)
		For i = set.Size - 1 To 0 Step - 1
			Dim RequestSet As SMMediaRequestSet = set.AsList.Get(i)
			If RequestSet.NumberOfAncestors > CountAncestors(RequestSet.Target) Then
			#if SMM_DEBUG
				Log("found a disconnected target!")
			#End If
				ViewsManager.CancelRequest(RequestSet.Target)
				set.Remove(RequestSet)
			End If
		Next
	Next
End Sub


'Returns the media cache size.
Public Sub getMediaCacheSize As Int
	Return MediaCache.Size
End Sub



Private Sub GetRequestFromRequestSet(rs As SMMediaRequestSet) As SMMediaRequest
	If rs.RequestState = STATE_LOADING Then
		Return rs.Loading
	Else If rs.RequestState = STATE_ERROR Then
		Return rs.Error
	Else
		Return rs.MainMedia
	End If
End Sub

Public Sub CreateRequest (Url As String, Extra As Map) As SMMediaRequest
	Return CreateSMMRequest2(Url, Url, MIME_UNKNOWN, Extra)
End Sub

Private Sub CreateSMMRequest (Key As String, Url As String, Mime As String) As SMMediaRequest
	Dim t1 As SMMediaRequest
	t1.Initialize
	t1.Key = Key
	t1.Url = Url
	t1.Mime = Mime
	t1.Extra.Initialize
	Return t1
End Sub

Private Sub CreateSMMRequest2 (Key As String, Url As String, Mime As String, Extra As Map) As SMMediaRequest
	Dim t1 As SMMediaRequest
	t1.Initialize
	t1.Key = Key
	t1.Url = Url
	t1.Mime = Mime
	t1.Extra = Extra
	Return t1
End Sub

Public Sub CloneRequest(Request As SMMediaRequest) As SMMediaRequest
	Dim req As SMMediaRequest = CreateSMMRequest(Request.Key, Request.Url, Request.Mime)
	For Each k As String In Request.Extra.Keys
		req.Extra.Put(k, Request.Extra.Get(k))
	Next
	Return req
End Sub

Private Sub CreateSMMediaMeta (Mime As String, Key As String, MetaState As Int, Permanent As Boolean) As SMMediaMeta
	Dim t1 As SMMediaMeta
	t1.Initialize
	t1.Mime = Mime
	t1.MediaType = ViewsManager.MimeToMediaType(Mime)
	t1.Key = Key
	t1.MetaState = MetaState
	t1.Permanent = Permanent
	t1.WaitingRequestsSets.Initialize
	Return t1
End Sub

Public Sub CreateSMMedia (Media As Object, Meta As SMMediaMeta, MediaState As Int) As SMMedia
	Dim t1 As SMMedia
	t1.Initialize
	t1.Media = Media
	t1.Meta = Meta
	t1.MediaState = MediaState
	t1.WaitingRequestsSets.Initialize
	t1.UsedBy.Initialize
	Return t1
End Sub

Public Sub CreateSMMediaRequestSet (Loading As SMMediaRequest, MainMedia As SMMediaRequest, Error As SMMediaRequest, Target As B4XView) As SMMediaRequestSet
	Dim t1 As SMMediaRequestSet
	t1.Initialize
	t1.Loading = Loading
	t1.MainMedia = MainMedia
	t1.Error = Error
	t1.Target = Target
	t1.NumberOfAncestors = CountAncestors(t1.Target)
	t1.Callback = Null
	If t1.NumberOfAncestors = 0 Then
		Log("Target is not in the views tree!")
	End If
	Return t1
End Sub

Private Sub CountAncestors(Target As B4XView) As Int
	Dim p As B4XView = Target
	Dim count As Int
	#if B4A
	Do While p.Parent Is View
	#else
	Do While p.Parent.IsInitialized
	#End If
		count = count + 1
		p = p.Parent
	Loop
	Return count
End Sub

'Handles jpeg orientation. It is called automatically after a JPEG is downloaded. You can call it directly when adding images with AddLocalMedia.
Public Sub PreprocessExif (Media As SMMedia, In As InputStream)
	#if SMM_DEBUG
	Log("PreprocessMedia: " & Media.Meta.Key)
	#End If
	If Media.Meta.Mime <> "image/jpeg" Then
		Log("image/jpeg mime expected!")
		In.Close
		Return
	End If
	#if B4A
	If B4ASdkVersion >= 24 Then
		Dim ExifInterface As JavaObject
		ExifInterface.InitializeNewInstance("android.media.ExifInterface", Array(In))
		Dim orientation As Int = ExifInterface.RunMethod("getAttribute", Array("Orientation"))
		Media.Media = RotateBitmapBasedOnOrientation(Media.Media, orientation)
	End If
	In.Close
	#Else If B4J AND SMM_META
	Dim MetadataReader As JavaObject
	Dim ExifReader As JavaObject
	ExifReader.InitializeNewInstance("com.drew.metadata.exif.ExifReader", Null)
	Dim readers As List = Array(ExifReader)
	Try
		Dim Metadata As JavaObject = MetadataReader.InitializeStatic("com.drew.imaging.jpeg.JpegMetadataReader").RunMethod("readMetadata", Array(In, readers))
		For Each dic As JavaObject In Metadata.RunMethod("getDirectories", Null).As(List)
			Dim orientation As Object = dic.RunMethod("getInteger", Array(274)) 'orientation
			If orientation <> Null Then
				Media.Media = RotateBitmapBasedOnOrientation(Media.Media, orientation)
				Exit
			End If
		Next
	Catch
		Log(LastException)
	End Try
	In.Close
	#End If
End Sub

Private Sub RotateBitmapBasedOnOrientation (bmp As B4XBitmap, orientation As Int) As B4XBitmap 'ignore
	Select orientation
		Case 3  '180
			bmp = bmp.Rotate(180)
		Case 6 '90
			bmp = bmp.Rotate(90)
		Case 8 '270
			bmp = bmp.Rotate(270)
	End Select
	Return bmp
End Sub

#if B4J and SMM_IMAGE4J
Private Sub LoadIcoImage (in As InputStream) As Object
	Dim jo As JavaObject
	jo.InitializeStatic("net.sf.image4j.codec.ico.ICODecoder")
	Dim res As Object = Null
	Try
		Dim bufferdImages As List = jo.RunMethod("read", Array(in))
		Dim LargestIndex As Int = -1
		Dim MaxSize As Int = -1
		For i = 0 To bufferdImages.Size - 1
			Dim bf As JavaObject = bufferdImages.Get(0)
			Dim size As Int = bf.RunMethod("getWidth", Null).As(Int) * bf.RunMethod("getHeight", Null).As(Int)
			If size >= MaxSize Then
				LargestIndex = i
				MaxSize = size
			End If
		Next
		If LargestIndex > -1 Then
			Dim fxutils As JavaObject
			fxutils.InitializeStatic("javafx.embed.swing.SwingFXUtils")
			res =fxutils.RunMethod("toFXImage", Array(bufferdImages.Get(LargestIndex), Null))
		End If
	Catch
		Log(LastException)
	End Try
	in.Close
	Return res
End Sub
#End If



