B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
' Kodi JSON RPC API info can be found at https://kodi.wiki/view/JSON-RPC_API
' The API v10 info on which this class is based can be found at https://kodi.wiki/view/JSON-RPC_API/v10
' Some JSON examples are available at https://kodi.wiki/view/JSON-RPC_API/Examples
'
' Non-core library dependencies:
' - B4J: jOkHttpUtils2, Json
' - B4A: OkHttpUtils2, Json

' CHANGES:
' ========
' 2021-11-08:
' - Initial version
' 2021-11-10:
' - Added method Favourites_PlayFavourite
' 2023-07-11:
' - Corrected the example in the IDE help for method Input_Up
' - Added public methods Application_GetOneProperty, Application_GetProperties, Application_GetVolume, Application_SetMute, and Application_SetVolume
' - Added private method GetAPIresultStringFromHttpJobResult2

Sub Class_Globals

	Private JsonRpcVersion As String = "2.0"
	Private mURL As String = ""
	Private mLogPrefix As String = ""
	Private mlogCalls As Boolean = False
	Private mlogReturnedInfo As Boolean = False
	Private mLogErrors As Boolean = False

	' Possible 'favType' values are: 'media', 'script', 'window', or 'unknown'
	Type wmKODI_favourite(title As String, favType As String, path As String, thumbnail As String, window As String, windowParameter As String)

End Sub

' Initializes the object. Parms:
' - URL: http://IP_ADDRESS:PORT[/[jsonrpc]]
' - logPrefix: the prefix to use for Log statements
' - logCalls: if True, the KODI JSON RPC API calls will be logged (URL and passed information)
' - logReturnedInfo: if True, the data returned by the KODI JSON RPC API will be logged
' - logErrors: if True, HttpJob error messages will be logged
' Right after 'Initialize', you could call 'JSONRPC_Version' to check whether or not the connection can be made.
Public Sub Initialize(URL As String, logPrefix As String, logCalls As Boolean, logReturnedInfo As Boolean, logErrors As Boolean)

	mLogPrefix = IIf(logPrefix.Trim = "", "", logPrefix & ": ")
	mlogCalls = logCalls
	mlogReturnedInfo = logReturnedInfo
	mLogErrors = logErrors
	mURL = URL.Trim
	If mURL.ToLowerCase.StartsWith("http") = False Then mURL = "http://" & mURL
	If mURL.ToLowerCase.EndsWith("/jsonrpc") = False Then mURL = mURL & IIf(mURL.EndsWith("/"), "jsonrpc", "/jsonrpc")

End Sub

#Region Internal methods
Private Sub Xeq(method As String, mParms As Map) As ResumableSub

	Dim mInput As Map = CreateMap("jsonrpc": JsonRpcVersion, "method": method, "id": "1")
	Dim JSONGenerator1 As JSONGenerator
	Dim JSONstring As String
	Dim httpJob1 As HttpJob
	Dim result As String
	Dim mResult As Map = CreateMap("returned": "")

	If mParms.IsInitialized Then
		If mParms <> Null Then
			If mParms.Size > 0 Then mInput.Put("params", mParms)
		End If
	End If

	JSONGenerator1.Initialize(mInput)
	JSONstring = JSONGenerator1.ToString()
	mResult.Put("called", mURL & JSONstring)

	If mlogCalls Then Log(mLogPrefix & "calling: " & mURL & JSONstring)

	httpJob1.Initialize(method, Me)
	httpJob1.PostString(mURL, JSONstring)
	httpJob1.GetRequest.SetContentType("application/json")

	Wait For (httpJob1) JobDone(httpJob1 As HttpJob)
	If httpJob1.Success Then
		result = httpJob1.GetString
		If mlogReturnedInfo Then Log(mLogPrefix & "returned: " & result)
		Dim json As JSONParser
		json.Initialize(result)
		Dim jsonMap As Map = json.NextObject
		If jsonMap.ContainsKey("error") Then
			mResult.Put("error", jsonMap)
			If mLogErrors Then Log(mLogPrefix & "error: " & jsonMap)
		Else
			mResult.Put("returned", result)
		End If
	Else
		mResult.Put("error", httpJob1.ErrorMessage)
		If mLogErrors Then Log(mLogPrefix & "error: " & httpJob1.ErrorMessage)
	End If

	httpJob1.Release
	Return mResult

End Sub

Private Sub GetAPIresultListFromHttpJobResult(XeqResult As Map) As List

	Dim result As List

	Try
		Dim json As JSONParser
		json.Initialize(XeqResult.GetDefault("returned", ""))
		Dim jsonMap As Map = json.NextObject 'E.g.: {"id":"1","jsonrpc":"2.0","result":{"speed":1}}
		result = jsonMap.Get("result")
	Catch
		result.Initialize
	End Try

	Return result

End Sub

Private Sub GetAPIresultMapFromHttpJobResult(XeqResult As Map, resultKey As String) As Map

	Dim result As Map

	Try
		Dim json As JSONParser
		json.Initialize(XeqResult.GetDefault("returned", ""))
		Dim jsonMap As Map = json.NextObject 'E.g.: {"id":"1","jsonrpc":"2.0","result":{"speed":1}}
		result = jsonMap.Get(resultKey)
	Catch
		result.Initialize
	End Try

	Return result

End Sub

Private Sub GetAPIresultStringFromHttpJobResult(XeqResult As Map, item As String, deflt As String) As String

	Dim result As String

	Try
		Dim json As JSONParser
		json.Initialize(XeqResult.GetDefault("returned", ""))
		Dim jsonMap As Map = json.NextObject 'E.g.: {"id":"1","jsonrpc":"2.0","result":{"speed":1}}
		Dim resultMap As Map = jsonMap.GetDefault("result", deflt)
		result = resultMap.Get(item)
	Catch
		result = deflt
	End Try

	Return result

End Sub

Private Sub GetAPIresultStringFromHttpJobResult2(XeqResult As Map, item As String, deflt As String) As String

	Dim result As String

	Try
		Dim json As JSONParser
		json.Initialize(XeqResult.GetDefault("returned", ""))
		Dim jsonMap As Map = json.NextObject 'E.g.: {"id":"1","jsonrpc":"2.0","result":89}
		result = jsonMap.GetDefault(item, deflt)
	Catch
		result = deflt
	End Try

	Return result

End Sub
#End Region ' Internal methods

#Region Methods for the 'Application' Namespace
' Retrieves the value of the given property.
' See Application_SetSpeedBackward for details and an example with the 'speed' property.
' See https://kodi.wiki/view/JSON-RPC_API/v10#Application.Property.Name for a list of all available properties.
Public Sub Application_GetOneProperty(property As String) As ResumableSub

	Wait For (Application_GetProperties(Array As String(property))) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Retrieves the values of the given properties.
' See Application_GetOneProperty for details and an example with the 'speed' property.
' See https://kodi.wiki/view/JSON-RPC_API/v10#Application.Property.Name for a list of all available properties.
' Additional data returned in the resulting map: key='properties', value=a map with the requested properties (key=property name, value=property value).
Public Sub Application_GetProperties(properties As List) As ResumableSub

	Wait For (Xeq("Application.GetProperties", CreateMap("properties": properties))) Complete (httpJobResult As Map)
	httpJobResult.Put("properties", IIf(httpJobResult.ContainsKey("error") = False, GetAPIresultMapFromHttpJobResult(httpJobResult, "result"), ""))
	Return httpJobResult

End Sub

' Get the current volume.
' See Input_Up for details and an example.
' Additional data returned in the resulting map: key='volume', value=an int that contains the current volume.
Public Sub Application_GetVolume As ResumableSub

	Wait For (Application_GetProperties(Array As String("volume"))) Complete (httpJobResult As Map)
	httpJobResult.Put("volume", IIf(httpJobResult.ContainsKey("error") = False, GetAPIresultStringFromHttpJobResult(httpJobResult, "volume", ""), ""))
	Return httpJobResult

End Sub

' Toggle mute/unmute.
' See Input_Up for details and an example.
' Additional data returned in the resulting map: key='result', value=True or False (reflects the muted state).
Public Sub Application_SetMute(mute As Boolean) As ResumableSub

	Wait For (Xeq("Application.SetMute", CreateMap("mute": mute))) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Set the current volume.
' See Input_Up for details and an example.
' Additional data returned in the resulting map: key='volume', value=an int that contains the new volume.
Public Sub Application_SetVolume(newVolume As Int) As ResumableSub

	Wait For (Xeq("Application.SetVolume", CreateMap("volume": newVolume))) Complete (httpJobResult As Map)
	httpJobResult.Put("volume", IIf(httpJobResult.ContainsKey("error") = False, GetAPIresultStringFromHttpJobResult2(httpJobResult, "result", -1), ""))
	Return httpJobResult

End Sub
#End Region ( Methods for the 'Application' Namespace

#Region Methods for the 'Favourites' Namespace
' Retrieve all favourites.
' See Input_Up for details and an example.
' Additional data returned in the resulting map: key='favourites', value=a list of Type 'KODI_favourite', sorted ascending by title.
Public Sub Favourites_GetFavourites As ResumableSub

	Dim properties As List = Array As String("path", "thumbnail", "window", "windowparameter")
	Wait For (Xeq("Favourites.GetFavourites", CreateMap("properties": properties))) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Dim m As Map = GetAPIresultMapFromHttpJobResult(httpJobResult, "result")
		Dim lstIn As List = m.Get("favourites")
		Dim lstOut As List
		lstOut.Initialize
		For Each favIn As Map In lstIn
			Dim favOut As wmKODI_favourite
			favOut.Initialize
			favOut.favType = favIn.GetDefault("type", "")
			favOut.path = favIn.GetDefault("path", "")
			favOut.thumbnail = favIn.GetDefault("thumbnail", "")
			favOut.title = favIn.GetDefault("title", "")
			favOut.window = favIn.GetDefault("window", "")
			favOut.windowParameter = favIn.GetDefault("windowparameter", "")
			lstOut.Add(favOut)
		Next
		lstOut.SortTypeCaseInsensitive("title", True)
		httpJobResult.Put("favourites", lstOut)
	End If
	Return httpJobResult

End Sub

' Plays a favourite of type 'media' or 'window'. Does nothing for other favourite types.
' 'fav' is a favourite that was returned by Favourites_GetFavourites.
Public Sub Favourites_PlayFavourite(fav As wmKODI_favourite)

	Select Case fav.favType
		Case "media"
			Wait For (Player_Open_File(fav.path)) Complete (result As Map)
		Case "window"
			Wait For (GUI_ActivateWindow(fav.window, fav.windowParameter)) Complete (result As Map)
	End Select

End Sub

#End Region ' Methods for the 'Favourites' Namespace

#Region Methods for the 'GUI' Namespace
' Activates the given window.
' See Input_Up for details and an example.
' Window name and parameters are present in Favourites - see Type 'wmKODI_favourite'.
Public Sub GUI_ActivateWindow(window As String, windowParms As String) As ResumableSub

	Dim lstWindowParms As List = Array As String(windowParms)
	Wait For (Xeq("GUI.ActivateWindow", CreateMap("window": window, "parameters": lstWindowParms))) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub
#End Region ' Methods for the 'GUI' Namespace

#Region Methods for the 'Input' Namespace
' Goes back in GUI.
' See Input_Up for details and an example.
Public Sub Input_Back As ResumableSub

	Wait For (Xeq("Input.Back", Null)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Shows the context menu.
' See Input_Up for details and an example.
Public Sub Input_ContextMenu As ResumableSub

	Wait For (Xeq("Input.ContextMenu", Null)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Navigate down in GUI.
' See Input_Up for details and an example.
Public Sub Input_Down As ResumableSub

	Wait For (Xeq("Input.Down", Null)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Goes to home window in GUI.
' See Input_Up for details and an example.
Public Sub Input_Home As ResumableSub

	Wait For (Xeq("Input.Home", Null)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Shows the information dialog (if it is available at that time).
' See Input_Up for details and an example.
Public Sub Input_Info As ResumableSub

	Wait For (Xeq("Input.Info", Null)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Navigate left in GUI.
' See Input_Up for details and an example.
Public Sub Input_Left As ResumableSub

	Wait For (Xeq("Input.Left", Null)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Navigate right in GUI.
' See Input_Up for details and an example.
Public Sub Input_Right As ResumableSub

	Wait For (Xeq("Input.Right", Null)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Select current item in GUI.
' See Input_Up for details and an example.
Public Sub Input_Select As ResumableSub

	Wait For (Xeq("Input.Select", Null)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Show the on-screen display for the current player (if an OSD is available for it).
' See Input_Up for details and an example.
Public Sub Input_ShowOSD As ResumableSub

	Wait For (Xeq("Input.ShowOSD", Null)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Show player process information (if it is available) of the playing item, like video decoder, pixel format, pvr signal strength, ...
' See Input_Up for details and an example.
Public Sub Input_ShowPlayerProcessInfo As ResumableSub

	Wait For (Xeq("Input.ShowPlayerProcessInfo", Null)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Navigate up in GUI.
' Returns a map containing these keys:
' - 'called': the call that was made to the KODI JSON RPC API
' - 'error': if "", all is well; otherwise, it contains the HttpJob's error message
' - 'returned': the info returned by the KODI JSON RPC API (can be "")
' - additional keys may be present depending on the method that was called (see
'   e.g. 'Player_SetSpeed'); for 'Input_Up' there are no such keys
'
' Example:<code>
'
' Dim kodi As wmKODI
' kodi.Initialize("http://192.168.1.5:1234", "", True, True, True)
' Wait For (kodi.Input_Up) Complete (result As Map)
' Log("Called: " & result.Get("called"))
' Log("Returned: " & result.Get("returned"))
' If result.ContainsKey("error") = False Then
'    Log("All is well")
' Else
'    Log("Error: " & result.Get("error"))
' End If
'</code>
Public Sub Input_Up As ResumableSub

	Wait For (Xeq("Input.Up", Null)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub
#End Region ' Methods for the 'Input' Namespace

#Region Methods for the 'JSONRPC' Namespace
' Call an arbitrary KODI JSON RPC API method.
' See https://kodi.wiki/view/JSON-RPC_API/v10 for the available methods and their parameters.
' 'JSONRPCmethod' is the method to be called, e.g. "JSONRPC_Version".
' 'params' is a map containing the method's parameters; if no parameters are expected, use Null.
' This method doesn't belong to any Namespace at all, it's a custom one.
Public Sub Arbitrary_KODI_call(JSONRPCmethod As String, params As Map) As ResumableSub

	Wait For (Xeq(JSONRPCmethod, params)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Retrieve the JSON-RPC protocol version.
' Can also be used to test the connection.
' See Input_Up for details and an example.
' Additional data returned in the resulting map: key='version', value=a map with keys 'major', 'minor', and 'patch'.
Public Sub JSONRPC_Version As ResumableSub

	Wait For (Xeq("JSONRPC.Version", Null)) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then httpJobResult.Put("version", GetAPIresultMapFromHttpJobResult(httpJobResult, "result"))
	Return httpJobResult

End Sub
#End Region ' Methods for the 'JSONRPC' Namespace

#Region Methods for the 'Player' Namespace
' Returns all active players.
' See Input_Up for details and an example.
' Additional data returned in the resulting map: key='playerslist', value=a list of maps with the following keys:
' - 'playerid': the value is the player ID
' - 'type': the value is 'audio', 'picture', or 'video'
Public Sub Player_GetActivePlayers As ResumableSub

	Wait For (Xeq("Player.GetActivePlayers", Null)) Complete (httpJobResult As Map) ' If all went well, 'httpJobResult' contains a list of maps
	If httpJobResult.ContainsKey("error") = False Then httpJobResult.Put("playerslist", GetAPIresultListFromHttpJobResult(httpJobResult)) ' The value is a list of maps
	Return httpJobResult

End Sub

' Retrieves one or more properties of the currently played item.
' See https://kodi.wiki/view/JSON-RPC_API/v10#List.Fields.All for a list of all available item properties.
' Additional data returned in the resulting map: key='properties', value=a map with the requested properties (key=property name, value=property value).
Public Sub Player_GetItem(playerID As Int, properties As List) As ResumableSub

	Wait For (Xeq("Player.GetItem", CreateMap("playerid": playerID, "properties": properties))) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then
		Dim m As Map = GetAPIresultMapFromHttpJobResult(httpJobResult, "result")
		httpJobResult.Put("properties", IIf(httpJobResult.ContainsKey("error") = False, m.Get("item"), ""))
	End If
	Return httpJobResult

End Sub

' Retrieves one property of the currently played item.
' See Player_GetItem for details.
' See https://kodi.wiki/view/JSON-RPC_API/v10#List.Fields.All for a list of all available item properties.
Public Sub Player_GetItemOneProperty(playerID As Int, property As String) As ResumableSub

	Wait For (Player_GetItem(playerID, Array As String(property))) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Retrieves the value of the given property.
' See Player_SetSpeedBackward for details and an example with the 'speed' property.
' See https://kodi.wiki/view/JSON-RPC_API/v10#Player.Property.Name for a list of all available properties.
Public Sub Player_GetOneProperty(playerID As Int, property As String) As ResumableSub

	Wait For (Player_GetProperties(playerID, Array As String(property))) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Get a list of available players.
' See Input_Up for details and an example.
' Additional data returned in the resulting map: key='playerslist', value=a list of maps (one map per player) with following keys:name (string), playsaudio (boolean), playsvideo (boolean), type (string: music/picture/video)
Public Sub Player_GetPlayers As ResumableSub

	Wait For (Xeq("Player.GetPlayers", Null)) Complete (httpJobResult As Map) ' If all went well, 'httpJobResult' contains a list of maps
	If httpJobResult.GetDefault("error", "") = "" Then httpJobResult.Put("playerslist", GetAPIresultListFromHttpJobResult(httpJobResult)) ' The value is a list of maps
	Return httpJobResult

End Sub

' Retrieves the values of the given properties.
' See Player_GetOneProperty for details and an example with the 'speed' property.
' See https://kodi.wiki/view/JSON-RPC_API/v10#Player.Property.Name for a list of all available properties.
' Additional data returned in the resulting map: key='properties', value=a map with the requested properties (key=property name, value=property value).
Public Sub Player_GetProperties(playerID As Int, properties As List) As ResumableSub

	Wait For (Xeq("Player.GetProperties", CreateMap("playerid": playerID, "properties": properties))) Complete (httpJobResult As Map)
	httpJobResult.Put("properties", IIf(httpJobResult.ContainsKey("error") = False, GetAPIresultMapFromHttpJobResult(httpJobResult, "result"), ""))
	Return httpJobResult

End Sub

' Start playback of a single file.
' See Input_Up for details and an example.
Public Sub Player_Open_File(path As String) As ResumableSub

	Dim innerParamsMap As Map = CreateMap("file": path)
	Wait For (Xeq("Player.Open", CreateMap("item": innerParamsMap))) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Pauses or unpauses playback.
' See Input_Up for details and an example.
Public Sub Player_PlayPause(playerID As Int) As ResumableSub

	Wait For (Xeq("Player.PlayPause", CreateMap("playerid": playerID))) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Seek through the playing item by specifying a percentage of the item's duration.
' See Input_Up for details and an example.
Public Sub Player_SeekPercentage(playerID As Int, percentage As Double) As ResumableSub

	Wait For (Xeq("Player.Seek", CreateMap("playerid": playerID, "value": percentage))) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Set the speed of the current playback.
' See Input_Up for details and an example.
' Additional data returned in the resulting map: key='speed', value=the new speed.
Public Sub Player_SetSpeed(playerID As Int, newSpeed As Int) As ResumableSub

	Wait For (Xeq("Player.SetSpeed", CreateMap("playerid": playerID, "speed": newSpeed))) Complete (httpJobResult As Map)
	If httpJobResult.ContainsKey("error") = False Then httpJobResult.Put("speed", IIf(httpJobResult.ContainsKey("error") = False, GetAPIresultStringFromHttpJobResult(httpJobResult, "speed", 1), ""))
	Return httpJobResult

End Sub

' Steps through the 'backward' (reverse) speed of the current playback.
' See Input_Up for details and an example.
' Additional data returned in the resulting map: key='speed', value=the new speed.
Public Sub Player_SetSpeedBackward(playerID As Int) As ResumableSub

	' Get the current speed
	Wait For (Player_GetOneProperty(playerID, "speed")) Complete (httpJobResult As Map)
	If httpJobResult.GetDefault("error", "") <> "" Then Return httpJobResult
	Dim speed As Int = GetAPIresultStringFromHttpJobResult(httpJobResult, "speed", 1)

	' Determine the new speed
	Select Case speed ' -32,-16,-8,-4,-2,-1,0,1,2,4,8,16,32
		Case 2, 4, 8, 16, 32
			speed = speed / 2
		Case -1, -2, -4, -8, -16
			speed = speed * 2
		Case Else
			speed = -1
	End Select

	' Set the new speed
	Wait For (Player_SetSpeed(playerID, speed)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Steps through the 'forward' speed of the current playback.
' See Input_Up for details and an example.
' Additional data returned in the resulting map: key='speed', value=the new speed.
Public Sub Player_SetSpeedForward(playerID As Int) As ResumableSub

	' Get the current speed
	Wait For (Player_GetOneProperty(playerID, "speed")) Complete (httpJobResult As Map)
	If httpJobResult.GetDefault("error", "") <> "" Then Return httpJobResult
	Dim speed As Int = GetAPIresultStringFromHttpJobResult(httpJobResult, "speed", 1)

	' Determine the new speed
	Select Case speed ' -32,-16,-8,-4,-2,-1,0,1,2,4,8,16,32
		Case 1, 2, 4, 8, 16
			speed = speed * 2
		Case -2, -4, -8, -16, -32
			speed = speed / 2
		Case Else
			speed = 1
	End Select

	' Set the new speed
	Wait For (Player_SetSpeed(playerID, speed)) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub

' Stops playback.
' See Input_Up for details and an example.
Public Sub Player_Stop(playerID As Int) As ResumableSub

	Wait For (Xeq("Player.Stop", CreateMap("playerid": playerID))) Complete (httpJobResult As Map)
	Return httpJobResult

End Sub
#End Region ' Methods for the 'Player' Namespace