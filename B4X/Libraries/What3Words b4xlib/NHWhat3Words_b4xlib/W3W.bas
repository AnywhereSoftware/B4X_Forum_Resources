B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12
@EndOfDesignText@
#Event: W3WResponse(w3wsq As W3WSquareType)

Sub Class_Globals
	Type W3WSquareType(Success As Boolean, mNorthEast As Map, mSouthWest As Map, mCoordinates As Map, Country As String, Words As String, Language As String, SquareURLInMap As String, NearestPlace As String, ErrorString As String)
	Private tW3WSquare As W3WSquareType
	Private evname As String
	Private sAPIKey As String
	Private classParent As Object
	Private fl As FusedLocation
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Parent As Object, EventName As String, APIKEY As String)
	classParent = Parent
	evname = EventName
	sAPIKey = APIKEY
	fl.Initialize("fl", Me)
End Sub

'<code>
'1) Install android-support-v4 with SDK Manager
'
'2) Add these in the beggining of the project (Main)
'#AdditionalJar:android-support-v4
'#AdditionalJar:com.google.android.gms:play-services-location
'#MultiDex:True
'
'3) Add this in manifest
'AddApplicationText(
'<activity android:name="com.google.android.gms.common.api.GoogleApiActivity"
'android:theme="@android:style/Theme.Translucent.NoTitleBar"
'android:exported="false"/>
'<meta-data
'android:name="com.google.android.gms.version"
'android:value="@integer/google_play_services_version" />
')
'AddPermission(android.permission.ACCESS_COARSE_LOCATION)
'AddPermission(android.permission.ACCESS_FINE_LOCATION)
'
' ************ THE CODE **************
' w3w.Initialize(Me, "ev", "sadjaksdaskdaskd")
' w3w.GetCoordinatesFromWhat3Words("jolly.shops.migrate")
' w3w.GetWhat3WordsFromCoordinates(37.946903, 23.664211)
' w3w.GetWhat3WordsFromMyCurrentPosition
'
' >>> Implement the event (..)_W3WResponse(w3wsq As W3WSquareType)
'</code>
Public Sub Instructions
	
End Sub


Public Sub GetWhat3WordsFromMyCurrentPosition
	fl.StartFLP
End Sub

Private Sub fl_LocationChanged(Location1 As Location)
	GetWhat3WordsFromCoordinates(Location1.Latitude, Location1.Longitude)
	fl.StopFLP
End Sub

Public Sub GetWhat3WordsFromCoordinates(lat As Double, lng As Double)
	Dim hj As HttpJob
	hj.Initialize("", Me)
	hj.Download($"https://api.what3words.com/v3/convert-To-3wa?coordinates=${lat}%2C${lng}&language=${FindLocale}"$)
	hj.GetRequest.SetHeader("X-Api-Key", sAPIKey)
	
	Wait for (hj) JobDone(hj As HttpJob)
	
	If hj.Success Then
		ProcessJSON(hj.GetString)
	Else
		ReturnEmptySquare(hj.ErrorMessage)
	End If
	
	hj.Release
End Sub

Public Sub GetCoordinatesFromWhat3Words(what3words As String)
	Dim hj As HttpJob
	hj.Initialize("", Me)
	hj.Download($"https://api.what3words.com/v3/convert-to-coordinates?words=${what3words}&language=${FindLocale}"$)
	hj.GetRequest.SetHeader("X-Api-Key", sAPIKey)
	
	Wait for (hj) JobDone(hj As HttpJob)
	
	If hj.Success Then
		ProcessJSON(hj.GetString)
	Else
		ReturnEmptySquare(hj.ErrorMessage)
	End If
	
	hj.Release
End Sub


Public Sub FindLocale As String
	#if B4A or B4J
	Dim jo As JavaObject
	jo = jo.InitializeStatic("java.util.Locale").RunMethod("getDefault", Null)
	Return jo.RunMethod("getLanguage", Null)
	#else if B4i
    Dim no As NativeObject
    Dim lang As String = no.Initialize("NSLocale") _
        .RunMethod("preferredLanguages", Null).RunMethod("objectAtIndex:", Array(0)).AsString
	If lang.Length > 2 Then lang = lang.SubString2(0, 2)
	Return lang
	#end if
End Sub

Private Sub ProcessJSON(sJSON As String)
	Try
		Dim parser As JSONParser
		parser.Initialize(sJSON)
		Dim jRoot As Map = parser.NextObject
		Dim country As String = jRoot.Get("country")
		Dim square As Map = jRoot.Get("square")
		Dim southwest As Map = square.Get("southwest")
		Dim swlng As Double = southwest.Get("lng")
		Dim swlat As Double = southwest.Get("lat")
		Dim northeast As Map = square.Get("northeast")
		Dim nelng As Double = northeast.Get("lng")
		Dim nelat As Double = northeast.Get("lat")
		Dim nearestPlace As String = jRoot.Get("nearestPlace")
		Dim coordinates As Map = jRoot.Get("coordinates")
		Dim crdslng As Double = coordinates.Get("lng")
		Dim crdslat As Double = coordinates.Get("lat")
		Dim words As String = jRoot.Get("words")
		Dim language As String = jRoot.Get("language")
		Dim map As String = jRoot.Get("map")
	
		tW3WSquare.Country = country
		tW3WSquare.Language = language
		tW3WSquare.SquareURLInMap = map
		tW3WSquare.mNorthEast = northeast
		tW3WSquare.mSouthWest = southwest
		tW3WSquare.mCoordinates = coordinates
		tW3WSquare.Words = words
		tW3WSquare.SquareURLInMap = map
		tW3WSquare.NearestPlace = nearestPlace
		tW3WSquare.Success = True
		

		CallSub2(classParent, evname & "_W3WResponse", tW3WSquare)
	Catch
		Log(LastException)
		ReturnEmptySquare(LastException.Message)
	End Try
	
End Sub

Public Sub getW3WSquare As W3WSquareType
	Return tW3WSquare
End Sub

Private Sub ReturnEmptySquare(Error As String)
	Dim ltW3W As W3WSquareType
	ltW3W.ErrorString = Error
	tW3WSquare.Success = False
	CallSub2(classParent, evname & "_W3WResponse", ltW3W)
End Sub