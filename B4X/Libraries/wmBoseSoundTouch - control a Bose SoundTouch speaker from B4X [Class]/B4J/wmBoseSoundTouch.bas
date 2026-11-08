B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
' Bose SoundTouch API info can be found at https://firstandsecondhomes.com/assets/uploads/SoundTouchAPI_WebServices_v1.1.0.pdf
'
' Library dependencies:
' - B4J: jOkHttpUtils2, Xml2Map
' - B4A: OkHttpUtils2, Xml2Map

' CHANGES:
' ========
' 2024-07-22:
' - Initial version
' 2024-07-23:
' - Added public methods Mute and Unmute

Sub Class_Globals

	Private mURL As String = ""
	Private mPort As String = "8090"
	Private mLogPrefix As String = ""
	Private mlogCalls As Boolean = False
	Private mlogReturnedInfo As Boolean = False
	Private mLogErrors As Boolean = False

	Type wmBoseSoundTouchNetwork(networkType As String, macAddress As String, ipAddress As String)
	Type wmBoseSoundTouchComponent(componentCategory As String, softwareVersion As String, serialNumber As String)
	' In wmBoseSoundTouchInfo:
	' - components: is a list of type wmBoseSoundTouchComponent
	' - networks: is a list of type wmBoseSoundTouchNetwork
	Type wmBoseSoundTouchInfo(deviceId As String, deviceName As String, deviceType As String, margeAccountUUID As String, components As List, networks As List, moduleType As String, variant As String, variantMode As String, countryCode As String, regionCode As String)
	Type wmBoseSoundTouchBassCapabilities(bassAvailable As Boolean, bassMin As Int, bassMax As Int, bassDefault As Int)
	Type wmBoseSoundTouchPreset(id As Int, createdOn As Long, updatedOn As Long, source As String, sourceType As String, sourceLocation As String, sourceAccount As String, sourceIsPresetable As Boolean, itemName As String, containerArt As String)
	' In wmBoseSoundTouchSource, 'status' is one of: READY, UNAVAILABLE
	Type wmBoseSoundTouchSource(name As String, source As String, sourceAccount As String, status As String, isReady As Boolean, isLocal As Boolean, multiRoomAllowed As Boolean)
	'In wmBoseSoundTouchNowPlaying:
	'- source: if 'STANDBY', it means the device is off (as in 'power key pressed'; it is still on the mains power)
	'- playStatus' is one of: BUFFERING_STATE, INVALID_PLAY_STATUS, PAUSE_STATE, PLAY_STATE, STOP_STATE
	Type wmBoseSoundTouchNowPlaying(source As String, sourceType As String, sourceLocation As String, sourceAccount As String, sourceIsPresetable As Boolean, itemName As String, containerArt As String, track As String, artist As String, album As String, stationName As String, artImageStatus As String, artImage As String, favoriteEnabled As Boolean, playStatus As String, streamType As String, description As String, stationLocation As String)
	'In wmBoseSoundTouchVolume: muteEnabled = True means the device is muted; False means it is unmuted
	Type wmBoseSoundTouchVolume(targetVolume As Int, actualVolume As Int, muteEnabled As Boolean)
	Type wmBoseSoundTouchBass(targetBass As Int, actualBass As Int)

	' Constants for KeyPress and KeyRelease
	Public Const KEY_PLAY As String = "PLAY"
	Public Const KEY_PAUSE As String = "PAUSE"
	Public Const KEY_STOP As String = "STOP"
	Public Const KEY_PREV_TRACK As String = "PREV_TRACK"
	Public Const KEY_NEXT_TRACK As String = "NEXT_TRACK"
	Public Const KEY_THUMBS_UP As String = "THUMBS_UP"
	Public Const KEY_THUMBS_DOWN As String = "THUMBS_DOWN"
	Public Const KEY_BOOKMARK As String = "BOOKMARK"
	Public Const KEY_POWER As String = "POWER"
	Public Const KEY_MUTE As String = "MUTE"
	Public Const KEY_VOLUME_UP As String = "VOLUME_UP"
	Public Const KEY_VOLUME_DOWN As String = "VOLUME_DOWN"
	Public Const KEY_PRESET_1 As String = "PRESET_1"
	Public Const KEY_PRESET_2 As String = "PRESET_2"
	Public Const KEY_PRESET_3 As String = "PRESET_3"
	Public Const KEY_PRESET_4 As String = "PRESET_4"
	Public Const KEY_PRESET_5 As String = "PRESET_5"
	Public Const KEY_PRESET_6 As String = "PRESET_6"
	Public Const KEY_AUX_INPUT As String = "AUX_INPUT"
	Public Const KEY_SHUFFLE_OFF As String = "SHUFFLE_OFF"
	Public Const KEY_SHUFFLE_ON As String = "SHUFFLE_ON"
	Public Const KEY_REPEAT_OFF As String = "REPEAT_OFF"
	Public Const KEY_REPEAT_ONE As String = "REPEAT_ONE"
	Public Const KEY_REPEAT_ALL As String = "REPEAT_ALL"
	Public Const KEY_PLAY_PAUSE As String = "PLAY_PAUSE"
	Public Const KEY_ADD_FAVORITE As String = "ADD_FAVORITE"
	Public Const KEY_REMOVE_FAVORITE As String = "REMOVE_FAVORITE"
	Public Const KEY_INVALID_KEY As String = "INVALID_KEY"

End Sub

' Initializes the object. Parms:
' - IP: the Bose SoundTouch device's IP address
' - logPrefix: the prefix to use for Log statements
' - logCalls: if True, the Bose SoundTouch API calls will be logged (URL and passed information)
' - logReturnedInfo: if True, the data returned by the Bose SoundTouch API will be logged
' - logErrors: if True, HttpJob error messages will be logged
' Right after 'Initialize', you could call 'GetInfo' to check whether or not the connection can be made.
Public Sub Initialize(IP As String, logPrefix As String, logCalls As Boolean, logReturnedInfo As Boolean, logErrors As Boolean)

	mLogPrefix = IIf(logPrefix.Trim = "", "", logPrefix & ": ")
	mlogCalls = logCalls
	mlogReturnedInfo = logReturnedInfo
	mLogErrors = logErrors
	mURL = IP.Trim

	If mURL.ToLowerCase.StartsWith("http") = False Then mURL = "http://" & mURL
	If mURL.EndsWith("/") Then mURL = mURL.SubString2(0, mURL.Length - 1)
	mURL = mURL & ":" & mPort & "/"

End Sub

#Region Internal methods
Private Sub XeqGet(method As String) As ResumableSub

	Dim url As String = mURL & method
	Dim httpJob1 As HttpJob
	Dim result As String
	Dim mResult As Map = CreateMap("returned": "")
	Dim xm As Xml2Map
	Dim xmData As Map

	mResult.Put("calledurl", url)

	If mlogCalls Then Log(mLogPrefix & "calling: " & url)

	httpJob1.Initialize("", Me)
	httpJob1.Download(url)

	Wait For (httpJob1) JobDone(httpJob1 As HttpJob)
	If httpJob1.Success Then
		result = httpJob1.GetString
		xm.Initialize
		xm.StripNamespaces = True
		xmData = xm.Parse(result)
		mResult.Put("returned", xmData)
		If mlogReturnedInfo Then
			Log(mLogPrefix & "returned XML: " & result)
			Log(mLogPrefix & "returned Map: " & xmData)
		End If
	Else
		mResult.Put("error", httpJob1.ErrorMessage)
		If mLogErrors Then Log(mLogPrefix & "error: " & httpJob1.ErrorMessage)
	End If

	httpJob1.Release
	Return mResult

End Sub

Private Sub XeqPost(method As String, xml As String) As ResumableSub

	Dim url As String = mURL & method
	Dim httpJob1 As HttpJob
	Dim result As String
	Dim mResult As Map = CreateMap("returned": "")

	mResult.Put("calledurl", url)
	If xml <> "" Then mResult.Put("calledxml", xml)

	If mlogCalls Then Log(mLogPrefix & "calling: " & url & IIf(xml = "", "", " ; " & xml))

	httpJob1.Initialize("", Me)
	httpJob1.PostString(url, xml)
	httpJob1.GetRequest.SetContentType("text/xml; charset=utf-8")

	Wait For (httpJob1) JobDone(httpJob1 As HttpJob)
	If httpJob1.Success Then
		result = httpJob1.GetString
		If mlogReturnedInfo Then Log(mLogPrefix & "returned: " & result)
		mResult.Put("returned", result)
	Else
		mResult.Put("error", httpJob1.ErrorMessage)
		If mLogErrors Then Log(mLogPrefix & "error: " & httpJob1.ErrorMessage)
	End If

	httpJob1.Release
	Return mResult

End Sub

Private Sub CreateEmptyList As List

	Dim l As List
	l.Initialize
	Return l

End Sub

Private Sub CreateEmptyMap As Map

	Dim m As Map
	m.Initialize
	Return m

End Sub

Private Sub GetFromMapAsBoolean(m As Map, key As String) As Boolean

	Return IIf(m.GetDefault(key, "").As(String).ToLowerCase = "true", True, False)

End Sub

Private Sub GetFromMapAsInt(m As Map, key As String, deflt As Int) As Int

	Try
		Dim i As Int = m.GetDefault(key, deflt)
		Return i
	Catch
		Return deflt
	End Try

End Sub
#End Region ' Internal methods

#Region Fetch data (API 'GET' methods)
' Retrieves device hardware and software information.
' Get device information; mostly static device info such as device id, type, IP address (per component if applicable),
' cloud account ID, software version, product version and component type and version.
' Additional data returned in the resulting map: key='value', value=a list of type wmBoseSoundTouchInfo.
' Returns a map containing these keys:
' - 'called': the call that was made to the Bose SoundTouch API
' - 'error': if "", all is well; otherwise, it contains the HttpJob's error message
' - 'returned': the info returned by the Bose SoundTouch API (the data type depends on the method that was called)
' - 'value': is only present if 'error' = "" and contains a variable of type wmBoseSoundTouchInfo (for GetInfo; this depends on the method that was called) 
'
' Example:<code>
'
' Dim wmBoseSoundTouch1 As wmBoseSoundTouch
' wmBoseSoundTouch1.Initialize("192.168.1.5", "", True, True, True)
' Wait For (wmBoseSoundTouch1.GetInfo) Complete (result As Map)
' Log("Called: " & result.Get("called"))
' Log("Returned: " & result.Get("returned"))
' If result.ContainsKey("error") = False Then
'    Log("Device info: " & result.Get("value"))
' Else
'    Log("Error: " & result.Get("error"))
' End If
'</code>
Public Sub GetInfo As ResumableSub

	Wait For (XeqGet("info")) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Dim mReturned As Map = httpJobResult.Get("returned")
		Dim mInfo As Map = mReturned.GetDefault("info", CreateEmptyMap)
		Dim infoOut As wmBoseSoundTouchInfo
		infoOut.Initialize
		infoOut.countryCode = mInfo.GetDefault("countryCode", "")
		infoOut.deviceName = mInfo.GetDefault("name", "")
		infoOut.deviceType = mInfo.GetDefault("type", "")
		infoOut.margeAccountUUID = mInfo.GetDefault("margeAccountUUID", "")
		infoOut.moduleType = mInfo.GetDefault("moduleType", "")
		infoOut.regionCode = mInfo.GetDefault("regionCode", "")
		infoOut.variant = mInfo.GetDefault("variant", "")
		infoOut.variantMode = mInfo.GetDefault("variantMode", "")
		Dim mInfoAttributes As Map = mInfo.GetDefault("Attributes", CreateEmptyMap)
		infoOut.deviceId = mInfoAttributes.GetDefault("deviceID", "")
		Dim lInfoNetworkInfo As List = mInfo.GetDefault("networkInfo", CreateEmptyList)
		infoOut.networks.Initialize
		For Each mNetworkInfo As Map In lInfoNetworkInfo
			Dim mNetworkInfoAttributes As Map = mNetworkInfo.GetDefault("Attributes", CreateEmptyMap)
			Dim ni As wmBoseSoundTouchNetwork
			ni.Initialize
			ni.macAddress = mNetworkInfo.GetDefault("macAddress", "")
			ni.ipAddress = mNetworkInfo.GetDefault("ipAddress", "")
			ni.networkType = mNetworkInfoAttributes.GetDefault("type", "")
			infoOut.networks.Add(ni)
		Next
		Dim mInfoComponents As Map = mInfo.GetDefault("components", CreateEmptyMap)
		Dim lInfoComponents As List = mInfoComponents.GetDefault("component", CreateEmptyList)
		infoOut.components.Initialize
		For Each mComponentInfo As Map In lInfoComponents
			Dim ci As wmBoseSoundTouchComponent
			ci.Initialize
			ci.componentCategory = mComponentInfo.GetDefault("componentCategory", "")
			ci.softwareVersion = mComponentInfo.GetDefault("softwareVersion", "")
			ci.serialNumber = mComponentInfo.GetDefault("serialNumber", "")
			infoOut.components.Add(ci)
		Next
		httpJobResult.Put("value", infoOut)
	End If
	Return httpJobResult

End Sub

' Retrieves information about the 6 presets.
' See GetInfo for details.
' Additional data returned in the resulting map: key='value', value=a list of type wmBoseSoundTouchPreset.
Public Sub GetPresets As ResumableSub

	Wait For (XeqGet("presets")) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Dim mReturned As Map = httpJobResult.Get("returned")
		Dim mPresets As Map = mReturned.GetDefault("presets", CreateEmptyMap)
		Dim lPresets As List = mPresets.GetDefault("preset", CreateEmptyList)
		Dim lstOut As List
		lstOut.Initialize
		For Each onePreset As Map In lPresets
			Dim presetInfo As wmBoseSoundTouchPreset
			presetInfo.Initialize
			Dim onePresetAttributes As Map = onePreset.GetDefault("Attributes", CreateEmptyMap)
			presetInfo.id = onePresetAttributes.GetDefault("id", -1)
			presetInfo.createdOn = onePresetAttributes.GetDefault("createdOn", 0)
			presetInfo.updatedOn = onePresetAttributes.GetDefault("updatedOn", 0)
			Dim onePresetContentItem As Map = onePreset.GetDefault("ContentItem", CreateEmptyMap)
			presetInfo.itemName = onePresetContentItem.GetDefault("itemName", "")
			presetInfo.containerArt = onePresetContentItem.GetDefault("containerArt", "")
			Dim onePresetContentItemAttributes As Map = onePresetContentItem.GetDefault("Attributes", CreateEmptyMap)
			presetInfo.source = onePresetContentItemAttributes.GetDefault("source", "")
			presetInfo.sourceType = onePresetContentItemAttributes.GetDefault("type", "")
			presetInfo.sourceLocation = onePresetContentItemAttributes.GetDefault("location", "")
			presetInfo.sourceAccount = onePresetContentItemAttributes.GetDefault("sourceAccount", "")
			presetInfo.sourceIsPresetable = GetFromMapAsBoolean(onePresetContentItemAttributes, "isPresetable")
			lstOut.Add(presetInfo)
		Next
		lstOut.SortTypeCaseInsensitive("id", True)
		httpJobResult.Put("value", lstOut)
	End If
	Return httpJobResult

End Sub

' Retrieves information about the device's available content sources.
' See GetInfo for details.
' Additional data returned in the resulting map: key='value', value=a list of type wmBoseSoundTouchSource.
Public Sub GetSources As ResumableSub

	Wait For (XeqGet("sources")) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Dim mReturned As Map = httpJobResult.Get("returned")
		Dim mSources As Map = mReturned.GetDefault("sources", CreateEmptyMap)
		Dim lSourceItems As List = mSources.GetDefault("sourceItem", CreateEmptyList)
		Dim lstOut As List
		lstOut.Initialize
		For Each oneSource As Map In lSourceItems
			Dim sourceInfo As wmBoseSoundTouchSource
			sourceInfo.Initialize
			sourceInfo.name = oneSource.GetDefault("Text", "")
			Dim oneSourceAttributes As Map = oneSource.GetDefault("Attributes", CreateEmptyMap)
			sourceInfo.isLocal = GetFromMapAsBoolean(oneSourceAttributes, "isLocal")
			sourceInfo.isReady = IIf(sourceInfo.status.EqualsIgnoreCase("READY"), True, False)
			sourceInfo.multiRoomAllowed = GetFromMapAsBoolean(oneSourceAttributes, "multiroomallowed")
			sourceInfo.source = oneSourceAttributes.GetDefault("source", "")
			sourceInfo.sourceAccount = oneSourceAttributes.GetDefault("sourceAccount", "")
			sourceInfo.status = oneSourceAttributes.GetDefault("status", "")
			lstOut.Add(sourceInfo)
		Next
		lstOut.SortTypeCaseInsensitive("source", True)
		httpJobResult.Put("value", lstOut)
	End If
	Return httpJobResult

End Sub

' Retrieves information about the device's bass capabilities.
' Some speakers do not support the ability to customize the bass levels, use this to find out whether bass customization is supported.
' See GetInfo for details.
' Additional data returned in the resulting map: key='value', value=a variable of type wmBoseSoundTouchBassCapabilities
Public Sub GetBassCapabilities As ResumableSub

	Wait For (XeqGet("bassCapabilities")) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Dim mReturned As Map = httpJobResult.Get("returned")
		Dim mBassCapabilities As Map = mReturned.GetDefault("bassCapabilities", CreateEmptyMap)
		Dim bassCapInfo As wmBoseSoundTouchBassCapabilities
		bassCapInfo.Initialize
		bassCapInfo.bassAvailable = GetFromMapAsBoolean(mBassCapabilities, "bassAvailable")
		bassCapInfo.bassDefault = GetFromMapAsInt(mBassCapabilities, "bassDefault", 0)
		bassCapInfo.bassMax = GetFromMapAsInt(mBassCapabilities, "bassMax", 0)
		bassCapInfo.bassMin = GetFromMapAsInt(mBassCapabilities, "bassMin", 0)
		httpJobResult.Put("value", bassCapInfo)
	End If
	Return httpJobResult

End Sub

' Retrieves information about what's currently playing on the device.
' See GetInfo for details.
' Additional data returned in the resulting map: key='value', value=a variable of type wmBoseSoundTouchNowPlaying.
Public Sub GetNowPlaying As ResumableSub

	Wait For (XeqGet("now_playing")) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Dim mReturned As Map = httpJobResult.Get("returned")
		Dim mNowPlaying As Map = mReturned.GetDefault("nowPlaying", CreateEmptyMap)
		Dim mNowPlayingContentItem As Map = mNowPlaying.GetDefault("ContentItem", CreateEmptyMap)
		Dim mNowPlayingContentItemAttributes As Map = mNowPlayingContentItem.GetDefault("Attributes", CreateEmptyMap)
		Dim mNowPlayingArt As Map = mNowPlaying.GetDefault("art", CreateEmptyMap)
		Dim mNowPlayingArtAttributes As Map = mNowPlayingArt.GetDefault("Attributes", CreateEmptyMap)
		Dim nowPlayingInfo As wmBoseSoundTouchNowPlaying
		nowPlayingInfo.Initialize
		nowPlayingInfo.album = mNowPlaying.GetDefault("album", "")
		nowPlayingInfo.artImage = mNowPlayingArtAttributes.GetDefault("artImageStatus", "")
		nowPlayingInfo.artImageStatus = mNowPlayingArt.GetDefault("Text", "")
		nowPlayingInfo.artist = mNowPlaying.GetDefault("artist", "")
		nowPlayingInfo.containerArt = mNowPlayingContentItem.GetDefault("containerArt", "")
		nowPlayingInfo.description = mNowPlaying.GetDefault("description", "")
		nowPlayingInfo.favoriteEnabled = GetFromMapAsBoolean(mNowPlaying, "favoriteEnabled")
		nowPlayingInfo.itemName = mNowPlayingContentItem.GetDefault("itemName", "")
		nowPlayingInfo.playStatus = mNowPlaying.GetDefault("playStatus", "")
		nowPlayingInfo.source = mNowPlayingContentItemAttributes.GetDefault("source", "")
		nowPlayingInfo.sourceAccount = mNowPlayingContentItemAttributes.GetDefault("sourceAccount", "")
		nowPlayingInfo.sourceIsPresetable = GetFromMapAsBoolean(mNowPlayingContentItemAttributes, "isPresetable")
		nowPlayingInfo.sourceLocation = mNowPlayingContentItemAttributes.GetDefault("location", "")
		nowPlayingInfo.sourceType = mNowPlayingContentItemAttributes.GetDefault("type", "")
		nowPlayingInfo.stationLocation = mNowPlaying.GetDefault("stationLocation", "")
		nowPlayingInfo.stationName = mNowPlaying.GetDefault("stationName", "")
		nowPlayingInfo.streamType = mNowPlaying.GetDefault("streamType", "")
		nowPlayingInfo.track = mNowPlaying.GetDefault("track", "")
		httpJobResult.Put("value", nowPlayingInfo)
	End If
	Return httpJobResult

End Sub

' Retrieves information about the device's volume settings.
' See GetInfo for details.
' Additional data returned in the resulting map: key='value', value=a variable of type wmBoseSoundTouchVolume.
' Volume ranges between 0, 100 inclusive.
Public Sub GetVolume As ResumableSub

	Wait For (XeqGet("volume")) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Dim mReturned As Map = httpJobResult.Get("returned")
		Dim mVolume As Map = mReturned.GetDefault("volume", CreateEmptyMap)
		Dim volumeInfo As wmBoseSoundTouchVolume
		volumeInfo.Initialize
		volumeInfo.targetvolume = mVolume.GetDefault("targetvolume", "")
		volumeInfo.actualvolume = mVolume.GetDefault("actualvolume", "")
		volumeInfo.muteEnabled = GetFromMapAsBoolean(mVolume, "muteenabled")
		httpJobResult.Put("value", volumeInfo)
	End If
	Return httpJobResult

End Sub

' Retrieves information about the device's bass settings.
' This may or may not be a supported capability, use the GetBassCapabilities to find out whether a speaker supports bass configuration.
' See GetInfo for details.
' Additional data returned in the resulting map: key='value', value=a variable of type wmBoseSoundTouchBass.
Public Sub GetBass As ResumableSub

	Wait For (XeqGet("bass")) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Dim mReturned As Map = httpJobResult.Get("returned")
		Dim mbass As Map = mReturned.GetDefault("bass", CreateEmptyMap)
		Dim bassInfo As wmBoseSoundTouchBass
		bassInfo.Initialize
		bassInfo.targetBass = mbass.GetDefault("targetbass", "")
		bassInfo.actualBass = mbass.GetDefault("actualbass", "")
		httpJobResult.Put("value", bassInfo)
	End If
	Return httpJobResult

End Sub
#End Region ' Fetch data (API 'GET' methods)

#Region Change data (API 'POST' methods)
' Sets the device's volume.
' newVol is between 0 and 100, inclusive. Values outside that range will be changed to 0 or 100.
' Additional data returned in the resulting map: key='value', value=a variable of type wmBoseSoundTouchVolume.
'
' Example:<code>
'
' Dim wmBoseSoundTouch1 As wmBoseSoundTouch
' wmBoseSoundTouch1.Initialize("192.168.1.5", "", True, True, True)
' Wait For (wmBoseSoundTouch1.SetVolume(20)) Complete (result As Map)
' Log("Called: " & result.Get("called"))
' Log("Returned: " & result.Get("returned"))
' If result.ContainsKey("error") = False Then
'    Log("New volume info: " & result.Get("value"))
' Else
'    Log("Error: " & result.Get("error"))
' End If
'</code>
Public Sub SetVolume(newVol As Int) As ResumableSub

	If newVol > 100 Then newVol = 100
	If newVol < 0 Then newVol = 0

	Wait For (XeqPost("volume", "<volume>" & newVol & "</volume>")) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Wait For (GetVolume) Complete (result As Map)
		If result.ContainsKey("error") = False Then httpJobResult.Put("value", result.Get("value"))
	End If

	Return httpJobResult

End Sub

' Sets the device's bass setting. This may or may not be a supported capability, use GetBassCapabilities to find out whether the speaker supports bass configuration.
' See SetVolume for details.
' Additional data returned in the resulting map: key='value', value=a variable of type wmBoseSoundTouchBass.
Public Sub SetBass(newBass As Int) As ResumableSub

	Wait For (XeqPost("bass", "<bass>" & newBass & "</bass>")) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Wait For (GetBass) Complete (result As Map)
		If result.ContainsKey("error") = False Then httpJobResult.Put("value", result.Get("value"))
	End If

	Return httpJobResult

End Sub

' Sets the device's name.
' See SetVolume for details.
' Additional data returned in the resulting map: key='value', value=a variable of type wmBoseSoundTouchInfo.
Public Sub SetName(newName As String) As ResumableSub

	Wait For (XeqPost("name", "<name>" & newName & "</name>")) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Wait For (GetInfo) Complete (result As Map)
		If result.ContainsKey("error") = False Then httpJobResult.Put("value", result.Get("value"))
	End If

	Return httpJobResult

End Sub

' Selects the device's AUX source if available.
' See SetVolume for details.
' Additional data returned in the resulting map: key='value', value=a variable of type wmBoseSoundTouchNowPlaying.
Public Sub SelectAux As ResumableSub

	Wait For (XeqPost("select", "<ContentItem source=""AUX"" sourceAccount=""AUX""></ContentItem>")) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Wait For (GetNowPlaying) Complete (result As Map)
		If result.ContainsKey("error") = False Then httpJobResult.Put("value", result.Get("value"))
	End If

	Return httpJobResult

End Sub

' Selects the device's Bluetooth source if available.
' See SetVolume for details.
' Additional data returned in the resulting map: key='value', value=a variable of type wmBoseSoundTouchNowPlaying.
Public Sub SelectBluetooth As ResumableSub

	Wait For (XeqPost("select", "<ContentItem source=""BLUETOOTH""></ContentItem>")) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Wait For (GetNowPlaying) Complete (result As Map)
		If result.ContainsKey("error") = False Then httpJobResult.Put("value", result.Get("value"))
	End If

	Return httpJobResult

End Sub

' Programmatically executes a key press, and optionally the release as well.
' key is one of the 'KEY_...' constants.
' If releaseToo is True, KeyRelease will be called after a successful KeyPress.
' See SetVolume for details.
Public Sub KeyPress(key As String, releaseToo As Boolean) As ResumableSub

	Wait For (XeqPost("key", "<key state=""press"" sender=""Gabbo"">" & key & "</key>")) Complete (httpJobResult As Map)
	If releaseToo And httpJobResult.ContainsKey("error") = False Then
		Wait For (KeyRelease(key)) Complete (result As Map)
		httpJobResult = result
	End If

	Return httpJobResult

End Sub

' Programmatically executes a key release for a previously pressed key.
' key is one of the 'KEY_...' constants.
' See SetVolume for details.
Public Sub KeyRelease(key As String) As ResumableSub

	Wait For (XeqPost("key", "<key state=""release"" sender=""Gabbo"">" & key & "</key>")) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Powers the device on if it is off.
' See SetVolume for details.
Public Sub PowerOn As ResumableSub

	Wait For (GetNowPlaying) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Dim nowPlaying As wmBoseSoundTouchNowPlaying = httpJobResult.Get("value")
		If nowPlaying.source.EqualsIgnoreCase("STANDBY") Then
			Wait For (KeyPress("POWER", True)) Complete (result As Map)
			httpJobResult = result
		End If
	End If

	Return httpJobResult

End Sub

' Powers the device off if it is on.
' See SetVolume for details.
Public Sub PowerOff As ResumableSub

	Wait For (GetNowPlaying) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Dim nowPlaying As wmBoseSoundTouchNowPlaying = httpJobResult.Get("value")
		If nowPlaying.source.EqualsIgnoreCase("STANDBY") = False Then
			Wait For (KeyPress("POWER", True)) Complete (result As Map)
			httpJobResult = result
		End If
	End If

	Return httpJobResult

End Sub

' Mutes the device if it is unmuted.
' See SetVolume for details.
Public Sub Mute As ResumableSub

	Wait For (GetVolume) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Dim vol As wmBoseSoundTouchVolume = httpJobResult.Get("value")
		If vol.muteEnabled = False Then
			Wait For (KeyPress("MUTE", True)) Complete (result As Map)
			httpJobResult = result
		End If
	End If

	Return httpJobResult

End Sub

' Unmutes the device if it is muted.
' See SetVolume for details.
Public Sub Unmute As ResumableSub

	Wait For (GetVolume) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Dim vol As wmBoseSoundTouchVolume = httpJobResult.Get("value")
		If vol.muteEnabled Then
			Wait For (KeyPress("MUTE", True)) Complete (result As Map)
			httpJobResult = result
		End If
	End If

	Return httpJobResult

End Sub
#End Region ' Change data (API 'POST' methods)