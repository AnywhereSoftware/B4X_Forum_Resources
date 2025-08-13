### FusedLocationProviderGMS (Latest) by Ivica Golubovic
### 10/07/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/147968/)

This is a new **FusedLocationProviderGMS** library that is based on the latest version of Google Mobile Services (GMS). Unlike the old version of the **FusedLocationProvider** library, this version uses the **FusedLocationProviderClient** class in place of the deprecated **FusedLocationProvider** class. The **FusedLocationProviderClient** class is based on asynchronous methods, while the old version uses synchronized methods that are deprecated.  
  
The principle of using the library is very similar to the older version, and the difference is that the result for each request to read the current location or the last known location is asynchronous and when the procedure is finished, the defined event will be fired. If you need a synchronized method, use the **WaitFor** command.  
  
It is also necessary to add the following line to the manifest to be able to use **GMS FusedLocation**:  

```B4X
AddApplicationText(<meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version" />)
```

  
  
**DOCUMENTATION:  
FusedLocationProviderGMS  
Author:** Ivica Golubovic  
**Version:** 1.2  

- **FusedLocationProviderClient**

- **Events:**

- **LocationAvailabilityChanged** (Available As Boolean)
- **LocationAvailabilityRequestCompleted** (Available As Boolean)
- **LocationChanged** (mLocation As LocationF)
- **LocationEnabledInSettingsChanged** (Enabled As Boolean)
- **LocationRequestCompleted** (Result As LocationResult)

- **Functions:**

- **FlushLocations**
*Flushes any locations currently being batched.*- **GetCurrentLocation** (Priority As Int) As Int
*Returns a single location fix representing the best estimate of the current location of the device. This may return a cached location if a recent enough location fix exists, or may compute a fresh location. If unable to retrieve a current location fix, null will be returned.  
 Priority - Priority used to obtain location.  
 This method is asynchronous. When the process is complete, an event "LocationRequestCompleted" will be triggered.*- **GetCurrentLocation2** (DurationMillis As Long, Granularity As Int, Priority As Int, MaxUpdateAgeMillis As Long) As Int
*Returns a single location fix representing the best estimate of the current location of the device. This may return a historical location if a recent enough location fix exists, or may compute a fresh location. If unable to retrieve a current location fix, null will be returned.  
 DurationMillis - Sets the duration in milliseconds of the location request used to derive the current location if no historical location satisfies the current location request. If this duration expires with no location, the current location request will return a null location. The current location request may fail and return a null location after a shorter duration, but never a longer duration. The default value is LocationRequest\_Constants.MAX\_VALUE.  
 Granularity - Sets the Granularity of locations returned for this request. This controls whether fine or coarse locations may be returned.  
 Priority - Sets the Priority of the location request used to derive the current location if no historical location satisfies the current location request.  
 MaxUpdateAgeMillis - Sets the maximum age of any location returned for this request. A value of 0 indicates that only freshly derived locations will be returned, and no historical locations will ever be returned. A value LocationRequest\_Constants.MAX\_VALUE represents an effectively unbounded maximum age.  
 This method is asynchronous. When the process is complete, an event "LocationRequestCompleted" will be triggered.*- **GetLastLocation** As Int
*Returns the most recent historical location currently available. Will return null if no historical location is available. The historical location may be of an arbitrary age, so clients should check how old the location is to see if it suits their purposes.  
 This method is asynchronous. When the process is complete, an event "LocationRequestCompleted" will be triggered.*- **GetLastLocation2** (Granularity As Int, MaxUpdateAgeMillis As Long) As Int
*Returns the most recent historical location currently available according to the given request. Will return null if no matching historical location is available.  
 Granularity - The Granularity of locations returned for this request. This controls whether fine or coarse locations may be returned.  
 MaxUpdateAgeMillis - The maximum age of any location returned for this request. A value of LocationRequest\_Constants.MAX\_VALUE represents an effectively unbounded maximum age.  
 This method is asynchronous. When the process is complete, an event "LocationRequestCompleted" will be triggered.*- **GetLocationAvailability**
*Returns true if the device location is generally available.  
 This method is asynchronous. When the process is complete, an event "LocationAvailabilityRequestCompleted" will be triggered.*- **Initialize** (EventName As String) As FusedLocationProviderClient
- **IsInitialized** As Boolean
- **RemoveLocationUpdates**
*Removes all location updates and stops listener for the future locations updates.*- **RequestLocationUpdates** (Request As LocationRequest)
*Requests location updates with the given request.  
 Use RemoveLocationUpdates to stop location updates once no longer needed.*- **SetMockLocation** (mLocation As LocationF) As FusedLocationProviderClient
*Sets the mock location of the Fused Location Provider.*- **SetMockMode** (MockMode As Boolean) As FusedLocationProviderClient
*Sets whether or not the Fused Location Provider is in mock mode.*
- **Properties:**

- **IsLocationEnabledInSettings** As Boolean [read only]
*Check if Location is enabled in device's settings.*- **LocationSettingsIntent** As Intent [read only]
*Returns the intent that is used to show the global locations settings.*
- **Granularity**

- **Fields:**

- **GRANULARITY\_COARSE** As Int
*The desired location granularity is always coarse, regardless of the client permission level. The client will be delivered coarse locations while it has the Manifest.permission.ACCESS\_FINE\_LOCATION or Manifest.permission.ACCESS\_COARSE\_LOCATION permission, and no location if it lacks either.  
 Constant Value: 1*- **GRANULARITY\_FINE** As Int
*The desired location granularity is always fine, regardless of the client permission level. The client will be delivered fine locations while it has the Manifest.permission.ACCESS\_FINE\_LOCATION, and no location if it lacks that permission.  
 Constant Value: 2*- **GRANULARITY\_PERMISSION\_LEVEL** As Int
*The desired location granularity should correspond to the client permission level. The client will be delivered fine locations while it has the Manifest.permission.ACCESS\_FINE\_LOCATION permission, coarse locations while it has only the Manifest.permission.ACCESS\_COARSE\_LOCATION permission, and no location if it lacks either.  
 Constant Value: 0*
- **LocationF**

- **Functions:**

- **BearingTo** (Dest As LocationF) As Float
*Returns the approximate initial bearing in degrees east of true north when traveling along the shortest path between this location and the given location. The shortest path is defined using the WGS84 ellipsoid. Locations that are (nearly) antipodal may produce meaningless results.*- **DistanceTo** (Dest As LocationF) As Float
*Returns the approximate distance in meters between this location and the given location. Distance is defined using the WGS84 ellipsoid.*- **HasAccuracy** As Boolean
*Returns true if this location has a horizontal accuracy, false otherwise.*- **HasAltitude** As Boolean
*Returns true if this location has an altitude, false otherwise.*- **HasBearing** As Boolean
*True if this location has a bearing, false otherwise.*- **HasBearingAccuracy** As Boolean
*Returns true if this location has a bearing accuracy, false otherwise.*- **HasSpeed** As Boolean
*True if this location has a speed, false otherwise.*- **HasSpeedAccuracy** As Boolean
*Returns true if this location has a speed accuracy, false otherwise.*- **HasVerticalAccuracy** As Boolean
*Returns true if this location has a vertical accuracy, false otherwise.*- **Initialize** As LocationF
- **Initialize2** (mLocationF As LocationF) As LocationF
- **IsInitialized** As Boolean
- **Reset**
*Sets the provider to null, removes all optional fields, and sets the values of all other fields to zero.*- **ToString** As String

- **Properties:**

- **Accuracy** As Float
*Gets or sets the horizontal accuracy in meters of this location.*- **Altitude** As Double
*Gets or sets the altitude of this location in meters above the WGS84 reference ellipsoid.*- **Bearing** As Float
*Gets or sets the bearing at the time of this location, in degrees. The given bearing will be converted into the range (0, 360).*- **BearingAccuracyDegrees** As Float
*Gets or sets the bearing accuracy in degrees of this location. Bearing accuracy in degrees Value is 0.0 or greater.*- **Latitude** As Double
*Gets or set the latitude of this location.*- **Longitude** As Double
*Gets or sets the longitude of this location.*- **Provider** As String
*Gets or sets the name of the provider associated with this location*- **Speed** As Float
*Gets or sets the speed at the time of this location, in meters per second.*- **SpeedAccuracyMetersPerSecond** As Float
*Set the speed accuracy of this location in meters per second.*- **Time** As Long
*Gets or sets the Unix epoch time of this location fix, in milliseconds since the start of the Unix epoch (00:00:00 January 1 1970 UTC).*- **VerticalAccuracyMeters** As Float
*Gets or sets the altitude accuracy of this location in meters.*
- **LocationF**

- **Fields:**

- **FORMAT\_DEGREES** As Int
*Constant used to specify formatting of a latitude or longitude in the form "[+-]DDD.DDDDD" where D indicates degrees.  
 Constant Value: 0*- **FORMAT\_MINUTES** As Int
*Constant used to specify formatting of a latitude or longitude in the form "[+-]DDD:MM.MMMMM" where D indicates degrees and M indicates minutes of arc (1 minute = 1/60th of a degree).  
 Constant Value: 1*- **FORMAT\_SECONDS** As Int
*Constant used to specify formatting of a latitude or longitude in the form "DDD:MM:SS.SSSSS" where D indicates degrees, M indicates minutes of arc, and S indicates seconds of arc (1 minute = 1/60th of a degree, 1 second = 1/3600th of a degree).  
 Constant Value: 2*
- **Functions:**

- **ConvertToDouble** (Coordinate As String) As Double
*Converts a String in one of the formats described by FORMAT\_DEGREES, FORMAT\_MINUTES, or FORMAT\_SECONDS into a double.*- **ConvertToString** (Coordinate As Double, OutputType As Int) As String
*Converts a latitude/longitude coordinate to a String representation. The outputType must be one of FORMAT\_DEGREES, FORMAT\_MINUTES, or FORMAT\_SECONDS. The coordinate must be a number between -180.0 and 180.0, inclusive. This conversion is performed in a method that is dependent on the default locale.*- **DistanceBetween** (startLatitude As Double, startLongitude As Double, endLatitude As Double, endLongitude As Double) As Float()
*Computes the approximate distance in meters between two locations, and optionally the initial and final bearings of the shortest path between them. Distance and bearing are defined using the WGS84 ellipsoid and stored in result().  
 The computed distance is stored in results(0). If results has length 2 or greater, the initial bearing is stored in results(1). If results has length 3 or greater, the final bearing is stored in results(2).*
- **LocationRequest**

- **Functions:**

- **Equals** (mObject As Object) As Boolean
- **GetDurationMillis** As Long
*The duration of this request. A location request will not receive any locations after it has expired, and will be removed shortly thereafter. A value of LocationRequest\_Constants.MAX\_VALUE\_FLOAT implies an infinite duration.*- **GetGranularity** As Int
*The Granularity of locations returned for this request. This controls whether fine or coarse locations may be returned.*- **GetIntervalMillis** As Long
*The desired interval of location updates. Location updates may arrive faster than this interval (but no faster than specified by getMinUpdateIntervalMillis()) or slower than this interval (if the request is being throttled for example).*- **GetMaxUpdateAgeMillis** As Long
*The maximum age of an initial historical location delivered for this request. A value of 0 indicates that no initial historical location will be delivered, only freshly derived locations. A value LocationRequest\_Constants.MAX\_VALUE\_FLOAT represents an effectively unbounded maximum age.*- **GetMaxUpdateDelayMillis** As Long
*The longest a location update may be delayed. This parameter controls location batching behavior. If this is set to a value at least 2x larger than the interval specified by getIntervalMillis(), then a device may (but is not required to) save power by delivering locations in batches. If clients do not require immediate delivery, consider setting this value as high as is reasonable to allow for additional power savings.  
 For example, if a request is made with a 2s interval and a 10s maximum update delay, this implies that the device may choose to deliver batches of 5 locations every 10s (where each location should represent a point in time ~2s after the previous).  
 Support for batching may vary by device type, so simply allowing batching via this parameter does not imply a client will receive batched results on all devices.  
 FusedLocationProviderClient.flushLocations() may be used to flush locations that have been batched, but not delivered yet.*- **GetMaxUpdates** As Int
*The maximum number of updates delivered to this request. A location request will not receive any locations after the maximum number of updates has been reached, and will be removed shortly thereafter. A value of LocationRequest\_Constants.MAX\_VALUE\_INT implies an unlimited number of updates.*- **GetMinUpdateDistanceMeters** As Float
*The minimum distance required between consecutive location updates. If a derived location update is not at least the specified distance away from the previous location update delivered to the client, it will not be delivered. This may also allow additional power savings under some circumstances.*- **GetMinUpdateIntervalMillis** As Long
*The fastest allowed interval of location updates. Location updates may arrive faster than the desired interval (getIntervalMillis()), but will never arrive faster than specified here. FLP APIs make some allowance for jitter with the minimum update interval, so clients need not worry about location updates that arrive a couple milliseconds too early being rejected.*- **GetPriority** As Int
*The Priority of the location request.*- **GetWaitForAccurateLocation** As Boolean
*If this request is Priority.PRIORITY\_HIGH\_ACCURACY, this will delay delivery of initial low accuracy locations for a small amount of time in case a high accuracy location can be delivered instead.*- **Initialize** (IntervalMillis As Long) As LocationRequest
*Constructs a LocationRequest with the given interval, and default values for all other fields.*- **Initialize2** (Priority As Int, IntervalMillis As Long) As LocationRequest
*Constructs a LocationRequest with the given priority and interval, and default values for all other fields.*- **Initialize3** (Request As LocationRequest) As LocationRequest
*Constructs a LocationRequest with values copied from the given LocationRequest.*- **IsBatched** As Boolean
*True if this request allows batching (i.e. getMaxUpdateDelayMillis() is at least 2x getIntervalMillis()).*- **IsInitialized** As Boolean
- **IsPassive** As Boolean
*True if the priority is Priority.PRIORITY\_PASSIVE.*- **SetDurationMillis** (DurationMillis As Long) As LocationRequest
*Sets the duration of this request. A location request will not receive any locations after it has expired, and will be removed shortly thereafter. A value of LocationRequest\_Constants.MAX\_VALUE implies an infinite duration.  
 The default value is LocationRequest\_Constants.MAX\_VALUE (unlimited).*- **SetGranularity** (Granularity As Int) As LocationRequest
*Sets the Granularity of locations returned for this request. This controls whether fine or coarse locations may be returned.  
 The default value is Granularity.GRANULARITY\_PERMISSION\_LEVEL.*- **SetIntervalMillis** (IntervalMillis As Long) As LocationRequest
*Sets the desired interval of location updates. Location updates may arrive faster than this interval (but no faster than specified by SetMinUpdateIntervalMillis(Long)) or slower than this interval (if the request is being throttled for example).*- **SetMaxUpdateAgeMillis** (MaxUpdateAgeMillis As Long) As LocationRequest
*Sets the maximum age of an initial historical location delivered for this request. A value of 0 indicates that no initial historical location will be delivered, only freshly derived locations. A value LocationRequest\_Constants.MAX\_VALUE represents an effectively unbounded maximum age.  
 This may be set to the special value LocationRequest\_Constants.IMPLICIT\_MAX\_UPDATE\_AGE in which case the maximum update age will always be the same as the interval.  
 The default value is LocationRequest\_Constants.IMPLICIT\_MAX\_UPDATE\_AGE.*- **SetMaxUpdateDelayMillis** (MaxUpdateDelayMillis As Long) As LocationRequest
*Sets the longest a location update may be delayed. This parameter controls location batching behavior. If this is set to a value at least 2x larger than the interval specified by setIntervalMillis(long), then a device may (but is not required to) save power by delivering locations in batches. If clients do not require immediate delivery, consider setting this value as high as is reasonable to allow for additional power savings. When the LocationRequest is built, the maximum update delay will be set to the max of the provided maximum update delay and the interval. This normalizes requests without batching to have the maximum update delay equal to the interval.  
 For example, if a request is made with a 2s interval and a 10s maximum update delay, this implies that the device may choose to deliver batches of 5 locations every 10s (where each location in a batch represents a point in time ~2s after the previous).  
 Support for batching may vary by device hardware, so simply allowing batching via this parameter does not imply a client will receive batched results on all devices.  
 FusedLocationProviderClient.FlushLocations() may be used to flush locations that have been batched, but not delivered yet.  
 The default value is 0.*- **SetMaxUpdates** (MaxUpdates As Int) As LocationRequest
*Sets the maximum number of updates delivered to this request. A location request will not receive any locations after the maximum number of updates has been reached, and will be removed shortly thereafter. A value of Integer.MAX\_VALUE implies an unlimited number of updates.  
 The default value is Integer.MAX\_VALUE.*- **SetMinUpdateDistanceMeters** (MinUpdateDistanceMeters As Float) As LocationRequest
*Sets the minimum distance required between consecutive location updates. If a derived location update is not at least the specified distance away from the previous location update delivered to the client, it will not be delivered. This may also allow additional power savings under some circumstances.  
 The default value is 0.*- **SetMinUpdateIntervalMillis** (MinUpdateIntervalMillis As Long) As LocationRequest
*Sets the fastest allowed interval of location updates. Location updates may arrive faster than the desired interval (setIntervalMillis(long)), but will never arrive faster than specified here.  
 This may be set to the special value LocationRequest\_Constants.IMPLICIT\_MIN\_UPDATE\_INTERVAL in which case the minimum update interval will be the same as the interval. FusedLocationProviderClient APIs make some allowance for jitter with the minimum update interval, so clients need not worry about location updates that arrive a couple milliseconds too early being rejected.  
 The default value is LocationRequest\_Constants.IMPLICIT\_MIN\_UPDATE\_INTERVAL.*- **SetPriority** (Priority As Int) As LocationRequest
*Sets the Priority of the location request.  
 The default value is Priority.PRIORITY\_BALANCED\_POWER\_ACCURACY.*- **SetWaitForAccurateLocation** (WaitForAccurateLocation As Boolean) As LocationRequest
*If set to true and this request is Priority.PRIORITY\_HIGH\_ACCURACY, this will delay delivery of initial low accuracy locations for a small amount of time in case a high accuracy location can be delivered instead.  
 The default value is true.*- **ToString** As String

- **LocationRequest**

- **Fields:**

- **IMPLICIT\_MAX\_UPDATE\_AGE** As Long
*Represents a maximum update age that is the same as the interval.  
 Constant Value: -1*- **IMPLICIT\_MIN\_UPDATE\_INTERVAL** As Long
*Represents a minimum update interval that is the same as the interval.  
 Constant Value: -1*- **MAX\_VALUE\_FLOAT** As Long
*A constant holding the maximum value a long can have.*- **MAX\_VALUE\_INT** As Int
*A constant holding the maximum value an int can have.*
- **LocationResult**

- **Properties:**

- **ErrorMessage** As String [read only]
- **Location** As LocationF [read only]
- **ResponseID** As Int [read only]
- **Status** As Int [read only]
- **StatusString** As String [read only]

- **LocationResult**

- **Fields:**

- **STATUS\_CANCELED** As Int
- **STATUS\_FAILED** As Int
- **STATUS\_SUCCESSFUL** As Int

- **Priority**

- **Fields:**

- **PRIORITY\_BALANCED\_POWER\_ACCURACY** As Int
*Requests a tradeoff that is balanced between location accuracy and power usage.  
 Constant Value: 102*- **PRIORITY\_HIGH\_ACCURACY** As Int
*Requests a tradeoff that favors highly accurate locations at the possible expense of additional power usage.  
 Constant Value: 100*- **PRIORITY\_LOW\_POWER** As Int
*Requests a tradeoff that favors low power usage at the possible expense of location accuracy.  
 Constant Value: 104*- **PRIORITY\_PASSIVE** As Int
*Ensures that no extra power will be used to derive locations. This enforces that the request will act as a passive listener that will only receive "free" locations calculated on behalf of other clients, and no locations will be calculated on behalf of only this request.  
 Constant Value: 105*
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private Fused As FusedLocationProviderClient  
    Private rp As RuntimePermissions  
End Sub  
  
Public Sub Initialize  
    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    
    'Requesting Location's runtime permissions  
    rp.CheckAndRequest(rp.PERMISSION_ACCESS_COARSE_LOCATION)  
    Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)  
    If Result=False Then  
        ExitApplication  
    End If  
    rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)  
    Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)  
    If Result=False Then  
        ExitApplication  
    End If  
    
    'Initialize FusedLocationProviderClient  
    Fused.Initialize("FusedLocation")  
End Sub  
  
Private Sub btnStartFused_Click  
    DefineFused  
End Sub  
  
Private Sub DefineFused  
    If Fused.IsLocationEnabledInSettings Then  
        Fused.GetLocationAvailability  
        Wait For FusedLocation_LocationAvailabilityRequestCompleted (Available As Boolean)  
        Log("LocationAvailable=" & Available)  
        If Available Then  
            Fused.GetLastLocation  
            Wait For FusedLocation_LocationRequestCompleted (Result As LocationResult)  
            If Result.Status=LocationResult.STATUS_SUCCESSFUL Then  
                If Result.Location.IsInitialized Then  
                    Dim LastLocation As LocationF = Result.Location  
                    Log("LastLocation Latitude = " & LastLocation.Latitude)  
                    Log("LastLocation Longitude = " & LastLocation.Longitude)  
                    'Do whatever you want with other LocatioF properties and methods  
                Else  
                    Log("Unknown last location")  
                End If  
            End If  
        End If  
    
        'Initiate FusedLocation's LocationRequest which will allow events to be fired and it will continue to work in background  
        Dim LocationRequest1 As LocationRequest  
        LocationRequest1.Initialize(1000) 'Refresh interval is 1000 miliseconds  
        LocationRequest1.SetMinUpdateIntervalMillis(100) 'Minimum refresh interval is 100 miliseconds  
        LocationRequest1.SetPriority(Priority.PRIORITY_HIGH_ACCURACY) 'Request high accuracy location  
        LocationRequest1.SetMinUpdateDistanceMeters(0) 'Minimum distance in meters to fire location change event (0 is default)  
        LocationRequest1.SetGranularity(Granularity.GRANULARITY_FINE)  
        Fused.RequestLocationUpdates(LocationRequest1) 'Set location request to FusedLocationProviderClient and start FusedLocation  
    Else  
        MsgboxAsync("Location is turned off in devices's settings. Turn it on.","Warning")  
        StartActivity(Fused.LocationSettingsIntent)  
    End If  
End Sub  
  
Private Sub btnFusedStop_Click  
    Fused.RemoveLocationUpdates ' This will stop FusedLocation to work and events will not be fired anymore. It will stop FusedLocation to work in background. You can start it again anytime you want  
End Sub  
  
Private Sub btnGetCurrentLocation_Click  
    Fused.GetCurrentLocation(Priority.PRIORITY_HIGH_ACCURACY)  
    Wait For FusedLocation_LocationRequestCompleted (Result As LocationResult)  
    If Result.Status=LocationResult.STATUS_SUCCESSFUL Then  
        If Result.Location.IsInitialized Then  
            MsgboxAsync("Your current location is:" & CRLF & "Latitude=" & Result.Location.Latitude & CRLF & "Longitude=" & Result.Location.Longitude,"Current Location")  
        End If  
    End If  
End Sub  
  
Private Sub Msgbox_Result (Result As Int)  
    Log("Msgbox_Result")  
End Sub  
  
Private Sub btnGetLastKnownLocation_Click  
    Fused.GetLastLocation  
    Wait For FusedLocation_LocationRequestCompleted (Result As LocationResult)  
    If Result.Status=LocationResult.STATUS_SUCCESSFUL Then  
        If Result.Location.IsInitialized Then  
            MsgboxAsync("Your last known location is:" & CRLF & "Latitude=" & Result.Location.Latitude & CRLF & "Longitude=" & Result.Location.Longitude,"Current Location")  
        End If  
    End If  
End Sub  
  
Private Sub FusedLocation_LocationAvailabilityChanged (Available As Boolean)  
    'This event will be fired when location availability is changed  
    'For example on signal lost or when location is turned off.  
    Log("LocationAvailabile = " & Available)  
End Sub  
  
Private Sub FusedLocation_LocationChanged (mLocation As LocationF)  
    'This event will be fired anytime your actual location is changed and if it meets the criteria of the defined LocationRequest  
    Log("Lat=" & mLocation.Latitude & CRLF & "Lng=" & mLocation.Longitude)  
End Sub  
  
Private Sub FusedLocation_LocationEnabledInSettingsChanged (Enabled As Boolean)  
    'This event will be fired if user turn off or turn on Location in device's settings  
    Log("LocationEnabled = " & Enabled)  
    If Enabled=False Then  
        StartActivity(Fused.LocationSettingsIntent)  
    End If  
End Sub
```

  
  
If this libraries makes your work easier and saves time in creating your application, please make a donation.  
<https://www.paypal.com/donate?hosted_button_id=HX7GS8H4XS54Q>