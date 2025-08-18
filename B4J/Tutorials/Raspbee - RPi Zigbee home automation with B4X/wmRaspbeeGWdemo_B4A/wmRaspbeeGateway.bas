B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
' Standard Class

' By walt61, last modified on 2020-09-10

' Non-core library dependencies:
' - B4A: ByteConverter, JSON, OkHttpUtils2
' - B4J: ByteConverter, Json, jOkHttpUtils2_NONUI (for non-UI programs) or jOkHttpUtils2 (for UI programs)

' Notes:
' - IMPORTANT FOR B4J NON-UI APPS, AS PER https://www.b4x.com/android/forum/threads/resumablesub-dont-work.89719 : see 'StartMessageLoop' and 'StopMessageLoop' in the demo program.
' - Tested with B4A and B4J, assumed to be B4I-compatible as well (but not tested or even tried).
' - The complete Raspbee/Conbee REST API documentation can be found at https://dresden-elektronik.github.io/deconz-rest-doc/
' - Not all of the available REST API calls have been foreseen but it shouldn't be hard to add them if there is a need.
' - A number of methods have been left quite rudimentary but it shouldn't be hard to refine them if there is a need.

' Changes:
' 2019-07-18
' - initial version
' 2019-08-31
' - added 'link' and 'code' tags to the Subs' descriptions
' 2019-12-18
' - added 'websocketnotifyall' and 'websocketport' to Type rbgw_config and filled them in 'GetConfig'
' 2020-08-23
' - GetAllLights and GetLightState now make sure that 'value.state.xy' will always be initialized
' 2020-09-10
' - Added parameter 'debugMode' to method Initialize
' - Added methods GetAllSensorsLumiWeather and GetSensorLumiWeather
' - Updated the comments for methods GetAllSensors and GetSensor
' - Added members ctmin and ctmax to Type rbgw_light
' - Added members onAndReachable, colorloopspeed, and transitiontime to Type rbgw_light_state
' - Added private methods IsUnsignedInteger and IsUnsignedDecimal
' - Method SetLightState now takes care of type testing/changing for the values it's given
' - Integer values returned by the 'Get...' methods now default to -1 instead of 0 (e.g. to indicate when 'hue' is not available for white bulbs)

' Introduction:
' The Raspbee (or Conbee, which is the USB version - the information here will only refer to the Raspbee) from Dresden Elektronik (https://shop.dresden-elektronik.de/raspbee.html, also available elsewhere, e.g. on Amazon) is a Zigbee (https://www.zigbee.org/) radio board for the Raspberry Pi.
' By using this module, the Raspberry Pi becomes a node that can be integrated in a Zigbee network - or used as the sole controller for such a network.
' For instance, Philips Hue and Ikea Tradfri products use the Zigbee standard and can be controlled from the Raspberry Pi with the Raspbee extension.
' When ordering a Raspbee, make sure you select the 'premium' version, which comes with the required firmware loaded.

' Requirements/preparations:
' 'deCONZ' is the software that interfaces with the Raspbee and that runs on the Raspberry Pi. It is important to realise that Dresden Elektronik only supports Raspbian; use any other distro and you're on your own if Murphy strikes.
' If your Linux knowledge goes beyond the basics (mine doesn't), you'll probably be able to get things working on other distros too.
' They have a preinstalled image available (https://phoscon.de/en/conbee2/sdcard) for download which works out of the box. I used the 'stable' image, not one of the beta versions, on an RPi2.
' Make sure your power supply produces 2.5A or more; anything less might not work properly (or not at all).
' After booting the image, do this as well (e.g. from a putty window - https://www.putty.org/) to enable headless usage:
' - sudo systemctl enable deconz
' - sudo systemctl start deconz
' Last but not least, you may want to use Real VNC viewer (https://www.realvnc.com/en/connect/download/viewer/ - or another VNC viewer) to connect to the RPi's graphic desktop, where deCONZ will be running.

' Getting started:
' 1. In the deCONZ UI (which you'll reach via VNC), you'll see your Raspbee and nothing else. Click the 'Plugins' menu, and then 'REST API Plugin'. Then, in the window that pops up, click one of the links to be taken to the browser interface.
' 2. Click your Raspbee's icon, and enter a name and a password. You'll use the name to obtain an API key (see below).
' 3. Use the browser interface to add your light bulbs, plugs, or other devices to your Zigbee network. When adding devices, you'll provide a name for each of them.
' 4. Obtain an API key (see method 'GetAPIkey') as you'll need that to initialise this Class, for communication with deCONZ.
' Now you're ready to use this Class in your B4X programs to interface with your Zigbee network and to control your devices, e.g. switch lights or plugs on and off, and get their current state (as Zigbee provides two-way communication).
' The (limited) demo programs will give you an idea about how to use the Class, and so should the documentation that was added to all its methods.

Sub Class_Globals

	Private su As StringUtils
	Private bc As ByteConverter

	Private m_IP As String = ""
	Private m_APIkey As String = ""
	Private m_debugMode As Boolean = False
	Private m_decimalSeparator As String = "."

	Type rbgw_light(ID As String, hascolor As Boolean, manufacturername As String, modelid As String, name As String, _
					etag As String, swversion As String, type_ As String, uniqueid As String, ctmin As Int, ctmax As Int, _
					state As rbgw_light_state)

	' See https://dresden-elektronik.github.io/deconz-rest-doc/lights/#setstate
	' and https://dresden-elektronik.github.io/deconz-rest-doc/lights/#getstate
	Type rbgw_light_state(alert As String, reachable As Boolean, on As Boolean, onAndReachable As Boolean, bri As Int, colormode As String, _
						ct As Int, effect As String, hue As Int, colorloopspeed As Int, transitiontime As Int, sat As Int, xy As List)

	Type rbgw_config(apiversion As String, dhcp As Boolean, gateway As String, ipaddress As String, _
					linkbutton As Boolean, localtime As String, mac As String, name	As String, _
					netmask As String, networkopenduration As Int, panid As Int, portalservices As Boolean, _
					proxyaddress As String, proxyport As Int, swversion As String, timeformat As String, _
					timezone As String, utc As String, uuid As String, zigbeechannel As Int, _
					websocketnotifyall As Boolean, websocketport As String, _
					swupdate As rbgw_config_swupdate, whitelist As Map)

	Type rbgw_config_swupdate(notify As Boolean, text As String, updatestate As Int, url As String)

	Type rbgw_lumi_weather(ID As String, config As rbgw_lumi_weather_config, ep As String, etag As String, manufacturername As String, modelid As String, name As String, _
						swversion As String, type_ As String, uniqueid As String, _
						state As rbgw_lumi_weather_state)

	Type rbgw_lumi_weather_config(battery As String, offset As String, on As Boolean, reachable As Boolean, onAndReachable As Boolean)

	Type rbgw_lumi_weather_state(lastUpdated As String, temperature As String, humidity As String, pressure As String)

	Type colour_rgb(r As Int, g As Int, b As Int)
	Type colour_xy(x As Double, y As Double)

End Sub

'Initializes the object. Parameters:
'- IP: the IP address of the Raspberry Pi with the Raspbee
'- APIkey: the API key; it can be obtained with method 'GetAPIkey'
'- debugMode: True to log debugging data, False to not do that
Public Sub Initialize(IP As String, APIkey As String, debugMode As Boolean)

	m_IP = IP
	m_APIkey = APIkey
	m_debugMode = debugMode
	m_decimalSeparator = NumberFormat2(1.1, 1, 1, 1, False).SubString2(1, 2)

End Sub

' This method can be called without prior initializing the class, and is only required once.
' It obtains an API key that can subsequently be used for the Initialize method.
' Pass the gateway IP, name, and password, and the device type that were set on the Raspberry Pi by
' starting the REST API (in a browser) from within the deCONZ program.
' In that REST API browser page, go to Gateway, then click the Advanced button, then click
' the Authenticate App button, then run this method within 60 seconds and check the log, where
' you will find 'GetAPIkey success:' and a value for 'username'; that value is your API key.
' It survives reboots and is persistent until you would delete it.
Public Sub GetAPIkey(gatewayIP As String, gatewayName As String, password As String, deviceType As String)

	Try
		Dim Job As HttpJob
		Dim m As Map = CreateMap("devicetype": deviceType)
		Dim jg As JSONGenerator
		jg.Initialize(m)

		Job.Initialize("GetAPIkey", Me)
		Job.PostString("http://" & gatewayIP & "/api", jg.ToString)
		Job.GetRequest.SetHeader("Authorization", "Basic " & su.EncodeBase64(bc.StringToBytes(gatewayName, "UTF-8")) & ":" & su.EncodeBase64(bc.StringToBytes(password, "UTF-8")))

		Wait For (Job) JobDone(Job As HttpJob)
		If Job.Success Then
			Log("GetAPIkey success: " & Job.GetString)
		Else
			Log("GetAPIkey error: " & Job.ErrorMessage)
		End If

		Job.Release
	Catch
		Log("GetAPIkey exception: " & LastException)
	End Try

End Sub

#Region Config
' Returns the current gateway configuration as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' is of Type rbgw_config (see Class_Globals).
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/configuration/#getconfig|https://dresden-elektronik.github.io/deconz-rest-doc/configuration/#getconfig</link> for details.
'
' Example:<code>
'
' Dim rb As wmRaspbeeGateway
' rb.Initialize("192.168.1.5", "27D9D4A8F9")
' Wait For (rb.GetConfig) Complete (result As Map)
' If result.Get("error") = "" Then
'    Dim value As rbgw_config = result.Get("value")
'    Log(value.ipaddress)
' Else
'    Log(result.Get("error"))
' End If
'</code>
Public Sub GetConfig As ResumableSub

	Dim value As rbgw_config
	value.Initialize

	Wait For (RESTget("GetConfig", "config", "")) Complete (result As Map)
	If result.GetDefault("error", "not ok") <> "" Then
		result.Put("value", value)
		Return result
	End If

	Dim parser As JSONParser
	parser.Initialize(result.Get("value"))
	Dim jm As Map = parser.NextObject

	value.apiversion = jm.GetDefault("apiversion", "")
	value.dhcp = GetFromMapAsBoolean(jm, "dhcp", False)
	value.gateway = jm.GetDefault("gateway", "")
	value.ipaddress = jm.GetDefault("ipaddress", "")
	value.linkbutton = GetFromMapAsBoolean(jm, "linkbutton", False)
	value.localtime = jm.GetDefault("localtime", "")
	value.mac = jm.GetDefault("mac", "")
	value.name = jm.GetDefault("name", "")
	value.netmask = jm.GetDefault("netmask", "")
	value.networkopenduration = GetFromMapAsInt(jm, "networkopenduration", -1)
	value.panid = GetFromMapAsInt(jm, "panid", -1)
	value.portalservices = GetFromMapAsBoolean(jm, "portalservices", False)
	value.proxyaddress = jm.GetDefault("proxyaddress", "")
	value.proxyport = GetFromMapAsInt(jm, "proxyport", -1)
	value.swversion = jm.GetDefault("swversion", "")
	value.timeformat = jm.GetDefault("timeformat", "")
	value.timezone = jm.GetDefault("timezone", "")
	value.utc = jm.GetDefault("utc", "")
	value.uuid = jm.GetDefault("uuid", "")
	value.zigbeechannel = GetFromMapAsInt(jm, "zigbeechannel", -1)
	value.websocketnotifyall = GetFromMapAsBoolean(jm, "websocketnotifyall", False)
	value.websocketport = jm.GetDefault("websocketport", "")
	Dim swupdate As Map = jm.GetDefault("swupdate", Null)
	value.swupdate.notify = GetFromMapAsBoolean(swupdate, "swupdate.notify", False)
	value.swupdate.text = swupdate.GetDefault("swupdate.text", "")
	value.swupdate.updatestate = GetFromMapAsInt(swupdate, "swupdate.updatestate", -1)
	value.swupdate.url = swupdate.GetDefault("swupdate.url", "")
	value.whitelist = jm.GetDefault("whitelist", Null)

	result.Put("value", value)
	Return result

End Sub

' Returns the full state of the gateway including all its lights, groups, scenes and schedules as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' contains the JSON returned by the API.
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/configuration/#getfullstate|https://dresden-elektronik.github.io/deconz-rest-doc/configuration/#getfullstate</link> for details.
' Use <link>http://basic4ppc.com:51042/json/index.html|http://basic4ppc.com:51042/json/index.html</link> to get details for parsing 'value'.
' Note: this method could be refined by defining a Type (similar to e.g. 'rbgw_config') and then returning
' a variable of that Type. I didn't do that yet as for the time being I don't need it here.
Public Sub GetFullState As ResumableSub

	Wait For (RESTget("GetFullState", "", "")) Complete (result As Map)
	Return result

End Sub
#End Region ' Config

#Region Groups
' Returns a list of all groups as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' contains the JSON returned by the API.
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/groups/|https://dresden-elektronik.github.io/deconz-rest-doc/groups/</link> for details.
' Use <link>http://basic4ppc.com:51042/json/index.html|http://basic4ppc.com:51042/json/index.html</link> to get details for parsing 'value'.
' Note: this method could be refined by defining a Type (similar to e.g. 'rbgw_config') and then returning
' a variable of that Type. I didn't do that yet as for the time being I don't need it here.
Public Sub GetAllGroups As ResumableSub

	Wait For (RESTget("GetAllGroups", "groups", "")) Complete (result As Map)
	Return result

End Sub

' Returns the full state of a group as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' contains the JSON returned by the API.
' Pass the ID of the group whose data you want to get, and the etag value if it is known (or an empty string if not),
' to reduce overhead if the light's status has not changed (see https://dresden-elektronik.github.io/deconz-rest-doc/polling/).
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/groups/#getattr|https://dresden-elektronik.github.io/deconz-rest-doc/groups/#getattr</link> for details.
' Use <link>http://basic4ppc.com:51042/json/index.html|http://basic4ppc.com:51042/json/index.html</link> to get details for parsing 'value'.
' Note: this method could be refined by defining a Type (similar to e.g. 'rbgw_config') and then returning
' a variable of that Type. I didn't do that yet as for the time being I don't need it here.
Public Sub GetGroupAttributes(groupID As String, etag As String) As ResumableSub

	Wait For (RESTget("GetGroupAttributes", "groups/" & groupID, etag)) Complete (result As Map)
	Return result

End Sub
#End Region ' Groups

#Region Lights
' Returns a list of all lights as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' contains a List of Type rbgw_light.
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/lights/#getall|https://dresden-elektronik.github.io/deconz-rest-doc/lights/#getall</link> for details.
' Notice that plugs (e.g. the Osram Smart Plug) are represented as lights as well by/for deCONZ.
'
' Example:<code>
'
' Dim rb As wmRaspbeeGateway
' rb.Initialize("192.168.1.5", "27D9D4A8F9")
' Wait For (rb.GetAllLights) Complete (result As Map)
' If result.Get("error") = "" Then
'    Log(result.Get("value"))
' Else
'    Log(result.Get("error"))
' End If
'</code>
Public Sub GetAllLights As ResumableSub

	Dim value As List
	value.Initialize

	Wait For (RESTget("GetAllLights", "lights", "")) Complete (result As Map)
	If result.GetDefault("error", "not ok") <> "" Then
		result.Put("value", value)
		Return result
	End If

	Dim parser As JSONParser
	parser.Initialize(result.Get("value"))
	Dim jm As Map = parser.NextObject
	Dim i As Int

	For i = 0 To (jm.Size - 1)
		Dim m As Map = jm.GetValueAt(i)
		Dim oneValue As rbgw_light
		oneValue.Initialize
		oneValue.ID = jm.GetKeyAt(i)
		oneValue.hascolor = GetFromMapAsBoolean(m, "hascolor", False)
		oneValue.ctmin = GetFromMapAsInt(m, "ctmin", -1)
		oneValue.ctmax = GetFromMapAsInt(m, "ctmax", -1)
		oneValue.manufacturername = m.GetDefault("manufacturername", "")
		oneValue.modelid = m.GetDefault("modelid", "")
		oneValue.name = m.GetDefault("name", "")
		oneValue.etag = m.GetDefault("etag", "")
		oneValue.swversion = m.GetDefault("swversion", "")
		oneValue.type_ = m.GetDefault("type", "")
		oneValue.uniqueid = m.GetDefault("uniqueid", "")
		Dim mState As Map = m.GetDefault("state", Null)
		oneValue.state.alert = mState.GetDefault("alert", "")
		oneValue.state.reachable = GetFromMapAsBoolean(mState, "reachable", False)
		oneValue.state.on = GetFromMapAsBoolean(mState, "on", False)
		oneValue.state.onAndReachable = oneValue.state.on And oneValue.state.reachable
		oneValue.state.bri = GetFromMapAsInt(mState, "bri", -1)
		oneValue.state.colormode = mState.GetDefault("colormode", "")
		oneValue.state.ct = GetFromMapAsInt(mState, "ct", -1)
		oneValue.state.effect = mState.GetDefault("effect", "")
		oneValue.state.colorloopspeed = GetFromMapAsInt(mState, "colorloopspeed", -1)
		oneValue.state.transitiontime = GetFromMapAsInt(mState, "transitiontime", -1)
		oneValue.state.hue = GetFromMapAsInt(mState, "hue", -1)
		oneValue.state.sat = GetFromMapAsInt(mState, "sat", -1)
		Dim xy As List
		xy.Initialize
		Try
			oneValue.state.xy = mState.GetDefault("xy", Null)
			If oneValue.state.xy.IsInitialized = False Then oneValue.state.xy = xy
		Catch
			Log("GetAllLights - state.xy exception: " & LastException)
			oneValue.state.xy = xy
		End Try
		value.Add(oneValue)
	Next

	result.Put("value", value)
	Return result

End Sub

' Returns a light's ID as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' contains the ID of the light whose name was passed 'lightName'.
' Notice that plugs (e.g. the Osram Smart Plug) are represented as lights as well by/for deCONZ.
'
' Example:<code>
'
' Dim rb As wmRaspbeeGateway
' rb.Initialize("192.168.1.5", "27D9D4A8F9")
' Wait For (rb.GetLightIDbyName("Osram Bulb")) Complete (result As Map)
' If result.Get("error") = "" Then
'    Log(result.Get("value"))
' Else
'    Log(result.Get("error"))
' End If
'</code>
Public Sub GetLightIDbyName(lightName As String) As ResumableSub

	Dim lightNameLowerCase As String = lightName.ToLowerCase

	Wait For (RESTget("GetAllLights", "lights", "")) Complete (result As Map)
	If result.GetDefault("error", "not ok") <> "" Then
		result.Put("value", "")
		Return result
	End If

	Dim parser As JSONParser
	parser.Initialize(result.Get("value"))
	Dim jm As Map = parser.NextObject
	Dim i As Int

	result.Put("value", "")
	For i = 0 To (jm.Size - 1)
		Dim m As Map = jm.GetValueAt(i)
		Dim name As String = m.GetDefault("name", "")
		If name.ToLowerCase = lightNameLowerCase Then
			result.Put("value", jm.GetKeyAt(i))
			Exit
		End If
	Next

	Return result

End Sub

' Returns the full state of a light as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' is of Type rbgw_light (see Class_Globals).
' Pass the ID of the light whose data you want to get, and the rbgw_light.etag value if it is known (or an empty string if not),
' to reduce overhead if the light's status has not changed (see https://dresden-elektronik.github.io/deconz-rest-doc/polling/).
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/lights/#getstate|https://dresden-elektronik.github.io/deconz-rest-doc/lights/#getstate</link> for details.
' Notice that plugs (e.g. the Osram Smart Plug) are represented as lights as well by/for deCONZ.
'
' Example:<code>
'
' Dim rb As wmRaspbeeGateway
' rb.Initialize("192.168.1.5", "27D9D4A8F9")
' Wait For (rb.GetLightState("1", "")) Complete (result As Map)
' If result.Get("error") = "" Then
'	 Dim light As rbgw_light = result.Get("value")
'	 If light.state.onAndReachable Then
'       Log("The light is on and reachable")
'    Else
'       Log("The light is off or unreachable")
'    End If
' Else
'    Log(result.Get("error"))
' End If
'</code>
Public Sub GetLightState(lightID As String, etag As String) As ResumableSub

	Dim value As rbgw_light
	value.Initialize

	Wait For (RESTget("GetLightState", "lights/" & lightID, etag)) Complete (result As Map)
	If result.GetDefault("error", "not ok") <> "" Then
		result.Put("value", value)
		Return result
	End If

	Dim parser As JSONParser
	parser.Initialize(result.Get("value"))
	Dim jm As Map = parser.NextObject

	value.ID = lightID
	value.etag = jm.GetDefault("etag", "")
	value.ctmin = GetFromMapAsInt(jm, "ctmin", -1)
	value.ctmax = GetFromMapAsInt(jm, "ctmax", -1)
	value.hascolor = GetFromMapAsBoolean(jm, "hascolor", False)
	value.manufacturername = jm.GetDefault("manufacturername", "")
	value.modelid = jm.GetDefault("modelid", "")
	value.name = jm.GetDefault("name", "")
	value.swversion = jm.GetDefault("swversion", "")
	value.type_ = jm.GetDefault("type", "")
	value.uniqueid = jm.GetDefault("uniqueid", "")
	Dim mState As Map = jm.GetDefault("state", Null)
	value.state.alert = mState.GetDefault("alert", "")
	value.state.reachable = GetFromMapAsBoolean(mState, "reachable", False)
	value.state.on = GetFromMapAsBoolean(mState, "on", False)
	value.state.onAndReachable = value.state.on And value.state.reachable
	value.state.bri = GetFromMapAsInt(mState, "bri", -1)
	value.state.colormode = mState.GetDefault("colormode", "")
	value.state.ct = GetFromMapAsInt(mState, "ct", -1)
	value.state.effect = mState.GetDefault("effect", "")
	value.state.colorloopspeed = GetFromMapAsInt(mState, "colorloopspeed", -1)
	value.state.transitiontime = GetFromMapAsInt(mState, "transitiontime", -1)
	value.state.hue = GetFromMapAsInt(mState, "hue", -1)
	value.state.sat = GetFromMapAsInt(mState, "sat", -1)
	Dim xy As List
	xy.Initialize
	Try
		value.state.xy = mState.GetDefault("xy", Null)
		If value.state.xy.IsInitialized = False Then value.state.xy = xy
	Catch
		Log("GetLightState - state.xy exception: " & LastException)
		value.state.xy = xy
	End Try

	result.Put("value", value)
	Return result

End Sub

' Sets various parameters of the state of a light and returns the result as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' is a JSON string that reports back about what has been set.
' Pass the ID of the light whose data you want to get, and the parameters you want to set (names and values).
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/lights/#setstate|https://dresden-elektronik.github.io/deconz-rest-doc/lights/#setstate</link> for the parameters that can be passed in Map 'parms'.
' Notice that plugs (e.g. the Osram Smart Plug) are represented as lights as well by/for deCONZ.
'
' Example:<code>
'
' Dim rb As wmRaspbeeGateway
' rb.Initialize("192.168.1.5", "27D9D4A8F9")
' Wait For (rb.GetLightState("1", "")) Complete (result As Map)
' If result.Get("error") = "" Then
'	Dim light As rbgw_light = result.Get("value")
'	Dim m As Map
'	m.Initialize
'	m.Put("on", Not(light.state.on)) ' On/off
'   m.Put("bri", 100) ' Set brightness
'   m.Put("hue", 10000) ' Set hue
'	Wait For (rb.SetLightState("1", m)) Complete (result As Map)
'	If result.Get("error") <> "" Then Log(result.Get("error"))
' End If
'</code>
Public Sub SetLightState(lightID As String, parms As Map) As ResumableSub

	Dim result As Map = CreateMap("error": "", "value": Null)

	Try
		Dim goodParms As Map
		goodParms.Initialize
		For Each k As String In parms.Keys
			If parms.Get(k) Is String Then
				Dim s As String = parms.Get(k)
				If (s.ToLowerCase = "true") Or (s.ToLowerCase = "false") Then
					Dim bool1 As Boolean = s
					goodParms.Put(k.ToLowerCase, bool1)
				Else If IsUnsignedInteger(s, False) Then
					Dim int1 As Int = s
					goodParms.Put(k.ToLowerCase, int1)
				Else If IsUnsignedDecimal(s, False, m_decimalSeparator) Then
					Dim dbl1 As Double = s
					goodParms.Put(k.ToLowerCase, dbl1)
				Else
					goodParms.Put(k.ToLowerCase, s.ToLowerCase)
				End If
			Else
				goodParms.Put(k.ToLowerCase, parms.Get(k))
			End If
		Next

		Dim Job As HttpJob
		Dim jg As JSONGenerator
		jg.Initialize(goodParms)

		Job.Initialize("SetLightState", Me)
		Job.PutString("http://" & m_IP & "/api/" & m_APIkey & "/lights/" & lightID & "/state", jg.ToString)

		Wait For (Job) JobDone(Job As HttpJob)
		If m_debugMode Then Log("SetLightState:" & CRLF & "* parms: " & jg.ToString & CRLF & "* error: " & Job.ErrorMessage & CRLF & "* result: " & Job.GetString)
		If Job.Success Then
			result.Put("value", Job.GetString)
		Else
			result.Put("error", Job.ErrorMessage)
		End If

		Job.Release
	Catch
		result.Put("error", LastException)
	End Try

	Return result

End Sub
#End Region ' Lights

#Region Rules
' Returns a list of all rules as a map with keys 'error' and 'value'. If there are no rules in the system Then an empty object {} will be returned.
' If 'error' is an empty string, all went well and 'value' contains the JSON returned by the API.
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/rules/#getall|https://dresden-elektronik.github.io/deconz-rest-doc/rules/#getall</link> for details.
' Use <link>http://basic4ppc.com:51042/json/index.html|http://basic4ppc.com:51042/json/index.html</link> to get details for parsing 'value'.
' Note: this method could be refined by defining a Type (similar to e.g. 'rbgw_config') and then returning
' a variable of that Type. I didn't do that yet as for the time being I don't need it here.
Public Sub GetAllRules As ResumableSub

	Wait For (RESTget("GetAllRules", "rules", "")) Complete (result As Map)
	Return result

End Sub

' Returns the rule with the specified id as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' contains the JSON returned by the API.
' Pass the ID of the rule whose data you want to get.
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/rules/#getrule|https://dresden-elektronik.github.io/deconz-rest-doc/rules/#getrule</link> for details.
' Use <link>http://basic4ppc.com:51042/json/index.html|http://basic4ppc.com:51042/json/index.html</link> to get details for parsing 'value'.
' Note: this method could be refined by defining a Type (similar to e.g. 'rbgw_config') and then returning
' a variable of that Type. I didn't do that yet as for the time being I don't need it here.
Public Sub GetRule(ruleID As String) As ResumableSub

	Wait For (RESTget("GetRule", "rules/" & ruleID, "")) Complete (result As Map)
	Return result

End Sub
#End Region ' Rules

#Region Scenes
' Returns a list of all scenes of a group as a map with keys 'error' and 'value'. If there are no scenes in the system Then an empty object {} will be returned.
' If 'error' is an empty string, all went well and 'value' contains the JSON returned by the API.
' Pass the ID of the group whose data you want to get.
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/scenes/#getall|https://dresden-elektronik.github.io/deconz-rest-doc/scenes/#getall</link> for details.
' Use <link>http://basic4ppc.com:51042/json/index.html|http://basic4ppc.com:51042/json/index.html</link> to get details for parsing 'value'.
' Note: this method could be refined by defining a Type (similar to e.g. 'rbgw_config') and then returning
' a variable of that Type. I didn't do that yet as for the time being I don't need it here.
Public Sub GetAllScenes(groupID As String) As ResumableSub

	Wait For (RESTget("GetAllScenes", "groups/" & groupID & "/scenes", "")) Complete (result As Map)
	Return result

End Sub

' Returns the scene with the specified id as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' contains the JSON returned by the API.
' Pass the IDs of the group and scene whose data you want to get.
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/scenes/#getattr|https://dresden-elektronik.github.io/deconz-rest-doc/scenes/#getattr</link> for details.
' Use <link>http://basic4ppc.com:51042/json/index.html|http://basic4ppc.com:51042/json/index.html</link> to get details for parsing 'value'.
' Note: this method could be refined by defining a Type (similar to e.g. 'rbgw_config') and then returning
' a variable of that Type. I didn't do that yet as for the time being I don't need it here.
Public Sub GetSceneAttributes(groupID As String, sceneID As String) As ResumableSub

	Wait For (RESTget("GetSceneAttributes", "groups/" & groupID & "/scenes/" & sceneID, "")) Complete (result As Map)
	Return result

End Sub
#End Region ' Scenes

#Region Schedules
' Returns a list of all schedules as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' contains the JSON returned by the API.
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/schedules/#getall|https://dresden-elektronik.github.io/deconz-rest-doc/schedules/#getall</link> for details.
' Use <link>http://basic4ppc.com:51042/json/index.html|http://basic4ppc.com:51042/json/index.html</link> to get details for parsing 'value'.
' Note: this method could be refined by defining a Type (similar to e.g. 'rbgw_config') and then returning
' a variable of that Type. I didn't do that yet as for the time being I don't need it here.
Public Sub GetAllSchedules As ResumableSub

	Wait For (RESTget("GetAllSchedules", "schedules", "")) Complete (result As Map)
	Return result

End Sub

' Returns all attributes of a schedule as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' contains the JSON returned by the API.
' Pass the ID of the schedule whose data you want to get.
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/Schedules/#getattr|https://dresden-elektronik.github.io/deconz-rest-doc/Schedules/#getattr</link> for details.
' Use <link>http://basic4ppc.com:51042/json/index.html|http://basic4ppc.com:51042/json/index.html</link> to get details for parsing 'value'.
' Note: this method could be refined by defining a Type (similar to e.g. 'rbgw_config') and then returning
' a variable of that Type. I didn't do that yet as for the time being I don't need it here.
Public Sub GetScheduleAttributes(scheduleID As String) As ResumableSub

	Wait For (RESTget("GetScheduleAttributes", "schedules/" & scheduleID, "")) Complete (result As Map)
	Return result

End Sub
#End Region ' Schedules

#Region Sensors/Switches
' Returns a list of all sensors/switches as a map with keys 'error' and 'value'. If there are no sensors in the system Then an empty object {} will be returned.
' If 'error' is an empty string, all went well and 'value' contains the JSON returned by the API.
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/sensors/#getall|https://dresden-elektronik.github.io/deconz-rest-doc/sensors/#getall</link> for details.
' Use <link>http://basic4ppc.com:51042/json/index.html|http://basic4ppc.com:51042/json/index.html</link> to get details for parsing 'value'.
' Note: different sensors appear to return different values. Therefore, defining a Type (similar to e.g. 'rbgw_config') and then returning
' a variable of that Type is not an option here. A separate method and Type should be created for each type of sensor.
Public Sub GetAllSensors As ResumableSub

	Wait For (RESTget("GetAllSensors", "sensors", "")) Complete (result As Map)
	Return result

End Sub

' Returns the sensor/switch with the specified id as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' contains the JSON returned by the API.
' Pass the ID of the sensor whose data you want to get.
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/sensors/#getsensor|https://dresden-elektronik.github.io/deconz-rest-doc/sensors/#getsensor</link> for details.
' Use <link>http://basic4ppc.com:51042/json/index.html|http://basic4ppc.com:51042/json/index.html</link> to get details for parsing 'value'.
' Note: different sensors appear to return different values. Therefore, defining a Type (similar to e.g. 'rbgw_config') and then returning
' a variable of that Type is not an option here. A separate method and Type should be created for each type of sensor.
Public Sub GetSensor(sensorID As String) As ResumableSub

	Wait For (RESTget("GetSensor", "sensors/" & sensorID, "")) Complete (result As Map)
	Return result

End Sub

' Returns a list of all sensors with manufacturername='LUMI' and modelid='lumi.weather' as a map with keys 'error' and 'value'.
' If 'error' is an empty string, all went well and 'value' contains a List of Type rbgw_lumi_weather.
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/lights/#getall|https://dresden-elektronik.github.io/deconz-rest-doc/lights/#getall</link> for details.
' Notice that plugs (e.g. the Osram Smart Plug) are represented as lights as well by/for deCONZ.
'
' Example:<code>
'
' Dim rb As wmRaspbeeGateway
' rb.Initialize("192.168.1.5", "27D9D4A8F9")
' Wait For (rb.GetAllSensorsLumiWeather) Complete (result As Map)
' If result.Get("error") = "" Then
'    Log(result.Get("value"))
' Else
'    Log(result.Get("error"))
' End If
'</code>
Public Sub GetAllSensorsLumiWeather As ResumableSub

	Dim value As List
	value.Initialize

	Wait For (RESTget("GetAllSensors", "sensors", "")) Complete (result As Map)
	If result.GetDefault("error", "not ok") <> "" Then
		result.Put("value", value)
		Return result
	End If

	Dim parser As JSONParser
	parser.Initialize(result.Get("value"))
	Dim jm As Map = parser.NextObject
	Dim i As Int

	For i = 0 To (jm.Size - 1)
		Dim m As Map = jm.GetValueAt(i)
		Dim manuf As String = m.GetDefault("manufacturername", "")
		Dim model As String = m.GetDefault("modelid", "")
		If (manuf.ToLowerCase <> "lumi") Or (model.ToLowerCase <> "lumi.weather") Then Continue
		Dim oneValue As rbgw_lumi_weather
		oneValue.Initialize
		oneValue.ID = jm.GetKeyAt(i)
		oneValue.ep = m.GetDefault("ep", "")
		oneValue.etag = m.GetDefault("etag", "")
		oneValue.manufacturername = manuf
		oneValue.modelid = model
		oneValue.name = m.GetDefault("name", "")
		oneValue.swversion = m.GetDefault("swversion", "")
		oneValue.type_ = m.GetDefault("type", "")
		oneValue.uniqueid = m.GetDefault("uniqueid", "")
		Dim mConfig As Map = m.GetDefault("config", Null)
		oneValue.config.battery = mConfig.GetDefault("battery", "")
		oneValue.config.offset = mConfig.GetDefault("offset", "")
		oneValue.config.on = GetFromMapAsBoolean(mConfig, "on", False)
		oneValue.config.reachable = GetFromMapAsBoolean(mConfig, "reachable", False)
		oneValue.config.onAndReachable = oneValue.config.on And oneValue.config.reachable
		Dim mState As Map = m.GetDefault("state", Null)
		oneValue.state.lastUpdated = mState.GetDefault("lastupdated", "")
		oneValue.state.humidity = mState.GetDefault("humidity", "")
		oneValue.state.pressure = mState.GetDefault("pressure", "")
		oneValue.state.temperature = mState.GetDefault("temperature", "")
		If oneValue.state.humidity = "" Then oneValue.state.humidity = "0000"
		If oneValue.state.pressure = "" Then oneValue.state.pressure = "0000"
		If oneValue.state.temperature = "" Then oneValue.state.temperature = "0000"
		value.Add(oneValue)
	Next

	result.Put("value", value)
	Return result

End Sub

' Returns the data for the sensor with the specified ID as a map with keys 'error' and 'value'.
' It is intended for a sensor with manufacturername='LUMI' and modelid='lumi.weather'.
' This sensor can be purchased as e.g. the 'Aqara Smart Air Pressure Temperature Humidity Environmental Sensor Intelligent Control'.
' If 'error' is an empty string, all went well and 'value' is of Type rbgw_lumi_weather (see Class_Globals).
' Pass the ID of the sensor whose data you want to get.
' See <link>https://dresden-elektronik.github.io/deconz-rest-doc/sensors/#getsensor|https://dresden-elektronik.github.io/deconz-rest-doc/sensors/#getsensor</link> for details.
' Use <link>http://basic4ppc.com:51042/json/index.html|http://basic4ppc.com:51042/json/index.html</link> to get details for parsing 'value'.
'
' Example:<code>
'
' Dim rb As wmRaspbeeGateway
' rb.Initialize("192.168.1.5", "27D9D4A8F9")
' Wait For (rb.GetSensorLumiWeather("1")) Complete (result As Map)
' If result.Get("error") = "" Then
'	Dim sensor As rbgw_lumi_weather = result.Get("value")
'   Log("Is the sensor on and reachable? : " & sensor.config.onAndReachable)
' End If
'</code>
Public Sub GetSensorLumiWeather(sensorID As String, etag As String) As ResumableSub

	Dim value As rbgw_lumi_weather
	value.Initialize

	Wait For (RESTget("GetSensor", "sensors/" & sensorID, etag)) Complete (result As Map)
	If result.GetDefault("error", "not ok") <> "" Then
		result.Put("value", value)
		Return result
	End If

	Dim parser As JSONParser
	parser.Initialize(result.Get("value"))
	Dim jm As Map = parser.NextObject

	Dim manuf As String = jm.GetDefault("manufacturername", "")
	Dim model As String = jm.GetDefault("modelid", "")

	If (manuf.ToLowerCase <> "lumi") Or (model.ToLowerCase <> "lumi.weather") Then
		result.Put("error", "Sensor ID " & sensorID & " is not a Lumi weather sensor")
		result.Put("value", value)
		Return result
	End If

	value.ID = sensorID
	value.ep = jm.GetDefault("ep", "")
	value.etag = jm.GetDefault("etag", "")
	value.manufacturername = manuf
	value.modelid = model
	value.name = jm.GetDefault("name", "")
	value.swversion = jm.GetDefault("swversion", "")
	value.type_ = jm.GetDefault("type", "")
	value.uniqueid = jm.GetDefault("uniqueid", "")
	Dim mConfig As Map = jm.GetDefault("config", Null)
	value.config.battery = mConfig.GetDefault("battery", "")
	value.config.offset = mConfig.GetDefault("offset", "")
	value.config.on = GetFromMapAsBoolean(mConfig, "on", False)
	value.config.reachable = GetFromMapAsBoolean(mConfig, "reachable", False)
	value.config.onAndReachable = value.config.on And value.config.reachable
	Dim mState As Map = jm.GetDefault("state", Null)
	value.state.lastUpdated = mState.GetDefault("lastupdated", "")
	value.state.humidity = mState.GetDefault("humidity", "")
	value.state.pressure = mState.GetDefault("pressure", "")
	value.state.temperature = mState.GetDefault("temperature", "")
	If value.state.humidity = "" Then value.state.humidity = "0000"
	If value.state.pressure = "" Then value.state.pressure = "0000"
	If value.state.temperature = "" Then value.state.temperature = "0000"

	result.Put("value", value)
	Return result

End Sub
#End Region ' Sensors/Switches

#Region Other
' Used by all the Get... methods except GetAPIkey.
Private Sub RESTget(jobID As String, URL As String, etag As String) As ResumableSub

	Dim m As Map
	m.Initialize

	Try
		Dim Job As HttpJob
		Job.Initialize(jobID, Me)
		If URL.StartsWith("/") Then
			Job.Download("http://" & m_IP & "/api/" & m_APIkey & URL)
		Else
			Job.Download("http://" & m_IP & "/api/" & m_APIkey & "/" & URL)
		End If
		' This is being ignored at the moment as it doesn't seem to work with my current setup,
		' and I want to avoid breaking things if it would start having an effect after any kind of update.
		'If etag <> "" Then Job.GetRequest.SetHeader("If-None-Match", etag)
		Wait For (Job) JobDone(Job As HttpJob)
		If Job.Success = False Then
			' Possibly, if etag handling is activated, some additional tests/actions must be done here
			m.Put("error", Job.ErrorMessage)
			m.Put("value", "")
		Else
			m.Put("error", "")
			m.Put("value", Job.GetString)
		End If
		Job.Release
	Catch
		m.Put("error", LastException)
		m.Put("value", "")
	End Try

	Return m

End Sub

Private Sub GetFromMapAsInt(m As Map, key As String, deflt As Object) As Int

	Try
		Return m.GetDefault(key, deflt)
	Catch
		Return deflt
	End Try

End Sub

Private Sub GetFromMapAsBoolean(m As Map, key As String, deflt As Object) As Boolean

	Try
		Dim s As String = m.GetDefault(key, deflt)
		Select Case s.Trim.ToLowerCase
			Case "true"
				Return True
			Case "false"
				Return False
			Case Else
				Return deflt
		End Select
	Catch
		Return deflt
	End Try

End Sub

Private Sub IsUnsignedInteger(s As String, allowNullString As Boolean) As Boolean

	' Regex expression based on http://regexlib.com/Search.aspx?k=integer&AspxAutoDetectCookieSupport=1
	If allowNullString And (s = "") Then
		Return True
	Else
		Return IsNumber(s) And Regex.IsMatch("^\d+$", s)
	End If

End Sub

Private Sub IsUnsignedDecimal(s As String, allowNullString As Boolean, decSep As String) As Boolean

	Dim sep As String
	If decSep.Trim = "" Then
		sep = m_decimalSeparator
	Else
		sep = decSep
	End If

	' Regex expression based on https://community.oracle.com/thread/429716
	If allowNullString And (s = "") Then
		Return True
	Else
		Return IsNumber(s) And Regex.IsMatch("^(\" & sep & "[0-9]+|[0-9]+(\" & sep & "[0-9]*)*)$", s)
	End If

End Sub
#End Region ' Other