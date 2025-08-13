B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13
@EndOfDesignText@
Sub Class_Globals
	Private const MainUrl As String = "https://geomag.bgs.ac.uk/web_service/GMModels"
	Private mModel As String = "wmm"
	Private mRevision As String = "current"
	Private mSubRevision As String = ""
	Private mCustomUrl As String = ""
	
	Type MagFieldData (declination As Map, inclination As Map, total_intensity As Map, vertical_intensity As Map, horizontal_intensity As Map, north_intensity As Map, east_intensity As Map)
	Dim Data As MagFieldData
End Sub

Public Sub Initialize(CustomUrl As String, Model As String, Revision As String, SubRevision As String)
	If CustomUrl <> "" Then mCustomUrl = CustomUrl
	If Model <> "" Then	mModel = Model
	If Revision <> "" Then mRevision = Revision
	If SubRevision <> "" Then mSubRevision = SubRevision
	Data.Initialize
End Sub

Private Sub CreateQueryString(parameters As Map) As String
	Dim queryString As String = ""
	For Each key As String In parameters.Keys
		If parameters.Get(key) <> Null Then
			queryString = queryString & key & "=" & parameters.Get(key) & "&"
		End If
	Next
	Return queryString.SubString2(0, queryString.Length - 1) ' Remove last "&"
End Sub

Private Sub Base64Encode(dta As String) As String
	Dim su As StringUtils
	Return su.EncodeBase64(dta.GetBytes("UTF8"))
End Sub

Public Sub Calculate (latitude As Double, longitude As Double, altitude As Double, depth As Double, radius As Double, year As String, date As String, username As String, password As String) As ResumableSub
	Dim parameters As Map
	parameters.Initialize
	parameters.Put("latitude", latitude)
	parameters.Put("longitude", longitude)
	If altitude <> 0 Then parameters.Put("altitude", altitude)
	If depth <> 0 Then parameters.Put("depth", depth)
	If radius <> 0 Then parameters.Put("radius", radius)
	If year <> "" Then parameters.Put("year", year)
	If date <> "" Then parameters.Put("date", date)
	parameters.Put("format", "json")
	
	Dim queryString As String = CreateQueryString(parameters)
	Dim baseUrl As String = IIf(mCustomUrl <> "", mCustomUrl, MainUrl)
	Dim url As String = baseUrl & "/" & mModel & "/" & mRevision & (IIf(mSubRevision <> "", "v" & mSubRevision, "")) & "?" & queryString

	Try
		Dim req As HttpJob
		req.Initialize("", Me)
		If username <> "" And password <> "" Then
			Dim auth As String = Base64Encode(username & ":" & password)
			req.GetRequest.SetHeader("Authorization", "Basic " & auth)
		End If
		
		req.Download(url)
		Wait For (req) JobDone(req As HttpJob)
		
		If req.Success Then
			Dim parser As JSONParser
			parser.Initialize(req.GetString)
			Dim response As Map = parser.NextObject
			Log ("Response = " & response)
			Dim all_data As Map = response.Get("geomagnetic-field-model-result")
			Dim fvalues As Map = all_data.Get ("field-value")

			Data.declination = fvalues.Get ("declination")
			Data.inclination = fvalues.Get ("inclination")
			Data.total_intensity = fvalues.Get ("total-intensity")
			Data.vertical_intensity = fvalues.Get ("vertical-intensity")
			Data.horizontal_intensity = fvalues.Get ("horizontal-intensity")
			Data.north_intensity = fvalues.Get ("north-intensity")
			Data.east_intensity = fvalues.Get ("east-intensity")
			
			Return True
		Else
			Log("Error: " & req.ErrorMessage)
		End If
	Catch
		Log(LastException)
		Return False
	End Try
	
	Return False
End Sub

