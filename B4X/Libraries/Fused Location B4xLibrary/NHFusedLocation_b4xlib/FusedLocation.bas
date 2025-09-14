B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#Event: LocationChanged(Location1 as Location)

Sub Class_Globals
	#if b4a
	Public FLP As FusedLocationProvider
	#else if b4i
	Public FLP As LocationManager
	#End If
	
	
	Private flpStarted As Boolean
	Private ParentObject As Object
	Private evnam As String
	Private intLocationReqRate As Int
End Sub

#if b4a

'Initializes the object. Set a LocationChanged(Location1 as Location) in the 
'calling object to be called with the location
Public Sub Initialize(EventName As String, Parent As Object)
	evnam = EventName
	FLP.Initialize("flp")
	FLP.Connect
	ParentObject = Parent
	intLocationReqRate = 10000
End Sub


Private Sub flp_ConnectionSuccess
	Log("Connected to location provider")
End Sub

Private Sub flp_ConnectionFailed(ConnectionResult1 As Int)
	Log("Failed to connect to location provider")
End Sub

'Start locating
Public Sub StartFLP
	Do While FLP.IsConnected = False
		Sleep(1000)
	Loop
	If flpStarted = False Then
		FLP.RequestLocationUpdates(CreateLocationRequest)
		flpStarted = True
	End If
End Sub


Private Sub CreateLocationRequest As LocationRequest
	Dim lr As LocationRequest
	lr.Initialize
	lr.SetInterval(intLocationReqRate)
	lr.SetFastestInterval(lr.GetInterval / 2)
	lr.SetPriority(lr.Priority.PRIORITY_HIGH_ACCURACY)
	Return lr
End Sub

'Stop locating
Public Sub StopFLP
	If flpStarted Then
		FLP.RemoveLocationUpdates
		flpStarted = False
	End If
End Sub



#else if b4i

'Initializes the object. Set a LocationChanged(Location1 as Location) in the 
'calling object to be called with the location
Public Sub Initialize(EventName As String, Parent As Object)
	evnam = EventName
	ParentObject = Parent
	Dim FLP As LocationManager
	FLP.Initialize("flp")
	intLocationReqRate = 50
End Sub

Private Sub flp_AuthorizationStatusChanged (Status As Int)
	Select Case Status
		Case FLP.AUTHORIZATION_DENIED, FLP.AUTHORIZATION_RESTRICTED
			Log("Failed to connect to location provider")
		Case FLP.AUTHORIZATION_NOT_DETERMINED
			Log("Status of connection to location provider not yet set")
		Case Else
			Log("Connected to location provider")
	End Select
End Sub

'Start locating
Public Sub StartFLP
	If FLP.LocationServicesEnabled Then
		FLP.Start(intLocationReqRate)
		flpStarted = True
	End If
End Sub

'Stop locating
Public Sub StopFLP
	If flpStarted = True Then
		FLP.Stop
		flpStarted = False
	End If
End Sub


#End If

Public Sub setLocationRequestInterval(LRInterval_B4AMillis_B4iMeters As Int)
	intLocationReqRate = LRInterval_B4AMillis_B4iMeters
	RestartFLP
End Sub

Public Sub RestartFLP
	StopFLP
	StartFLP
End Sub

Public Sub setParent(Parent As Object)
	ParentObject = Parent
End Sub

Private Sub flp_LocationChanged (Location1 As Location)
	CallSub2(ParentObject, evnam & "_LocationChanged", Location1)
End Sub
