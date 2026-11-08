B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'Ctrl + click to create the B4Xlib: ide://run?File=%ADDITIONAL%\B4XLibMaker.jar&Args=|%ADDITIONAL%\B4XLibMakerSettings.txt|wmSMA
' Standard Class

#Region Documentation and Dependencies
' By walt61, last modified: see 'Changes' below
' Code ported from Python to B4X: https://github.com/Dymerz/SMA-SunnyBoy#

' Purpose:
' To connect to and read data (such as the current solar power production) from an SMA Sunny Boy inverter. The Sunny Boy must have been added to your LAN or WLAN - see https://www.sma-sunny.com/en/service-tip-how-to-connect-a-sunny-boy-inverter-with-built-in-wifi-to-a-local-wireless-network/ for instructions.

' Library dependencies (all are internal libraries):
' JavaObject, [j]OkHttpUtils2, Json

' Notes:
' - IMPORTANT FOR B4J NON-UI APPS, AS PER https://www.b4x.com/android/forum/threads/resumablesub-dont-work.89719 : see 'StartMessageLoop' and 'StopMessageLoop' in the demo program.
' - Tested with B4A and B4J, assumed to be B4I-compatible as well (but not tested or even tried).

' Other useful files on the device, mentioned as comments in the original Python code:
' - login: '/login.json',
' - logout: '/logout.json',
' - getTime: '/getTime.json',
' - getValues: '/getValues.json',
' - getAllOnlValues: '/getAllOnlValues.json',
' - getAllParamValues: '/getAllParamValues.json',
' - setParamValues: '/setParamValues.json',
' - getWebSrvConf: '/getWebSrvConf.json',
' - getEventsModal: '/getEvents.json',
' - getEvents: '/getEvents.json',
' - getLogger: '/getLogger.json',
' - getBackup: '/getConfigFile.json',
' - loginGridGuard: '/loginSR.json',
' - sessionCheck: '/sessionCheck.json',
' - setTime: '/setTime.json',
' - backupUpdate: 'input_file_backup.htm',
' - fwUpdate: 'input_file_update.htm',
' - SslCertUpdate: 'input_file_ssl.htm'

' MIT License for the original Python code:
'   Copyright (c) 2020 Urbain Corentin
'
'   Permission is hereby granted, free of charge, to any person obtaining a copy
'   of this software and associated documentation files (the "Software"), to deal
'   in the Software without restriction, including without limitation the rights
'   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
'   copies of the Software, and to permit persons to whom the Software is
'   furnished to do so, subject to the following conditions:
'
'   The above copyright notice and this permission notice shall be included in all
'   copies or substantial portions of the Software.
'
'   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
'   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
'   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
'   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
'   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
'   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
'   SOFTWARE.
#End Region ' Documentation and Dependencies

#Region Changes
' B4XLibMakerVersion=0.01

' 2025-07-08
' - initial version
#End Region ' Changes

Sub Class_Globals

	Private ip As String
	Private cookie As String = ""
	Private url As String
	Private lsid As String = ""
	Private ssid As String = ""
	Private serial As String = ""
	Private user As String = "usr"
	Private password As String
	Private port As Int
	Private useSSL As Boolean = False
	Private emptyMap As Map
	Private emptyList As List
	Private connectionMade As Boolean = False
	Private acceptLanguage As String = "en,en-US;q=0.8, nl;q=0.5"

	Type wmSMAdataType(device_error As String, _
						device_state As String, _
						device_warning As String, _
						ethernet_counter_status As String, _
						ethernet_dns As String, _
						ethernet_gateway As String, _
						ethernet_ip As String, _
						ethernet_netmask As String, _
						ethernet_status As String, _
						injection_time As String, _
						power_ab As String, _
						power_amp As String, _
						power_b As String, _
						power_current As String, _
						power_total As String, _
						productivity_day As String, _
						productivity_total As String, _
						server_dns As String, _
						server_gatewy As String, _
						server_ip As String, _
						server_netmask As String, _
						service_time As String, _
						tide_ab As String, _
						voltage_ab As String, _
						wlan_dns As String, _
						wlan_gateway As String, _
						wlan_ip As String, _
						wlan_netmask As String, _
						wlan_scan_status As String, _
						wlan_status As String, _
						wlan_strength As String)
	Public DATA As wmSMAdataType
	Private DATAitems As Map

	Type wmSMAresult(success As Boolean, errorText As String, result As Object)

End Sub

#Region PublicSubs
'Initializes the object. You can add parameters to this method if needed.
'Parameters:
'- ip1: the IP of the SMA
'- installer: True to connect as Installer, False to connect as User
'- password1: the password with which to connect
'- port1: the SMA web port to which to connect; the Sunny Boy's default port is 443 when using SSL, otherwise it is 80
'- useSSL1: True or False, to indicate whether or not SSL must be used to connect
'- acceptLanguage1: the 'Accept-Language' value to use for the http headers (see <link>https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Accept-Language|https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Accept-Language</link>); an empty string defaults to "en,en-US;q=0.8, nl;q=0.5"
Public Sub Initialize(ip1 As String, installer As Boolean, password1 As String, port1 As Int, useSSL1 As Boolean, acceptLanguage1 As String)

	emptyMap.Initialize
	emptyList.Initialize

	ip = ip1
	If installer Then user = "istl"
	password = password1
	port = port1
	useSSL = useSSL1
	url = IIf(useSSL, "https", "http") & "://" & ip & ":" & port
	If acceptLanguage1 <> "" Then acceptLanguage = acceptLanguage1

	' Init DATA; status:
	' - 1725 -> offline
	' - 307  -> online
	DATAitems.Initialize
	DATA.device_error = CreateDataItem("6100_00412000", "W")
	DATA.device_state = CreateDataItem("6180_084B1E00", "W")
	DATA.device_warning = CreateDataItem("6100_00411F00", "W")
	DATA.ethernet_counter_status = CreateDataItem("6180_084AAA00", "status")
	DATA.ethernet_dns = CreateDataItem("6800_10AA6400", "")
	DATA.ethernet_gateway = CreateDataItem("6800_10AA6300", "")
	DATA.ethernet_ip = CreateDataItem("6800_10AA6100", "")
	DATA.ethernet_netmask = CreateDataItem("6800_10AA6200", "")
	DATA.ethernet_status = CreateDataItem("6180_084A9600", "status")
	DATA.injection_time = CreateDataItem("6400_00462F00", "s")
	DATA.power_ab = CreateDataItem("6380_40251E00", "")
	DATA.power_amp = CreateDataItem("6100_40465300", "A")
	DATA.power_b = CreateDataItem("6380_40451F00", "")
	DATA.power_current = CreateDataItem("6100_40263F00", "W")
	DATA.power_total = CreateDataItem("6400_00260100", "W")
	DATA.productivity_day = CreateDataItem("6400_00262200", "")
	DATA.productivity_total = CreateDataItem("6400_00260100", "")
	DATA.server_dns = CreateDataItem("6180_104A9D00", "")
	DATA.server_gatewy = CreateDataItem("6180_104A9C00", "")
	DATA.server_ip = CreateDataItem("6180_104A9A00", "")
	DATA.server_netmask = CreateDataItem("6180_104A9B00", "")
	DATA.service_time = CreateDataItem("6400_00462E00", "s")
	DATA.tide_ab = CreateDataItem("6380_40452100", "")
	DATA.voltage_ab = CreateDataItem("6380_40451F00", "")
	DATA.wlan_dns = CreateDataItem("6180_104ABA00", "")
	DATA.wlan_gateway = CreateDataItem("6180_104AB900", "")
	DATA.wlan_ip = CreateDataItem("6180_104AB700", "")
	DATA.wlan_netmask = CreateDataItem("6180_104AB800", "")
	DATA.wlan_scan_status = CreateDataItem("6180_084ABB00", "")
	DATA.wlan_status = CreateDataItem("6180_084ABC00", "status")
	DATA.wlan_strength = CreateDataItem("6100_004AB600", "")

End Sub

' B4Xlib information:
' - Dependencies (all are internal libraries):
'   - B4A: JavaObject, JSON, OkHttpUtils2
'   - B4J: JavaObject, Json, jOkHttpUtils2, jOkHttpUtils2
' - Additional jars needed: none
' - Contains Type definitions: wmSMAdataType, wmSMAresult
Public Sub B4XLibInfo
' This method is only used to document dependencies, additional jars, etc
End Sub

' Returns the Sunny Boy's serial number (after successfully having used one of the Get... methods)
Public Sub getSerialNumber As String

	Return serial

End Sub

' Establishes a new connection. Returns a variable of tyoe wmSMAresult (member 'result' is not used).
' Example:<code>
'
' Dim wmSMA1 As wmSMA
' wmSMA1.Initialize(ip1, installer, password1, port1, useSSL1, "")
' Wait For (wmSMA1.Connect) Complete (wmSMAresult1 As wmSMAresult)
' If wmSMAresult1.success Then
'    Log("Connected")
' Else
'    Log("Error: " & result.errorText)
' End If
'</code>
Public Sub Connect As ResumableSub

	Dim wmSMAresult1 As wmSMAresult
	wmSMAresult1.Initialize

	lsid = GetRandomUUID

	Dim job As HttpJob = InitJob("/dyn/login.json", CreateMap("right": user, "pass": password))
	Wait For (job) JobDone(job As HttpJob)
	If job.Success Then
		Try
			Dim jp As JSONParser
			jp.Initialize(job.GetString)
			Dim m1 As Map = jp.NextObject
			If m1.ContainsKey("err") Then
				wmSMAresult1.errorText = "wmSMA - Connect - error: " & job.GetString
			Else If m1.ContainsKey("result") = False Then
				wmSMAresult1.errorText = "wmSMA - Connect - 'result' not found in: " & job.GetString
			Else
				Dim m2 As Map = m1.Get("result")
				If m2.ContainsKey("sid") = False Then
					wmSMAresult1.errorText = "wmSMA - Connect - 'sid' not found in 'result': " & job.GetString
				Else
					ssid = m2.Get("sid").As(String)
					connectionMade = True
					wmSMAresult1.success = True
				End If
			End If
		Catch
			wmSMAresult1.errorText = "wmSMA - Connect: " & LastException
		End Try
	Else
		wmSMAresult1.errorText = "wmSMA - Connect: " & job.ErrorMessage
	End If

	If wmSMAresult1.errorText <> "" Then cookie = ""

	job.Release
	Return wmSMAresult1

End Sub

' Logs out and clears the connection. Returns a variable of tyoe wmSMAresult (member 'result' is not used).
' Example:<code>
'
' Dim wmSMA1 As wmSMA
' ...
' Wait For (wmSMA1.Disconnect) Complete (wmSMAresult1 As wmSMAresult)
' If wmSMAresult1.success Then
'    Log("Disconnected")
' Else
'    Log("Error: " & result.errorText)
' End If
'</code>
Public Sub Disconnect As ResumableSub

	Dim wmSMAresult1 As wmSMAresult
	wmSMAresult1.Initialize

	Dim job As HttpJob = InitJob("/dyn/logout.json?sid=" & ssid, emptyMap)
	Wait For (job) JobDone(job As HttpJob)
	If job.Success Then
		Try
			Dim jp As JSONParser
			jp.Initialize(job.GetString)
			Dim m1 As Map = jp.NextObject
			If m1.ContainsKey("err") Then
				wmSMAresult1.errorText = "wmSMA - Disconnect - error: " & job.GetString
			Else
				lsid = ""
				ssid = ""
				cookie = ""
				wmSMAresult1.success = True
				If m1.ContainsKey("result") Then
					Dim m2 As Map = m1.Get("result")
					If m2.ContainsKey("isLogin") Then
						wmSMAresult1.success = Not(m2.Get("isLogin").As(Boolean))
					End If
				End If
			End If
		Catch
			wmSMAresult1.errorText = "wmSMA - Disconnect: " & LastException
		End Try
	Else
		wmSMAresult1.errorText = "wmSMA - Disconnect: " & job.ErrorMessage
	End If

	job.Release
	Return wmSMAresult1

End Sub

' Returns whether or not we are connected to the Sunny Boy in a variable of tyoe wmSMAresult.
' wmSMAresult.result is a Boolean in this case.
' Example:<code>
'
' Dim wmSMA1 As wmSMA
' ...
' Wait For (wmSMA1.IsConnected) Complete (wmSMAresult1 As wmSMAresult)
' If wmSMAresult1.success Then
'    Log("IsConnected: " & wmSMAresult1.result.As(Boolean))
' Else
'    Log("Error: " & result.errorText)
' End If
'</code>
Public Sub IsConnected As ResumableSub

	Dim wmSMAresult1 As wmSMAresult
	wmSMAresult1.Initialize

	If (lsid = "") Or (ssid = "") Or (cookie = "") Or (connectionMade = False) Then Return wmSMAresult1

	Dim job As HttpJob = InitJob("/dyn/sessionCheck.json?sid=" & ssid, emptyMap)
	Wait For (job) JobDone(job As HttpJob)
	If job.Success Then
		Try
			Dim jp As JSONParser
			jp.Initialize(job.GetString)
			Dim m1 As Map = jp.NextObject
			If m1.ContainsKey("err") Then
				wmSMAresult1.errorText = "wmSMA - IsConnected - error: " & job.GetString
			Else If m1.ContainsKey("result") = False Then
				wmSMAresult1.errorText = "wmSMA - IsConnected - 'result' not found in: " & job.GetString
			Else
				Dim m2 As Map = m1.Get("result")
				wmSMAresult1.result = m2.ContainsKey("cntDwnGg")
				wmSMAresult1.success = True
			End If
		Catch
			wmSMAresult1.errorText = "wmSMA - IsConnected: " & LastException
		End Try
	Else
		wmSMAresult1.errorText = "wmSMA - IsConnected: " & job.ErrorMessage
	End If

	job.Release
	Return wmSMAresult1

End Sub

' Fetches one of the DATA... values and returns a variable of tyoe wmSMAresult.
' wmSMAresult.result is a String containing the requested value.
' Example:<code>
'
' Dim wmSMA1 As wmSMA
' ...
' Wait For (wmSMA1.GetValue(wmSMA1.DATA.power_current)) Complete (wmSMAresult1 As wmSMAresult)
' If wmSMAresult1.success Then
'    Log("Current power generation (Wh): " & wmSMAresult1.result.As(String))
' Else
'    Log("Error: " & result.errorText)
' End If
'</code>
Public Sub GetValue(DATAitem As String) As ResumableSub

	Dim wmSMAresult1 As wmSMAresult
	wmSMAresult1.Initialize

	Dim keys As List
	keys.Initialize
	keys.Add(DATAitem)

	Dim job As HttpJob = InitJob("/dyn/getValues.json?sid=" & ssid, CreateMap("keys": keys, "destDev": emptyList))
	Wait For (job) JobDone(job As HttpJob)
	If job.Success Then
		Try
			Dim jp As JSONParser
			jp.Initialize(job.GetString)
			Dim m1 As Map = jp.NextObject
			If m1.ContainsKey("err") Then
				wmSMAresult1.errorText = "wmSMA - GetValue - error: " & job.GetString
			Else If m1.ContainsKey("result") = False Then
				wmSMAresult1.errorText = "wmSMA - GetValue - 'result' not found in: " & job.GetString
			Else
				Dim m2 As Map = m1.Get("result") ' For DATA.power_current, this is e.g.: {014D-730CEDE2={6100_40263F00={1=[{val=142}]}}}
				For Each justOneKeyM2 In m2.Keys
					serial = justOneKeyM2 ' This is: 014D-730CEDE2
					Dim m3 As Map = m2.Get(justOneKeyM2) ' This is: {6100_40263F00={1=[{val=142}]}}
					Dim m4 As Map = m3.Get(DATAitem) ' This is: {1=[{val=142}]}
					Dim lst5 As List = m4.Get("1") ' This is: [{val=142}]
					Dim m6 As Map = lst5.Get(0)
					wmSMAresult1.result = m6.Get("val").As(String)
					wmSMAresult1.success = True
					Exit ' There should be only one key, but just playing it safe here
				Next
			End If
		Catch
			wmSMAresult1.errorText = "wmSMA - GetValue: " & LastException
		End Try
	Else
		wmSMAresult1.errorText = "wmSMA - GetValue: " & job.ErrorMessage
	End If

	job.Release
	Return wmSMAresult1

End Sub

' Fetches the unit of measurement for one of the DATA... values.
' Example:<code>
'
' Dim wmSMA1 As wmSMA
' ...
' Log("The measurement unit for DATA.power_current is: " & wmSMA1.GetUnit(wmSMA1.DATA.power_current, "???"))
'</code>
Public Sub GetUnit(DATAitem As String, default As String) As String

	Return DATAitems.GetDefault(DATAitem, default)

End Sub

' Fetches ALL the DATA... values and returns a variable of tyoe wmSMAresult.
' wmSMAresult.result is a Map; the keys are all the DATA... values, the values are maps containing information for each key; their contents vary depending on the key.
' Example:<code>
'
' Dim wmSMA1 As wmSMA
' ...
' Wait For (wmSMA1.GetAllValues) Complete (wmSMAresult1 As wmSMAresult)
' If wmSMAresult1.success Then
'    Log("All values: " & wmSMAresult1.result.As(Map))
' Else
'    Log("Error: " & result.errorText)
' End If
'</code>
Public Sub GetAllValues() As ResumableSub

	Dim wmSMAresult1 As wmSMAresult
	wmSMAresult1.Initialize
	Dim resultMap As Map
	resultMap.Initialize

	Dim job As HttpJob = InitJob("/dyn/getAllParamValues.json?sid=" & ssid, CreateMap("destDev": emptyList))
	Wait For (job) JobDone(job As HttpJob)
	If job.Success Then
		Try
			Dim jp As JSONParser
			jp.Initialize(job.GetString)
			Dim m1 As Map = jp.NextObject
			If m1.ContainsKey("err") Then
				wmSMAresult1.errorText = "wmSMA - GetAllValues - error: " & job.GetString
			Else If m1.ContainsKey("result") = False Then
				wmSMAresult1.errorText = "wmSMA - GetAllValues - 'result' not found in: " & job.GetString
			Else
				Dim m2 As Map = m1.Get("result")
				For Each justOneKeyM2 In m2.Keys
					serial = justOneKeyM2
					Dim m3 As Map = m2.Get(justOneKeyM2)
					For Each oneKeyInM3 As String In m3.Keys
						resultMap.Put(oneKeyInM3, m3.Get(oneKeyInM3))
					Next
					wmSMAresult1.result = resultMap
					wmSMAresult1.success = True
					Exit ' There should be only one key, but just playing it safe here
				Next
			End If
		Catch
			wmSMAresult1.errorText = "wmSMA - GetAllValues: " & LastException
		End Try
	Else
		wmSMAresult1.errorText = "wmSMA - GetAllValues: " & job.ErrorMessage
	End If

	job.Release
	Return wmSMAresult1

End Sub

' Fetches the solar production within a DateTime range and returns a variable of tyoe wmSMAresult.
' wmSMAresult.result is a List containing maps; each map contains:
' - key='t', value DateTime
' - key='v', value=the TOTAL yield since the Sunny Boy started to record solar production, in Wh
' Example:<code>
'
' Dim wmSMA1 As wmSMA
' ...
' Dim dtStart As Long = DateUtils.SetDateAndTime(2025, 7, 6, 0, 0, 0) ' Get data starting at midnight on 6 July 2025
' Dim dtEnd As Long = DateUtils.SetDateAndTime(2025, 7, 6, 10, 45, 0) ' Final data to get is the same date, 10:45AM
' Wait For (wmSMA1.GetLogger(dtStart, dtEnd)) Complete (wmSMAresult1 As wmSMAresult)
' If wmSMAresult1.success Then
'    Log("Logger: " & wmSMAresult1.result.As(List))
' Else
'    Log("Error: " & result.errorText)
' End If
'</code>
Public Sub GetLogger(dateTimeStart As Long, dateTimeEnd As Long) As ResumableSub

	Dim wmSMAresult1 As wmSMAresult
	wmSMAresult1.Initialize
	Dim resultList As List
	resultList.Initialize

	' - 'key' 28672 indicates 'select all data with a step of 5 minutes' (this is mentioned in the Python code)
	' - dateTimeStart and dateTimeEnd must be divided by 1000 to get them in seconds instead of milliseconds
	Dim job As HttpJob = InitJob("/dyn/getLogger.json?sid=" & ssid, CreateMap("destDev": emptyList, "key": 28672, "tEnd": dateTimeEnd / 1000, "tStart": dateTimeStart / 1000))
	Wait For (job) JobDone(job As HttpJob)
	If job.Success Then
		Try
			Dim jp As JSONParser
			jp.Initialize(job.GetString)
			Dim m1 As Map = jp.NextObject
			If m1.ContainsKey("err") Then
				wmSMAresult1.errorText = "wmSMA - GetLogger - error: " & job.GetString
			Else If m1.ContainsKey("result") = False Then
				wmSMAresult1.errorText = "wmSMA - GetLogger - 'result' not found in: " & job.GetString
			Else
				Dim m2 As Map = m1.Get("result")
				For Each justOneKeyM2 In m2.Keys
					serial = justOneKeyM2
					Dim lst3 As List = m2.Get(justOneKeyM2).As(List)
					For Each oneMap As Map In lst3
						resultList.Add(CreateMap("t": oneMap.Get("t").As(Long) * 1000, "v": oneMap.Get("v").As(String))) ' *1000 to get B4X DateTime values
					Next
					wmSMAresult1.result = resultList
					wmSMAresult1.success = True
					Exit ' There should be only one key, but just playing it safe here
				Next
			End If
		Catch
			wmSMAresult1.errorText = "wmSMA - GetLogger: " & LastException
		End Try
	Else
		wmSMAresult1.errorText = "wmSMA - GetLogger: " & job.ErrorMessage
	End If

	job.Release
	Return wmSMAresult1

End Sub
#End Region ' PublicSubs

#Region PrivateSubs
Private Sub CreateDataItem(tag As String, unit As String) As String

	DATAitems.Put(tag, unit) ' Note: this map isn't used at the moment; it was added as it was present in the Python code too
	Return tag

End Sub

Private Sub InitJob(url1 As String, params As Map) As HttpJob

	Dim job As HttpJob
	Dim headers As Map = GetHeaders(params)
	Dim jg As JSONGenerator

	job.Initialize("", Me)
	jg.Initialize(params)
	job.PostString(url & url1, jg.ToString)
	job.GetRequest.SetContentType("application/json")
	For Each oneHdr As String In headers.Keys
		job.GetRequest.SetHeader(oneHdr, headers.Get(oneHdr).As(String))
	Next

	Return job

End Sub

Private Sub GetRandomUUID As String

	' Code from https://www.b4x.com/android/forum/threads/b4x-uuid-generator.163203/

	Dim jo As JavaObject
	Return jo.InitializeStatic("java.util.UUID").RunMethod("randomUUID", Null)

End Sub

Private Sub GetHeaders(params As Map) As Map

	Dim m As Map = CreateMap( _
							"Host": ip, _
							"User-Agent": "Mozilla/5.0 (Windows NT 6.0; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0", _
							"Accept": "application/json, text/plain, */*", _
							"Accept-Language": acceptLanguage, _
							"Accept-Encoding": "gzip, deflate", _
							"Referer": url & "/", _
							"Content-Type": "application/json", _
							"Content-Length": params.Size, _
							"Cookie": "" _
							)

	If cookie = "" Then
		cookie = "tmhDynamicLocale.locale=%22en%22; user80=%7B%22role%22%3A%7B%22bitMask%22%3A2%2C%22title%22%3A%22usr%22%2C%22loginLevel%22%3A1%7D%2C%22username%22%3A861%2C%22sid%22%3A%22" & lsid & "%22%7D"
		m.Put("Cookie", cookie)
	End If

	Return m

End Sub
#End Region ' PrivateSubs